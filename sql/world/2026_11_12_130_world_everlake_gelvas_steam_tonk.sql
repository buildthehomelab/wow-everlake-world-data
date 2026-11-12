-- Forever player vendor observations place schematic 22729 on Gelvas Grimegate.
-- https://ahledger.com/wow-forever/npcs/14828-gelvas-grimegate
-- Forever vendor listing shows 40 tickets. Pinned ItemExtendedCost 11747
-- charges 40 Darkmoon Prize Tickets (currency 515).
INSERT INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost, type, VerifiedBuild)
SELECT t.entry, 0, 22729, 0, 0, 11747, 1, 0
FROM creature_template t
WHERE t.entry = 14828
  AND (t.npcflag & 128) <> 0
  AND EXISTS (
      SELECT 1
      FROM creature c
      JOIN game_event_creature e ON e.guid = c.guid
      WHERE c.id = t.entry AND e.eventEntry IN (4, 5)
  )
  AND NOT EXISTS (
      SELECT 1 FROM npc_vendor v WHERE v.entry = t.entry AND v.item = 22729 AND v.type = 1
  );
