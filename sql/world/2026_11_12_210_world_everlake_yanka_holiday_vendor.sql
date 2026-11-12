-- Darkcaller Yanka's Forsaken Stink Bomb Cluster inventory is on the Hallow's End spawn.
UPDATE creature_template t
SET t.npcflag=t.npcflag|128
WHERE t.entry=15197 AND t.name='Darkcaller Yanka' AND t.npcflag=3
 AND EXISTS (SELECT 1 FROM npc_vendor v WHERE v.entry=t.entry AND v.item=20387 AND v.type=1)
 AND EXISTS (SELECT 1 FROM creature c JOIN game_event_creature e ON e.guid=c.guid
             WHERE c.id=t.entry AND c.npcflag IS NULL AND e.eventEntry=12)
 AND NOT EXISTS (SELECT 1 FROM creature c WHERE c.id=t.entry
                 AND NOT EXISTS (SELECT 1 FROM game_event_creature e WHERE e.guid=c.guid AND e.eventEntry=12));
