% ============================================================
% KROPA - Crop Disease Expert System Knowledge Base
% File: knowledge_base/crops.pl
%
% Contains:
%   - Facts: symptoms, causes, treatments, info per disease
%   - Rules: inference rules that derive a diagnosis from symptoms
%
% The Prolog engine acts as the reasoning layer; Django only
% calls into this file via PySWIP – no diagnosis logic lives
% in Python.
% ============================================================

% --------------------------------------------------------
% SECTION 1: CROPS
% crop(CropId, DisplayName)
% --------------------------------------------------------
crop(maize,   'Maize (Corn)').
crop(tomato,  'Tomato').
crop(rice,    'Rice').
crop(wheat,   'Wheat').
crop(potato,  'Potato').
crop(cassava, 'Cassava').
crop(banana,  'Banana').
crop(soybean, 'Soybean').


% --------------------------------------------------------
% SECTION 2: SYMPTOM FACTS
% symptom(DiseaseId, SymptomAtom)
%
% Each symptom is a simple atom used both here and in the UI.
% --------------------------------------------------------

% --- MAIZE DISEASES ---
% Maize Lethal Necrosis
symptom(maize_lethal_necrosis, yellow_streaking_on_leaves).
symptom(maize_lethal_necrosis, necrosis_on_leaf_margins).
symptom(maize_lethal_necrosis, dead_heart_symptom).
symptom(maize_lethal_necrosis, premature_plant_death).
symptom(maize_lethal_necrosis, small_malformed_cobs).

% Gray Leaf Spot
symptom(maize_gray_leaf_spot, rectangular_gray_lesions).
symptom(maize_gray_leaf_spot, tan_to_gray_leaf_patches).
symptom(maize_gray_leaf_spot, lesions_parallel_to_leaf_veins).
symptom(maize_gray_leaf_spot, premature_leaf_death).

% Northern Corn Leaf Blight
symptom(maize_nclb, long_elliptical_gray_lesions).
symptom(maize_nclb, lesions_with_wavy_margins).
symptom(maize_nclb, tan_or_grayish_spots).
symptom(maize_nclb, leaf_blighting).

% Maize Streak Virus
symptom(maize_streak_virus, pale_yellow_streaks_on_leaves).
symptom(maize_streak_virus, stunted_growth).
symptom(maize_streak_virus, narrow_chlorotic_streaks).
symptom(maize_streak_virus, distorted_leaves).

% Common Rust
symptom(maize_common_rust, small_reddish_brown_pustules).
symptom(maize_common_rust, pustules_on_both_leaf_surfaces).
symptom(maize_common_rust, dusty_orange_powder_on_leaves).
symptom(maize_common_rust, yellowing_around_pustules).

% --- TOMATO DISEASES ---
% Early Blight
symptom(tomato_early_blight, dark_brown_spots_with_concentric_rings).
symptom(tomato_early_blight, yellowing_around_spots).
symptom(tomato_early_blight, lower_leaves_affected_first).
symptom(tomato_early_blight, lesions_with_target_board_pattern).

% Late Blight
symptom(tomato_late_blight, dark_water_soaked_lesions).
symptom(tomato_late_blight, white_fuzzy_mold_on_leaf_underside).
symptom(tomato_late_blight, brown_rotting_fruit).
symptom(tomato_late_blight, rapid_wilting_of_plant).

% Fusarium Wilt
symptom(tomato_fusarium_wilt, yellowing_of_lower_leaves).
symptom(tomato_fusarium_wilt, wilting_despite_adequate_water).
symptom(tomato_fusarium_wilt, brown_discoloration_of_stem_vascular).
symptom(tomato_fusarium_wilt, one_sided_leaf_yellowing).

% Tomato Mosaic Virus
symptom(tomato_mosaic_virus, mosaic_pattern_on_leaves).
symptom(tomato_mosaic_virus, leaf_distortion_and_curling).
symptom(tomato_mosaic_virus, stunted_plant_growth).
symptom(tomato_mosaic_virus, mottled_light_dark_green_patches).

% Bacterial Speck
symptom(tomato_bacterial_speck, small_dark_brown_spots_with_yellow_halo).
symptom(tomato_bacterial_speck, spots_on_fruit_surface).
symptom(tomato_bacterial_speck, water_soaked_lesions_turning_brown).
symptom(tomato_bacterial_speck, defoliation_in_severe_cases).

