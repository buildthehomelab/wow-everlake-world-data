-- New WoW Forever creatures and objects whose loot is a quest item, so the quests that ask for it can be done.
-- 2026_11_18_926_world_everlake_quest_drop_sources.sql: written from public data by a script, checked by hand.
--
-- The realm's tracker listed quests whose item no one could get: QuestieDB (its Forever item corrections, generated and
-- players' QuestieTrace recordings) names the creature or object that drops it, and the realm had no template for it.
-- This adds 31 creatures and 12 objects where a template source (EG Link's record of the client's own
-- query data: creature_details / object_details, what the live server sent players' games; else DatabaseForever) and a
-- place for it are known.
--
-- Creatures (370 spawns), as slice 5 of the Everlake import (docs/forever-import.md) writes new NPCs:
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
-- 20 of the creatures (262 spawns) have no EG Link record: their name, title, type, family, classification
-- and models come from DatabaseForever (EmuForever, e0b21a2; used by the project's decision of 2026-11-18), the rank
-- from QuestieDB's traces where they record one, levels from QuestieDB's traces. DatabaseForever's faction, levels,
-- speeds, flags and loot for these look generated (faction 14 and level 1 for all, every drop at 100%) and are not
-- used. No player recorded how they react, so their faction is any of the nearby NPCs' that is not friendly to either
-- side's players (a quest item drops from them for both); several came out neutral (7). Not checked in game.
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
-- forever-db from Polestar (GPL-3.0) 74eda09e, spawn points; client CreatureDisplayInfo and FactionTemplate (70790).
-- Guids: creatures 920001000 to 920001461, objects 920001030 to 920001164: a block of their own after file 923's.
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
SET @EVERLAKE_CS213795 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 213795 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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
SET @EVERLAKE_CS222286 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 222286 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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
SET @EVERLAKE_CS255003 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 255003 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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
SET @EVERLAKE_CS256899 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 256899 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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
SET @EVERLAKE_CS260244 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260244 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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
SET @EVERLAKE_CS260973 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260973 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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
SET @EVERLAKE_CS269057 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 269057 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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
SET @EVERLAKE_CS252711 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 252711 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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
SET @EVERLAKE_CS259054 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259054 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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
SET @EVERLAKE_CS259055 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259055 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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
SET @EVERLAKE_CS263307 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 263307 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
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

-- Calefactus the Unleashed (221740): 81919. Faction 49 as Redstone Crystalhide (5991); 1 spawn(s) from 238 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 5991; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C221740 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 221740)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 221740);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 221740, 0, 0, 'Calefactus the Unleashed', NULL, NULL, NULL, NULL, 0, 0, 49, 0, 1.11111, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C221740 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 221740, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 221740, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C221740 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 221740, 0, 118830, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C221740 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 221740, 50, 50 FROM DUAL
WHERE @EVERLAKE_C221740 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 221740);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 221740, 0, 220213, 40, 1, 1, 0, 1, 1, 'Calefactus the Unleashed: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C221740 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 221740 AND `ItemType` = 0 AND `Item` = 220213);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 221740, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C221740 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 221740);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 221740, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C221740 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 221740, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C221740 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 221740, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C221740 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 221740, 0, 220213, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C221740 = 1;
SET @EVERLAKE_CS221740 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 221740 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 221740 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 221740);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 221740, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 720, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001200 AS `guid`, -11455.09 AS `x`, -2874.79 AS `y`, 3.49 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS221740 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS221740 = 1 AND c.`id` = 221740 AND c.`guid` BETWEEN 920001200 AND 920001200;

-- Celegosa (247972): 91685. Faction 60 as Blue Dragonspawn (193); 1 spawn(s) from 42 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 193 (200 yd); spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C247972 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 247972)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 247972);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 247972, 0, 0, 'Celegosa', NULL, NULL, NULL, NULL, 0, 0, 60, 0, 0.88889, 1.14286, 1, 1, 0, 2700, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 2, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C247972 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 247972, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 247972, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C247972 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 247972, 0, 9996, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C247972 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 247972, 54, 54 FROM DUAL
WHERE @EVERLAKE_C247972 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 247972);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 247972, 0, 246938, 40, 1, 1, 0, 1, 1, 'Celegosa: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C247972 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 247972 AND `ItemType` = 0 AND `Item` = 246938);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 247972, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247972 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247972);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 247972, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247972 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 247972, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247972 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 247972, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247972 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 247972, 0, 246938, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247972 = 1;
SET @EVERLAKE_CS247972 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 247972 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 247972 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 247972);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247972, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 600, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001201 AS `guid`, 2635.99 AS `x`, -5332.29 AS `y`, 69.71 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS247972 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS247972 = 1 AND c.`id` = 247972 AND c.`guid` BETWEEN 920001201 AND 920001201;

-- Celastrus the Bitter (249051): 91923. Faction 14 as Hyjal Owl (249053); 1 spawn(s) from 90 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 249053 (200 yd); spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C249051 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 249051)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249051);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 249051, 0, 0, 'Celastrus the Bitter', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 3, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C249051 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 249051, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 249051, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C249051 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 249051, 0, 131805, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C249051 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 249051, 57, 57 FROM DUAL
WHERE @EVERLAKE_C249051 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 249051);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 249051, 0, 282028, 40, 1, 1, 0, 1, 1, 'Celastrus the Bitter: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C249051 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 249051 AND `ItemType` = 0 AND `Item` = 282028);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 249051, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249051 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249051);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 249051, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249051 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 249051, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249051 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 249051, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249051 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 249051, 0, 282028, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249051 = 1;
SET @EVERLAKE_CS249051 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249051 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 249051 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 249051);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 249051, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 600, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001202 AS `guid`, 4602.95 AS `x`, -3204.97 AS `y`, 1034.01 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS249051 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS249051 = 1 AND c.`id` = 249051 AND c.`guid` BETWEEN 920001202 AND 920001202;

