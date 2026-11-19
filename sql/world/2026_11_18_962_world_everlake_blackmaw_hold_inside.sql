-- WoW Forever: Blackmaw Hold (map 2974): the hold's inside. 2026_11_18_962_world_everlake_blackmaw_hold_inside.sql.
-- The spawns of the four bosses inside the hold (Elder Shaman Bloodmane and his Devotees, the Unbound Spirit with Elder
-- Bramblesnap, the Blackmaw Behemoth with Clawbert, Varrox Bleakhoof), two rares and seven packs of the main cave, and two
-- teleports that stand in for the way down to Varrox and back up until the fights' script does it.
-- The templates are 2026_11_18_961's: a spawn is added only where its template exists and its guid is free. Safe to run
-- again; every added row is recorded in everlake_import_rows. Never edit this file once deployed: a later fix is a new file.
--
-- Real data: the hold is one cave model (spawn 65469469 of map 2974); its floors, read from Everlake's own vmaps
-- (ForeverTracker ft.terrain: every surface of that model with at least 3 yards of headroom), fall into separate rooms:
-- a wide low chamber (z ~132), a room to the north-east (z ~219), a room to the west (z ~274), a deep cave (z -105..-23)
-- and the main cave joining them. The guides (Warcraft Tavern, WoW Handbook, Zockify) give the route: east and down to
-- Bloodmane's wide chamber, north and down a ramp to the Behemoth, a pool behind it (south) dropping to Varrox, a side
-- passage south to the Unbound Spirit's clearing.
-- INFERRED: which room is which (matched by direction and depth), every spawn spot and pack, and the two teleports: the
-- live dungeon drops players through a pool and lifts them back on an air stream; these server area triggers do the same
-- trip from the Behemoth room's south edge and from the far side of Varrox's cave.

