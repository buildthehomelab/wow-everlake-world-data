-- Four rare Forever creatures the realm lacks, so the items only they drop can be had: Carrodin (Wetlands), and
-- Twilight Forgemaster, Gul'gash and Mosh'gra (Riverglades).
-- 2026_11_21_98_world_everlake_rare_droppers.sql: written from public data by a script, checked by hand.
--
-- The realm's tracker lists Feather-Stitched Moccasins (282642), Twilight Forgehammer (281665), Gul'gash's Greathammer
-- (281648) and Rog'mar Trainee Shoulderpads (281676) as items no one can get:
-- ForeverChanges and Wowhead name these creatures as their only droppers, and the realm has no template for them.
-- Built by the rules of 2026_11_18_930_world_everlake_rest_npcs.sql (one spawn per named creature):
--   * template: EG Link's creature details (name, type, family, classification, class, model, type flags, health and
--     power multipliers, CreatureDifficultyID, movement); levels from EG Link's creature records (Carrodin: QuestieDB's
--     player traces and Forever data, EG Link has no level for it).
--   * how it treats players: Wowhead's Forever pages (the tracker's cache), QuestieDB's friendlyToFaction.
--   * faction: the commonest faction of the realm's own NPCs within 60 yards (else 200) that treats players that way,
--     same creature type first; the nearest of them lends walk and run speed, attack times and variance.
--   * spawn: one, at the middle of Wowhead's points (the point nearest all the others), height from the realm's maps and
--     vmaps (ForeverTracker tools/height.py: the terrain at each). Respawn time, wander distance and movement as the
--     realm's commonest on map 0 for that classification. Not checked in game.
--   * loot: every item Wowhead counted at least 10 times, at Wowhead's count over kills.
--
-- Sources: EG Link (Efficient Games, CC BY 4.0); QuestieDB (GPL-3.0); NorgannonDB; ForeverChanges; Wowhead's Forever
-- database through the ForeverTracker's page cache (reactions, points and loot counts only); client CreatureDisplayInfo.
-- Guids: creatures 920016000 to 920016003.
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

SET @EVERLAKE_FILE := '2026_11_21_98_world_everlake_rare_droppers.sql';

START TRANSACTION;

-- --------------------------------------------------------------------------------------- model sizes (INFERRED)
-- The core does not load a creature whose display has no creature_model_info row (Creature::InitEntry). These
-- displays had none on the realm: the commonest bounding radius and combat reach of the realm's displays on the same
-- client model (CreatureDisplayInfo.ModelID) and scale. Only where the realm still has no row.
-- 140581: INFERRED from same client model 5408, scale 1.0: 666 of 768 displays.
SET @EVERLAKE_M140581 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 140581);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 140581, 0.347, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M140581 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 140581, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from client model 5408: same client model 5408, scale 1.0: 666 of 768 displays' FROM DUAL WHERE @EVERLAKE_M140581 = 1;
-- 140469: INFERRED from same client model 7200, scale 1.0: 219 of 262 displays.
SET @EVERLAKE_M140469 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 140469);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 140469, 0.236, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M140469 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 140469, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from client model 7200: same client model 7200, scale 1.0: 219 of 262 displays' FROM DUAL WHERE @EVERLAKE_M140469 = 1;

-- ------------------------------------------------------------------------------------------- spawned creatures

-- Carrodin (211965): only dropper of Feather-Stitched Moccasins (282642); Wetlands 46.4, 65.0, Wowhead point 46.4, 65.0: the middle point (47.2, 64.8) and four others are in the lake (water 2-29 yards deep).
-- Alliance hostile, Horde hostile (Wowhead): faction 22 as Leech Stalker (1111), 42 yards; 1 spawn.
SET @EVERLAKE_NOTE := 'eglink creature_details; levels questie; faction/speeds from 1111; spawn wowhead; loot wowhead';
SET @EVERLAKE_C211965 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 211965)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 211965);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 211965, 0, 0, 'Carrodin', NULL, NULL, NULL, NULL, 0, 0, 22, 0, 1, 1.14286, 1, 4, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 26, 0, 1, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C211965 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 211965, 0, 0, 0, 0, 0, 1.05, 1, 1, 1, 261318, 134217729, 0, 0, 211965, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C211965 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 211965, 0, 114497, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C211965 = 1;
SET @EVERLAKE_L211965 := @EVERLAKE_C211965 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 211965);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 211965, 25, 25 FROM DUAL
WHERE @EVERLAKE_L211965 = 1;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 211965, 0, 5114, 29.73, 0, 1, 0, 1, 1, 'Carrodin: Wowhead 22/74' FROM DUAL WHERE @EVERLAKE_C211965 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 211965 AND `ItemType` = 0 AND `Item` = 5114);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 211965, 0, 5116, 31.08, 0, 1, 0, 1, 1, 'Carrodin: Wowhead 23/74' FROM DUAL WHERE @EVERLAKE_C211965 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 211965 AND `ItemType` = 0 AND `Item` = 5116);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 211965, 0, 17056, 25.68, 0, 1, 0, 1, 1, 'Carrodin: Wowhead 19/74' FROM DUAL WHERE @EVERLAKE_C211965 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 211965 AND `ItemType` = 0 AND `Item` = 17056);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 211965, 0, 282642, 13.51, 0, 1, 0, 1, 1, 'Carrodin: Wowhead 10/74' FROM DUAL WHERE @EVERLAKE_C211965 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 211965 AND `ItemType` = 0 AND `Item` = 282642);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 211965, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C211965 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 211965);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 211965, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C211965 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 211965, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C211965 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 211965, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L211965 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 211965, 0, 5114, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C211965 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 211965, 0, 5116, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C211965 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 211965, 0, 17056, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C211965 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 211965, 0, 282642, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C211965 = 1;
SET @EVERLAKE_CS211965 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 211965 AND `file` = '2026_11_21_98_world_everlake_rare_droppers.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 211965 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 211965);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 211965, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 18000, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920016000 AS `guid`, -3939.48 AS `x`, -2308.42 AS `y`, 164.13 AS `z`  -- wowhead
) s
WHERE @EVERLAKE_CS211965 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS211965 = 1 AND c.`id` = 211965 AND c.`guid` = 920016000;

