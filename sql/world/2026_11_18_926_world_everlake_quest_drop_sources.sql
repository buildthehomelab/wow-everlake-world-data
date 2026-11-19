-- New WoW Forever creatures and objects whose loot is a quest item, so the quests that ask for it can be done.
-- 2026_11_18_926_world_everlake_quest_drop_sources.sql: written from public data by a script, checked by hand.
--
-- The realm's tracker listed quests whose item no one could get: QuestieDB (its Forever item corrections, generated and
-- players' QuestieTrace recordings) names the creature or object that drops it, and the realm had no template for it.
-- This adds 11 creatures and 12 objects, each only where EG Link recorded the client's own query data
-- for it (creature_details / object_details: what the live server sent players' games) and a place for it is known.
--
-- Creatures (108 spawns), as slice 5 of the Everlake import (docs/forever-import.md) writes new NPCs:
--   * template: EG Link's creature details (name, type, family, classification, class, models, type flags, health and
--     power multipliers, CreatureDifficultyID, movement); levels from EG Link's creature records, else QuestieDB's
--     player traces; quest items (creature_questitem) as the client was told.
--   * faction: no public source records it. The commonest faction of the realm's own NPCs spawned within 60 yards
--     (else 200, said per row) that treats players as EG Link's players saw this creature do (its reactions; any
--     faction when no player recorded one), same creature type first. The nearest of them lends walk and run speed,
--     attack times and variance. Each creature's note names it.
--   * spawns: one for a named creature (the middle of its recorded points, a QuestieDB point when one is within 15
--     yards); a kind of mob gets one spawn per cell of the realm's own spacing of mobs around those points (the median
--     distance of each nearby creature's spawns to its nearest twin), best sources first: QuestieDB (fix, generated,
--     trace), then EG Link's sightings (where the player stood at its corpse). Respawn time, wander distance and
--     movement as the realm's commonest for that classification on the map. Heights from the realm's own maps and vmaps
--     (ForeverTracker tools/height.py, client 70790's files): near a realm spawn (20 yards) its floor, else the
--     terrain. Not checked in game.
--   * loot: only the quest items, QuestRequired. Chance: EG Link's per-quest chance where a quest had 10 or more
--     recorded loot windows, else 40 (the tracker's quest_chance for a quest item no source gives a chance for).
--     No other loot and no money yet: a later drops import adds them once the templates are in.
-- Objects (134 spawns): EG Link's object details are the whole template (type, model, size, the 35 data values:
-- lock, loot id, personal loot id, quest, spell). Chests (type 3) get their quest items at 100% for players on the
-- quest (gameobject_questitem and loot rows), as the realm's other quest chests; a loot id the realm already fills is
-- left as it is. Several of these chests are already in the realm's world (templates from the fork's sniffs) but were
-- never spawned and most have no loot: those get the spawns and the loot here too, only while the realm's template has
-- EG Link's type and loot id and no spawn. Spawns: QuestieDB's points, else the middle of EG Link's player positions
-- at the object (players open it from up to ~5 yards, so a spawn may stand a few yards off); points closer than 8
-- yards are one spawn. Respawn as the realm's commonest for quest chests on the map. Rotation 0.
--
-- Sources: EG Link (Efficient Games, CC BY 4.0) 30c3bb9c (data to 2026-11-18); QuestieDB (GPL-3.0) 4f628e83;
-- forever-db from Polestar (GPL-3.0) 74eda09e, spawn points; client tables CreatureDisplayInfo and FactionTemplate (70790).
-- Guids: creatures 920001000 to 920001108, objects 920001030 to 920001164: a block of their own after file 923's.
-- No template is added where the realm already has one; creature spawns only while the template is this file's and the
-- realm has no spawn of it, object spawns while the realm has none of that object. Each added row is recorded in
-- everlake_import_rows.
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

SET @EVERLAKE_FILE := '2026_11_18_926_world_everlake_quest_drop_sources.sql';

START TRANSACTION;

-- Gharrik (213795): 78830. Faction 16 as Ridge Stalker Patriarch (2734); 1 spawn(s) from 18 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 2734; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C213795 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 213795)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 213795);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 213795, 0, 0, 'Gharrik', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.42857, 1, 0, 0, 1300, 2000, 1, 1, 1, 0, 2048, 0, 7, 0, 1, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C213795 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 213795, 0, 0, 0, 0, 0, 1.15, 1, 1, 1, 263196, 134217729, 0, 0, 213795, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C213795 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 213795, 0, 115693, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_C213795 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 213795, 40, 40 FROM DUAL
WHERE @EVERLAKE_C213795 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 213795);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 213795, 0, 0, 211293, 0 FROM DUAL WHERE @EVERLAKE_C213795 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 213795 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 213795, 0, 211293, 40, 1, 1, 0, 1, 1, 'Gharrik: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C213795 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 213795 AND `ItemType` = 0 AND `Item` = 211293);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 213795, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C213795 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 213795);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 213795, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C213795 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 213795, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C213795 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 213795, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C213795 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 213795, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C213795 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 213795, 0, 211293, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C213795 = 1;
SET @EVERLAKE_CS213795 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 213795 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 213795 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 213795);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 213795, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001000 AS `guid`, -7007.5 AS `x`, -2636.5 AS `y`, 297.35 AS `z`  -- polestar
) s
WHERE @EVERLAKE_CS213795 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS213795 = 1 AND c.`id` = 213795 AND c.`guid` BETWEEN 920001000 AND 920001000;

-- Namida Grimtotem (222286): 92878. Faction 16 as Grimtotem Raider (7725); 1 spawn(s) from 11 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 7725; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C222286 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 222286)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 222286);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 222286, 0, 0, 'Namida Grimtotem', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 2, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C222286 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 222286, 0, 0, 0, 0, 0, 3, 1, 1, 1, 272108, 134217728, 0, 0, 222286, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C222286 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 222286, 0, 119063, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C222286 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 222286, 43, 43 FROM DUAL
WHERE @EVERLAKE_C222286 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 222286);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 222286, 0, 0, 254877, 0 FROM DUAL WHERE @EVERLAKE_C222286 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 222286 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 222286, 0, 254877, 40, 1, 1, 0, 1, 1, 'Namida Grimtotem: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C222286 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 222286 AND `ItemType` = 0 AND `Item` = 254877);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 222286, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222286 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 222286);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 222286, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222286 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 222286, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222286 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 222286, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222286 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 222286, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222286 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 222286, 0, 254877, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222286 = 1;
SET @EVERLAKE_CS222286 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 222286 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 222286 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 222286);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 222286, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 600, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001001 AS `guid`, -4155 AS `x`, 799 AS `y`, 145.21 AS `z`  -- polestar
) s
WHERE @EVERLAKE_CS222286 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS222286 = 1 AND c.`id` = 222286 AND c.`guid` BETWEEN 920001001 AND 920001001;

-- Gimashi (255003): 93465. Faction 554 as Burning Blade Summoner (4668); 1 spawn(s) from 3 points.
SET @EVERLAKE_NOTE := 'eglink@70888 creature_details; levels questie:trace; faction/speeds from 4668; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C255003 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 255003)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 255003);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 255003, 0, 0, 'Gimashi', NULL, NULL, NULL, NULL, 0, 0, 554, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C255003 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 255003, 0, 0, 0, 0, 0, 1.15, 1, 1, 1, 335910, 134217728, 0, 0, 255003, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C255003 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 255003, 0, 138589, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C255003 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 255003, 40, 40 FROM DUAL
WHERE @EVERLAKE_C255003 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 255003);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 255003, 0, 0, 258774, 0 FROM DUAL WHERE @EVERLAKE_C255003 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 255003 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 255003, 0, 258774, 40, 1, 1, 0, 1, 1, 'Gimashi: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C255003 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 255003 AND `ItemType` = 0 AND `Item` = 258774);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 255003, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255003 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 255003);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 255003, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255003 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 255003, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255003 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 255003, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255003 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 255003, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255003 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 255003, 0, 258774, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255003 = 1;
SET @EVERLAKE_CS255003 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 255003 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 255003 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 255003);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 255003, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001002 AS `guid`, -1842.22 AS `x`, 597.1 AS `y`, 109.63 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS255003 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS255003 = 1 AND c.`id` = 255003 AND c.`guid` BETWEEN 920001002 AND 920001002;

