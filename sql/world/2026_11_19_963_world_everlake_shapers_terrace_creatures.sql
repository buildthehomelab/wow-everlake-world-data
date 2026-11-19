-- WoW Forever: The Shaper's Terrace (map 3001): its creatures. 2026_11_19_963_world_everlake_shapers_terrace_creatures.sql.
-- Templates for the creatures Wowhead's Forever pages place in The Shaper's Terrace (marked with no zone of their own,
-- ids around its bosses), their models and levels, the bosses' loot, and their spawns. Safe to run again: a template is
-- added only where the realm has none, a spawn only where its guid is free, every added row recorded in
-- everlake_import_rows. Never edit this file once deployed.
--
-- Real data: names, ranks, types and models (Wowhead's Forever pages, read by the tracker's crawl), boss loot with the
-- counts players recorded, the map's areas (the client's AreaTable and the server's map files: the dungeon is a copy of
-- this part of Un'Goro Crater), which boss is where (the public guide of Warcraft Tavern).
-- INFERRED: levels (58-60), faction 16, health and damage multipliers, gold, every spawn spot and pack. Simplified: the
-- four Archival Panel bosses (Cinder, Snowtalon, Vitrix, Bolt) and Nanaya stand at their panels instead of being summoned
-- with 15 crystals each; the panels, crystals, fire elementals and Stone Guardians are not in Wowhead's pages yet.

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

SET @EVERLAKE_FILE := '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql';
START TRANSACTION;

-- Titanosaur (253201) boss: model 142989, levels 58-58, health x10.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C253201 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 253201)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253201);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 253201, 0, 0, 'Titanosaur', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C253201 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 253201, 0, 0, 0, 0, 0, 10.0, 1, 1, 2.0, 0, 0, 128, 0, 253201, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C253201 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 253201, 0, 142989, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C253201 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 253201, 58, 58 FROM DUAL WHERE @EVERLAKE_C253201 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 253201);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 253201, 0, 274964, 5.8, 0, 1, 0, 1, 1, 'Titanosaur: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C253201 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 253201 AND `ItemType` = 0 AND `Item` = 274964);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 253201, 0, 280009, 63.77, 0, 1, 0, 1, 1, 'Titanosaur: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C253201 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 253201 AND `ItemType` = 0 AND `Item` = 280009);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 253201, 0, 280010, 47.83, 0, 1, 0, 1, 1, 'Titanosaur: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C253201 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 253201 AND `ItemType` = 0 AND `Item` = 280010);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 253201, 0, 280011, 50.72, 0, 1, 0, 1, 1, 'Titanosaur: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C253201 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 253201 AND `ItemType` = 0 AND `Item` = 280011);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 253201, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253201 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 253201, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253201 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 253201, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253201 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 253201, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253201 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 253201, 0, 274964, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253201 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 253201, 0, 280009, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253201 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 253201, 0, 280010, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253201 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 253201, 0, 280011, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253201 = 1;
SET @EVERLAKE_CS253201 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253201 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 253201, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002000 AS `guid`, -5662.5 AS `x`, -1454.2 AS `y`, 36.37 AS `z`, 4.155 AS `o` -- Titanosaur on the paved road (Walk of Communion) (INFERRED spot)
) s WHERE @EVERLAKE_CS253201 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS253201 = 1 AND c.`id` = 253201 AND c.`guid` BETWEEN 974002000 AND 974002000;

-- Ravasaur Hunter (253214): model 4442, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C253214 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 253214)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253214);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 253214, 0, 0, 'Ravasaur Hunter', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C253214 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 253214, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 253214, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C253214 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 253214, 0, 4442, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C253214 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 253214, 58, 59 FROM DUAL WHERE @EVERLAKE_C253214 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 253214);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 253214, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253214 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 253214, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253214 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 253214, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253214 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 253214, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253214 = 1;
SET @EVERLAKE_CS253214 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253214 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 253214, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002001 AS `guid`, -5620.8 AS `x`, -762.5 AS `y`, 28.52 AS `z`, 2.826 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002002 AS `guid`, -5795.8 AS `x`, -737.5 AS `y`, 42.39 AS `z`, 6.246 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS253214 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS253214 = 1 AND c.`id` = 253214 AND c.`guid` BETWEEN 974002001 AND 974002002;

-- Ravasaur Matriarch (253215): model 143340, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C253215 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 253215)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253215);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 253215, 0, 0, 'Ravasaur Matriarch', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C253215 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 253215, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 253215, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C253215 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 253215, 0, 143340, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C253215 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 253215, 58, 59 FROM DUAL WHERE @EVERLAKE_C253215 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 253215);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 253215, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253215 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 253215, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253215 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 253215, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253215 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 253215, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253215 = 1;
SET @EVERLAKE_CS253215 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253215 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 253215, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002003 AS `guid`, -5637.5 AS `x`, -729.2 AS `y`, 31.6 AS `z`, 3.4 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS253215 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS253215 = 1 AND c.`id` = 253215 AND c.`guid` BETWEEN 974002003 AND 974002003;

-- Izha'Rel (253218) boss: model 143040, levels 58-58, health x6.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C253218 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 253218)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253218);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 253218, 0, 0, 'Izha''Rel', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C253218 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 253218, 0, 0, 0, 0, 0, 6.0, 1, 1, 2.0, 0, 0, 128, 0, 253218, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C253218 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 253218, 0, 143040, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C253218 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 253218, 58, 58 FROM DUAL WHERE @EVERLAKE_C253218 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 253218);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 253218, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253218 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 253218, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253218 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 253218, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253218 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 253218, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253218 = 1;
SET @EVERLAKE_CS253218 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253218 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 253218, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002004 AS `guid`, -5687.5 AS `x`, -737.5 AS `y`, 26.65 AS `z`, 5.312 AS `o` -- Izha'Rel beside Tor'Rel (INFERRED spot)
) s WHERE @EVERLAKE_CS253218 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS253218 = 1 AND c.`id` = 253218 AND c.`guid` BETWEEN 974002004 AND 974002004;

