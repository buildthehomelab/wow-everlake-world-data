-- New WoW Forever creatures out in the world whose drops no one on the realm could get.
-- 2026_11_18_927_world_everlake_outdoor_drop_sources.sql: written from public data by a script, checked by hand.
--
-- The realm's tracker counts items that drop only from creatures the realm has no template for. This adds 12 of those
-- creatures (89 spawns) whose template the live client was sent (EG Link) and whose place is known, with the drops
-- Wowhead measured on them. Same method as 2026_11_18_926_world_everlake_quest_drop_sources.sql, with these changes:
--   * template: EG Link's creature details (name, title, type, family, classification, class, models, type flags, health
--     and power multipliers, CreatureDifficultyID, movement); levels from EG Link's creature records or combat log, else
--     QuestieDB's player traces; quest items (creature_questitem) as the client was told.
--   * faction: no public source records it. The commonest faction of the realm's own NPCs spawned within 60 yards
--     (else 200, 400, 600: said per creature) that treats players as they saw this creature do (EG Link's recorded
--     reactions, else Wowhead's: hostile, neutral or friendly per side), same creature type first. The nearest of them
--     lends walk and run speed, attack times and variance. Each creature's note names it.
--   * spawns: a named creature stands at the middle of Wowhead's spawn points (QuestieDB generated) and forever-db's where
--     there are any, else of QuestieDB's player traces (EG Link's combat log for Tunk). A kind of mob with 10 or more
--     such points takes them alone; with fewer, players' traces fill the gaps: one spawn per cell of the realm's own
--     spacing of mobs around those points (the median distance of each nearby creature's spawns to its nearest twin),
--     none within 10 yards of another spawn of this file. Respawn time, wander distance and movement as the realm's
--     commonest for that classification on the map. Heights from the realm's own maps and vmaps (ForeverTracker
--     tools/height.py): near a realm spawn (40 yards) its floor; else the terrain, a building's floor up to 3 yards above
--     it, or, where the terrain is under water, the top floor of the model above the water (Admiral Lamora, on a ship).
--     Not checked in game.
--   * loot: the chance is Wowhead's count over its kills (count/outof, in each row's comment), not a flat rate.
--     QuestRequired only for an item the client lists as the creature's quest item and that starts no quest; an item
--     that starts a quest drops for everyone (the core hides it from players who already took that quest).
--     No other loot and no money yet: a later drops import adds them once the templates are in.
--   Several of these items serve quests the realm does not have yet (named per creature): the drop is in place for when
--   they come.
--
-- Sources: EG Link (Efficient Games, CC BY 4.0) 30c3bb9c (data to 2026-11-18); Wowhead's WoW Forever database (drop
-- counts and reactions, read from the ForeverTracker's page cache; only ids and counts are taken); QuestieDB (GPL-3.0)
-- 4f628e83; forever-db from Polestar (GPL-3.0) 74eda09e, spawn points; client FactionTemplate (70790).
-- Guids: creatures 920002000 to 920002088: a block of their own after file 926's (920001000 to 920001461).
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

SET @EVERLAKE_FILE := '2026_11_18_927_world_everlake_outdoor_drop_sources.sql';

START TRANSACTION;

-- Dro'zem the Blasphemous (214456): 277213 34.21%; for no quest.
-- Faction 40 as Blackrock Renegade (437); 1 spawn(s) from 177 points.
SET @EVERLAKE_NOTE := 'eglink@70888 creature_details; levels questie:trace; faction/speeds from 437, reactions wowhead; spawns questie; drops wowhead';
SET @EVERLAKE_C214456 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 214456)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 214456);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 214456, 0, 0, 'Dro''zem the Blasphemous', NULL, NULL, NULL, NULL, 0, 0, 40, 0, 1, 1.14286, 1, 2, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C214456 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 214456, 0, 0, 0, 0, 0, 3, 2, 1, 1, 263898, 134217728, 0, 0, 214456, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C214456 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 214456, 0, 116033, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C214456 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 214456, 23, 23 FROM DUAL
WHERE @EVERLAKE_C214456 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 214456);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 214456, 0, 277213, 34.21, 0, 1, 0, 1, 1, 'Dro''zem the Blasphemous: wowhead 39/114' FROM DUAL WHERE @EVERLAKE_C214456 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 214456 AND `ItemType` = 0 AND `Item` = 277213);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 214456, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C214456 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 214456);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 214456, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C214456 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 214456, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C214456 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 214456, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C214456 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 214456, 0, 277213, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C214456 = 1;
SET @EVERLAKE_CS214456 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 214456 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 214456 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 214456);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 214456, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 37800, 2, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002000 AS `guid`, -9584.49 AS `x`, -3211.69 AS `y`, 49.19 AS `z`  -- questie:trace, z: realm spawn 12 yd away
) s
WHERE @EVERLAKE_CS214456 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS214456 = 1 AND c.`id` = 214456 AND c.`guid` BETWEEN 920002000 AND 920002000;

