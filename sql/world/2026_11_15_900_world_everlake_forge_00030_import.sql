-- Everlake Forge #30: Import, 1 resource(s), 14 row(s)
-- Applied on the test realm as the tracker's Forge operation #29; numbered 30 here, the next free number of this repository.
-- 2026_11_15_900_world_everlake_forge_00030_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70938) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Classic database 2026-11-15: Feast of Winter Veil (NOTICE.md, Forge exports).
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
-- gameobject: 4 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `gameobject` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(910290000, 178432, 1, 0, 0, '0', 0, 0, 0, -1, -1231.19, 65.6161, 128.912, -0.959931, 0, 0, 0.461749, -0.887011, 180, 255, 1, '', NULL, 70938),
(910290001, 180715, 1, 0, 0, '0', 0, 0, 0, -1, -1227.87, 70.1361, 129.717, -2.09439, 0, 0, 0.866025, -0.5, 180, 255, 1, '', NULL, 70938),
(910290002, 178746, 1, 0, 0, '0', 0, 0, 0, -1, -1233.33, 74.2931, 129.665, 2.18166, 0, 0, 0.887011, 0.461749, 180, 255, 1, '', NULL, 70938),
(910290003, 178426, 1, 0, 0, '0', 0, 0, 0, -1, -1231.48, 66.8287, 129.161, 1.88496, 0, 0, 0.809017, 0.587785, 180, 255, 1, '', NULL, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject` x ON x.`id` = s.`id` AND x.`map` = s.`map` AND (x.`position_x` - s.`position_x`) * (x.`position_x` - s.`position_x`) + (x.`position_y` - s.`position_y`) * (x.`position_y` - s.`position_y`) <= 25;
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject` x ON x.`guid` = s.`guid`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `gameobject_template` p WHERE p.`entry` = `everlake_forge_stage`.`id`);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', s.`guid`, 0, 0, 0, '2026_11_15_900_world_everlake_forge_00030_import.sql', 'Forge #30: Classic database 2026-11-15: Feast of Winter Veil' FROM `everlake_forge_stage` s;

-- creature: 3 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `creature` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(910290000, 13432, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, -1274.94, 109.166, 129.298, 1.8695, 1480, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910290001, 13436, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -8807, 635.279, 94.229, 4.162, 840, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910290002, 13602, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, 171.682, -260.075, 150.132, 1.142, 600, 40, 0, NULL, 1, NULL, NULL, NULL, NULL, '', NULL, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `creature` x ON x.`id` = s.`id` AND x.`map` = s.`map` AND (x.`position_x` - s.`position_x`) * (x.`position_x` - s.`position_x`) + (x.`position_y` - s.`position_y`) * (x.`position_y` - s.`position_y`) <= 25;
DELETE s FROM `everlake_forge_stage` s JOIN `creature` x ON x.`guid` = s.`guid`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`id`);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`) SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature', s.`guid`, 0, 0, 0, '2026_11_15_900_world_everlake_forge_00030_import.sql', 'Forge #30: Classic database 2026-11-15: Feast of Winter Veil' FROM `everlake_forge_stage` s;

-- game_event_gameobject: 4 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `eventEntry`, `guid` FROM `game_event_gameobject` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`eventEntry`, `guid`) VALUES
(2, 910290000),
(2, 910290001),
(2, 910290002),
(2, 910290003);
DELETE s FROM `everlake_forge_stage` s JOIN `game_event_gameobject` x ON x.`guid` <=> s.`guid` AND x.`eventEntry` <=> s.`eventEntry`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `gameobject` p WHERE p.`guid` = `everlake_forge_stage`.`guid`);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) SELECT `eventEntry`, `guid` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'game_event_gameobject', s.`guid`, s.`eventEntry`, 0, 0, '2026_11_15_900_world_everlake_forge_00030_import.sql', 'Forge #30: Classic database 2026-11-15: Feast of Winter Veil' FROM `everlake_forge_stage` s;

-- game_event_creature: 3 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `eventEntry`, `guid` FROM `game_event_creature` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`eventEntry`, `guid`) VALUES
(2, 910290000),
(2, 910290001),
(2, 910290002);
DELETE s FROM `everlake_forge_stage` s JOIN `game_event_creature` x ON x.`guid` <=> s.`guid` AND x.`eventEntry` <=> s.`eventEntry`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature` p WHERE p.`guid` = `everlake_forge_stage`.`guid`);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) SELECT `eventEntry`, `guid` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'game_event_creature', s.`guid`, s.`eventEntry`, 0, 0, '2026_11_15_900_world_everlake_forge_00030_import.sql', 'Forge #30: Classic database 2026-11-15: Feast of Winter Veil' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