-- Chogg'Zac (256899): 95562. Faction 16 as Twilight Shadowmancer (254560); 1 spawn(s) from 26 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 254560; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C256899 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 256899)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 256899);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 256899, 0, 0, 'Chogg''Zac', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 2, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C256899 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 256899, 0, 0, 0, 0, 0, 3, 0.6, 1, 1, 339964, 0, 0, 0, 256899, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C256899 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 256899, 0, 16020, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C256899 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 256899, 41, 41 FROM DUAL
WHERE @EVERLAKE_C256899 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 256899);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 256899, 0, 0, 265751, 0 FROM DUAL WHERE @EVERLAKE_C256899 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 256899 AND `DifficultyID` = 0 AND `Idx` = 0)
UNION ALL SELECT 256899, 0, 1, 265750, 0 FROM DUAL WHERE @EVERLAKE_C256899 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 256899 AND `DifficultyID` = 0 AND `Idx` = 1)
UNION ALL SELECT 256899, 0, 2, 266426, 0 FROM DUAL WHERE @EVERLAKE_C256899 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 256899 AND `DifficultyID` = 0 AND `Idx` = 2);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 256899, 0, 265751, 40, 1, 1, 0, 1, 1, 'Chogg''Zac: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C256899 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 256899 AND `ItemType` = 0 AND `Item` = 265751);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 256899, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256899 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 256899);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 256899, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256899 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 256899, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256899 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 256899, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256899 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 256899, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256899 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 256899, 0, 1, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256899 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 256899, 0, 2, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256899 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 256899, 0, 265751, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C256899 = 1;
SET @EVERLAKE_CS256899 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 256899 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 256899 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 256899);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 256899, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 720, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001003 AS `guid`, -8119.55 AS `x`, -4130.43 AS `y`, 21.95 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS256899 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS256899 = 1 AND c.`id` = 256899 AND c.`guid` BETWEEN 920001003 AND 920001003;

-- Monstrous Threshadon (260244): 95267. Faction 14 as Murloc Tideskimmer (255899); 1 spawn(s) from 55 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 255899; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C260244 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 260244)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260244);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 260244, 0, 0, 'Monstrous Threshadon', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C260244 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 260244, 0, 0, 0, 0, 0, 1.5, 1, 1, 1, 343450, 0, 0, 0, 260244, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C260244 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 260244, 0, 992, 1.25, 0, 0 FROM DUAL WHERE @EVERLAKE_C260244 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 260244, 42, 42 FROM DUAL
WHERE @EVERLAKE_C260244 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 260244);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 260244, 0, 0, 268633, 0 FROM DUAL WHERE @EVERLAKE_C260244 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 260244 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 260244, 0, 268633, 40, 1, 1, 0, 1, 1, 'Monstrous Threshadon: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C260244 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 260244 AND `ItemType` = 0 AND `Item` = 268633);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 260244, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260244 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 260244);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 260244, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260244 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260244, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260244 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 260244, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260244 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 260244, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260244 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 260244, 0, 268633, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260244 = 1;
SET @EVERLAKE_CS260244 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260244 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260244 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260244);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260244, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001004 AS `guid`, -8793.05 AS `x`, -5500.55 AS `y`, -9.25 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS260244 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS260244 = 1 AND c.`id` = 260244 AND c.`guid` BETWEEN 920001004 AND 920001004;

-- Klunk (260973): 95425. Faction 14 as Eastsea Musketeer (257910); 1 spawn(s) from 13 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 257910 (200 yd); spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C260973 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 260973)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260973);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 260973, 0, 0, 'Klunk', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C260973 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 260973, 0, 0, 0, 0, 0, 2, 1, 1, 1, 344181, 0, 0, 0, 260973, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C260973 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 260973, 0, 11569, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C260973 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 260973, 42, 42 FROM DUAL
WHERE @EVERLAKE_C260973 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 260973);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 260973, 0, 0, 269257, 0 FROM DUAL WHERE @EVERLAKE_C260973 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 260973 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 260973, 0, 269257, 40, 1, 1, 0, 1, 1, 'Klunk: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C260973 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 260973 AND `ItemType` = 0 AND `Item` = 269257);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 260973, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260973 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 260973);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 260973, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260973 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260973, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260973 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 260973, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260973 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 260973, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260973 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 260973, 0, 269257, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260973 = 1;
SET @EVERLAKE_CS260973 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260973 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260973 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260973);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260973, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001005 AS `guid`, -7312.83 AS `x`, -5513.65 AS `y`, 188.56 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS260973 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS260973 = 1 AND c.`id` = 260973 AND c.`guid` BETWEEN 920001005 AND 920001005;

-- Mirrorscale (269057): 97378. Faction 14 as Rogue Vale Screecher (5308); 1 spawn(s) from 27 points.
SET @EVERLAKE_NOTE := 'eglink@70888 creature_details; levels questie:trace; faction/speeds from 5308 (200 yd); spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C269057 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 269057)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 269057);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 269057, 0, 0, 'Mirrorscale', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.42857, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 27, 0, 1, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C269057 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 269057, 0, 0, 0, 0, 0, 1.2, 1, 1, 1, 352707, 134217729, 0, 0, 269057, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C269057 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 269057, 0, 145741, 1, 0, 0 FROM DUAL WHERE @EVERLAKE_C269057 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 269057, 48, 48 FROM DUAL
WHERE @EVERLAKE_C269057 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 269057);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 269057, 0, 0, 277972, 0 FROM DUAL WHERE @EVERLAKE_C269057 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 269057 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 269057, 0, 277972, 40, 1, 1, 0, 1, 1, 'Mirrorscale: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C269057 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 269057 AND `ItemType` = 0 AND `Item` = 277972);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 269057, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269057 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 269057);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 269057, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269057 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 269057, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269057 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 269057, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269057 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 269057, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269057 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 269057, 0, 277972, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269057 = 1;
SET @EVERLAKE_CS269057 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 269057 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 269057 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 269057);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 269057, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001007 AS `guid`, -4512.36 AS `x`, 2129.3 AS `y`, 4.34 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS269057 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS269057 = 1 AND c.`id` = 269057 AND c.`guid` BETWEEN 920001007 AND 920001007;

