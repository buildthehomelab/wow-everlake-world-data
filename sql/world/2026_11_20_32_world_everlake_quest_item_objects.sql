-- World objects that hand out quest items the realm has no source for (the tracker's "item not obtainable" quest
-- objectives), from Icy Veins' WoW Forever database (https://db.icy-veins.com/wow-forever/: name, type, model, size, data
-- fields and the quest item each object gives, recorded by players' addons) and Wowhead's WoW Forever object pages
-- (https://www.wowhead.com/forever, read 2026-11-20 through the tracker's kept pages: map points).
-- 2026_11_20_32_world_everlake_quest_item_objects.sql: written from public data by a script, checked by hand.
--
-- For each object: its template where the realm has none; the quest item in the loot of the template's loot id (Data1),
-- quest-only, 100%, one at a time; the gameobject_questitem row; spawns where the realm has none of it.
-- Spawns: one per Wowhead point at least 5 yards apart, at most 15, turned into a world position with the client's
-- UiMapAssignment rectangles and the height from the realm's maps and vmaps (ForeverTracker tools/height.py). Points
-- on water or on top of a model are left out. Orientation 0, rotation 0, respawn 120 s and one item per loot are INFERRED.
-- Held back (need a look in game): Highborne Tablet (524260): inside ruins with several floors; Sesspira's Hoard (524759): inside ruins with several floors; Admiral's Treasure Chest (629472): inside a building with several floors; Anastasia's Stash (656405): inside a building with several floors.
-- Not here: 5 objects with no point on any source (660624, 410528, 650929, 642943, 412261).
-- Guids: objects 920015049 upward, in the quest-object block (920015000-920015999).
-- Each added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing. Not tried in game.
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
SET @EVERLAKE_FILE := '2026_11_20_32_world_everlake_quest_item_objects.sql';
START TRANSACTION;

-- Satyrweed Bramble (507746): gives item 235470 for quest 86926; 15 spawn(s).
SET @EVERLAKE_G507746 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 507746);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 507746, 3, 391, 'Satyrweed Bramble', '', '', '', 1.25, 43, 130360, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G507746 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 507746, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=507746' FROM DUAL WHERE @EVERLAKE_G507746 = 1;
SET @EVERLAKE_L507746 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 507746 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L507746 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L507746 AND `Item` = 235470);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L507746, 0, 235470, 100, 1, 1, 0, 1, 1, 'Satyrweed Bramble' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L507746, 0, 235470, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=507746: gathers item 235470' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 507746 AND `ItemId` = 235470);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 507746);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 507746, @EVERLAKE_QX, 235470, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 507746, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=507746: quest item 235470' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS507746 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 507746) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 507746 AND `guid` NOT BETWEEN 920015049 AND 920015063);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 507746, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015049 AS `guid`, 1 AS `map`, 4631.60 AS `x`, -6121.82 AS `y`, 103.85 AS `z`
  UNION ALL
  SELECT 920015050 AS `guid`, 1 AS `map`, 4655.27 AS `x`, -6126.89 AS `y`, 101.42 AS `z`
  UNION ALL
  SELECT 920015051 AS `guid`, 1 AS `map`, 4601.17 AS `x`, -6152.25 AS `y`, 102.65 AS `z`
  UNION ALL
  SELECT 920015052 AS `guid`, 1 AS `map`, 4675.56 AS `x`, -6157.32 AS `y`, 105.66 AS `z`
  UNION ALL
  SELECT 920015053 AS `guid`, 1 AS `map`, 4641.75 AS `x`, -6157.32 AS `y`, 101.83 AS `z`
  UNION ALL
  SELECT 920015054 AS `guid`, 1 AS `map`, 4594.41 AS `x`, -6213.10 AS `y`, 101.15 AS `z`
  UNION ALL
  SELECT 920015055 AS `guid`, 1 AS `map`, 4567.36 AS `x`, -6228.31 AS `y`, 100.62 AS `z`
  UNION ALL
  SELECT 920015056 AS `guid`, 1 AS `map`, 4536.93 AS `x`, -6233.38 AS `y`, 99.72 AS `z`
  UNION ALL
  SELECT 920015057 AS `guid`, 1 AS `map`, 4651.89 AS `x`, -6248.59 AS `y`, 108.97 AS `z`
  UNION ALL
  SELECT 920015058 AS `guid`, 1 AS `map`, 4601.17 AS `x`, -6258.73 AS `y`, 108.13 AS `z`
  UNION ALL
  SELECT 920015059 AS `guid`, 1 AS `map`, 4560.60 AS `x`, -6263.80 AS `y`, 103.69 AS `z`
  UNION ALL
  SELECT 920015060 AS `guid`, 1 AS `map`, 4624.84 AS `x`, -6268.87 AS `y`, 108.81 AS `z`
  UNION ALL
  SELECT 920015061 AS `guid`, 1 AS `map`, 4523.40 AS `x`, -6268.87 AS `y`, 107.89 AS `z`
  UNION ALL
  SELECT 920015062 AS `guid`, 1 AS `map`, 4570.74 AS `x`, -6299.30 AS `y`, 110.46 AS `z`
  UNION ALL
  SELECT 920015063 AS `guid`, 1 AS `map`, 4520.02 AS `x`, -6304.37 AS `y`, 116.87 AS `z`
) s WHERE @EVERLAKE_GS507746 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=507746 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS507746 = 1 AND g.`id` = 507746 AND g.`guid` BETWEEN 920015049 AND 920015063;

-- Untainted Soil (562377): gives item 247889 for quest 91754; 15 spawn(s).
SET @EVERLAKE_G562377 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 562377);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 562377, 3, 109815, 'Untainted Soil', '', '', '', 0.75, 43, 134456, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 151327, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G562377 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 562377, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=562377' FROM DUAL WHERE @EVERLAKE_G562377 = 1;
SET @EVERLAKE_L562377 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 562377 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L562377 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L562377 AND `Item` = 247889);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L562377, 0, 247889, 100, 1, 1, 0, 1, 1, 'Untainted Soil' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L562377, 0, 247889, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=562377: gathers item 247889' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 562377 AND `ItemId` = 247889);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 562377);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 562377, @EVERLAKE_QX, 247889, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 562377, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=562377: quest item 247889' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS562377 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 562377) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 562377 AND `guid` NOT BETWEEN 920015064 AND 920015078);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 562377, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015064 AS `guid`, 1 AS `map`, 4315.94 AS `x`, -2725.36 AS `y`, 1085.30 AS `z`
  UNION ALL
  SELECT 920015065 AS `guid`, 1 AS `map`, 4315.94 AS `x`, -2767.04 AS `y`, 1086.81 AS `z`
  UNION ALL
  SELECT 920015066 AS `guid`, 1 AS `map`, 4251.13 AS `x`, -2770.51 AS `y`, 1106.98 AS `z`
  UNION ALL
  SELECT 920015067 AS `guid`, 1 AS `map`, 4232.61 AS `x`, -2808.71 AS `y`, 1109.03 AS `z`
  UNION ALL
  SELECT 920015068 AS `guid`, 1 AS `map`, 4248.82 AS `x`, -2812.18 AS `y`, 1099.97 AS `z`
  UNION ALL
  SELECT 920015069 AS `guid`, 1 AS `map`, 4248.82 AS `x`, -2846.91 AS `y`, 1091.98 AS `z`
  UNION ALL
  SELECT 920015070 AS `guid`, 1 AS `map`, 4329.83 AS `x`, -2857.33 AS `y`, 1071.08 AS `z`
  UNION ALL
  SELECT 920015071 AS `guid`, 1 AS `map`, 4399.26 AS `x`, -2874.70 AS `y`, 1081.34 AS `z`
  UNION ALL
  SELECT 920015072 AS `guid`, 1 AS `map`, 4251.13 AS `x`, -2892.06 AS `y`, 1084.92 AS `z`
  UNION ALL
  SELECT 920015073 AS `guid`, 1 AS `map`, 4299.74 AS `x`, -2902.48 AS `y`, 1080.42 AS `z`
  UNION ALL
  SELECT 920015074 AS `guid`, 1 AS `map`, 4304.37 AS `x`, -2905.95 AS `y`, 1079.45 AS `z`
  UNION ALL
  SELECT 920015075 AS `guid`, 1 AS `map`, 4214.10 AS `x`, -2905.95 AS `y`, 1091.42 AS `z`
  UNION ALL
  SELECT 920015076 AS `guid`, 1 AS `map`, 4209.47 AS `x`, -2912.90 AS `y`, 1094.74 AS `z`
  UNION ALL
  SELECT 920015077 AS `guid`, 1 AS `map`, 4396.95 AS `x`, -2964.99 AS `y`, 1033.03 AS `z`
  UNION ALL
  SELECT 920015078 AS `guid`, 1 AS `map`, 4258.07 AS `x`, -2975.41 AS `y`, 1080.57 AS `z`
) s WHERE @EVERLAKE_GS562377 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=562377 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS562377 = 1 AND g.`id` = 562377 AND g.`guid` BETWEEN 920015064 AND 920015078;

