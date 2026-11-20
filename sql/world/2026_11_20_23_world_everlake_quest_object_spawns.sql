-- World objects the missing Forever quests need, from Icy Veins' WoW Forever database (https://db.icy-veins.com/wow-forever/:
-- name, type, model, size and data fields) and Wowhead's WoW Forever object pages (https://www.wowhead.com/forever, read
-- 2026-11-20 through the tracker's kept pages: map points).
-- 2026_11_20_23_world_everlake_quest_object_spawns.sql: written from public data by a script, checked by hand.
--
-- 4 new templates with their spawns (Shattered Orb, Illari's Loot Cache, Red Bag, Mysterious Chest), and spawns for 16
-- objects file 2026_11_19_995 added as templates only (Icy Veins had no point for them; Wowhead does).
-- Spawns: one per Wowhead point at least 5 yards apart, at most 10, turned into a world position with the client's
-- UiMapAssignment rectangles and the height from the realm's maps and vmaps (ForeverTracker tools/height.py). Dried
-- Hanging Herbs (quest Herbs of the Hollow) stand in the cave under the terrain: its lowest floor. Old Chest's points are
-- on a lake: the lake bed. Orientation 0, rotation 0 and respawn 300 s are INFERRED.
-- Held back: Burned Memorial Candle (642517): its points are inside a building with several floors.
-- Guids: objects 920015000 upward, a block of their own (920015000-920015999).
-- No template is added where the realm already has one. An object is spawned where the realm has its template but no
-- spawn of it outside this block. Each added row is recorded in everlake_import_rows.
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';

SET @EVERLAKE_FILE := '2026_11_20_23_world_everlake_quest_object_spawns.sql';
START TRANSACTION;

-- Shattered Orb (409315): type 2, model 125345; quests 78093; 2 spawn(s).
SET @EVERLAKE_G409315 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 409315) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 409315);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 409315, 2, 125345, 'Shattered Orb', '', '', '', 0.25, 0, 26701, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G409315 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 409315, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=409315' FROM DUAL WHERE @EVERLAKE_G409315 = 1;
SET @EVERLAKE_GS409315 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 409315) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 409315 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 409315, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015000 AS `guid`, 1 AS `map`, 1709.39 AS `x`, -3455.40 AS `y`, 144.30 AS `z`
  UNION ALL
  SELECT 920015001 AS `guid`, 1 AS `map`, 1713.23 AS `x`, -3461.17 AS `y`, 144.10 AS `z`
) s WHERE @EVERLAKE_GS409315 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=409315 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS409315 = 1 AND g.`id` = 409315 AND g.`guid` BETWEEN 920015000 AND 920015001;

-- Illari's Loot Cache (418855): type 2, model 10; quests 79242; 2 spawn(s).
SET @EVERLAKE_G418855 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 418855) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 418855);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 418855, 2, 10, 'Illari''s Loot Cache', '', '', '', 1.0, 0, 26974, 0, 0, 0, 0, 0, 0, 0, 0, 116960, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G418855 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 418855, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=418855' FROM DUAL WHERE @EVERLAKE_G418855 = 1;
SET @EVERLAKE_GS418855 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 418855) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 418855 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 418855, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015002 AS `guid`, 0 AS `map`, -1803.73 AS `x`, -4250.67 AS `y`, 2.13 AS `z`
  UNION ALL
  SELECT 920015003 AS `guid`, 0 AS `map`, -1796.53 AS `x`, -4254.27 AS `y`, 0.70 AS `z`
) s WHERE @EVERLAKE_GS418855 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=418855 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS418855 = 1 AND g.`id` = 418855 AND g.`guid` BETWEEN 920015002 AND 920015003;

-- Red Bag (457056): type 2, model 123945; quests 84146, 84211; 1 spawn(s).
SET @EVERLAKE_G457056 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 457056) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 457056);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 457056, 2, 123945, 'Red Bag', '', '', '', 2.0, 0, 27690, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G457056 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 457056, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=457056' FROM DUAL WHERE @EVERLAKE_G457056 = 1;
SET @EVERLAKE_GS457056 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 457056) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 457056 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 457056, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015004 AS `guid`, 0 AS `map`, -7509.51 AS `x`, -1819.12 AS `y`, 228.32 AS `z`
) s WHERE @EVERLAKE_GS457056 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=457056 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS457056 = 1 AND g.`id` = 457056 AND g.`guid` BETWEEN 920015004 AND 920015004;

