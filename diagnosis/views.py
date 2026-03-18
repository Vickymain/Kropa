"""
KROPA – Chat Views
==================
Single endpoint: user types a free-text description,
backend extracts symptom atoms, delegates ALL reasoning to Prolog,
returns a diagnosis as JSON (rendered by the chat UI).

No diagnosis logic lives here — Prolog handles all of that.
"""

import json
import re
import logging

from django.shortcuts import render
from django.http import JsonResponse
from django.views.decorators.http import require_POST

from . import prolog_engine
from .models import QueryHistory

logger = logging.getLogger(__name__)


# ---------------------------------------------------------------------------
# Crop aliases
# Maps common user terms → crop IDs in the Prolog knowledge base
# ---------------------------------------------------------------------------
CROP_ALIASES = {
    'maize': 'maize', 'corn': 'maize',
    'tomato': 'tomato', 'tomatoes': 'tomato',
    'rice': 'rice', 'paddy': 'rice',
    'wheat': 'wheat',
    'potato': 'potato', 'potatoes': 'potato', 'spud': 'potato',
    'cassava': 'cassava', 'manioc': 'cassava', 'yuca': 'cassava',
    'banana': 'banana', 'bananas': 'banana', 'plantain': 'banana',
    'soybean': 'soybean', 'soy': 'soybean', 'soya': 'soybean', 'soybeans': 'soybean',
}

# Crops that users might mention but are not in the knowledge base
UNSUPPORTED_CROPS = {
    'kale', 'kales', 'cabbage', 'spinach', 'lettuce', 'onion', 'garlic',
    'pepper', 'peppers', 'cucumber', 'mango', 'avocado', 'coffee',
    'sugarcane', 'cotton', 'groundnut', 'peanut', 'bean', 'beans',
    'pea', 'peas', 'carrot', 'carrots',
}


# ---------------------------------------------------------------------------
# Symptom keyword map
# Built once at module load from all Prolog symptom atoms.
# ---------------------------------------------------------------------------
def _build_keyword_map():
    """
    3-tier pattern list  (phrase, symptom_atom, tier):

      Tier 1 – full symptom phrase   'dark water soaked lesions'
      Tier 2 – consecutive bigrams   'yellow leaves', 'fuzzy mold'
      Tier 3 – single distinctive words ≥7 chars (generic words blocked)

    Colour words are intentionally NOT blocked so bigrams like
    'yellow streaks', 'white mold' still match at tier 2.
    """
    GENERIC_SINGLE = {
        'leaves', 'stems', 'plant', 'plants', 'lesions', 'patches',
        'growth', 'tissue', 'surface', 'margin', 'margins',
        'present', 'appear', 'become', 'entire', 'across', 'visible',
        'premature', 'severe', 'rapidly',
    }

    all_syms = set()
    for crop in prolog_engine.get_all_crops():
        for sym in prolog_engine.get_crop_symptoms(crop['id']):
            all_syms.add((sym['id'], sym['question']))

    patterns = []
    for sym_id, _question in all_syms:
        words = sym_id.split('_')

        # Tier 1 – full phrase
        patterns.append((sym_id.replace('_', ' '), sym_id, 1))

        # Tier 2 – every consecutive bigram
        for i in range(len(words) - 1):
            patterns.append((f'{words[i]} {words[i + 1]}', sym_id, 2))

        # Tier 3 – long single words
        for word in words:
            if len(word) >= 7 and word not in GENERIC_SINGLE:
                patterns.append((word, sym_id, 3))

    # Tier 1 first, then 2, then 3; longest pattern wins within each tier
    patterns.sort(key=lambda x: (x[2], -len(x[0])))
    return patterns


try:
    _KEYWORD_MAP = _build_keyword_map()
except Exception as exc:
    logger.warning("Could not build keyword map: %s", exc)
    _KEYWORD_MAP = []


# ---------------------------------------------------------------------------
# Text-parsing helpers
# ---------------------------------------------------------------------------

def _extract_crop(text):
    """
    Detect the crop mentioned in user text.
    Returns (crop_id, crop_name, is_unsupported).
    """
    text_lower = text.lower()

    # Check for unsupported crops first so we can warn the user
    for name in UNSUPPORTED_CROPS:
        if re.search(r'\b' + re.escape(name) + r'\b', text_lower):
            return None, name, True

    # Check our alias table
    for alias, crop_id in CROP_ALIASES.items():
        if re.search(r'\b' + re.escape(alias) + r'\b', text_lower):
            crops = prolog_engine.get_all_crops()
            crop_name = next(
                (c['name'] for c in crops if c['id'] == crop_id), crop_id
            )
            return crop_id, crop_name, False

    return None, None, False