-- Ohk'zi (222233): 254692 60.66%; for 92858 (not on the realm yet).
-- Faction 45 as Gordunni Ogre (5229); 1 spawn(s) from 5 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 5229, reactions wowhead; spawns questie; drops wowhead';
SET @EVERLAKE_C222233 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 222233)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 222233);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 222233, 0, 0, 'Ohk''zi', NULL, NULL, NULL, NULL, 0, 0, 45, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C222233 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 222233, 0, 0, 0, 0, 0, 3, 1, 1, 1, 272055, 134217728, 0, 0, 222233, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C222233 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 222233, 0, 11558, 1.125, 1, 0 FROM DUAL WHERE @EVERLAKE_C222233 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 222233, 43, 43 FROM DUAL
WHERE @EVERLAKE_C222233 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 222233);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 222233, 0, 0, 254692, 0 FROM DUAL WHERE @EVERLAKE_C222233 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 222233 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 222233, 0, 254692, 60.66, 1, 1, 0, 1, 1, 'Ohk''zi: wowhead 37/61' FROM DUAL WHERE @EVERLAKE_C222233 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 222233 AND `ItemType` = 0 AND `Item` = 254692);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 222233, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222233 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 222233);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 222233, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222233 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 222233, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222233 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 222233, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222233 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 222233, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222233 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 222233, 0, 254692, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222233 = 1;
SET @EVERLAKE_CS222233 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 222233 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 222233 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 222233);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 222233, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 600, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002001 AS `guid`, -3525.0 AS `x`, 229.17 AS `y`, 150.7 AS `z`  -- questie:generated, z: realm spawn 2 yd away
) s
WHERE @EVERLAKE_CS222233 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS222233 = 1 AND c.`id` = 222233 AND c.`guid` BETWEEN 920002001 AND 920002001;

-- Executioner Morg (256891): 269351 100.0%; for 95433 (not on the realm yet).
-- Faction 14 as Twilight Fanatic (256795) (200 yd); 1 spawn(s) from 59 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 256795 (200 yd), reactions wowhead; spawns questie; drops wowhead';
SET @EVERLAKE_C256891 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 256891)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 256891);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 256891, 0, 0, 'Executioner Morg', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C256891 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 256891, 0, 0, 0, 0, 0, 3.5, 1.15, 1, 1, 339954, 0, 0, 0, 256891, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C256891 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 256891, 0, 145171, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C256891 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 256891, 46, 46 FROM DUAL
WHERE @EVERLAKE_C256891 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 256891);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 256891, 0, 0, 269351, 0 FROM DUAL WHERE @EVERLAKE_C256891 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 256891 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 256891, 0, 269351, 100, 1, 1, 0, 1, 1, 'Executioner Morg: wowhead 216/216' FROM DUAL WHERE @EVERLAKE_C256891 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 256891 AND `ItemType` = 0 AND `Item` = 269351);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 256891, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256891 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 256891);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 256891, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256891 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 256891, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256891 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 256891, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256891 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 256891, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256891 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 256891, 0, 269351, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256891 = 1;
SET @EVERLAKE_CS256891 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 256891 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 256891 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 256891);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 256891, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 720, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002002 AS `guid`, -7759.68 AS `x`, -3313.2 AS `y`, 179.14 AS `z`  -- questie:trace, z: terrain
) s
WHERE @EVERLAKE_CS256891 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS256891 = 1 AND c.`id` = 256891 AND c.`guid` BETWEEN 920002002 AND 920002002;