-- Mysterious Chest (462236): type 2, model 259; quests 84332; 1 spawn(s).
SET @EVERLAKE_G462236 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 462236) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 462236);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 462236, 2, 259, 'Mysterious Chest', '', '', '', 0.5, 0, 27727, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G462236 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 462236, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=462236' FROM DUAL WHERE @EVERLAKE_G462236 = 1;
SET @EVERLAKE_GS462236 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 462236) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 462236 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 462236, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015005 AS `guid`, 0 AS `map`, 1232.07 AS `x`, -3435.02 AS `y`, 288.76 AS `z`
) s WHERE @EVERLAKE_GS462236 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=462236 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS462236 = 1 AND g.`id` = 462236 AND g.`guid` BETWEEN 920015005 AND 920015005;

-- Ashen Soil (613773): type 10, model 20; quests 93547; 1 spawn(s) (template from file 995).
SET @EVERLAKE_GS613773 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 613773) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 613773 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 613773, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015006 AS `guid`, 1 AS `map`, 5174.65 AS `x`, -3388.69 AS `y`, 1627.86 AS `z`
) s WHERE @EVERLAKE_GS613773 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=613773 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS613773 = 1 AND g.`id` = 613773 AND g.`guid` BETWEEN 920015006 AND 920015006;

-- Dried Hanging Herbs (617129): type 10, model 117833; quests 93828; 4 spawn(s) (template from file 995).
SET @EVERLAKE_GS617129 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 617129) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 617129 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 617129, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015007 AS `guid`, 1 AS `map`, 4491.85 AS `x`, -1627.92 AS `y`, 1287.61 AS `z`
  UNION ALL
  SELECT 920015008 AS `guid`, 1 AS `map`, 4471.02 AS `x`, -1641.81 AS `y`, 1284.63 AS `z`
  UNION ALL
  SELECT 920015009 AS `guid`, 1 AS `map`, 4477.96 AS `x`, -1673.07 AS `y`, 1285.16 AS `z`
  UNION ALL
  SELECT 920015010 AS `guid`, 1 AS `map`, 4459.44 AS `x`, -1676.54 AS `y`, 1284.93 AS `z`
) s WHERE @EVERLAKE_GS617129 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=617129 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS617129 = 1 AND g.`id` = 617129 AND g.`guid` BETWEEN 920015007 AND 920015010;

-- Loamy Soil (621767): type 10, model 49; quests 94843; 9 spawn(s) (template from file 995).
SET @EVERLAKE_GS621767 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 621767) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 621767 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 621767, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015011 AS `guid`, 0 AS `map`, -8578.03 AS `x`, -3700.72 AS `y`, 36.79 AS `z`
  UNION ALL
  SELECT 920015012 AS `guid`, 0 AS `map`, -8451.93 AS `x`, -3720.12 AS `y`, 42.36 AS `z`
  UNION ALL
  SELECT 920015013 AS `guid`, 0 AS `map`, -8513.37 AS `x`, -3744.37 AS `y`, 34.28 AS `z`
  UNION ALL
  SELECT 920015014 AS `guid`, 0 AS `map`, -8364.63 AS `x`, -3754.07 AS `y`, 42.63 AS `z`
  UNION ALL
  SELECT 920015015 AS `guid`, 0 AS `map`, -8481.03 AS `x`, -3768.62 AS `y`, 38.69 AS `z`
  UNION ALL
  SELECT 920015016 AS `guid`, 0 AS `map`, -8493.97 AS `x`, -3773.47 AS `y`, 35.66 AS `z`
  UNION ALL
  SELECT 920015017 AS `guid`, 0 AS `map`, -8545.70 AS `x`, -3788.02 AS `y`, 32.84 AS `z`
  UNION ALL
  SELECT 920015018 AS `guid`, 0 AS `map`, -8426.07 AS `x`, -3807.42 AS `y`, 45.66 AS `z`
  UNION ALL
  SELECT 920015019 AS `guid`, 0 AS `map`, -8500.43 AS `x`, -3817.12 AS `y`, 26.06 AS `z`
) s WHERE @EVERLAKE_GS621767 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=621767 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS621767 = 1 AND g.`id` = 621767 AND g.`guid` BETWEEN 920015011 AND 920015019;

