-- METAMMO vendor captures list both certifications at 1,000 Merchant's Favor.
-- Build 70862 extended cost 11522 matches the existing Horde offers.
UPDATE npc_vendor SET ExtendedCost = 11522
WHERE type = 1 AND ExtendedCost = 0 AND PlayerConditionID = 0
  AND ((entry = 256734 AND item = 271626) OR (entry = 256735 AND item = 271627));
