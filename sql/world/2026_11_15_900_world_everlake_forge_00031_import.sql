-- Everlake Forge #31: Import, 1 resource(s), 16 row(s)
-- Applied on the test realm as the tracker's Forge operation #30; numbered 31 here, the next free number of this repository.
-- 2026_11_15_900_world_everlake_forge_00031_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70938) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Classic database 2026-11-15: Hallow’s End (NOTICE.md, Forge exports).
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
-- gameobject: 5 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `gameobject` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(910300000, 180405, 0, 0, 0, '0', 0, 0, 0, -1, -10550.3, -1110.84, 31.4281, -1.01229, 0, 0, 0.48481, -0.87462, 180, 255, 1, '', NULL, 70938),
(910300001, 180432, 0, 0, 0, '0', 0, 0, 0, -1, 1712.63, 507.05, 38.2495, 1.58824, 0, 0, 0.713246, 0.700914, 300, 255, 1, '', NULL, 70938),
(910300002, 180433, 0, 0, 0, '0', 0, 0, 0, -1, 1734.04, 504.05, 42.2861, 1.4131, 0, 0, 0.649213, 0.760607, 300, 255, 1, '', NULL, 70938),
(910300003, 180434, 0, 0, 0, '0', 0, 0, 0, -1, 1704.48, 518.689, 35.4045, 1.30704, 0, 0, 0.607984, 0.793949, 300, 255, 1, '', NULL, 70938),
(910300004, 180434, 0, 0, 0, '0', 0, 0, 0, -1, 1738.74, 551.097, 33.4966, 4.59492, 0, 0, 0.747395, -0.66438, 300, 255, 1, '', NULL, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject` x ON x.`id` = s.`id` AND x.`map` = s.`map` AND (x.`position_x` - s.`position_x`) * (x.`position_x` - s.`position_x`) + (x.`position_y` - s.`position_y`) * (x.`position_y` - s.`position_y`) <= 25;
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject` x ON x.`guid` = s.`guid`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `gameobject_template` p WHERE p.`entry` = `everlake_forge_stage`.`id`);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', s.`guid`, 0, 0, 0, '2026_11_15_900_world_everlake_forge_00031_import.sql', 'Forge #31: Classic database 2026-11-15: Hallow’s End' FROM `everlake_forge_stage` s;

-- creature: 3 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `creature` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(910300000, 15199, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -826.324, -532.834, 14.45, 0.4706, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910300001, 15195, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, 1729.05, 552.65, 34.3029, 4.5439, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910300002, 15415, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -835.52, -528.52, 11.97, 0, 300, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `creature` x ON x.`id` = s.`id` AND x.`map` = s.`map` AND (x.`position_x` - s.`position_x`) * (x.`position_x` - s.`position_x`) + (x.`position_y` - s.`position_y`) * (x.`position_y` - s.`position_y`) <= 25;
DELETE s FROM `everlake_forge_stage` s JOIN `creature` x ON x.`guid` = s.`guid`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`id`);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`) SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature', s.`guid`, 0, 0, 0, '2026_11_15_900_world_everlake_forge_00031_import.sql', 'Forge #31: Classic database 2026-11-15: Hallow’s End' FROM `everlake_forge_stage` s;

-- game_event_gameobject: 5 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `eventEntry`, `guid` FROM `game_event_gameobject` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`eventEntry`, `guid`) VALUES
(12, 910300000),
(12, 910300001),
(12, 910300002),
(12, 910300003),
(12, 910300004);
DELETE s FROM `everlake_forge_stage` s JOIN `game_event_gameobject` x ON x.`guid` <=> s.`guid` AND x.`eventEntry` <=> s.`eventEntry`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `gameobject` p WHERE p.`guid` = `everlake_forge_stage`.`guid`);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) SELECT `eventEntry`, `guid` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'game_event_gameobject', s.`guid`, s.`eventEntry`, 0, 0, '2026_11_15_900_world_everlake_forge_00031_import.sql', 'Forge #31: Classic database 2026-11-15: Hallow’s End' FROM `everlake_forge_stage` s;

-- game_event_creature: 3 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `eventEntry`, `guid` FROM `game_event_creature` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`eventEntry`, `guid`) VALUES
(12, 910300000),
(12, 910300001),
(12, 910300002);
DELETE s FROM `everlake_forge_stage` s JOIN `game_event_creature` x ON x.`guid` <=> s.`guid` AND x.`eventEntry` <=> s.`eventEntry`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature` p WHERE p.`guid` = `everlake_forge_stage`.`guid`);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) SELECT `eventEntry`, `guid` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'game_event_creature', s.`guid`, s.`eventEntry`, 0, 0, '2026_11_15_900_world_everlake_forge_00031_import.sql', 'Forge #31: Classic database 2026-11-15: Hallow’s End' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
