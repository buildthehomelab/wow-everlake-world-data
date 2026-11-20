-- World objects the missing Forever quests need (quest-giver objects and objects to use), from Icy Veins' WoW Forever
-- database (https://db.icy-veins.com/wow-forever/, read 2026-11-19): name, type, model, size, data fields and icon of
-- each object as the client knows it, and where players' addons saw it.
-- 2026_11_19_995_world_everlake_quest_objects.sql: written from public data by a script, checked by hand.
--
-- 46 templates; every model is in the 70959 client (GameObjectDisplayInfo). EG Link's record of the client's own
-- query answers (object_details) has 19 of them and agrees on type and model for 19.
-- Spawns: each point players' addons recorded (UiMap per mille), turned into a world position with the client's
-- UiMapAssignment rectangles (ForeverTracker ft.geo), height from the realm's own maps and vmaps (tools/height.py); a
-- cave under terrain takes its lowest floor. Orientation 0 and respawn 300 s are INFERRED. Objects with no recorded
-- point get their template only.
-- Guids: objects 920013000 upward, a block of their own (920013000-920013999).
-- No template is added where the realm already has one. An object is spawned where the realm has its template (this
-- file's or its own) but no spawn of it. Each added row is recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing. Not tried in game.

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

SET @EVERLAKE_FILE := '2026_11_19_995_world_everlake_quest_objects.sql';
START TRANSACTION;

-- Broken Warhammer (423703): type 2, model 1107; quests 96438; 1 spawn(s).
SET @EVERLAKE_G423703 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 423703) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 423703);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 423703, 2, 1107, 'Broken Warhammer', '', '', '', 0.8, 0, 29896, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G423703 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 423703, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=423703; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G423703 = 1;
SET @EVERLAKE_GS423703 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 423703) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 423703 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 423703, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013000 AS `guid`, 1 AS `map`, -2088.95 AS `x`, 1864.93 AS `y`, 66.87 AS `z`
) s WHERE @EVERLAKE_GS423703 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS423703 = 1 AND g.`id` = 423703 AND g.`guid` BETWEEN 920013000 AND 920013000;

-- Legashi Cauldron (506307): type 2, model 216; quests 86804, 86925, 86926, 86927; 1 spawn(s).
SET @EVERLAKE_G506307 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 506307) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 506307);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 506307, 2, 216, 'Legashi Cauldron', '', '', '', 1.5, 93, 28275, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G506307 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 506307, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=506307' FROM DUAL WHERE @EVERLAKE_G506307 = 1;
SET @EVERLAKE_GS506307 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 506307) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 506307 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 506307, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013001 AS `guid`, 1 AS `map`, 4632.28 AS `x`, -6203.46 AS `y`, 104.2 AS `z`
) s WHERE @EVERLAKE_GS506307 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS506307 = 1 AND g.`id` = 506307 AND g.`guid` BETWEEN 920013001 AND 920013001;

-- Saria's Knapsack (527828): type 2, model 323; quests 89053, 89470; 1 spawn(s).
SET @EVERLAKE_G527828 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 527828) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 527828);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 527828, 2, 323, 'Saria''s Knapsack', '', '', '', 1.0, 43, 28550, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G527828 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 527828, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=527828' FROM DUAL WHERE @EVERLAKE_G527828 = 1;
SET @EVERLAKE_GS527828 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 527828) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 527828 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 527828, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013002 AS `guid`, 1 AS `map`, 3925.94 AS `x`, -5783.6 AS `y`, 14.65 AS `z`
) s WHERE @EVERLAKE_GS527828 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS527828 = 1 AND g.`id` = 527828 AND g.`guid` BETWEEN 920013002 AND 920013002;

-- Shen'dralar Pylon (577959): type 2, model 4714; quests 92914; 2 spawn(s).
SET @EVERLAKE_G577959 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 577959) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 577959);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 577959, 2, 4714, 'Shen''dralar Pylon', '', '', '', 2.25, 0, 29082, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G577959 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 577959, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=577959; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G577959 = 1;
SET @EVERLAKE_GS577959 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 577959) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 577959 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 577959, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013003 AS `guid`, 1 AS `map`, -2369.86 AS `x`, 1129.56 AS `y`, 108.16 AS `z`
  UNION ALL
  SELECT 920013004 AS `guid`, 1 AS `map`, -2381.75 AS `x`, 1128.33 AS `y`, 133.1 AS `z`
) s WHERE @EVERLAKE_GS577959 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS577959 = 1 AND g.`id` = 577959 AND g.`guid` BETWEEN 920013003 AND 920013004;