% --- RICE DISEASES ---
% Rice Blast
symptom(rice_blast, diamond_shaped_lesions_on_leaves).
symptom(rice_blast, gray_center_with_brown_border_lesions).
symptom(rice_blast, neck_rot_at_base_of_panicle).
symptom(rice_blast, whitish_gray_spots).

% Bacterial Leaf Blight
symptom(rice_bacterial_leaf_blight, water_soaked_leaf_margins).
symptom(rice_bacterial_leaf_blight, yellowing_from_leaf_tip).
symptom(rice_bacterial_leaf_blight, wilting_of_seedlings).
symptom(rice_bacterial_leaf_blight, bacterial_ooze_on_leaves).

% Brown Spot
symptom(rice_brown_spot, oval_to_circular_brown_spots).
symptom(rice_brown_spot, spots_with_gray_center_and_brown_margin).
symptom(rice_brown_spot, spots_scattered_across_leaf_blade).
symptom(rice_brown_spot, premature_ripening_of_grain).

% Sheath Blight
symptom(rice_sheath_blight, oval_or_elliptical_lesions_on_sheath).
symptom(rice_sheath_blight, greenish_gray_lesions_with_brown_border).
symptom(rice_sheath_blight, lesions_extending_to_leaf_blades).
symptom(rice_sheath_blight, white_cottony_mycelial_growth).

% --- WHEAT DISEASES ---
% Wheat Rust (Stem Rust)
symptom(wheat_stem_rust, reddish_brown_pustules_on_stems).
symptom(wheat_stem_rust, pustules_on_leaves_and_sheaths).
symptom(wheat_stem_rust, urediniospores_dust_easily_rubbed_off).
symptom(wheat_stem_rust, lodging_of_plants).

% Powdery Mildew
symptom(wheat_powdery_mildew, white_powdery_patches_on_leaves).
symptom(wheat_powdery_mildew, powdery_coating_on_stems_and_ears).
symptom(wheat_powdery_mildew, yellowing_of_affected_leaves).
symptom(wheat_powdery_mildew, stunted_growth).

% Septoria Leaf Blotch
symptom(wheat_septoria, tan_to_brown_irregular_blotches).
symptom(wheat_septoria, small_black_dots_within_lesions).
symptom(wheat_septoria, lower_leaves_most_infected).
symptom(wheat_septoria, water_soaked_lesions_initially).

% --- POTATO DISEASES ---
% Late Blight
symptom(potato_late_blight, dark_water_soaked_lesions_on_leaves).
symptom(potato_late_blight, white_cottony_growth_on_leaf_underside).
symptom(potato_late_blight, rapid_tissue_death_and_browning).
symptom(potato_late_blight, brown_rotting_tubers).

% Early Blight
symptom(potato_early_blight, dark_brown_irregular_spots_on_leaves).
symptom(potato_early_blight, target_ring_pattern_in_spots).
symptom(potato_early_blight, yellowing_around_spot_edges).
symptom(potato_early_blight, severe_defoliation).

% Blackleg
symptom(potato_blackleg, black_slimy_rot_at_stem_base).
symptom(potato_blackleg, wilting_of_upper_leaves).
symptom(potato_blackleg, yellowing_and_upward_rolling_of_leaves).
symptom(potato_blackleg, rotting_of_seed_piece).

% --- CASSAVA DISEASES ---
% Cassava Mosaic Disease
symptom(cassava_mosaic, mosaic_chlorosis_on_leaves).
symptom(cassava_mosaic, leaf_distortion_and_curling).
symptom(cassava_mosaic, stunted_plant_growth).
symptom(cassava_mosaic, reduced_leaf_size).

% Cassava Brown Streak
symptom(cassava_brown_streak, yellow_blotches_on_leaves).
symptom(cassava_brown_streak, brown_necrotic_streaks_in_tubers).
symptom(cassava_brown_streak, feathery_yellow_mottle_on_leaves).
symptom(cassava_brown_streak, poor_tuber_quality).

% --- BANANA DISEASES ---
% Panama Disease (Fusarium Wilt)
symptom(banana_panama_disease, yellowing_of_older_outer_leaves).
symptom(banana_panama_disease, wilting_and_collapse_of_leaf_petioles).
symptom(banana_panama_disease, brown_discoloration_in_pseudostem).
symptom(banana_panama_disease, premature_fruit_ripening).