-- Head Scratcher (251199): 92446. Faction 14 as Hyjal Owl (249053); 1 spawn(s) from 50 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 249053 (200 yd); spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C251199 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 251199)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 251199);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 251199, 0, 0, 'Head Scratcher', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 4, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C251199 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 251199, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 251199, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C251199 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 251199, 0, 136876, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C251199 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 251199, 60, 60 FROM DUAL
WHERE @EVERLAKE_C251199 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 251199);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 251199, 0, 251781, 40, 1, 1, 0, 1, 1, 'Head Scratcher: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C251199 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 251199 AND `ItemType` = 0 AND `Item` = 251781);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 251199, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C251199 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 251199);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 251199, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C251199 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 251199, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C251199 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 251199, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C251199 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 251199, 0, 251781, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C251199 = 1;
SET @EVERLAKE_CS251199 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 251199 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 251199 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 251199);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 251199, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 600, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001203 AS `guid`, 4660.81 AS `x`, -2141.91 AS `y`, 1148.7 AS `z`  -- questie:generated
) s
WHERE @EVERLAKE_CS251199 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS251199 = 1 AND c.`id` = 251199 AND c.`guid` BETWEEN 920001203 AND 920001203;

-- Tyaeha Darkoath (260444): 95378. Faction 14 as Ashen Acolyte (260422); 1 spawn(s) from 22 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 260422 (200 yd); spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C260444 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 260444)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260444);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 260444, 0, 0, 'Tyaeha Darkoath', NULL, 'Master of Diseases', NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C260444 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 260444, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 260444, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C260444 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 260444, 0, 142443, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C260444 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 260444, 58, 58 FROM DUAL
WHERE @EVERLAKE_C260444 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 260444);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 260444, 0, 273291, 40, 1, 1, 0, 1, 1, 'Tyaeha Darkoath: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C260444 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 260444 AND `ItemType` = 0 AND `Item` = 273291);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 260444, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260444 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 260444);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 260444, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260444 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260444, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260444 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 260444, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260444 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 260444, 0, 273291, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260444 = 1;
SET @EVERLAKE_CS260444 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260444 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260444 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260444);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260444, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001204 AS `guid`, 4715.2 AS `x`, -2551.71 AS `y`, 1155.41 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS260444 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS260444 = 1 AND c.`id` = 260444 AND c.`guid` BETWEEN 920001204 AND 920001204;

-- Zarrat Wormwing (260826): 91883, 92147. Faction 7 as Highfeather Maverick (264473); 1 spawn(s) from 66 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 264473 (200 yd); spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C260826 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 260826)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260826);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 260826, 0, 0, 'Zarrat Wormwing', NULL, NULL, NULL, NULL, 0, 0, 7, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C260826 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 260826, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 260826, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C260826 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 260826, 0, 3218, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C260826 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 260826, 59, 59 FROM DUAL
WHERE @EVERLAKE_C260826 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 260826);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 260826, 0, 268997, 40, 1, 1, 0, 1, 1, 'Zarrat Wormwing: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C260826 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 260826 AND `ItemType` = 0 AND `Item` = 268997)
UNION ALL SELECT 260826, 0, 268998, 40, 1, 1, 0, 1, 1, 'Zarrat Wormwing: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C260826 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 260826 AND `ItemType` = 0 AND `Item` = 268998);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 260826, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260826 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 260826);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 260826, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260826 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260826, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260826 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 260826, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260826 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 260826, 0, 268997, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260826 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 260826, 0, 268998, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260826 = 1;
SET @EVERLAKE_CS260826 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260826 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260826 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260826);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260826, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001205 AS `guid`, 4966.34 AS `x`, -2704.87 AS `y`, 1428.59 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS260826 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS260826 = 1 AND c.`id` = 260826 AND c.`guid` BETWEEN 920001205 AND 920001205;

-- Barton (266357): 96781. Faction 87 as Syndicate Spy (2242); 1 spawn(s) from 49 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 2242; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C266357 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 266357)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 266357);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 266357, 0, 0, 'Barton', NULL, NULL, NULL, NULL, 0, 0, 87, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C266357 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 266357, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 266357, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C266357 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 266357, 0, 144792, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C266357 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 266357, 36, 36 FROM DUAL
WHERE @EVERLAKE_C266357 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 266357);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 266357, 0, 275482, 40, 1, 1, 0, 1, 1, 'Barton: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C266357 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 266357 AND `ItemType` = 0 AND `Item` = 275482);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 266357, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C266357 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 266357);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 266357, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C266357 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 266357, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C266357 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 266357, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C266357 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 266357, 0, 275482, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C266357 = 1;
SET @EVERLAKE_CS266357 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 266357 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 266357 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 266357);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 266357, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001206 AS `guid`, 642.64 AS `x`, -979.27 AS `y`, 165.24 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS266357 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS266357 = 1 AND c.`id` = 266357 AND c.`guid` BETWEEN 920001206 AND 920001206;

-- Hailspite (269213): 97490. Faction 16 as Shardtooth Mauler (7443); 1 spawn(s) from 37 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 7443; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C269213 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 269213)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 269213);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 269213, 0, 0, 'Hailspite', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 5, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C269213 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 269213, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 269213, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C269213 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 269213, 0, 10317, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C269213 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 269213, 60, 60 FROM DUAL
WHERE @EVERLAKE_C269213 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 269213);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 269213, 0, 278091, 40, 1, 1, 0, 1, 1, 'Hailspite: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C269213 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 269213 AND `ItemType` = 0 AND `Item` = 278091);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 269213, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269213 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 269213);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 269213, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269213 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 269213, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269213 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 269213, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269213 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 269213, 0, 278091, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C269213 = 1;
SET @EVERLAKE_CS269213 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 269213 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 269213 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 269213);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 269213, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 600, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001207 AS `guid`, 5912.49 AS `x`, -5023.97 AS `y`, 832.97 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS269213 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS269213 = 1 AND c.`id` = 269213 AND c.`guid` BETWEEN 920001207 AND 920001207;

-- Witch Doctor Ti'ik (270772): 98203. Faction 14 as Vicious Owlbeast (2927); 1 spawn(s) from 9 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 2927; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C270772 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 270772)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 270772);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 270772, 0, 0, 'Witch Doctor Ti''ik', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C270772 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 270772, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 270772, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C270772 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 270772, 0, 146443, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C270772 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 270772, 49, 49 FROM DUAL
WHERE @EVERLAKE_C270772 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 270772);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 270772, 0, 279913, 40, 1, 1, 0, 1, 1, 'Witch Doctor Ti''ik: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C270772 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 270772 AND `ItemType` = 0 AND `Item` = 279913);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 270772, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270772 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 270772);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 270772, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270772 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 270772, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270772 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 270772, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270772 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 270772, 0, 279913, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270772 = 1;
SET @EVERLAKE_CS270772 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 270772 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 270772 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 270772);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 270772, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001208 AS `guid`, -221.69 AS `x`, -2567.91 AS `y`, 119.84 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS270772 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS270772 = 1 AND c.`id` = 270772 AND c.`guid` BETWEEN 920001208 AND 920001208;

