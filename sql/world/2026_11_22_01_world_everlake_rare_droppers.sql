-- Three rare Forever creatures of the Riverglades the realm lacks, so the items only they drop can be had: Mad Marrius,
-- Kargra the Blind and Reginald Holmsby.
-- 2026_11_22_01_world_everlake_rare_droppers.sql: written from public data by a script, checked by hand.
--
-- The realm's tracker lists Corrupted Riverglades Pendant (281657), Robes of the Blind Cultist (281666) and Well-Worn
-- Pitchfork (281661) as items no one can get: Wowhead, Icy Veins, NorgannonDB and QuestieDB name these creatures as
-- their droppers, and the realm has no template for them. Built by the rules of
-- 2026_11_21_98_world_everlake_rare_droppers.sql (one spawn per named creature):
--   * template: EG Link's creature details (name, type, classification, class, model and its scale, type flags, health
--     and power multipliers, CreatureDifficultyID); levels from Wowhead's Forever pages.
--   * how it treats players: Wowhead's Forever pages (the tracker's cache), QuestieDB's friendlyToFaction.
--   * faction: the faction of the realm's own NPCs nearby that treat players that way, humanoids first; the nearest of
--     them lends walk and run speed, attack times and variance.
--   * spawn: one, at Wowhead's point (the middle one where it has more), height from the realm's maps and vmaps
--     (ForeverTracker tools/height.py). Mad Marrius and Kargra stand inside models with several floors: the lowest floor
--     is taken. Respawn time, wander distance and movement as file 2026_11_21_98 for the classification. Not checked
--     in game.
--   * loot: every item Wowhead counted at least 10 times, at Wowhead's count over kills.
--
-- Sources: EG Link (Efficient Games, CC BY 4.0); QuestieDB (GPL-3.0); NorgannonDB; Icy Veins; Wowhead's Forever
-- database through the ForeverTracker's page cache (reactions, points, levels and loot counts only); client
-- CreatureDisplayInfo.
-- Guids: creatures 920016004 to 920016006.
-- No template is added where the realm already has one; a creature spawns only while the template is this file's and
-- the realm has no spawn of it. Each added row is recorded in everlake_import_rows.
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

SET @EVERLAKE_FILE := '2026_11_22_01_world_everlake_rare_droppers.sql';

START TRANSACTION;

-- --------------------------------------------------------------------------------------- model sizes (INFERRED)
-- The core does not load a creature whose display has no creature_model_info row (Creature::InitEntry). These
-- displays had none on the realm: the commonest bounding radius and combat reach of the realm's displays on the same
-- client model (CreatureDisplayInfo.ModelID) and scale. Only where the realm still has no row.
-- 139922: INFERRED from same client model 7661, scale 1.0: 321 of the 350 realm displays checked.
SET @EVERLAKE_M139922 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 139922);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 139922, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M139922 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 139922, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from client model 7661: same client model 7661, scale 1.0: 321 of the 350 realm displays checked' FROM DUAL WHERE @EVERLAKE_M139922 = 1;
-- 139606: INFERRED from same client model 7661, scale 1.0: 321 of the 350 realm displays checked.
SET @EVERLAKE_M139606 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 139606);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 139606, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M139606 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 139606, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from client model 7661: same client model 7661, scale 1.0: 321 of the 350 realm displays checked' FROM DUAL WHERE @EVERLAKE_M139606 = 1;
-- 139861: INFERRED from same client model 7200, scale 1.0: as file 2026_11_21_98 (219 of 262 displays).
SET @EVERLAKE_M139861 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 139861);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 139861, 0.236, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M139861 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 139861, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from client model 7200: same client model 7200, scale 1.0: as file 2026_11_21_98 (219 of 262 displays)' FROM DUAL WHERE @EVERLAKE_M139861 = 1;

-- ------------------------------------------------------------------------------------------- spawned creatures

-- Mad Marrius (257034): only dropper of Corrupted Riverglades Pendant (281657); Riverglades 45.4, 56.0, one of Wowhead's 2 points, inside a tower: the lowest floor of the tower (38.13), 2 yards over the ground.
-- no reaction on Wowhead; hostile, as the Twilight camp around it: faction 16 as Twilight Raider (256952), 87 yards; 1 spawn.
SET @EVERLAKE_NOTE := 'eglink creature_details; levels wowhead; faction/speeds from 256952; spawn wowhead; loot wowhead';
SET @EVERLAKE_C257034 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 257034)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 257034);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 257034, 0, 0, 'Mad Marrius', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 2, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C257034 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 257034, 0, 0, 0, 0, 0, 3, 2, 1, 1, 340101, 0, 0, 0, 257034, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C257034 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 257034, 0, 139922, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C257034 = 1;
SET @EVERLAKE_L257034 := @EVERLAKE_C257034 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 257034);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 257034, 41, 41 FROM DUAL
WHERE @EVERLAKE_L257034 = 1;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 257034, 0, 4338, 21.43, 0, 1, 0, 1, 1, 'Mad Marrius: Wowhead 12/56' FROM DUAL WHERE @EVERLAKE_C257034 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 257034 AND `ItemType` = 0 AND `Item` = 4338);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 257034, 0, 5429, 17.86, 0, 1, 0, 1, 1, 'Mad Marrius: Wowhead 10/56' FROM DUAL WHERE @EVERLAKE_C257034 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 257034 AND `ItemType` = 0 AND `Item` = 5429);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 257034, 0, 281657, 23.21, 0, 1, 0, 1, 1, 'Mad Marrius: Wowhead 13/56' FROM DUAL WHERE @EVERLAKE_C257034 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 257034 AND `ItemType` = 0 AND `Item` = 281657);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 257034, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257034 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 257034);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 257034, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257034 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 257034, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257034 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 257034, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L257034 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 257034, 0, 4338, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257034 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 257034, 0, 5429, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257034 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 257034, 0, 281657, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257034 = 1;
SET @EVERLAKE_CS257034 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 257034 AND `file` = '2026_11_22_01_world_everlake_rare_droppers.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 257034 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 257034);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 257034, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 37800, 2, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920016004 AS `guid`, -8277.33 AS `x`, -4093.57 AS `y`, 38.13 AS `z`  -- wowhead
) s
WHERE @EVERLAKE_CS257034 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS257034 = 1 AND c.`id` = 257034 AND c.`guid` = 920016004;