-- Shen'dralar Pylon (577960): type 2, model 4714; quests 92914; 1 spawn(s).
SET @EVERLAKE_G577960 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 577960) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 577960);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 577960, 2, 4714, 'Shen''dralar Pylon', '', '', '', 2.25, 0, 29082, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G577960 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 577960, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=577960; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G577960 = 1;
SET @EVERLAKE_GS577960 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 577960) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 577960 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 577960, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013005 AS `guid`, 1 AS `map`, -2217.2 AS `x`, 520.3 AS `y`, 174.96 AS `z`
) s WHERE @EVERLAKE_GS577960 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS577960 = 1 AND g.`id` = 577960 AND g.`guid` BETWEEN 920013005 AND 920013005;

-- WANTED! (581918): type 2, model 17; quests 92858; 1 spawn(s).
SET @EVERLAKE_G581918 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 581918) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 581918);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 581918, 2, 17, 'WANTED!', '', '', '', 1.0, 0, 29070, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G581918 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 581918, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=581918' FROM DUAL WHERE @EVERLAKE_G581918 = 1;
SET @EVERLAKE_GS581918 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 581918) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 581918 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 581918, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013006 AS `guid`, 1 AS `map`, -4398.38 AS `x`, 3281.61 AS `y`, 13.15 AS `z`
) s WHERE @EVERLAKE_GS581918 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS581918 = 1 AND g.`id` = 581918 AND g.`guid` BETWEEN 920013006 AND 920013006;

-- Connery's Trunk (611086): type 2, model 41; quests 96337; 1 spawn(s).
SET @EVERLAKE_G611086 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 611086) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 611086);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 611086, 2, 41, 'Connery''s Trunk', '', '', '', 0.6, 1634, 29881, 0, 0, 0, 0, 0, 0, 0, 0, 155978, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2180, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G611086 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 611086, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=611086; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G611086 = 1;
SET @EVERLAKE_GS611086 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 611086) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 611086 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 611086, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013007 AS `guid`, 0 AS `map`, -10983.63 AS `x`, 1496.62 AS `y`, 61.71 AS `z`
) s WHERE @EVERLAKE_GS611086 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS611086 = 1 AND g.`id` = 611086 AND g.`guid` BETWEEN 920013007 AND 920013007;

-- Ashen Soil (613773): type 10, model 20; quests 93547; 0 spawn(s).
SET @EVERLAKE_G613773 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 613773) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 613773);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 613773, 10, 20, 'Ashen Soil', '', '', '', 1.0, 43, 93547, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147780, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G613773 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 613773, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=613773' FROM DUAL WHERE @EVERLAKE_G613773 = 1;

-- Battle Cache (613848): type 2, model 8; quests 96558; 1 spawn(s).
SET @EVERLAKE_G613848 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 613848) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 613848);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 613848, 2, 8, 'Battle Cache', '', '', '', 2.0, 0, 29901, 0, 41471, 0, 0, 0, 0, 0, 0, 156365, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G613848 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 613848, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=613848' FROM DUAL WHERE @EVERLAKE_G613848 = 1;
SET @EVERLAKE_GS613848 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 613848) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 613848 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 613848, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013008 AS `guid`, 1 AS `map`, 5084.61 AS `x`, -1930.76 AS `y`, 1390.38 AS `z`
) s WHERE @EVERLAKE_GS613848 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS613848 = 1 AND g.`id` = 613848 AND g.`guid` BETWEEN 920013008 AND 920013008;

-- Dried Hanging Herbs (617129): type 10, model 117833; quests 93828; 0 spawn(s).
SET @EVERLAKE_G617129 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 617129) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 617129);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 617129, 10, 117833, 'Dried Hanging Herbs', '', '', '', 1.0, 4287, 0, 0, 1000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 148872, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 181, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G617129 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 617129, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=617129' FROM DUAL WHERE @EVERLAKE_G617129 = 1;