-- Tangle of Wire (571603): gives item 250775 for quest 92011; 15 spawn(s).
SET @EVERLAKE_G571603 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 571603);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 571603, 3, 112418, 'Tangle of Wire', '', '', '', 0.5, 57, 139854, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5121, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2180, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G571603 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 571603, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=571603' FROM DUAL WHERE @EVERLAKE_G571603 = 1;
SET @EVERLAKE_L571603 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 571603 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L571603 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L571603 AND `Item` = 250775);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L571603, 0, 250775, 100, 1, 1, 0, 1, 1, 'Tangle of Wire' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L571603, 0, 250775, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=571603: gathers item 250775' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 571603 AND `ItemId` = 250775);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 571603);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 571603, @EVERLAKE_QX, 250775, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 571603, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=571603: quest item 250775' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS571603 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 571603) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 571603 AND `guid` NOT BETWEEN 920015079 AND 920015093);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 571603, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015079 AS `guid`, 1 AS `map`, 5463.97 AS `x`, -2610.75 AS `y`, 1482.77 AS `z`
  UNION ALL
  SELECT 920015080 AS `guid`, 1 AS `map`, 5459.34 AS `x`, -2614.23 AS `y`, 1482.97 AS `z`
  UNION ALL
  SELECT 920015081 AS `guid`, 1 AS `map`, 5605.16 AS `x`, -2655.90 AS `y`, 1494.97 AS `z`
  UNION ALL
  SELECT 920015082 AS `guid`, 1 AS `map`, 5440.83 AS `x`, -2662.85 AS `y`, 1485.88 AS `z`
  UNION ALL
  SELECT 920015083 AS `guid`, 1 AS `map`, 5426.94 AS `x`, -2708.00 AS `y`, 1485.80 AS `z`
  UNION ALL
  SELECT 920015084 AS `guid`, 1 AS `map`, 5575.07 AS `x`, -2753.14 AS `y`, 1496.64 AS `z`
  UNION ALL
  SELECT 920015085 AS `guid`, 1 AS `map`, 5512.58 AS `x`, -2767.04 AS `y`, 1499.79 AS `z`
  UNION ALL
  SELECT 920015086 AS `guid`, 1 AS `map`, 5295.01 AS `x`, -2780.93 AS `y`, 1511.06 AS `z`
  UNION ALL
  SELECT 920015087 AS `guid`, 1 AS `map`, 5301.95 AS `x`, -2784.40 AS `y`, 1510.97 AS `z`
  UNION ALL
  SELECT 920015088 AS `guid`, 1 AS `map`, 5623.68 AS `x`, -2798.29 AS `y`, 1510.93 AS `z`
  UNION ALL
  SELECT 920015089 AS `guid`, 1 AS `map`, 5588.96 AS `x`, -2815.66 AS `y`, 1508.89 AS `z`
  UNION ALL
  SELECT 920015090 AS `guid`, 1 AS `map`, 5276.49 AS `x`, -2895.53 AS `y`, 1529.60 AS `z`
  UNION ALL
  SELECT 920015091 AS `guid`, 1 AS `map`, 5505.63 AS `x`, -2923.32 AS `y`, 1538.42 AS `z`
  UNION ALL
  SELECT 920015092 AS `guid`, 1 AS `map`, 5269.55 AS `x`, -3072.65 AS `y`, 1573.81 AS `z`
  UNION ALL
  SELECT 920015093 AS `guid`, 1 AS `map`, 5387.59 AS `x`, -3100.44 AS `y`, 1581.66 AS `z`
) s WHERE @EVERLAKE_GS571603 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=571603 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS571603 = 1 AND g.`id` = 571603 AND g.`guid` BETWEEN 920015079 AND 920015093;

-- Horde Flag (577731): gives item 253249 for quest 91794; 2 spawn(s).
SET @EVERLAKE_G577731 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 577731);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 577731, 3, 5111, 'Horde Flag', '', '', '', 0.5, 93, 135895, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4105, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G577731 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 577731, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=577731' FROM DUAL WHERE @EVERLAKE_G577731 = 1;
SET @EVERLAKE_L577731 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 577731 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L577731 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L577731 AND `Item` = 253249);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L577731, 0, 253249, 100, 1, 1, 0, 1, 1, 'Horde Flag' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L577731, 0, 253249, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=577731: gathers item 253249' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 577731 AND `ItemId` = 253249);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 577731);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 577731, @EVERLAKE_QX, 253249, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 577731, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=577731: quest item 253249' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS577731 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 577731) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 577731 AND `guid` NOT BETWEEN 920015094 AND 920015095);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 577731, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015094 AS `guid`, 1 AS `map`, 5445.46 AS `x`, -2648.96 AS `y`, 1485.39 AS `z`
  UNION ALL
  SELECT 920015095 AS `guid`, 1 AS `map`, 5565.81 AS `x`, -2652.43 AS `y`, 1484.74 AS `z`
) s WHERE @EVERLAKE_GS577731 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=577731 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS577731 = 1 AND g.`id` = 577731 AND g.`guid` BETWEEN 920015094 AND 920015095;

-- Moonveil Moss (617262): gives item 262802 for quest 93825; 15 spawn(s).
SET @EVERLAKE_G617262 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 617262);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 617262, 3, 117892, 'Moonveil Moss', '', '', '', 0.75, 4492, 137685, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 181, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G617262 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 617262, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=617262' FROM DUAL WHERE @EVERLAKE_G617262 = 1;
SET @EVERLAKE_L617262 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 617262 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L617262 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L617262 AND `Item` = 262802);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L617262, 0, 262802, 100, 1, 1, 0, 1, 1, 'Moonveil Moss' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L617262, 0, 262802, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=617262: gathers item 262802' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 617262 AND `ItemId` = 262802);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 617262);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 617262, @EVERLAKE_QX, 262802, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 617262, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=617262: quest item 262802' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS617262 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 617262) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 617262 AND `guid` NOT BETWEEN 920015096 AND 920015110);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 617262, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015096 AS `guid`, 1 AS `map`, 5019.57 AS `x`, -1374.40 AS `y`, 1341.20 AS `z`
  UNION ALL
  SELECT 920015097 AS `guid`, 1 AS `map`, 5031.15 AS `x`, -1377.87 AS `y`, 1339.80 AS `z`
  UNION ALL
  SELECT 920015098 AS `guid`, 1 AS `map`, 5063.55 AS `x`, -1412.60 AS `y`, 1338.94 AS `z`
  UNION ALL
  SELECT 920015099 AS `guid`, 1 AS `map`, 5227.88 AS `x`, -1419.54 AS `y`, 1359.96 AS `z`
  UNION ALL
  SELECT 920015100 AS `guid`, 1 AS `map`, 5237.14 AS `x`, -1426.49 AS `y`, 1360.82 AS `z`
  UNION ALL
  SELECT 920015101 AS `guid`, 1 AS `map`, 5042.72 AS `x`, -1429.96 AS `y`, 1335.74 AS `z`
  UNION ALL
  SELECT 920015102 AS `guid`, 1 AS `map`, 5107.53 AS `x`, -1478.58 AS `y`, 1344.20 AS `z`
  UNION ALL
  SELECT 920015103 AS `guid`, 1 AS `map`, 5190.85 AS `x`, -1509.84 AS `y`, 1354.39 AS `z`
  UNION ALL
  SELECT 920015104 AS `guid`, 1 AS `map`, 4718.68 AS `x`, -1600.14 AS `y`, 1297.60 AS `z`
  UNION ALL
  SELECT 920015105 AS `guid`, 1 AS `map`, 4683.96 AS `x`, -1620.97 AS `y`, 1290.70 AS `z`
  UNION ALL
  SELECT 920015106 AS `guid`, 1 AS `map`, 4802.00 AS `x`, -1686.96 AS `y`, 1150.45 AS `z`
  UNION ALL
  SELECT 920015107 AS `guid`, 1 AS `map`, 4489.53 AS `x`, -1881.44 AS `y`, 1237.27 AS `z`
  UNION ALL
  SELECT 920015108 AS `guid`, 1 AS `map`, 4572.86 AS `x`, -1884.91 AS `y`, 1159.33 AS `z`
  UNION ALL
  SELECT 920015109 AS `guid`, 1 AS `map`, 4584.43 AS `x`, -1933.54 AS `y`, 1155.84 AS `z`
  UNION ALL
  SELECT 920015110 AS `guid`, 1 AS `map`, 4422.41 AS `x`, -1933.54 AS `y`, 1241.41 AS `z`
) s WHERE @EVERLAKE_GS617262 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=617262 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS617262 = 1 AND g.`id` = 617262 AND g.`guid` BETWEEN 920015096 AND 920015110;

