-- Greater Tarantula 271898 (Alther's Mill): level 18-19, as live Forever has it.
-- 2026_11_23_06_world_everlake_greater_tarantula_level.sql: written by hand.
--
-- The realm holds it at level 19 only. Wowhead's Forever page gives 18-19 and QuestieDB's traces give 18-19; Icy
-- Veins' players recorded 17 to 19. Taken as the two that agree. The old Greater Tarantula (505) stays 19-20.
--
-- Sources: Wowhead's Forever database through the ForeverTracker's page cache (the level only); QuestieDB (GPL-3.0).
-- Changes the row only while it is still 19-19. Running it again changes nothing. Never edit this file once it is
-- deployed: a later fix is a new file.

UPDATE `creature_classic_level` SET `level_min` = 18
WHERE `entry` = 271898 AND `level_min` = 19 AND `level_max` = 19;