-- Loamy Soil (621767): type 10, model 49; quests 94843; 0 spawn(s).
SET @EVERLAKE_G621767 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 621767) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 621767);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 621767, 10, 49, 'Loamy Soil', '', '', '', 0.5, 4331, 94843, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G621767 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 621767, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=621767; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G621767 = 1;

-- Loose Soil (621813): type 10, model 20; quests 94829; 0 spawn(s).
SET @EVERLAKE_G621813 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 621813) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 621813);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 621813, 10, 20, 'Loose Soil', 'questinteract', '', '', 1.2, 4334, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G621813 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 621813, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=621813' FROM DUAL WHERE @EVERLAKE_G621813 = 1;

-- Fuzzle's Treasure (625582): type 2, model 1; quests 94963; 1 spawn(s).
SET @EVERLAKE_G625582 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 625582) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 625582);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 625582, 2, 1, 'Fuzzle''s Treasure', '', '', '', 1.0, 0, 29488, 0, 0, 0, 0, 0, 1, 0, 0, 151407, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G625582 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 625582, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=625582; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G625582 = 1;
SET @EVERLAKE_GS625582 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 625582) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 625582 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 625582, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013009 AS `guid`, 0 AS `map`, -8010.26 AS `x`, -3911.21 AS `y`, 21.53 AS `z`
) s WHERE @EVERLAKE_GS625582 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS625582 = 1 AND g.`id` = 625582 AND g.`guid` BETWEEN 920013009 AND 920013009;

-- Cannon Ammunition (629425): type 10, model 4177; quests 95165; 0 spawn(s).
SET @EVERLAKE_G629425 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 629425) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 629425);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 629425, 10, 4177, 'Cannon Ammunition', '', '', '', 1.0, 4346, 95165, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G629425 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 629425, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=629425; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G629425 = 1;

-- Cannon Ammunition (629426): type 10, model 4177; quests 95165; 0 spawn(s).
SET @EVERLAKE_G629426 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 629426) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 629426);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 629426, 10, 4177, 'Cannon Ammunition', '', '', '', 1.0, 4346, 95165, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G629426 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 629426, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=629426; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G629426 = 1;

-- Cannon Ammunition (629427): type 10, model 4177; quests 95165; 0 spawn(s).
SET @EVERLAKE_G629427 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 629427) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 629427);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 629427, 10, 4177, 'Cannon Ammunition', '', '', '', 1.0, 4346, 95165, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G629427 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 629427, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=629427; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G629427 = 1;

-- Painted Hide (629761): type 2, model 116323; quests 95260; 1 spawn(s).
SET @EVERLAKE_G629761 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 629761) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 629761);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 629761, 2, 116323, 'Painted Hide', '', '', '', 0.5, 0, 29550, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G629761 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 629761, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=629761; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G629761 = 1;
SET @EVERLAKE_GS629761 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 629761) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 629761 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 629761, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013010 AS `guid`, 0 AS `map`, -8467.13 AS `x`, -5399.67 AS `y`, 0.68 AS `z`
) s WHERE @EVERLAKE_GS629761 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS629761 = 1 AND g.`id` = 629761 AND g.`guid` BETWEEN 920013010 AND 920013010;

-- Venture Co. Ledger (630887): type 2, model 4032; quests 95325, 95326; 1 spawn(s).
SET @EVERLAKE_G630887 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 630887) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 630887);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 630887, 2, 4032, 'Venture Co. Ledger', '', '', '', 1.5, 0, 29564, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G630887 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 630887, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=630887; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G630887 = 1;
SET @EVERLAKE_GS630887 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 630887) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 630887 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 630887, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013011 AS `guid`, 0 AS `map`, -11956.2 AS `x`, -505.24 AS `y`, 39.28 AS `z`
) s WHERE @EVERLAKE_GS630887 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS630887 = 1 AND g.`id` = 630887 AND g.`guid` BETWEEN 920013011 AND 920013011;

-- Old Chest (642451): type 2, model 5744; quests 95599; 0 spawn(s).
SET @EVERLAKE_G642451 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 642451) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 642451);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 642451, 2, 5744, 'Old Chest', '', '', '', 1.5, 0, 29669, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G642451 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 642451, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642451' FROM DUAL WHERE @EVERLAKE_G642451 = 1;