-- Honey Wasp (236028): 89013, 91608. Faction 14 as Thunderhead Hippogryph (6375); 46 spawn(s) from 79 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 6375; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C236028 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 236028)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236028);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 236028, 0, 0, 'Honey Wasp', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1.2, 1.42857, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C236028 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 236028, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 236028, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C236028 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 236028, 0, 13095, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C236028 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 236028, 47, 49 FROM DUAL
WHERE @EVERLAKE_C236028 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 236028);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 236028, 0, 238503, 40, 1, 1, 0, 1, 1, 'Honey Wasp: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C236028 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 236028 AND `ItemType` = 0 AND `Item` = 238503);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 236028, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236028 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 236028);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 236028, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236028 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 236028, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236028 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 236028, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236028 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 236028, 0, 238503, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236028 = 1;
SET @EVERLAKE_CS236028 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236028 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 236028 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 236028);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 236028, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001209 AS `guid`, 3299.05 AS `x`, -4194.4 AS `y`, 108.63 AS `z`  -- questie:trace
  UNION ALL SELECT 920001210, 3309.2, -4154.84, 103.58  -- questie:trace
  UNION ALL SELECT 920001211, 3312.92, -4228.37, 108.27  -- questie:trace
  UNION ALL SELECT 920001212, 3350.45, -4250.68, 109.66  -- questie:trace
  UNION ALL SELECT 920001213, 3355.18, -4401.29, 105.39  -- questie:trace
  UNION ALL SELECT 920001214, 3356.87, -4285.16, 100.28  -- questie:trace
  UNION ALL SELECT 920001215, 3360.25, -4177.16, 102.19  -- questie:trace
  UNION ALL SELECT 920001216, 3372.09, -4212.14, 106.8  -- questie:trace
  UNION ALL SELECT 920001217, 3390.35, -4374.92, 118.68  -- questie:trace
  UNION ALL SELECT 920001218, 3391.7, -4466.19, 107.31  -- questie:trace
  UNION ALL SELECT 920001219, 3392.38, -4252.71, 107.68  -- questie:trace
  UNION ALL SELECT 920001220, 3411.31, -4179.69, 101.7  -- questie:trace
  UNION ALL SELECT 920001221, 3423.82, -4459.09, 123.26  -- questie:trace
  UNION ALL SELECT 920001222, 3431.26, -4286.18, 97.45  -- questie:trace
  UNION ALL SELECT 920001223, 3431.94, -4219.75, 97.85  -- questie:trace
  UNION ALL SELECT 920001224, 3433.29, -4422.08, 123.32  -- questie:trace
  UNION ALL SELECT 920001225, 3435.32, -4333.34, 102.42  -- questie:trace
  UNION ALL SELECT 920001226, 3448.5, -4252.2, 97.18  -- questie:trace
  UNION ALL SELECT 920001227, 3464.73, -4182.73, 99.44  -- questie:trace
  UNION ALL SELECT 920001228, 3467.1, -4145.21, 118.54  -- questie:trace
  UNION ALL SELECT 920001229, 3470.48, -4308.49, 109.66  -- questie:trace
  UNION ALL SELECT 920001230, 3482.66, -4418.53, 119.45  -- questie:trace
  UNION ALL SELECT 920001231, 3500.58, -4380.5, 118.78  -- questie:trace
  UNION ALL SELECT 920001232, 3507.68, -4277.56, 97.75  -- questie:trace
  UNION ALL SELECT 920001233, 3508.01, -4081.32, 96.39  -- questie:trace
  UNION ALL SELECT 920001234, 3518.5, -4165.49, 105.02  -- questie:trace
  UNION ALL SELECT 920001235, 3519.17, -4205.05, 101.91  -- questie:trace
  UNION ALL SELECT 920001236, 3525.6, -4133.55, 107.27  -- questie:trace
  UNION ALL SELECT 920001237, 3525.94, -4321.17, 116.02  -- questie:trace
  UNION ALL SELECT 920001238, 3542.17, -4365.28, 115.36  -- questie:trace
  UNION ALL SELECT 920001239, 3554.34, -4224.31, 104.92  -- questie:trace
  UNION ALL SELECT 920001240, 3575.64, -4312.55, 99.79  -- questie:trace
  UNION ALL SELECT 920001241, 3580.71, -4175.13, 98.53  -- questie:trace
  UNION ALL SELECT 920001242, 3588.83, -4221.78, 100.46  -- questie:trace
  UNION ALL SELECT 920001243, 3589.5, -4134.56, 104.24  -- questie:trace
  UNION ALL SELECT 920001244, 3602.01, -4370.35, 111.53  -- questie:trace
  UNION ALL SELECT 920001245, 3602.69, -4090.95, 102.18  -- questie:trace
  UNION ALL SELECT 920001246, 3602.69, -4053.93, 100.89  -- questie:trace
  UNION ALL SELECT 920001247, 3620.61, -4320.66, 103.44  -- questie:trace
  UNION ALL SELECT 920001248, 3627.03, -4168.54, 99.55  -- questie:trace
  UNION ALL SELECT 920001249, 3630.75, -4261.33, 108.0  -- questie:trace
  UNION ALL SELECT 920001250, 3630.75, -4118.33, 102.14  -- questie:trace
  UNION ALL SELECT 920001251, 3634.81, -4201.5, 110.24  -- questie:trace
  UNION ALL SELECT 920001252, 3646.31, -4349.06, 107.42  -- questie:trace
  UNION ALL SELECT 920001253, 3676.4, -4247.13, 121.79  -- questie:trace
  UNION ALL SELECT 920001254, 3678.43, -4159.41, 121.51  -- questie:trace
) s
WHERE @EVERLAKE_CS236028 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS236028 = 1 AND c.`id` = 236028 AND c.`guid` BETWEEN 920001209 AND 920001254;