-- Bear Berries (617265): gives item 262818 for quest 93831; 15 spawn(s).
SET @EVERLAKE_G617265 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 617265);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 617265, 3, 129264, 'Bear Berries', '', '', '', 0.75, 57, 137686, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 181, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G617265 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 617265, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=617265' FROM DUAL WHERE @EVERLAKE_G617265 = 1;
SET @EVERLAKE_L617265 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 617265 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L617265 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L617265 AND `Item` = 262818);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L617265, 0, 262818, 100, 1, 1, 0, 1, 1, 'Bear Berries' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L617265, 0, 262818, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=617265: gathers item 262818' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 617265 AND `ItemId` = 262818);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 617265);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 617265, @EVERLAKE_QX, 262818, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 617265, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=617265: quest item 262818' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS617265 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 617265) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 617265 AND `guid` NOT BETWEEN 920015111 AND 920015125);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 617265, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015111 AS `guid`, 1 AS `map`, 5119.10 AS `x`, -1311.88 AS `y`, 1358.34 AS `z`
  UNION ALL
  SELECT 920015112 AS `guid`, 1 AS `map`, 5195.48 AS `x`, -1346.61 AS `y`, 1361.44 AS `z`
  UNION ALL
  SELECT 920015113 AS `guid`, 1 AS `map`, 5035.77 AS `x`, -1377.87 AS `y`, 1339.71 AS `z`
  UNION ALL
  SELECT 920015114 AS `guid`, 1 AS `map`, 5225.57 AS `x`, -1412.60 AS `y`, 1359.87 AS `z`
  UNION ALL
  SELECT 920015115 AS `guid`, 1 AS `map`, 5239.46 AS `x`, -1429.96 AS `y`, 1360.99 AS `z`
  UNION ALL
  SELECT 920015116 AS `guid`, 1 AS `map`, 5281.12 AS `x`, -1489.00 AS `y`, 1364.60 AS `z`
  UNION ALL
  SELECT 920015117 AS `guid`, 1 AS `map`, 5197.80 AS `x`, -1492.47 AS `y`, 1350.75 AS `z`
  UNION ALL
  SELECT 920015118 AS `guid`, 1 AS `map`, 5237.14 AS `x`, -1523.73 AS `y`, 1356.16 AS `z`
  UNION ALL
  SELECT 920015119 AS `guid`, 1 AS `map`, 4725.62 AS `x`, -1589.72 AS `y`, 1300.66 AS `z`
  UNION ALL
  SELECT 920015120 AS `guid`, 1 AS `map`, 4813.57 AS `x`, -1593.19 AS `y`, 1306.47 AS `z`
  UNION ALL
  SELECT 920015121 AS `guid`, 1 AS `map`, 4808.95 AS `x`, -1596.66 AS `y`, 1305.98 AS `z`
  UNION ALL
  SELECT 920015122 AS `guid`, 1 AS `map`, 4681.64 AS `x`, -1620.97 AS `y`, 1290.64 AS `z`
  UNION ALL
  SELECT 920015123 AS `guid`, 1 AS `map`, 4658.50 AS `x`, -1627.92 AS `y`, 1289.25 AS `z`
  UNION ALL
  SELECT 920015124 AS `guid`, 1 AS `map`, 4612.21 AS `x`, -1690.43 AS `y`, 1292.98 AS `z`
  UNION ALL
  SELECT 920015125 AS `guid`, 1 AS `map`, 4561.29 AS `x`, -1721.69 AS `y`, 1275.80 AS `z`
) s WHERE @EVERLAKE_GS617265 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=617265 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS617265 = 1 AND g.`id` = 617265 AND g.`guid` BETWEEN 920015111 AND 920015125;

-- Thorn Bush (617435): gives item 263227 for quest 93407; 9 spawn(s).
SET @EVERLAKE_G617435 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 617435);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 617435, 3, 122827, 'Thorn Bush', '', '', '', 1.0, 43, 137750, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2180, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G617435 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 617435, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=617435' FROM DUAL WHERE @EVERLAKE_G617435 = 1;
SET @EVERLAKE_L617435 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 617435 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L617435 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L617435 AND `Item` = 263227);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L617435, 0, 263227, 100, 1, 1, 0, 1, 1, 'Thorn Bush' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L617435, 0, 263227, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=617435: gathers item 263227' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 617435 AND `ItemId` = 263227);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 617435);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 617435, @EVERLAKE_QX, 263227, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 617435, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=617435: quest item 263227' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS617435 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 617435) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 617435 AND `guid` NOT BETWEEN 920015126 AND 920015134);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 617435, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015126 AS `guid`, 1 AS `map`, 5408.42 AS `x`, -3419.94 AS `y`, 1566.35 AS `z`
  UNION ALL
  SELECT 920015127 AS `guid`, 1 AS `map`, 5278.81 AS `x`, -3461.62 AS `y`, 1572.23 AS `z`
  UNION ALL
  SELECT 920015128 AS `guid`, 1 AS `map`, 5251.03 AS `x`, -3499.82 AS `y`, 1594.09 AS `z`
  UNION ALL
  SELECT 920015129 AS `guid`, 1 AS `map`, 5257.97 AS `x`, -3503.29 AS `y`, 1594.22 AS `z`
  UNION ALL
  SELECT 920015130 AS `guid`, 1 AS `map`, 5276.49 AS `x`, -3510.24 AS `y`, 1593.29 AS `z`
  UNION ALL
  SELECT 920015131 AS `guid`, 1 AS `map`, 5359.82 AS `x`, -3555.39 AS `y`, 1572.42 AS `z`
  UNION ALL
  SELECT 920015132 AS `guid`, 1 AS `map`, 5348.24 AS `x`, -3600.54 AS `y`, 1561.61 AS `z`
  UNION ALL
  SELECT 920015133 AS `guid`, 1 AS `map`, 5450.08 AS `x`, -3607.48 AS `y`, 1561.01 AS `z`
  UNION ALL
  SELECT 920015134 AS `guid`, 1 AS `map`, 5362.13 AS `x`, -3631.79 AS `y`, 1559.09 AS `z`
) s WHERE @EVERLAKE_GS617435 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=617435 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS617435 = 1 AND g.`id` = 617435 AND g.`guid` BETWEEN 920015126 AND 920015134;

-- Ancient Sword (618822): gives item 264501 for quest 97029; 3 spawn(s).
SET @EVERLAKE_G618822 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 618822);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 618822, 3, 129893, 'Ancient Sword', '', '', '', 1.0, 1599, 138025, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 305544, 0, 0, 149737, 0, 0, 4107, 1438, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2180, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G618822 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 618822, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=618822' FROM DUAL WHERE @EVERLAKE_G618822 = 1;
SET @EVERLAKE_L618822 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 618822 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L618822 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L618822 AND `Item` = 264501);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L618822, 0, 264501, 100, 1, 1, 0, 1, 1, 'Ancient Sword' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L618822, 0, 264501, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=618822: gathers item 264501' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 618822 AND `ItemId` = 264501);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 618822);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 618822, @EVERLAKE_QX, 264501, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 618822, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=618822: quest item 264501' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS618822 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 618822) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 618822 AND `guid` NOT BETWEEN 920015135 AND 920015137);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 618822, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015135 AS `guid`, 2991 AS `map`, 2289.96 AS `x`, 1583.50 AS `y`, 743.78 AS `z`
  UNION ALL
  SELECT 920015136 AS `guid`, 2991 AS `map`, 2260.29 AS `x`, 1511.19 AS `y`, 715.30 AS `z`
  UNION ALL
  SELECT 920015137 AS `guid`, 2991 AS `map`, 3354.25 AS `x`, 548.88 AS `y`, 749.70 AS `z`
) s WHERE @EVERLAKE_GS618822 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=618822 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS618822 = 1 AND g.`id` = 618822 AND g.`guid` BETWEEN 920015135 AND 920015137;

