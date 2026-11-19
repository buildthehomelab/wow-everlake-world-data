-- Four WoW Forever quest NPCs that file 930 (2026_11_18_930_world_everlake_rest_npcs.sql) held back for want of a
-- faction: Kirala Fairgrass, The Ravenous, Bullets Bigblast and Drazzit Dripvalve, who take in crafting writs and
-- Dustwallow quests. 2026_11_18_931_world_everlake_lone_quest_npcs.sql: written from public data by the same script as file 930, checked by hand.
--
-- QuestieDB's player traces record each of them as friendly to both sides. Each stands alone: no realm NPC within 200
-- yards has a faction that treats players that way, and DatabaseForever gives only its generated default (14). By the
-- project's decision of 2026-11-18 they get faction 35 (friendly to everyone, no reputation) with the core's default
-- speeds and attack times (walk 1, run 1.14286, 2000 ms). Everything else is made as in file 930:
--   * template: EG Link's creature details where EG Link has the creature (The Ravenous), else DatabaseForever
--     (EmuForever e0b21a2: name, title, type, family, classification, models). Levels from QuestieDB's player traces.
--     Quest giver flag, as QuestieDB names each as a giver or ender; their quests come with the quest import.
--   * spawn: one each, the middle of its QuestieDB points (Forever data and player traces); height from the realm's own
--     maps and vmaps, near a realm spawn (20 yards) its floor, else the terrain. Respawn, wander and movement as the
--     realm's commonest for quest NPCs on the map. Not checked in game.
--   * model sizes: displays the realm had no creature_model_info row for get one, INFERRED as the fork's
--     2026_10_27_17_world_forever_creature_model_info.sql does (the commonest values of the realm's displays on the
--     same client model and scale).
-- Still held back from file 930: Gizzix Grimegurgle (no source records how it treats players) and the six others
-- listed in its pull request.
--
-- Sources: EG Link (Efficient Games, CC BY 4.0) 30c3bb9c; QuestieDB (GPL-3.0) 4f628e83; DatabaseForever (EmuForever)
-- e0b21a2; client FactionTemplate, Faction, CreatureDisplayInfo and CreatureModelData (70790).
-- Guids: creatures 920006046 to 920006049, after file 930's.
-- No template is added where the realm already has one; spawns only while the template is this file's and the realm has
-- no spawn of it. Each added row is recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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

SET @EVERLAKE_FILE := '2026_11_18_931_world_everlake_lone_quest_npcs.sql';

START TRANSACTION;

-- --------------------------------------------------------------------------------------- model sizes (INFERRED)
-- The core does not load a creature whose display has no creature_model_info row (Creature::InitEntry). These
-- displays had none on the realm. As the fork's 2026_10_27_17_world_forever_creature_model_info.sql: the commonest
-- bounding radius and combat reach of the realm's displays on the same client model (CreatureDisplayInfo.ModelID) and
-- scale, else CreatureModelData.CollisionWidth x scale x 0.5727 / 2.4545. Only where the realm still has no row.
-- 143048: INFERRED from same client model 7300, scale 1.0: 330 of 372 displays.
SET @EVERLAKE_M143048 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 143048);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 143048, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M143048 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 143048, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from client model 7300: same client model 7300, scale 1.0: 330 of 372 displays' FROM DUAL WHERE @EVERLAKE_M143048 = 1;
-- 143141: INFERRED from same client model 831, scale 1.0: 254 of 279 displays.
SET @EVERLAKE_M143141 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 143141);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 143141, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M143141 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 143141, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from client model 831: same client model 831, scale 1.0: 254 of 279 displays' FROM DUAL WHERE @EVERLAKE_M143141 = 1;
-- 146435: INFERRED from same client model 831, scale 1.0: 254 of 279 displays.
SET @EVERLAKE_M146435 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 146435);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 146435, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M146435 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 146435, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from client model 831: same client model 831, scale 1.0: 254 of 279 displays' FROM DUAL WHERE @EVERLAKE_M146435 = 1;

-- ------------------------------------------------------------------------------------------- spawned creatures

