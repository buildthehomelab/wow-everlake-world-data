-- Boyle already stocks Nutritious Slime Sludge for WRIGGLE. but lacks the vendor flag.
-- https://db.icy-veins.com/api/catalog/wowf/item/278265
UPDATE creature_template t
SET t.npcflag = t.npcflag | 128
WHERE t.entry = 4612 AND t.name = 'Boyle' AND (t.npcflag & 128) = 0
  AND EXISTS (SELECT 1 FROM creature WHERE id = t.entry AND map = 0 AND npcflag IS NULL)
  AND EXISTS (SELECT 1 FROM npc_vendor WHERE entry = t.entry AND item = 278265 AND type = 1);
