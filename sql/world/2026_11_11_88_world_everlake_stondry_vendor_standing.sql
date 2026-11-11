-- Stondry Darkhammer inventory: https://www.wow-professions.com/forever/npc/stondry-darkhammer
-- Client 70862: PlayerCondition 163213 is ACA Friendly and 163214 is ACA Honored.
UPDATE npc_vendor SET PlayerConditionID = 163213
WHERE entry = 256730 AND type = 1 AND PlayerConditionID = 0 AND ExtendedCost = 11846
  AND (item BETWEEN 251418 AND 251422 OR item BETWEEN 251428 AND 251432);

UPDATE npc_vendor SET PlayerConditionID = 163214
WHERE entry = 256730 AND type = 1 AND PlayerConditionID = 0 AND ExtendedCost = 11847
  AND (item BETWEEN 251413 AND 251417 OR item BETWEEN 251423 AND 251427
    OR item BETWEEN 251433 AND 251437 OR item IN (251465,251466));
