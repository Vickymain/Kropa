"""
KROPA – Prolog Inference Engine Bridge
======================================
This module is the ONLY place where Python talks to Prolog.
All reasoning is delegated to the Prolog knowledge base (crops.pl).
Django views import functions from this module; they never perform
any diagnosis logic themselves.

Architecture:
  Python (Django)  <-->  prolog_engine.py  <-->  SWI-Prolog (PySWIP)
                         (this file)              (crops.pl)
"""

import os
import logging
from typing import List, Dict, Any, Optional, Tuple

from django.conf import settings

logger = logging.getLogger(__name__)

# ---------------------------------------------------------------------------
# PySWIP initialisation
# ---------------------------------------------------------------------------
try:
    from pyswip import Prolog, Atom, Variable, Functor, call
    _prolog = Prolog()
    _prolog.consult(settings.PROLOG_KB_PATH)
    PROLOG_AVAILABLE = True
    logger.info("Prolog knowledge base loaded from %s", settings.PROLOG_KB_PATH)
except Exception as exc:
    PROLOG_AVAILABLE = False
    _prolog = None
    logger.error("Failed to initialise Prolog: %s", exc)


# ---------------------------------------------------------------------------
# Internal helper
# ---------------------------------------------------------------------------

def _query(goal: str) -> List[Dict[str, Any]]:
    """Run a Prolog query and return all solutions as a list of dicts."""
    if not PROLOG_AVAILABLE:
        raise RuntimeError("Prolog engine is not available.")
    try:
        return list(_prolog.query(goal))
    except Exception as exc:
        logger.error("Prolog query failed: %s | query: %s", exc, goal)
        return []


def _pl_list(python_list: List[str]) -> str:
    """
    Convert a Python list of strings to a Prolog list literal.
    e.g. ['yellow_leaves', 'brown_spots'] → '[yellow_leaves,brown_spots]'
    """
    return '[' + ','.join(python_list) + ']'


# ---------------------------------------------------------------------------
# Public API – called by Django views
# ---------------------------------------------------------------------------

def get_all_crops() -> List[Dict[str, str]]:
    """
    Return all crops from Prolog as a list of dicts:
        [{'id': 'maize', 'name': 'Maize (Corn)'}, ...]
    Prolog goal:  crop(CropId, DisplayName)
    """
    results = _query("crop(CropId, DisplayName)")
    return [
        {'id': str(r['CropId']), 'name': str(r['DisplayName'])}
        for r in results
    ]


def get_crop_symptoms(crop_id: str) -> List[Dict[str, str]]:
    """
    Return all symptom atoms for a crop together with their
    human-readable question text.
    Prolog goal:  get_symptoms_for_crop(CropId, Symptoms),
                  member(S, Symptoms),
                  ask_question(S, Q)

    Returns:
        [{'id': 'yellow_streaking_on_leaves',
          'question': 'Are there yellow streaks running along the leaves?'},
         ...]
    """
    goal = (
        f"get_symptoms_for_crop({crop_id}, Symptoms),"
        f"member(Symptom, Symptoms),"
        f"ask_question(Symptom, Question)"
    )
    results = _query(goal)
    seen = set()
    symptoms = []
    for r in results:
        sid = str(r['Symptom'])
        if sid not in seen:
            seen.add(sid)
            symptoms.append({
                'id': sid,
                'question': str(r['Question']),
            })
    return symptoms


def diagnose_crop(crop_id: str, observed_symptoms: List[str]) -> List[Dict[str, Any]]:
    """
    Run the inference engine: query Prolog with the crop and a list of
    observed symptom atoms, and return ranked diagnoses.

    Prolog goal:
        diagnose(CropId, [sym1,sym2,...], Disease, Score, MatchCount, TotalSymptoms),
        get_disease_info(Disease, Name, Cause, Treatment)

    Returns a list of dicts sorted by confidence (highest first):
        [
          {
            'disease_id':   'tomato_late_blight',
            'name':         'Late Blight',
            'cause':        '...',
            'treatment':    '...',
            'score':        0.75,
            'match_count':  3,
            'total_symptoms': 4,
            'confidence':   'High',
          },
          ...
        ]
    """
    if not observed_symptoms:
        return []

    pl_symptoms = _pl_list(observed_symptoms)
    goal = (
        f"diagnose({crop_id}, {pl_symptoms}, Disease, Score, MatchCount, TotalSymptoms),"
        f"get_disease_info(Disease, Name, Cause, Treatment)"
    )
    results = _query(goal)

    diagnoses = []
    seen_diseases = set()
    for r in results:
        disease_id = str(r['Disease'])
        if disease_id in seen_diseases:
            continue
        seen_diseases.add(disease_id)

        score = float(r['Score'])
        match_count = int(r['MatchCount'])
        total = int(r['TotalSymptoms'])

        # Determine confidence label
        if score >= 0.75:
            confidence = 'High'
        elif score >= 0.5:
            confidence = 'Moderate'
        else:
            confidence = 'Low'

        diagnoses.append({
            'disease_id':      disease_id,
            'name':            str(r['Name']),
            'cause':           str(r['Cause']),
            'treatment':       str(r['Treatment']),
            'score':           round(score * 100, 1),   # percentage
            'match_count':     match_count,
            'total_symptoms':  total,
            'confidence':      confidence,
        })

    # Sort by score descending (Prolog already returns in order, but be safe)
    diagnoses.sort(key=lambda d: d['score'], reverse=True)
    return diagnoses


def get_interactive_question(crop_id: str, answered_symptoms: List[str]) -> Optional[Dict[str, str]]:
    """
    Interactive Q&A: return the NEXT symptom question to ask.

    Strategy (all in Prolog):
    1. Fetch all symptoms for the crop.
    2. Exclude already-answered ones.
    3. Return the first unanswered one.

    Returns {'id': ..., 'question': ...} or None if all asked.
    """
    all_symptoms = get_crop_symptoms(crop_id)
    for sym in all_symptoms:
        if sym['id'] not in answered_symptoms:
            return sym
    return None


def get_disease_details(disease_id: str) -> Optional[Dict[str, str]]:
    """
    Retrieve full details for a specific disease by its Prolog ID.
    Prolog goal:  get_disease_info(DiseaseId, Name, Cause, Treatment)
    """
    goal = f"get_disease_info({disease_id}, Name, Cause, Treatment)"
    results = _query(goal)
    if not results:
        return None
    r = results[0]
    return {
        'disease_id': disease_id,
        'name':       str(r['Name']),
        'cause':      str(r['Cause']),
        'treatment':  str(r['Treatment']),
    }
