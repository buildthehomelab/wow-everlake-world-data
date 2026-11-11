-- Local playtest. XY comes from 11 Forever loot sightings, Z from pinned terrain.
-- Facing and a five-minute respawn are provisional.
-- https://db.icy-veins.com/api/catalog/wowf/gameobject/624265
SET @stolen_tools_ready := EXISTS (
    SELECT 1 FROM gameobject_template WHERE entry = 624265 AND type = 3 AND data1 = 138957
) AND EXISTS (
    SELECT 1 FROM gameobject_loot_template WHERE Entry = 138957 AND ItemType = 0 AND Item = 266897
) AND EXISTS (
    SELECT 1 FROM quest_objectives WHERE QuestID = 94931 AND Type = 1 AND ObjectID = 266897 AND Amount = 8
) AND NOT EXISTS (
    SELECT 1 FROM gameobject WHERE id = 624265 OR guid BETWEEN 62426500 AND 62426510
);
INSERT INTO gameobject
    (guid, id, map, spawnDifficulties, position_x, position_y, position_z, orientation, rotation3, spawntimesecs, state)
SELECT p.guid, 624265, 0, '0', p.x, p.y, p.z, 0, 1, 300, 1
FROM (
    SELECT 62426500 AS guid, -8782.7 AS x, -2730.72 AS y, 201.09 AS z 
    UNION ALL SELECT 62426501, -8798.22, -2733.14, 201.1 
    UNION ALL SELECT 62426502, -8746.17, -2751.09, 197.03 
    UNION ALL SELECT 62426503, -8762.66, -2766.61, 198.7 
    UNION ALL SELECT 62426504, -8712.86, -2784.07, 196.99 
    UNION ALL SELECT 62426505, -8757.48, -2786.98, 197.82 
    UNION ALL SELECT 62426506, -8604.87, -2868.46, 190.21 
    UNION ALL SELECT 62426507, -8581.59, -2891.74, 196.3 
    UNION ALL SELECT 62426508, -8559.93, -2905.32, 196.05 
    UNION ALL SELECT 62426509, -8571.89, -2939.27, 199.23 
    UNION ALL SELECT 62426510, -8536.0, -2979.52, 193.51 
) p
WHERE @stolen_tools_ready;
