-- World objects that hand out items the realm has no source for (the tracker's "No source" items), from Icy Veins'
-- WoW Forever database (https://db.icy-veins.com/wow-forever/: name, type, model, size, data fields and the item each
-- object gives, recorded by players' addons) and QuestieDB's WoW Forever object traces (players' map points, GPL-3.0).
-- 2026_11_22_02_world_everlake_item_objects.sql: written from public data by a script, checked by hand.
--
-- For each object: its template where the realm has none; the item in the loot of the template's loot id (Data1), 100%,
-- one at a time, quest-only where the item is an objective of a quest the realm has; the gameobject_questitem row for
-- those; spawns where the realm has none of it.
-- Spawns: one per QuestieDB point at least 5 yards apart, at most 15, turned into a world position with the client's
-- UiMapAssignment rectangles and the height from the realm's maps and vmaps (ForeverTracker tools/height.py). Points
-- on water or on a model are left out. Orientation 0, rotation 0, respawn 120 s and one item per loot are INFERRED,
-- as in 2026_11_20_32_world_everlake_quest_item_objects.sql.
-- Held back (need a look in game):
--   Sealed Barrel (422911): its one point is on water.
--   Highborne Tablet (524284): its one point is inside ruins with several floors.
--   Highborne Tablet (524298): its one point is inside ruins with several floors.
--   Mana Sieve (584729): its one point is inside a tower with several floors.
--   Uthek's Staff (587338): Icy Veins gives it no loot id (Data1 0), so no loot could be attached.
--   Unfinished Masterwork Sword (613223): its one point is inside a tower with several floors.
--   Bracket (656812): all 7 points are on models.
--   Narassin's Strongbox (676349): its one point is inside a building with several floors.
--   Recipe: Raw Plated Armorfish (694054): its one point is on an upper floor of a model in Deadwind Pass.
-- Not here: the gathering nodes Heavy Thorium Vein (566779), Chunk of Amber (656332) and Large Chunk of Amber (656333),
-- which need a pool and a full loot table.
-- Guids: objects 920015287 upward, in the quest-object block (920015000-920015999).
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
SET @EVERLAKE_FILE := '2026_11_22_02_world_everlake_item_objects.sql';
START TRANSACTION;

-- Fel Mote (507731): gives item 235471 for quest 86926; 1 spawn(s) from 1 QuestieDB point(s).
SET @EVERLAKE_G507731 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 507731);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 507731, 3, 90321, 'Fel Mote', '', '', '', 0.35, 93, 130359, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4098, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G507731 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 507731, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=507731' FROM DUAL WHERE @EVERLAKE_G507731 = 1;
SET @EVERLAKE_L507731 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 507731 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L507731 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L507731 AND `Item` = 235471);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L507731, 0, 235471, 100, 1, 1, 0, 1, 1, 'Fel Mote' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L507731, 0, 235471, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=507731: gathers item 235471' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 507731 AND `ItemId` = 235471);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 507731);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 507731, @EVERLAKE_QX, 235471, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 507731, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=507731: quest item 235471' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS507731 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 507731) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 507731 AND `guid` NOT BETWEEN 920015287 AND 920015287);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 507731, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015287 AS `guid`, 1 AS `map`, 4492.97 AS `x`, -6393.11 AS `y`, 126.34 AS `z`
) s WHERE @EVERLAKE_GS507731 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'QuestieDB object=507731 traces: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS507731 = 1 AND g.`id` = 507731 AND g.`guid` BETWEEN 920015287 AND 920015287;