-- Devilsaur (261749): model 144495, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261749 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261749)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261749);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261749, 0, 0, 'Devilsaur', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261749 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261749, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261749, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261749 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261749, 0, 144495, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261749 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261749, 58, 59 FROM DUAL WHERE @EVERLAKE_C261749 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261749);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261749, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261749 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261749, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261749 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261749, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261749 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261749, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261749 = 1;
SET @EVERLAKE_CS261749 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261749 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261749, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002005 AS `guid`, -5620.8 AS `x`, -970.8 AS `y`, 19.89 AS `z`, 4.102 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261749 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261749 = 1 AND c.`id` = 261749 AND c.`guid` BETWEEN 974002005 AND 974002005;

-- Tyranosaur (261750): model 142990, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261750 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261750)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261750);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261750, 0, 0, 'Tyranosaur', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261750 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261750, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261750, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261750 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261750, 0, 142990, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261750 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261750, 58, 59 FROM DUAL WHERE @EVERLAKE_C261750 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261750);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261750, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261750 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261750, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261750 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261750, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261750 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261750, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261750 = 1;
SET @EVERLAKE_CS261750 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261750 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261750, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002006 AS `guid`, -5662.5 AS `x`, -1012.5 AS `y`, 13.74 AS `z`, 4.157 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261750 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261750 = 1 AND c.`id` = 261750 AND c.`guid` BETWEEN 974002006 AND 974002006;

-- Devilsaur (261752): model 144497, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261752 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261752)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261752);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261752, 0, 0, 'Devilsaur', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261752 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261752, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261752, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261752 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261752, 0, 144497, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261752 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261752, 58, 59 FROM DUAL WHERE @EVERLAKE_C261752 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261752);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261752, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261752 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261752, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261752 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261752, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261752 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261752, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261752 = 1;
SET @EVERLAKE_CS261752 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261752 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261752, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002007 AS `guid`, -5579.2 AS `x`, -929.2 AS `y`, 22.4 AS `z`, 4.069 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261752 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261752 = 1 AND c.`id` = 261752 AND c.`guid` BETWEEN 974002007 AND 974002007;

-- Azurepetal Trapper (261770): model 13172, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261770 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261770)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261770);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261770, 0, 0, 'Azurepetal Trapper', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261770 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261770, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261770, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261770 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261770, 0, 13172, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261770 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261770, 58, 59 FROM DUAL WHERE @EVERLAKE_C261770 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261770);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261770, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261770 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261770, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261770 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261770, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261770 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261770, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261770 = 1;
SET @EVERLAKE_CS261770 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261770 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261770, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002008 AS `guid`, -5670.8 AS `x`, -704.2 AS `y`, 25.8 AS `z`, 4.358 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002009 AS `guid`, -5587.5 AS `x`, -737.5 AS `y`, 31.97 AS `z`, 3.185 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261770 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261770 = 1 AND c.`id` = 261770 AND c.`guid` BETWEEN 974002008 AND 974002009;

-- Diemetradon (261771): model 8512, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261771 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261771)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261771);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261771, 0, 0, 'Diemetradon', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261771 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261771, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261771, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261771 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261771, 0, 8512, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261771 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261771, 58, 59 FROM DUAL WHERE @EVERLAKE_C261771 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261771);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261771, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261771 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261771, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261771 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261771, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261771 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261771, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261771 = 1;
SET @EVERLAKE_CS261771 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261771 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261771, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002010 AS `guid`, -5529.2 AS `x`, -962.5 AS `y`, 18.82 AS `z`, 3.878 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002011 AS `guid`, -5579.2 AS `x`, -812.5 AS `y`, 18.59 AS `z`, 4.242 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261771 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261771 = 1 AND c.`id` = 261771 AND c.`guid` BETWEEN 974002010 AND 974002011;

-- Tar Lurker (261773): model 9010, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261773 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261773)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261773);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261773, 0, 0, 'Tar Lurker', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261773 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261773, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261773, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261773 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261773, 0, 9010, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261773 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261773, 58, 59 FROM DUAL WHERE @EVERLAKE_C261773 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261773);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261773, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261773 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261773, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261773 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261773, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261773 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261773, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261773 = 1;
SET @EVERLAKE_CS261773 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261773 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261773, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002012 AS `guid`, -5912.5 AS `x`, -1262.5 AS `y`, 9.71 AS `z`, 1.636 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002013 AS `guid`, -5929.2 AS `x`, -1170.8 AS `y`, 9.2 AS `z`, 4.975 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261773 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261773 = 1 AND c.`id` = 261773 AND c.`guid` BETWEEN 974002012 AND 974002013;

-- Azurepetal Flayer (261774): model 13172, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261774 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261774)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261774);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261774, 0, 0, 'Azurepetal Flayer', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261774 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261774, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261774, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261774 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261774, 0, 13172, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261774 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261774, 58, 59 FROM DUAL WHERE @EVERLAKE_C261774 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261774);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261774, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261774 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261774, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261774 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261774, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261774 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261774, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261774 = 1;
SET @EVERLAKE_CS261774 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261774 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261774, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002014 AS `guid`, -5745.8 AS `x`, -737.5 AS `y`, 33.59 AS `z`, 6.215 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002015 AS `guid`, -5762.5 AS `x`, -704.2 AS `y`, 37.43 AS `z`, 5.835 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261774 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261774 = 1 AND c.`id` = 261774 AND c.`guid` BETWEEN 974002014 AND 974002015;

-- Tar Walker (261779): model 480, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261779 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261779)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261779);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261779, 0, 0, 'Tar Walker', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261779 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261779, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261779, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261779 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261779, 0, 480, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261779 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261779, 58, 59 FROM DUAL WHERE @EVERLAKE_C261779 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261779);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261779, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261779 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261779, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261779 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261779, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261779 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261779, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261779 = 1;
SET @EVERLAKE_CS261779 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261779 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261779, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002016 AS `guid`, -5912.5 AS `x`, -1137.5 AS `y`, 8.45 AS `z`, 4.682 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002017 AS `guid`, -5937.5 AS `x`, -1320.8 AS `y`, 10.24 AS `z`, 1.345 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261779 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261779 = 1 AND c.`id` = 261779 AND c.`guid` BETWEEN 974002016 AND 974002017;