-- Scarlet Dart Tuber (626685): gives item 267289 for quest 93759; 15 spawn(s).
SET @EVERLAKE_G626685 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 626685);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 626685, 3, 122946, 'Scarlet Dart Tuber', '', '', '', 0.6, 43, 139185, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 181, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G626685 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 626685, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=626685' FROM DUAL WHERE @EVERLAKE_G626685 = 1;
SET @EVERLAKE_L626685 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 626685 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L626685 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L626685 AND `Item` = 267289);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L626685, 0, 267289, 100, 1, 1, 0, 1, 1, 'Scarlet Dart Tuber' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L626685, 0, 267289, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=626685: gathers item 267289' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 626685 AND `ItemId` = 267289);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 626685);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 626685, @EVERLAKE_QX, 267289, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 626685, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=626685: quest item 267289' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS626685 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 626685) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 626685 AND `guid` NOT BETWEEN 920015138 AND 920015152);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 626685, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015138 AS `guid`, 1 AS `map`, 4570.54 AS `x`, -2905.95 AS `y`, 1078.42 AS `z`
  UNION ALL
  SELECT 920015139 AS `guid`, 1 AS `map`, 4487.22 AS `x`, -2944.15 AS `y`, 1062.14 AS `z`
  UNION ALL
  SELECT 920015140 AS `guid`, 1 AS `map`, 4392.32 AS `x`, -2978.88 AS `y`, 1035.55 AS `z`
  UNION ALL
  SELECT 920015141 AS `guid`, 1 AS `map`, 4686.27 AS `x`, -2985.83 AS `y`, 1078.97 AS `z`
  UNION ALL
  SELECT 920015142 AS `guid`, 1 AS `map`, 4607.58 AS `x`, -3003.19 AS `y`, 1062.90 AS `z`
  UNION ALL
  SELECT 920015143 AS `guid`, 1 AS `map`, 4677.01 AS `x`, -3145.58 AS `y`, 1049.70 AS `z`
  UNION ALL
  SELECT 920015144 AS `guid`, 1 AS `map`, 4468.70 AS `x`, -3166.42 AS `y`, 1034.63 AS `z`
  UNION ALL
  SELECT 920015145 AS `guid`, 1 AS `map`, 4727.93 AS `x`, -3169.89 AS `y`, 1061.67 AS `z`
  UNION ALL
  SELECT 920015146 AS `guid`, 1 AS `map`, 4720.99 AS `x`, -3208.10 AS `y`, 1056.59 AS `z`
  UNION ALL
  SELECT 920015147 AS `guid`, 1 AS `map`, 4716.36 AS `x`, -3215.04 AS `y`, 1053.93 AS `z`
  UNION ALL
  SELECT 920015148 AS `guid`, 1 AS `map`, 4663.13 AS `x`, -3253.24 AS `y`, 1035.74 AS `z`
  UNION ALL
  SELECT 920015149 AS `guid`, 1 AS `map`, 4399.26 AS `x`, -3263.66 AS `y`, 1030.37 AS `z`
  UNION ALL
  SELECT 920015150 AS `guid`, 1 AS `map`, 4503.42 AS `x`, -3267.14 AS `y`, 1018.43 AS `z`
  UNION ALL
  SELECT 920015151 AS `guid`, 1 AS `map`, 4700.16 AS `x`, -3329.65 AS `y`, 1036.35 AS `z`
  UNION ALL
  SELECT 920015152 AS `guid`, 1 AS `map`, 4630.72 AS `x`, -3350.49 AS `y`, 1017.83 AS `z`
) s WHERE @EVERLAKE_GS626685 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=626685 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS626685 = 1 AND g.`id` = 626685 AND g.`guid` BETWEEN 920015138 AND 920015152;

-- Crystallized Fel-Slime (637622): gives item 274412 for quest 95319; 9 spawn(s).
SET @EVERLAKE_G637622 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 637622);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 637622, 3, 86152, 'Crystallized Fel-Slime', '', '', '', 0.3, 4088, 141072, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G637622 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 637622, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=637622' FROM DUAL WHERE @EVERLAKE_G637622 = 1;
SET @EVERLAKE_L637622 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 637622 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L637622 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L637622 AND `Item` = 274412);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L637622, 0, 274412, 100, 1, 1, 0, 1, 1, 'Crystallized Fel-Slime' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L637622, 0, 274412, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=637622: gathers item 274412' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 637622 AND `ItemId` = 274412);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 637622);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 637622, @EVERLAKE_QX, 274412, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 637622, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=637622: quest item 274412' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS637622 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 637622) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 637622 AND `guid` NOT BETWEEN 920015153 AND 920015161);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 637622, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015153 AS `guid`, 1 AS `map`, 4440.93 AS `x`, -2339.87 AS `y`, 1117.26 AS `z`
  UNION ALL
  SELECT 920015154 AS `guid`, 1 AS `map`, 4623.78 AS `x`, -2395.43 AS `y`, 1165.85 AS `z`
  UNION ALL
  SELECT 920015155 AS `guid`, 1 AS `map`, 4570.54 AS `x`, -2433.64 AS `y`, 1099.58 AS `z`
  UNION ALL
  SELECT 920015156 AS `guid`, 1 AS `map`, 4549.71 AS `x`, -2447.53 AS `y`, 1099.32 AS `z`
  UNION ALL
  SELECT 920015157 AS `guid`, 1 AS `map`, 4556.66 AS `x`, -2468.36 AS `y`, 1100.10 AS `z`
  UNION ALL
  SELECT 920015158 AS `guid`, 1 AS `map`, 4339.09 AS `x`, -2485.73 AS `y`, 1092.82 AS `z`
  UNION ALL
  SELECT 920015159 AS `guid`, 1 AS `map`, 4396.95 AS `x`, -2589.92 AS `y`, 1095.95 AS `z`
  UNION ALL
  SELECT 920015160 AS `guid`, 1 AS `map`, 4459.44 AS `x`, -2600.34 AS `y`, 1095.97 AS `z`
  UNION ALL
  SELECT 920015161 AS `guid`, 1 AS `map`, 4466.39 AS `x`, -2610.75 AS `y`, 1095.83 AS `z`
) s WHERE @EVERLAKE_GS637622 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=637622 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS637622 = 1 AND g.`id` = 637622 AND g.`guid` BETWEEN 920015153 AND 920015161;

-- Untainted Flower (642129): gives item 260176 for quest 95568; 10 spawn(s).
SET @EVERLAKE_G642129 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 642129);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 642129, 3, 126317, 'Untainted Flower', '', '', '', 1.2, 43, 140082, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G642129 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 642129, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642129' FROM DUAL WHERE @EVERLAKE_G642129 = 1;
SET @EVERLAKE_L642129 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 642129 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L642129 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L642129 AND `Item` = 260176);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L642129, 0, 260176, 100, 1, 1, 0, 1, 1, 'Untainted Flower' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L642129, 0, 260176, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642129: gathers item 260176' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 642129 AND `ItemId` = 260176);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 642129);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 642129, @EVERLAKE_QX, 260176, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 642129, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642129: quest item 260176' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS642129 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 642129) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 642129 AND `guid` NOT BETWEEN 920015162 AND 920015171);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 642129, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015162 AS `guid`, 1 AS `map`, 4653.87 AS `x`, -3228.93 AS `y`, 1036.29 AS `z`
  UNION ALL
  SELECT 920015163 AS `guid`, 1 AS `map`, 4489.53 AS `x`, -3444.25 AS `y`, 1000.08 AS `z`
  UNION ALL
  SELECT 920015164 AS `guid`, 1 AS `map`, 4440.93 AS `x`, -3472.04 AS `y`, 1007.74 AS `z`
  UNION ALL
  SELECT 920015165 AS `guid`, 1 AS `map`, 4572.86 AS `x`, -3569.28 AS `y`, 986.40 AS `z`
  UNION ALL
  SELECT 920015166 AS `guid`, 1 AS `map`, 4626.09 AS `x`, -3607.48 AS `y`, 970.25 AS `z`
  UNION ALL
  SELECT 920015167 AS `guid`, 1 AS `map`, 4690.90 AS `x`, -3628.32 AS `y`, 967.93 AS `z`
  UNION ALL
  SELECT 920015168 AS `guid`, 1 AS `map`, 4552.03 AS `x`, -3628.32 AS `y`, 980.51 AS `z`
  UNION ALL
  SELECT 920015169 AS `guid`, 1 AS `map`, 4642.30 AS `x`, -3631.79 AS `y`, 965.66 AS `z`
  UNION ALL
  SELECT 920015170 AS `guid`, 1 AS `map`, 4651.55 AS `x`, -3659.58 AS `y`, 958.35 AS `z`
  UNION ALL
  SELECT 920015171 AS `guid`, 1 AS `map`, 4616.83 AS `x`, -3690.83 AS `y`, 957.01 AS `z`
) s WHERE @EVERLAKE_GS642129 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=642129 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS642129 = 1 AND g.`id` = 642129 AND g.`guid` BETWEEN 920015162 AND 920015171;