-- Tarnished Shield Dome (572022): gives item 269246 for quest 92011; 15 spawn(s) from 16 QuestieDB point(s).
SET @EVERLAKE_G572022 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 572022);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 572022, 3, 112460, 'Tarnished Shield Dome', '', '', '', 1.0, 57, 139855, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5121, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2180, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G572022 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 572022, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=572022' FROM DUAL WHERE @EVERLAKE_G572022 = 1;
SET @EVERLAKE_L572022 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 572022 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L572022 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L572022 AND `Item` = 269246);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L572022, 0, 269246, 100, 1, 1, 0, 1, 1, 'Tarnished Shield Dome' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L572022, 0, 269246, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=572022: gathers item 269246' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 572022 AND `ItemId` = 269246);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 572022);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 572022, @EVERLAKE_QX, 269246, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 572022, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=572022: quest item 269246' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS572022 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 572022) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 572022 AND `guid` NOT BETWEEN 920015288 AND 920015302);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 572022, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015288 AS `guid`, 1 AS `map`, 5476.24 AS `x`, -2637.15 AS `y`, 1481.46 AS `z`
  UNION ALL
  SELECT 920015289 AS `guid`, 1 AS `map`, 5569.29 AS `x`, -2646.87 AS `y`, 1485.48 AS `z`
  UNION ALL
  SELECT 920015290 AS `guid`, 1 AS `map`, 5550.31 AS `x`, -2652.78 AS `y`, 1484.00 AS `z`
  UNION ALL
  SELECT 920015291 AS `guid`, 1 AS `map`, 5595.44 AS `x`, -2718.41 AS `y`, 1496.37 AS `z`
  UNION ALL
  SELECT 920015292 AS `guid`, 1 AS `map`, 5516.28 AS `x`, -2765.99 AS `y`, 1499.54 AS `z`
  UNION ALL
  SELECT 920015293 AS `guid`, 1 AS `map`, 5420.00 AS `x`, -2789.26 AS `y`, 1505.38 AS `z`
  UNION ALL
  SELECT 920015294 AS `guid`, 1 AS `map`, 5336.21 AS `x`, -2850.73 AS `y`, 1514.49 AS `z`
  UNION ALL
  SELECT 920015295 AS `guid`, 1 AS `map`, 5292.69 AS `x`, -2864.62 AS `y`, 1528.35 AS `z`
  UNION ALL
  SELECT 920015296 AS `guid`, 1 AS `map`, 5426.01 AS `x`, -2921.93 AS `y`, 1537.29 AS `z`
  UNION ALL
  SELECT 920015297 AS `guid`, 1 AS `map`, 5343.85 AS `x`, -2929.22 AS `y`, 1537.43 AS `z`
  UNION ALL
  SELECT 920015298 AS `guid`, 1 AS `map`, 5358.43 AS `x`, -2945.20 AS `y`, 1538.32 AS `z`
  UNION ALL
  SELECT 920015299 AS `guid`, 1 AS `map`, 5652.61 AS `x`, -2964.64 AS `y`, 1547.68 AS `z`
  UNION ALL
  SELECT 920015300 AS `guid`, 1 AS `map`, 5427.63 AS `x`, -2967.42 AS `y`, 1550.38 AS `z`
  UNION ALL
  SELECT 920015301 AS `guid`, 1 AS `map`, 5379.49 AS `x`, -3012.92 AS `y`, 1558.46 AS `z`
  UNION ALL
  SELECT 920015302 AS `guid`, 1 AS `map`, 5541.05 AS `x`, -3050.08 AS `y`, 1561.71 AS `z`
) s WHERE @EVERLAKE_GS572022 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'QuestieDB object=572022 traces: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS572022 = 1 AND g.`id` = 572022 AND g.`guid` BETWEEN 920015288 AND 920015302;