-- Admiral Lamora (257861): 268520 92.46%; for no quest.
-- Faction 14 as Eastsea Musketeer (257910) (600 yd); 1 spawn(s) from 36 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 257910 (600 yd), reactions wowhead; spawns questie; drops wowhead';
SET @EVERLAKE_C257861 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 257861)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 257861);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 257861, 0, 0, 'Admiral Lamora', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C257861 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 257861, 0, 0, 0, 0, 0, 1.5, 1, 1, 1, 340952, 134217728, 0, 0, 257861, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C257861 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 257861, 0, 140431, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C257861 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 257861, 45, 45 FROM DUAL
WHERE @EVERLAKE_C257861 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 257861);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 257861, 0, 268520, 92.46, 0, 1, 0, 1, 1, 'Admiral Lamora: wowhead 503/544' FROM DUAL WHERE @EVERLAKE_C257861 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 257861 AND `ItemType` = 0 AND `Item` = 268520);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 257861, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257861 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 257861);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 257861, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257861 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 257861, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257861 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 257861, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257861 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 257861, 0, 268520, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257861 = 1;
SET @EVERLAKE_CS257861 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 257861 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 257861 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 257861);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 257861, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002003 AS `guid`, -7423.73 AS `x`, -6276.07 AS `y`, 13.09 AS `z`  -- questie:generated, z: top of the model above the water
) s
WHERE @EVERLAKE_CS257861 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS257861 = 1 AND c.`id` = 257861 AND c.`guid` BETWEEN 920002003 AND 920002003;

-- Scaldaron (263141): 271612 27.86%, 271613 37.86%; for 95935 (not on the realm yet), 95936 (not on the realm yet).
-- Faction 38 as Cinderscale Warrior (262477); 1 spawn(s) from 20 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 262477, reactions eglink/wowhead; spawns questie; drops wowhead';
SET @EVERLAKE_C263141 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 263141)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 263141);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 263141, 0, 0, 'Scaldaron', NULL, NULL, NULL, NULL, 0, 0, 38, 0, 1, 1.14286, 1, 2, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 2, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C263141 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 263141, 0, 0, 0, 0, 0, 4, 1, 1, 1, 346447, 134217728, 0, 0, 263141, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C263141 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 263141, 0, 9585, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C263141 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 263141, 43, 43 FROM DUAL
WHERE @EVERLAKE_C263141 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 263141);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 263141, 0, 271612, 27.86, 0, 1, 0, 1, 1, 'Scaldaron: wowhead 39/140' FROM DUAL WHERE @EVERLAKE_C263141 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 263141 AND `ItemType` = 0 AND `Item` = 271612)
UNION ALL SELECT 263141, 0, 271613, 37.86, 0, 1, 0, 1, 1, 'Scaldaron: wowhead 53/140' FROM DUAL WHERE @EVERLAKE_C263141 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 263141 AND `ItemType` = 0 AND `Item` = 271613);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 263141, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263141 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 263141);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 263141, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263141 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 263141, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263141 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 263141, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263141 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 263141, 0, 271612, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263141 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 263141, 0, 271613, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263141 = 1;
SET @EVERLAKE_CS263141 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 263141 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 263141 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 263141);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 263141, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 37800, 2, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002004 AS `guid`, -8823.77 AS `x`, -3404.87 AS `y`, 174.21 AS `z`  -- questie:generated, z: realm spawn 32 yd away
) s
WHERE @EVERLAKE_CS263141 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS263141 = 1 AND c.`id` = 263141 AND c.`guid` BETWEEN 920002004 AND 920002004;

-- Ombassa (263315): 281052 99.78%; for 95986, 96105.
-- Faction 16 as Freshwater Crocolisk (259046) (400 yd); 1 spawn(s) from 94 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 259046 (400 yd), reactions eglink/wowhead; spawns questie; drops wowhead';
SET @EVERLAKE_C263315 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 263315)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 263315);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 263315, 0, 0, 'Ombassa', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 2, 0, 1, 0, '', 0, 1, 0, 1694, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C263315 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 263315, 0, 0, 0, 0, 0, 3.2, 1, 1, 1, 346622, 1, 0, 0, 263315, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C263315 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 263315, 0, 4424, 1.25, 1, 0 FROM DUAL WHERE @EVERLAKE_C263315 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 263315, 41, 41 FROM DUAL
WHERE @EVERLAKE_C263315 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 263315);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 263315, 0, 0, 281052, 0 FROM DUAL WHERE @EVERLAKE_C263315 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 263315 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 263315, 0, 281052, 99.78, 1, 1, 0, 1, 1, 'Ombassa: wowhead 458/459' FROM DUAL WHERE @EVERLAKE_C263315 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 263315 AND `ItemType` = 0 AND `Item` = 281052);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 263315, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263315 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 263315);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 263315, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263315 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 263315, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263315 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 263315, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263315 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 263315, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263315 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 263315, 0, 281052, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263315 = 1;
SET @EVERLAKE_CS263315 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 263315 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 263315 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 263315);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 263315, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 720, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002005 AS `guid`, -8206.2 AS `x`, -4782.27 AS `y`, 46.57 AS `z`  -- questie:generated, z: terrain
) s
WHERE @EVERLAKE_CS263315 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS263315 = 1 AND c.`id` = 263315 AND c.`guid` BETWEEN 920002005 AND 920002005;