-- Loose Soil (621813): type 10, model 20; quests 94829; 5 spawn(s) (template from file 995).
SET @EVERLAKE_GS621813 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 621813) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 621813 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 621813, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015020 AS `guid`, 0 AS `map`, -7918.43 AS `x`, -4180.87 AS `y`, 24.97 AS `z`
  UNION ALL
  SELECT 920015021 AS `guid`, 0 AS `map`, -7863.47 AS `x`, -4239.07 AS `y`, 26.22 AS `z`
  UNION ALL
  SELECT 920015022 AS `guid`, 0 AS `map`, -7915.20 AS `x`, -4239.07 AS `y`, 25.86 AS `z`
  UNION ALL
  SELECT 920015023 AS `guid`, 0 AS `map`, -7866.70 AS `x`, -4243.92 AS `y`, 26.28 AS `z`
  UNION ALL
  SELECT 920015024 AS `guid`, 0 AS `map`, -7882.87 AS `x`, -4248.77 AS `y`, 26.46 AS `z`
) s WHERE @EVERLAKE_GS621813 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=621813 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS621813 = 1 AND g.`id` = 621813 AND g.`guid` BETWEEN 920015020 AND 920015024;

-- Cannon Ammunition (629425): type 10, model 4177; quests 95165; 1 spawn(s) (template from file 995).
SET @EVERLAKE_GS629425 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 629425) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 629425 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 629425, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015025 AS `guid`, 0 AS `map`, -7300.87 AS `x`, -6179.07 AS `y`, 12.60 AS `z`
) s WHERE @EVERLAKE_GS629425 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=629425 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS629425 = 1 AND g.`id` = 629425 AND g.`guid` BETWEEN 920015025 AND 920015025;

-- Cannon Ammunition (629426): type 10, model 4177; quests 95165; 2 spawn(s) (template from file 995).
SET @EVERLAKE_GS629426 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 629426) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 629426 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 629426, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015026 AS `guid`, 0 AS `map`, -7414.03 AS `x`, -6280.92 AS `y`, 13.32 AS `z`
  UNION ALL
  SELECT 920015027 AS `guid`, 0 AS `map`, -7423.73 AS `x`, -6285.77 AS `y`, 13.41 AS `z`
) s WHERE @EVERLAKE_GS629426 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=629426 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS629426 = 1 AND g.`id` = 629426 AND g.`guid` BETWEEN 920015026 AND 920015027;

-- Cannon Ammunition (629427): type 10, model 4177; quests 95165; 2 spawn(s) (template from file 995).
SET @EVERLAKE_GS629427 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 629427) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 629427 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 629427, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015028 AS `guid`, 0 AS `map`, -7743.83 AS `x`, -6300.32 AS `y`, 22.37 AS `z`
  UNION ALL
  SELECT 920015029 AS `guid`, 0 AS `map`, -7737.37 AS `x`, -6305.17 AS `y`, 13.68 AS `z`
) s WHERE @EVERLAKE_GS629427 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=629427 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS629427 = 1 AND g.`id` = 629427 AND g.`guid` BETWEEN 920015028 AND 920015029;

-- Old Chest (642451): type 2, model 5744; quests 95599; 1 spawn(s) (template from file 995).
SET @EVERLAKE_GS642451 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 642451) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 642451 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 642451, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015030 AS `guid`, 1 AS `map`, -4655.53 AS `x`, -62.73 AS `y`, 75.00 AS `z`
) s WHERE @EVERLAKE_GS642451 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=642451 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS642451 = 1 AND g.`id` = 642451 AND g.`guid` BETWEEN 920015030 AND 920015030;

-- Corrupted Growth (651430): type 10, model 425; quests 96296; 10 spawn(s) (template from file 995).
SET @EVERLAKE_GS651430 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 651430) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 651430 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 651430, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015031 AS `guid`, 1 AS `map`, 4940.88 AS `x`, -2576.02 AS `y`, 1427.38 AS `z`
  UNION ALL
  SELECT 920015032 AS `guid`, 1 AS `map`, 5003.37 AS `x`, -2603.81 AS `y`, 1424.16 AS `z`
  UNION ALL
  SELECT 920015033 AS `guid`, 1 AS `map`, 4989.48 AS `x`, -2603.81 AS `y`, 1423.91 AS `z`
  UNION ALL
  SELECT 920015034 AS `guid`, 1 AS `map`, 4994.11 AS `x`, -2614.23 AS `y`, 1424.46 AS `z`
  UNION ALL
  SELECT 920015035 AS `guid`, 1 AS `map`, 5003.37 AS `x`, -2617.70 AS `y`, 1424.84 AS `z`
  UNION ALL
  SELECT 920015036 AS `guid`, 1 AS `map`, 5033.46 AS `x`, -2628.12 AS `y`, 1428.27 AS `z`
  UNION ALL
  SELECT 920015037 AS `guid`, 1 AS `map`, 4933.93 AS `x`, -2638.54 AS `y`, 1427.37 AS `z`
  UNION ALL
  SELECT 920015038 AS `guid`, 1 AS `map`, 4936.25 AS `x`, -2648.96 AS `y`, 1427.02 AS `z`
  UNION ALL
  SELECT 920015039 AS `guid`, 1 AS `map`, 4906.16 AS `x`, -2683.69 AS `y`, 1433.45 AS `z`
  UNION ALL
  SELECT 920015040 AS `guid`, 1 AS `map`, 5005.68 AS `x`, -2701.05 AS `y`, 1428.85 AS `z`
) s WHERE @EVERLAKE_GS651430 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=651430 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS651430 = 1 AND g.`id` = 651430 AND g.`guid` BETWEEN 920015031 AND 920015040;