-- Calcified Excrement (572028): gives item 269244 for quest 92011; 15 spawn(s) from 19 QuestieDB point(s).
SET @EVERLAKE_G572028 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 572028);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 572028, 3, 112461, 'Calcified Excrement', '', '', '', 0.35, 57, 135235, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5121, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2180, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G572028 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 572028, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=572028' FROM DUAL WHERE @EVERLAKE_G572028 = 1;
SET @EVERLAKE_L572028 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 572028 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L572028 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L572028 AND `Item` = 269244);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L572028, 0, 269244, 100, 1, 1, 0, 1, 1, 'Calcified Excrement' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L572028, 0, 269244, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=572028: gathers item 269244' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 572028 AND `ItemId` = 269244);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 572028);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 572028, @EVERLAKE_QX, 269244, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 572028, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=572028: quest item 269244' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS572028 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 572028) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 572028 AND `guid` NOT BETWEEN 920015303 AND 920015317);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 572028, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015303 AS `guid`, 1 AS `map`, 5507.02 AS `x`, -2539.91 AS `y`, 1498.43 AS `z`
  UNION ALL
  SELECT 920015304 AS `guid`, 1 AS `map`, 5484.11 AS `x`, -2576.02 AS `y`, 1496.69 AS `z`
  UNION ALL
  SELECT 920015305 AS `guid`, 1 AS `map`, 5286.91 AS `x`, -2622.91 AS `y`, 1500.92 AS `z`
  UNION ALL
  SELECT 920015306 AS `guid`, 1 AS `map`, 5202.66 AS `x`, -2728.14 AS `y`, 1544.72 AS `z`
  UNION ALL
  SELECT 920015307 AS `guid`, 1 AS `map`, 5232.05 AS `x`, -2764.26 AS `y`, 1527.20 AS `z`
  UNION ALL
  SELECT 920015308 AS `guid`, 1 AS `map`, 5654.69 AS `x`, -2858.03 AS `y`, 1532.79 AS `z`
  UNION ALL
  SELECT 920015309 AS `guid`, 1 AS `map`, 5636.18 AS `x`, -2868.10 AS `y`, 1519.72 AS `z`
  UNION ALL
  SELECT 920015310 AS `guid`, 1 AS `map`, 5231.82 AS `x`, -2886.85 AS `y`, 1546.10 AS `z`
  UNION ALL
  SELECT 920015311 AS `guid`, 1 AS `map`, 5664.65 AS `x`, -2974.37 AS `y`, 1547.18 AS `z`
  UNION ALL
  SELECT 920015312 AS `guid`, 1 AS `map`, 5702.37 AS `x`, -2975.06 AS `y`, 1552.57 AS `z`
  UNION ALL
  SELECT 920015313 AS `guid`, 1 AS `map`, 5690.80 AS `x`, -2983.40 AS `y`, 1549.77 AS `z`
  UNION ALL
  SELECT 920015314 AS `guid`, 1 AS `map`, 5285.52 AS `x`, -2997.98 AS `y`, 1552.11 AS `z`
  UNION ALL
  SELECT 920015315 AS `guid`, 1 AS `map`, 5227.19 AS `x`, -3012.57 AS `y`, 1560.66 AS `z`
  UNION ALL
  SELECT 920015316 AS `guid`, 1 AS `map`, 5388.75 AS `x`, -3028.20 AS `y`, 1570.81 AS `z`
  UNION ALL
  SELECT 920015317 AS `guid`, 1 AS `map`, 5328.80 AS `x`, -3050.08 AS `y`, 1583.81 AS `z`
) s WHERE @EVERLAKE_GS572028 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'QuestieDB object=572028 traces: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS572028 = 1 AND g.`id` = 572028 AND g.`guid` BETWEEN 920015303 AND 920015317;

-- Rusting Metal Chunk (638767): gives item 269246 for quest 92011; 6 spawn(s) from 13 QuestieDB point(s).
SET @EVERLAKE_G638767 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 638767);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 638767, 3, 122976, 'Rusting Metal Chunk', '', '', '', 1.0, 57, 139855, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5121, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 181, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G638767 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 638767, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=638767' FROM DUAL WHERE @EVERLAKE_G638767 = 1;
SET @EVERLAKE_L638767 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 638767 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L638767 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L638767 AND `Item` = 269246);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L638767, 0, 269246, 100, 1, 1, 0, 1, 1, 'Rusting Metal Chunk' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L638767, 0, 269246, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=638767: gathers item 269246' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 638767 AND `ItemId` = 269246);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 638767);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 638767, @EVERLAKE_QX, 269246, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 638767, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=638767: quest item 269246' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS638767 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 638767) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 638767 AND `guid` NOT BETWEEN 920015318 AND 920015323);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 638767, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015318 AS `guid`, 1 AS `map`, 5484.57 AS `x`, -2630.90 AS `y`, 1482.65 AS `z`
  UNION ALL
  SELECT 920015319 AS `guid`, 1 AS `map`, 5602.62 AS `x`, -2700.01 AS `y`, 1497.84 AS `z`
  UNION ALL
  SELECT 920015320 AS `guid`, 1 AS `map`, 5388.05 AS `x`, -2714.59 AS `y`, 1485.70 AS `z`
  UNION ALL
  SELECT 920015321 AS `guid`, 1 AS `map`, 5351.02 AS `x`, -2838.58 AS `y`, 1514.27 AS `z`
  UNION ALL
  SELECT 920015322 AS `guid`, 1 AS `map`, 5366.07 AS `x`, -2912.55 AS `y`, 1532.55 AS `z`
  UNION ALL
  SELECT 920015323 AS `guid`, 1 AS `map`, 5506.33 AS `x`, -2934.08 AS `y`, 1537.70 AS `z`
) s WHERE @EVERLAKE_GS638767 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'QuestieDB object=638767 traces: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS638767 = 1 AND g.`id` = 638767 AND g.`guid` BETWEEN 920015318 AND 920015323;