-- Makrinni Burrower (247470): 91568. Faction 74 as Spitelash Siren (6195); 34 spawn(s) from 73 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 6195; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C247470 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 247470)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 247470);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 247470, 0, 0, 'Makrinni Burrower', NULL, NULL, NULL, NULL, 0, 0, 74, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C247470 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 247470, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 247470, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C247470 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 247470, 0, 11371, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C247470 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 247470, 50, 51 FROM DUAL
WHERE @EVERLAKE_C247470 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 247470);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 247470, 0, 246684, 40, 1, 1, 0, 1, 1, 'Makrinni Burrower: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C247470 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 247470 AND `ItemType` = 0 AND `Item` = 246684);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 247470, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247470 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247470);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 247470, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247470 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 247470, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247470 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 247470, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247470 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 247470, 0, 246684, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247470 = 1;
SET @EVERLAKE_CS247470 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 247470 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 247470 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 247470);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247470, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001255 AS `guid`, 3153.66 AS `x`, -5681.17 AS `y`, 27.62 AS `z`  -- questie:trace
  UNION ALL SELECT 920001256, 3154.67, -5776.5, 10.19  -- questie:trace
  UNION ALL SELECT 920001257, 3213.17, -5610.17, 31.44  -- questie:trace
  UNION ALL SELECT 920001258, 3228.39, -5549.83, 45.31  -- questie:trace
  UNION ALL SELECT 920001259, 3285.19, -5724.27, -6.61  -- questie:trace
  UNION ALL SELECT 920001260, 3323.06, -5618.79, 11.76  -- questie:trace
  UNION ALL SELECT 920001261, 3346.39, -5688.77, 8.26  -- questie:trace
  UNION ALL SELECT 920001262, 3384.26, -5516.87, 20.37  -- questie:trace
  UNION ALL SELECT 920001263, 3417.4, -5687.76, 7.58  -- questie:trace
  UNION ALL SELECT 920001264, 3420.1, -5640.09, 7.25  -- questie:trace
  UNION ALL SELECT 920001265, 3441.74, -5513.83, 21.9  -- questie:trace
  UNION ALL SELECT 920001266, 3476.23, -5609.16, 9.8  -- questie:trace
  UNION ALL SELECT 920001267, 3486.37, -5680.15, 5.59  -- questie:trace
  UNION ALL SELECT 920001268, 3491.11, -5740.49, 6.01  -- questie:trace
  UNION ALL SELECT 920001269, 3516.81, -5584.82, 13.38  -- questie:trace
  UNION ALL SELECT 920001270, 3518.16, -5648.71, 6.47  -- questie:trace
  UNION ALL SELECT 920001271, 3524.24, -5502.67, 36.75  -- questie:trace
  UNION ALL SELECT 920001272, 3548.25, -5740.49, 1.87  -- questie:trace
  UNION ALL SELECT 920001273, 3573.95, -5615.24, 9.19  -- questie:trace
  UNION ALL SELECT 920001274, 3578.01, -5533.1, 21.22  -- questie:trace
  UNION ALL SELECT 920001275, 3581.05, -5682.18, 3.19  -- questie:trace
  UNION ALL SELECT 920001276, 3610.13, -5582.28, 14.73  -- questie:trace
  UNION ALL SELECT 920001277, 3617.91, -5711.08, -3.95  -- questie:trace
  UNION ALL SELECT 920001278, 3665.58, -5651.75, 9.44  -- questie:trace
  UNION ALL SELECT 920001279, 3670.31, -5552.37, 16.9  -- questie:trace
  UNION ALL SELECT 920001280, 3714.95, -5709.05, 6.93  -- questie:trace
  UNION ALL SELECT 920001281, 3742.34, -5551.86, 16.05  -- questie:trace
  UNION ALL SELECT 920001282, 3782.57, -5723.76, -0.1  -- questie:trace
  UNION ALL SELECT 920001283, 3800.15, -5658.85, 4.59  -- questie:trace
  UNION ALL SELECT 920001284, 3805.9, -5587.86, 11.64  -- questie:trace
  UNION ALL SELECT 920001285, 3831.26, -5757.73, 10.22  -- questie:trace
  UNION ALL SELECT 920001286, 3856.28, -5661.9, 13.86  -- questie:trace
  UNION ALL SELECT 920001287, 3890.1, -5625.89, 20.94  -- questie:trace
  UNION ALL SELECT 920001288, 3909.37, -5673.56, 20.76  -- questie:trace
) s
WHERE @EVERLAKE_CS247470 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS247470 = 1 AND c.`id` = 247470 AND c.`guid` BETWEEN 920001255 AND 920001288;

-- Tainted Shrubbery (248395): 91755. Faction 7 as Battlescarred Steelbeak (249974); 9 spawn(s) from 195 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 249974; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C248395 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 248395)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 248395);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 248395, 0, 0, 'Tainted Shrubbery', NULL, NULL, NULL, NULL, 0, 0, 7, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C248395 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 248395, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 248395, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C248395 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 248395, 0, 8151, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C248395 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 248395, 55, 56 FROM DUAL
WHERE @EVERLAKE_C248395 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 248395);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 248395, 0, 247892, 40, 1, 1, 0, 1, 1, 'Tainted Shrubbery: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C248395 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 248395 AND `ItemType` = 0 AND `Item` = 247892);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 248395, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C248395 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 248395);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 248395, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C248395 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 248395, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C248395 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 248395, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C248395 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 248395, 0, 247892, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C248395 = 1;
SET @EVERLAKE_CS248395 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 248395 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 248395 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 248395);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 248395, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001289 AS `guid`, 4338.62 AS `x`, -2960.48 AS `y`, 1061.74 AS `z`  -- questie:trace
  UNION ALL SELECT 920001290, 4479.35, -3418.55, 1003.19  -- questie:trace
  UNION ALL SELECT 920001291, 4509.9, -2919.84, 1073.15  -- questie:trace
  UNION ALL SELECT 920001292, 4543.23, -3582.13, 978.95  -- questie:trace
  UNION ALL SELECT 920001293, 4584.66, -3196.98, 1034.43  -- questie:trace
  UNION ALL SELECT 920001294, 4641.37, -3407.79, 1017.34  -- questie:trace
  UNION ALL SELECT 920001295, 4649.01, -3038.27, 1067.28  -- questie:trace
  UNION ALL SELECT 920001296, 4741.13, -3275.12, 1058.86  -- questie:trace
  UNION ALL SELECT 920001297, 4811.26, -3020.91, 1174.36  -- questie:trace
) s
WHERE @EVERLAKE_CS248395 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS248395 = 1 AND c.`id` = 248395 AND c.`guid` BETWEEN 920001289 AND 920001297;

