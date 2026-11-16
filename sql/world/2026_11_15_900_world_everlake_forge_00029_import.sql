-- Everlake Forge #29: Import, 1 resource(s), 96 row(s)
-- Applied on the test realm as the tracker's Forge operation #28; numbered 29 here, the next free number of this repository.
-- 2026_11_15_900_world_everlake_forge_00029_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70938) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Classic database 2026-11-15: Lunar Festival (NOTICE.md, Forge exports).
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing: a row is added only
-- where none exists, spawns only where the same creature or object is not already within 5 yards, and each added row is recorded in everlake_import_rows.

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

START TRANSACTION;
-- gameobject: 6 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `gameobject` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(910280000, 180871, 1, 0, 0, '0', 0, 0, 0, -1, -1024.76, -237.99, 160.384, 1.95477, 0, 0, 0.829038, 0.559193, 180, 255, 1, '', NULL, 70938),
(910280001, 180859, 1, 0, 0, '0', 0, 0, 0, -1, 7531.66, -2851.23, 458.917, 2.40855, 0, 0, 0.93358, 0.35837, 180, 255, 1, '', NULL, 70938),
(910280002, 180859, 1, 0, 0, '0', 0, 0, 0, -1, 7561.15, -2872.45, 461.1, 2.58308, 0, 0, 0.961261, 0.275641, 180, 255, 1, '', NULL, 70938),
(910280003, 180766, 1, 0, 0, '0', 0, 0, 0, -1, 7451.17, -2814.08, 462.273, 2.91468, 0, 0, 0.993571, 0.113211, 25, 255, 1, '', NULL, 70938),
(910280004, 180774, 1, 0, 0, '0', 0, 0, 0, -1, 7570, -2903.24, 462.297, 4.6816, 0, 0, 0.71791, -0.696136, 25, 255, 1, '', NULL, 70938),
(910280005, 180774, 1, 0, 0, '0', 0, 0, 0, -1, 7562.98, -2903.09, 462.297, 4.6816, 0, 0, 0.71791, -0.696136, 25, 255, 1, '', NULL, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject` x ON x.`id` = s.`id` AND x.`map` = s.`map` AND (x.`position_x` - s.`position_x`) * (x.`position_x` - s.`position_x`) + (x.`position_y` - s.`position_y`) * (x.`position_y` - s.`position_y`) <= 25;
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject` x ON x.`guid` = s.`guid`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `gameobject_template` p WHERE p.`entry` = `everlake_forge_stage`.`id`);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', s.`guid`, 0, 0, 0, '2026_11_15_900_world_everlake_forge_00029_import.sql', 'Forge #29: Classic database 2026-11-15: Lunar Festival' FROM `everlake_forge_stage` s;