-- Twilight Forgemaster (258032): only dropper of Twilight Forgehammer (281665); Riverglades 28.9, 45.6, the middle of Wowhead's 5 points; EG Link saw it 53 yards away.
-- Alliance hostile, Horde hostile (Wowhead): faction 14 as Twilight Champion (256799), 63 yards; 1 spawn.
SET @EVERLAKE_NOTE := 'eglink creature_details; levels eglink; faction/speeds from 256799; spawn wowhead; loot wowhead';
SET @EVERLAKE_C258032 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 258032)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 258032);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 258032, 0, 0, 'Twilight Forgemaster', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 2, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C258032 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 258032, 0, 0, 0, 0, 0, 3, 1, 1, 1, 341126, 0, 0, 0, 258032, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C258032 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 258032, 0, 140581, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C258032 = 1;
SET @EVERLAKE_L258032 := @EVERLAKE_C258032 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 258032);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 258032, 46, 46 FROM DUAL
WHERE @EVERLAKE_L258032 = 1;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 258032, 0, 3671, 9.35, 0, 1, 0, 1, 1, 'Twilight Forgemaster: Wowhead 10/107' FROM DUAL WHERE @EVERLAKE_C258032 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 258032 AND `ItemType` = 0 AND `Item` = 3671);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 258032, 0, 4338, 14.02, 0, 1, 0, 1, 1, 'Twilight Forgemaster: Wowhead 15/107' FROM DUAL WHERE @EVERLAKE_C258032 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 258032 AND `ItemType` = 0 AND `Item` = 4338);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 258032, 0, 5429, 11.21, 0, 1, 0, 1, 1, 'Twilight Forgemaster: Wowhead 12/107' FROM DUAL WHERE @EVERLAKE_C258032 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 258032 AND `ItemType` = 0 AND `Item` = 5429);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 258032, 0, 5431, 12.15, 0, 1, 0, 1, 1, 'Twilight Forgemaster: Wowhead 13/107' FROM DUAL WHERE @EVERLAKE_C258032 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 258032 AND `ItemType` = 0 AND `Item` = 5431);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 258032, 0, 6438, 11.21, 0, 1, 0, 1, 1, 'Twilight Forgemaster: Wowhead 12/107' FROM DUAL WHERE @EVERLAKE_C258032 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 258032 AND `ItemType` = 0 AND `Item` = 6438);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 258032, 0, 281665, 28.04, 0, 1, 0, 1, 1, 'Twilight Forgemaster: Wowhead 30/107' FROM DUAL WHERE @EVERLAKE_C258032 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 258032 AND `ItemType` = 0 AND `Item` = 281665);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 258032, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C258032 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 258032);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 258032, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C258032 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 258032, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C258032 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 258032, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L258032 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 258032, 0, 3671, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C258032 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 258032, 0, 4338, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C258032 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 258032, 0, 5429, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C258032 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 258032, 0, 5431, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C258032 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 258032, 0, 6438, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C258032 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 258032, 0, 281665, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C258032 = 1;
SET @EVERLAKE_CS258032 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 258032 AND `file` = '2026_11_21_98_world_everlake_rare_droppers.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 258032 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 258032);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 258032, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 37800, 2, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920016001 AS `guid`, -7941.07 AS `x`, -3293.32 AS `y`, 172.19 AS `z`  -- wowhead
) s
WHERE @EVERLAKE_CS258032 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS258032 = 1 AND c.`id` = 258032 AND c.`guid` = 920016001;