% Black Sigatoka
symptom(banana_black_sigatoka, dark_brown_streaks_on_leaves).
symptom(banana_black_sigatoka, streaks_enlarge_to_dark_elliptical_spots).
symptom(banana_black_sigatoka, gray_center_with_yellow_halo).
symptom(banana_black_sigatoka, premature_leaf_death).

% --- SOYBEAN DISEASES ---
% Soybean Rust
symptom(soybean_rust, small_tan_to_reddish_brown_lesions).
symptom(soybean_rust, yellowish_spots_on_upper_leaf_surface).
symptom(soybean_rust, fungal_pustules_on_leaf_underside).
symptom(soybean_rust, early_defoliation).

% Frogeye Leaf Spot
symptom(soybean_frogeye, circular_lesions_with_reddish_brown_margin).
symptom(soybean_frogeye, gray_center_in_lesions).
symptom(soybean_frogeye, lesions_on_both_leaf_surfaces).
symptom(soybean_frogeye, spots_may_coalesce_and_kill_leaf).


% --------------------------------------------------------
% SECTION 3: CAUSE FACTS
% cause(DiseaseId, CauseDescription)
% --------------------------------------------------------
cause(maize_lethal_necrosis,    'Co-infection by Maize Chlorotic Mottle Virus (MCMV) and a potyvirus; spread by thrips and aphids').
cause(maize_gray_leaf_spot,     'Fungus Cercospora zeae-maydis; favoured by warm humid conditions and poor air circulation').
cause(maize_nclb,               'Fungus Setosphaeria turcica (anamorph Exserohilum turcicum); windborne conidia spread in wet weather').
cause(maize_streak_virus,       'Maize Streak Virus (MSV) transmitted by leafhoppers (Cicadulina spp.)').
cause(maize_common_rust,        'Fungus Puccinia sorghi; windborne urediospores, favoured by cool humid nights').

cause(tomato_early_blight,      'Fungus Alternaria solani; overwinters in soil debris; spreads via splashing rain').
cause(tomato_late_blight,       'Oomycete Phytophthora infestans; spreads rapidly in cool wet conditions').
cause(tomato_fusarium_wilt,     'Soil-borne fungus Fusarium oxysporum f. sp. lycopersici; enters through roots').
cause(tomato_mosaic_virus,      'Tomato Mosaic Virus (ToMV), mechanically transmitted by contact or insects').
cause(tomato_bacterial_speck,   'Bacterium Pseudomonas syringae pv. tomato; favoured by cool wet weather').

cause(rice_blast,               'Fungus Magnaporthe oryzae; windborne conidia, promoted by excess nitrogen and humidity').
cause(rice_bacterial_leaf_blight, 'Bacterium Xanthomonas oryzae pv. oryzae; enters through leaf margins and water pores').
cause(rice_brown_spot,          'Fungus Cochliobolus miyabeanus; linked to nutrient-deficient or drought-stressed soil').
cause(rice_sheath_blight,       'Fungus Rhizoctonia solani; spreads through infected soil and plant debris').

cause(wheat_stem_rust,          'Fungus Puccinia graminis f. sp. tritici; windborne spores, favoured by warm moist weather').
cause(wheat_powdery_mildew,     'Fungus Blumeria graminis f. sp. tritici; thrives in humid conditions with poor air flow').
cause(wheat_septoria,           'Fungus Zymoseptoria tritici; rain-splashed spores, severe in wet autumns and springs').

cause(potato_late_blight,       'Oomycete Phytophthora infestans; cool wet conditions; spreads explosively').
cause(potato_early_blight,      'Fungus Alternaria solani; spreads by air and splashing rain; worse in older plants').
cause(potato_blackleg,          'Bacterium Pectobacterium atrosepticum; soil-borne, enters through wounds').

cause(cassava_mosaic,           'Cassava Mosaic Virus complex (CMV); transmitted by whiteflies (Bemisia tabaci)').
cause(cassava_brown_streak,     'Cassava Brown Streak Virus (CBSV); transmitted by whiteflies').

cause(banana_panama_disease,    'Soil-borne fungus Fusarium oxysporum f. sp. cubense; survives decades in soil').
cause(banana_black_sigatoka,    'Fungus Pseudocercospora fijiensis; windborne ascospores in warm humid climates').