-- Tunk (259256): 267137 52.1%, 267138 47.69%; for no quest.
-- Faction 16 as Krol'dok Brute (8110000) (400 yd); 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938 combat log; faction/speeds from 8110000 (400 yd), reactions none; spawns eglink; drops wowhead';
SET @EVERLAKE_C259256 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 259256)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259256);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 259256, 0, 0, 'Tunk', NULL, 'Blacksmith', NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C259256 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 259256, 0, 0, 0, 0, 0, 5, 1, 1, 1, 342436, 0, 0, 0, 259256, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C259256 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 259256, 0, 144671, 1.5, 1, 0 FROM DUAL WHERE @EVERLAKE_C259256 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 259256, 41, 41 FROM DUAL
WHERE @EVERLAKE_C259256 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 259256);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 259256, 0, 267137, 52.1, 0, 1, 0, 1, 1, 'Tunk: wowhead 248/476' FROM DUAL WHERE @EVERLAKE_C259256 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259256 AND `ItemType` = 0 AND `Item` = 267137)
UNION ALL SELECT 259256, 0, 267138, 47.69, 0, 1, 0, 1, 1, 'Tunk: wowhead 227/476' FROM DUAL WHERE @EVERLAKE_C259256 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259256 AND `ItemType` = 0 AND `Item` = 267138);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 259256, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259256 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 259256);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 259256, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259256 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 259256, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259256 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 259256, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259256 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259256, 0, 267137, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259256 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259256, 0, 267138, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259256 = 1;
SET @EVERLAKE_CS259256 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259256 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 259256 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 259256);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 259256, 3039, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 7200, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002006 AS `guid`, -7207.34 AS `x`, -4581.29 AS `y`, 180.73 AS `z`  -- eglink:combatlog, z: terrain
) s
WHERE @EVERLAKE_CS259256 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS259256 = 1 AND c.`id` = 259256 AND c.`guid` BETWEEN 920002006 AND 920002006;