-- Kargra the Blind (256892): only dropper of Robes of the Blind Cultist (281666); Riverglades 26.6, 47.8, Wowhead's one point, inside a tall model: its lowest floor (184.22), 1 yard over the ground.
-- no reaction on Wowhead; hostile, as the Twilight camp nearby: faction 14 as Twilight Champion (256799), 134 yards; 1 spawn.
SET @EVERLAKE_NOTE := 'eglink creature_details; levels wowhead; faction/speeds from 256799; spawn wowhead; loot wowhead';
SET @EVERLAKE_C256892 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 256892)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 256892);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 256892, 0, 0, 'Kargra the Blind', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 4, 0, 2000, 2000, 1, 1, 2, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C256892 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 256892, 0, 0, 0, 0, 0, 3, 1, 1, 1, 339955, 0, 0, 0, 256892, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C256892 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 256892, 0, 139861, 1.35, 1, 0 FROM DUAL WHERE @EVERLAKE_C256892 = 1;
SET @EVERLAKE_L256892 := @EVERLAKE_C256892 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 256892);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 256892, 46, 46 FROM DUAL
WHERE @EVERLAKE_L256892 = 1;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 256892, 0, 4338, 11, 0, 1, 0, 1, 1, 'Kargra the Blind: Wowhead 11/100' FROM DUAL WHERE @EVERLAKE_C256892 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 256892 AND `ItemType` = 0 AND `Item` = 4338);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 256892, 0, 281666, 27, 0, 1, 0, 1, 1, 'Kargra the Blind: Wowhead 27/100' FROM DUAL WHERE @EVERLAKE_C256892 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 256892 AND `ItemType` = 0 AND `Item` = 281666);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 256892, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256892 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 256892);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 256892, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256892 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 256892, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256892 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 256892, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L256892 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 256892, 0, 4338, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256892 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 256892, 0, 281666, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256892 = 1;
SET @EVERLAKE_CS256892 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 256892 AND `file` = '2026_11_22_01_world_everlake_rare_droppers.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 256892 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 256892);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 256892, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 18000, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920016005 AS `guid`, -8012.2 AS `x`, -3181.77 AS `y`, 184.22 AS `z`  -- wowhead
) s
WHERE @EVERLAKE_CS256892 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS256892 = 1 AND c.`id` = 256892 AND c.`guid` = 920016005;

-- Reginald Holmsby (256410): only dropper of Well-Worn Pitchfork (281661); Riverglades 46.2, 82.2, Wowhead's one point, on the floor of a building (25.44).
-- Alliance friendly, Horde hostile (QuestieDB friendlyToFaction A): faction 12 as Meadowsbrook Farmhand (256383), 45 yards; 1 spawn.
SET @EVERLAKE_NOTE := 'eglink creature_details; levels wowhead; faction/speeds from 256383; spawn wowhead; loot wowhead';
SET @EVERLAKE_C256410 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 256410)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 256410);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 256410, 0, 0, 'Reginald Holmsby', NULL, NULL, NULL, NULL, 0, 0, 12, 0, 1, 1.14286, 1, 4, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C256410 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 256410, 0, 0, 0, 0, 0, 1.4, 1.1, 1, 1, 339454, 0, 0, 0, 256410, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C256410 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 256410, 0, 139606, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C256410 = 1;
SET @EVERLAKE_L256410 := @EVERLAKE_C256410 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 256410);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 256410, 38, 38 FROM DUAL
WHERE @EVERLAKE_L256410 = 1;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 256410, 0, 4306, 26.67, 0, 1, 0, 1, 1, 'Reginald Holmsby: Wowhead 16/60' FROM DUAL WHERE @EVERLAKE_C256410 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 256410 AND `ItemType` = 0 AND `Item` = 4306);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 256410, 0, 281661, 18.33, 0, 1, 0, 1, 1, 'Reginald Holmsby: Wowhead 11/60' FROM DUAL WHERE @EVERLAKE_C256410 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 256410 AND `ItemType` = 0 AND `Item` = 281661);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 256410, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256410 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 256410);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 256410, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256410 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 256410, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256410 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 256410, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L256410 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 256410, 0, 4306, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256410 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 256410, 0, 281661, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256410 = 1;
SET @EVERLAKE_CS256410 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 256410 AND `file` = '2026_11_22_01_world_everlake_rare_droppers.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 256410 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 256410);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 256410, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 18000, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920016006 AS `guid`, -9124.47 AS `x`, -4132.37 AS `y`, 25.44 AS `z`  -- wowhead
) s
WHERE @EVERLAKE_CS256410 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS256410 = 1 AND c.`id` = 256410 AND c.`guid` = 920016006;

COMMIT;