-- Decrepit Pylon Protector (252711): 99257. Faction 133 as Magram Necrokhan (253274); 33 spawn(s) from 209 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 253274; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C252711 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 252711)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 252711);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 252711, 0, 0, 'Decrepit Pylon Protector', NULL, NULL, NULL, NULL, 0, 0, 133, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C252711 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 252711, 0, 0, 0, 0, 0, 1, 1, 1, 1, 333551, 0, 0, 0, 252711, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C252711 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 252711, 0, 137523, 2, 1, 0 FROM DUAL WHERE @EVERLAKE_C252711 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 252711, 42, 43 FROM DUAL
WHERE @EVERLAKE_C252711 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 252711);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 252711, 0, 0, 286647, 0 FROM DUAL WHERE @EVERLAKE_C252711 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 252711 AND `DifficultyID` = 0 AND `Idx` = 0);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 252711, 0, 286647, 40, 1, 1, 0, 1, 1, 'Decrepit Pylon Protector: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C252711 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 252711 AND `ItemType` = 0 AND `Item` = 286647);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 252711, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C252711 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 252711);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 252711, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C252711 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 252711, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C252711 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 252711, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C252711 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 252711, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C252711 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 252711, 0, 286647, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C252711 = 1;
SET @EVERLAKE_CS252711 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 252711 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 252711 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 252711);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 252711, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001008 AS `guid`, -2401.57 AS `x`, 1104.55 AS `y`, 128.05 AS `z`  -- questie:generated
  UNION ALL SELECT 920001009, -2378.33, 1135.3, 105.61  -- questie:generated
  UNION ALL SELECT 920001010, -2348.27, 1108.65, 107.08  -- questie:generated
  UNION ALL SELECT 920001011, -2225.27, 497.75, 176.6  -- questie:generated
  UNION ALL SELECT 920001012, -2214.33, 540.8, 162.25  -- questie:generated
  UNION ALL SELECT 920001013, -2507.89, 1108.24, 135.95  -- questie:trace
  UNION ALL SELECT 920001014, -2494.5, 1065.81, 129.47  -- questie:trace
  UNION ALL SELECT 920001015, -2468.81, 1093.89, 134.71  -- questie:trace
  UNION ALL SELECT 920001016, -2431.91, 1079.34, 128.55  -- questie:trace
  UNION ALL SELECT 920001017, -2416.74, 1006.36, 148.7  -- questie:trace
  UNION ALL SELECT 920001018, -2406.49, 1044.07, 125.19  -- questie:trace
  UNION ALL SELECT 920001019, -2370.41, 1057.61, 121.85  -- questie:trace
  UNION ALL SELECT 920001020, -2365.76, 1013.94, 131.04  -- questie:trace
  UNION ALL SELECT 920001021, -2340.61, 543.46, 40.97  -- questie:trace
  UNION ALL SELECT 920001022, -2337.61, 1163.38, 96.45  -- questie:trace
  UNION ALL SELECT 920001023, -2334.05, 1046.54, 116.61  -- questie:trace
  UNION ALL SELECT 920001024, -2326.54, 1238.62, 92.63  -- questie:trace
  UNION ALL SELECT 920001025, -2318.2, 1301.76, 84.25  -- questie:trace
  UNION ALL SELECT 920001026, -2310.0, 1200.9, 93.63  -- questie:trace
  UNION ALL SELECT 920001027, -2308.5, 1130.17, 97.78  -- questie:trace
  UNION ALL SELECT 920001028, -2294.97, 558.22, 170.63  -- questie:trace
  UNION ALL SELECT 920001029, -2286.49, 1035.67, 105.81  -- questie:trace
  UNION ALL SELECT 920001030, -2269.82, 593.28, 155.2  -- questie:trace
  UNION ALL SELECT 920001031, -2266.95, 533.21, 181.02  -- questie:trace
  UNION ALL SELECT 920001032, -2261.35, 1269.58, 83.07  -- questie:trace
  UNION ALL SELECT 920001033, -2256.84, 1321.64, 63.67  -- questie:trace
  UNION ALL SELECT 920001034, -2234.01, 583.23, 163.72  -- questie:trace
  UNION ALL SELECT 920001035, -2228.14, 419.64, 180.0  -- questie:trace
  UNION ALL SELECT 920001036, -2218.43, 630.79, 153.97  -- questie:trace
  UNION ALL SELECT 920001037, -2207.23, 459.0, 177.29  -- questie:trace
  UNION ALL SELECT 920001038, -2204.84, 387.37, 187.87  -- questie:trace
  UNION ALL SELECT 920001039, -2186.18, 492.83, 177.59  -- questie:trace
  UNION ALL SELECT 920001040, -2175.11, 530.55, 173.77  -- questie:trace
) s
WHERE @EVERLAKE_CS252711 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS252711 = 1 AND c.`id` = 252711 AND c.`guid` BETWEEN 920001008 AND 920001040;

-- Wildplains Patriarch (259054): 94925, 96109. Faction 16 as Low Plains Buzzard (263343); 16 spawn(s) from 187 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 263343 (200 yd); spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C259054 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 259054)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259054);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 259054, 0, 0, 'Wildplains Patriarch', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 2, 0, 1, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C259054 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 259054, 0, 0, 0, 0, 0, 1.25, 1, 1, 1, 342210, 134217729, 0, 0, 259054, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C259054 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 259054, 0, 1977, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C259054 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 259054, 38, 39 FROM DUAL
WHERE @EVERLAKE_C259054 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 259054);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 259054, 0, 0, 266888, 0 FROM DUAL WHERE @EVERLAKE_C259054 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 259054 AND `DifficultyID` = 0 AND `Idx` = 0)
UNION ALL SELECT 259054, 0, 1, 268632, 0 FROM DUAL WHERE @EVERLAKE_C259054 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 259054 AND `DifficultyID` = 0 AND `Idx` = 1);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 259054, 0, 266888, 40, 1, 1, 0, 1, 1, 'Wildplains Patriarch: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C259054 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259054 AND `ItemType` = 0 AND `Item` = 266888);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 259054, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259054 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 259054);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 259054, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259054 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 259054, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259054 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 259054, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259054 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 259054, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259054 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 259054, 0, 1, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259054 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259054, 0, 266888, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259054 = 1;
SET @EVERLAKE_CS259054 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259054 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 259054 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 259054);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 259054, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001041 AS `guid`, -8451.61 AS `x`, -4744.44 AS `y`, 28.18 AS `z`  -- questie:trace
  UNION ALL SELECT 920001042, -8397.94, -4639.68, 23.22  -- questie:trace
  UNION ALL SELECT 920001043, -8384.68, -4835.13, 23.19  -- questie:trace
  UNION ALL SELECT 920001044, -8337.47, -4733.28, 22.94  -- questie:trace
  UNION ALL SELECT 920001045, -8301.58, -4591.66, 24.23  -- questie:trace
  UNION ALL SELECT 920001046, -8286.71, -4894.79, 18.15  -- questie:trace
  UNION ALL SELECT 920001047, -8230.77, -4767.72, 51.41  -- questie:trace
  UNION ALL SELECT 920001048, -8211.7, -4986.45, 25.28  -- questie:trace
  UNION ALL SELECT 920001049, -8201.67, -4662.96, 24.91  -- questie:trace
  UNION ALL SELECT 920001050, -8200.7, -4555.77, 23.23  -- questie:trace
  UNION ALL SELECT 920001051, -8173.87, -4870.05, 23.24  -- questie:trace
  UNION ALL SELECT 920001052, -8122.78, -4761.9, 27.59  -- questie:trace
  UNION ALL SELECT 920001053, -8089.48, -4645.5, 23.93  -- questie:trace
  UNION ALL SELECT 920001054, -8088.83, -4968.51, 27.4  -- questie:trace
  UNION ALL SELECT 920001055, -8059.73, -4851.14, 23.04  -- questie:trace
  UNION ALL SELECT 920001056, -8002.18, -4721.16, 31.02  -- questie:trace
) s
WHERE @EVERLAKE_CS259054 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS259054 = 1 AND c.`id` = 259054 AND c.`guid` BETWEEN 920001041 AND 920001056;