cause(soybean_rust,             'Fungus Phakopsora pachyrhizi; windborne urediospores; favoured by warm humid weather').
cause(soybean_frogeye,          'Fungus Cercospora sojina; seed-borne and survives on infested plant residues').


% --------------------------------------------------------
% SECTION 4: TREATMENT FACTS
% treatment(DiseaseId, TreatmentDescription)
% --------------------------------------------------------
treatment(maize_lethal_necrosis,    'Remove and destroy infected plants; control thrips/aphids with insecticides; use certified virus-free seed; plant resistant varieties').
treatment(maize_gray_leaf_spot,     'Apply fungicides (strobilurins, triazoles); improve row spacing for air circulation; rotate crops; use resistant hybrids').
treatment(maize_nclb,               'Apply triazole or strobilurin fungicides at early disease onset; use resistant varieties; practice crop rotation').
treatment(maize_streak_virus,       'Control leafhopper vectors with insecticides; use streak-resistant maize varieties; early planting to escape peak leafhopper season').
treatment(maize_common_rust,        'Apply triazole fungicides preventively; plant rust-resistant varieties; avoid late planting').

treatment(tomato_early_blight,      'Apply chlorothalonil or mancozeb fungicides; remove infected lower leaves; practice crop rotation; mulch to reduce soil splash').
treatment(tomato_late_blight,       'Apply metalaxyl, mancozeb, or copper-based fungicides; destroy infected plants; avoid overhead irrigation; use resistant varieties').
treatment(tomato_fusarium_wilt,     'No effective cure once infected; use resistant varieties; solarize soil; practice long crop rotation (4+ years); improve drainage').
treatment(tomato_mosaic_virus,      'No chemical cure; remove and destroy infected plants; sanitize tools; control insect vectors; use virus-free transplants').
treatment(tomato_bacterial_speck,   'Apply copper-based bactericides; avoid working with wet plants; remove crop debris; use certified disease-free seed').

treatment(rice_blast,               'Apply tricyclazole or propiconazole fungicides; balance nitrogen fertilization; drain fields periodically; use blast-resistant varieties').
treatment(rice_bacterial_leaf_blight, 'Use copper-based bactericides; drain infected fields; avoid excess nitrogen; plant resistant varieties (IRBB lines)').
treatment(rice_brown_spot,          'Improve soil fertility (especially potassium and silicon); apply mancozeb or propiconazole fungicides; use healthy certified seed').
treatment(rice_sheath_blight,       'Apply validamycin or hexaconazole fungicide; reduce plant density; drain field to reduce humidity; use tolerant varieties').

treatment(wheat_stem_rust,          'Apply triazole fungicides (propiconazole, tebuconazole); use resistant varieties; early planting; remove volunteer wheat plants').
treatment(wheat_powdery_mildew,     'Apply triadimefon or propiconazole fungicides; improve air circulation; use resistant varieties; avoid excess nitrogen').
treatment(wheat_septoria,           'Apply strobilurin or triazole fungicides from flag leaf stage; use resistant varieties; bury crop residues by ploughing').

treatment(potato_late_blight,       'Apply metalaxyl-mancozeb or copper hydroxide fungicides preventively; destroy infected plants and tubers; avoid overhead irrigation; store only healthy tubers').
treatment(potato_early_blight,      'Apply mancozeb or chlorothalonil fungicides; remove infected leaves; fertilize adequately; practice crop rotation').
treatment(potato_blackleg,          'Use disease-free seed tubers; treat cut surfaces with fungicide; improve soil drainage; remove and destroy infected plants').

treatment(cassava_mosaic,           'Remove and destroy infected plants; use clean planting material; control whiteflies with insecticides or neem; plant CMD-resistant varieties').
treatment(cassava_brown_streak,     'Use clean disease-tested cuttings; rogueing of infected plants; control whitefly vectors; plant CBSD-tolerant varieties').

treatment(banana_panama_disease,    'No chemical cure; remove and destroy infected mats; maintain long fallows; plant resistant varieties (e.g., FHIA hybrids); improve soil drainage').
treatment(banana_black_sigatoka,    'Apply triazole or strobilurin fungicides on a scheduled programme; remove and destroy old leaves; improve drainage and air circulation').

treatment(soybean_rust,             'Apply triazole fungicides (tebuconazole, azoxystrobin); scout regularly; early planting to avoid peak spore pressure; use resistant varieties').
treatment(soybean_frogeye,          'Apply strobilurin or triazole fungicides; rotate crops; use certified disease-free seed; select resistant varieties').