-- Burned Memorial Candle (642517): type 10, model 123672; quests 95615; 0 spawn(s).
SET @EVERLAKE_G642517 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 642517) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 642517);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 642517, 10, 123672, 'Burned Memorial Candle', '', '', '', 1.0, 4378, 95615, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G642517 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 642517, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642517' FROM DUAL WHERE @EVERLAKE_G642517 = 1;

-- WANTED! (645164): type 2, model 17; quests 95992; 1 spawn(s).
SET @EVERLAKE_G645164 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 645164) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 645164);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 645164, 2, 17, 'WANTED!', '', '', '', 1.0, 0, 29788, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G645164 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 645164, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=645164; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G645164 = 1;
SET @EVERLAKE_GS645164 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 645164) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 645164 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 645164, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013012 AS `guid`, 0 AS `map`, -7986.98 AS `x`, -4775.48 AS `y`, 24.24 AS `z`
) s WHERE @EVERLAKE_GS645164 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS645164 = 1 AND g.`id` = 645164 AND g.`guid` BETWEEN 920013012 AND 920013012;

-- Loose Cog (650234): type 2, model 124714; quests 94479; 1 spawn(s).
SET @EVERLAKE_G650234 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 650234) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 650234);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 650234, 2, 124714, 'Loose Cog', '', '', '', 0.5, 0, 30004, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G650234 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 650234, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=650234' FROM DUAL WHERE @EVERLAKE_G650234 = 1;
SET @EVERLAKE_GS650234 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 650234) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 650234 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 650234, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013013 AS `guid`, 1 AS `map`, 4512.91 AS `x`, -3537.68 AS `y`, 986.8 AS `z`
) s WHERE @EVERLAKE_GS650234 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS650234 = 1 AND g.`id` = 650234 AND g.`guid` BETWEEN 920013013 AND 920013013;

-- Unmarked Grave (651262): type 2, model 20; quests 90702; 1 spawn(s).
SET @EVERLAKE_G651262 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 651262) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 651262);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 651262, 2, 20, 'Unmarked Grave', '', '', '', 1.0, 0, 29862, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G651262 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 651262, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=651262' FROM DUAL WHERE @EVERLAKE_G651262 = 1;
SET @EVERLAKE_GS651262 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 651262) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 651262 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 651262, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013014 AS `guid`, 1 AS `map`, 5177.89 AS `x`, -1704.32 AS `y`, 1339.83 AS `z`
) s WHERE @EVERLAKE_GS651262 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS651262 = 1 AND g.`id` = 651262 AND g.`guid` BETWEEN 920013014 AND 920013014;

-- Corrupted Growth (651409): type 2, model 425; quests 96296; 1 spawn(s).
SET @EVERLAKE_G651409 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 651409) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 651409);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 651409, 2, 425, 'Corrupted Growth', '', '', '', 2.0, 0, 29864, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G651409 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 651409, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=651409' FROM DUAL WHERE @EVERLAKE_G651409 = 1;
SET @EVERLAKE_GS651409 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 651409) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 651409 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 651409, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013015 AS `guid`, 1 AS `map`, 5000.59 AS `x`, -2609.02 AS `y`, 1424.54 AS `z`
) s WHERE @EVERLAKE_GS651409 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS651409 = 1 AND g.`id` = 651409 AND g.`guid` BETWEEN 920013015 AND 920013015;

-- Corrupted Growth (651430): type 10, model 425; quests 96296; 0 spawn(s).
SET @EVERLAKE_G651430 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 651430) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 651430);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 651430, 10, 425, 'Corrupted Growth', '', '', '', 2.0, 93, 96296, 0, 3000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G651430 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 651430, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=651430' FROM DUAL WHERE @EVERLAKE_G651430 = 1;

-- Northern Sentinel Stone (651979): type 10, model 84873; quests 93127; 0 spawn(s).
SET @EVERLAKE_G651979 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 651979) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 651979);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 651979, 10, 84873, 'Northern Sentinel Stone', '', '', '', 1.0, 93, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 1293361, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 156036, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G651979 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 651979, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=651979' FROM DUAL WHERE @EVERLAKE_G651979 = 1;

