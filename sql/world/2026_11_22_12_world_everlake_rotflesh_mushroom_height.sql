-- Riverglades: the Rotflesh Mushroom object 920001060 set to the core fork's navmesh height.
-- 2026_11_22_12_world_everlake_rotflesh_mushroom_height.sql: written by hand.
--
-- The core fork's Karrz 0.1.39 port (2026_11_21_68, server navmesh, 2026-11-21) puts it at 116.54, 2.2 yards under the
-- 118.75 that 926 gave it (the terrain height in the server's maps at that exact point). Taken as Karrz has it.
-- Moves only while it still has the old height. Running it again changes nothing. A later fix is a new file.

UPDATE `gameobject` SET `position_z` = 116.54
WHERE `guid` = 920001060 AND `id` = 630588 AND `map` = 0 AND `position_z` BETWEEN 118.70 AND 118.80;