-- Wildplains Huntress (259055): 94925, 96109. Faction 16 as Freshwater Crocolisk (259046); 20 spawn(s) from 216 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 259046 (200 yd); spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C259055 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 259055)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259055);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 259055, 0, 0, 'Wildplains Huntress', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 2, 0, 1, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C259055 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 259055, 0, 0, 0, 0, 0, 1, 1, 1, 1, 342211, 134217729, 0, 0, 259055, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C259055 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 259055, 0, 1933, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C259055 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 259055, 38, 39 FROM DUAL
WHERE @EVERLAKE_C259055 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 259055);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 259055, 0, 0, 266888, 0 FROM DUAL WHERE @EVERLAKE_C259055 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 259055 AND `DifficultyID` = 0 AND `Idx` = 0)
UNION ALL SELECT 259055, 0, 1, 268632, 0 FROM DUAL WHERE @EVERLAKE_C259055 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 259055 AND `DifficultyID` = 0 AND `Idx` = 1);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 259055, 0, 266888, 40, 1, 1, 0, 1, 1, 'Wildplains Huntress: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C259055 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259055 AND `ItemType` = 0 AND `Item` = 266888)
UNION ALL SELECT 259055, 0, 268632, 40, 1, 1, 0, 1, 1, 'Wildplains Huntress: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C259055 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 259055 AND `ItemType` = 0 AND `Item` = 268632);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 259055, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259055 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 259055);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 259055, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259055 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 259055, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259055 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 259055, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259055 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 259055, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259055 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 259055, 0, 1, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259055 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259055, 0, 266888, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259055 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 259055, 0, 268632, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259055 = 1;
SET @EVERLAKE_CS259055 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259055 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 259055 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 259055);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 259055, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001057 AS `guid`, -8354.93 AS `x`, -4724.07 AS `y`, 23.1 AS `z`  -- questie:generated
  UNION ALL SELECT 920001058, -8283.8, -4782.27, 25.51  -- questie:generated
  UNION ALL SELECT 920001059, -8248.23, -4675.57, 24.43  -- questie:generated
  UNION ALL SELECT 920001060, -8238.53, -4922.92, 24.22  -- questie:generated
  UNION ALL SELECT 920001061, -8232.07, -4845.32, 25.69  -- questie:generated
  UNION ALL SELECT 920001062, -8209.43, -4767.72, 48.24  -- questie:generated
  UNION ALL SELECT 920001063, -8177.1, -4661.02, 25.27  -- questie:generated
  UNION ALL SELECT 920001064, -8148.0, -4864.72, 25.15  -- questie:generated
  UNION ALL SELECT 920001065, -8135.07, -4762.87, 30.0  -- questie:generated
  UNION ALL SELECT 920001066, -8394.38, -4784.21, 23.02  -- questie:trace
  UNION ALL SELECT 920001067, -8333.92, -4863.75, 25.81  -- questie:trace
  UNION ALL SELECT 920001068, -8321.95, -4656.17, 23.61  -- questie:trace
  UNION ALL SELECT 920001069, -8222.69, -4598.94, 23.55  -- questie:trace
  UNION ALL SELECT 920001070, -8167.08, -4957.35, 23.12  -- questie:trace
  UNION ALL SELECT 920001071, -8104.03, -4696.91, 22.92  -- questie:trace
  UNION ALL SELECT 920001072, -8089.8, -4935.53, 24.67  -- questie:trace
  UNION ALL SELECT 920001073, -8066.84, -4803.61, 23.7  -- questie:trace
  UNION ALL SELECT 920001074, -8043.56, -4645.98, 24.56  -- questie:trace
  UNION ALL SELECT 920001075, -8041.3, -4876.84, 23.24  -- questie:trace
  UNION ALL SELECT 920001076, -7989.24, -4808.46, 23.54  -- questie:trace
) s
WHERE @EVERLAKE_CS259055 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS259055 = 1 AND c.`id` = 259055 AND c.`guid` BETWEEN 920001057 AND 920001076;

