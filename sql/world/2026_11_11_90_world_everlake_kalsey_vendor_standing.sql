-- WoW Professions lists both vendor counterparts with the same standing tiers.
UPDATE npc_vendor SET PlayerConditionID = 163213
WHERE entry = 256731 AND type = 1 AND PlayerConditionID = 0
  AND ExtendedCost = 11871 AND item IN (249888,249889);

UPDATE npc_vendor SET PlayerConditionID = 163214
WHERE entry = 256731 AND type = 1 AND PlayerConditionID = 0
  AND ExtendedCost = 11872 AND item = 249890;