-- Corpsefeeder (253394): 259893 93.44%; for 93574 (not on the realm yet).
-- Faction 133 as Magram Necrokhan (253274); 25 spawn(s) from 445 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 253274, reactions wowhead; spawns polestar/questie; drops wowhead';
SET @EVERLAKE_C253394 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 253394)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253394);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 253394, 0, 0, 'Corpsefeeder', NULL, NULL, NULL, NULL, 0, 0, 133, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C253394 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 253394, 0, 0, 0, 0, 0, 6, 1, 1, 1, 334279, 0, 0, 0, 253394, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C253394 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 253394, 0, 137848, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C253394 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 253394, 45, 45 FROM DUAL
WHERE @EVERLAKE_C253394 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 253394);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 253394, 0, 259893, 93.44, 0, 1, 0, 1, 1, 'Corpsefeeder: wowhead 57/61' FROM DUAL WHERE @EVERLAKE_C253394 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 253394 AND `ItemType` = 0 AND `Item` = 259893);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 253394, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253394 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 253394);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 253394, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253394 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 253394, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253394 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 253394, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253394 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 253394, 0, 259893, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253394 = 1;
SET @EVERLAKE_CS253394 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253394 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 253394 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 253394);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 253394, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 600, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002007 AS `guid`, -2362 AS `x`, 1061.5 AS `y`, 120.5 AS `z`  -- polestar, z: terrain
  UNION ALL SELECT 920002008, -2638.0, 831.9, 76.69  -- questie:generated, z: realm spawn 13 yd away
  UNION ALL SELECT 920002009, -2629.8, 924.15, 89.99  -- questie:generated, z: terrain
  UNION ALL SELECT 920002010, -2461.7, 770.4, 119.82  -- questie:generated, z: terrain
  UNION ALL SELECT 920002011, -2454.87, 700.7, 136.13  -- questie:generated, z: terrain
  UNION ALL SELECT 920002012, -2439.83, 672.0, 136.92  -- questie:generated, z: terrain
  UNION ALL SELECT 920002013, -2438.47, 733.5, 129.23  -- questie:generated, z: terrain
  UNION ALL SELECT 920002014, -2409.77, 1079.95, 123.75  -- questie:generated, z: realm spawn 29 yd away
  UNION ALL SELECT 920002015, -2407.03, 631.0, 141.11  -- questie:generated, z: terrain
  UNION ALL SELECT 920002016, -2338.7, 1096.35, 107.79  -- questie:generated, z: realm spawn 11 yd away
  UNION ALL SELECT 920002017, -2323.67, 1067.65, 108.38  -- questie:generated, z: terrain
  UNION ALL SELECT 920002018, -2323.67, 1161.95, 95.54  -- questie:generated, z: realm spawn 19 yd away
  UNION ALL SELECT 920002019, -2323.67, 1211.15, 89.6  -- questie:generated, z: realm spawn 18 yd away
  UNION ALL SELECT 920002020, -2275.83, 801.15, 139.08  -- questie:generated, z: realm spawn 14 yd away
  UNION ALL SELECT 920002021, -2252.6, 1008.2, 101.47  -- questie:generated, z: realm spawn 26 yd away
  UNION ALL SELECT 920002022, -2243.03, 823.7, 126.66  -- questie:generated, z: realm spawn 30 yd away
  UNION ALL SELECT 920002023, -2221.17, 895.45, 110.62  -- questie:generated, z: terrain
  UNION ALL SELECT 920002024, -2219.8, 715.05, 146.53  -- questie:generated, z: terrain
  UNION ALL SELECT 920002025, -2215.7, 672.0, 145.88  -- questie:generated, z: terrain
  UNION ALL SELECT 920002026, -2211.6, 542.85, 167.48  -- questie:generated, z: terrain
  UNION ALL SELECT 920002027, -2211.6, 930.3, 103.25  -- questie:generated, z: terrain
  UNION ALL SELECT 920002028, -2200.67, 856.5, 123.82  -- questie:generated, z: terrain
  UNION ALL SELECT 920002029, -2177.43, 721.2, 142.45  -- questie:generated, z: terrain
  UNION ALL SELECT 920002030, -2140.53, 788.85, 149.49  -- questie:generated, z: terrain
  UNION ALL SELECT 920002031, -2095.43, 811.4, 155.01  -- questie:generated, z: terrain
) s
WHERE @EVERLAKE_CS253394 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS253394 = 1 AND c.`id` = 253394 AND c.`guid` BETWEEN 920002007 AND 920002031;