-- Kirala Fairgrass (262024): ender for 94323.
-- Alliance friendly, Horde friendly: faction 35 by the decision of 2026-11-18 (no realm NPC within 200 yards fits, DatabaseForever has 14); 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction 35 by decision 2026-11-18, core default speeds; spawns questie';
SET @EVERLAKE_C262024 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262024)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262024);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262024, 0, 0, 'Kirala Fairgrass', NULL, 'The Argent Dawn', NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262024 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262024, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262024 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262024, 0, 143048, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262024 = 1;
SET @EVERLAKE_L262024 := @EVERLAKE_C262024 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 262024);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262024, 60, 60 FROM DUAL
WHERE @EVERLAKE_L262024 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262024, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262024 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 262024);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262024, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262024 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262024, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262024 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262024, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L262024 = 1;
SET @EVERLAKE_CS262024 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262024 AND `file` = '2026_11_18_931_world_everlake_lone_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 262024 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 262024);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262024, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920006046 AS `guid`, 1843.03 AS `x`, -2144.84 AS `y`, 67.52 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS262024 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS262024 = 1 AND c.`id` = 262024 AND c.`guid` BETWEEN 920006046 AND 920006046;

-- The Ravenous (262072): ender for 94282, 94294.
-- Alliance friendly, Horde friendly: faction 35 by the decision of 2026-11-18 (no realm NPC within 200 yards fits, DatabaseForever has 14); 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction 35 by decision 2026-11-18, core default speeds; spawns questie';
SET @EVERLAKE_C262072 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262072)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262072);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262072, 0, 0, 'The Ravenous', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262072 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262072, 0, 0, 0, 0, 0, 1, 1, 1, 1, 345342, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262072 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262072, 0, 358, 3, 1, 0 FROM DUAL WHERE @EVERLAKE_C262072 = 1;
SET @EVERLAKE_L262072 := @EVERLAKE_C262072 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 262072);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262072, 40, 40 FROM DUAL
WHERE @EVERLAKE_L262072 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262072, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262072 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 262072);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262072, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262072 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262072, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262072 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262072, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L262072 = 1;
SET @EVERLAKE_CS262072 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262072 AND `file` = '2026_11_18_931_world_everlake_lone_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 262072 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 262072);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262072, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920006047 AS `guid`, -4010.13 AS `x`, -3810.0 AS `y`, 37.73 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS262072 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS262072 = 1 AND c.`id` = 262072 AND c.`guid` BETWEEN 920006047 AND 920006047;

-- Bullets Bigblast (262379): ender for 94288, 94312.
-- Alliance friendly, Horde friendly: faction 35 by the decision of 2026-11-18 (no realm NPC within 200 yards fits, DatabaseForever has 14); 1 spawn(s) from 3 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction 35 by decision 2026-11-18, core default speeds; spawns questie';
SET @EVERLAKE_C262379 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262379)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262379);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262379, 0, 0, 'Bullets Bigblast', NULL, 'Steamwheedle Construction Co.', NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262379 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262379, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262379 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262379, 0, 143141, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262379 = 1;
SET @EVERLAKE_L262379 := @EVERLAKE_C262379 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 262379);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262379, 53, 53 FROM DUAL
WHERE @EVERLAKE_L262379 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262379, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262379 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 262379);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262379, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262379 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262379, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262379 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262379, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L262379 = 1;
SET @EVERLAKE_CS262379 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262379 AND `file` = '2026_11_18_931_world_everlake_lone_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 262379 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 262379);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262379, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920006048 AS `guid`, -10256.97 AS `x`, -3823.95 AS `y`, 18.23 AS `z`  -- questie:generated
) s
WHERE @EVERLAKE_CS262379 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS262379 = 1 AND c.`id` = 262379 AND c.`guid` BETWEEN 920006048 AND 920006048;

-- Drazzit Dripvalve (270723): ender/giver for 98205, 98215.
-- Alliance friendly, Horde friendly: faction 35 by the decision of 2026-11-18 (no realm NPC within 200 yards fits, DatabaseForever has 14); 1 spawn(s) from 2 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction 35 by decision 2026-11-18, core default speeds; spawns questie';
SET @EVERLAKE_C270723 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 270723)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 270723);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 270723, 0, 0, 'Drazzit Dripvalve', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C270723 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 270723, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C270723 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 270723, 0, 146435, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C270723 = 1;
SET @EVERLAKE_L270723 := @EVERLAKE_C270723 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 270723);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 270723, 40, 40 FROM DUAL
WHERE @EVERLAKE_L270723 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 270723, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270723 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 270723);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 270723, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270723 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 270723, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270723 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 270723, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L270723 = 1;
SET @EVERLAKE_CS270723 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 270723 AND `file` = '2026_11_18_931_world_everlake_lone_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 270723 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 270723);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 270723, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920006049 AS `guid`, -4686.33 AS `x`, -3127.5 AS `y`, 45.44 AS `z`  -- questie:generated
) s
WHERE @EVERLAKE_CS270723 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS270723 = 1 AND c.`id` = 270723 AND c.`guid` BETWEEN 920006049 AND 920006049;


COMMIT;