-- Pristine Crystallized Fel-Slime (652442): gives item 268990 for quest 95319; 1 spawn(s) from 1 QuestieDB point(s).
SET @EVERLAKE_G652442 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 652442);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 652442, 3, 125305, 'Pristine Crystallized Fel-Slime', '', '', '', 1.0, 4088, 140805, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G652442 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 652442, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=652442' FROM DUAL WHERE @EVERLAKE_G652442 = 1;
SET @EVERLAKE_L652442 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 652442 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L652442 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L652442 AND `Item` = 268990);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L652442, 0, 268990, 100, 1, 1, 0, 1, 1, 'Pristine Crystallized Fel-Slime' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L652442, 0, 268990, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=652442: gathers item 268990' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_QI := NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 652442 AND `ItemId` = 268990);
SET @EVERLAKE_QX := (SELECT COALESCE(MAX(`Idx`) + 1, 0) FROM `gameobject_questitem` WHERE `GameObjectEntry` = 652442);
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 652442, @EVERLAKE_QX, 268990, 0 FROM DUAL WHERE @EVERLAKE_QI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questitem', 652442, @EVERLAKE_QX, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=652442: quest item 268990' FROM DUAL WHERE @EVERLAKE_QI = 1;
SET @EVERLAKE_GS652442 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 652442) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 652442 AND `guid` NOT BETWEEN 920015324 AND 920015324);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 652442, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015324 AS `guid`, 1 AS `map`, 4391.39 AS `x`, -2592.00 AS `y`, 1095.85 AS `z`
) s WHERE @EVERLAKE_GS652442 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'QuestieDB object=652442 traces: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS652442 = 1 AND g.`id` = 652442 AND g.`guid` BETWEEN 920015324 AND 920015324;

-- Fel-Tainted Journal (660984): gives item 277533 (no quest of the realm asks for it); 1 spawn(s) from 1 QuestieDB point(s).
SET @EVERLAKE_G660984 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 660984);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 660984, 3, 127530, 'Fel-Tainted Journal', '', '', '', 1.0, 57, 142178, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G660984 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 660984, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=660984' FROM DUAL WHERE @EVERLAKE_G660984 = 1;
SET @EVERLAKE_L660984 := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 660984 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_L660984 IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_L660984 AND `Item` = 277533);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_L660984, 0, 277533, 100, 0, 1, 0, 1, 1, 'Fel-Tainted Journal' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_L660984, 0, 277533, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=660984: gathers item 277533' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_GS660984 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 660984) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 660984 AND `guid` NOT BETWEEN 920015325 AND 920015325);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 660984, s.`map`, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015325 AS `guid`, 1 AS `map`, 4642.76 AS `x`, -2407.24 AS `y`, 1165.79 AS `z`
) s WHERE @EVERLAKE_GS660984 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'QuestieDB object=660984 traces: map points; height.py' FROM `gameobject` g WHERE @EVERLAKE_GS660984 = 1 AND g.`id` = 660984 AND g.`guid` BETWEEN 920015325 AND 920015325;

COMMIT;
