-- Forever Guides lists both Fizzlefuse schematics at 270 Merchant's Favor and Honored.
-- Client 70862: extended cost 11862 and Durotar Supply and Logistics condition 163218.
UPDATE npc_vendor
SET ExtendedCost = 11862, PlayerConditionID = 163218
WHERE entry = 248200 AND type = 1 AND item IN (264221,264222)
  AND ExtendedCost = 0 AND PlayerConditionID = 0;