-- Quickpetal Lasher (261780): model 12348, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261780 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261780)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261780);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261780, 0, 0, 'Quickpetal Lasher', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261780 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261780, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261780, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261780 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261780, 0, 12348, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261780 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261780, 58, 59 FROM DUAL WHERE @EVERLAKE_C261780 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261780);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261780, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261780 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261780, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261780 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261780, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261780 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261780, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261780 = 1;
SET @EVERLAKE_CS261780 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261780 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261780, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002018 AS `guid`, -5604.2 AS `x`, -1237.5 AS `y`, 38.54 AS `z`, 4.444 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002019 AS `guid`, -5637.5 AS `x`, -1587.5 AS `y`, 40.72 AS `z`, 1.779 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261780 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261780 = 1 AND c.`id` = 261780 AND c.`guid` BETWEEN 974002018 AND 974002019;

-- Tar Crawler (261781): model 3018, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261781 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261781)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261781);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261781, 0, 0, 'Tar Crawler', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261781 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261781, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261781, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261781 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261781, 0, 3018, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261781 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261781, 58, 59 FROM DUAL WHERE @EVERLAKE_C261781 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261781);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261781, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261781 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261781, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261781 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261781, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261781 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261781, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261781 = 1;
SET @EVERLAKE_CS261781 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261781 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261781, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002020 AS `guid`, -6029.2 AS `x`, -1462.5 AS `y`, -0.99 AS `z`, 4.812 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002021 AS `guid`, -6020.8 AS `x`, -1712.5 AS `y`, 11.57 AS `z`, 1.552 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261781 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261781 = 1 AND c.`id` = 261781 AND c.`guid` BETWEEN 974002020 AND 974002021;

-- Tar Hunter (261782): model 1549, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261782 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261782)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261782);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261782, 0, 0, 'Tar Hunter', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261782 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261782, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261782, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261782 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261782, 0, 1549, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261782 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261782, 58, 59 FROM DUAL WHERE @EVERLAKE_C261782 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261782);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261782, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261782 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261782, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261782 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261782, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261782 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261782, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261782 = 1;
SET @EVERLAKE_CS261782 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261782 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261782, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002022 AS `guid`, -6037.5 AS `x`, -1679.2 AS `y`, 8.23 AS `z`, 1.39 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002023 AS `guid`, -6004.2 AS `x`, -1504.2 AS `y`, 8.52 AS `z`, 4.514 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261782 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261782 = 1 AND c.`id` = 261782 AND c.`guid` BETWEEN 974002022 AND 974002023;

-- Thunderstomp Stegodon (261783): model 10934, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261783 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261783)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261783);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261783, 0, 0, 'Thunderstomp Stegodon', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261783 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261783, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261783, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261783 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261783, 0, 10934, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261783 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261783, 58, 59 FROM DUAL WHERE @EVERLAKE_C261783 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261783);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261783, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261783 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261783, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261783 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261783, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261783 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261783, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261783 = 1;
SET @EVERLAKE_CS261783 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261783 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261783, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002024 AS `guid`, -5520.8 AS `x`, -1037.5 AS `y`, 11.19 AS `z`, 3.655 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261783 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261783 = 1 AND c.`id` = 261783 AND c.`guid` BETWEEN 974002024 AND 974002024;

-- Spiked Stegodon (261784): model 143329, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261784 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261784)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261784);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261784, 0, 0, 'Spiked Stegodon', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261784 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261784, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261784, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261784 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261784, 0, 143329, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261784 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261784, 58, 59 FROM DUAL WHERE @EVERLAKE_C261784 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261784);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261784, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261784 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261784, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261784 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261784, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261784 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261784, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261784 = 1;
SET @EVERLAKE_CS261784 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261784 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261784, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002025 AS `guid`, -5787.5 AS `x`, -904.2 AS `y`, 22.63 AS `z`, 4.803 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002026 AS `guid`, -5762.5 AS `x`, -1479.2 AS `y`, 9.03 AS `z`, 1.572 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261784 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261784 = 1 AND c.`id` = 261784 AND c.`guid` BETWEEN 974002025 AND 974002026;

-- Plated Stegodon (261785): model 2764, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261785 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261785)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261785);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261785, 0, 0, 'Plated Stegodon', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261785 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261785, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261785, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261785 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261785, 0, 2764, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261785 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261785, 58, 59 FROM DUAL WHERE @EVERLAKE_C261785 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261785);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261785, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261785 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261785, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261785 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261785, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261785 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261785, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261785 = 1;
SET @EVERLAKE_CS261785 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261785 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261785, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002027 AS `guid`, -5662.5 AS `x`, -779.2 AS `y`, 24.03 AS `z`, 4.463 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002028 AS `guid`, -5737.5 AS `x`, -1054.2 AS `y`, 9.01 AS `z`, 4.504 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261785 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261785 = 1 AND c.`id` = 261785 AND c.`guid` BETWEEN 974002027 AND 974002028;

-- Ironhide Ravasaur (261786): model 1337, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261786 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261786)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261786);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261786, 0, 0, 'Ironhide Ravasaur', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261786 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261786, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261786, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261786 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261786, 0, 1337, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261786 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261786, 58, 59 FROM DUAL WHERE @EVERLAKE_C261786 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261786);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261786, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261786 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261786, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261786 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261786, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261786 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261786, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261786 = 1;
SET @EVERLAKE_CS261786 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261786 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261786, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002029 AS `guid`, -5812.5 AS `x`, -1329.2 AS `y`, -6.38 AS `z`, 1.261 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002030 AS `guid`, -5862.5 AS `x`, -1179.2 AS `y`, 0.36 AS `z`, 0.051 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261786 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261786 = 1 AND c.`id` = 261786 AND c.`guid` BETWEEN 974002029 AND 974002030;