def _extract_symptoms(text, crop_id=None):
    """
    Scan the free-text description and return matched symptom atom IDs.
    If crop_id is given, only return symptoms that belong to that crop.
    """
    text_lower = text.lower()
    matched = set()
    valid = (
        {s['id'] for s in prolog_engine.get_crop_symptoms(crop_id)}
        if crop_id else None
    )

    for phrase, sym_id, _tier in _KEYWORD_MAP:
        if valid is not None and sym_id not in valid:
            continue
        if phrase in text_lower:
            matched.add(sym_id)

    return list(matched)


# ---------------------------------------------------------------------------
# Views
# ---------------------------------------------------------------------------

def chat(request):
    """Render the single-page chat UI."""
    crops = prolog_engine.get_all_crops()
    return render(request, 'diagnosis/chat.html', {'crops': crops})


@require_POST
def diagnose_text(request):
    """
    AJAX POST endpoint.
    Body JSON: { "message": "<user description>" }
    Returns JSON diagnosis results.
    """
    try:
        data = json.loads(request.body)
        message = data.get('message', '').strip()
    except Exception:
        return JsonResponse({'error': 'Invalid JSON'}, status=400)

    if not message:
        return JsonResponse({'error': 'Empty message'}, status=400)

    # Strip /diagnose command prefix if present
    message = re.sub(r'^/diagnose\s*', '', message, flags=re.IGNORECASE).strip()

    # 1. Detect crop
    crop_id, crop_name, is_unsupported = _extract_crop(message)

    # User named a crop that is not in the knowledge base
    if is_unsupported:
        supported = ', '.join(c['name'] for c in prolog_engine.get_all_crops())
        return JsonResponse({
            'status': 'unsupported_crop',
            'message': (
                f"Sorry, <strong>{crop_name}</strong> is not in the "
                f"KROPA knowledge base.\n\n"
                f"Supported crops: {supported}."
            ),
            'results': [],
        })

    # 2. Extract matched symptom atoms
    symptoms = _extract_symptoms(message, crop_id)

    if not symptoms:
        supported = ', '.join(c['name'] for c in prolog_engine.get_all_crops())
        return JsonResponse({
            'status': 'no_symptoms',
            'message': (
                "I couldn't match any known symptoms in your description.\n\n"
                "Try being more specific — for example:\n"
                "• <em>'My tomato has dark water-soaked patches and white fuzzy mold on the leaves.'</em>\n"
                "• <em>'Maize leaves show pale yellow streaks and the plant is stunted.'</em>\n\n"
                f"Supported crops: {supported}."
            ),
            'crop_id': crop_id,
            'crop_name': crop_name,
            'symptoms': [],
            'results': [],
        })

    # 3. No crop detected → try all crops, pick the best-scoring one
    if not crop_id:
        best_score = -1
        best_results = []
        best_crop = None
        best_cname = None
        for crop in prolog_engine.get_all_crops():
            results = prolog_engine.diagnose_crop(crop['id'], symptoms)
            if results and results[0]['score'] > best_score:
                best_score = results[0]['score']
                best_results = results
                best_crop = crop['id']
                best_cname = crop['name']
        crop_id = best_crop
        crop_name = best_cname
        results = best_results
    else:
        # 4. Delegate entirely to Prolog ↓
        results = prolog_engine.diagnose_crop(crop_id, symptoms)

    # Build human-readable labels for the matched symptoms
    sym_map = (
        {s['id']: s['question'] for s in prolog_engine.get_crop_symptoms(crop_id)}
        if crop_id else {}
    )
    sym_labels = [sym_map.get(s, s.replace('_', ' ')) for s in symptoms]

    if results:
        _save_history(crop_id or 'unknown', crop_name or 'Unknown', symptoms, results)

    return JsonResponse({
        'status': 'ok',
        'crop_id': crop_id,
        'crop_name': crop_name,
        'symptoms': sym_labels,
        'sym_count': len(symptoms),
        'results': results,
    })


# ---------------------------------------------------------------------------
# Internal helpers
# ---------------------------------------------------------------------------

def _save_history(crop_id, crop_name, symptoms, results):
    try:
        top = results[0] if results else {}
        QueryHistory.objects.create(
            crop_id=crop_id,
            crop_name=crop_name,
            symptoms=json.dumps(symptoms),
            top_disease=top.get('name', ''),
            confidence=top.get('confidence', ''),
            results_json=json.dumps(results),
        )
    except Exception as exc:
        logger.error("Failed to save history: %s", exc)
