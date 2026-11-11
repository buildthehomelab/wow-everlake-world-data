-- Wow Professions lists these offers at Azeroth Commerce Authority Honored.
-- Client 1.60.1.70862 PlayerCondition 163214 requires faction 2586 at rank 5.
UPDATE npc_vendor
SET PlayerConditionID = 163214
WHERE type = 1 AND PlayerConditionID = 0
  AND (
    (entry = 256730 AND item IN (251447,251448,251449,251471) AND ExtendedCost = 11848)
    OR (entry = 256733 AND item IN (264234,264237) AND ExtendedCost = 11863)
  );