-- Northern Sentinel Stone (651979): type 10, model 84873; quests 93127; 1 spawn(s) (template from file 995).
SET @EVERLAKE_GS651979 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 651979) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 651979 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 651979, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015041 AS `guid`, 1 AS `map`, 5688.49 AS `x`, -3801.97 AS `y`, 1656.88 AS `z`
) s WHERE @EVERLAKE_GS651979 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=651979 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS651979 = 1 AND g.`id` = 651979 AND g.`guid` BETWEEN 920015041 AND 920015041;

-- Southern Sentinel Stone (651986): type 10, model 84873; quests 93127; 2 spawn(s) (template from file 995).
SET @EVERLAKE_GS651986 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 651986) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 651986 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 651986, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015042 AS `guid`, 1 AS `map`, 5457.03 AS `x`, -3861.00 AS `y`, 1632.99 AS `z`
  UNION ALL
  SELECT 920015043 AS `guid`, 1 AS `map`, 5463.97 AS `x`, -3867.95 AS `y`, 1635.19 AS `z`
) s WHERE @EVERLAKE_GS651986 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=651986 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS651986 = 1 AND g.`id` = 651986 AND g.`guid` BETWEEN 920015042 AND 920015043;

-- Western Sentinel Stone (651987): type 10, model 84873; quests 93127; 1 spawn(s) (template from file 995).
SET @EVERLAKE_GS651987 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 651987) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 651987 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 651987, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015044 AS `guid`, 1 AS `map`, 5669.97 AS `x`, -3301.86 AS `y`, 1606.08 AS `z`
) s WHERE @EVERLAKE_GS651987 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=651987 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS651987 = 1 AND g.`id` = 651987 AND g.`guid` BETWEEN 920015044 AND 920015044;

-- South Bonfire (656668): type 10, model 324; quests 96959; 1 spawn(s) (template from file 995).
SET @EVERLAKE_GS656668 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 656668) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 656668 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 656668, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015045 AS `guid`, 1 AS `map`, 5470.92 AS `x`, -2631.59 AS `y`, 1481.51 AS `z`
) s WHERE @EVERLAKE_GS656668 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=656668 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS656668 = 1 AND g.`id` = 656668 AND g.`guid` BETWEEN 920015045 AND 920015045;

-- Southeast Bonfire (656669): type 10, model 324; quests 96959; 1 spawn(s) (template from file 995).
SET @EVERLAKE_GS656669 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 656669) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 656669 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 656669, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015046 AS `guid`, 1 AS `map`, 5382.96 AS `x`, -2826.08 AS `y`, 1510.51 AS `z`
) s WHERE @EVERLAKE_GS656669 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=656669 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS656669 = 1 AND g.`id` = 656669 AND g.`guid` BETWEEN 920015046 AND 920015046;

-- Ashen Soil (659199): type 10, model 20; quests 93547; 1 spawn(s) (template from file 995).
SET @EVERLAKE_GS659199 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 659199) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 659199 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 659199, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015047 AS `guid`, 1 AS `map`, 5244.09 AS `x`, -3333.12 AS `y`, 1647.75 AS `z`
) s WHERE @EVERLAKE_GS659199 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=659199 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS659199 = 1 AND g.`id` = 659199 AND g.`guid` BETWEEN 920015047 AND 920015047;

-- Ashen Soil (659200): type 10, model 20; quests 93547; 1 spawn(s) (template from file 995).
SET @EVERLAKE_GS659200 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 659200) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 659200 AND `guid` NOT BETWEEN 920015000 AND 920015999);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 659200, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920015048 AS `guid`, 1 AS `map`, 5181.59 AS `x`, -3353.96 AS `y`, 1636.94 AS `z`
) s WHERE @EVERLAKE_GS659200 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=659200 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS659200 = 1 AND g.`id` = 659200 AND g.`guid` BETWEEN 920015048 AND 920015048;

COMMIT;