-- Southern Sentinel Stone (651986): type 10, model 84873; quests 93127; 0 spawn(s).
SET @EVERLAKE_G651986 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 651986) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 651986);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 651986, 10, 84873, 'Southern Sentinel Stone', '', '', '', 1.0, 93, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 1293361, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 156036, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G651986 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 651986, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=651986' FROM DUAL WHERE @EVERLAKE_G651986 = 1;

-- Western Sentinel Stone (651987): type 10, model 84873; quests 93127; 0 spawn(s).
SET @EVERLAKE_G651987 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 651987) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 651987);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 651987, 10, 84873, 'Western Sentinel Stone', '', '', '', 1.0, 93, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 1293361, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 156036, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G651987 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 651987, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=651987' FROM DUAL WHERE @EVERLAKE_G651987 = 1;

-- Carving (652438): type 2, model 125238; quests 92101; 1 spawn(s).
SET @EVERLAKE_G652438 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 652438) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 652438);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 652438, 2, 125238, 'Carving', '', '', '', 0.45, 0, 29213, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G652438 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 652438, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=652438; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G652438 = 1;
SET @EVERLAKE_GS652438 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 652438) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 652438 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 652438, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013016 AS `guid`, 1 AS `map`, -4671.25 AS `x`, -1838.25 AS `y`, 115.34 AS `z`
) s WHERE @EVERLAKE_GS652438 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS652438 = 1 AND g.`id` = 652438 AND g.`guid` BETWEEN 920013016 AND 920013016;

-- Bone Pile (652449): type 2, model 125238; quests 96255, 96435; 1 spawn(s).
SET @EVERLAKE_G652449 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 652449) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 652449);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 652449, 2, 125238, 'Bone Pile', '', '', '', 0.8, 0, 29894, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G652449 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 652449, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=652449' FROM DUAL WHERE @EVERLAKE_G652449 = 1;
SET @EVERLAKE_GS652449 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 652449) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 652449 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 652449, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013017 AS `guid`, 1 AS `map`, 4447.18 AS `x`, -2338.13 AS `y`, 1117.34 AS `z`
) s WHERE @EVERLAKE_GS652449 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS652449 = 1 AND g.`id` = 652449 AND g.`guid` BETWEEN 920013017 AND 920013017;

-- Embroidered Scabbard (654121): type 2, model 125586; quests 92100, 96550; 1 spawn(s).
SET @EVERLAKE_G654121 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 654121) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 654121);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 654121, 2, 125586, 'Embroidered Scabbard', '', '', '', 1.0, 0, 29935, 0, 43327, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 181, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G654121 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 654121, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=654121' FROM DUAL WHERE @EVERLAKE_G654121 = 1;
SET @EVERLAKE_GS654121 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 654121) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 654121 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 654121, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013018 AS `guid`, 1 AS `map`, 5227.88 AS `x`, -1228.88 AS `y`, 1375.66 AS `z`
) s WHERE @EVERLAKE_GS654121 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS654121 = 1 AND g.`id` = 654121 AND g.`guid` BETWEEN 920013018 AND 920013018;

-- Weathered Anchor (654126): type 2, model 125238; quests 93510; 1 spawn(s).
SET @EVERLAKE_G654126 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 654126) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 654126);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 654126, 2, 125238, 'Weathered Anchor', '', '', '', 0.4, 0, 29946, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 181, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G654126 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 654126, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=654126; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G654126 = 1;
SET @EVERLAKE_GS654126 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 654126) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 654126 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 654126, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013019 AS `guid`, 0 AS `map`, -9401.18 AS `x`, -2341.4 AS `y`, 56.94 AS `z`
) s WHERE @EVERLAKE_GS654126 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS654126 = 1 AND g.`id` = 654126 AND g.`guid` BETWEEN 920013019 AND 920013019;

-- Broken Fishing Basket (654150): type 2, model 125591; quests 96561; 1 spawn(s).
SET @EVERLAKE_G654150 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 654150) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 654150);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 654150, 2, 125591, 'Broken Fishing Basket', '', '', '', 2.0, 0, 29903, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 181, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G654150 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 654150, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=654150' FROM DUAL WHERE @EVERLAKE_G654150 = 1;
SET @EVERLAKE_GS654150 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 654150) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 654150 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 654150, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013020 AS `guid`, 1 AS `map`, 5258.9 AS `x`, -2162.05 AS `y`, 1259.38 AS `z`
) s WHERE @EVERLAKE_GS654150 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS654150 = 1 AND g.`id` = 654150 AND g.`guid` BETWEEN 920013020 AND 920013020;