-- creature: 42 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `creature` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(910280000, 15605, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 2809.42, -298.311, 109.197, 2.2124, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280001, 15557, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -7955.99, -2701.6, 190.629, 0.1448, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280002, 15558, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -5339.71, -2900.36, 343.356, 4.4186, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280003, 15565, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -9391.43, 142.467, 61.1422, 3.0257, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280004, 15582, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -869.407, -3730.32, 22.565, 4.417, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280005, 15600, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 2459.51, -6956.14, 111.238, 1.7612, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280006, 15588, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -2300.68, -1946.13, 96.2758, 4.1311, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280007, 15587, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -3801.35, 1092.59, 131.969, 6.2452, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280008, 15575, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -2104.57, -446.089, -8.0803, 4.4121, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280009, 15603, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 5101.63, -522.688, 335.06, 4.5372, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280010, 15570, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -6202.55, 1801.27, 19.3972, 0.6596, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280011, 15586, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -7116.61, -3780.11, 8.6701, 0.2956, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280012, 15573, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -9560.5, -2700.24, 12.281, 0.9208, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280013, 15584, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -5433.37, -2425.91, 89.6587, 0.4852, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280014, 15604, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -6234.48, -3941.96, -58.751, 0.9729, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280015, 15563, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -11793.4, -3181.84, -30.2682, 1.1549, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280016, 15569, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -5570.76, -497.917, 401.813, 1.7426, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280017, 15576, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -14424.6, 531.775, 24.88, 5.1662, 180, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280018, 15895, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 10140.4, 2579.71, 1323.37, 4.387, 600, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280019, 15898, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 10141.7, 2604.31, 1330.83, 6.1735, 600, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280020, 15893, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 10150.9, 2602.31, 1330.91, 2.4784, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280021, 15894, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 10150.8, 2602.45, 1330.91, 6.2308, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280022, 15892, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 10149.8, 2607.96, 1330.83, 4.8418, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280023, 15892, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 10155.8, 2601.27, 1330.83, 2.8211, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280024, 15892, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 10145.7, 2598.17, 1330.83, 0.7673, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280025, 15567, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -7274.65, -801.765, 296.871, 6.1468, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280026, 15961, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 7929.99, -2605.03, 492.776, 5.5327, 180, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280027, 15961, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 7924.09, -2637.73, 492.761, 0.4712, 180, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280028, 15893, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -8747.91, 1074.12, 90.5812, 3.3161, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280029, 15894, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -8747.84, 1074.33, 90.5931, 1.9722, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280030, 15893, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -4662.63, -957.069, 500.46, 4.8695, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280031, 15894, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -4662.78, -956.093, 500.46, 4.7298, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280032, 15893, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 1984.01, -4255.16, 31.738, 3.8223, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280033, 15894, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 1985.07, -4254.62, 31.719, 0.0175, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280034, 15893, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, 1641.9, 239.936, 62.6749, 3.6303, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280035, 15894, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, 1641.95, 239.918, 62.6749, 3.1241, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280036, 15893, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -1031.85, -230.388, 160.254, 2.2689, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280037, 15894, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -1031.9, -230.491, 160.245, 2.618, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280038, 15560, 229, 0, 0, '0', 0, 0, 0, -1, 0, 0, 31.5467, -401.319, 48.6986, 1.6841, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280039, 15549, 230, 0, 0, '0', 0, 0, 0, -1, 0, 0, 592.67, -190.145, -54.0991, 0.2227, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280040, 15607, 329, 0, 0, '0', 0, 0, 0, -1, 0, 0, 3708.25, -3453.13, 130.554, 5.862, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910280041, 15556, 349, 0, 0, '0', 0, 0, 0, -1, 0, 0, -7.671, -246.622, -168.102, 3.2848, 25, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `creature` x ON x.`id` = s.`id` AND x.`map` = s.`map` AND (x.`position_x` - s.`position_x`) * (x.`position_x` - s.`position_x`) + (x.`position_y` - s.`position_y`) * (x.`position_y` - s.`position_y`) <= 25;
DELETE s FROM `everlake_forge_stage` s JOIN `creature` x ON x.`guid` = s.`guid`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`id`);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`) SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature', s.`guid`, 0, 0, 0, '2026_11_15_900_world_everlake_forge_00029_import.sql', 'Forge #29: Classic database 2026-11-15: Lunar Festival' FROM `everlake_forge_stage` s;

-- game_event_gameobject: 6 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `eventEntry`, `guid` FROM `game_event_gameobject` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`eventEntry`, `guid`) VALUES
(7, 910280000),
(7, 910280001),
(7, 910280002),
(7, 910280003),
(7, 910280004),
(7, 910280005);
DELETE s FROM `everlake_forge_stage` s JOIN `game_event_gameobject` x ON x.`guid` <=> s.`guid` AND x.`eventEntry` <=> s.`eventEntry`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `gameobject` p WHERE p.`guid` = `everlake_forge_stage`.`guid`);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) SELECT `eventEntry`, `guid` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'game_event_gameobject', s.`guid`, s.`eventEntry`, 0, 0, '2026_11_15_900_world_everlake_forge_00029_import.sql', 'Forge #29: Classic database 2026-11-15: Lunar Festival' FROM `everlake_forge_stage` s;

-- game_event_creature: 42 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `eventEntry`, `guid` FROM `game_event_creature` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`eventEntry`, `guid`) VALUES
(7, 910280000),
(7, 910280001),
(7, 910280002),
(7, 910280003),
(7, 910280004),
(7, 910280005),
(7, 910280006),
(7, 910280007),
(7, 910280008),
(7, 910280009),
(7, 910280010),
(7, 910280011),
(7, 910280012),
(7, 910280013),
(7, 910280014),
(7, 910280015),
(7, 910280016),
(7, 910280017),
(7, 910280018),
(7, 910280019),
(7, 910280020),
(7, 910280021),
(7, 910280022),
(7, 910280023),
(7, 910280024),
(7, 910280025),
(7, 910280026),
(7, 910280027),
(7, 910280028),
(7, 910280029),
(7, 910280030),
(7, 910280031),
(7, 910280032),
(7, 910280033),
(7, 910280034),
(7, 910280035),
(7, 910280036),
(7, 910280037),
(7, 910280038),
(7, 910280039),
(7, 910280040),
(7, 910280041);
DELETE s FROM `everlake_forge_stage` s JOIN `game_event_creature` x ON x.`guid` <=> s.`guid` AND x.`eventEntry` <=> s.`eventEntry`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature` p WHERE p.`guid` = `everlake_forge_stage`.`guid`);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) SELECT `eventEntry`, `guid` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'game_event_creature', s.`guid`, s.`eventEntry`, 0, 0, '2026_11_15_900_world_everlake_forge_00029_import.sql', 'Forge #29: Classic database 2026-11-15: Lunar Festival' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
