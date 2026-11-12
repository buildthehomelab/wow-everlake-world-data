-- Local playtest placement from captured map 0 XY and build 70790 terrain Z.
-- Gray Ram uses the sighting near the existing Brown and White Ram spawns.
-- Facing is provisional. Chestnut Mare gets a spawn-specific gossip flag.
INSERT INTO creature
    (guid,id,map,position_x,position_y,position_z,orientation,npcflag)
SELECT s.guid,s.id,0,s.x,s.y,s.z,0,t.npcflag | 1
FROM (
    SELECT 26747500 AS guid,267475 AS id,-5535 AS x,-1347 AS y,398.66 AS z
    UNION ALL SELECT 26767700,267677,-9442.5,-1387,46.97
) s
JOIN creature_template t ON t.entry=s.id
WHERE NOT EXISTS (SELECT 1 FROM creature WHERE id=s.id OR guid=s.guid);