-- Wormwing Harpy (249220): 92147. Faction 7 as Highfeather Maverick (264473); 4 spawn(s) from 112 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 264473; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C249220 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 249220)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249220);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 249220, 0, 0, 'Wormwing Harpy', NULL, NULL, NULL, NULL, 0, 0, 7, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C249220 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 249220, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 249220, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C249220 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 249220, 0, 10872, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C249220 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 249220, 57, 58 FROM DUAL
WHERE @EVERLAKE_C249220 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 249220);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 249220, 0, 268997, 40, 1, 1, 0, 1, 1, 'Wormwing Harpy: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C249220 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 249220 AND `ItemType` = 0 AND `Item` = 268997);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 249220, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249220 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249220);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 249220, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249220 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 249220, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249220 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 249220, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249220 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 249220, 0, 268997, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249220 = 1;
SET @EVERLAKE_CS249220 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249220 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 249220 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 249220);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 249220, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001298 AS `guid`, 4830.7 AS `x`, -2809.06 AS `y`, 1449.97 AS `z`  -- questie:trace
  UNION ALL SELECT 920001299, 4908.24, -2551.71, 1447.34  -- questie:trace
  UNION ALL SELECT 920001300, 4970.27, -2721.89, 1428.51  -- questie:trace
  UNION ALL SELECT 920001301, 5056.37, -2479.48, 1434.53  -- questie:trace
) s
WHERE @EVERLAKE_CS249220 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS249220 = 1 AND c.`id` = 249220 AND c.`guid` BETWEEN 920001298 AND 920001301;

-- Wormwing Windwitch (249221): 92147. Faction 7 as Highfeather Maverick (264473); 4 spawn(s) from 98 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 264473; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C249221 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 249221)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249221);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 249221, 0, 0, 'Wormwing Windwitch', NULL, NULL, NULL, NULL, 0, 0, 7, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C249221 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 249221, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 249221, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C249221 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 249221, 0, 10282, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C249221 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 249221, 57, 59 FROM DUAL
WHERE @EVERLAKE_C249221 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 249221);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 249221, 0, 268997, 40, 1, 1, 0, 1, 1, 'Wormwing Windwitch: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C249221 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 249221 AND `ItemType` = 0 AND `Item` = 268997);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 249221, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249221 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249221);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 249221, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249221 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 249221, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249221 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 249221, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249221 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 249221, 0, 268997, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249221 = 1;
SET @EVERLAKE_CS249221 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249221 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 249221 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 249221);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 249221, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001302 AS `guid`, 5071.5 AS `x`, -2460 AS `y`, 1434.56 AS `z`  -- polestar
  UNION ALL SELECT 920001303, 4825.15, -2811.14, 1450.07  -- questie:trace
  UNION ALL SELECT 920001304, 4925.6, -2651.04, 1428.08  -- questie:trace
  UNION ALL SELECT 920001305, 4978.84, -2863.58, 1453.14  -- questie:trace
) s
WHERE @EVERLAKE_CS249221 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS249221 = 1 AND c.`id` = 249221 AND c.`guid` BETWEEN 920001302 AND 920001305;

-- Wormwing Ambusher (249222): 92147. Faction 7 as Highfeather Maverick (264473); 4 spawn(s) from 96 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 264473; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C249222 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 249222)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249222);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 249222, 0, 0, 'Wormwing Ambusher', NULL, NULL, NULL, NULL, 0, 0, 7, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C249222 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 249222, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 249222, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C249222 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 249222, 0, 10282, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C249222 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 249222, 57, 58 FROM DUAL
WHERE @EVERLAKE_C249222 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 249222);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 249222, 0, 268997, 40, 1, 1, 0, 1, 1, 'Wormwing Ambusher: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C249222 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 249222 AND `ItemType` = 0 AND `Item` = 268997);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 249222, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249222 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249222);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 249222, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249222 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 249222, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249222 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 249222, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249222 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 249222, 0, 268997, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249222 = 1;
SET @EVERLAKE_CS249222 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249222 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 249222 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 249222);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 249222, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001306 AS `guid`, 4834.64 AS `x`, -2801.42 AS `y`, 1447.84 AS `z`  -- questie:trace
  UNION ALL SELECT 920001307, 4908.47, -2558.31, 1447.48  -- questie:trace
  UNION ALL SELECT 920001308, 4984.16, -2719.11, 1428.09  -- questie:trace
  UNION ALL SELECT 920001309, 5060.77, -2480.17, 1434.6  -- questie:trace
) s
WHERE @EVERLAKE_CS249222 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS249222 = 1 AND c.`id` = 249222 AND c.`guid` BETWEEN 920001306 AND 920001309;

-- Wormwing Fledgling (249223): 92147. Faction 7 as Highfeather Maverick (264473); 3 spawn(s) from 67 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 264473; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C249223 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 249223)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249223);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 249223, 0, 0, 'Wormwing Fledgling', NULL, NULL, NULL, NULL, 0, 0, 7, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C249223 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 249223, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 249223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C249223 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 249223, 0, 3022, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C249223 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 249223, 55, 56 FROM DUAL
WHERE @EVERLAKE_C249223 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 249223);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 249223, 0, 268997, 40, 1, 1, 0, 1, 1, 'Wormwing Fledgling: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C249223 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 249223 AND `ItemType` = 0 AND `Item` = 268997);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 249223, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249223 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249223);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 249223, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249223 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 249223, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249223 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 249223, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249223 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 249223, 0, 268997, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249223 = 1;
SET @EVERLAKE_CS249223 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249223 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 249223 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 249223);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 249223, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001310 AS `guid`, 4841.81 AS `x`, -2795.86 AS `y`, 1446.99 AS `z`  -- questie:trace
  UNION ALL SELECT 920001311, 4949.67, -2561.09, 1428.82  -- questie:trace
  UNION ALL SELECT 920001312, 4995.27, -2723.62, 1429.02  -- questie:trace
) s
WHERE @EVERLAKE_CS249223 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS249223 = 1 AND c.`id` = 249223 AND c.`guid` BETWEEN 920001310 AND 920001312;