-- Syndicate Footlocker (656157): type 2, model 5744; quests 96784; 1 spawn(s).
SET @EVERLAKE_G656157 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 656157) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 656157);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 656157, 2, 5744, 'Syndicate Footlocker', '', '', '', 1.0, 0, 30030, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G656157 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 656157, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656157; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G656157 = 1;
SET @EVERLAKE_GS656157 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 656157) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 656157 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 656157, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013021 AS `guid`, 0 AS `map`, -770.05 AS `x`, -2029.47 AS `y`, 34.08 AS `z`
) s WHERE @EVERLAKE_GS656157 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS656157 = 1 AND g.`id` = 656157 AND g.`guid` BETWEEN 920013021 AND 920013021;

-- South Bonfire (656668): type 10, model 324; quests 96959; 0 spawn(s).
SET @EVERLAKE_G656668 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 656668) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 656668);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 656668, 10, 324, 'South Bonfire', '', '', '', 1.36, 4088, 96959, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G656668 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 656668, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656668' FROM DUAL WHERE @EVERLAKE_G656668 = 1;

-- Southeast Bonfire (656669): type 10, model 324; quests 96959; 0 spawn(s).
SET @EVERLAKE_G656669 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 656669) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 656669);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 656669, 10, 324, 'Southeast Bonfire', '', '', '', 1.0, 4088, 96959, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G656669 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 656669, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656669' FROM DUAL WHERE @EVERLAKE_G656669 = 1;

-- Troll Remains (656786): type 2, model 126458; quests 96998; 1 spawn(s).
SET @EVERLAKE_G656786 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 656786) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 656786);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 656786, 2, 126458, 'Troll Remains', '', '', '', 1.0, 0, 30090, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G656786 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 656786, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656786' FROM DUAL WHERE @EVERLAKE_G656786 = 1;
SET @EVERLAKE_GS656786 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 656786) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 656786 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 656786, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013022 AS `guid`, 1 AS `map`, 5344.54 AS `x`, -3060.84 AS `y`, 1612.42 AS `z`
) s WHERE @EVERLAKE_GS656786 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS656786 = 1 AND g.`id` = 656786 AND g.`guid` BETWEEN 920013022 AND 920013022;

-- Old Wardrobe (656815): type 2, model 4; quests 97000, 97001; 1 spawn(s).
SET @EVERLAKE_G656815 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 656815) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 656815);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 656815, 2, 4, 'Old Wardrobe', '', '', '', 1.0, 0, 30095, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G656815 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 656815, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656815' FROM DUAL WHERE @EVERLAKE_G656815 = 1;
SET @EVERLAKE_GS656815 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 656815) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 656815 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 656815, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013023 AS `guid`, 1 AS `map`, 5355.19 AS `x`, -2079.05 AS `y`, 1287.33 AS `z`
) s WHERE @EVERLAKE_GS656815 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS656815 = 1 AND g.`id` = 656815 AND g.`guid` BETWEEN 920013023 AND 920013023;

-- Lost Shipping Crate (658115): type 2, model 285; quests 94895; 1 spawn(s).
SET @EVERLAKE_G658115 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 658115) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 658115);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 658115, 2, 285, 'Lost Shipping Crate', '', '', '', 0.75, 0, 30122, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G658115 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 658115, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=658115; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G658115 = 1;
SET @EVERLAKE_GS658115 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 658115) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 658115 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 658115, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013024 AS `guid`, 1 AS `map`, -1724.4 AS `x`, 3180.41 AS `y`, 5.24 AS `z`
) s WHERE @EVERLAKE_GS658115 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS658115 = 1 AND g.`id` = 658115 AND g.`guid` BETWEEN 920013024 AND 920013024;

-- Lost Shipping Crate (658116): type 2, model 285; quests 93443; 1 spawn(s).
SET @EVERLAKE_G658116 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 658116) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 658116);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 658116, 2, 285, 'Lost Shipping Crate', '', '', '', 0.75, 0, 30123, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G658116 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 658116, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=658116; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G658116 = 1;
SET @EVERLAKE_GS658116 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 658116) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 658116 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 658116, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013025 AS `guid`, 0 AS `map`, -11296.8 AS `x`, -204.04 AS `y`, 75.76 AS `z`
) s WHERE @EVERLAKE_GS658116 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS658116 = 1 AND g.`id` = 658116 AND g.`guid` BETWEEN 920013025 AND 920013025;