-- Glade Viper (263307): 96108. Faction 16 as Low Plains Buzzard (263343); 32 spawn(s) from 272 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 263343; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C263307 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 263307)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 263307);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 263307, 0, 0, 'Glade Viper', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C263307 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 263307, 0, 0, 0, 0, 0, 1, 1, 1, 1, 346614, 0, 0, 0, 263307, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C263307 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 263307, 0, 14557, 1, 0, 0 FROM DUAL WHERE @EVERLAKE_C263307 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 263307, 37, 38 FROM DUAL
WHERE @EVERLAKE_C263307 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 263307);
INSERT INTO `creature_questitem` (`CreatureEntry`, `DifficultyID`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 263307, 0, 0, 271776, 0 FROM DUAL WHERE @EVERLAKE_C263307 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 263307 AND `DifficultyID` = 0 AND `Idx` = 0)
UNION ALL SELECT 263307, 0, 1, 268632, 0 FROM DUAL WHERE @EVERLAKE_C263307 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_questitem` WHERE `CreatureEntry` = 263307 AND `DifficultyID` = 0 AND `Idx` = 1);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 263307, 0, 271776, 40, 1, 1, 0, 1, 1, 'Glade Viper: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C263307 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 263307 AND `ItemType` = 0 AND `Item` = 271776)
UNION ALL SELECT 263307, 0, 268632, 40, 1, 1, 0, 1, 1, 'Glade Viper: tracker quest_chance (too few recorded windows)' FROM DUAL WHERE @EVERLAKE_C263307 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 263307 AND `ItemType` = 0 AND `Item` = 268632);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 263307, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263307 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 263307);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 263307, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263307 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 263307, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263307 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 263307, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263307 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 263307, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263307 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questitem', 263307, 0, 1, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263307 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 263307, 0, 271776, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263307 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 263307, 0, 268632, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C263307 = 1;
SET @EVERLAKE_CS263307 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 263307 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 263307 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 263307);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 263307, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001077 AS `guid`, -8617.8 AS `x`, -5044.65 AS `y`, 23.87 AS `z`  -- questie:trace
  UNION ALL SELECT 920001078, -8565.1, -4903.52, 27.1  -- questie:trace
  UNION ALL SELECT 920001079, -8562.51, -4989.85, 26.02  -- questie:trace
  UNION ALL SELECT 920001080, -8553.46, -5085.88, 24.89  -- questie:trace
  UNION ALL SELECT 920001081, -8546.67, -4814.28, 30.17  -- questie:trace
  UNION ALL SELECT 920001082, -8532.44, -4729.89, 24.38  -- questie:trace
  UNION ALL SELECT 920001083, -8496.88, -4946.68, 24.15  -- questie:trace
  UNION ALL SELECT 920001084, -8488.47, -4860.84, 24.73  -- questie:trace
  UNION ALL SELECT 920001085, -8488.15, -5017.98, 23.01  -- questie:trace
  UNION ALL SELECT 920001086, -8477.8, -5105.76, 26.43  -- questie:trace
  UNION ALL SELECT 920001087, -8451.93, -4771.6, 27.78  -- questie:trace
  UNION ALL SELECT 920001088, -8440.94, -4683.81, 32.5  -- questie:trace
  UNION ALL SELECT 920001089, -8422.83, -4972.39, 23.16  -- questie:trace
  UNION ALL SELECT 920001090, -8410.87, -4843.38, 24.11  -- questie:trace
  UNION ALL SELECT 920001091, -8400.2, -5083.45, 23.84  -- questie:trace
  UNION ALL SELECT 920001092, -8376.27, -4911.28, 24.31  -- questie:trace
  UNION ALL SELECT 920001093, -8370.45, -4748.32, 24.69  -- questie:trace
  UNION ALL SELECT 920001094, -8364.31, -4664.41, 23.33  -- questie:trace
  UNION ALL SELECT 920001095, -8355.26, -5016.52, 25.55  -- questie:trace
  UNION ALL SELECT 920001096, -8336.18, -4846.29, 23.62  -- questie:trace
  UNION ALL SELECT 920001097, -8300.61, -4944.26, 23.77  -- questie:trace
  UNION ALL SELECT 920001098, -8300.29, -5089.27, 33.14  -- questie:trace
  UNION ALL SELECT 920001099, -8296.09, -4736.19, 23.01  -- questie:trace
  UNION ALL SELECT 920001100, -8283.48, -4641.62, 23.39  -- questie:trace
  UNION ALL SELECT 920001101, -8263.75, -4876.36, 22.78  -- questie:trace
  UNION ALL SELECT 920001102, -8255.35, -5027.19, 29.96  -- questie:trace
  UNION ALL SELECT 920001103, -8242.41, -4802.64, 37.31  -- questie:trace
  UNION ALL SELECT 920001104, -8223.66, -4715.82, 28.23  -- questie:trace
  UNION ALL SELECT 920001105, -8201.03, -4916.13, 23.51  -- questie:trace
  UNION ALL SELECT 920001106, -8187.45, -5075.69, 37.43  -- questie:trace
  UNION ALL SELECT 920001107, -8176.45, -5000.03, 24.89  -- questie:trace
  UNION ALL SELECT 920001108, -8141.53, -4858.41, 25.63  -- questie:trace
) s
WHERE @EVERLAKE_CS263307 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS263307 = 1 AND c.`id` = 263307 AND c.`guid` BETWEEN 920001077 AND 920001108;

-- Accursed Skull (587276, type 3): 93041. 3 spawn(s) from 8 points.
SET @EVERLAKE_NOTE := 'eglink@70938 object_details; spawns eglink; drops QuestieDB';
SET @EVERLAKE_O587276 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 587276)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 587276);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 587276, 3, 114687, 'Accursed Skull', '', '', '', 2, 4088, 136336, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O587276 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 587276, 0, 255945, 0 FROM DUAL WHERE @EVERLAKE_O587276 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 587276 AND `Idx` = 0);
SET @EVERLAKE_L587276 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 587276 AND `type` = 3 AND 136336 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 136336);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 136336, 0, 255945, 100, 1, 1, 0, 1, 1, 'Accursed Skull' FROM DUAL WHERE @EVERLAKE_L587276 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 587276, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O587276 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 587276);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 587276, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O587276 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 136336, 0, 255945, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L587276 = 1;
SET @EVERLAKE_OS587276 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 587276 AND `type` = 3 AND 136336 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 587276)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001030 AND 920001032);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 587276, 1, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001030 AS `guid`, -2240.7 AS `x`, 1385.2 AS `y`, 78.85 AS `z`  -- eglink:approached
  UNION ALL SELECT 920001031, -2234.55, 1384.95, 81.3  -- eglink:approached
  UNION ALL SELECT 920001032, -2224.84, 1377.06, 83.25  -- eglink:approached
) s
WHERE @EVERLAKE_OS587276 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS587276 = 1 AND g.`id` = 587276 AND g.`guid` BETWEEN 920001030 AND 920001032;

-- Centaur Supplies (602101, type 3): 93129. 9 spawn(s) from 10 points.
SET @EVERLAKE_NOTE := 'eglink@70938 object_details; spawns questie; drops QuestieDB';
SET @EVERLAKE_O602101 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 602101)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 602101);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 602101, 3, 115602, 'Centaur Supplies', '', '', '', 1, 4088, 136552, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O602101 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 602101, 0, 256892, 0 FROM DUAL WHERE @EVERLAKE_O602101 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 602101 AND `Idx` = 0);
SET @EVERLAKE_L602101 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 602101 AND `type` = 3 AND 136552 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 136552);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 136552, 0, 256892, 100, 1, 1, 0, 1, 1, 'Centaur Supplies' FROM DUAL WHERE @EVERLAKE_L602101 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 602101, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O602101 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 602101);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 602101, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O602101 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 136552, 0, 256892, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L602101 = 1;
SET @EVERLAKE_OS602101 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 602101 AND `type` = 3 AND 136552 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 602101)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001033 AND 920001041);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 602101, 1, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001033 AS `guid`, -2963.27 AS `x`, 1311.6 AS `y`, 58.06 AS `z`  -- questie:generated
  UNION ALL SELECT 920001034, -2918.17, 1410.0, 65.27  -- questie:generated
  UNION ALL SELECT 920001035, -2907.23, 1418.2, 64.84  -- questie:generated
  UNION ALL SELECT 920001036, -2897.67, 1410.0, 64.47  -- questie:generated
  UNION ALL SELECT 920001037, -2885.37, 1420.25, 64.05  -- questie:generated
  UNION ALL SELECT 920001038, -2867.6, 1403.85, 64.11  -- questie:generated
  UNION ALL SELECT 920001039, -2864.87, 1395.65, 63.73  -- questie:generated
  UNION ALL SELECT 920001040, -2855.3, 1422.3, 64.06  -- questie:generated
  UNION ALL SELECT 920001041, -2848.47, 1412.05, 63.81  -- questie:generated
) s
WHERE @EVERLAKE_OS602101 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS602101 = 1 AND g.`id` = 602101 AND g.`guid` BETWEEN 920001033 AND 920001041;

-- Feed Satchel (616740, type 3): 93787. 14 spawn(s) from 30 points.
SET @EVERLAKE_NOTE := 'eglink@70938 object_details; spawns eglink; drops QuestieDB';
SET @EVERLAKE_O616740 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 616740)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 616740);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 616740, 3, 5511, 'Feed Satchel', '', '', '', 1, 43, 137565, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O616740 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 616740, 0, 262640, 0 FROM DUAL WHERE @EVERLAKE_O616740 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 616740 AND `Idx` = 0);
SET @EVERLAKE_L616740 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 616740 AND `type` = 3 AND 137565 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 137565);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 137565, 0, 262640, 100, 1, 1, 0, 1, 1, 'Feed Satchel' FROM DUAL WHERE @EVERLAKE_L616740 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 616740, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O616740 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 616740);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 616740, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O616740 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 137565, 0, 262640, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L616740 = 1;
SET @EVERLAKE_OS616740 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 616740 AND `type` = 3 AND 137565 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 616740)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001042 AND 920001055);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 616740, 0, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001042 AS `guid`, -9125.4 AS `x`, -4098.15 AS `y`, 24.48 AS `z`  -- eglink:approached
  UNION ALL SELECT 920001043, -9122.8, -4077.8, 24.27  -- eglink:approached
  UNION ALL SELECT 920001044, -9114.2, -4095.03, 24.47  -- eglink:approached
  UNION ALL SELECT 920001045, -9112.8, -4086.1, 24.28  -- eglink:approached
  UNION ALL SELECT 920001046, -9064.72, -4075.25, 23.74  -- eglink:approached
  UNION ALL SELECT 920001047, -9060.58, -4068.18, 24.09  -- eglink:approached
  UNION ALL SELECT 920001048, -9048.17, -4054.17, 24.46  -- eglink:approached
  UNION ALL SELECT 920001049, -9036.9, -4114.6, 24.45  -- eglink:approached
  UNION ALL SELECT 920001050, -9029.77, -4122.0, 24.07  -- eglink:approached
  UNION ALL SELECT 920001051, -9027.4, -4114.2, 23.75  -- eglink:approached
  UNION ALL SELECT 920001052, -9024.25, -4135.3, 24.24  -- eglink:approached
  UNION ALL SELECT 920001053, -9013.9, -4125.9, 24.08  -- eglink:approached
  UNION ALL SELECT 920001054, -9160.7, -4150.4, 26.68  -- eglink:loot
  UNION ALL SELECT 920001055, -9131.7, -4123.6, 25.09  -- eglink:loot
) s
WHERE @EVERLAKE_OS616740 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS616740 = 1 AND g.`id` = 616740 AND g.`guid` BETWEEN 920001042 AND 920001055;

-- Discarded Doll (622001, type 3): 94858. 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'eglink@70938 object_details; spawns questie; drops QuestieDB';
SET @EVERLAKE_O622001 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 622001)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 622001);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 622001, 3, 120320, 'Discarded Doll', '', '', '', 0.75, 4335, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 138917, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O622001 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 622001, 0, 266251, 0 FROM DUAL WHERE @EVERLAKE_O622001 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 622001 AND `Idx` = 0);
SET @EVERLAKE_L622001 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 622001 AND `type` = 3 AND 138917 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 138917);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 138917, 0, 266251, 100, 1, 1, 0, 1, 1, 'Discarded Doll' FROM DUAL WHERE @EVERLAKE_L622001 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 622001, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O622001 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 622001);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 622001, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O622001 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 138917, 0, 266251, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L622001 = 1;
SET @EVERLAKE_OS622001 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 622001 AND `type` = 3 AND 138917 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 622001)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001057 AND 920001057);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 622001, 0, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001057 AS `guid`, -7915.2 AS `x`, -4496.12 AS `y`, 31.67 AS `z`  -- questie:generated
) s
WHERE @EVERLAKE_OS622001 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS622001 = 1 AND g.`id` = 622001 AND g.`guid` BETWEEN 920001057 AND 920001057;

-- Rotflesh Mushroom (630588, type 3): 95261. 8 spawn(s) from 9 points.
SET @EVERLAKE_NOTE := 'eglink@70938 object_details; spawns questie; drops QuestieDB';
SET @EVERLAKE_O630588 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 630588)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 630588);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 630588, 3, 1847, 'Rotflesh Mushroom', '', '', '', 0.5, 43, 139633, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4099, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O630588 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 630588, 0, 268664, 0 FROM DUAL WHERE @EVERLAKE_O630588 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 630588 AND `Idx` = 0);
SET @EVERLAKE_L630588 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 630588 AND `type` = 3 AND 139633 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 139633);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 139633, 0, 268664, 100, 1, 1, 0, 1, 1, 'Rotflesh Mushroom' FROM DUAL WHERE @EVERLAKE_L630588 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 630588, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O630588 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 630588);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 630588, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O630588 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 139633, 0, 268664, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L630588 = 1;
SET @EVERLAKE_OS630588 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 630588 AND `type` = 3 AND 139633 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 630588)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001058 AND 920001065);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 630588, 0, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001058 AS `guid`, -7342.9 AS `x`, -5553.42 AS `y`, 117.22 AS `z`  -- questie:generated
  UNION ALL SELECT 920001059, -7339.67, -5519.47, 185.43  -- questie:generated
  UNION ALL SELECT 920001060, -7329.97, -5475.82, 118.75  -- questie:generated
  UNION ALL SELECT 920001061, -7310.57, -5558.27, 161.76  -- questie:generated
  UNION ALL SELECT 920001062, -7300.87, -5519.47, 167.18  -- questie:generated
  UNION ALL SELECT 920001063, -7291.17, -5485.52, 156.35  -- questie:generated
  UNION ALL SELECT 920001064, -7278.23, -5534.02, 149.39  -- questie:generated
  UNION ALL SELECT 920001065, -7262.07, -5451.57, 140.15  -- questie:generated
) s
WHERE @EVERLAKE_OS630588 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS630588 = 1 AND g.`id` = 630588 AND g.`guid` BETWEEN 920001058 AND 920001065;

-- Wildflower (648994, type 3): 95975. 35 spawn(s) from 42 points.
SET @EVERLAKE_NOTE := 'eglink@70938 object_details; spawns questie; drops QuestieDB';
SET @EVERLAKE_O648994 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 648994)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 648994);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 648994, 3, 253, 'Wildflower', '', '', '', 1, 4395, 140538, 60000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O648994 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 648994, 0, 271823, 0 FROM DUAL WHERE @EVERLAKE_O648994 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 648994 AND `Idx` = 0);
SET @EVERLAKE_L648994 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 648994 AND `type` = 3 AND 140538 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 140538);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 140538, 0, 271823, 100, 1, 1, 0, 1, 1, 'Wildflower' FROM DUAL WHERE @EVERLAKE_L648994 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 648994, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O648994 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 648994);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 648994, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O648994 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 140538, 0, 271823, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L648994 = 1;
SET @EVERLAKE_OS648994 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 648994 AND `type` = 3 AND 140538 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 648994)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001066 AND 920001100);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 648994, 0, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001066 AS `guid`, -8552.17 AS `x`, -4908.37 AS `y`, 25.47 AS `z`  -- questie:generated
  UNION ALL SELECT 920001067, -8490.73, -4976.27, 24.89  -- questie:generated
  UNION ALL SELECT 920001068, -8490.73, -4966.57, 24.4  -- questie:generated
  UNION ALL SELECT 920001069, -8481.03, -5116.92, 26.91  -- questie:generated
  UNION ALL SELECT 920001070, -8455.17, -5204.22, 32.02  -- questie:generated
  UNION ALL SELECT 920001071, -8439.0, -4782.27, 26.29  -- questie:generated
  UNION ALL SELECT 920001072, -8409.9, -5073.27, 24.39  -- questie:generated
  UNION ALL SELECT 920001073, -8361.4, -5170.27, 30.84  -- questie:generated
  UNION ALL SELECT 920001074, -8361.4, -5160.57, 30.82  -- questie:generated
  UNION ALL SELECT 920001075, -8361.4, -4952.02, 24.7  -- questie:generated
  UNION ALL SELECT 920001076, -8345.23, -5223.62, 28.5  -- questie:generated
  UNION ALL SELECT 920001077, -8342.0, -4888.97, 24.54  -- questie:generated
  UNION ALL SELECT 920001078, -8338.77, -5320.62, 34.51  -- questie:generated
  UNION ALL SELECT 920001079, -8338.77, -4631.92, 24.43  -- questie:generated
  UNION ALL SELECT 920001080, -8335.53, -5301.22, 33.58  -- questie:generated
  UNION ALL SELECT 920001081, -8306.43, -4578.57, 24.81  -- questie:generated
  UNION ALL SELECT 920001082, -8287.03, -4719.22, 24.36  -- questie:generated
  UNION ALL SELECT 920001083, -8277.33, -5005.37, 26.95  -- questie:generated
  UNION ALL SELECT 920001084, -8264.4, -4656.17, 24.5  -- questie:generated
  UNION ALL SELECT 920001085, -8228.83, -5247.87, 35.11  -- questie:generated
  UNION ALL SELECT 920001086, -8209.43, -5262.42, 36.65  -- questie:generated
  UNION ALL SELECT 920001087, -8202.97, -5063.57, 35.93  -- questie:generated
  UNION ALL SELECT 920001088, -8196.5, -4656.17, 25.3  -- questie:generated
  UNION ALL SELECT 920001089, -8180.33, -5170.27, 38.64  -- questie:generated
  UNION ALL SELECT 920001090, -8170.63, -4927.77, 24.68  -- questie:generated
  UNION ALL SELECT 920001091, -8151.23, -4932.62, 24.45  -- questie:generated
  UNION ALL SELECT 920001092, -8141.53, -5272.12, 41.9  -- questie:generated
  UNION ALL SELECT 920001093, -8131.83, -5514.62, 14.02  -- questie:generated
  UNION ALL SELECT 920001094, -8102.73, -5432.17, 38.62  -- questie:generated
  UNION ALL SELECT 920001095, -8099.5, -5306.07, 44.09  -- questie:generated
  UNION ALL SELECT 920001096, -8089.8, -5141.17, 41.64  -- questie:generated
  UNION ALL SELECT 920001097, -7992.8, -5184.82, 43.78  -- questie:generated
  UNION ALL SELECT 920001098, -7954.0, -5150.87, 42.9  -- questie:generated
  UNION ALL SELECT 920001099, -7915.2, -4927.77, 35.6  -- questie:generated
  UNION ALL SELECT 920001100, -7905.5, -5068.42, 41.79  -- questie:generated
) s
WHERE @EVERLAKE_OS648994 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS648994 = 1 AND g.`id` = 648994 AND g.`guid` BETWEEN 920001066 AND 920001100;

-- Rock Pile (649094, type 3): 95183. 8 spawn(s) from 15 points.
SET @EVERLAKE_NOTE := 'eglink@70938 object_details; spawns questie; drops QuestieDB';
SET @EVERLAKE_O649094 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 649094)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 649094);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 649094, 3, 124348, 'Rock Pile', '', '', '', 0.25, 57, 140565, 60000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O649094 = 1;
SET @EVERLAKE_L649094 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 649094 AND `type` = 3 AND 140565 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 140565);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 140565, 0, 271892, 100, 1, 1, 0, 1, 1, 'Rock Pile' FROM DUAL WHERE @EVERLAKE_L649094 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 649094, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O649094 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 649094);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 140565, 0, 271892, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L649094 = 1;
SET @EVERLAKE_OS649094 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 649094 AND `type` = 3 AND 140565 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 649094)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001101 AND 920001108);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 649094, 0, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001101 AS `guid`, -7747.07 AS `x`, -5519.47 AS `y`, 55.19 AS `z`  -- questie:fix
  UNION ALL SELECT 920001102, -7692.1, -5635.87, 57.01  -- questie:generated
  UNION ALL SELECT 920001103, -7591.87, -5441.87, 56.3  -- questie:generated
  UNION ALL SELECT 920001104, -7566.0, -5373.97, 57.2  -- questie:generated
  UNION ALL SELECT 920001105, -7410.8, -5209.07, 63.05  -- questie:fix
  UNION ALL SELECT 920001106, -7404.33, -5146.02, 63.16  -- questie:fix
  UNION ALL SELECT 920001107, -7291.17, -5112.07, 63.76  -- questie:fix
  UNION ALL SELECT 920001108, -7275.0, -5053.87, 63.86  -- questie:fix
) s
WHERE @EVERLAKE_OS649094 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS649094 = 1 AND g.`id` = 649094 AND g.`guid` BETWEEN 920001101 AND 920001108;

-- Stolen Shipment (661518, type 3): 97328. 24 spawn(s) from 37 points.
SET @EVERLAKE_NOTE := 'eglink@70938 object_details; spawns eglink; drops QuestieDB';
SET @EVERLAKE_O661518 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 661518)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 661518);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 661518, 3, 127995, 'Stolen Shipment', '', '', '', 1, 43, 142278, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O661518 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 661518, 0, 277953, 0 FROM DUAL WHERE @EVERLAKE_O661518 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 661518 AND `Idx` = 0);
SET @EVERLAKE_L661518 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 661518 AND `type` = 3 AND 142278 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 142278);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 142278, 0, 277953, 100, 1, 1, 0, 1, 1, 'Stolen Shipment' FROM DUAL WHERE @EVERLAKE_L661518 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 661518, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O661518 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 661518);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 661518, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O661518 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 142278, 0, 277953, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L661518 = 1;
SET @EVERLAKE_OS661518 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 661518 AND `type` = 3 AND 142278 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 661518)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001109 AND 920001132);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 661518, 0, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001109 AS `guid`, -11729.8 AS `x`, 667.6 AS `y`, 49.65 AS `z`  -- eglink:approached
  UNION ALL SELECT 920001110, -11724.0, 626.9, 50.16  -- eglink:approached
  UNION ALL SELECT 920001111, -11722.65, 635.85, 50.41  -- eglink:approached
  UNION ALL SELECT 920001112, -11715.9, 619.2, 50.24  -- eglink:approached
  UNION ALL SELECT 920001113, -11715.6, 609.9, 50.25  -- eglink:approached
  UNION ALL SELECT 920001114, -11711.9, 585.6, 50.04  -- eglink:approached
  UNION ALL SELECT 920001115, -11708.2, 668.85, 50.61  -- eglink:approached
  UNION ALL SELECT 920001116, -11709.6, 580.9, 50.13  -- eglink:approached
  UNION ALL SELECT 920001117, -11705.8, 619.5, 50.45  -- eglink:approached
  UNION ALL SELECT 920001118, -11701.1, 746.3, 49.67  -- eglink:approached
  UNION ALL SELECT 920001119, -11697.25, 754.7, 50.07  -- eglink:approached
  UNION ALL SELECT 920001120, -11686.15, 723.0, 50.67  -- eglink:approached
  UNION ALL SELECT 920001121, -11684.77, 755.07, 50.46  -- eglink:approached
  UNION ALL SELECT 920001122, -11680.4, 708.6, 50.55  -- eglink:approached
  UNION ALL SELECT 920001123, -11680.4, 723.63, 50.72  -- eglink:approached
  UNION ALL SELECT 920001124, -11667.6, 535.8, 45.65  -- eglink:approached
  UNION ALL SELECT 920001125, -11667.4, 553.7, 50.75  -- eglink:approached
  UNION ALL SELECT 920001126, -11676.3, 565.5, 50.7  -- eglink:loot
  UNION ALL SELECT 920001127, -11668.0, 730.8, 50.72  -- eglink:loot
  UNION ALL SELECT 920001128, -11638.7, 776.2, 42.58  -- eglink:loot
  UNION ALL SELECT 920001129, -11623.9, 636.3, 51.36  -- eglink:loot
  UNION ALL SELECT 920001130, -11595.7, 665.4, 60.52  -- eglink:loot
  UNION ALL SELECT 920001131, -11555.1, 558.4, 50.4  -- eglink:loot
  UNION ALL SELECT 920001132, -11545.4, 571.9, 50.67  -- eglink:loot
) s
WHERE @EVERLAKE_OS661518 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS661518 = 1 AND g.`id` = 661518 AND g.`guid` BETWEEN 920001109 AND 920001132;

-- Packaged Tonics (667686, type 3): 92519. 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'eglink@70959 object_details; spawns eglink; drops QuestieDB';
SET @EVERLAKE_O667686 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 667686)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 667686);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 667686, 3, 317, 'Packaged Tonics', '', '', '', 1, 93, 142452, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O667686 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 667686, 0, 278462, 0 FROM DUAL WHERE @EVERLAKE_O667686 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 667686 AND `Idx` = 0);
SET @EVERLAKE_L667686 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 667686 AND `type` = 3 AND 142452 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 142452);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 142452, 0, 278462, 100, 1, 1, 0, 1, 1, 'Packaged Tonics' FROM DUAL WHERE @EVERLAKE_L667686 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 667686, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O667686 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 667686);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 667686, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O667686 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 142452, 0, 278462, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L667686 = 1;
SET @EVERLAKE_OS667686 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 667686 AND `type` = 3 AND 142452 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 667686)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001133 AND 920001133);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 667686, 0, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001133 AS `guid`, -1554.5 AS `x`, -3033.2 AS `y`, 13.65 AS `z`  -- eglink:loot
) s
WHERE @EVERLAKE_OS667686 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS667686 = 1 AND g.`id` = 667686 AND g.`guid` BETWEEN 920001133 AND 920001133;

-- Tremayne Family Blacksmithing Techniques (668295, type 3): 97884. 2 spawn(s) from 4 points.
SET @EVERLAKE_NOTE := 'eglink@70938 object_details; spawns eglink/questie; drops QuestieDB';
SET @EVERLAKE_O668295 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 668295)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 668295);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 668295, 3, 105, 'Tremayne Family Blacksmithing Techniques', '', '', '', 1, 57, 142510, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O668295 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 668295, 0, 278868, 0 FROM DUAL WHERE @EVERLAKE_O668295 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 668295 AND `Idx` = 0);
SET @EVERLAKE_L668295 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 668295 AND `type` = 3 AND 142510 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 142510);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 142510, 0, 278868, 100, 1, 1, 0, 1, 1, 'Tremayne Family Blacksmithing Techniques' FROM DUAL WHERE @EVERLAKE_L668295 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 668295, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O668295 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 668295);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 668295, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O668295 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 142510, 0, 278868, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L668295 = 1;
SET @EVERLAKE_OS668295 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 668295 AND `type` = 3 AND 142510 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 668295)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001134 AND 920001135);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 668295, 0, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001134 AS `guid`, -8080.1 AS `x`, -4166.32 AS `y`, 27.11 AS `z`  -- questie:generated
  UNION ALL SELECT 920001135, -8084.65, -4162.2, 27.49  -- eglink:approached
) s
WHERE @EVERLAKE_OS668295 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS668295 = 1 AND g.`id` = 668295 AND g.`guid` BETWEEN 920001134 AND 920001135;

-- Stolen Freewind Supplies (670338, type 3): 98069. 28 spawn(s) from 56 points.
SET @EVERLAKE_NOTE := 'eglink@70938 object_details; spawns eglink; drops QuestieDB';
SET @EVERLAKE_O670338 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 670338)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 670338);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 670338, 3, 323, 'Stolen Freewind Supplies', '', '', '', 1, 43, 142688, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O670338 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 670338, 0, 279383, 0 FROM DUAL WHERE @EVERLAKE_O670338 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 670338 AND `Idx` = 0);
SET @EVERLAKE_L670338 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 670338 AND `type` = 3 AND 142688 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 142688);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 142688, 0, 279383, 100, 1, 1, 0, 1, 1, 'Stolen Freewind Supplies' FROM DUAL WHERE @EVERLAKE_L670338 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 670338, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O670338 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 670338);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 670338, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O670338 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 142688, 0, 279383, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L670338 = 1;
SET @EVERLAKE_OS670338 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 670338 AND `type` = 3 AND 142688 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 670338)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001136 AND 920001163);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 670338, 1, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001136 AS `guid`, -5616.15 AS `x`, -1604.15 AS `y`, 14.15 AS `z`  -- eglink:approached
  UNION ALL SELECT 920001137, -5613.8, -1608.15, 14.65  -- eglink:approached
  UNION ALL SELECT 920001138, -5607.53, -1583.57, 12.47  -- eglink:approached
  UNION ALL SELECT 920001139, -5604.35, -1580.95, 12.14  -- eglink:approached
  UNION ALL SELECT 920001140, -5601.7, -1610.35, 13.88  -- eglink:approached
  UNION ALL SELECT 920001141, -5595.9, -1583.82, 10.56  -- eglink:approached
  UNION ALL SELECT 920001142, -5591.8, -1618.55, 14.8  -- eglink:approached
  UNION ALL SELECT 920001143, -5588.75, -1621.95, 15.19  -- eglink:approached
  UNION ALL SELECT 920001144, -5578.2, -1628.1, 17.38  -- eglink:approached
  UNION ALL SELECT 920001145, -5557.0, -1633.75, 22.29  -- eglink:approached
  UNION ALL SELECT 920001146, -5547.6, -1628.9, 22.97  -- eglink:approached
  UNION ALL SELECT 920001147, -5538.47, -1609.8, 26.75  -- eglink:approached
  UNION ALL SELECT 920001148, -5528.9, -1596.9, 29.83  -- eglink:approached
  UNION ALL SELECT 920001149, -5512.67, -1577.03, 28.61  -- eglink:approached
  UNION ALL SELECT 920001150, -5465.5, -1647.6, 27.0  -- eglink:approached
  UNION ALL SELECT 920001151, -5452.4, -1674.4, -38.41  -- eglink:approached
  UNION ALL SELECT 920001152, -5446.67, -1663.93, -27.83  -- eglink:approached
  UNION ALL SELECT 920001153, -5437.9, -1654.7, -30.29  -- eglink:approached
  UNION ALL SELECT 920001154, -5434.0, -1670.35, -42.71  -- eglink:approached
  UNION ALL SELECT 920001155, -5421.62, -1669.08, -51.84  -- eglink:approached
  UNION ALL SELECT 920001156, -5422.15, -1674.7, -51.6  -- eglink:approached
  UNION ALL SELECT 920001157, -5421.93, -1660.9, -50.53  -- eglink:approached
  UNION ALL SELECT 920001158, -5415.05, -1647.95, -49.47  -- eglink:approached
  UNION ALL SELECT 920001159, -5414.75, -1660.75, -52.67  -- eglink:approached
  UNION ALL SELECT 920001160, -5410.13, -1644.67, -50.19  -- eglink:approached
  UNION ALL SELECT 920001161, -5403.25, -1652.55, -54.11  -- eglink:approached
  UNION ALL SELECT 920001162, -5398.03, -1649.6, -54.42  -- eglink:approached
  UNION ALL SELECT 920001163, -5509.35, -1570.7, 27.59  -- eglink:loot
) s
WHERE @EVERLAKE_OS670338 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS670338 = 1 AND g.`id` = 670338 AND g.`guid` BETWEEN 920001136 AND 920001163;

-- Relic of the Claw (673093, type 3): 98342, 98396, 98404. 1 spawn(s) from 3 points.
SET @EVERLAKE_NOTE := 'eglink@70790 object_details; spawns polestar; drops QuestieDB';
SET @EVERLAKE_O673093 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 673093)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 673093);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 673093, 3, 404, 'Relic of the Claw', '', '', '', 1.2, 57, 143022, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 161408, 0, 0, 4096, 0, 0, 0, 0, 0, 1309054, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_O673093 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 673093, 0, 280679, 0 FROM DUAL WHERE @EVERLAKE_O673093 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 673093 AND `Idx` = 0);
SET @EVERLAKE_L673093 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 673093 AND `type` = 3 AND 143022 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 143022);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 143022, 0, 280679, 100, 1, 1, 0, 1, 1, 'Relic of the Claw' FROM DUAL WHERE @EVERLAKE_L673093 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 673093, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O673093 = 1 AND EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 673093);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 673093, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_O673093 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 143022, 0, 280679, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_L673093 = 1;
SET @EVERLAKE_OS673093 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 673093 AND `type` = 3 AND 143022 IN (`Data1`, `Data30`))
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 673093)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920001164 AND 920001164);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 673093, 1, 0, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 180, 255, 1, '', NULL, 0
FROM (
  SELECT 920001164 AS `guid`, 7457 AS `x`, -3117 AS `y`, 592.97 AS `z`  -- polestar
) s
WHERE @EVERLAKE_OS673093 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_OS673093 = 1 AND g.`id` = 673093 AND g.`guid` BETWEEN 920001164 AND 920001164;

COMMIT;
