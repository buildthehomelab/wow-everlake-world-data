-- Alynsia inventory: https://www.wow-professions.com/forever/npc/alynsia
-- The matching Beneris offers corroborate the standing tiers.
UPDATE npc_vendor SET PlayerConditionID = 163213
WHERE entry = 256732 AND type = 1 AND PlayerConditionID = 0 AND ExtendedCost = 11841
  AND (item BETWEEN 249493 AND 249496 OR item BETWEEN 249502 AND 249510);

UPDATE npc_vendor SET PlayerConditionID = 163214
WHERE entry = 256732 AND type = 1 AND PlayerConditionID = 0
  AND ((ExtendedCost = 11842 AND item = 249537)
    OR (ExtendedCost = 11843 AND item IN (
      249525,249526,249529,249530,249532,249534,249535,249536,249538,249539,
      274393,274394,274398,274399,274401
    )));
