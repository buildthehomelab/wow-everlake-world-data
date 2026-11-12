-- Efficient Games Forever 70862 creature and vendor capture (CC BY 4.0).
-- Spell 1307266 summons the bot. SummonProperties 5851 specifies faction 35 in build 70862.
CREATE TEMPORARY TABLE everlake_reagent_offers (slot INT, item INT PRIMARY KEY, stock INT);
INSERT INTO everlake_reagent_offers VALUES
    (0, 10284, 0),
    (1, 10290, 0),
    (2, 10647, 0),
    (3, 10648, 0),
    (4, 11291, 0),
    (5, 14341, 0),
    (6, 159, 0),
    (7, 16583, 0),
    (8, 17020, 0),
    (9, 17021, 0),
    (10, 17026, 0),
    (11, 17028, 0),
    (12, 17029, 0),
    (13, 17030, 0),
    (14, 17031, 0),
    (15, 17032, 0),
    (16, 17033, 0),
    (17, 17034, 0),
    (18, 17035, 0),
    (19, 17036, 0),
    (20, 17037, 0),
    (21, 17038, 0),
    (22, 18567, 0),
    (23, 21099, 0),
    (24, 21177, 0),
    (25, 21219, 0),
    (26, 2320, 0),
    (27, 2321, 0),
    (28, 2324, 0),
    (29, 2325, 0),
    (30, 253665, 0),
    (31, 253668, 0),
    (32, 2604, 0),
    (33, 2605, 0),
    (34, 2678, 0),
    (35, 2692, 0),
    (36, 272941, 0),
    (37, 273636, 0),
    (38, 2880, 0),
    (39, 2901, 0),
    (40, 3466, 0),
    (41, 3713, 0),
    (42, 3857, 0),
    (43, 4289, 0),
    (44, 4291, 0),
    (45, 4340, 0),
    (46, 4341, 0),
    (47, 4342, 0),
    (48, 4357, 4),
    (49, 4364, 3),
    (50, 4399, 0),
    (51, 4400, 0),
    (52, 4470, 0),
    (53, 4471, 0),
    (54, 4536, 0),
    (55, 5565, 0),
    (56, 5956, 0),
    (57, 6256, 0),
    (58, 6260, 0),
    (59, 6261, 0),
    (60, 6529, 0),
    (61, 6530, 0),
    (62, 6532, 0),
    (63, 7005, 0),
    (64, 8343, 0);
START TRANSACTION;
INSERT INTO creature_template (entry,name,faction,npcflag,unit_class,type)
SELECT 242498,'Reagent Bot',35,128,1,9
WHERE NOT EXISTS (SELECT 1 FROM creature_template WHERE entry=242498);
INSERT INTO creature_template_model (CreatureID,Idx,CreatureDisplayID,DisplayScale,Probability)
SELECT 242498,0,15200,1,1
WHERE EXISTS (SELECT 1 FROM creature_template WHERE entry=242498 AND name='Reagent Bot')
AND NOT EXISTS (SELECT 1 FROM creature_template_model WHERE CreatureID=242498);
INSERT INTO creature_template_difficulty (Entry,DifficultyID,CreatureDifficultyID,TypeFlags,TypeFlags2)
SELECT 242498,0,321824,134217728,67108864
WHERE EXISTS (SELECT 1 FROM creature_template WHERE entry=242498 AND name='Reagent Bot')
AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE Entry=242498 AND DifficultyID=0);
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,type,PlayerConditionID,IgnoreFiltering,VerifiedBuild)
SELECT 242498,o.slot,o.item,o.stock,IF(o.stock>0,7200,0),0,1,0,0,0
FROM everlake_reagent_offers o
WHERE EXISTS (SELECT 1 FROM creature_template WHERE entry=242498 AND name='Reagent Bot' AND npcflag&128)
AND NOT EXISTS (
    SELECT 1 FROM npc_vendor v WHERE v.entry=242498 AND (v.slot=o.slot OR v.item<0 OR (v.item=o.item AND v.type=1))
);
COMMIT;
DROP TEMPORARY TABLE everlake_reagent_offers;
