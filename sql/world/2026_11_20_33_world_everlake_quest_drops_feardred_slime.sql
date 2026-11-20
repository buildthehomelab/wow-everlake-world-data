-- Two quest items the realm has no source for (the tracker's "item not obtainable" quest objectives), from the Icy
-- Veins WoW Forever catalogue (https://db.icy-veins.com/wow-forever/: who drops them and how often, recorded by players'
-- addons on live) and Wowhead's WoW Forever NPC pages (https://www.wowhead.com/forever, read 2026-11-20 through the
-- tracker's kept pages: map points).
-- 2026_11_20_33_world_everlake_quest_drops_feardred_slime.sql: written from public data by a script, checked by hand.
--
-- Feardred's Amulet (235334), quest 86777 Master Feardred: live drops it from Master Feardred 236496, a new id for the
--   classic Master Feardred 6652 the realm already spawns at the same spot in Azshara (Wowhead's points for 236496 are
--   around 4489 -6400, the realm's 6652 stands at 4483 -6406). Added to 6652's loot instead of a second Feardred:
--   quest-only, 100% (INFERRED: the recordings give no rate).
-- Seeping Slime Essence (276235), quest 97049 Essence of Seeping Slimes (8 needed): Seeping Slime 262684, which the realm
--   lacks. Template from Icy Veins (not specified type, elite, health x3.1, model 143333) with the settings file
--   2026_11_19_963 gave the dungeon's other creatures: level 58-59, faction 16, respawn 7200 s (INFERRED). Two spawns on
--   The Shaper's Terrace map (3001, a copy of this part of Un'Goro) at Wowhead's two points (Kalimdor map 49.8 75.8 and
--   49.9 75.4 = -5796.27 -1259.71 and -5698.13 -1296.51): by the pools, ground -6.38 and the pool floor -7.13 (height.py).
--   Drop: quest-only, 76.19% (Icy Veins: 16 recorded kills). Model size 0.5 / 1.5 INFERRED (no realm display shares it).
-- Guids: creatures 920014007-008, in the quest NPC block (920014000-920014099).
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
SET @EVERLAKE_FILE := '2026_11_20_33_world_everlake_quest_drops_feardred_slime.sql';
START TRANSACTION;

-- Feardred's Amulet on Master Feardred (6652).
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 6652 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `Item` = 235334);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 235334, 100, 1, 1, 0, 1, 1, 'Feardred''s Amulet' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 235334, 0, @EVERLAKE_FILE, 'Icy Veins item=235334: dropped by 236496 (= 6652); chance INFERRED' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- Seeping Slime (262684).
SET @EVERLAKE_NOTE := 'Icy Veins npc=262684 record + Wowhead points; level/faction/respawn INFERRED as file 2026_11_19_963';
SET @EVERLAKE_M := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 143333);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`) SELECT 143333, 0.5, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_model_info', 143333, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED: no realm display shares model 17322' FROM DUAL WHERE @EVERLAKE_M = 1;
SET @EVERLAKE_C262684 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262684) AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262684);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262684, 0, 0, 'Seeping Slime', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262684 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262684, 0, 0, 0, 0, 0, 3.1, 1, 1, 1, 0, 0, 0, 0, 262684, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262684 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262684, 0, 143333, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262684 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262684, 58, 59 FROM DUAL WHERE @EVERLAKE_C262684 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262684);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_template', 262684, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262684 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 262684);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_template_difficulty', 262684, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262684 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_template_model', 262684, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262684 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_classic_level', 262684, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262684 = 1;
SET @EVERLAKE_CS262684 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262684 AND `file` = '2026_11_20_33_world_everlake_quest_drops_feardred_slime.sql')
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 262684 AND `guid` NOT BETWEEN 920014007 AND 920014008);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262684, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 7200, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 920014007 AS `guid`, -5796.27 AS `x`, -1259.71 AS `y`, -6.38 AS `z`  -- height.py: ground
  UNION ALL
  SELECT 920014008 AS `guid`, -5698.13 AS `x`, -1296.51 AS `y`, -7.13 AS `z`  -- height.py: pool floor (water -7.00)
) s WHERE @EVERLAKE_CS262684 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c WHERE @EVERLAKE_CS262684 = 1 AND c.`id` = 262684 AND c.`guid` BETWEEN 920014007 AND 920014008;

SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 262684 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `Item` = 276235);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 276235, 76.19, 1, 1, 0, 1, 1, 'Seeping Slime Essence' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 276235, 0, @EVERLAKE_FILE, 'Icy Veins npc=262684 addon_drops: 76.19% of 16 kills' FROM DUAL WHERE @EVERLAKE_LI = 1;

COMMIT;