-- Eternal Sentry (249237): 90865. Faction 14 as Forgotten Soldier (249247); 22 spawn(s) from 107 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 249247; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C249237 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 249237)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249237);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 249237, 0, 0, 'Eternal Sentry', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 6, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C249237 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 249237, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 249237, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C249237 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 249237, 0, 7855, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C249237 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 249237, 57, 58 FROM DUAL
WHERE @EVERLAKE_C249237 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 249237);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 249237, 0, 273322, 40, 1, 1, 0, 1, 1, 'Eternal Sentry: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C249237 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 249237 AND `ItemType` = 0 AND `Item` = 273322);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 249237, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249237 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249237);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 249237, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249237 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 249237, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249237 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 249237, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249237 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 249237, 0, 273322, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249237 = 1;
SET @EVERLAKE_CS249237 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249237 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 249237 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 249237);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 249237, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001313 AS `guid`, 4855.24 AS `x`, -1850.19 AS `y`, 1300.99 AS `z`  -- questie:generated
  UNION ALL SELECT 920001314, 4977.91, -1825.87, 1320.66  -- questie:generated
  UNION ALL SELECT 920001315, 4987.17, -1877.97, 1326.15  -- questie:generated
  UNION ALL SELECT 920001316, 5045.03, -1815.46, 1323.03  -- questie:generated
  UNION ALL SELECT 920001317, 5061.23, -1693.9, 1322.94  -- questie:generated
  UNION ALL SELECT 920001318, 5063.55, -1756.42, 1321.64  -- questie:generated
  UNION ALL SELECT 920001319, 5100.58, -1777.25, 1323.98  -- questie:generated
  UNION ALL SELECT 920001320, 5109.84, -1818.93, 1332.75  -- questie:generated
  UNION ALL SELECT 920001321, 5119.1, -1735.58, 1333.74  -- questie:generated
  UNION ALL SELECT 920001322, 5130.67, -1697.38, 1336.95  -- questie:generated
  UNION ALL SELECT 920001323, 5174.65, -1714.74, 1337.54  -- questie:generated
  UNION ALL SELECT 920001324, 5241.77, -1714.74, 1357.43  -- questie:generated
  UNION ALL SELECT 920001325, 4898.75, -1883.18, 1317.07  -- questie:trace
  UNION ALL SELECT 920001326, 4911.48, -1838.72, 1324.13  -- questie:trace
  UNION ALL SELECT 920001327, 4941.8, -1647.02, 1324.89  -- questie:trace
  UNION ALL SELECT 920001328, 4983.23, -1644.59, 1352.22  -- questie:trace
  UNION ALL SELECT 920001329, 4991.57, -1772.39, 1332.27  -- questie:trace
  UNION ALL SELECT 920001330, 5001.06, -1712.66, 1331.92  -- questie:trace
  UNION ALL SELECT 920001331, 5055.45, -1865.12, 1336.11  -- questie:trace
  UNION ALL SELECT 920001332, 5096.65, -1878.32, 1353.07  -- questie:trace
  UNION ALL SELECT 920001333, 5147.34, -1767.88, 1337.15  -- questie:trace
  UNION ALL SELECT 920001334, 5207.05, -1738.7, 1341.84  -- questie:trace
) s
WHERE @EVERLAKE_CS249237 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS249237 = 1 AND c.`id` = 249237 AND c.`guid` BETWEEN 920001313 AND 920001334;