-- Gul'gash (259758): only dropper of Gul'gash's Greathammer (281648); Riverglades 84.3, 28.8, the middle of Wowhead's 13 points.
-- Alliance hostile, Horde hostile (Wowhead): faction 14 as Eastsea Bombardier (257916), 138 yards; 1 spawn.
SET @EVERLAKE_NOTE := 'eglink creature_details; levels eglink; faction/speeds from 257916; spawn wowhead; loot wowhead';
SET @EVERLAKE_C259758 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 259758)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259758);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 259758, 0, 0, 'Gul''gash', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 2, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 5, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C259758 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 259758, 0, 0, 0, 0, 0, 5, 1, 1, 1, 342947, 0, 0, 0, 259758, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C259758 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 259758, 0, 12812, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C259758 = 1;
SET @EVERLAKE_L259758 := @EVERLAKE_C259758 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 259758);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 259758, 49, 49 FROM DUAL
WHERE @EVERLAKE_L259758 = 1;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 259758, 0, 4338, 11.7, 0, 1, 0, 1, 1, 'Gul''gash: Wowhead 11/94' FROM DUAL WHERE @EVERLAKE_C259758 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259758 AND `ItemType` = 0 AND `Item` = 4338);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 259758, 0, 7973, 15.96, 0, 1, 0, 1, 1, 'Gul''gash: Wowhead 15/94' FROM DUAL WHERE @EVERLAKE_C259758 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259758 AND `ItemType` = 0 AND `Item` = 7973);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 259758, 0, 281648, 30.85, 0, 1, 0, 1, 1, 'Gul''gash: Wowhead 29/94' FROM DUAL WHERE @EVERLAKE_C259758 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259758 AND `ItemType` = 0 AND `Item` = 281648);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 259758, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259758 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 259758);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 259758, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259758 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 259758, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259758 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 259758, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L259758 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259758, 0, 4338, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259758 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259758, 0, 7973, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259758 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259758, 0, 281648, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259758 = 1;
SET @EVERLAKE_CS259758 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259758 AND `file` = '2026_11_21_98_world_everlake_rare_droppers.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 259758 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 259758);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 259758, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 37800, 2, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920016002 AS `guid`, -7397.87 AS `x`, -5980.22 AS `y`, 2.7 AS `z`  -- wowhead
) s
WHERE @EVERLAKE_CS259758 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS259758 = 1 AND c.`id` = 259758 AND c.`guid` = 920016002;

-- Mosh'gra (259801): only dropper of Rog'mar Trainee Shoulderpads (281676); Riverglades 62.8, 36.0, the middle of Wowhead's 10 points.
-- Alliance hostile, Horde friendly (Wowhead, QuestieDB friendlyToFaction H): faction 29 as Rog'mar Trainee (256749), 44 yards; 1 spawn.
SET @EVERLAKE_NOTE := 'eglink creature_details; levels eglink; faction/speeds from 256749; spawn wowhead; loot wowhead';
SET @EVERLAKE_C259801 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 259801)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259801);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 259801, 0, 0, 'Mosh''gra', NULL, NULL, NULL, NULL, 0, 0, 29, 0, 1, 1.14286, 1, 4, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C259801 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 259801, 0, 0, 0, 0, 0, 1.5, 1, 1, 1, 342990, 0, 0, 0, 259801, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C259801 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 259801, 0, 140469, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C259801 = 1;
SET @EVERLAKE_L259801 := @EVERLAKE_C259801 = 1 AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 259801);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 259801, 41, 41 FROM DUAL
WHERE @EVERLAKE_L259801 = 1;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 259801, 0, 4338, 31.82, 0, 1, 0, 1, 1, 'Mosh''gra: Wowhead 14/44' FROM DUAL WHERE @EVERLAKE_C259801 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259801 AND `ItemType` = 0 AND `Item` = 4338);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 259801, 0, 281676, 31.82, 0, 1, 0, 1, 1, 'Mosh''gra: Wowhead 14/44' FROM DUAL WHERE @EVERLAKE_C259801 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259801 AND `ItemType` = 0 AND `Item` = 281676);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 259801, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259801 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 259801);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 259801, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259801 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 259801, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259801 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 259801, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L259801 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259801, 0, 4338, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259801 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259801, 0, 281676, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259801 = 1;
SET @EVERLAKE_CS259801 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259801 AND `file` = '2026_11_21_98_world_everlake_rare_droppers.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 259801 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 259801);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 259801, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 18000, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920016003 AS `guid`, -7630.67 AS `x`, -4937.47 AS `y`, 19.77 AS `z`  -- wowhead
) s
WHERE @EVERLAKE_CS259801 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS259801 = 1 AND c.`id` = 259801 AND c.`guid` = 920016003;

COMMIT;
