-- Forever Guides lists both 270-Favor schematics at Honored.
UPDATE npc_vendor SET PlayerConditionID = 163214
WHERE entry = 256733 AND type = 1 AND PlayerConditionID = 0
  AND ExtendedCost = 11862 AND item IN (264221,264222);
