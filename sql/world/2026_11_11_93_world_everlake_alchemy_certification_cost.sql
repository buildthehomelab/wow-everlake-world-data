-- Nina Surefire's Alchemy Certification costs 1,000 Merchant's Favor.
-- https://metammo.com/wow-forever/merchants-favor/nina-surefire
UPDATE npc_vendor SET ExtendedCost = 11522
WHERE entry = 256729 AND item = 271621 AND type = 1
  AND ExtendedCost = 0 AND PlayerConditionID = 0;
