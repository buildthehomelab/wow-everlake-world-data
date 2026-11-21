-- Two Camp Tents (object 528996) set onto the ground: Kharanos no longer floats, Durotar no longer sinks.
-- 2026_11_20_39_world_everlake_camp_tent_heights.sql: written by hand.
--
-- Player report 2026-11-20: the tent of the Kharanos camp (Dun Morogh) floats. The core fork's
-- sql/custom/world/2026_11_05_99_world_forever_restore_forever_quest_data.sql spawns seven Camp Tents (guids 52899600-606).
-- The live realm has 52899606 at -5651.02, -492.97, z 397.85 (read on the server 2026-11-20). The server's own maps
-- (tracker tools/height.py) put flat terrain there at 396.52-396.70 within 2 yards, 396.60 under the tent, so it hung
-- 1.25 yards up. 52899602 (Durotar, 137.48, -4704.5) sits at z 16.23 on flat terrain at 18.60, 2.37 yards under ground.
-- The other five are within 0.6 yards of their ground (or on uneven ground) and stay as they are.
-- Each row moves only while it still has the old height. Running it again changes nothing. A later fix is a new file.

UPDATE `gameobject` SET `position_z` = 396.60
WHERE `guid` = 52899606 AND `id` = 528996 AND `map` = 0 AND `position_z` BETWEEN 397.80 AND 397.90;

UPDATE `gameobject` SET `position_z` = 18.60
WHERE `guid` = 52899602 AND `id` = 528996 AND `map` = 1 AND `position_z` BETWEEN 16.18 AND 16.28;
