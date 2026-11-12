-- Forever prize prices observed at Gelvas Grimegate.
-- https://www.icy-veins.com/wow-forever/news/damage-buff-and-14-slot-bag-the-forever-darkmoon-faire-is-in-town/
-- Costs 11744–11749 use Darkmoon Prize Ticket currency (515).
UPDATE npc_vendor
SET ExtendedCost = CASE item WHEN 19291 THEN 11748 WHEN 19295 THEN 11744 END
WHERE entry = 14828 AND type = 1
  AND (item, ExtendedCost) IN ((19291, 3816), (19295, 3818));

INSERT INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost, type, VerifiedBuild)
SELECT t.entry, 0, prizes.item, 0, 0, prizes.cost, 1, 0
FROM creature_template t
CROSS JOIN (
    SELECT 19292 AS item, 11745 AS cost
    UNION ALL SELECT 19293, 11748
    UNION ALL SELECT 19296, 11747
    UNION ALL SELECT 19297, 11746
    UNION ALL SELECT 19298, 11744
    UNION ALL SELECT 19426, 11749
    UNION ALL SELECT 19491, 11749
) prizes
WHERE t.entry = 14828 AND (t.npcflag & 128) <> 0
  AND EXISTS (
      SELECT 1 FROM creature c JOIN game_event_creature e ON e.guid = c.guid
      WHERE c.id = t.entry AND e.eventEntry IN (4, 5)
  )
  AND NOT EXISTS (
      SELECT 1 FROM npc_vendor v WHERE v.entry = t.entry AND v.item = prizes.item AND v.type = 1
  );