% --------------------------------------------------------
% SECTION 5: DISEASE DISPLAY NAMES
% disease_name(DiseaseId, DisplayName)
% --------------------------------------------------------
disease_name(maize_lethal_necrosis,     'Maize Lethal Necrosis (MLN)').
disease_name(maize_gray_leaf_spot,      'Gray Leaf Spot').
disease_name(maize_nclb,               'Northern Corn Leaf Blight (NCLB)').
disease_name(maize_streak_virus,        'Maize Streak Virus (MSV)').
disease_name(maize_common_rust,         'Common Rust').

disease_name(tomato_early_blight,       'Early Blight').
disease_name(tomato_late_blight,        'Late Blight').
disease_name(tomato_fusarium_wilt,      'Fusarium Wilt').
disease_name(tomato_mosaic_virus,       'Tomato Mosaic Virus').
disease_name(tomato_bacterial_speck,    'Bacterial Speck').

disease_name(rice_blast,                'Rice Blast').
disease_name(rice_bacterial_leaf_blight,'Bacterial Leaf Blight').
disease_name(rice_brown_spot,           'Brown Spot').
disease_name(rice_sheath_blight,        'Sheath Blight').

disease_name(wheat_stem_rust,           'Stem Rust').
disease_name(wheat_powdery_mildew,      'Powdery Mildew').
disease_name(wheat_septoria,            'Septoria Leaf Blotch').

disease_name(potato_late_blight,        'Late Blight').
disease_name(potato_early_blight,       'Early Blight').
disease_name(potato_blackleg,           'Blackleg').

disease_name(cassava_mosaic,            'Cassava Mosaic Disease (CMD)').
disease_name(cassava_brown_streak,      'Cassava Brown Streak Disease (CBSD)').

disease_name(banana_panama_disease,     'Panama Disease (Fusarium Wilt TR4)').
disease_name(banana_black_sigatoka,     'Black Sigatoka').

disease_name(soybean_rust,              'Soybean Rust').
disease_name(soybean_frogeye,           'Frogeye Leaf Spot').


% --------------------------------------------------------
% SECTION 6: CROP-DISEASE MEMBERSHIP
% disease_of_crop(CropId, DiseaseId)
% Maps which diseases belong to which crop.
% --------------------------------------------------------
disease_of_crop(maize,   maize_lethal_necrosis).
disease_of_crop(maize,   maize_gray_leaf_spot).
disease_of_crop(maize,   maize_nclb).
disease_of_crop(maize,   maize_streak_virus).
disease_of_crop(maize,   maize_common_rust).

disease_of_crop(tomato,  tomato_early_blight).
disease_of_crop(tomato,  tomato_late_blight).
disease_of_crop(tomato,  tomato_fusarium_wilt).
disease_of_crop(tomato,  tomato_mosaic_virus).
disease_of_crop(tomato,  tomato_bacterial_speck).

disease_of_crop(rice,    rice_blast).
disease_of_crop(rice,    rice_bacterial_leaf_blight).
disease_of_crop(rice,    rice_brown_spot).
disease_of_crop(rice,    rice_sheath_blight).

disease_of_crop(wheat,   wheat_stem_rust).
disease_of_crop(wheat,   wheat_powdery_mildew).
disease_of_crop(wheat,   wheat_septoria).

disease_of_crop(potato,  potato_late_blight).
disease_of_crop(potato,  potato_early_blight).
disease_of_crop(potato,  potato_blackleg).

disease_of_crop(cassava, cassava_mosaic).
disease_of_crop(cassava, cassava_brown_streak).

disease_of_crop(banana,  banana_panama_disease).
disease_of_crop(banana,  banana_black_sigatoka).

disease_of_crop(soybean, soybean_rust).
disease_of_crop(soybean, soybean_frogeye).


% --------------------------------------------------------
% SECTION 7: INFERENCE RULES
%
%   count_matching_symptoms(+Disease, +ObservedSymptoms, -Count)
%   Counts how many facts symptom(Disease, S) appear in
%   ObservedSymptoms.
%
%   total_symptoms(+Disease, -Total)
%   Counts all symptoms defined for Disease.
%
%   match_score(+Disease, +ObservedSymptoms, -Score)
%   Score = Count / Total  (a fraction 0..1).
%   Only succeeds when Count > 0.
%
%   diagnose(+CropId, +ObservedSymptoms, -Disease, -Score, -MatchCount, -TotalSymptoms)
%   Entry point called from Python.  Returns every disease of the
%   given crop together with its match score, ordered best-first.
%
%   get_symptoms_for_crop(+CropId, -SymptomList)
%   Returns the deduplicated list of all symptom atoms for a crop,
%   used to build the interactive question list.
% --------------------------------------------------------