-- Rowdy Rose (254566): 260245 1.82%; for 93606 (not on the realm yet).
-- Faction 133 as Magram Marauder (262838); 22 spawn(s) from 263 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 262838, reactions wowhead; spawns questie; drops wowhead';
SET @EVERLAKE_C254566 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 254566)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254566);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 254566, 0, 0, 'Rowdy Rose', NULL, NULL, NULL, NULL, 0, 0, 133, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C254566 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 254566, 0, 0, 0, 0, 0, 1, 1, 1, 1, 335472, 0, 0, 0, 254566, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C254566 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 254566, 0, 138254, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C254566 = 1
UNION ALL SELECT 254566, 1, 138256, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C254566 = 1
UNION ALL SELECT 254566, 2, 138258, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C254566 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 254566, 41, 42 FROM DUAL
WHERE @EVERLAKE_C254566 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 254566);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 254566, 0, 0, 260245, 0 FROM DUAL WHERE @EVERLAKE_C254566 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 254566 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 254566, 0, 260245, 1.82, 1, 1, 0, 1, 1, 'Rowdy Rose: wowhead 7/384' FROM DUAL WHERE @EVERLAKE_C254566 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 254566 AND `ItemType` = 0 AND `Item` = 260245);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 254566, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254566 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 254566);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 254566, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254566 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 254566, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254566 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 254566, 1, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254566 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 254566, 2, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254566 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 254566, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254566 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 254566, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254566 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 254566, 0, 260245, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254566 = 1;
SET @EVERLAKE_CS254566 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254566 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 254566 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 254566);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 254566, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002032 AS `guid`, -3031.05 AS `x`, 590.62 AS `y`, 152.17 AS `z`  -- questie:trace, z: terrain
  UNION ALL SELECT 920002033, -3028.32, 718.74, 142.82  -- questie:trace, z: terrain
  UNION ALL SELECT 920002034, -3027.5, 825.13, 108.51  -- questie:trace, z: terrain
  UNION ALL SELECT 920002035, -3023.13, 535.47, 167.05  -- questie:trace, z: terrain
  UNION ALL SELECT 920002036, -2996.75, 782.7, 114.51  -- questie:trace, z: terrain
  UNION ALL SELECT 920002037, -2991.01, 623.83, 146.03  -- questie:trace, z: terrain
  UNION ALL SELECT 920002038, -2990.87, 680.61, 129.77  -- questie:trace, z: terrain
  UNION ALL SELECT 920002039, -2972.83, 563.55, 152.22  -- questie:trace, z: terrain
  UNION ALL SELECT 920002040, -2960.67, 729.81, 116.19  -- questie:trace, z: terrain
  UNION ALL SELECT 920002041, -2948.64, 802.58, 104.4  -- questie:trace, z: terrain
  UNION ALL SELECT 920002042, -2938.94, 638.17, 124.06  -- questie:trace, z: terrain
  UNION ALL SELECT 920002043, -2920.22, 575.24, 140.01  -- questie:trace, z: terrain
  UNION ALL SELECT 920002044, -2918.99, 690.24, 113.3  -- questie:trace, z: terrain
  UNION ALL SELECT 920002045, -2910.51, 755.85, 104.21  -- questie:trace, z: terrain
  UNION ALL SELECT 920002046, -2899.58, 855.68, 104.15  -- questie:trace, z: terrain
  UNION ALL SELECT 920002047, -2885.37, 615.83, 116.29  -- questie:trace, z: terrain
  UNION ALL SELECT 920002048, -2883.59, 530.55, 123.16  -- questie:trace, z: terrain
  UNION ALL SELECT 920002049, -2872.11, 793.36, 95.47  -- questie:trace, z: realm spawn 32 yd away
  UNION ALL SELECT 920002050, -2866.92, 710.34, 114.77  -- questie:trace, z: realm spawn 18 yd away
  UNION ALL SELECT 920002051, -2848.33, 657.45, 104.3  -- questie:trace, z: realm spawn 40 yd away
  UNION ALL SELECT 920002052, -2816.62, 606.81, 120.48  -- questie:trace, z: terrain
  UNION ALL SELECT 920002053, -2793.12, 656.62, 92.74  -- questie:trace, z: terrain
) s
WHERE @EVERLAKE_CS254566 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS254566 = 1 AND c.`id` = 254566 AND c.`guid` BETWEEN 920002032 AND 920002053;