-- Mountain Squallclimber (249491): 92017. Faction 7 as Hyjal Stag (248041); 110 spawn(s) from 326 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 248041; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C249491 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 249491)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249491);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 249491, 0, 0, 'Mountain Squallclimber', NULL, NULL, NULL, NULL, 0, 0, 7, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C249491 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 249491, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 249491, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C249491 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 249491, 0, 10893, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C249491 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 249491, 58, 59 FROM DUAL
WHERE @EVERLAKE_C249491 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 249491);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 249491, 0, 274287, 40, 1, 1, 0, 1, 1, 'Mountain Squallclimber: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C249491 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 249491 AND `ItemType` = 0 AND `Item` = 274287);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 249491, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249491 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249491);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 249491, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249491 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 249491, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249491 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 249491, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249491 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 249491, 0, 274287, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249491 = 1;
SET @EVERLAKE_CS249491 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249491 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 249491 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 249491);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 249491, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001335 AS `guid`, 4242.8 AS `x`, -2483.99 AS `y`, 1158.57 AS `z`  -- questie:trace
  UNION ALL SELECT 920001336, 4518.0, -3524.48, 987.92  -- questie:trace
  UNION ALL SELECT 920001337, 4526.8, -1775.86, 1261.64  -- questie:trace
  UNION ALL SELECT 920001338, 4556.89, -3468.56, 999.45  -- questie:trace
  UNION ALL SELECT 920001339, 4563.6, -1736.97, 1271.18  -- questie:trace
  UNION ALL SELECT 920001340, 4612.21, -1715.44, 1275.71  -- questie:trace
  UNION ALL SELECT 920001341, 4698.08, -2225.26, 1173.0  -- questie:trace
  UNION ALL SELECT 920001342, 4707.8, -2158.58, 1198.59  -- questie:trace
  UNION ALL SELECT 920001343, 4722.61, -2098.5, 1215.97  -- questie:trace
  UNION ALL SELECT 920001344, 4736.27, -2198.52, 1197.63  -- questie:trace
  UNION ALL SELECT 920001345, 4744.83, -2261.73, 1191.01  -- questie:trace
  UNION ALL SELECT 920001346, 4749.23, -2150.25, 1212.86  -- questie:trace
  UNION ALL SELECT 920001347, 4807.56, -2809.41, 1444.28  -- questie:trace
  UNION ALL SELECT 920001348, 4831.4, -3212.61, 1153.98  -- questie:trace
  UNION ALL SELECT 920001349, 4855.01, -3276.51, 1169.54  -- questie:trace
  UNION ALL SELECT 920001350, 4862.41, -3326.18, 1176.14  -- questie:trace
  UNION ALL SELECT 920001351, 5033.69, -2504.14, 1432.59  -- questie:trace
  UNION ALL SELECT 920001352, 5034.62, -2164.48, 1386.28  -- questie:trace
  UNION ALL SELECT 920001353, 5042.72, -2111.0, 1373.63  -- questie:trace
  UNION ALL SELECT 920001354, 5046.88, -2260.68, 1400.77  -- questie:trace
  UNION ALL SELECT 920001355, 5066.79, -2464.89, 1435.0  -- questie:trace
  UNION ALL SELECT 920001356, 5077.21, -2172.12, 1382.56  -- questie:trace
  UNION ALL SELECT 920001357, 5078.36, -2090.86, 1370.29  -- questie:trace
  UNION ALL SELECT 920001358, 5085.08, -2244.71, 1391.92  -- questie:trace
  UNION ALL SELECT 920001359, 5093.41, -2421.48, 1429.31  -- questie:trace
  UNION ALL SELECT 920001360, 5093.41, -2299.23, 1401.83  -- questie:trace
  UNION ALL SELECT 920001361, 5101.51, -2354.8, 1414.44  -- questie:trace
  UNION ALL SELECT 920001362, 5112.39, -2046.4, 1366.15  -- questie:trace
  UNION ALL SELECT 920001363, 5136.0, -3383.48, 1632.0  -- questie:trace
  UNION ALL SELECT 920001364, 5138.08, -3448.42, 1624.1  -- questie:trace
  UNION ALL SELECT 920001365, 5140.39, -2374.94, 1419.17  -- questie:trace
  UNION ALL SELECT 920001366, 5161.69, -3352.57, 1629.53  -- questie:trace
  UNION ALL SELECT 920001367, 5162.61, -3413.69, 1618.51  -- questie:trace
  UNION ALL SELECT 920001368, 5163.31, -3650.55, 1665.91  -- questie:trace
  UNION ALL SELECT 920001369, 5184.14, -2388.14, 1427.04  -- questie:trace
  UNION ALL SELECT 920001370, 5188.07, -3321.66, 1643.72  -- questie:trace
  UNION ALL SELECT 920001371, 5196.64, -3628.32, 1618.51  -- questie:trace
  UNION ALL SELECT 920001372, 5198.03, -1932.84, 1367.36  -- questie:trace
  UNION ALL SELECT 920001373, 5201.04, -3451.89, 1604.77  -- questie:trace
  UNION ALL SELECT 920001374, 5201.73, -3369.24, 1637.38  -- questie:trace
  UNION ALL SELECT 920001375, 5215.39, -3589.42, 1612.55  -- questie:trace
  UNION ALL SELECT 920001376, 5216.08, -3516.49, 1599.35  -- questie:trace
  UNION ALL SELECT 920001377, 5234.13, -3345.62, 1645.43  -- questie:trace
  UNION ALL SELECT 920001378, 5235.52, -3719.31, 1626.75  -- questie:trace
  UNION ALL SELECT 920001379, 5251.73, -3618.59, 1593.45  -- questie:trace
  UNION ALL SELECT 920001380, 5252.65, -3543.23, 1594.12  -- questie:trace
  UNION ALL SELECT 920001381, 5262.84, -3758.21, 1625.84  -- questie:trace
  UNION ALL SELECT 920001382, 5263.76, -3683.89, 1593.61  -- questie:trace
  UNION ALL SELECT 920001383, 5274.87, -3316.45, 1657.07  -- questie:trace
  UNION ALL SELECT 920001384, 5278.34, -3579.7, 1593.89  -- questie:trace
  UNION ALL SELECT 920001385, 5279.04, -2622.21, 1502.15  -- questie:trace
  UNION ALL SELECT 920001386, 5291.54, -3511.63, 1589.84  -- questie:trace
  UNION ALL SELECT 920001387, 5293.62, -2560.4, 1506.18  -- questie:trace
  UNION ALL SELECT 920001388, 5295.47, -3788.07, 1651.67  -- questie:trace
  UNION ALL SELECT 920001389, 5304.73, -3347.36, 1655.39  -- questie:trace
  UNION ALL SELECT 920001390, 5304.96, -3697.43, 1594.65  -- questie:trace
  UNION ALL SELECT 920001391, 5323.01, -2618.39, 1493.32  -- questie:trace
  UNION ALL SELECT 920001392, 5324.87, -3737.02, 1611.88  -- questie:trace
  UNION ALL SELECT 920001393, 5329.96, -3563.03, 1578.66  -- questie:trace
  UNION ALL SELECT 920001394, 5340.61, -3787.73, 1633.45  -- questie:trace
  UNION ALL SELECT 920001395, 5341.07, -3479.33, 1572.97  -- questie:trace
  UNION ALL SELECT 920001396, 5341.53, -3365.77, 1656.03  -- questie:trace
  UNION ALL SELECT 920001397, 5348.24, -3668.26, 1592.02  -- questie:trace
  UNION ALL SELECT 920001398, 5368.61, -3436.27, 1576.36  -- questie:trace
  UNION ALL SELECT 920001399, 5379.95, -3756.47, 1611.01  -- questie:trace
  UNION ALL SELECT 920001400, 5380.42, -3498.08, 1560.15  -- questie:trace
  UNION ALL SELECT 920001401, 5383.42, -3358.47, 1656.22  -- questie:trace
  UNION ALL SELECT 920001402, 5390.14, -3670.69, 1593.29  -- questie:trace
  UNION ALL SELECT 920001403, 5398.24, -3534.55, 1562.23  -- questie:trace
  UNION ALL SELECT 920001404, 5410.51, -3808.22, 1612.49  -- questie:trace
  UNION ALL SELECT 920001405, 5416.29, -3446.69, 1559.2  -- questie:trace
  UNION ALL SELECT 920001406, 5419.07, -3712.36, 1593.47  -- questie:trace
  UNION ALL SELECT 920001407, 5419.76, -3629.01, 1561.8  -- questie:trace
  UNION ALL SELECT 920001408, 5430.64, -2338.48, 1510.77  -- questie:trace
  UNION ALL SELECT 920001409, 5448.93, -3672.77, 1587.77  -- questie:trace
  UNION ALL SELECT 920001410, 5452.86, -3825.23, 1613.75  -- questie:trace
  UNION ALL SELECT 920001411, 5460.04, -3613.73, 1566.35  -- questie:trace
  UNION ALL SELECT 920001412, 5486.89, -2365.22, 1461.74  -- questie:trace
  UNION ALL SELECT 920001413, 5502.39, -3732.85, 1593.81  -- questie:trace
  UNION ALL SELECT 920001414, 5513.27, -2430.16, 1468.77  -- questie:trace
  UNION ALL SELECT 920001415, 5528.78, -3690.14, 1594.68  -- questie:trace
  UNION ALL SELECT 920001416, 5543.59, -2390.92, 1472.62  -- questie:trace
  UNION ALL SELECT 920001417, 5551.46, -2329.45, 1495.7  -- questie:trace
  UNION ALL SELECT 920001418, 5551.93, -2463.16, 1474.42  -- questie:trace
  UNION ALL SELECT 920001419, 5553.78, -3737.02, 1598.76  -- questie:trace
  UNION ALL SELECT 920001420, 5558.87, -3630.4, 1588.02  -- questie:trace
  UNION ALL SELECT 920001421, 5560.49, -3476.55, 1568.93  -- questie:trace
  UNION ALL SELECT 920001422, 5575.77, -2428.08, 1474.62  -- questie:trace
  UNION ALL SELECT 920001423, 5583.87, -3548.79, 1576.98  -- questie:trace
  UNION ALL SELECT 920001424, 5590.35, -2488.16, 1484.87  -- questie:trace
  UNION ALL SELECT 920001425, 5591.97, -3606.79, 1585.37  -- questie:trace
  UNION ALL SELECT 920001426, 5597.52, -3437.31, 1578.73  -- questie:trace
  UNION ALL SELECT 920001427, 5601.23, -3497.74, 1579.44  -- questie:trace
  UNION ALL SELECT 920001428, 5616.73, -3805.09, 1625.53  -- questie:trace
  UNION ALL SELECT 920001429, 5627.61, -2464.89, 1511.76  -- questie:trace
  UNION ALL SELECT 920001430, 5628.31, -3560.94, 1594.34  -- questie:trace
  UNION ALL SELECT 920001431, 5637.8, -3452.94, 1585.43  -- questie:trace
  UNION ALL SELECT 920001432, 5651.22, -3511.98, 1587.24  -- questie:trace
  UNION ALL SELECT 920001433, 5663.72, -3367.85, 1588.27  -- questie:trace
  UNION ALL SELECT 920001434, 5682.7, -3432.45, 1590.4  -- questie:trace
  UNION ALL SELECT 920001435, 5686.17, -3475.16, 1588.28  -- questie:trace
  UNION ALL SELECT 920001436, 5690.34, -3521.7, 1611.77  -- questie:trace
  UNION ALL SELECT 920001437, 5712.1, -3317.15, 1593.34  -- questie:trace
  UNION ALL SELECT 920001438, 5719.97, -3391.12, 1593.25  -- questie:trace
  UNION ALL SELECT 920001439, 5727.6, -3450.85, 1594.79  -- questie:trace
  UNION ALL SELECT 920001440, 5757.23, -3323.4, 1610.68  -- questie:trace
  UNION ALL SELECT 920001441, 5766.26, -3386.6, 1600.6  -- questie:trace
  UNION ALL SELECT 920001442, 5774.13, -3433.49, 1628.27  -- questie:trace
  UNION ALL SELECT 920001443, 5795.19, -3350.14, 1632.64  -- questie:trace
  UNION ALL SELECT 920001444, 5811.62, -3403.27, 1636.45  -- questie:trace
) s
WHERE @EVERLAKE_CS249491 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS249491 = 1 AND c.`id` = 249491 AND c.`guid` BETWEEN 920001335 AND 920001444;