-- Nanaya (261809) boss: model 143832, levels 60-60, health x14.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261809 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261809)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261809);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261809, 0, 0, 'Nanaya', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 5, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261809, 0, 0, 0, 0, 0, 14.0, 1, 1, 2.0, 0, 0, 128, 0, 261809, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261809, 0, 143832, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261809, 60, 60 FROM DUAL WHERE @EVERLAKE_C261809 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261809);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261809, 0, 273116, 4.29, 0, 1, 0, 1, 1, 'Nanaya: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261809 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261809 AND `ItemType` = 0 AND `Item` = 273116);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261809, 0, 273128, 95.09, 0, 1, 0, 1, 1, 'Nanaya: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261809 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261809 AND `ItemType` = 0 AND `Item` = 273128);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261809, 0, 274964, 3.07, 0, 1, 0, 1, 1, 'Nanaya: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261809 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261809 AND `ItemType` = 0 AND `Item` = 274964);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261809, 0, 280023, 34.97, 0, 1, 0, 1, 1, 'Nanaya: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261809 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261809 AND `ItemType` = 0 AND `Item` = 280023);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261809, 0, 280024, 25.77, 0, 1, 0, 1, 1, 'Nanaya: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261809 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261809 AND `ItemType` = 0 AND `Item` = 280024);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261809, 0, 280025, 31.9, 0, 1, 0, 1, 1, 'Nanaya: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261809 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261809 AND `ItemType` = 0 AND `Item` = 280025);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261809, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261809, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261809, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261809, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261809, 0, 273116, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261809, 0, 273128, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261809, 0, 274964, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261809, 0, 280023, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261809, 0, 280024, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261809 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261809, 0, 280025, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261809 = 1;
SET @EVERLAKE_CS261809 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261809 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261809, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002031 AS `guid`, -5854.2 AS `x`, -1587.5 AS `y`, 37.14 AS `z`, 0.36 AS `o` -- Nanaya on the Pillar of Assimilation (summoned by the Titan Panel on live) (INFERRED spot)
) s WHERE @EVERLAKE_CS261809 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261809 = 1 AND c.`id` = 261809 AND c.`guid` BETWEEN 974002031 AND 974002031;

-- Tor'Rel (261811) boss: model 143039, levels 58-58, health x6.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261811 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261811)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261811);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261811, 0, 0, 'Tor''Rel', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261811 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261811, 0, 0, 0, 0, 0, 6.0, 1, 1, 2.0, 0, 0, 128, 0, 261811, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261811 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261811, 0, 143039, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261811 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261811, 58, 58 FROM DUAL WHERE @EVERLAKE_C261811 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261811);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261811, 0, 274964, 4.08, 0, 1, 0, 1, 1, 'Tor''Rel: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261811 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261811 AND `ItemType` = 0 AND `Item` = 274964);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261811, 0, 280012, 29.25, 0, 1, 0, 1, 1, 'Tor''Rel: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261811 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261811 AND `ItemType` = 0 AND `Item` = 280012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261811, 0, 280013, 27.21, 0, 1, 0, 1, 1, 'Tor''Rel: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261811 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261811 AND `ItemType` = 0 AND `Item` = 280013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261811, 0, 280014, 37.41, 0, 1, 0, 1, 1, 'Tor''Rel: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261811 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261811 AND `ItemType` = 0 AND `Item` = 280014);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261811, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261811 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261811, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261811 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261811, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261811 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261811, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261811 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261811, 0, 274964, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261811 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261811, 0, 280012, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261811 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261811, 0, 280013, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261811 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261811, 0, 280014, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261811 = 1;
SET @EVERLAKE_CS261811 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261811 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261811, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002032 AS `guid`, -5687.5 AS `x`, -745.8 AS `y`, 25.93 AS `z`, 0.966 AS `o` -- Tor'Rel on the northern path (INFERRED spot)
) s WHERE @EVERLAKE_CS261811 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261811 = 1 AND c.`id` = 261811 AND c.`guid` BETWEEN 974002032 AND 974002032;

-- Thunderhoof (261812) boss: model 144514, levels 58-58, health x9.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261812 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261812)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261812);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261812, 0, 0, 'Thunderhoof', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261812 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261812, 0, 0, 0, 0, 0, 9.0, 1, 1, 2.0, 0, 0, 128, 0, 261812, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261812 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261812, 0, 144514, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261812 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261812, 58, 58 FROM DUAL WHERE @EVERLAKE_C261812 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261812);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261812, 0, 274964, 8.97, 0, 1, 0, 1, 1, 'Thunderhoof: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261812 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261812 AND `ItemType` = 0 AND `Item` = 274964);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261812, 0, 280018, 24.14, 0, 1, 0, 1, 1, 'Thunderhoof: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261812 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261812 AND `ItemType` = 0 AND `Item` = 280018);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261812, 0, 280019, 31.03, 0, 1, 0, 1, 1, 'Thunderhoof: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261812 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261812 AND `ItemType` = 0 AND `Item` = 280019);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261812, 0, 280020, 40.0, 0, 1, 0, 1, 1, 'Thunderhoof: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261812 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261812 AND `ItemType` = 0 AND `Item` = 280020);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261812, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261812 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261812, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261812 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261812, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261812 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261812, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261812 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261812, 0, 274964, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261812 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261812, 0, 280018, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261812 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261812, 0, 280019, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261812 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261812, 0, 280020, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261812 = 1;
SET @EVERLAKE_CS261812 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261812 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261812, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002033 AS `guid`, -6020.8 AS `x`, -1554.2 AS `y`, 9.37 AS `z`, 4.849 AS `o` -- Thunderhoof on the south rim (Shaper's Plateau) (INFERRED spot)
) s WHERE @EVERLAKE_CS261812 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261812 = 1 AND c.`id` = 261812 AND c.`guid` BETWEEN 974002033 AND 974002033;

-- Venomridge (261813) boss: model 144511, levels 58-58, health x9.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261813 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261813)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261813);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261813, 0, 0, 'Venomridge', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261813 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261813, 0, 0, 0, 0, 0, 9.0, 1, 1, 2.0, 0, 0, 128, 0, 261813, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261813 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261813, 0, 144511, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261813 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261813, 58, 58 FROM DUAL WHERE @EVERLAKE_C261813 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261813);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261813, 0, 274964, 3.61, 0, 1, 0, 1, 1, 'Venomridge: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261813 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261813 AND `ItemType` = 0 AND `Item` = 274964);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261813, 0, 280015, 31.93, 0, 1, 0, 1, 1, 'Venomridge: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261813 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261813 AND `ItemType` = 0 AND `Item` = 280015);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261813, 0, 280016, 30.12, 0, 1, 0, 1, 1, 'Venomridge: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261813 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261813 AND `ItemType` = 0 AND `Item` = 280016);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261813, 0, 280017, 32.53, 0, 1, 0, 1, 1, 'Venomridge: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261813 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261813 AND `ItemType` = 0 AND `Item` = 280017);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261813, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261813 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261813, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261813 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261813, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261813 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261813, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261813 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261813, 0, 274964, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261813 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261813, 0, 280015, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261813 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261813, 0, 280016, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261813 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261813, 0, 280017, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261813 = 1;
SET @EVERLAKE_CS261813 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261813 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261813, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002034 AS `guid`, -5912.5 AS `x`, -1220.8 AS `y`, 8.88 AS `z`, 3.906 AS `o` -- Venomridge by the tar (Botanical Grounds) (INFERRED spot)
) s WHERE @EVERLAKE_CS261813 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261813 = 1 AND c.`id` = 261813 AND c.`guid` BETWEEN 974002034 AND 974002034;