-- Terrible Tulip (254567): 260245 1.57%; for 93606 (not on the realm yet).
-- Faction 133 as Magram Marauder (262838) (200 yd); 18 spawn(s) from 217 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 262838 (200 yd), reactions wowhead; spawns questie; drops wowhead';
SET @EVERLAKE_C254567 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 254567)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254567);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 254567, 0, 0, 'Terrible Tulip', NULL, NULL, NULL, NULL, 0, 0, 133, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C254567 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 254567, 0, 0, 0, 0, 0, 1, 1, 1, 1, 335473, 0, 0, 0, 254567, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C254567 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 254567, 0, 138260, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C254567 = 1
UNION ALL SELECT 254567, 1, 138261, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C254567 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 254567, 41, 42 FROM DUAL
WHERE @EVERLAKE_C254567 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 254567);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 254567, 0, 0, 260245, 0 FROM DUAL WHERE @EVERLAKE_C254567 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 254567 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 254567, 0, 260245, 1.57, 1, 1, 0, 1, 1, 'Terrible Tulip: wowhead 5/319' FROM DUAL WHERE @EVERLAKE_C254567 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 254567 AND `ItemType` = 0 AND `Item` = 260245);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 254567, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254567 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 254567);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 254567, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254567 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 254567, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254567 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 254567, 1, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254567 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 254567, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254567 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 254567, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254567 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 254567, 0, 260245, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254567 = 1;
SET @EVERLAKE_CS254567 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254567 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 254567 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 254567);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 254567, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002054 AS `guid`, -3009.46 AS `x`, 733.7 AS `y`, 131.97 AS `z`  -- questie:trace, z: terrain
  UNION ALL SELECT 920002055, -2990.46, 644.33, 137.01  -- questie:trace, z: terrain
  UNION ALL SELECT 920002056, -2976.39, 554.12, 151.8  -- questie:trace, z: terrain
  UNION ALL SELECT 920002057, -2967.37, 701.52, 115.71  -- questie:trace, z: terrain
  UNION ALL SELECT 920002058, -2961.08, 818.78, 108.35  -- questie:trace, z: terrain
  UNION ALL SELECT 920002059, -2957.12, 757.49, 114.28  -- questie:trace, z: terrain
  UNION ALL SELECT 920002060, -2955.2, 601.89, 140.7  -- questie:trace, z: terrain
  UNION ALL SELECT 920002061, -2928.01, 663.6, 117.05  -- questie:trace, z: terrain
  UNION ALL SELECT 920002062, -2925.14, 534.86, 142.92  -- questie:trace, z: terrain
  UNION ALL SELECT 920002063, -2909.28, 722.43, 114.65  -- questie:trace, z: terrain
  UNION ALL SELECT 920002064, -2902.04, 784.55, 99.19  -- questie:trace, z: terrain
  UNION ALL SELECT 920002065, -2898.9, 615.01, 117.89  -- questie:trace, z: terrain
  UNION ALL SELECT 920002066, -2872.52, 554.53, 120.52  -- questie:trace, z: terrain
  UNION ALL SELECT 920002067, -2868.69, 658.67, 108.15  -- questie:trace, z: realm spawn 34 yd away
  UNION ALL SELECT 920002068, -2854.21, 709.72, 114.6  -- questie:trace, z: realm spawn 22 yd away
  UNION ALL SELECT 920002069, -2833.16, 602.3, 120.12  -- questie:trace, z: terrain
  UNION ALL SELECT 920002070, -2815.39, 534.45, 130.15  -- questie:trace, z: terrain
  UNION ALL SELECT 920002071, -2808.56, 662.37, 96.25  -- questie:trace, z: terrain
) s
WHERE @EVERLAKE_CS254567 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS254567 = 1 AND c.`id` = 254567 AND c.`guid` BETWEEN 920002054 AND 920002071;

-- Converted Farmer (259258): 266252 75.63%; for 94858.
-- Faction 16 as Twilight Neophyte (256798) (200 yd); 9 spawn(s) from 18 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 256798 (200 yd), reactions wowhead; spawns questie; drops wowhead';
SET @EVERLAKE_C259258 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 259258)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259258);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 259258, 0, 0, 'Converted Farmer', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 4, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C259258 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 259258, 0, 0, 0, 0, 0, 1, 1, 1, 1, 342438, 0, 0, 0, 259258, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C259258 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 259258, 0, 141425, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C259258 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 259258, 41, 41 FROM DUAL
WHERE @EVERLAKE_C259258 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 259258);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 259258, 0, 0, 266252, 0 FROM DUAL WHERE @EVERLAKE_C259258 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 259258 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 259258, 0, 266252, 75.63, 1, 1, 0, 1, 1, 'Converted Farmer: wowhead 149/197' FROM DUAL WHERE @EVERLAKE_C259258 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259258 AND `ItemType` = 0 AND `Item` = 266252);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 259258, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259258 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 259258);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 259258, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259258 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 259258, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259258 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 259258, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259258 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 259258, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259258 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259258, 0, 266252, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259258 = 1;
SET @EVERLAKE_CS259258 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259258 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 259258 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 259258);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 259258, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002072 AS `guid`, -7921.67 AS `x`, -4481.57 AS `y`, 32.77 AS `z`  -- questie:generated, z: the floor of the building on the ground
  UNION ALL SELECT 920002073, -7964.35, -4444.22, 31.91  -- questie:trace, z: terrain
  UNION ALL SELECT 920002074, -7940.42, -4394.27, 32.43  -- questie:trace, z: terrain
  UNION ALL SELECT 920002075, -7896.12, -4405.42, 32.08  -- questie:trace, z: terrain
  UNION ALL SELECT 920002076, -7894.51, -4441.31, 32.06  -- questie:trace, z: terrain
  UNION ALL SELECT 920002077, -7892.57, -4476.72, 32.37  -- questie:trace, z: terrain
  UNION ALL SELECT 920002078, -7878.66, -4528.13, 33.96  -- questie:trace, z: terrain
  UNION ALL SELECT 920002079, -7856.68, -4466.05, 50.45  -- questie:trace, z: realm spawn 23 yd away
  UNION ALL SELECT 920002080, -7844.39, -4546.56, 32.07  -- questie:trace, z: terrain
) s
WHERE @EVERLAKE_CS259258 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS259258 = 1 AND c.`id` = 259258 AND c.`guid` BETWEEN 920002072 AND 920002080;