-- Untainted Flower (642130): gives item 260176 for quest 95568; 9 spawn(s).
SET @EVERLAKE_G642130 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 642130);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 642130, 3, 126316, 'Untainted Flower', '', '', '', 1.2, 43, 140082, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G642130 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 642130, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642130' FROM DUAL WHERE @EVERLAKE_G642130 = 1;
SET @EVERLAKE_L642130 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 642130 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L642130 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L642130 AND `Item` = 260176);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L642130, 0, 260176, 100, 1, 1, 0, 1, 1, 'Untainted Flower' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L642130, 0, 260176, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642130: gathers item 260176' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 642130 AND `ItemId` = 260176);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 642130);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 642130, @EVERLAKE_QX, 260176, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 642130, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642130: quest item 260176' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS642130 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 642130) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 642130 AND `guid` NOT BETWEEN 920015172 AND 920015180);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 642130, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015172 AS `guid`, 1 AS `map`, 4616.83 AS `x`, -3690.83 AS `y`, 957.01 AS `z`
  UNION ALL
  SELECT 920015173 AS `guid`, 1 AS `map`, 4656.18 AS `x`, -3715.14 AS `y`, 949.75 AS `z`
  UNION ALL
  SELECT 920015174 AS `guid`, 1 AS `map`, 4720.99 AS `x`, -3725.56 AS `y`, 951.34 AS `z`
  UNION ALL
  SELECT 920015175 AS `guid`, 1 AS `map`, 4725.62 AS `x`, -3767.24 AS `y`, 948.36 AS `z`
  UNION ALL
  SELECT 920015176 AS `guid`, 1 AS `map`, 4679.33 AS `x`, -3770.71 AS `y`, 943.60 AS `z`
  UNION ALL
  SELECT 920015177 AS `guid`, 1 AS `map`, 4628.41 AS `x`, -3781.13 AS `y`, 945.35 AS `z`
  UNION ALL
  SELECT 920015178 AS `guid`, 1 AS `map`, 4593.69 AS `x`, -3871.42 AS `y`, 944.19 AS `z`
  UNION ALL
  SELECT 920015179 AS `guid`, 1 AS `map`, 4621.46 AS `x`, -3902.68 AS `y`, 944.20 AS `z`
  UNION ALL
  SELECT 920015180 AS `guid`, 1 AS `map`, 4651.55 AS `x`, -3913.10 AS `y`, 944.81 AS `z`
) s WHERE @EVERLAKE_GS642130 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=642130 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS642130 = 1 AND g.`id` = 642130 AND g.`guid` BETWEEN 920015172 AND 920015180;

-- Untainted Flower (642131): gives item 260176 for quest 95568; 10 spawn(s).
SET @EVERLAKE_G642131 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 642131);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 642131, 3, 126318, 'Untainted Flower', '', '', '', 1.2, 43, 140082, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G642131 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 642131, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642131' FROM DUAL WHERE @EVERLAKE_G642131 = 1;
SET @EVERLAKE_L642131 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 642131 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L642131 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L642131 AND `Item` = 260176);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L642131, 0, 260176, 100, 1, 1, 0, 1, 1, 'Untainted Flower' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L642131, 0, 260176, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642131: gathers item 260176' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 642131 AND `ItemId` = 260176);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 642131);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 642131, @EVERLAKE_QX, 260176, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 642131, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=642131: quest item 260176' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS642131 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 642131) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 642131 AND `guid` NOT BETWEEN 920015181 AND 920015190);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 642131, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015181 AS `guid`, 1 AS `map`, 4436.30 AS `x`, -3433.84 AS `y`, 1007.39 AS `z`
  UNION ALL
  SELECT 920015182 AS `guid`, 1 AS `map`, 4542.77 AS `x`, -3451.20 AS `y`, 997.06 AS `z`
  UNION ALL
  SELECT 920015183 AS `guid`, 1 AS `map`, 4558.97 AS `x`, -3590.12 AS `y`, 976.68 AS `z`
  UNION ALL
  SELECT 920015184 AS `guid`, 1 AS `map`, 4589.06 AS `x`, -3597.06 AS `y`, 971.31 AS `z`
  UNION ALL
  SELECT 920015185 AS `guid`, 1 AS `map`, 4521.94 AS `x`, -3604.01 AS `y`, 983.02 AS `z`
  UNION ALL
  SELECT 920015186 AS `guid`, 1 AS `map`, 4697.85 AS `x`, -3621.37 AS `y`, 969.98 AS `z`
  UNION ALL
  SELECT 920015187 AS `guid`, 1 AS `map`, 4646.92 AS `x`, -3652.63 AS `y`, 960.29 AS `z`
  UNION ALL
  SELECT 920015188 AS `guid`, 1 AS `map`, 4651.55 AS `x`, -3656.10 AS `y`, 959.36 AS `z`
  UNION ALL
  SELECT 920015189 AS `guid`, 1 AS `map`, 4677.01 AS `x`, -3663.05 AS `y`, 959.00 AS `z`
  UNION ALL
  SELECT 920015190 AS `guid`, 1 AS `map`, 4709.42 AS `x`, -3666.52 AS `y`, 960.25 AS `z`
) s WHERE @EVERLAKE_GS642131 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=642131 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS642131 = 1 AND g.`id` = 642131 AND g.`guid` BETWEEN 920015181 AND 920015190;

-- Hyjal Owl Egg (644820): gives item 269920 for quest 95569; 15 spawn(s).
SET @EVERLAKE_G644820 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 644820);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 644820, 3, 124000, 'Hyjal Owl Egg', '', '', '', 0.5, 93, 140083, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 1287051, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G644820 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 644820, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=644820' FROM DUAL WHERE @EVERLAKE_G644820 = 1;
SET @EVERLAKE_L644820 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 644820 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L644820 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L644820 AND `Item` = 269920);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L644820, 0, 269920, 100, 1, 1, 0, 1, 1, 'Hyjal Owl Egg' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L644820, 0, 269920, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=644820: gathers item 269920' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 644820 AND `ItemId` = 269920);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 644820);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 644820, @EVERLAKE_QX, 269920, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 644820, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=644820: quest item 269920' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS644820 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 644820) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 644820 AND `guid` NOT BETWEEN 920015191 AND 920015205);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 644820, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015191 AS `guid`, 1 AS `map`, 4558.97 AS `x`, -2958.05 AS `y`, 1063.65 AS `z`
  UNION ALL
  SELECT 920015192 AS `guid`, 1 AS `map`, 4443.24 AS `x`, -3156.00 AS `y`, 1036.73 AS `z`
  UNION ALL
  SELECT 920015193 AS `guid`, 1 AS `map`, 4660.81 AS `x`, -3242.83 AS `y`, 1035.75 AS `z`
  UNION ALL
  SELECT 920015194 AS `guid`, 1 AS `map`, 4457.13 AS `x`, -3319.23 AS `y`, 1016.35 AS `z`
  UNION ALL
  SELECT 920015195 AS `guid`, 1 AS `map`, 4394.64 AS `x`, -3322.70 AS `y`, 1026.10 AS `z`
  UNION ALL
  SELECT 920015196 AS `guid`, 1 AS `map`, 4392.32 AS `x`, -3336.59 AS `y`, 1023.50 AS `z`
  UNION ALL
  SELECT 920015197 AS `guid`, 1 AS `map`, 4390.01 AS `x`, -3378.27 AS `y`, 1021.45 AS `z`
  UNION ALL
  SELECT 920015198 AS `guid`, 1 AS `map`, 4475.65 AS `x`, -3399.11 AS `y`, 1005.49 AS `z`
  UNION ALL
  SELECT 920015199 AS `guid`, 1 AS `map`, 4584.43 AS `x`, -3416.47 AS `y`, 1006.11 AS `z`
  UNION ALL
  SELECT 920015200 AS `guid`, 1 AS `map`, 4575.17 AS `x`, -3416.47 AS `y`, 1004.73 AS `z`
  UNION ALL
  SELECT 920015201 AS `guid`, 1 AS `map`, 4429.35 AS `x`, -3430.36 AS `y`, 1009.55 AS `z`
  UNION ALL
  SELECT 920015202 AS `guid`, 1 AS `map`, 4484.90 AS `x`, -3437.31 AS `y`, 1001.55 AS `z`
  UNION ALL
  SELECT 920015203 AS `guid`, 1 AS `map`, 4396.95 AS `x`, -3437.31 AS `y`, 1023.65 AS `z`
  UNION ALL
  SELECT 920015204 AS `guid`, 1 AS `map`, 4489.53 AS `x`, -3440.78 AS `y`, 1000.69 AS `z`
  UNION ALL
  SELECT 920015205 AS `guid`, 1 AS `map`, 4542.77 AS `x`, -3447.73 AS `y`, 996.98 AS `z`
) s WHERE @EVERLAKE_GS644820 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=644820 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS644820 = 1 AND g.`id` = 644820 AND g.`guid` BETWEEN 920015191 AND 920015205;