-- Ravasaur Juvenile (261898): model 11316, levels 58-59, health x1.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261898 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261898)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261898);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261898, 0, 0, 'Ravasaur Juvenile', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261898 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261898, 0, 0, 0, 0, 0, 1.0, 1, 1, 1.0, 0, 0, 0, 0, 261898, 0, 0, 40, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261898 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261898, 0, 11316, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261898 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261898, 58, 59 FROM DUAL WHERE @EVERLAKE_C261898 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261898);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261898, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261898 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261898, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261898 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261898, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261898 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261898, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261898 = 1;
SET @EVERLAKE_CS261898 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261898 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261898, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002035 AS `guid`, -5804.2 AS `x`, -1762.5 AS `y`, 18.68 AS `z`, 1.501 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002036 AS `guid`, -5904.2 AS `x`, -1462.5 AS `y`, 11.0 AS `z`, 1.115 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261898 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261898 = 1 AND c.`id` = 261898 AND c.`guid` BETWEEN 974002035 AND 974002036;

-- Ravasaur Stalker (261934): model 648, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261934 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261934)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261934);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261934, 0, 0, 'Ravasaur Stalker', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261934 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261934, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261934, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261934 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261934, 0, 648, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261934 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261934, 58, 59 FROM DUAL WHERE @EVERLAKE_C261934 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261934);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261934, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261934 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261934, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261934 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261934, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261934 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261934, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261934 = 1;
SET @EVERLAKE_CS261934 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261934 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261934, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002037 AS `guid`, -5612.5 AS `x`, -879.2 AS `y`, 22.61 AS `z`, 4.241 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002038 AS `guid`, -5687.5 AS `x`, -1154.2 AS `y`, 8.88 AS `z`, 3.4 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261934 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261934 = 1 AND c.`id` = 261934 AND c.`guid` BETWEEN 974002037 AND 974002038;

-- Azurepetal Sporecaller (261968): model 132032, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261968 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261968)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261968);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261968, 0, 0, 'Azurepetal Sporecaller', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261968 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261968, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 261968, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261968 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261968, 0, 132032, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261968 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261968, 58, 59 FROM DUAL WHERE @EVERLAKE_C261968 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261968);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261968, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261968 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261968, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261968 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261968, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261968 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261968, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261968 = 1;
SET @EVERLAKE_CS261968 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261968 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261968, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002039 AS `guid`, -5770.8 AS `x`, -762.5 AS `y`, 37.17 AS `z`, 0.237 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS261968 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261968 = 1 AND c.`id` = 261968 AND c.`guid` BETWEEN 974002039 AND 974002039;

-- Cinder (261974) boss: model 143035, levels 58-58, health x9.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261974 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261974)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261974);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261974, 0, 0, 'Cinder', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261974 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261974, 0, 0, 0, 0, 0, 9.0, 1, 1, 2.0, 0, 0, 128, 0, 261974, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261974 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261974, 0, 143035, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261974 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261974, 58, 58 FROM DUAL WHERE @EVERLAKE_C261974 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261974);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261974, 0, 274964, 3.64, 0, 1, 0, 1, 1, 'Cinder: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261974 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261974 AND `ItemType` = 0 AND `Item` = 274964);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261974, 0, 280028, 58.18, 0, 1, 0, 1, 1, 'Cinder: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261974 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261974 AND `ItemType` = 0 AND `Item` = 280028);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 261974, 0, 280029, 40.0, 0, 1, 0, 1, 1, 'Cinder: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C261974 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 261974 AND `ItemType` = 0 AND `Item` = 280029);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261974, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261974 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261974, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261974 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261974, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261974 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261974, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261974 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261974, 0, 274964, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261974 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261974, 0, 280028, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261974 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 261974, 0, 280029, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261974 = 1;
SET @EVERLAKE_CS261974 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261974 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261974, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002040 AS `guid`, -5904.2 AS `x`, -862.5 AS `y`, 112.81 AS `z`, 5.584 AS `o` -- Cinder at Ruby Spring, the Red Archival Panel's hills (summoned on live) (INFERRED spot)
) s WHERE @EVERLAKE_CS261974 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261974 = 1 AND c.`id` = 261974 AND c.`guid` BETWEEN 974002040 AND 974002040;

-- King Op (261993) boss: model 143129, levels 58-58, health x8.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C261993 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261993)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261993);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261993, 0, 0, 'King Op', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 2, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261993 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261993, 0, 0, 0, 0, 0, 8.0, 1, 1, 2.0, 0, 0, 128, 0, 261993, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261993 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261993, 0, 143129, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261993 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261993, 58, 58 FROM DUAL WHERE @EVERLAKE_C261993 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261993);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261993, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261993 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261993, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261993 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261993, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261993 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261993, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261993 = 1;
SET @EVERLAKE_CS261993 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261993 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261993, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002041 AS `guid`, -6020.8 AS `x`, -1829.2 AS `y`, 57.07 AS `z`, 1.196 AS `o` -- King Op among the gorillas, east of the plains (INFERRED spot)
) s WHERE @EVERLAKE_CS261993 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS261993 = 1 AND c.`id` = 261993 AND c.`guid` BETWEEN 974002041 AND 974002041;

