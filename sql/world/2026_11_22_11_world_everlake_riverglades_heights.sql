-- Four Riverglades spawns set onto their ground: Wildplains Patriarch, Dro'zem the Blasphemous, Scaldaron and Clubtoe.
-- 2026_11_22_11_world_everlake_riverglades_heights.sql: written by hand.
--
-- These spawns come from 926, 927 and 983, whose heights were taken from a source point or the lowest floor.
-- The core fork's 2026_11_21_68 (Riverglades spawns on the ground, checked on the server's navmesh) found them off the
-- ground and left them to this repo. The new heights are the surfaces in the server's own maps (tracker tools/height.py
-- --floors, 2026-11-22), at the floor the navmesh points to:
--   920001046 Wildplains Patriarch   18.15 -> 23.03  stood on the lake bed under 5 yards of water; now on the water.
--   920002000 Dro'zem the Blasphemous 49.19 -> 52.95  3.8 yards under the terrain.
--   920002004 Scaldaron              174.21 -> 162.63 on the upper surface, which the navmesh does not walk; the floor below is.
--   920010020 Clubtoe                  7.93 -> 9.62   the lowest cave surface is not walkable; the floor above is.
-- Left alone: object 920001060 (Rotflesh Mushroom) is already on the terrain (118.75); the navmesh's 116.54 would sink it.
-- Each row moves only while it still has the old height. Running it again changes nothing. A later fix is a new file.

UPDATE `creature` SET `position_z` = 23.03
WHERE `guid` = 920001046 AND `id` = 259054 AND `map` = 0 AND `position_z` BETWEEN 18.10 AND 18.20;

UPDATE `creature` SET `position_z` = 52.95
WHERE `guid` = 920002000 AND `id` = 214456 AND `map` = 0 AND `position_z` BETWEEN 49.14 AND 49.24;

UPDATE `creature` SET `position_z` = 162.63
WHERE `guid` = 920002004 AND `id` = 263141 AND `map` = 0 AND `position_z` BETWEEN 174.16 AND 174.26;

UPDATE `creature` SET `position_z` = 9.62
WHERE `guid` = 920010020 AND `id` = 260931 AND `map` = 0 AND `position_z` BETWEEN 7.88 AND 7.98;