%% count_matching_symptoms/3
count_matching_symptoms(Disease, ObservedSymptoms, Count) :-
    findall(S,
        (symptom(Disease, S), member(S, ObservedSymptoms)),
        Matches),
    length(Matches, Count).

%% total_symptoms/2
total_symptoms(Disease, Total) :-
    findall(S, symptom(Disease, S), All),
    length(All, Total).

%% match_score/3
match_score(Disease, ObservedSymptoms, Score) :-
    count_matching_symptoms(Disease, ObservedSymptoms, Count),
    Count > 0,
    total_symptoms(Disease, Total),
    Total > 0,
    Score is Count / Total.

%% diagnose/6
%  Returns diseases sorted by score descending.
%  Backtracking yields each result in turn.
diagnose(CropId, ObservedSymptoms, Disease, Score, MatchCount, TotalSymptoms) :-
    findall(
        score(S, D, C, T),
        (
            disease_of_crop(CropId, D),
            count_matching_symptoms(D, ObservedSymptoms, C),
            C > 0,
            total_symptoms(D, T),
            S is C / T
        ),
        AllScores
    ),
    % Sort descending by score (msort preserves duplicates; we reverse)
    msort(AllScores, SortedAsc),
    reverse(SortedAsc, SortedDesc),
    member(score(Score, Disease, MatchCount, TotalSymptoms), SortedDesc).

%% Convenience rule: get all symptoms for a crop (deduped, sorted)
get_symptoms_for_crop(CropId, SortedSymptoms) :-
    findall(S,
        (disease_of_crop(CropId, D), symptom(D, S)),
        Raw),
    list_to_set(Raw, Unique),
    msort(Unique, SortedSymptoms).

%% get_disease_info/4  – retrieve name, cause and treatment in one call
get_disease_info(DiseaseId, Name, Cause, Treatment) :-
    disease_name(DiseaseId, Name),
    cause(DiseaseId, Cause),
    treatment(DiseaseId, Treatment).