-- Nascent Undead Ravager (253360): 92873. Faction 133 as Magram Wrangler (4640); 2 spawn(s) from 5 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 4640; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C253360 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 253360)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253360);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 253360, 0, 0, 'Nascent Undead Ravager', NULL, NULL, NULL, NULL, 0, 0, 133, 0, 0.66667, 1.42857, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 6, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C253360 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 253360, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 253360, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C253360 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 253360, 0, 11369, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C253360 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 253360, 40, 41 FROM DUAL
WHERE @EVERLAKE_C253360 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 253360);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 253360, 0, 254842, 40, 1, 1, 0, 1, 1, 'Nascent Undead Ravager: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C253360 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 253360 AND `ItemType` = 0 AND `Item` = 254842);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 253360, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253360 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 253360);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 253360, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253360 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 253360, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253360 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 253360, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253360 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 253360, 0, 254842, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253360 = 1;
SET @EVERLAKE_CS253360 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253360 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 253360 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 253360);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 253360, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001445 AS `guid`, -2082.66 AS `x`, 1158.63 AS `y`, 115.66 AS `z`  -- questie:trace
  UNION ALL SELECT 920001446, -2021.5, 1191.0, 101.18  -- questie:trace
) s
WHERE @EVERLAKE_CS253360 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS253360 = 1 AND c.`id` = 253360 AND c.`guid` BETWEEN 920001445 AND 920001446;

-- Scourge Reanimator (260148): 92591, 92592. Faction 14 as Fleshflay Ravener (249228); 15 spawn(s) from 31 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 249228; spawns questie/eglink; drops QuestieDB';
SET @EVERLAKE_C260148 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 260148)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260148);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 260148, 0, 0, 'Scourge Reanimator', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 6, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C260148 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 260148, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 260148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C260148 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 260148, 0, 16197, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C260148 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 260148, 59, 60 FROM DUAL
WHERE @EVERLAKE_C260148 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 260148);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 260148, 0, 268573, 40, 1, 1, 0, 1, 1, 'Scourge Reanimator: tracker quest_chance; QuestieDB npcDrops' FROM DUAL WHERE @EVERLAKE_C260148 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 260148 AND `ItemType` = 0 AND `Item` = 268573);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 260148, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260148 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 260148);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 260148, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260148 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260148, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260148 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 260148, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260148 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 260148, 0, 268573, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260148 = 1;
SET @EVERLAKE_CS260148 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260148 AND `file` = '2026_11_18_926_world_everlake_quest_drop_sources.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260148 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260148);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260148, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920001447 AS `guid`, 4929.77 AS `x`, -1859.91 AS `y`, 1316.82 AS `z`  -- questie:trace
  UNION ALL SELECT 920001448, 4968.19, -1876.58, 1324.08  -- questie:trace
  UNION ALL SELECT 920001449, 4992.03, -1827.26, 1322.6  -- questie:trace
  UNION ALL SELECT 920001450, 4992.95, -1714.05, 1339.02  -- questie:trace
  UNION ALL SELECT 920001451, 5024.9, -1798.44, 1321.7  -- questie:trace
  UNION ALL SELECT 920001452, 5042.49, -1844.98, 1330.24  -- questie:trace
  UNION ALL SELECT 920001453, 5052.44, -1759.19, 1321.64  -- questie:trace
  UNION ALL SELECT 920001454, 5090.63, -1859.21, 1351.89  -- questie:trace
  UNION ALL SELECT 920001455, 5094.8, -1794.27, 1328.82  -- questie:trace
  UNION ALL SELECT 920001456, 5098.04, -1919.99, 1393.11  -- questie:trace
  UNION ALL SELECT 920001457, 5139.0, -1860.6, 1381.85  -- questie:trace
  UNION ALL SELECT 920001458, 5163.54, -1731.41, 1336.28  -- questie:trace
  UNION ALL SELECT 920001459, 5170.25, -1829.0, 1369.83  -- questie:trace
  UNION ALL SELECT 920001460, 5204.97, -1707.8, 1357.52  -- questie:trace
  UNION ALL SELECT 920001461, 5206.82, -1653.97, 1389.33  -- questie:trace
) s
WHERE @EVERLAKE_CS260148 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS260148 = 1 AND c.`id` = 260148 AND c.`guid` BETWEEN 920001447 AND 920001461;

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
