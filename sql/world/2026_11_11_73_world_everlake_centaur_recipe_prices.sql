-- Forever quartermaster rosters: native recipes cost 15 totems at Honored.
-- Opposing-clan recipes cost 60 totems at Exalted.
UPDATE npc_vendor v
JOIN npc_vendor gelkis ON gelkis.entry=253140 AND gelkis.item=v.item AND gelkis.type=1
    AND gelkis.ExtendedCost IN (10962,10963)
JOIN creature_template c ON c.entry=v.entry AND c.name='Gorhak'
SET v.ExtendedCost=IF(gelkis.ExtendedCost=10962,10963,10962),
    v.PlayerConditionID=IF(gelkis.ExtendedCost=10962,146127,146125)
WHERE v.entry=253139 AND v.type=1 AND v.ExtendedCost=0 AND v.PlayerConditionID=0
  AND v.item IN (249486,249489,250979,250985,251390,251458,252833,253974,254682,269901,269903,274491);

UPDATE npc_vendor v
JOIN creature_template c ON c.entry=v.entry AND c.name='Molkar'
SET v.PlayerConditionID=IF(v.ExtendedCost=10962,146129,146131)
WHERE v.entry=253140 AND v.type=1 AND v.ExtendedCost IN (10962,10963) AND v.PlayerConditionID=0
  AND v.item IN (249486,249489,250979,250985,251390,251458,252833,253974,254682,269901,269903,274491);