-- Ashen Soil (659199): type 10, model 20; quests 93547; 0 spawn(s).
SET @EVERLAKE_G659199 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 659199) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 659199);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 659199, 10, 20, 'Ashen Soil', '', '', '', 0.5, 43, 93547, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147780, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G659199 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 659199, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=659199' FROM DUAL WHERE @EVERLAKE_G659199 = 1;

-- Ashen Soil (659200): type 10, model 20; quests 93547; 0 spawn(s).
SET @EVERLAKE_G659200 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 659200) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 659200);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 659200, 10, 20, 'Ashen Soil', '', '', '', 0.5, 43, 93547, 0, 3000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 147780, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G659200 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 659200, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=659200' FROM DUAL WHERE @EVERLAKE_G659200 = 1;

-- Statue of Malorne (661778): type 2, model 123673; quests 86611, 86612; 1 spawn(s).
SET @EVERLAKE_G661778 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 661778) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 661778);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 661778, 2, 123673, 'Statue of Malorne', '', '', '', 0.25, 4088, 30231, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G661778 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 661778, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=661778; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G661778 = 1;
SET @EVERLAKE_GS661778 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 661778) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 661778 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 661778, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013026 AS `guid`, 1 AS `map`, 5318.63 AS `x`, -776.21 AS `y`, 341.75 AS `z`
) s WHERE @EVERLAKE_GS661778 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS661778 = 1 AND g.`id` = 661778 AND g.`guid` BETWEEN 920013026 AND 920013026;

-- Ancient Hilt (676059): type 2, model 129893; quests 93161; 1 spawn(s).
SET @EVERLAKE_G676059 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 676059) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 676059);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 676059, 2, 129893, 'Ancient Hilt', '', '', '', 1.0, 0, 30633, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2180, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G676059 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 676059, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=676059' FROM DUAL WHERE @EVERLAKE_G676059 = 1;
SET @EVERLAKE_GS676059 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 676059) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 676059 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 676059, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013027 AS `guid`, 2991 AS `map`, 4064.77 AS `x`, 998.88 AS `y`, 816.68 AS `z`
) s WHERE @EVERLAKE_GS676059 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS676059 = 1 AND g.`id` = 676059 AND g.`guid` BETWEEN 920013027 AND 920013027;

-- Wanted (707249): type 2, model 15; quests 95882; 1 spawn(s).
SET @EVERLAKE_G707249 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 707249) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 707249);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 707249, 2, 15, 'Wanted', '', '', '', 0.5, 0, 30952, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G707249 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 707249, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=707249; EG Link object_details agrees' FROM DUAL WHERE @EVERLAKE_G707249 = 1;
SET @EVERLAKE_GS707249 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 707249) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 707249 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 707249, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013028 AS `guid`, 0 AS `map`, -7986.33 AS `x`, -4782.75 AS `y`, 24.08 AS `z`
) s WHERE @EVERLAKE_GS707249 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS707249 = 1 AND g.`id` = 707249 AND g.`guid` BETWEEN 920013028 AND 920013028;

-- Bookshelf (710894): type 2, model 137; quests 93521; 1 spawn(s).
SET @EVERLAKE_G710894 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 710894) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 710894);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 710894, 2, 137, 'Bookshelf', '', '', '', 1.0, 0, 30989, 0, 0, 0, 0, 0, 0, 0, 0, 168025, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G710894 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 710894, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=710894' FROM DUAL WHERE @EVERLAKE_G710894 = 1;
SET @EVERLAKE_GS710894 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 710894) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 710894 AND `guid` NOT BETWEEN 920013000 AND 920013999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 710894, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920013029 AS `guid`, 1 AS `map`, 5485.27 AS `x`, -3594.28 AS `y`, 2181.77 AS `z`
) s WHERE @EVERLAKE_GS710894 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins addon point; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS710894 = 1 AND g.`id` = 710894 AND g.`guid` BETWEEN 920013029 AND 920013029;

COMMIT;