-- The Jewel of the Horizon (650219): gives item 272974 for quest 92500; 2 spawn(s).
SET @EVERLAKE_G650219 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 650219);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 650219, 3, 124707, 'The Jewel of the Horizon', '', '', '', 1.0, 4506, 140741, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G650219 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 650219, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=650219' FROM DUAL WHERE @EVERLAKE_G650219 = 1;
SET @EVERLAKE_L650219 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 650219 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L650219 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L650219 AND `Item` = 272974);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L650219, 0, 272974, 100, 1, 1, 0, 1, 1, 'The Jewel of the Horizon' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L650219, 0, 272974, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=650219: gathers item 272974' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 650219 AND `ItemId` = 272974);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 650219);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 650219, @EVERLAKE_QX, 272974, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 650219, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=650219: quest item 272974' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS650219 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 650219) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 650219 AND `guid` NOT BETWEEN 920015206 AND 920015207);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 650219, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015206 AS `guid`, 1 AS `map`, 4929.30 AS `x`, -2579.50 AS `y`, 1428.70 AS `z`
  UNION ALL
  SELECT 920015207 AS `guid`, 1 AS `map`, 4924.67 AS `x`, -2582.97 AS `y`, 1428.59 AS `z`
) s WHERE @EVERLAKE_GS650219 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=650219 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS650219 = 1 AND g.`id` = 650219 AND g.`guid` BETWEEN 920015206 AND 920015207;

-- Azgalor's Remains (650227): gives item 253239 for quest 92335; 3 spawn(s).
SET @EVERLAKE_G650227 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 650227);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 650227, 3, 4173, 'Azgalor''s Remains', '', '', '', 6.0, 43, 135888, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G650227 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 650227, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=650227' FROM DUAL WHERE @EVERLAKE_G650227 = 1;
SET @EVERLAKE_L650227 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 650227 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L650227 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L650227 AND `Item` = 253239);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L650227, 0, 253239, 100, 1, 1, 0, 1, 1, 'Azgalor''s Remains' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L650227, 0, 253239, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=650227: gathers item 253239' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 650227 AND `ItemId` = 253239);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 650227);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 650227, @EVERLAKE_QX, 253239, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 650227, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=650227: quest item 253239' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS650227 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 650227) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 650227 AND `guid` NOT BETWEEN 920015208 AND 920015210);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 650227, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015208 AS `guid`, 1 AS `map`, 5507.95 AS `x`, -2631.59 AS `y`, 1480.65 AS `z`
  UNION ALL
  SELECT 920015209 AS `guid`, 1 AS `map`, 5501.01 AS `x`, -2635.06 AS `y`, 1480.54 AS `z`
  UNION ALL
  SELECT 920015210 AS `guid`, 1 AS `map`, 5507.95 AS `x`, -2642.01 AS `y`, 1480.19 AS `z`
) s WHERE @EVERLAKE_GS650227 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=650227 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS650227 = 1 AND g.`id` = 650227 AND g.`guid` BETWEEN 920015208 AND 920015210;

-- Tarnished Highfeather Bangle (650902): gives item 273164 for quest 96252; 7 spawn(s).
SET @EVERLAKE_G650902 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 650902);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 650902, 3, 124842, 'Tarnished Highfeather Bangle', '', '', '', 0.6, 4088, 140813, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G650902 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 650902, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=650902' FROM DUAL WHERE @EVERLAKE_G650902 = 1;
SET @EVERLAKE_L650902 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 650902 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L650902 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L650902 AND `Item` = 273164);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L650902, 0, 273164, 100, 1, 1, 0, 1, 1, 'Tarnished Highfeather Bangle' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L650902, 0, 273164, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=650902: gathers item 273164' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 650902 AND `ItemId` = 273164);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 650902);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 650902, @EVERLAKE_QX, 273164, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 650902, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=650902: quest item 273164' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS650902 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 650902) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 650902 AND `guid` NOT BETWEEN 920015211 AND 920015217);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 650902, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015211 AS `guid`, 1 AS `map`, 4929.30 AS `x`, -2485.73 AS `y`, 1440.34 AS `z`
  UNION ALL
  SELECT 920015212 AS `guid`, 1 AS `map`, 4929.30 AS `x`, -2579.50 AS `y`, 1428.70 AS `z`
  UNION ALL
  SELECT 920015213 AS `guid`, 1 AS `map`, 4924.67 AS `x`, -2582.97 AS `y`, 1428.59 AS `z`
  UNION ALL
  SELECT 920015214 AS `guid`, 1 AS `map`, 4982.54 AS `x`, -2610.75 AS `y`, 1424.07 AS `z`
  UNION ALL
  SELECT 920015215 AS `guid`, 1 AS `map`, 4922.36 AS `x`, -2662.85 AS `y`, 1428.98 AS `z`
  UNION ALL
  SELECT 920015216 AS `guid`, 1 AS `map`, 4917.73 AS `x`, -2739.25 AS `y`, 1430.65 AS `z`
  UNION ALL
  SELECT 920015217 AS `guid`, 1 AS `map`, 4903.84 AS `x`, -2770.51 AS `y`, 1435.41 AS `z`
) s WHERE @EVERLAKE_GS650902 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=650902 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS650902 = 1 AND g.`id` = 650902 AND g.`guid` BETWEEN 920015211 AND 920015217;

-- Prickly Pinecone (651048): gives item 273304 for quest 96262; 14 spawn(s).
SET @EVERLAKE_G651048 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 651048);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 651048, 3, 124906, 'Prickly Pinecone', '', '', '', 2.0, 4088, 140834, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G651048 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 651048, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=651048' FROM DUAL WHERE @EVERLAKE_G651048 = 1;
SET @EVERLAKE_L651048 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 651048 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L651048 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L651048 AND `Item` = 273304);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L651048, 0, 273304, 100, 1, 1, 0, 1, 1, 'Prickly Pinecone' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L651048, 0, 273304, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=651048: gathers item 273304' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 651048 AND `ItemId` = 273304);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 651048);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 651048, @EVERLAKE_QX, 273304, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 651048, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=651048: quest item 273304' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS651048 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 651048) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 651048 AND `guid` NOT BETWEEN 920015218 AND 920015231);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 651048, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015218 AS `guid`, 1 AS `map`, 4378.43 AS `x`, -2312.08 AS `y`, 1154.47 AS `z`
  UNION ALL
  SELECT 920015219 AS `guid`, 1 AS `map`, 4346.03 AS `x`, -2322.50 AS `y`, 1158.13 AS `z`
  UNION ALL
  SELECT 920015220 AS `guid`, 1 AS `map`, 4297.42 AS `x`, -2360.70 AS `y`, 1167.24 AS `z`
  UNION ALL
  SELECT 920015221 AS `guid`, 1 AS `map`, 4297.42 AS `x`, -2367.65 AS `y`, 1164.59 AS `z`
  UNION ALL
  SELECT 920015222 AS `guid`, 1 AS `map`, 4269.65 AS `x`, -2409.32 AS `y`, 1165.27 AS `z`
  UNION ALL
  SELECT 920015223 AS `guid`, 1 AS `map`, 4230.30 AS `x`, -2499.62 AS `y`, 1161.89 AS `z`
  UNION ALL
  SELECT 920015224 AS `guid`, 1 AS `map`, 4269.65 AS `x`, -2596.86 AS `y`, 1125.83 AS `z`
  UNION ALL
  SELECT 920015225 AS `guid`, 1 AS `map`, 4244.19 AS `x`, -2600.34 AS `y`, 1131.92 AS `z`
  UNION ALL
  SELECT 920015226 AS `guid`, 1 AS `map`, 4415.47 AS `x`, -2659.38 AS `y`, 1119.55 AS `z`
  UNION ALL
  SELECT 920015227 AS `guid`, 1 AS `map`, 4420.10 AS `x`, -2662.85 AS `y`, 1120.53 AS `z`
  UNION ALL
  SELECT 920015228 AS `guid`, 1 AS `map`, 4258.07 AS `x`, -2683.69 AS `y`, 1110.44 AS `z`
  UNION ALL
  SELECT 920015229 AS `guid`, 1 AS `map`, 4292.79 AS `x`, -2687.16 AS `y`, 1105.58 AS `z`
  UNION ALL
  SELECT 920015230 AS `guid`, 1 AS `map`, 4362.23 AS `x`, -2697.58 AS `y`, 1106.74 AS `z`
  UNION ALL
  SELECT 920015231 AS `guid`, 1 AS `map`, 4346.03 AS `x`, -2728.83 AS `y`, 1103.90 AS `z`
) s WHERE @EVERLAKE_GS651048 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=651048 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS651048 = 1 AND g.`id` = 651048 AND g.`guid` BETWEEN 920015218 AND 920015231;

