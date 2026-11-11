-- Forever Timbermaw rewards: Meilosh sells both plans.
-- Build 70862 ItemSparse sets 10 gold and Timbermaw Hold Revered on both items.
INSERT INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost, type, VerifiedBuild)
SELECT c.entry, 0, plans.item, 0, 0, 0, 1, 0
FROM creature_template c
CROSS JOIN (SELECT 251469 AS item UNION ALL SELECT 251470) plans
WHERE c.entry = 11557 AND c.name = 'Meilosh' AND (c.npcflag & 128) <> 0
  AND EXISTS (SELECT 1 FROM creature WHERE id = c.entry)
  AND NOT EXISTS (SELECT 1 FROM npc_vendor v WHERE v.entry = c.entry AND v.item = plans.item AND v.type = 1);