%% ask_question/2 – maps each symptom atom to a human-readable question
%% Used by the interactive Q&A flow.
ask_question(yellow_streaking_on_leaves,               'Are there yellow streaks running along the leaves?').
ask_question(necrosis_on_leaf_margins,                 'Do you see dead (necrotic) tissue along the leaf edges?').
ask_question(dead_heart_symptom,                       'Is the central whorl dead or dried up?').
ask_question(premature_plant_death,                    'Are entire plants dying before maturity?').
ask_question(small_malformed_cobs,                     'Are the cobs small or malformed?').
ask_question(rectangular_gray_lesions,                 'Are there rectangular gray lesions on the leaves?').
ask_question(tan_to_gray_leaf_patches,                 'Do you see tan or gray patches on the leaves?').
ask_question(lesions_parallel_to_leaf_veins,           'Are the lesions running parallel to the leaf veins?').
ask_question(premature_leaf_death,                     'Are leaves dying prematurely?').
ask_question(long_elliptical_gray_lesions,             'Are there long, elliptical gray-tan lesions on the leaves?').
ask_question(lesions_with_wavy_margins,                'Do the lesions have wavy or irregular margins?').
ask_question(tan_or_grayish_spots,                     'Are there tan or grayish spots on the foliage?').
ask_question(leaf_blighting,                           'Are large portions of the leaf blighted (killed)?').
ask_question(pale_yellow_streaks_on_leaves,            'Are there pale yellow streaks along the leaves?').
ask_question(stunted_growth,                           'Is the plant noticeably shorter or smaller than healthy plants?').
ask_question(narrow_chlorotic_streaks,                 'Do you see narrow yellowish streaks on young leaves?').
ask_question(distorted_leaves,                         'Are the leaves twisted, curled or misshapen?').
ask_question(small_reddish_brown_pustules,             'Can you see small reddish-brown raised pustules on the leaves?').
ask_question(pustules_on_both_leaf_surfaces,           'Are the pustules present on both sides of the leaf?').
ask_question(dusty_orange_powder_on_leaves,            'Is there orange/rust-coloured dusty powder on the leaves?').
ask_question(yellowing_around_pustules,                'Is there yellowing of the leaf tissue around the pustules?').
ask_question(dark_brown_spots_with_concentric_rings,   'Are there dark brown spots with concentric ring patterns (like a target)?').
ask_question(yellowing_around_spots,                   'Is there yellowing of the leaf tissue surrounding the brown spots?').
ask_question(lower_leaves_affected_first,              'Are the lower/older leaves the most affected?').
ask_question(lesions_with_target_board_pattern,        'Do the lesions look like a target board (rings within rings)?').
ask_question(dark_water_soaked_lesions,                'Are there dark, water-soaked patches appearing rapidly?').
ask_question(white_fuzzy_mold_on_leaf_underside,       'Is there white fuzzy mold on the underside of the leaves?').
ask_question(brown_rotting_fruit,                      'Is the fruit turning brown and rotting?').
ask_question(rapid_wilting_of_plant,                   'Is the plant wilting very quickly?').
ask_question(yellowing_of_lower_leaves,                'Are the lower leaves turning yellow?').
ask_question(wilting_despite_adequate_water,           'Is the plant wilting even when the soil has enough moisture?').
ask_question(brown_discoloration_of_stem_vascular,     'If you cut the stem, is the inner tissue brown or discoloured?').
ask_question(one_sided_leaf_yellowing,                 'Is yellowing more pronounced on one side of the plant?').
ask_question(mosaic_pattern_on_leaves,                 'Do the leaves show a patchy mosaic of light and dark green?').
ask_question(leaf_distortion_and_curling,              'Are the leaves distorted, curled or puckered?').
ask_question(mottled_light_dark_green_patches,         'Are there irregular mottled light/dark green patches?').
ask_question(small_dark_brown_spots_with_yellow_halo,  'Are there small dark brown spots surrounded by a yellow halo?').
ask_question(spots_on_fruit_surface,                   'Are small dark spots visible on the fruit surface?').
ask_question(water_soaked_lesions_turning_brown,       'Are there water-soaked lesions that turn brown quickly?').
ask_question(defoliation_in_severe_cases,              'Is the plant losing leaves prematurely?').
ask_question(diamond_shaped_lesions_on_leaves,         'Are there diamond-shaped lesions on the leaves?').
ask_question(gray_center_with_brown_border_lesions,    'Do the lesions have a gray centre with a brown border?').
ask_question(neck_rot_at_base_of_panicle,              'Is there rotting or discolouration at the neck of the grain panicle?').
ask_question(whitish_gray_spots,                       'Are there whitish-gray spots on the foliage?').
ask_question(water_soaked_leaf_margins,                'Are the leaf margins water-soaked or bleached?').
ask_question(yellowing_from_leaf_tip,                  'Is yellowing starting from the tip and moving inward?').
ask_question(wilting_of_seedlings,                     'Are seedlings wilting or collapsing (kresek)?').
ask_question(bacterial_ooze_on_leaves,                 'Do you see yellowish bacterial ooze on cut stems placed in water?').
ask_question(oval_to_circular_brown_spots,             'Are there oval to circular brown spots on the leaves?').
ask_question(spots_with_gray_center_and_brown_margin,  'Do spots have a gray centre and brown margin?').
ask_question(spots_scattered_across_leaf_blade,        'Are spots scattered broadly across the leaf surface?').
ask_question(premature_ripening_of_grain,              'Is the grain ripening too early or incompletely?').
ask_question(oval_or_elliptical_lesions_on_sheath,     'Are there oval lesions on the leaf sheath (lower stem)?').
ask_question(greenish_gray_lesions_with_brown_border,  'Are the sheath lesions greenish-gray with a brown border?').
ask_question(lesions_extending_to_leaf_blades,         'Are lesions extending from the sheath up into the leaf blade?').
ask_question(white_cottony_mycelial_growth,            'Is there white cottony fungal growth visible?').
ask_question(reddish_brown_pustules_on_stems,          'Are there reddish-brown pustules on the stems?').
ask_question(pustules_on_leaves_and_sheaths,           'Are pustules present on both leaves and sheaths?').
ask_question(urediniospores_dust_easily_rubbed_off,    'Does orange rust dust rub off easily when you touch the lesions?').
ask_question(lodging_of_plants,                        'Are plants falling over (lodging) due to weakened stems?').
ask_question(white_powdery_patches_on_leaves,          'Are there white powdery patches on the upper leaf surface?').
ask_question(powdery_coating_on_stems_and_ears,        'Is the powdery coating also on the stems and ears?').
ask_question(yellowing_of_affected_leaves,             'Are the affected leaves turning yellow?').
ask_question(tan_to_brown_irregular_blotches,          'Are there tan to brown irregular blotches on leaves?').
ask_question(small_black_dots_within_lesions,          'Are there tiny black dots (pycnidia) within the lesions?').
ask_question(lower_leaves_most_infected,               'Are the lower, older leaves the most severely infected?').
ask_question(water_soaked_lesions_initially,           'Did the lesions start as water-soaked before turning brown?').
ask_question(dark_water_soaked_lesions_on_leaves,      'Are there dark water-soaked lesions on potato leaves?').
ask_question(white_cottony_growth_on_leaf_underside,   'Is there white cottony growth visible on the leaf underside?').
ask_question(rapid_tissue_death_and_browning,          'Is tissue dying quickly and turning brown?').
ask_question(brown_rotting_tubers,                     'Are the tubers showing brown internal rot?').
ask_question(dark_brown_irregular_spots_on_leaves,     'Are there dark brown irregular spots on the leaves?').
ask_question(target_ring_pattern_in_spots,             'Do the spots have concentric target-ring patterns?').
ask_question(yellowing_around_spot_edges,              'Is there yellowing around the edges of the spots?').
ask_question(severe_defoliation,                       'Is the plant losing many leaves (severe defoliation)?').
ask_question(black_slimy_rot_at_stem_base,             'Is there black slimy rot at the base of the stem?').
ask_question(wilting_of_upper_leaves,                  'Are the upper leaves wilting while lower stem is black and rotting?').
ask_question(yellowing_and_upward_rolling_of_leaves,   'Are the leaves yellowing and rolling upward?').
ask_question(rotting_of_seed_piece,                    'Has the original seed piece rotted away?').
ask_question(mosaic_chlorosis_on_leaves,               'Do the leaves show a mosaic-like yellowing (chlorosis)?').
ask_question(reduced_leaf_size,                        'Are the leaves noticeably smaller than normal?').
ask_question(yellow_blotches_on_leaves,                'Are there yellow blotches on the leaves?').
ask_question(brown_necrotic_streaks_in_tubers,         'Are there brown necrotic streaks inside the tubers?').
ask_question(feathery_yellow_mottle_on_leaves,         'Is there a feathery yellow mottle pattern on the leaves?').
ask_question(poor_tuber_quality,                       'Is overall tuber/root quality very poor?').
ask_question(yellowing_of_older_outer_leaves,          'Are the older outer leaves turning yellow first?').
ask_question(wilting_and_collapse_of_leaf_petioles,    'Are the leaf stems wilting and collapsing?').
ask_question(brown_discoloration_in_pseudostem,        'Is there brown discolouration inside the banana stem when cut?').
ask_question(premature_fruit_ripening,                 'Is the fruit ripening prematurely or unevenly?').
ask_question(dark_brown_streaks_on_leaves,             'Are there dark brown streaks on the leaves?').
ask_question(streaks_enlarge_to_dark_elliptical_spots, 'Do the streaks enlarge into dark elliptical spots?').
ask_question(gray_center_with_yellow_halo,             'Do the spots have a gray centre surrounded by a yellow halo?').
ask_question(small_tan_to_reddish_brown_lesions,       'Are there small tan to reddish-brown lesions on the leaves?').
ask_question(yellowish_spots_on_upper_leaf_surface,    'Are there yellowish spots on the upper leaf surface?').
ask_question(fungal_pustules_on_leaf_underside,        'Are there small pustules on the underside of the leaves?').
ask_question(early_defoliation,                        'Is the plant dropping its leaves earlier than normal?').
ask_question(circular_lesions_with_reddish_brown_margin, 'Are the lesions circular with a reddish-brown margin?').
ask_question(gray_center_in_lesions,                   'Do the lesions have a gray centre?').
ask_question(lesions_on_both_leaf_surfaces,            'Are lesions present on both sides of the leaf?').
ask_question(spots_may_coalesce_and_kill_leaf,         'Are multiple spots merging together and killing the whole leaf?').