-- Sturdy Tree Branch (653120): gives item 274617 for quest 92702; 2 spawn(s).
SET @EVERLAKE_G653120 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 653120);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 653120, 3, 125420, 'Sturdy Tree Branch', '', '', '', 6.0, 43, 141192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 181, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G653120 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 653120, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=653120' FROM DUAL WHERE @EVERLAKE_G653120 = 1;
SET @EVERLAKE_L653120 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 653120 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L653120 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L653120 AND `Item` = 274617);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L653120, 0, 274617, 100, 1, 1, 0, 1, 1, 'Sturdy Tree Branch' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L653120, 0, 274617, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=653120: gathers item 274617' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 653120 AND `ItemId` = 274617);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 653120);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 653120, @EVERLAKE_QX, 274617, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 653120, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=653120: quest item 274617' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS653120 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 653120) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 653120 AND `guid` NOT BETWEEN 920015232 AND 920015233);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 653120, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015232 AS `guid`, 1 AS `map`, 4512.68 AS `x`, -1784.20 AS `y`, 1260.32 AS `z`
  UNION ALL
  SELECT 920015233 AS `guid`, 1 AS `map`, 4508.05 AS `x`, -1787.67 AS `y`, 1260.75 AS `z`
) s WHERE @EVERLAKE_GS653120 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=653120 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS653120 = 1 AND g.`id` = 653120 AND g.`guid` BETWEEN 920015232 AND 920015233;

-- Secret Shipment (656398): gives item 275882 for quest 96786; 2 spawn(s).
SET @EVERLAKE_G656398 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 656398);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 656398, 3, 31, 'Secret Shipment', '', '', '', 1.0, 93, 141626, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4098, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G656398 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 656398, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656398' FROM DUAL WHERE @EVERLAKE_G656398 = 1;
SET @EVERLAKE_L656398 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 656398 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L656398 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L656398 AND `Item` = 275882);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L656398, 0, 275882, 100, 1, 1, 0, 1, 1, 'Secret Shipment' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L656398, 0, 275882, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656398: gathers item 275882' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 656398 AND `ItemId` = 275882);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 656398);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 656398, @EVERLAKE_QX, 275882, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 656398, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656398: quest item 275882' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS656398 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 656398) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 656398 AND `guid` NOT BETWEEN 920015234 AND 920015235);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 656398, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015234 AS `guid`, 0 AS `map`, -1160.53 AS `x`, -1421.07 AS `y`, 59.31 AS `z`
  UNION ALL
  SELECT 920015235 AS `guid`, 0 AS `map`, -1162.93 AS `x`, -1428.27 AS `y`, 59.05 AS `z`
) s WHERE @EVERLAKE_GS656398 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=656398 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS656398 = 1 AND g.`id` = 656398 AND g.`guid` BETWEEN 920015234 AND 920015235;

-- Sun-Bleached Bonepile (656518): gives item 275927 for quest 96957; 15 spawn(s).
SET @EVERLAKE_G656518 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 656518);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 656518, 3, 125135, 'Sun-Bleached Bonepile', '', '', '', 0.8, 4088, 141719, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G656518 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 656518, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656518' FROM DUAL WHERE @EVERLAKE_G656518 = 1;
SET @EVERLAKE_L656518 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 656518 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L656518 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L656518 AND `Item` = 275927);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L656518, 0, 275927, 100, 1, 1, 0, 1, 1, 'Sun-Bleached Bonepile' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L656518, 0, 275927, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656518: gathers item 275927' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 656518 AND `ItemId` = 275927);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 656518);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 656518, @EVERLAKE_QX, 275927, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 656518, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656518: quest item 275927' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS656518 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 656518) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 656518 AND `guid` NOT BETWEEN 920015236 AND 920015250);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 656518, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015236 AS `guid`, 1 AS `map`, 4989.48 AS `x`, -1704.32 AS `y`, 1339.18 AS `z`
  UNION ALL
  SELECT 920015237 AS `guid`, 1 AS `map`, 5186.22 AS `x`, -1707.80 AS `y`, 1341.21 AS `z`
  UNION ALL
  SELECT 920015238 AS `guid`, 1 AS `map`, 5142.25 AS `x`, -1711.27 AS `y`, 1335.05 AS `z`
  UNION ALL
  SELECT 920015239 AS `guid`, 1 AS `map`, 5227.88 AS `x`, -1714.74 AS `y`, 1350.03 AS `z`
  UNION ALL
  SELECT 920015240 AS `guid`, 1 AS `map`, 5165.39 AS `x`, -1732.11 AS `y`, 1336.29 AS `z`
  UNION ALL
  SELECT 920015241 AS `guid`, 1 AS `map`, 5128.36 AS `x`, -1732.11 AS `y`, 1334.48 AS `z`
  UNION ALL
  SELECT 920015242 AS `guid`, 1 AS `map`, 5038.09 AS `x`, -1732.11 AS `y`, 1321.77 AS `z`
  UNION ALL
  SELECT 920015243 AS `guid`, 1 AS `map`, 5051.98 AS `x`, -1735.58 AS `y`, 1322.33 AS `z`
  UNION ALL
  SELECT 920015244 AS `guid`, 1 AS `map`, 5202.42 AS `x`, -1739.05 AS `y`, 1340.53 AS `z`
  UNION ALL
  SELECT 920015245 AS `guid`, 1 AS `map`, 5093.64 AS `x`, -1742.52 AS `y`, 1321.63 AS `z`
  UNION ALL
  SELECT 920015246 AS `guid`, 1 AS `map`, 5051.98 AS `x`, -1742.52 AS `y`, 1321.82 AS `z`
  UNION ALL
  SELECT 920015247 AS `guid`, 1 AS `map`, 5207.05 AS `x`, -1756.42 AS `y`, 1346.10 AS `z`
  UNION ALL
  SELECT 920015248 AS `guid`, 1 AS `map`, 5151.50 AS `x`, -1756.42 AS `y`, 1336.59 AS `z`
  UNION ALL
  SELECT 920015249 AS `guid`, 1 AS `map`, 4996.43 AS `x`, -1770.31 AS `y`, 1332.77 AS `z`
  UNION ALL
  SELECT 920015250 AS `guid`, 1 AS `map`, 5172.33 AS `x`, -1780.73 AS `y`, 1340.00 AS `z`
) s WHERE @EVERLAKE_GS656518 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=656518 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS656518 = 1 AND g.`id` = 656518 AND g.`guid` BETWEEN 920015236 AND 920015250;