-- Bolt (262081) boss: model 143063, levels 58-58, health x9.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262081 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262081)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262081);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262081, 0, 0, 'Bolt', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262081 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262081, 0, 0, 0, 0, 0, 9.0, 1, 1, 2.0, 0, 0, 128, 0, 262081, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262081 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262081, 0, 143063, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262081 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262081, 58, 58 FROM DUAL WHERE @EVERLAKE_C262081 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262081);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 262081, 0, 274964, 4.43, 0, 1, 0, 1, 1, 'Bolt: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C262081 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 262081 AND `ItemType` = 0 AND `Item` = 274964);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 262081, 0, 280031, 48.73, 0, 1, 0, 1, 1, 'Bolt: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C262081 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 262081 AND `ItemType` = 0 AND `Item` = 280031);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 262081, 0, 280032, 50.63, 0, 1, 0, 1, 1, 'Bolt: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C262081 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 262081 AND `ItemType` = 0 AND `Item` = 280032);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262081, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262081 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262081, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262081 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262081, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262081 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262081, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262081 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 262081, 0, 274964, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262081 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 262081, 0, 280031, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262081 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 262081, 0, 280032, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262081 = 1;
SET @EVERLAKE_CS262081 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262081 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262081, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002042 AS `guid`, -5929.2 AS `x`, -1220.8 AS `y`, 9.11 AS `z`, 6.11 AS `o` -- Bolt behind Venomridge, the Yellow Panel (summoned on live) (INFERRED spot)
) s WHERE @EVERLAKE_CS262081 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262081 = 1 AND c.`id` = 262081 AND c.`guid` BETWEEN 974002042 AND 974002042;

-- Ravasaur Trapper (262114): model 1962, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262114 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262114)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262114);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262114, 0, 0, 'Ravasaur Trapper', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262114 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262114, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262114, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262114 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262114, 0, 1962, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262114 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262114, 58, 59 FROM DUAL WHERE @EVERLAKE_C262114 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262114);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262114, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262114 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262114, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262114 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262114, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262114 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262114, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262114 = 1;
SET @EVERLAKE_CS262114 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262114 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262114, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002043 AS `guid`, -5812.5 AS `x`, -1054.2 AS `y`, 13.6 AS `z`, 5.104 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002044 AS `guid`, -5637.5 AS `x`, -1079.2 AS `y`, 10.12 AS `z`, 3.79 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262114 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262114 = 1 AND c.`id` = 262114 AND c.`guid` BETWEEN 974002043 AND 974002044;

-- Ravasaur Assassin (262115): model 948, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262115 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262115)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262115);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262115, 0, 0, 'Ravasaur Assassin', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262115 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262115, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262115, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262115 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262115, 0, 948, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262115 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262115, 58, 59 FROM DUAL WHERE @EVERLAKE_C262115 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262115);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262115, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262115 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262115, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262115 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262115, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262115 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262115, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262115 = 1;
SET @EVERLAKE_CS262115 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262115 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262115, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002045 AS `guid`, -5687.5 AS `x`, -929.2 AS `y`, 18.96 AS `z`, 4.414 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002046 AS `guid`, -5737.5 AS `x`, -779.2 AS `y`, 30.89 AS `z`, 4.648 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262115 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262115 = 1 AND c.`id` = 262115 AND c.`guid` BETWEEN 974002045 AND 974002046;

-- Stegodon Young (262117): model 1540, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262117 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262117)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262117);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262117, 0, 0, 'Stegodon Young', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262117 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262117, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262117, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262117 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262117, 0, 1540, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262117 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262117, 58, 59 FROM DUAL WHERE @EVERLAKE_C262117 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262117);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262117, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262117 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262117, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262117 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262117, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262117 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262117, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262117 = 1;
SET @EVERLAKE_CS262117 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262117 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262117, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002047 AS `guid`, -5645.8 AS `x`, -829.2 AS `y`, 24.52 AS `z`, 4.385 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002048 AS `guid`, -5770.8 AS `x`, -954.2 AS `y`, 18.81 AS `z`, 4.748 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262117 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262117 = 1 AND c.`id` = 262117 AND c.`guid` BETWEEN 974002047 AND 974002048;

-- Direhorn Matriarch (262127) boss: model 144515, levels 58-58, health x9.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262127 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262127)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262127);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262127, 0, 0, 'Direhorn Matriarch', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262127 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262127, 0, 0, 0, 0, 0, 9.0, 1, 1, 2.0, 0, 0, 128, 0, 262127, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262127 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262127, 0, 144515, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262127 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262127, 58, 58 FROM DUAL WHERE @EVERLAKE_C262127 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262127);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 262127, 0, 274964, 4.52, 0, 1, 0, 1, 1, 'Direhorn Matriarch: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C262127 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 262127 AND `ItemType` = 0 AND `Item` = 274964);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 262127, 0, 280021, 33.55, 0, 1, 0, 1, 1, 'Direhorn Matriarch: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C262127 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 262127 AND `ItemType` = 0 AND `Item` = 280021);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 262127, 0, 280022, 37.42, 0, 1, 0, 1, 1, 'Direhorn Matriarch: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C262127 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 262127 AND `ItemType` = 0 AND `Item` = 280022);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 262127, 0, 280045, 28.39, 0, 1, 0, 1, 1, 'Direhorn Matriarch: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C262127 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 262127 AND `ItemType` = 0 AND `Item` = 280045);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262127, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262127 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262127, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262127 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262127, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262127 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262127, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262127 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 262127, 0, 274964, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262127 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 262127, 0, 280021, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262127 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 262127, 0, 280022, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262127 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 262127, 0, 280045, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262127 = 1;
SET @EVERLAKE_CS262127 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262127 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262127, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002049 AS `guid`, -5729.2 AS `x`, -1762.5 AS `y`, 34.07 AS `z`, 1.363 AS `o` -- the Direhorn Matriarch at the eastern edge (INFERRED spot)
) s WHERE @EVERLAKE_CS262127 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262127 = 1 AND c.`id` = 262127 AND c.`guid` BETWEEN 974002049 AND 974002049;

-- Emerald Flayer (262164): model 132024, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262164 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262164)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262164);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262164, 0, 0, 'Emerald Flayer', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262164 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262164, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262164, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262164 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262164, 0, 132024, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262164 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262164, 58, 59 FROM DUAL WHERE @EVERLAKE_C262164 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262164);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262164, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262164 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262164, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262164 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262164, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262164 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262164, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262164 = 1;
SET @EVERLAKE_CS262164 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262164 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262164, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002050 AS `guid`, -5787.5 AS `x`, -1279.2 AS `y`, -6.36 AS `z`, 1.341 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002051 AS `guid`, -5837.5 AS `x`, -1129.2 AS `y`, 8.95 AS `z`, 5.741 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262164 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262164 = 1 AND c.`id` = 262164 AND c.`guid` BETWEEN 974002050 AND 974002051;

