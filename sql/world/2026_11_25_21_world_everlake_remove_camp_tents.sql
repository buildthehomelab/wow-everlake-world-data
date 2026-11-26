-- The remaining Camp Tents (object 528996) at the adventurer camps are removed: Goldshire, Brill, Kharanos, Razor Hill,
-- Bloodhoof and Dolanaar.
-- 2026_11_25_21_world_everlake_remove_camp_tents.sql: written by hand.
--
-- These are other players' camps that a data dump stored as fixed spawns (the sniff has the template only, no spawn).
-- The core fork's sql/custom/world/2026_11_07_80_world_forever_camp_tent_objects.sql removed all seven, but
-- 2026_11_05_99_world_forever_restore_forever_quest_data.sql (guids 52899600-606) came back with the 2026-11-09 data
-- batch and put them back. 2026_11_25_20 already removed the Zephras Isle one (52899601); this removes every spawn of
-- the object that is left, so it also replaces the height and facing fixes of 2026_11_20_39 and 2026_11_20_40.
-- Running it again changes nothing.

DELETE FROM `gameobject_addon` WHERE `guid` IN (SELECT `guid` FROM `gameobject` WHERE `id` = 528996);
DELETE FROM `gameobject` WHERE `id` = 528996;
