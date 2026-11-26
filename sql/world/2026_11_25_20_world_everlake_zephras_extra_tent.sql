-- Zephras Isle: the extra Camp Tent behind Raan Wildwind's camp is gone.
-- 2026_11_25_20_world_everlake_zephras_extra_tent.sql: written by hand.
--
-- Player report 2026-11-25: Raan Wildwind's camp (map 2991, near 3295, 1913) shows a second tent for no reason. The map
-- itself draws the camp; the second tent is Camp Tent object 528996, guid 52899601 at 3289.62, 1922.55, 838.86 (VerifiedBuild 0).
-- It comes from the core fork's sql/custom/world/2026_11_05_99_world_forever_restore_forever_quest_data.sql. The core's
-- 2026_11_07_80_world_forever_camp_tent_objects.sql had removed all seven 528996 spawns (a dump stored other players'
-- camps as fixed spawns; the sniff has the template only), but the restore file came back with the 2026-11-09 data batch
-- and put them back. Only the Zephras one goes here; the other six camps are left as they are.
-- Deletes by guid, id and map, so it touches nothing else. Running it again changes nothing.

DELETE FROM `gameobject_addon` WHERE `guid` = 52899601;
DELETE FROM `gameobject` WHERE `guid` = 52899601 AND `id` = 528996 AND `map` = 2991;