-- Emerald Overgrowth (262166): model 138253, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262166 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262166)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262166);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262166, 0, 0, 'Emerald Overgrowth', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262166 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262166, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262166, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262166 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262166, 0, 138253, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262166 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262166, 58, 59 FROM DUAL WHERE @EVERLAKE_C262166 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262166);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262166, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262166 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262166, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262166 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262166, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262166 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262166, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262166 = 1;
SET @EVERLAKE_CS262166 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262166 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262166, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002052 AS `guid`, -5812.5 AS `x`, -1704.2 AS `y`, 10.3 AS `z`, 1.477 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262166 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262166 = 1 AND c.`id` = 262166 AND c.`guid` BETWEEN 974002052 AND 974002052;

-- Emerald Seedling (262167): model 13172, levels 58-59, health x1.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262167 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262167)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262167);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262167, 0, 0, 'Emerald Seedling', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262167 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262167, 0, 0, 0, 0, 0, 1.0, 1, 1, 1.0, 0, 0, 0, 0, 262167, 0, 0, 40, 120, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262167 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262167, 0, 13172, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262167 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262167, 58, 59 FROM DUAL WHERE @EVERLAKE_C262167 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262167);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262167, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262167 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262167, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262167 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262167, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262167 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262167, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262167 = 1;
SET @EVERLAKE_CS262167 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262167 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262167, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002053 AS `guid`, -5820.8 AS `x`, -1454.2 AS `y`, 10.2 AS `z`, 1.367 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002054 AS `guid`, -5995.8 AS `x`, -1429.2 AS `y`, 6.73 AS `z`, 0.831 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262167 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262167 = 1 AND c.`id` = 262167 AND c.`guid` BETWEEN 974002053 AND 974002054;

-- Emerald Harvester (262168): model 138246, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262168 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262168)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262168);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262168, 0, 0, 'Emerald Harvester', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262168 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262168, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262168, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262168 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262168, 0, 138246, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262168 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262168, 58, 59 FROM DUAL WHERE @EVERLAKE_C262168 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262168);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262168, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262168 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262168, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262168 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262168, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262168 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262168, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262168 = 1;
SET @EVERLAKE_CS262168 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262168 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262168, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002055 AS `guid`, -5579.2 AS `x`, -1012.5 AS `y`, 14.72 AS `z`, 3.863 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262168 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262168 = 1 AND c.`id` = 262168 AND c.`guid` BETWEEN 974002055 AND 974002055;

-- Emberleaf Flayer (262188): model 13110, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262188 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262188)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262188);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262188, 0, 0, 'Emberleaf Flayer', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262188 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262188, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262188, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262188 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262188, 0, 13110, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262188 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262188, 58, 59 FROM DUAL WHERE @EVERLAKE_C262188 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262188);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262188, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262188 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262188, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262188 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262188, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262188 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262188, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262188 = 1;
SET @EVERLAKE_CS262188 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262188 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262188, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002056 AS `guid`, -5729.2 AS `x`, -562.5 AS `y`, 5.09 AS `z`, 5.428 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002057 AS `guid`, -5637.5 AS `x`, -670.8 AS `y`, 25.27 AS `z`, 2.264 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262188 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262188 = 1 AND c.`id` = 262188 AND c.`guid` BETWEEN 974002056 AND 974002057;

-- Emberleaf Germinator (262190): model 138256, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262190 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262190)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262190);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262190, 0, 0, 'Emberleaf Germinator', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262190 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262190, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262190, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262190 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262190, 0, 138256, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262190 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262190, 58, 59 FROM DUAL WHERE @EVERLAKE_C262190 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262190);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262190, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262190 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262190, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262190 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262190, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262190 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262190, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262190 = 1;
SET @EVERLAKE_CS262190 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262190 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262190, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002058 AS `guid`, -5637.5 AS `x`, -554.2 AS `y`, 9.49 AS `z`, 3.931 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002059 AS `guid`, -5679.2 AS `x`, -654.2 AS `y`, 19.68 AS `z`, 1.802 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262190 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262190 = 1 AND c.`id` = 262190 AND c.`guid` BETWEEN 974002058 AND 974002059;

-- Emberleaf Scorcher (262191): model 13110, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262191 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262191)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262191);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262191, 0, 0, 'Emberleaf Scorcher', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262191 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262191, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262191, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262191 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262191, 0, 13110, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262191 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262191, 58, 59 FROM DUAL WHERE @EVERLAKE_C262191 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262191);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262191, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262191 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262191, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262191 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262191, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262191 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262191, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262191 = 1;
SET @EVERLAKE_CS262191 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262191 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262191, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002060 AS `guid`, -5729.2 AS `x`, -620.8 AS `y`, 17.14 AS `z`, 0.332 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262191 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262191 = 1 AND c.`id` = 262191 AND c.`guid` BETWEEN 974002060 AND 974002060;

-- Quickpetal Flayer (262197): model 132025, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262197 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262197)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262197);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262197, 0, 0, 'Quickpetal Flayer', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262197 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262197, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262197, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262197 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262197, 0, 132025, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262197 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262197, 58, 59 FROM DUAL WHERE @EVERLAKE_C262197 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262197);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262197, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262197 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262197, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262197 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262197, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262197 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262197, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262197 = 1;
SET @EVERLAKE_CS262197 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262197 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262197, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002061 AS `guid`, -5679.2 AS `x`, -1537.5 AS `y`, 43.07 AS `z`, 1.392 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002062 AS `guid`, -5637.5 AS `x`, -1495.8 AS `y`, 40.8 AS `z`, 2.198 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262197 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262197 = 1 AND c.`id` = 262197 AND c.`guid` BETWEEN 974002061 AND 974002062;