-- Abandoned Supplies (656604): gives item 275958 for quest 96971; 14 spawn(s).
SET @EVERLAKE_G656604 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 656604);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 656604, 3, 318, 'Abandoned Supplies', '', '', '', 1.0, 4088, 141742, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G656604 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 656604, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656604' FROM DUAL WHERE @EVERLAKE_G656604 = 1;
SET @EVERLAKE_L656604 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 656604 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L656604 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L656604 AND `Item` = 275958);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L656604, 0, 275958, 100, 1, 1, 0, 1, 1, 'Abandoned Supplies' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L656604, 0, 275958, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656604: gathers item 275958' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 656604 AND `ItemId` = 275958);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 656604);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 656604, @EVERLAKE_QX, 275958, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 656604, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656604: quest item 275958' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS656604 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 656604) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 656604 AND `guid` NOT BETWEEN 920015251 AND 920015264);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 656604, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015251 AS `guid`, 1 AS `map`, 5450.08 AS `x`, -2638.54 AS `y`, 1485.28 AS `z`
  UNION ALL
  SELECT 920015252 AS `guid`, 1 AS `map`, 5570.44 AS `x`, -2645.48 AS `y`, 1485.70 AS `z`
  UNION ALL
  SELECT 920015253 AS `guid`, 1 AS `map`, 5440.83 AS `x`, -2662.85 AS `y`, 1485.88 AS `z`
  UNION ALL
  SELECT 920015254 AS `guid`, 1 AS `map`, 5440.83 AS `x`, -2704.52 AS `y`, 1486.08 AS `z`
  UNION ALL
  SELECT 920015255 AS `guid`, 1 AS `map`, 5424.62 AS `x`, -2711.47 AS `y`, 1485.96 AS `z`
  UNION ALL
  SELECT 920015256 AS `guid`, 1 AS `map`, 5535.72 AS `x`, -2767.04 AS `y`, 1498.00 AS `z`
  UNION ALL
  SELECT 920015257 AS `guid`, 1 AS `map`, 5514.89 AS `x`, -2767.04 AS `y`, 1499.66 AS `z`
  UNION ALL
  SELECT 920015258 AS `guid`, 1 AS `map`, 5577.39 AS `x`, -2812.18 AS `y`, 1508.94 AS `z`
  UNION ALL
  SELECT 920015259 AS `guid`, 1 AS `map`, 5299.64 AS `x`, -2867.75 AS `y`, 1528.22 AS `z`
  UNION ALL
  SELECT 920015260 AS `guid`, 1 AS `map`, 5285.75 AS `x`, -2895.53 AS `y`, 1529.61 AS `z`
  UNION ALL
  SELECT 920015261 AS `guid`, 1 AS `map`, 5350.56 AS `x`, -2933.74 AS `y`, 1538.29 AS `z`
  UNION ALL
  SELECT 920015262 AS `guid`, 1 AS `map`, 5322.78 AS `x`, -2940.68 AS `y`, 1538.36 AS `z`
  UNION ALL
  SELECT 920015263 AS `guid`, 1 AS `map`, 5498.69 AS `x`, -2964.99 AS `y`, 1541.22 AS `z`
  UNION ALL
  SELECT 920015264 AS `guid`, 1 AS `map`, 5401.48 AS `x`, -2992.78 AS `y`, 1552.61 AS `z`
) s WHERE @EVERLAKE_GS656604 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=656604 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS656604 = 1 AND g.`id` = 656604 AND g.`guid` BETWEEN 920015251 AND 920015264;

-- Pile of Nails (656809): gives item 276087 for quest 96992; 4 spawn(s).
SET @EVERLAKE_G656809 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 656809);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 656809, 3, 126474, 'Pile of Nails', '', '', '', 2.0, 43, 141779, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 181, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G656809 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 656809, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656809' FROM DUAL WHERE @EVERLAKE_G656809 = 1;
SET @EVERLAKE_L656809 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 656809 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L656809 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L656809 AND `Item` = 276087);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L656809, 0, 276087, 100, 1, 1, 0, 1, 1, 'Pile of Nails' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L656809, 0, 276087, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656809: gathers item 276087' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 656809 AND `ItemId` = 276087);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 656809);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 656809, @EVERLAKE_QX, 276087, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 656809, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=656809: quest item 276087' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS656809 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 656809) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 656809 AND `guid` NOT BETWEEN 920015265 AND 920015268);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 656809, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015265 AS `guid`, 1 AS `map`, 5278.81 AS `x`, -2013.41 AS `y`, 1286.01 AS `z`
  UNION ALL
  SELECT 920015266 AS `guid`, 1 AS `map`, 5269.55 AS `x`, -2016.89 AS `y`, 1285.89 AS `z`
  UNION ALL
  SELECT 920015267 AS `guid`, 1 AS `map`, 5195.48 AS `x`, -2100.24 AS `y`, 1279.06 AS `z`
  UNION ALL
  SELECT 920015268 AS `guid`, 1 AS `map`, 5181.59 AS `x`, -2103.71 AS `y`, 1279.49 AS `z`
) s WHERE @EVERLAKE_GS656809 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=656809 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS656809 = 1 AND g.`id` = 656809 AND g.`guid` BETWEEN 920015265 AND 920015268;

-- Wyrmtail (671644): gives item 280092 for quest 98231; 15 spawn(s).
SET @EVERLAKE_G671644 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 671644);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 671644, 3, 391, 'Wyrmtail', '', '', '', 1.0, 57, 142825, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G671644 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 671644, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=671644' FROM DUAL WHERE @EVERLAKE_G671644 = 1;
SET @EVERLAKE_L671644 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 671644 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L671644 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L671644 AND `Item` = 280092);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L671644, 0, 280092, 100, 1, 1, 0, 1, 1, 'Wyrmtail' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L671644, 0, 280092, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=671644: gathers item 280092' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 671644 AND `ItemId` = 280092);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 671644);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 671644, @EVERLAKE_QX, 280092, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 671644, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=671644: quest item 280092' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS671644 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 671644) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 671644 AND `guid` NOT BETWEEN 920015269 AND 920015283);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 671644, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015269 AS `guid`, 1 AS `map`, -4595.33 AS `x`, -3190.50 AS `y`, 41.73 AS `z`
  UNION ALL
  SELECT 920015270 AS `guid`, 1 AS `map`, -4539.33 AS `x`, -3222.00 AS `y`, 31.12 AS `z`
  UNION ALL
  SELECT 920015271 AS `guid`, 1 AS `map`, -4619.83 AS `x`, -3232.50 AS `y`, 30.20 AS `z`
  UNION ALL
  SELECT 920015272 AS `guid`, 1 AS `map`, -4577.83 AS `x`, -3258.75 AS `y`, 31.87 AS `z`
  UNION ALL
  SELECT 920015273 AS `guid`, 1 AS `map`, -4679.33 AS `x`, -3264.00 AS `y`, 31.46 AS `z`
  UNION ALL
  SELECT 920015274 AS `guid`, 1 AS `map`, -4752.83 AS `x`, -3295.50 AS `y`, 38.57 AS `z`
  UNION ALL
  SELECT 920015275 AS `guid`, 1 AS `map`, -4742.33 AS `x`, -3306.00 AS `y`, 30.74 AS `z`
  UNION ALL
  SELECT 920015276 AS `guid`, 1 AS `map`, -4563.83 AS `x`, -3327.00 AS `y`, 39.77 AS `z`
  UNION ALL
  SELECT 920015277 AS `guid`, 1 AS `map`, -4766.83 AS `x`, -3327.00 AS `y`, 33.92 AS `z`
  UNION ALL
  SELECT 920015278 AS `guid`, 1 AS `map`, -4595.33 AS `x`, -3337.50 AS `y`, 38.64 AS `z`
  UNION ALL
  SELECT 920015279 AS `guid`, 1 AS `map`, -4525.33 AS `x`, -3353.25 AS `y`, 41.46 AS `z`
  UNION ALL
  SELECT 920015280 AS `guid`, 1 AS `map`, -4941.83 AS `x`, -3379.50 AS `y`, 38.16 AS `z`
  UNION ALL
  SELECT 920015281 AS `guid`, 1 AS `map`, -4728.33 AS `x`, -3384.75 AS `y`, 31.03 AS `z`
  UNION ALL
  SELECT 920015282 AS `guid`, 1 AS `map`, -4882.33 AS `x`, -3384.75 AS `y`, 35.96 AS `z`
  UNION ALL
  SELECT 920015283 AS `guid`, 1 AS `map`, -4777.33 AS `x`, -3395.25 AS `y`, 31.33 AS `z`
) s WHERE @EVERLAKE_GS671644 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=671644 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS671644 = 1 AND g.`id` = 671644 AND g.`guid` BETWEEN 920015269 AND 920015283;

-- Damaged Blue Crystal (672518): gives item 280417 for quest 87492; 1 spawn(s).
SET @EVERLAKE_G672518 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 672518);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 672518, 3, 2971, 'Damaged Blue Crystal', '', '', '', 1.0, 43, 142905, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 166471, 0, 0, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G672518 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 672518, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=672518' FROM DUAL WHERE @EVERLAKE_G672518 = 1;
SET @EVERLAKE_L672518 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 672518 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L672518 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L672518 AND `Item` = 280417);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L672518, 0, 280417, 100, 1, 1, 0, 1, 1, 'Damaged Blue Crystal' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L672518, 0, 280417, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=672518: gathers item 280417' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 672518 AND `ItemId` = 280417);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 672518);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 672518, @EVERLAKE_QX, 280417, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 672518, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=672518: quest item 280417' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS672518 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 672518) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 672518 AND `guid` NOT BETWEEN 920015284 AND 920015284);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 672518, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015284 AS `guid`, 1 AS `map`, -7821.60 AS `x`, -1919.77 AS `y`, -273.03 AS `z`
) s WHERE @EVERLAKE_GS672518 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=672518 page: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS672518 = 1 AND g.`id` = 672518 AND g.`guid` BETWEEN 920015284 AND 920015284;

COMMIT;