-- Tainted Hyjal Bear (244530): 243266 6.67%, 262913 6.67%; for no quest.
-- Faction 14 as Hyjal Owl (249053) (200 yd); 8 spawn(s) from 111 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 249053 (200 yd), reactions wowhead; spawns questie; drops wowhead';
SET @EVERLAKE_C244530 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 244530)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 244530);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 244530, 0, 0, 'Tainted Hyjal Bear', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 4, 0, 1, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C244530 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 244530, 0, 0, 0, 0, 0, 1.5, 1, 1, 1, 323875, 1, 0, 0, 244530, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C244530 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 244530, 0, 148859, 1, 0, 0 FROM DUAL WHERE @EVERLAKE_C244530 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 244530, 56, 57 FROM DUAL
WHERE @EVERLAKE_C244530 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 244530);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 244530, 0, 0, 243266, 0 FROM DUAL WHERE @EVERLAKE_C244530 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 244530 AND `DifficultyID` = 0 AND `Idx` = 0)
UNION ALL SELECT 244530, 0, 1, 262913, 0 FROM DUAL WHERE @EVERLAKE_C244530 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 244530 AND `DifficultyID` = 0 AND `Idx` = 1);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 244530, 0, 243266, 6.67, 1, 1, 0, 1, 1, 'Tainted Hyjal Bear: wowhead 1/15' FROM DUAL WHERE @EVERLAKE_C244530 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 244530 AND `ItemType` = 0 AND `Item` = 243266)
UNION ALL SELECT 244530, 0, 262913, 6.67, 1, 1, 0, 1, 1, 'Tainted Hyjal Bear: wowhead 1/15' FROM DUAL WHERE @EVERLAKE_C244530 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 244530 AND `ItemType` = 0 AND `Item` = 262913);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 244530, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244530 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 244530);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 244530, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244530 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 244530, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244530 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 244530, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244530 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 244530, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244530 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 244530, 0, 1, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244530 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 244530, 0, 243266, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244530 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 244530, 0, 262913, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244530 = 1;
SET @EVERLAKE_CS244530 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 244530 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 244530 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 244530);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 244530, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920002081 AS `guid`, 4224.51 AS `x`, -2510.04 AS `y`, 1166.98 AS `z`  -- questie:trace, z: terrain
  UNION ALL SELECT 920002082, 4288.16, -2665.28, 1108.2  -- questie:trace, z: terrain
  UNION ALL SELECT 920002083, 4306.68, -2361.75, 1164.5  -- questie:trace, z: terrain
  UNION ALL SELECT 920002084, 4392.32, -2519.76, 1122.3  -- questie:trace, z: realm spawn 35 yd away
  UNION ALL SELECT 920002085, 4403.66, -3383.48, 1017.83  -- questie:trace, z: terrain
  UNION ALL SELECT 920002086, 4468.24, -3220.25, 1026.49  -- questie:trace, z: terrain
  UNION ALL SELECT 920002087, 4515.69, -3509.2, 989.77  -- questie:trace, z: terrain
  UNION ALL SELECT 920002088, 4624.94, -3355.0, 1016.32  -- questie:trace, z: terrain
) s
WHERE @EVERLAKE_CS244530 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS244530 = 1 AND c.`id` = 244530 AND c.`guid` BETWEEN 920002081 AND 920002088;

COMMIT;