-- Snowtalon (262297) boss: model 143122, levels 58-58, health x9.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262297 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262297)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262297);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262297, 0, 0, 'Snowtalon', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262297 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262297, 0, 0, 0, 0, 0, 9.0, 1, 1, 2.0, 0, 0, 128, 0, 262297, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262297 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262297, 0, 143122, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262297 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262297, 58, 58 FROM DUAL WHERE @EVERLAKE_C262297 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262297);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 262297, 0, 274964, 5.63, 0, 1, 0, 1, 1, 'Snowtalon: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C262297 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 262297 AND `ItemType` = 0 AND `Item` = 274964);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 262297, 0, 280026, 47.89, 0, 1, 0, 1, 1, 'Snowtalon: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C262297 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 262297 AND `ItemType` = 0 AND `Item` = 280026);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 262297, 0, 280027, 52.11, 0, 1, 0, 1, 1, 'Snowtalon: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C262297 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 262297 AND `ItemType` = 0 AND `Item` = 280027);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262297, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262297 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262297, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262297 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262297, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262297 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262297, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262297 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 262297, 0, 274964, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262297 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 262297, 0, 280026, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262297 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 262297, 0, 280027, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262297 = 1;
SET @EVERLAKE_CS262297 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262297 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262297, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002063 AS `guid`, -5687.5 AS `x`, -604.2 AS `y`, 13.02 AS `z`, 4.002 AS `o` -- Snowtalon in the Crystalline Highlands, the Blue Panel (summoned on live) (INFERRED spot)
) s WHERE @EVERLAKE_CS262297 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262297 = 1 AND c.`id` = 262297 AND c.`guid` BETWEEN 974002063 AND 974002063;

-- Eastgrotto Gorilla (262299): model 844, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262299 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262299)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262299);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262299, 0, 0, 'Eastgrotto Gorilla', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262299 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262299, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262299, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262299 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262299, 0, 844, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262299 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262299, 58, 59 FROM DUAL WHERE @EVERLAKE_C262299 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262299);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262299, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262299 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262299, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262299 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262299, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262299 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262299, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262299 = 1;
SET @EVERLAKE_CS262299 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262299 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262299, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002064 AS `guid`, -5495.8 AS `x`, -995.8 AS `y`, 16.48 AS `z`, 3.73 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002065 AS `guid`, -5670.8 AS `x`, -970.8 AS `y`, 16.57 AS `z`, 4.287 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262299 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262299 = 1 AND c.`id` = 262299 AND c.`guid` BETWEEN 974002064 AND 974002065;

-- Eastgrotto Dweller (262300): model 5244, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262300 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262300)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262300);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262300, 0, 0, 'Eastgrotto Dweller', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262300 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262300, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262300, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262300 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262300, 0, 5244, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262300 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262300, 58, 59 FROM DUAL WHERE @EVERLAKE_C262300 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262300);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262300, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262300 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262300, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262300 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262300, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262300 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262300, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262300 = 1;
SET @EVERLAKE_CS262300 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262300 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262300, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002066 AS `guid`, -5762.5 AS `x`, -862.5 AS `y`, 25.95 AS `z`, 4.711 AS `o` -- a pack (INFERRED spot)
  UNION ALL
  SELECT 974002067 AS `guid`, -5737.5 AS `x`, -1437.5 AS `y`, 9.37 AS `z`, 1.667 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262300 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262300 = 1 AND c.`id` = 262300 AND c.`guid` BETWEEN 974002066 AND 974002067;

-- Eastgrotto Silverback (262301): model 5244, levels 58-59, health x3.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C262301 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262301)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262301);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262301, 0, 0, 'Eastgrotto Silverback', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262301 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262301, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 262301, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262301 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262301, 0, 5244, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262301 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262301, 58, 59 FROM DUAL WHERE @EVERLAKE_C262301 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262301);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262301, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262301 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262301, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262301 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262301, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262301 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262301, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262301 = 1;
SET @EVERLAKE_CS262301 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262301 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262301, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002068 AS `guid`, -5712.5 AS `x`, -1012.5 AS `y`, 11.65 AS `z`, 4.41 AS `o` -- a pack (INFERRED spot)
) s WHERE @EVERLAKE_CS262301 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262301 = 1 AND c.`id` = 262301 AND c.`guid` BETWEEN 974002068 AND 974002068;

-- Vitrix (272561) boss: model 147098, levels 60-60, health x14.0 (INFERRED)
SET @EVERLAKE_NOTE := 'wowhead forever pages (name, rank, type, model, levels, boss drops); faction/health/damage/gold INFERRED';
SET @EVERLAKE_C272561 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 272561)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 272561);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 272561, 0, 0, 'Vitrix', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 272561, 0, 0, 0, 0, 0, 14.0, 1, 1, 2.0, 0, 0, 128, 0, 272561, 0, 0, 2500, 6000, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 272561, 0, 147098, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 272561, 60, 60 FROM DUAL WHERE @EVERLAKE_C272561 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 272561);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 272561, 0, 274964, 4.2, 0, 1, 0, 1, 1, 'Vitrix: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C272561 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 272561 AND `ItemType` = 0 AND `Item` = 274964);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 272561, 0, 280026, 17.65, 0, 1, 0, 1, 1, 'Vitrix: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C272561 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 272561 AND `ItemType` = 0 AND `Item` = 280026);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 272561, 0, 280027, 14.29, 0, 1, 0, 1, 1, 'Vitrix: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C272561 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 272561 AND `ItemType` = 0 AND `Item` = 280027);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 272561, 0, 280028, 12.61, 0, 1, 0, 1, 1, 'Vitrix: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C272561 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 272561 AND `ItemType` = 0 AND `Item` = 280028);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 272561, 0, 280029, 14.29, 0, 1, 0, 1, 1, 'Vitrix: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C272561 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 272561 AND `ItemType` = 0 AND `Item` = 280029);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 272561, 0, 280031, 16.81, 0, 1, 0, 1, 1, 'Vitrix: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C272561 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 272561 AND `ItemType` = 0 AND `Item` = 280031);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 272561, 0, 280032, 24.37, 0, 1, 0, 1, 1, 'Vitrix: Wowhead forever drops' FROM DUAL WHERE @EVERLAKE_C272561 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 272561 AND `ItemType` = 0 AND `Item` = 280032);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 272561, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 272561, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 272561, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 272561, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 272561, 0, 274964, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 272561, 0, 280026, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 272561, 0, 280027, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 272561, 0, 280028, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 272561, 0, 280029, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 272561, 0, 280031, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 272561, 0, 280032, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C272561 = 1;
SET @EVERLAKE_CS272561 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 272561 AND `file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql');
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 272561, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002069 AS `guid`, -5520.8 AS `x`, -845.8 AS `y`, 22.18 AS `z`, 5.326 AS `o` -- Vitrix at Watcher's Overlook, the Green Panel (summoned on live) (INFERRED spot)
) s WHERE @EVERLAKE_CS272561 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS272561 = 1 AND c.`id` = 272561 AND c.`guid` BETWEEN 974002069 AND 974002069;

COMMIT;