CREATE TABLE IF NOT EXISTS `everlake_import_rows` (
  `tbl` varchar(64) NOT NULL COMMENT 'world table of the row',
  `k1` bigint NOT NULL COMMENT 'the row''s key, in the table''s primary key order',
  `k2` bigint NOT NULL DEFAULT '0',
  `k3` bigint NOT NULL DEFAULT '0',
  `k4` bigint NOT NULL DEFAULT '0',
  `file` varchar(200) NOT NULL COMMENT 'the update file that added the row',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT 'the sources that gave it',
  PRIMARY KEY (`tbl`, `k1`, `k2`, `k3`, `k4`),
  KEY `file` (`file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added (docs/forever-import.md)';

SET @EVERLAKE_FILE := '2026_11_18_962_world_everlake_blackmaw_hold_inside.sql';
SET @EVERLAKE_NOTE := 'rooms from Everlake vmaps (cave model 65469469); route from public guides; every spot INFERRED';
START TRANSACTION;

-- Blackmaw Behemoth (247207): 1 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247207, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000100 AS `guid`, 3665 AS `x`, 2905 AS `y`, 248.9 AS `z`, 2.078 AS `o` -- the Behemoth in the room past the ramp (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247207) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 247207 AND c.`guid` BETWEEN 974000100 AND 974000100;

-- Elder Shaman Bloodmane (247209): 1 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247209, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000101 AS `guid`, 3495 AS `x`, 3165 AS `y`, 123.8 AS `z`, 3.221 AS `o` -- Bloodmane in the wide low chamber (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247209) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 247209 AND c.`guid` BETWEEN 974000101 AND 974000101;

-- Unbound Spirit (247231): 1 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247231, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000102 AS `guid`, 3265 AS `x`, 2920 AS `y`, 273.7 AS `z`, 2.103 AS `o` -- the Unbound Spirit in its clearing (the west room down the south passage) (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247231) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 247231 AND c.`guid` BETWEEN 974000102 AND 974000102;

-- Varrox Bleakhoof (247234): 1 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247234, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000103 AS `guid`, 3405 AS `x`, 2945 AS `y`, -101.3 AS `z`, 5.387 AS `o` -- Varrox in the cave under the pool (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247234) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 247234 AND c.`guid` BETWEEN 974000103 AND 974000103;

-- Legashi Subjugator (247235): 4 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247235, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000104 AS `guid`, 3400 AS `x`, 2885 AS `y`, 214.2 AS `z`, 0.576 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000105 AS `guid`, 3395 AS `x`, 2880 AS `y`, 215.3 AS `z`, 0.592 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000106 AS `guid`, 3440 AS `x`, 2850 AS `y`, 205.6 AS `z`, 1.197 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000107 AS `guid`, 3500 AS `x`, 3040 AS `y`, 146.2 AS `z`, 4.46 AS `o` -- a pack in the main cave (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247235) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 247235 AND c.`guid` BETWEEN 974000104 AND 974000107;

-- Blackmaw Berserker (247237): 4 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247237, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000108 AS `guid`, 3300 AS `x`, 2895 AS `y`, 206.1 AS `z`, 0.211 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000109 AS `guid`, 3295 AS `x`, 2900 AS `y`, 205.9 AS `z`, 0.178 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000110 AS `guid`, 3310 AS `x`, 2935 AS `y`, 203.6 AS `z`, 6.264 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000111 AS `guid`, 3305 AS `x`, 2930 AS `y`, 203.6 AS `z`, 0.011 AS `o` -- a pack in the main cave (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247237) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 247237 AND c.`guid` BETWEEN 974000108 AND 974000111;

-- Legashi Summoner (247248): 4 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247248, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000112 AS `guid`, 3405 AS `x`, 2845 AS `y`, 210.5 AS `z`, 0.913 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000113 AS `guid`, 3410 AS `x`, 2840 AS `y`, 209.4 AS `z`, 0.976 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000114 AS `guid`, 3465 AS `x`, 3060 AS `y`, 164.8 AS `z`, 4.768 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000115 AS `guid`, 3470 AS `x`, 3065 AS `y`, 165.5 AS `z`, 4.729 AS `o` -- a pack in the main cave (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247248) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 247248 AND c.`guid` BETWEEN 974000112 AND 974000115;

-- Clawbert (247996): 1 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247996, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000116 AS `guid`, 3660 AS `x`, 2905 AS `y`, 249.6 AS `z`, 0.423 AS `o` -- Clawbert beside the Behemoth (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247996) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 247996 AND c.`guid` BETWEEN 974000116 AND 974000116;

-- Elder Bramblesnap (248765): 1 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 248765, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000117 AS `guid`, 3255 AS `x`, 2910 AS `y`, 273.7 AS `z`, 0.874 AS `o` -- Elder Bramblesnap at the clearing, to start the ritual (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 248765) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 248765 AND c.`guid` BETWEEN 974000117 AND 974000117;

-- Tunnelweb Matriarch (250034): 1 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 250034, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000118 AS `guid`, 3415 AS `x`, 3055 AS `y`, 259.3 AS `z`, 5.147 AS `o` -- Tunnelweb Matriarch in the main cave (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 250034) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 250034 AND c.`guid` BETWEEN 974000118 AND 974000118;

-- Legashi Slayer (255347): 4 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 255347, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000119 AS `guid`, 3550 AS `x`, 2985 AS `y`, 144.8 AS `z`, 3.74 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000120 AS `guid`, 3520 AS `x`, 2825 AS `y`, 223.3 AS `z`, 1.992 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000121 AS `guid`, 3340 AS `x`, 2880 AS `y`, 208.6 AS `z`, 0.374 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000122 AS `guid`, 3335 AS `x`, 2885 AS `y`, 208.4 AS `z`, 0.329 AS `o` -- a pack in the main cave (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 255347) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 255347 AND c.`guid` BETWEEN 974000119 AND 974000122;

-- Blackmaw Champion (255394): 4 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 255394, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000123 AS `guid`, 3620 AS `x`, 2895 AS `y`, 172.1 AS `z`, 2.897 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000124 AS `guid`, 3625 AS `x`, 2890 AS `y`, 172.1 AS `z`, 2.874 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000125 AS `guid`, 3345 AS `x`, 2985 AS `y`, 231.4 AS `z`, 5.888 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000126 AS `guid`, 3340 AS `x`, 2990 AS `y`, 231.6 AS `z`, 5.869 AS `o` -- a pack in the main cave (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 255394) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 255394 AND c.`guid` BETWEEN 974000123 AND 974000126;

-- Blackmaw Shaman (258508): 4 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 258508, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000127 AS `guid`, 3620 AS `x`, 3065 AS `y`, 322.2 AS `z`, 3.875 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000128 AS `guid`, 3625 AS `x`, 3070 AS `y`, 322.2 AS `z`, 3.876 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000129 AS `guid`, 3560 AS `x`, 3120 AS `y`, 184.0 AS `z`, 4.275 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000130 AS `guid`, 3565 AS `x`, 3125 AS `y`, 184.4 AS `z`, 4.264 AS `o` -- a pack in the main cave (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 258508) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 258508 AND c.`guid` BETWEEN 974000127 AND 974000130;

-- Legashi Plaguebringer (268864): 3 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 268864, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000131 AS `guid`, 3660 AS `x`, 2865 AS `y`, 172.1 AS `z`, 2.799 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000132 AS `guid`, 3655 AS `x`, 2870 AS `y`, 172.1 AS `z`, 2.815 AS `o` -- a pack in the main cave (INFERRED spot)
  UNION ALL
  SELECT 974000133 AS `guid`, 3690 AS `x`, 2945 AS `y`, 191.0 AS `z`, 3.202 AS `o` -- a pack in the main cave (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 268864) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 268864 AND c.`guid` BETWEEN 974000131 AND 974000133;

-- Gortek the Apprentice (269111): 1 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 269111, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000134 AS `guid`, 3585 AS `x`, 2950 AS `y`, 172.2 AS `z`, 3.301 AS `o` -- Gortek, near the way down to the Behemoth (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 269111) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 269111 AND c.`guid` BETWEEN 974000134 AND 974000134;

-- Blackmaw Devotee (277474): 6 spawn(s)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 277474, 2974, 16554, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974000135 AS `guid`, 3505 AS `x`, 3160 AS `y`, 123.7 AS `z`, 2.909 AS `o` -- Blackmaw Devotees around Bloodmane (the guides: kill them first) (INFERRED spot)
  UNION ALL
  SELECT 974000136 AS `guid`, 3510 AS `x`, 3165 AS `y`, 123.6 AS `z`, 3.17 AS `o` -- Blackmaw Devotees around Bloodmane (the guides: kill them first) (INFERRED spot)
  UNION ALL
  SELECT 974000137 AS `guid`, 3480 AS `x`, 3155 AS `y`, 124.6 AS `z`, 0.951 AS `o` -- Blackmaw Devotees around Bloodmane (the guides: kill them first) (INFERRED spot)
  UNION ALL
  SELECT 974000138 AS `guid`, 3515 AS `x`, 3160 AS `y`, 123.5 AS `z`, 2.99 AS `o` -- Blackmaw Devotees around Bloodmane (the guides: kill them first) (INFERRED spot)
  UNION ALL
  SELECT 974000139 AS `guid`, 3515 AS `x`, 3170 AS `y`, 123.5 AS `z`, 3.339 AS `o` -- Blackmaw Devotees around Bloodmane (the guides: kill them first) (INFERRED spot)
  UNION ALL
  SELECT 974000140 AS `guid`, 3520 AS `x`, 3165 AS `y`, 123.5 AS `z`, 3.162 AS `o` -- Blackmaw Devotees around Bloodmane (the guides: kill them first) (INFERRED spot)
) s WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 277474) AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE c.`id` = 277474 AND c.`guid` BETWEEN 974000135 AND 974000140;

-- the way down to Varrox and back up (INFERRED stand-ins for the pool and the air stream): safe locations 1104142 (in
-- front of Varrox) and 1104143 (the Behemoth's room); custom area triggers 2976 (down) and 2977 (up), 2.5-yard spheres
INSERT INTO `world_safe_locs` (`ID`, `MapID`, `LocX`, `LocY`, `LocZ`, `Facing`, `Comment`)
SELECT * FROM (SELECT 1104142 AS `ID`, 2974 AS `MapID`, 3395 AS `LocX`, 2955 AS `LocY`, -101.6 AS `LocZ`, 2.2 AS `Facing`, 'Blackmaw Hold (dungeon) - in front of Varrox Bleakhoof (INFERRED spot)' AS `Comment`
  UNION ALL SELECT 1104143, 2974, 3680, 2905, 245.8, 3.14, 'Blackmaw Hold (dungeon) - back up by the Blackmaw Behemoth (INFERRED spot)') s
WHERE NOT EXISTS (SELECT 1 FROM `world_safe_locs` x WHERE x.`ID` = s.`ID`);
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `ActionSetId`, `ActionSetFlags`, `VerifiedBuild`)
SELECT * FROM (SELECT 2976 AS `Id`, 1 AS `IsCustom`, 0 AS `Flags`, 0 AS `ActionSetId`, 0 AS `ActionSetFlags`, 0 AS `VerifiedBuild` UNION ALL SELECT 2977, 1, 0, 0, 0, 0) s
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger_template` x WHERE x.`Id` = s.`Id` AND x.`IsCustom` = 1);
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`, `IsCustom`, `ActionType`, `ActionParam`, `TargetType`)
SELECT * FROM (SELECT 2976 AS `AreaTriggerId`, 1 AS `IsCustom`, 2 AS `ActionType`, 1104142 AS `ActionParam`, 5 AS `TargetType` UNION ALL SELECT 2977, 1, 2, 1104143, 5) s
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger_template_actions` x WHERE x.`AreaTriggerId` = s.`AreaTriggerId` AND x.`IsCustom` = 1);
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Shape`, `ShapeData0`, `ShapeData1`)
SELECT * FROM (SELECT 2976 AS `Id`, 1 AS `IsCustom`, 2976 AS `AreaTriggerId`, 1 AS `IsAreatriggerCustom`, 0 AS `Shape`, 2.5 AS `ShapeData0`, 2.5 AS `ShapeData1` UNION ALL SELECT 2977, 1, 2977, 1, 0, 2.5, 2.5) s
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger_create_properties` x WHERE x.`Id` = s.`Id` AND x.`IsCustom` = 1);
INSERT INTO `areatrigger` (`SpawnId`, `AreaTriggerCreatePropertiesId`, `IsCustom`, `MapId`, `SpawnDifficulties`, `PosX`, `PosY`, `PosZ`, `Orientation`, `PhaseUseFlags`, `PhaseId`, `PhaseGroup`, `ScriptName`, `Comment`, `VerifiedBuild`)
SELECT * FROM (SELECT 2976 AS `SpawnId`, 2976 AS `P`, 1 AS `C`, 2974 AS `M`, '1' AS `D`, 3640 AS `X`, 2910 AS `Y`, 247.2 AS `Z`, 0 AS `O`, 1 AS `F`, 0 AS `PI`, 0 AS `PG`, '' AS `S`, 'Blackmaw Hold - down to Varrox (INFERRED stand-in for the pool)' AS `N`, 0 AS `V`
  UNION ALL SELECT 2977, 2977, 1, 2974, '1', 3435, 2900, -92.7, 0, 1, 0, 0, '', 'Blackmaw Hold - back up to the Behemoth (INFERRED stand-in for the air stream)', 0) s
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger` x WHERE x.`SpawnId` = s.`SpawnId`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) VALUES
('world_safe_locs', 1104142, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE), ('world_safe_locs', 1104143, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE),
('areatrigger', 2976, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE), ('areatrigger', 2977, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE);

COMMIT;
