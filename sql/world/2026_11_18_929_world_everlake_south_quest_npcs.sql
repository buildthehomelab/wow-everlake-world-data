-- Forever NPCs of Riverglades, Shen'dralas and Azshara that the realm's missing and incomplete quests need: quest givers
-- and enders, kill targets and the creatures that drop the quests' items, plus the invisible credit NPCs a client spell
-- gives credit for.
-- 2026_11_18_929_world_everlake_south_quest_npcs.sql: written from public data by a script, checked by hand. No quest is added here.
--
-- 28 creatures (538 spawns) and 5 credit NPCs (template only), as slice 5 of the Everlake import and
-- world-data file 926 (quest drop sources) write new NPCs:
--   * template: EG Link's creature details where it has them (17 creatures: name, title, type, family, classification,
--     class, models, type flags, health and power multipliers, CreatureDifficultyID, movement); else DatabaseForever
--     (EmuForever e0b21a2; the project's decision of 2026-11-18): name, title, type, family, class and models, the rank
--     from QuestieDB where it records one. DatabaseForever's faction, levels, speeds and flags look generated and are
--     not used. Levels: EG Link's sightings, else Wowhead's NPC page, else QuestieDB (its fix, trace, generated data).
--   * quest NPCs (QuestieDB says they give or take a quest) get the quest giver flag (npcflag 2); the quests themselves
--     (creature_queststarter / questender) come with the quest files.
--   * faction: no public source records it. The commonest faction of the realm's own NPCs spawned within 60 yards (else
--     200) that treats players as players saw this creature do (EG Link's reactions, else Wowhead's), same creature
--     type first. Where nobody recorded a reaction, its role decides: a quest NPC is friendly to the sides its quests
--     are for (QuestieDB's race masks: fix, then trace, then generated), else neutral like a nearby NPC that offers a
--     service; a kill or drop target is friendly to neither side. The nearest of those NPCs lends walk and run speed,
--     attack times and variance, and its immunity to players and NPCs. Each creature's note names it.
--   * spawns: a named creature or quest NPC gets one spawn: for a quest NPC the point of a spawn row (DatabaseForever,
--     forever-db) or Wowhead's map point first, else where players met it (QuestieTrace); for others the middle of all
--     its points (a better source's point within 15 yards of it is taken instead). A kind of mob gets one spawn per cell
--     of the realm's own spacing of mobs around its points (the median distance of nearby creatures' spawns to their
--     nearest twin), best sources first: Wowhead, forever-db and DatabaseForever points, QuestieDB (fix, generated,
--     trace), EG Link's sightings. Respawn, wander distance and movement as the realm's commonest for that
--     classification on the map (quest NPCs: as the realm's quest givers there, standing still). Heights from the
--     realm's own maps and vmaps (ForeverTracker tools/height.py): a spawn row's own height, else a realm spawn's
--     within 20 yards as the hint, else the terrain; a point with no hint that has a model floor more than 3 yards
--     under the ground (a cave or mine: which floor is not known) gives no spawn. Not checked in game.
--   * loot: quest items (QuestieDB: dropped by it and asked for by a quest), QuestRequired. Chance: Wowhead's
--     count/outof where it has 10 or more loots and the item dropped more than once, else EG Link's per-quest chance
--     (10 or more windows), else 40 (the tracker's quest_chance). No other loot and no money yet.
--   * credit NPCs ([DNT] Kill Credit ...): only those a client spell gives credit for (SpellEffect, checked for each);
--     template only, never spawned: DatabaseForever's name, type and model, faction 35, not
--     selectable or attackable (unit_flags 0x2000002), a trigger (flags_extra 128), as world-data PRs #200 and #201 write them.
--   * model sizes (INFERRED): 14 of the displays are new Forever ones the realm's creature_model_info lacks,
--     and the core loads no creature without its display's row (Creature::InitEntry). By the fork's own method
--     (sql/custom/world/2026_10_27_17_world_forever_creature_model_info.sql): the commonest value of the realm's rows
--     for other displays on the same client model (CreatureDisplayInfo.ModelID, client 70790), scaled by the display's
--     CreatureModelScale; a model with no such row and no collision width gets the player defaults 0.389 / 1.5. Each
--     row's note says which. Only displays without a row are added (INSERT IGNORE): an existing row is never changed.
--
-- Sources: EG Link (Efficient Games, CC BY 4.0) 30c3bb9c; QuestieDB (GPL-3.0) 4f628e83; Wowhead's WoW Forever NPC
-- pages (map points, levels, reactions, drop counts; read 2026-11-16 to 11-18); forever-db from Polestar (GPL-3.0)
-- 74eda09e; DatabaseForever (EmuForever) e0b21a2; client CreatureDisplayInfo and FactionTemplate (70790).
-- Guids: creatures 920004500 to 920005037 (this batch's block, 920004500 to 920005999).
-- No template is added where the realm already has one; spawns only while the template is this file's and the realm
-- has no spawn of it. Each added row is recorded in everlake_import_rows.
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

SET @EVERLAKE_FILE := '2026_11_18_929_world_everlake_south_quest_npcs.sql';

START TRANSACTION;

-- Model sizes the realm lacks (INFERRED, as the fork's 2026_10_27_17).
SET @EVERLAKE_NOTE := 'INFERRED: client model 7300, scale 1: 356 of the realm''s 364 rows on that model';
SET @EVERLAKE_M127408 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 127408);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 127408, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M127408 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 127408, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M127408 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 8103, scale 1: 8 of the realm''s 15 rows on that model';
SET @EVERLAKE_M130233 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 130233);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 130233, 0.383, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M130233 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 130233, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M130233 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 6838, scale 1: 593 of the realm''s 640 rows on that model';
SET @EVERLAKE_M138242 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 138242);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 138242, 0.372, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M138242 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 138242, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M138242 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 7369, scale 1: 297 of the realm''s 313 rows on that model';
SET @EVERLAKE_M138358 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 138358);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 138358, 0.389, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M138358 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 138358, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M138358 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 7200, scale 1: 274 of the realm''s 286 rows on that model';
SET @EVERLAKE_M139814 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 139814);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 139814, 0.236, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M139814 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 139814, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M139814 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 7661, scale 1: 1138 of the realm''s 1246 rows on that model';
SET @EVERLAKE_M139994 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 139994);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 139994, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M139994 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 139994, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M139994 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 7233, scale 1: 333 of the realm''s 381 rows on that model';
SET @EVERLAKE_M140328 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 140328);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 140328, 0.383, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M140328 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 140328, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M140328 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 7661, scale 1: 1138 of the realm''s 1246 rows on that model';
SET @EVERLAKE_M140461 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 140461);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 140461, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M140461 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 140461, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M140461 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 7599, scale 1: 654 of the realm''s 706 rows on that model';
SET @EVERLAKE_M140462 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 140462);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 140462, 0.208, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M140462 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 140462, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M140462 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 7661, scale 1: 1138 of the realm''s 1246 rows on that model';
SET @EVERLAKE_M141307 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 141307);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 141307, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M141307 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 141307, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M141307 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 33, scale 1.6: 26 of the realm''s 29 rows on that model';
SET @EVERLAKE_M142909 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 142909);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 142909, 1.6, 2.4, 0, 0 FROM DUAL WHERE @EVERLAKE_M142909 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 142909, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M142909 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 32, scale 2.05: 51 of the realm''s 53 rows on that model';
SET @EVERLAKE_M142910 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 142910);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 142910, 1.8306, 3.075, 0, 0 FROM DUAL WHERE @EVERLAKE_M142910 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 142910, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M142910 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 7200, scale 1: 274 of the realm''s 286 rows on that model';
SET @EVERLAKE_M143078 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 143078);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 143078, 0.236, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M143078 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 143078, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M143078 = 1;
SET @EVERLAKE_NOTE := 'INFERRED: client model 8102, scale 1: 9 of the realm''s 19 rows on that model';
SET @EVERLAKE_M144435 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 144435);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 144435, 0.383, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M144435 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 144435, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M144435 = 1;

-- Fizbuz Mithril (220984, Riverglades, ender/giver: 95312, 95321). Faction 475 as Gadgetzan Bruiser (9460); 1 spawn(s) from 7 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels wowhead; faction/speeds from 9460; reaction wowhead; spawns dbf';
SET @EVERLAKE_C220984 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 220984)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 220984)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (10747));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 220984, 0, 0, 'Fizbuz Mithril', NULL, NULL, NULL, NULL, 0, 0, 475, 2, 1, 1.42857, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C220984 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 220984, 0, 0, 0, 0, 0, 1.1, 1, 1, 1, 270592, 134217728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C220984 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 220984, 0, 10747, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C220984 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 220984, 35, 35 FROM DUAL
WHERE @EVERLAKE_C220984 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 220984);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 220984, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C220984 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 220984);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 220984, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C220984 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 220984, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C220984 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 220984, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C220984 = 1;
SET @EVERLAKE_CS220984 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 220984 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 220984 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 220984);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 220984, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004500 AS `guid`, -7135.4 AS `x`, -3779.15 AS `y`, 8.37 AS `z`  -- dbf
) s
WHERE @EVERLAKE_CS220984 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS220984 = 1 AND c.`id` = 220984 AND c.`guid` BETWEEN 920004500 AND 920004500;

-- Ceruleos (221651, Azshara, drops: no quest). Faction 14 as Forest Ooze (8766); 1 spawn(s) from 125 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels wowhead; faction/speeds from 8766; reaction wowhead; spawns questie:trace';
SET @EVERLAKE_C221651 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 221651)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 221651)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (9995));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 221651, 0, 0, 'Ceruleos', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 2, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C221651 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 221651, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C221651 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 221651, 0, 9995, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C221651 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 221651, 50, 50 FROM DUAL
WHERE @EVERLAKE_C221651 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 221651);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 221651, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C221651 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 221651);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 221651, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C221651 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 221651, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C221651 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 221651, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C221651 = 1;
SET @EVERLAKE_CS221651 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 221651 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 221651 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 221651);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 221651, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004501 AS `guid`, 2914.61 AS `x`, -5264.34 AS `y`, 132.01 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS221651 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS221651 = 1 AND c.`id` = 221651 AND c.`guid` BETWEEN 920004501 AND 920004501;

-- Prince Halanox (235892, Azshara, kill: 86814). Faction 90 as Legashi Satyr (6200); 1 spawn(s) from 5 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 6200; reaction by role; spawns questie:trace';
SET @EVERLAKE_C235892 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 235892)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 235892)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (12334));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 235892, 0, 0, 'Prince Halanox', NULL, NULL, NULL, NULL, 0, 0, 90, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 3, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C235892 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 235892, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C235892 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 235892, 0, 12334, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C235892 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 235892, 55, 55 FROM DUAL
WHERE @EVERLAKE_C235892 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 235892);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 235892, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235892 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 235892);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 235892, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235892 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 235892, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235892 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 235892, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235892 = 1;
SET @EVERLAKE_CS235892 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 235892 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 235892 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 235892);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 235892, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 600, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004502 AS `guid`, 4700.92 AS `x`, -6661.86 AS `y`, 119.93 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS235892 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS235892 = 1 AND c.`id` = 235892 AND c.`guid` BETWEEN 920004502 AND 920004502;

-- Ekkal (235903, Azshara, ender/giver: 86746, 86752, 97327). Faction 35 as Ogtinc (8405); 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 8405 (200 yd); reaction by role; spawns questie:trace';
SET @EVERLAKE_C235903 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 235903)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 235903)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (5851));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 235903, 0, 0, 'Ekkal', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 1.1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 512, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C235903 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 235903, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C235903 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 235903, 0, 5851, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C235903 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 235903, 50, 50 FROM DUAL
WHERE @EVERLAKE_C235903 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 235903);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 235903, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235903 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 235903);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 235903, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235903 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 235903, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235903 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 235903, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235903 = 1;
SET @EVERLAKE_CS235903 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 235903 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 235903 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 235903);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 235903, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004503 AS `guid`, 4027.04 AS `x`, -5406.83 AS `y`, 116.83 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS235903 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS235903 = 1 AND c.`id` = 235903 AND c.`guid` BETWEEN 920004503 AND 920004503;

-- Legashi Soulstealer (236867, Azshara, kill: 86792). Faction 90 as Legashi Satyr (6200); 17 spawn(s) from 112 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels wowhead; faction/speeds from 6200; reaction by role; spawns questie:trace/wowhead';
SET @EVERLAKE_C236867 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 236867)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236867)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (11336));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 236867, 0, 0, 'Legashi Soulstealer', NULL, NULL, NULL, NULL, 0, 0, 90, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 3, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C236867 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 236867, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C236867 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 236867, 0, 11336, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C236867 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 236867, 53, 54 FROM DUAL
WHERE @EVERLAKE_C236867 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 236867);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 236867, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236867 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 236867);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 236867, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236867 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 236867, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236867 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 236867, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236867 = 1;
SET @EVERLAKE_CS236867 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236867 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 236867 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 236867);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 236867, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004504 AS `guid`, 4618.08 AS `x`, -6613.69 AS `y`, 101.08 AS `z`  -- wowhead
  UNION ALL SELECT 920004505, 4682.32, -6583.27, 106.74  -- wowhead
  UNION ALL SELECT 920004506, 4689.09, -6664.4, 120.9  -- wowhead
  UNION ALL SELECT 920004507, 4719.52, -6471.71, 110.81  -- wowhead
  UNION ALL SELECT 920004508, 4722.9, -6755.67, 121.25  -- wowhead
  UNION ALL SELECT 920004509, 4773.62, -6547.77, 99.71  -- wowhead
  UNION ALL SELECT 920004510, 4777.0, -6679.61, 95.6  -- wowhead
  UNION ALL SELECT 920004511, 4817.57, -6608.62, 97.91  -- wowhead
  UNION ALL SELECT 920004512, 4509.88, -6554.36, 97.8  -- questie:trace
  UNION ALL SELECT 920004513, 4512.58, -6666.43, 98.41  -- questie:trace
  UNION ALL SELECT 920004514, 4631.6, -6527.99, 116.61  -- questie:trace
  UNION ALL SELECT 920004515, 4643.1, -6444.33, 114.64  -- questie:trace
  UNION ALL SELECT 920004516, 4691.45, -6393.11, 110.02  -- questie:trace
  UNION ALL SELECT 920004517, 4771.93, -6413.9, 104.84  -- questie:trace
  UNION ALL SELECT 920004518, 4788.83, -6803.34, 90.76  -- questie:trace
  UNION ALL SELECT 920004519, 4825.01, -6734.88, 95.7  -- questie:trace
  UNION ALL SELECT 920004520, 4885.54, -6649.69, 93.62  -- questie:trace
) s
WHERE @EVERLAKE_CS236867 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS236867 = 1 AND c.`id` = 236867 AND c.`guid` BETWEEN 920004504 AND 920004520;

-- Legashi Hellraiser (236874, Azshara, kill: 86792). Faction 90 as Legashi Satyr (6200); 19 spawn(s) from 114 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels wowhead; faction/speeds from 6200; reaction by role; spawns questie:trace/wowhead';
SET @EVERLAKE_C236874 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 236874)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236874)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (6743));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 236874, 0, 0, 'Legashi Hellraiser', NULL, NULL, NULL, NULL, 0, 0, 90, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 3, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C236874 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 236874, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C236874 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 236874, 0, 6743, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C236874 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 236874, 53, 54 FROM DUAL
WHERE @EVERLAKE_C236874 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 236874);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 236874, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236874 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 236874);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 236874, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236874 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 236874, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236874 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 236874, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236874 = 1;
SET @EVERLAKE_CS236874 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236874 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 236874 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 236874);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 236874, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004521 AS `guid`, 4624.84 AS `x`, -6608.62 AS `y`, 101.07 AS `z`  -- wowhead
  UNION ALL SELECT 920004522, 4692.47, -6552.84, 104.05  -- wowhead
  UNION ALL SELECT 920004523, 4712.75, -6674.54, 118.32  -- wowhead
  UNION ALL SELECT 920004524, 4726.28, -6471.71, 109.79  -- wowhead
  UNION ALL SELECT 920004525, 4760.09, -6598.48, 105.08  -- wowhead
  UNION ALL SELECT 920004526, 4793.9, -6704.97, 95.1  -- wowhead
  UNION ALL SELECT 920004527, 4820.95, -6628.9, 95.59  -- wowhead
  UNION ALL SELECT 920004528, 4502.78, -6674.54, 96.94  -- questie:trace
  UNION ALL SELECT 920004529, 4532.2, -6523.94, 95.12  -- questie:trace
  UNION ALL SELECT 920004530, 4565.33, -6642.09, 95.85  -- questie:trace
  UNION ALL SELECT 920004531, 4632.28, -6526.98, 116.73  -- questie:trace
  UNION ALL SELECT 920004532, 4639.38, -6437.73, 113.89  -- questie:trace
  UNION ALL SELECT 920004533, 4683.34, -6376.88, 110.94  -- questie:trace
  UNION ALL SELECT 920004534, 4702.27, -6757.2, 136.87  -- questie:trace
  UNION ALL SELECT 920004535, 4751.98, -6814.5, 107.98  -- questie:trace
  UNION ALL SELECT 920004536, 4760.77, -6385.0, 106.96  -- questie:trace
  UNION ALL SELECT 920004537, 4804.05, -6495.03, 108.86  -- questie:trace
  UNION ALL SELECT 920004538, 4848.68, -6783.56, 96.84  -- questie:trace
  UNION ALL SELECT 920004539, 4885.54, -6641.07, 94.26  -- questie:trace
) s
WHERE @EVERLAKE_CS236874 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS236874 = 1 AND c.`id` = 236874 AND c.`guid` BETWEEN 920004521 AND 920004539;

-- Legashi Blackguard (236876, Azshara, kill: 86792). Faction 90 as Legashi Satyr (6200); 9 spawn(s) from 67 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 6200; reaction by role; spawns questie:trace/wowhead';
SET @EVERLAKE_C236876 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 236876)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236876)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (8575));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 236876, 0, 0, 'Legashi Blackguard', NULL, NULL, NULL, NULL, 0, 0, 90, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 3, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C236876 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 236876, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C236876 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 236876, 0, 8575, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C236876 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 236876, 53, 54 FROM DUAL
WHERE @EVERLAKE_C236876 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 236876);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 236876, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236876 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 236876);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 236876, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236876 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 236876, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236876 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 236876, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236876 = 1;
SET @EVERLAKE_CS236876 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236876 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 236876 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 236876);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 236876, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004540 AS `guid`, 4641.75 AS `x`, -6639.05 AS `y`, 104.72 AS `z`  -- wowhead
  UNION ALL SELECT 920004541, 4695.85, -6542.7, 104.31  -- wowhead
  UNION ALL SELECT 920004542, 4702.61, -6694.82, 123.62  -- wowhead
  UNION ALL SELECT 920004543, 4739.8, -6451.42, 108.35  -- wowhead
  UNION ALL SELECT 920004544, 4756.71, -6603.55, 112.31  -- wowhead
  UNION ALL SELECT 920004545, 4820.95, -6684.68, 94.05  -- wowhead
  UNION ALL SELECT 920004546, 4748.6, -6756.18, 107.78  -- questie:trace
  UNION ALL SELECT 920004547, 4764.15, -6518.36, 101.54  -- questie:trace
  UNION ALL SELECT 920004548, 4868.97, -6621.3, 95.98  -- questie:trace
) s
WHERE @EVERLAKE_CS236876 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS236876 = 1 AND c.`id` = 236876 AND c.`guid` BETWEEN 920004540 AND 920004548;

-- Commander Truesong (239822, Azshara, ender/giver: 88807, 88809, 88812, 88813, 88821, 88857, 89470, 92345, 98096). Faction 35 as Loh'atu (11548); 1 spawn(s) from 4 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 11548; reaction by role; spawns polestar';
SET @EVERLAKE_C239822 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 239822)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 239822)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (127408));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 239822, 0, 0, 'Commander Truesong', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C239822 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 239822, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C239822 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 239822, 0, 127408, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C239822 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 239822, 45, 45 FROM DUAL
WHERE @EVERLAKE_C239822 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 239822);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 239822, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239822 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 239822);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 239822, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239822 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 239822, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239822 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 239822, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239822 = 1;
SET @EVERLAKE_CS239822 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 239822 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 239822 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 239822);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 239822, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004549 AS `guid`, 2699 AS `x`, -3880.5 AS `y`, 106.99 AS `z`  -- polestar
) s
WHERE @EVERLAKE_CS239822 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS239822 = 1 AND c.`id` = 239822 AND c.`guid` BETWEEN 920004549 AND 920004549;

-- Lord Sarthiss (239939, Azshara, item: 88809). Faction 74 as Spitelash Serpent Guard (6194); 1 spawn(s) from 58 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels wowhead; faction/speeds from 6194; reaction by role; spawns wowhead';
SET @EVERLAKE_C239939 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 239939)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 239939)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (4764));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 239939, 0, 0, 'Lord Sarthiss', NULL, NULL, NULL, NULL, 0, 0, 74, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C239939 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 239939, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 239939, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C239939 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 239939, 0, 4764, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C239939 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 239939, 52, 52 FROM DUAL
WHERE @EVERLAKE_C239939 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 239939);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 239939, 0, 280610, 60.71, 1, 1, 0, 1, 1, 'Lord Sarthiss: wowhead 34/56; quest 88809' FROM DUAL WHERE @EVERLAKE_C239939 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 239939 AND `ItemType` = 0 AND `Item` = 280610);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 239939, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239939 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 239939);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 239939, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239939 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 239939, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239939 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 239939, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239939 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 239939, 0, 280610, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239939 = 1;
SET @EVERLAKE_CS239939 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 239939 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 239939 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 239939);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 239939, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004550 AS `guid`, 3434.64 AS `x`, -5173.57 AS `y`, 83.46 AS `z`  -- wowhead
) s
WHERE @EVERLAKE_CS239939 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS239939 = 1 AND c.`id` = 239939 AND c.`guid` BETWEEN 920004550 AND 920004550;

-- Razorgill (239971, Azshara, item: 89037). Faction 129 as Makrinni Scrabbler (6370); 1 spawn(s) from 40 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 6370; reaction by role; spawns wowhead';
SET @EVERLAKE_C239971 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 239971)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 239971)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (1762));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 239971, 0, 0, 'Razorgill', NULL, NULL, NULL, NULL, 0, 0, 129, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C239971 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 239971, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 239971, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C239971 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 239971, 0, 1762, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C239971 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 239971, 52, 52 FROM DUAL
WHERE @EVERLAKE_C239971 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 239971);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 239971, 0, 238385, 75.68, 1, 1, 0, 1, 1, 'Razorgill: wowhead 28/37; quest 89037' FROM DUAL WHERE @EVERLAKE_C239971 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 239971 AND `ItemType` = 0 AND `Item` = 238385);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 239971, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239971 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 239971);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 239971, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239971 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 239971, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239971 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 239971, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239971 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 239971, 0, 238385, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239971 = 1;
SET @EVERLAKE_CS239971 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 239971 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 239971 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 239971);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 239971, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004551 AS `guid`, 4266.43 AS `x`, -7800.27 AS `y`, 8.83 AS `z`  -- wowhead
) s
WHERE @EVERLAKE_CS239971 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS239971 = 1 AND c.`id` = 239971 AND c.`guid` BETWEEN 920004551 AND 920004551;

-- Lieutenant Suncrest (247006, Azshara, item: 91497). Faction 14 as Thunderhead Patriarch (6379); 1 spawn(s) from 26 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 6379; reaction by role; spawns questie:trace';
SET @EVERLAKE_C247006 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 247006)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 247006)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (144435));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 247006, 0, 0, 'Lieutenant Suncrest', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1.2, 1.42857, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C247006 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 247006, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 247006, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C247006 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 247006, 0, 144435, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C247006 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 247006, 53, 53 FROM DUAL
WHERE @EVERLAKE_C247006 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 247006);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 247006, 0, 246725, 85, 1, 1, 0, 1, 1, 'Lieutenant Suncrest: wowhead 34/40; quest 91497' FROM DUAL WHERE @EVERLAKE_C247006 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 247006 AND `ItemType` = 0 AND `Item` = 246725);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 247006, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247006 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247006);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 247006, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247006 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 247006, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247006 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 247006, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247006 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 247006, 0, 246725, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247006 = 1;
SET @EVERLAKE_CS247006 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 247006 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 247006 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 247006);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247006, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004552 AS `guid`, 4398.3 AS `x`, -6666.43 AS `y`, 100.06 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS247006 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS247006 = 1 AND c.`id` = 247006 AND c.`guid` BETWEEN 920004552 AND 920004552;

-- Ranger Lydrea (247013, Azshara, item: 91497). Faction 14 as Thunderhead Patriarch (6379); 1 spawn(s) from 32 points.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; levels questie:trace; faction/speeds from 6379; reaction by role; spawns questie:trace';
SET @EVERLAKE_C247013 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 247013)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 247013)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (130233));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 247013, 0, 0, 'Ranger Lydrea', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1.2, 1.42857, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C247013 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 247013, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 247013, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C247013 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 247013, 0, 130233, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C247013 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 247013, 53, 53 FROM DUAL
WHERE @EVERLAKE_C247013 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 247013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 247013, 0, 246722, 88.24, 1, 1, 0, 1, 1, 'Ranger Lydrea: wowhead 30/34; quest 91497' FROM DUAL WHERE @EVERLAKE_C247013 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 247013 AND `ItemType` = 0 AND `Item` = 246722);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 247013, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247013 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 247013);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 247013, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247013 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 247013, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247013 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 247013, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247013 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 247013, 0, 246722, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C247013 = 1;
SET @EVERLAKE_CS247013 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 247013 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 247013 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 247013);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 247013, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004553 AS `guid`, 4332.7 AS `x`, -6842.89 AS `y`, 93.99 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS247013 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS247013 = 1 AND c.`id` = 247013 AND c.`guid` BETWEEN 920004553 AND 920004553;

-- Bristleback Nomad (253524, Shen'dralas, kill: 93066). Faction 39 as Palemane Skinner (2950); 58 spawn(s) from 292 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 2950; reaction eglink; spawns questie:trace';
SET @EVERLAKE_C253524 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 253524)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253524)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (1346));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 253524, 253852, 0, 'Bristleback Nomad', NULL, NULL, NULL, NULL, 0, 0, 39, 0, 1, 0.85714, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C253524 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 253524, 0, 0, 0, 0, 0, 1, 1, 1, 1, 334409, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C253524 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 253524, 0, 1346, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C253524 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 253524, 42, 43 FROM DUAL
WHERE @EVERLAKE_C253524 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 253524);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 253524, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253524 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 253524);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 253524, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253524 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 253524, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253524 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 253524, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253524 = 1;
SET @EVERLAKE_CS253524 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253524 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 253524 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 253524);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 253524, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004554 AS `guid`, -2455.0 AS `x`, 605.38 AS `y`, 142.49 AS `z`  -- questie:trace
  UNION ALL SELECT 920004555, -2452.54, 563.55, 149.14  -- questie:trace
  UNION ALL SELECT 920004556, -2441.61, 645.76, 137.82  -- questie:trace
  UNION ALL SELECT 920004557, -2435.46, 678.97, 136.07  -- questie:trace
  UNION ALL SELECT 920004558, -2418.24, 598.82, 139.04  -- questie:trace
  UNION ALL SELECT 920004559, -2417.42, 559.66, 143.73  -- questie:trace
  UNION ALL SELECT 920004560, -2411.82, 493.86, 64.25  -- questie:trace
  UNION ALL SELECT 920004561, -2410.04, 628.95, 140.02  -- questie:trace
  UNION ALL SELECT 920004562, -2407.44, 526.04, 162.13  -- questie:trace
  UNION ALL SELECT 920004563, -2400.34, 673.43, 144.03  -- questie:trace
  UNION ALL SELECT 920004564, -2383.8, 589.79, 137.19  -- questie:trace
  UNION ALL SELECT 920004565, -2383.12, 553.1, 156.15  -- questie:trace
  UNION ALL SELECT 920004566, -2365.76, 630.38, 154.87  -- questie:trace
  UNION ALL SELECT 920004567, -2361.66, 1124.23, 108.26  -- questie:trace
  UNION ALL SELECT 920004568, -2350.86, 600.66, 136.43  -- questie:trace
  UNION ALL SELECT 920004569, -2350.32, 534.45, 40.97  -- questie:trace
  UNION ALL SELECT 920004570, -2327.36, 563.35, 170.93  -- questie:trace
  UNION ALL SELECT 920004571, -2321.07, 628.95, 145.37  -- questie:trace
  UNION ALL SELECT 920004572, -2319.84, 503.69, 45.79  -- questie:trace
  UNION ALL SELECT 920004573, -2305.22, 588.97, 146.7  -- questie:trace
  UNION ALL SELECT 920004574, -2293.87, 662.16, 168.24  -- questie:trace
  UNION ALL SELECT 920004575, -2283.35, 622.18, 156.49  -- questie:trace
  UNION ALL SELECT 920004576, -2283.08, 553.1, 170.76  -- questie:trace
  UNION ALL SELECT 920004577, -2279.52, 839.69, 124.97  -- questie:trace
  UNION ALL SELECT 920004578, -2270.37, 588.57, 155.86  -- questie:trace
  UNION ALL SELECT 920004579, -2269.82, 760.15, 147.84  -- questie:trace
  UNION ALL SELECT 920004580, -2261.21, 649.45, 164.84  -- questie:trace
  UNION ALL SELECT 920004581, -2261.07, 807.51, 131.57  -- questie:trace
  UNION ALL SELECT 920004582, -2255.06, 531.78, 173.16  -- questie:trace
  UNION ALL SELECT 920004583, -2253.15, 614.19, 155.1  -- questie:trace
  UNION ALL SELECT 920004584, -2249.46, 565.2, 172.54  -- questie:trace
  UNION ALL SELECT 920004585, -2243.85, 707.26, 157.58  -- questie:trace
  UNION ALL SELECT 920004586, -2241.94, 742.73, 150.37  -- questie:trace
  UNION ALL SELECT 920004587, -2240.98, 674.46, 151.85  -- questie:trace
  UNION ALL SELECT 920004588, -2235.11, 777.37, 143.36  -- questie:trace
  UNION ALL SELECT 920004589, -2230.32, 500.83, 176.3  -- questie:trace
  UNION ALL SELECT 920004590, -2226.91, 593.28, 162.76  -- questie:trace
  UNION ALL SELECT 920004591, -2225.68, 630.18, 153.89  -- questie:trace
  UNION ALL SELECT 920004592, -2225.13, 543.67, 172.87  -- questie:trace
  UNION ALL SELECT 920004593, -2221.17, 842.97, 123.62  -- questie:trace
  UNION ALL SELECT 920004594, -2219.66, 926.82, 106.37  -- questie:trace
  UNION ALL SELECT 920004595, -2214.61, 695.37, 144.8  -- questie:trace
  UNION ALL SELECT 920004596, -2211.33, 471.92, 176.71  -- questie:trace
  UNION ALL SELECT 920004597, -2208.73, 405.29, 182.66  -- questie:trace
  UNION ALL SELECT 920004598, -2208.73, 738.21, 147.63  -- questie:trace
  UNION ALL SELECT 920004599, -2208.46, 802.38, 154.17  -- questie:trace
  UNION ALL SELECT 920004600, -2198.89, 664.0, 149.37  -- questie:trace
  UNION ALL SELECT 920004601, -2193.42, 576.06, 166.98  -- questie:trace
  UNION ALL SELECT 920004602, -2187.96, 838.05, 132.59  -- questie:trace
  UNION ALL SELECT 920004603, -2186.45, 514.97, 173.48  -- questie:trace
  UNION ALL SELECT 920004604, -2179.07, 752.77, 144.89  -- questie:trace
  UNION ALL SELECT 920004605, -2171.56, 807.71, 150.71  -- questie:trace
  UNION ALL SELECT 920004606, -2164.18, 857.53, 144.0  -- questie:trace
  UNION ALL SELECT 920004607, -2157.34, 727.35, 143.85  -- questie:trace
  UNION ALL SELECT 920004608, -2155.7, 773.27, 147.1  -- questie:trace
  UNION ALL SELECT 920004609, -2141.76, 818.78, 151.79  -- questie:trace
  UNION ALL SELECT 920004610, -2108.96, 830.67, 154.53  -- questie:trace
  UNION ALL SELECT 920004611, -2074.11, 830.46, 155.78  -- questie:trace
) s
WHERE @EVERLAKE_CS253524 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS253524 = 1 AND c.`id` = 253524 AND c.`guid` BETWEEN 920004554 AND 920004611;

-- Bristleback Skullcrusher (253526, Shen'dralas, kill: 93066). Faction 39 as Palemane Skinner (2950); 87 spawn(s) from 372 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 2950; reaction eglink; spawns questie:generated/questie:trace';
SET @EVERLAKE_C253526 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 253526)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253526)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (4757));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 253526, 253852, 0, 'Bristleback Skullcrusher', NULL, NULL, NULL, NULL, 0, 0, 39, 0, 1, 0.85714, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C253526 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 253526, 0, 0, 0, 0, 0, 1, 1, 1, 1, 334411, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C253526 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 253526, 0, 4757, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C253526 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 253526, 42, 43 FROM DUAL
WHERE @EVERLAKE_C253526 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 253526);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 253526, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253526 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 253526);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 253526, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253526 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 253526, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253526 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 253526, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C253526 = 1;
SET @EVERLAKE_CS253526 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253526 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 253526 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 253526);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 253526, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004612 AS `guid`, -2468.53 AS `x`, 766.3 AS `y`, 120.5 AS `z`  -- questie:generated
  UNION ALL SELECT 920004613, -2454.87, 706.85, 135.23  -- questie:generated
  UNION ALL SELECT 920004614, -2433.0, 735.55, 129.47  -- questie:generated
  UNION ALL SELECT 920004615, -2428.9, 694.55, 135.41  -- questie:generated
  UNION ALL SELECT 920004616, -2413.87, 637.15, 139.68  -- questie:generated
  UNION ALL SELECT 920004617, -2412.5, 721.2, 141.06  -- questie:generated
  UNION ALL SELECT 920004618, -2375.6, 563.35, 156.54  -- questie:generated
  UNION ALL SELECT 920004619, -2260.8, 575.65, 168.94  -- questie:generated
  UNION ALL SELECT 920004620, -2238.93, 786.8, 140.11  -- questie:generated
  UNION ALL SELECT 920004621, -2236.2, 743.75, 149.34  -- questie:generated
  UNION ALL SELECT 920004622, -2229.37, 590.0, 162.95  -- questie:generated
  UNION ALL SELECT 920004623, -2228.0, 684.3, 145.04  -- questie:generated
  UNION ALL SELECT 920004624, -2223.9, 538.75, 173.12  -- questie:generated
  UNION ALL SELECT 920004625, -2221.17, 653.55, 149.51  -- questie:generated
  UNION ALL SELECT 920004626, -2221.17, 710.95, 145.92  -- questie:generated
  UNION ALL SELECT 920004627, -2215.7, 514.15, 173.12  -- questie:generated
  UNION ALL SELECT 920004628, -2187.0, 565.4, 167.09  -- questie:generated
  UNION ALL SELECT 920004629, -2178.8, 518.25, 175.66  -- questie:generated
  UNION ALL SELECT 920004630, -2156.93, 831.9, 147.29  -- questie:generated
  UNION ALL SELECT 920004631, -2122.77, 836.0, 154.37  -- questie:generated
  UNION ALL SELECT 920004632, -2611.08, 836.62, 79.0  -- questie:trace
  UNION ALL SELECT 920004633, -2581.01, 831.08, 85.76  -- questie:trace
  UNION ALL SELECT 920004634, -2559.14, 802.58, 93.5  -- questie:trace
  UNION ALL SELECT 920004635, -2523.47, 798.69, 103.56  -- questie:trace
  UNION ALL SELECT 920004636, -2497.23, 795.0, 110.23  -- questie:trace
  UNION ALL SELECT 920004637, -2455.69, 582.41, 144.71  -- questie:trace
  UNION ALL SELECT 920004638, -2450.08, 627.72, 139.99  -- questie:trace
  UNION ALL SELECT 920004639, -2441.75, 652.93, 138.0  -- questie:trace
  UNION ALL SELECT 920004640, -2441.34, 785.57, 119.93  -- questie:trace
  UNION ALL SELECT 920004641, -2419.47, 527.48, 162.62  -- questie:trace
  UNION ALL SELECT 920004642, -2418.65, 668.72, 139.0  -- questie:trace
  UNION ALL SELECT 920004643, -2414.69, 492.01, 64.37  -- questie:trace
  UNION ALL SELECT 920004644, -2413.59, 800.12, 122.29  -- questie:trace
  UNION ALL SELECT 920004645, -2409.36, 601.07, 137.92  -- questie:trace
  UNION ALL SELECT 920004646, -2401.16, 561.71, 145.25  -- questie:trace
  UNION ALL SELECT 920004647, -2395.14, 690.24, 151.48  -- questie:trace
  UNION ALL SELECT 920004648, -2394.05, 537.73, 156.1  -- questie:trace
  UNION ALL SELECT 920004649, -2388.99, 656.01, 160.89  -- questie:trace
  UNION ALL SELECT 920004650, -2387.76, 808.53, 126.01  -- questie:trace
  UNION ALL SELECT 920004651, -2375.05, 708.08, 167.19  -- questie:trace
  UNION ALL SELECT 920004652, -2369.31, 536.09, 167.58  -- questie:trace
  UNION ALL SELECT 920004653, -2354.42, 575.86, 151.7  -- questie:trace
  UNION ALL SELECT 920004654, -2342.8, 541.21, 40.97  -- questie:trace
  UNION ALL SELECT 920004655, -2333.1, 775.52, 175.67  -- questie:trace
  UNION ALL SELECT 920004656, -2320.93, 558.63, 170.94  -- questie:trace
  UNION ALL SELECT 920004657, -2317.65, 620.75, 146.52  -- questie:trace
  UNION ALL SELECT 920004658, -2316.56, 820.62, 131.75  -- questie:trace
  UNION ALL SELECT 920004659, -2300.98, 764.66, 162.31  -- questie:trace
  UNION ALL SELECT 920004660, -2298.11, 567.86, 170.43  -- questie:trace
  UNION ALL SELECT 920004661, -2292.37, 830.26, 127.63  -- questie:trace
  UNION ALL SELECT 920004662, -2278.02, 795.82, 141.39  -- questie:trace
  UNION ALL SELECT 920004663, -2277.47, 627.31, 155.71  -- questie:trace
  UNION ALL SELECT 920004664, -2273.1, 759.33, 152.57  -- questie:trace
  UNION ALL SELECT 920004665, -2263.94, 648.84, 164.19  -- questie:trace
  UNION ALL SELECT 920004666, -2263.81, 819.6, 127.89  -- questie:trace
  UNION ALL SELECT 920004667, -2260.94, 847.89, 123.3  -- questie:trace
  UNION ALL SELECT 920004668, -2259.02, 545.31, 173.16  -- questie:trace
  UNION ALL SELECT 920004669, -2251.64, 611.53, 155.88  -- questie:trace
  UNION ALL SELECT 920004670, -2249.18, 873.52, 119.33  -- questie:trace
  UNION ALL SELECT 920004671, -2247.27, 522.55, 174.22  -- questie:trace
  UNION ALL SELECT 920004672, -2235.65, 812.22, 129.81  -- questie:trace
  UNION ALL SELECT 920004673, -2226.91, 617.27, 157.42  -- questie:trace
  UNION ALL SELECT 920004674, -2226.91, 921.48, 108.3  -- questie:trace
  UNION ALL SELECT 920004675, -2222.4, 874.34, 115.79  -- questie:trace
  UNION ALL SELECT 920004676, -2218.57, 841.94, 124.23  -- questie:trace
  UNION ALL SELECT 920004677, -2217.2, 477.04, 178.53  -- questie:trace
  UNION ALL SELECT 920004678, -2215.43, 569.09, 166.24  -- questie:trace
  UNION ALL SELECT 920004679, -2213.65, 791.51, 148.74  -- questie:trace
  UNION ALL SELECT 920004680, -2212.97, 419.23, 179.73  -- questie:trace
  UNION ALL SELECT 920004681, -2201.08, 952.24, 100.23  -- questie:trace
  UNION ALL SELECT 920004682, -2199.71, 856.7, 124.05  -- questie:trace
  UNION ALL SELECT 920004683, -2198.89, 927.63, 105.55  -- questie:trace
  UNION ALL SELECT 920004684, -2197.11, 746.82, 147.45  -- questie:trace
  UNION ALL SELECT 920004685, -2194.65, 829.03, 133.74  -- questie:trace
  UNION ALL SELECT 920004686, -2176.61, 729.61, 142.58  -- questie:trace
  UNION ALL SELECT 920004687, -2174.84, 907.13, 133.65  -- questie:trace
  UNION ALL SELECT 920004688, -2172.24, 775.32, 168.58  -- questie:trace
  UNION ALL SELECT 920004689, -2168.82, 856.09, 141.02  -- questie:trace
  UNION ALL SELECT 920004690, -2167.87, 808.12, 151.36  -- questie:trace
  UNION ALL SELECT 920004691, -2143.54, 779.62, 148.17  -- questie:trace
  UNION ALL SELECT 920004692, -2134.79, 809.76, 152.77  -- questie:trace
  UNION ALL SELECT 920004693, -2107.87, 811.81, 154.82  -- questie:trace
  UNION ALL SELECT 920004694, -2104.32, 858.55, 155.17  -- questie:trace
  UNION ALL SELECT 920004695, -2084.5, 831.9, 155.45  -- questie:trace
  UNION ALL SELECT 920004696, -2068.78, 854.86, 155.39  -- questie:trace
  UNION ALL SELECT 920004697, -2054.16, 830.46, 162.6  -- questie:trace
  UNION ALL SELECT 920004698, -2025.99, 855.16, 193.92  -- questie:trace
) s
WHERE @EVERLAKE_CS253526 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS253526 = 1 AND c.`id` = 253526 AND c.`guid` BETWEEN 920004612 AND 920004698;

-- Rokren (254040, Shen'dralas, giver: 93125). Faction 35 as Shen'dralas Protector (255759); 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 255759 (200 yd); reaction eglink; spawns questie:trace';
SET @EVERLAKE_C254040 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 254040)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254040)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (9436));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 254040, 0, 0, 'Rokren', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C254040 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 254040, 0, 0, 0, 0, 0, 2.5, 1, 1, 1, 334924, 134217728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C254040 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 254040, 0, 9436, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C254040 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 254040, 43, 43 FROM DUAL
WHERE @EVERLAKE_C254040 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 254040);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 254040, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254040 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 254040);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 254040, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254040 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 254040, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254040 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 254040, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254040 = 1;
SET @EVERLAKE_CS254040 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254040 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 254040 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 254040);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 254040, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004699 AS `guid`, -2964.63 AS `x`, 1325.34 AS `y`, 58.06 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS254040 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS254040 = 1 AND c.`id` = 254040 AND c.`guid` BETWEEN 920004699 AND 920004699;

-- Outcast Scout (254283, Shen'dralas, kill: 93072). Faction 133 as Magram Marauder (262838); 82 spawn(s) from 441 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels eglink@70938; faction/speeds from 262838 (200 yd); reaction eglink; spawns questie:trace/wowhead';
SET @EVERLAKE_C254283 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 254283)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254283)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (9421));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 254283, 0, 0, 'Outcast Scout', NULL, NULL, NULL, NULL, 0, 0, 133, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1694, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C254283 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 254283, 0, 0, 0, 0, 0, 1.1, 1, 1, 1, 335195, 134217728, 0, 0, 254283, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C254283 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 254283, 0, 9421, 1.05, 0, 0 FROM DUAL WHERE @EVERLAKE_C254283 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 254283, 41, 42 FROM DUAL
WHERE @EVERLAKE_C254283 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 254283);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 254283, 0, 254432, 24.73, 1, 1, 0, 1, 1, 'Outcast Scout: wowhead 45/182; quest 92811,92812,93224,93225' FROM DUAL WHERE @EVERLAKE_C254283 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = 254283 AND `ItemType` = 0 AND `Item` = 254432);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 254283, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254283 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 254283);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 254283, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254283 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 254283, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254283 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 254283, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254283 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 254283, 0, 254432, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254283 = 1;
SET @EVERLAKE_CS254283 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254283 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 254283 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 254283);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 254283, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004700 AS `guid`, -2803.37 AS `x`, 1184.5 AS `y`, 82.85 AS `z`  -- wowhead
  UNION ALL SELECT 920004701, -2785.6, 1104.55, 106.82  -- wowhead
  UNION ALL SELECT 920004702, -2769.2, 1057.4, 106.25  -- wowhead
  UNION ALL SELECT 920004703, -2621.6, 1325.95, 97.85  -- wowhead
  UNION ALL SELECT 920004704, -2592.9, 1311.6, 108.02  -- wowhead
  UNION ALL SELECT 920004705, -2581.97, 1219.35, 95.71  -- wowhead
  UNION ALL SELECT 920004706, -3118.93, 1251.54, 140.04  -- questie:trace
  UNION ALL SELECT 920004707, -3117.7, 1212.59, 142.19  -- questie:trace
  UNION ALL SELECT 920004708, -3103.21, 1307.5, 119.14  -- questie:trace
  UNION ALL SELECT 920004709, -3098.7, 1158.05, 134.42  -- questie:trace
  UNION ALL SELECT 920004710, -3090.37, 1200.49, 109.77  -- questie:trace
  UNION ALL SELECT 920004711, -3081.76, 1345.63, 104.77  -- questie:trace
  UNION ALL SELECT 920004712, -3074.51, 1127.51, 126.36  -- questie:trace
  UNION ALL SELECT 920004713, -3072.46, 1316.11, 100.95  -- questie:trace
  UNION ALL SELECT 920004714, -3065.63, 1174.45, 93.17  -- questie:trace
  UNION ALL SELECT 920004715, -3046.77, 1248.26, 86.83  -- questie:trace
  UNION ALL SELECT 920004716, -3046.22, 1282.69, 80.58  -- questie:trace
  UNION ALL SELECT 920004717, -3041.71, 1214.84, 82.52  -- questie:trace
  UNION ALL SELECT 920004718, -3034.88, 1386.84, 101.55  -- questie:trace
  UNION ALL SELECT 920004719, -3027.5, 1417.79, 102.24  -- questie:trace
  UNION ALL SELECT 920004720, -3021.62, 1262.81, 69.9  -- questie:trace
  UNION ALL SELECT 920004721, -3021.49, 1183.07, 99.63  -- questie:trace
  UNION ALL SELECT 920004722, -3019.3, 1300.94, 68.88  -- questie:trace
  UNION ALL SELECT 920004723, -3011.51, 1228.78, 70.49  -- questie:trace
  UNION ALL SELECT 920004724, -2988.28, 1204.59, 74.95  -- questie:trace
  UNION ALL SELECT 920004725, -2988.14, 1282.69, 61.84  -- questie:trace
  UNION ALL SELECT 920004726, -2976.39, 1245.18, 64.33  -- questie:trace
  UNION ALL SELECT 920004727, -2973.11, 1176.51, 107.81  -- questie:trace
  UNION ALL SELECT 920004728, -2954.11, 1283.11, 56.03  -- questie:trace
  UNION ALL SELECT 920004729, -2951.38, 1225.09, 66.11  -- questie:trace
  UNION ALL SELECT 920004730, -2932.65, 1305.25, 54.09  -- questie:trace
  UNION ALL SELECT 920004731, -2930.6, 1260.35, 57.44  -- questie:trace
  UNION ALL SELECT 920004732, -2926.09, 1208.07, 71.07  -- questie:trace
  UNION ALL SELECT 920004733, -2901.08, 1232.67, 59.52  -- questie:trace
  UNION ALL SELECT 920004734, -2877.17, 1382.12, 61.29  -- questie:trace
  UNION ALL SELECT 920004735, -2869.92, 1242.72, 54.36  -- questie:trace
  UNION ALL SELECT 920004736, -2857.35, 1359.57, 52.78  -- questie:trace
  UNION ALL SELECT 920004737, -2851.61, 1277.57, 43.03  -- questie:trace
  UNION ALL SELECT 920004738, -2843.0, 1060.07, 129.83  -- questie:trace
  UNION ALL SELECT 920004739, -2842.18, 1224.48, 59.84  -- questie:trace
  UNION ALL SELECT 920004740, -2828.51, 1383.55, 56.85  -- questie:trace
  UNION ALL SELECT 920004741, -2817.03, 1413.28, 63.67  -- questie:trace
  UNION ALL SELECT 920004742, -2816.21, 1313.65, 17.29  -- questie:trace
  UNION ALL SELECT 920004743, -2813.89, 1249.08, 51.53  -- questie:trace
  UNION ALL SELECT 920004744, -2807.47, 1059.45, 132.4  -- questie:trace
  UNION ALL SELECT 920004745, -2803.23, 1363.88, 49.55  -- questie:trace
  UNION ALL SELECT 920004746, -2795.71, 1214.22, 58.13  -- questie:trace
  UNION ALL SELECT 920004747, -2786.01, 1259.94, 51.15  -- questie:trace
  UNION ALL SELECT 920004748, -2776.17, 1147.39, 84.82  -- questie:trace
  UNION ALL SELECT 920004749, -2775.49, 1373.51, 59.08  -- questie:trace
  UNION ALL SELECT 920004750, -2770.43, 1340.71, 50.48  -- questie:trace
  UNION ALL SELECT 920004751, -2755.53, 1241.7, 54.24  -- questie:trace
  UNION ALL SELECT 920004752, -2754.58, 1280.44, 50.5  -- questie:trace
  UNION ALL SELECT 920004753, -2749.66, 1315.9, 51.61  -- questie:trace
  UNION ALL SELECT 920004754, -2749.52, 1172.0, 88.97  -- questie:trace
  UNION ALL SELECT 920004755, -2747.47, 1364.9, 62.4  -- questie:trace
  UNION ALL SELECT 920004756, -2746.79, 1081.59, 102.55  -- questie:trace
  UNION ALL SELECT 920004757, -2728.06, 1296.02, 56.26  -- questie:trace
  UNION ALL SELECT 920004758, -2717.68, 1376.38, 67.76  -- questie:trace
  UNION ALL SELECT 920004759, -2715.63, 1149.65, 81.02  -- questie:trace
  UNION ALL SELECT 920004760, -2709.61, 1099.84, 94.2  -- questie:trace
  UNION ALL SELECT 920004761, -2707.43, 1270.19, 60.11  -- questie:trace
  UNION ALL SELECT 920004762, -2703.46, 1320.21, 65.59  -- questie:trace
  UNION ALL SELECT 920004763, -2691.3, 1393.39, 103.07  -- questie:trace
  UNION ALL SELECT 920004764, -2677.77, 1296.84, 73.03  -- questie:trace
  UNION ALL SELECT 920004765, -2664.38, 1328.2, 91.23  -- questie:trace
  UNION ALL SELECT 920004766, -2662.19, 1262.61, 77.9  -- questie:trace
  UNION ALL SELECT 920004767, -2650.98, 1198.85, 82.77  -- questie:trace
  UNION ALL SELECT 920004768, -2646.06, 1290.07, 81.11  -- questie:trace
  UNION ALL SELECT 920004769, -2638.82, 1156.41, 87.55  -- questie:trace
  UNION ALL SELECT 920004770, -2626.93, 1262.61, 92.76  -- questie:trace
  UNION ALL SELECT 920004771, -2622.83, 1212.59, 86.94  -- questie:trace
  UNION ALL SELECT 920004772, -2609.16, 1159.69, 87.86  -- questie:trace
  UNION ALL SELECT 920004773, -2598.37, 1269.78, 97.68  -- questie:trace
  UNION ALL SELECT 920004774, -2592.35, 1187.99, 90.37  -- questie:trace
  UNION ALL SELECT 920004775, -2567.75, 1275.32, 110.27  -- questie:trace
  UNION ALL SELECT 920004776, -2566.52, 1166.87, 96.86  -- questie:trace
  UNION ALL SELECT 920004777, -2554.36, 1315.49, 156.27  -- questie:trace
  UNION ALL SELECT 920004778, -2551.9, 1236.37, 107.68  -- questie:trace
  UNION ALL SELECT 920004779, -2549.58, 1203.57, 100.38  -- questie:trace
  UNION ALL SELECT 920004780, -2547.8, 1141.24, 106.67  -- questie:trace
  UNION ALL SELECT 920004781, -2524.7, 1273.47, 127.5  -- questie:trace
) s
WHERE @EVERLAKE_CS254283 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS254283 = 1 AND c.`id` = 254283 AND c.`guid` BETWEEN 920004700 AND 920004781;

-- Vindael (254717, Shen'dralas, ender/giver: 93450, 93546, 96060). Faction 35 as Shen'dralas Protector (255759); 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 255759; reaction by role; spawns questie:trace';
SET @EVERLAKE_C254717 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 254717)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254717)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (138358));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 254717, 0, 0, 'Vindael', NULL, 'Blacksmith', NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 6, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C254717 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 254717, 0, 0, 0, 0, 0, 1, 1, 1, 1, 335623, 134217728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C254717 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 254717, 0, 138358, 1.15, 1, 0 FROM DUAL WHERE @EVERLAKE_C254717 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 254717, 60, 60 FROM DUAL
WHERE @EVERLAKE_C254717 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 254717);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 254717, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254717 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 254717);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 254717, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254717 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 254717, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254717 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 254717, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254717 = 1;
SET @EVERLAKE_CS254717 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254717 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 254717 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 254717);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 254717, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004782 AS `guid`, -2979.94 AS `x`, 1164.0 AS `y`, 111.21 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS254717 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS254717 = 1 AND c.`id` = 254717 AND c.`guid` BETWEEN 920004782 AND 920004782;

-- Marshal Ryan (257250, Riverglades, ender/giver: 94887, 94892). Faction 35 as Cyrus Therepentous (9459); 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 9459 (200 yd); reaction by role; spawns questie:trace';
SET @EVERLAKE_C257250 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 257250)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 257250)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (139994));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 257250, 0, 0, 'Marshal Ryan', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 0.88889, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 768, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C257250 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 257250, 0, 0, 0, 0, 0, 1, 1, 1, 1, 340318, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C257250 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 257250, 0, 139994, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C257250 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 257250, 44, 44 FROM DUAL
WHERE @EVERLAKE_C257250 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 257250);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 257250, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257250 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 257250);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 257250, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257250 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 257250, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257250 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 257250, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257250 = 1;
SET @EVERLAKE_CS257250 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 257250 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 257250 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 257250);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 257250, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004783 AS `guid`, -7785.87 AS `x`, -3159.94 AS `y`, 184.02 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS257250 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS257250 = 1 AND c.`id` = 257250 AND c.`guid` BETWEEN 920004783 AND 920004783;

-- Eastsea Bombardier (257916, Riverglades, kill: 95122). Faction 14 as Eastsea Buccaneer (257901); 86 spawn(s) from 200 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 257901; reaction by role; spawns questie:generated/questie:trace';
SET @EVERLAKE_C257916 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 257916)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 257916)
  AND (SELECT COUNT(*) = 2 FROM `creature_model_info` WHERE `DisplayID` IN (140461, 140462));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 257916, 0, 0, 'Eastsea Bombardier', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C257916 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 257916, 0, 0, 0, 0, 0, 1.2, 1, 1, 1, 341007, 134217728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C257916 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 257916, 0, 140461, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C257916 = 1
UNION ALL SELECT 257916, 1, 140462, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C257916 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 257916, 43, 44 FROM DUAL
WHERE @EVERLAKE_C257916 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 257916);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 257916, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257916 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 257916);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 257916, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257916 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 257916, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257916 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 257916, 1, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257916 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 257916, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C257916 = 1;
SET @EVERLAKE_CS257916 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 257916 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 257916 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 257916);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 257916, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004784 AS `guid`, -7831.13 AS `x`, -6077.22 AS `y`, 0.16 AS `z`  -- questie:generated
  UNION ALL SELECT 920004785, -7734.13, -6280.92, -8.85  -- questie:generated
  UNION ALL SELECT 920004786, -7721.2, -5737.72, 61.9  -- questie:generated
  UNION ALL SELECT 920004787, -7705.03, -5689.22, 61.15  -- questie:generated
  UNION ALL SELECT 920004788, -7679.17, -5723.17, 58.48  -- questie:generated
  UNION ALL SELECT 920004789, -7659.77, -5689.22, 58.53  -- questie:generated
  UNION ALL SELECT 920004790, -7646.83, -5737.72, 59.43  -- questie:generated
  UNION ALL SELECT 920004791, -7620.97, -5689.22, 59.18  -- questie:generated
  UNION ALL SELECT 920004792, -7582.17, -5698.92, 61.06  -- questie:generated
  UNION ALL SELECT 920004793, -7578.93, -5742.57, 61.27  -- questie:generated
  UNION ALL SELECT 920004794, -7559.53, -5660.12, 51.0  -- questie:generated
  UNION ALL SELECT 920004795, -7536.9, -5689.22, 58.87  -- questie:generated
  UNION ALL SELECT 920004796, -7507.8, -5752.27, 61.1  -- questie:generated
  UNION ALL SELECT 920004797, -7507.8, -5718.32, 58.66  -- questie:generated
  UNION ALL SELECT 920004798, -7491.63, -5664.97, 57.78  -- questie:generated
  UNION ALL SELECT 920004799, -7472.23, -5708.62, 58.54  -- questie:generated
  UNION ALL SELECT 920004800, -7420.5, -6280.92, -13.14  -- questie:generated
  UNION ALL SELECT 920004801, -7420.5, -5703.77, 58.03  -- questie:generated
  UNION ALL SELECT 920004802, -7300.87, -6174.22, -11.41  -- questie:generated
  UNION ALL SELECT 920004803, -7865.41, -6086.43, 1.06  -- questie:trace
  UNION ALL SELECT 920004804, -7829.52, -5611.13, 68.34  -- questie:trace
  UNION ALL SELECT 920004805, -7814.64, -5646.05, 68.87  -- questie:trace
  UNION ALL SELECT 920004806, -7809.47, -6278.98, 6.62  -- questie:trace
  UNION ALL SELECT 920004807, -7804.3, -5687.76, 69.91  -- questie:trace
  UNION ALL SELECT 920004808, -7798.15, -6352.7, -2.88  -- questie:trace
  UNION ALL SELECT 920004809, -7783.28, -5755.66, 98.47  -- questie:trace
  UNION ALL SELECT 920004810, -7778.11, -6211.56, 5.82  -- questie:trace
  UNION ALL SELECT 920004811, -7760.32, -5676.61, 60.53  -- questie:trace
  UNION ALL SELECT 920004812, -7758.71, -5778.94, 93.21  -- questie:trace
  UNION ALL SELECT 920004813, -7755.47, -5722.68, 63.49  -- questie:trace
  UNION ALL SELECT 920004814, -7751.27, -6314.38, -14.25  -- questie:trace
  UNION ALL SELECT 920004815, -7744.48, -5617.44, 57.59  -- questie:trace
  UNION ALL SELECT 920004816, -7740.92, -6228.54, 0.54  -- questie:trace
  UNION ALL SELECT 920004817, -7736.72, -6150.45, -0.18  -- questie:trace
  UNION ALL SELECT 920004818, -7717.32, -6182.46, -4.13  -- questie:trace
  UNION ALL SELECT 920004819, -7703.09, -6312.93, -10.28  -- questie:trace
  UNION ALL SELECT 920004820, -7700.51, -5794.46, 63.02  -- questie:trace
  UNION ALL SELECT 920004821, -7684.66, -6253.76, -0.53  -- questie:trace
  UNION ALL SELECT 920004822, -7675.93, -5588.82, 38.28  -- questie:trace
  UNION ALL SELECT 920004823, -7670.11, -5769.24, 60.88  -- questie:trace
  UNION ALL SELECT 920004824, -7663.65, -5810.47, 81.29  -- questie:trace
  UNION ALL SELECT 920004825, -7650.07, -6245.03, 0.68  -- questie:trace
  UNION ALL SELECT 920004826, -7643.6, -5611.13, 39.37  -- questie:trace
  UNION ALL SELECT 920004827, -7640.04, -5659.15, 57.54  -- questie:trace
  UNION ALL SELECT 920004828, -7606.74, -5607.74, 48.24  -- questie:trace
  UNION ALL SELECT 920004829, -7601.57, -5774.58, 76.78  -- questie:trace
  UNION ALL SELECT 920004830, -7576.35, -5569.42, 59.31  -- questie:trace
  UNION ALL SELECT 920004831, -7559.53, -5613.56, 37.4  -- questie:trace
  UNION ALL SELECT 920004832, -7545.95, -5724.14, 59.25  -- questie:trace
  UNION ALL SELECT 920004833, -7535.28, -6200.89, -6.17  -- questie:trace
  UNION ALL SELECT 920004834, -7526.55, -5600.95, 33.95  -- questie:trace
  UNION ALL SELECT 920004835, -7512.33, -5502.01, 58.72  -- questie:trace
  UNION ALL SELECT 920004836, -7490.34, -6260.06, -12.86  -- questie:trace
  UNION ALL SELECT 920004837, -7488.4, -6223.69, -6.29  -- questie:trace
  UNION ALL SELECT 920004838, -7487.43, -5780.4, 63.87  -- questie:trace
  UNION ALL SELECT 920004839, -7479.35, -6166.94, 0.55  -- questie:trace
  UNION ALL SELECT 920004840, -7476.44, -5592.7, 57.97  -- questie:trace
  UNION ALL SELECT 920004841, -7475.47, -5630.53, 57.15  -- questie:trace
  UNION ALL SELECT 920004842, -7468.68, -5551.96, 59.6  -- questie:trace
  UNION ALL SELECT 920004843, -7458.98, -5806.1, 69.59  -- questie:trace
  UNION ALL SELECT 920004844, -7458.33, -6302.26, -13.39  -- questie:trace
  UNION ALL SELECT 920004845, -7455.42, -6256.67, -11.04  -- questie:trace
  UNION ALL SELECT 920004846, -7450.57, -5755.66, 58.95  -- questie:trace
  UNION ALL SELECT 920004847, -7448.95, -5683.88, 57.54  -- questie:trace
  UNION ALL SELECT 920004848, -7447.98, -6208.17, -2.35  -- questie:trace
  UNION ALL SELECT 920004849, -7420.18, -5638.78, 59.48  -- questie:trace
  UNION ALL SELECT 920004850, -7411.12, -5763.42, 54.27  -- questie:trace
  UNION ALL SELECT 920004851, -7407.57, -6139.78, -6.04  -- questie:trace
  UNION ALL SELECT 920004852, -7402.39, -5798.34, 69.58  -- questie:trace
  UNION ALL SELECT 920004853, -7398.84, -6252.79, 0.33  -- questie:trace
  UNION ALL SELECT 920004854, -7393.99, -5598.52, 73.12  -- questie:trace
  UNION ALL SELECT 920004855, -7377.82, -5652.84, 72.92  -- questie:trace
  UNION ALL SELECT 920004856, -7372.0, -6201.38, 6.39  -- questie:trace
  UNION ALL SELECT 920004857, -7371.03, -5769.73, 49.36  -- questie:trace
  UNION ALL SELECT 920004858, -7366.5, -6080.61, -7.82  -- questie:trace
  UNION ALL SELECT 920004859, -7357.77, -6251.33, 0.36  -- questie:trace
  UNION ALL SELECT 920004860, -7356.16, -6165.49, 4.6  -- questie:trace
  UNION ALL SELECT 920004861, -7350.34, -5708.13, 58.6  -- questie:trace
  UNION ALL SELECT 920004862, -7348.07, -6295.47, -19.56  -- questie:trace
  UNION ALL SELECT 920004863, -7345.16, -6107.29, -7.89  -- questie:trace
  UNION ALL SELECT 920004864, -7342.25, -5795.92, 39.88  -- questie:trace
  UNION ALL SELECT 920004865, -7339.34, -6051.03, 1.42  -- questie:trace
  UNION ALL SELECT 920004866, -7307.01, -6223.2, -10.94  -- questie:trace
  UNION ALL SELECT 920004867, -7306.69, -6278.01, -18.03  -- questie:trace
  UNION ALL SELECT 920004868, -7296.02, -6072.37, 0.64  -- questie:trace
  UNION ALL SELECT 920004869, -7288.26, -6124.75, -14.15  -- questie:trace
) s
WHERE @EVERLAKE_CS257916 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS257916 = 1 AND c.`id` = 257916 AND c.`guid` BETWEEN 920004784 AND 920004869;

-- Dunston Willis (259057, Riverglades, ender/giver: 94927, 96126). Faction 7 as Gobam (257058); 1 spawn(s) from 4 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 257058 (200 yd); neutral NPC with a service; reaction by role; spawns polestar';
SET @EVERLAKE_C259057 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 259057)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259057)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (141307));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 259057, 0, 0, 'Dunston Willis', NULL, NULL, NULL, NULL, 0, 0, 7, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C259057 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 259057, 0, 0, 0, 0, 0, 2, 1, 1, 1, 342237, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C259057 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 259057, 0, 141307, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C259057 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 259057, 44, 44 FROM DUAL
WHERE @EVERLAKE_C259057 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 259057);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 259057, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259057 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 259057);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 259057, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259057 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 259057, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259057 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 259057, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C259057 = 1;
SET @EVERLAKE_CS259057 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 259057 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 259057 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 259057);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 259057, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004870 AS `guid`, -6880.5 AS `x`, -5219 AS `y`, 111.11 AS `z`  -- polestar
) s
WHERE @EVERLAKE_CS259057 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS259057 = 1 AND c.`id` = 259057 AND c.`guid` BETWEEN 920004870 AND 920004870;

-- Twilight Mauler (260968, Riverglades, kill: 95424). Faction 14 as Eastsea Musketeer (257910); 70 spawn(s) from 106 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 257910; reaction by role; spawns polestar/questie:trace';
SET @EVERLAKE_C260968 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 260968)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260968)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (142910));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 260968, 0, 0, 'Twilight Mauler', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C260968 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 260968, 0, 0, 0, 0, 0, 1.4, 1.1, 1, 1, 344176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C260968 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 260968, 0, 142910, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C260968 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 260968, 41, 42 FROM DUAL
WHERE @EVERLAKE_C260968 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 260968);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 260968, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260968 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 260968);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 260968, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260968 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260968, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260968 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 260968, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260968 = 1;
SET @EVERLAKE_CS260968 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260968 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260968 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260968);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260968, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004871 AS `guid`, -7455.5 AS `x`, -5552 AS `y`, 59.55 AS `z`  -- polestar
  UNION ALL SELECT 920004872, -7607.71, -5376.88, 58.01  -- questie:trace
  UNION ALL SELECT 920004873, -7590.25, -5403.07, 55.68  -- questie:trace
  UNION ALL SELECT 920004874, -7576.99, -5576.21, 58.84  -- questie:trace
  UNION ALL SELECT 920004875, -7568.26, -5359.9, 57.23  -- questie:trace
  UNION ALL SELECT 920004876, -7559.21, -5661.57, 52.04  -- questie:trace
  UNION ALL SELECT 920004877, -7558.89, -5395.79, 57.56  -- questie:trace
  UNION ALL SELECT 920004878, -7547.89, -5532.56, 56.9  -- questie:trace
  UNION ALL SELECT 920004879, -7543.69, -5310.92, 57.48  -- questie:trace
  UNION ALL SELECT 920004880, -7537.55, -5193.55, 58.5  -- questie:trace
  UNION ALL SELECT 920004881, -7535.61, -5431.68, 59.21  -- questie:trace
  UNION ALL SELECT 920004882, -7527.85, -5685.82, 58.41  -- questie:trace
  UNION ALL SELECT 920004883, -7526.55, -5238.17, 58.64  -- questie:trace
  UNION ALL SELECT 920004884, -7521.06, -5286.18, 57.47  -- questie:trace
  UNION ALL SELECT 920004885, -7518.47, -5616.95, 38.79  -- questie:trace
  UNION ALL SELECT 920004886, -7518.47, -5390.94, 57.15  -- questie:trace
  UNION ALL SELECT 920004887, -7516.53, -5352.63, 57.09  -- questie:trace
  UNION ALL SELECT 920004888, -7512.33, -5484.55, 58.55  -- questie:trace
  UNION ALL SELECT 920004889, -7509.09, -5114.49, 55.47  -- questie:trace
  UNION ALL SELECT 920004890, -7508.45, -5587.85, 49.9  -- questie:trace
  UNION ALL SELECT 920004891, -7503.6, -5672.73, 58.56  -- questie:trace
  UNION ALL SELECT 920004892, -7497.45, -5241.08, 58.94  -- questie:trace
  UNION ALL SELECT 920004893, -7497.13, -5635.38, 53.73  -- questie:trace
  UNION ALL SELECT 920004894, -7496.81, -5515.1, 54.8  -- questie:trace
  UNION ALL SELECT 920004895, -7492.93, -5705.71, 58.38  -- questie:trace
  UNION ALL SELECT 920004896, -7491.63, -5428.29, 63.77  -- questie:trace
  UNION ALL SELECT 920004897, -7487.75, -5141.17, 56.98  -- questie:trace
  UNION ALL SELECT 920004898, -7485.81, -5182.39, 57.1  -- questie:trace
  UNION ALL SELECT 920004899, -7483.23, -5598.04, 56.83  -- questie:trace
  UNION ALL SELECT 920004900, -7480.32, -5354.57, 59.25  -- questie:trace
  UNION ALL SELECT 920004901, -7479.02, -5293.46, 58.38  -- questie:trace
  UNION ALL SELECT 920004902, -7473.53, -5402.58, 62.83  -- questie:trace
  UNION ALL SELECT 920004903, -7471.26, -5249.81, 61.47  -- questie:trace
  UNION ALL SELECT 920004904, -7470.94, -5630.53, 56.96  -- questie:trace
  UNION ALL SELECT 920004905, -7468.35, -5665.45, 57.97  -- questie:trace
  UNION ALL SELECT 920004906, -7467.71, -5748.87, 59.54  -- questie:trace
  UNION ALL SELECT 920004907, -7465.12, -5222.65, 57.18  -- questie:trace
  UNION ALL SELECT 920004908, -7460.27, -5144.56, 57.19  -- questie:trace
  UNION ALL SELECT 920004909, -7453.48, -5373.97, 61.66  -- questie:trace
  UNION ALL SELECT 920004910, -7450.57, -5698.92, 58.48  -- questie:trace
  UNION ALL SELECT 920004911, -7447.98, -5614.53, 58.5  -- questie:trace
  UNION ALL SELECT 920004912, -7444.1, -5766.82, 59.63  -- questie:trace
  UNION ALL SELECT 920004913, -7440.87, -5170.27, 57.77  -- questie:trace
  UNION ALL SELECT 920004914, -7436.99, -5728.99, 58.82  -- questie:trace
  UNION ALL SELECT 920004915, -7434.4, -5213.92, 63.62  -- questie:trace
  UNION ALL SELECT 920004916, -7428.91, -5639.26, 59.02  -- questie:trace
  UNION ALL SELECT 920004917, -7424.06, -5672.73, 60.04  -- questie:trace
  UNION ALL SELECT 920004918, -7413.06, -5540.32, 77.09  -- questie:trace
  UNION ALL SELECT 920004919, -7412.09, -5612.1, 62.91  -- questie:trace
  UNION ALL SELECT 920004920, -7409.18, -5747.42, 54.05  -- questie:trace
  UNION ALL SELECT 920004921, -7404.01, -5147.96, 62.77  -- questie:trace
  UNION ALL SELECT 920004922, -7402.72, -5211.49, 65.12  -- questie:trace
  UNION ALL SELECT 920004923, -7397.54, -5283.27, 57.71  -- questie:trace
  UNION ALL SELECT 920004924, -7392.37, -5186.76, 57.88  -- questie:trace
  UNION ALL SELECT 920004925, -7390.75, -5643.63, 64.58  -- questie:trace
  UNION ALL SELECT 920004926, -7387.2, -5562.63, 76.8  -- questie:trace
  UNION ALL SELECT 920004927, -7375.88, -5164.93, 61.08  -- questie:trace
  UNION ALL SELECT 920004928, -7374.26, -5714.92, 56.33  -- questie:trace
  UNION ALL SELECT 920004929, -7371.03, -5625.2, 69.61  -- questie:trace
  UNION ALL SELECT 920004930, -7367.47, -5595.61, 75.39  -- questie:trace
  UNION ALL SELECT 920004931, -7363.27, -5683.88, 64.16  -- questie:trace
  UNION ALL SELECT 920004932, -7359.71, -5655.27, 80.02  -- questie:trace
  UNION ALL SELECT 920004933, -7353.89, -5780.4, 45.35  -- questie:trace
  UNION ALL SELECT 920004934, -7348.07, -5752.27, 50.18  -- questie:trace
  UNION ALL SELECT 920004935, -7347.43, -5705.22, 61.12  -- questie:trace
  UNION ALL SELECT 920004936, -7347.1, -5160.57, 61.01  -- questie:trace
  UNION ALL SELECT 920004937, -7346.78, -5614.04, 74.38  -- questie:trace
  UNION ALL SELECT 920004938, -7331.26, -5682.43, 74.62  -- questie:trace
  UNION ALL SELECT 920004939, -7330.94, -5647.02, 75.44  -- questie:trace
  UNION ALL SELECT 920004940, -7301.19, -5660.6, 75.62  -- questie:trace
) s
WHERE @EVERLAKE_CS260968 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS260968 = 1 AND c.`id` = 260968 AND c.`guid` BETWEEN 920004871 AND 920004940;

-- Crag'rog (260993, Riverglades, ender/giver: 95431, 95432, 95433). Faction 35 as Cyrus Therepentous (9459); 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 9459 (200 yd); reaction by role; spawns questie:trace';
SET @EVERLAKE_C260993 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 260993)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260993)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (11545));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 260993, 0, 0, 'Crag''rog', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 0.88889, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 768, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C260993 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 260993, 0, 0, 0, 0, 0, 1.4, 1, 1, 1, 344201, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C260993 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 260993, 0, 11545, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C260993 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 260993, 42, 42 FROM DUAL
WHERE @EVERLAKE_C260993 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 260993);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 260993, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260993 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 260993);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 260993, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260993 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260993, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260993 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 260993, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260993 = 1;
SET @EVERLAKE_CS260993 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260993 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260993 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260993);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260993, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004941 AS `guid`, -7648.13 AS `x`, -3233.18 AS `y`, 180.48 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS260993 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS260993 = 1 AND c.`id` = 260993 AND c.`guid` BETWEEN 920004941 AND 920004941;

-- Twilight Subjugator (260996, Riverglades, kill: 96015). Faction 14 as Twilight Fanatic (256795); 11 spawn(s) from 25 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 256795 (200 yd); reaction by role; spawns questie:trace';
SET @EVERLAKE_C260996 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 260996)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260996)
  AND (SELECT COUNT(*) = 2 FROM `creature_model_info` WHERE `DisplayID` IN (140328, 2896));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 260996, 0, 0, 'Twilight Subjugator', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C260996 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 260996, 0, 0, 0, 0, 0, 1, 1, 1, 1, 344204, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C260996 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 260996, 0, 140328, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C260996 = 1
UNION ALL SELECT 260996, 1, 2896, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C260996 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 260996, 41, 42 FROM DUAL
WHERE @EVERLAKE_C260996 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 260996);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 260996, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260996 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 260996);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 260996, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260996 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260996, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260996 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260996, 1, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260996 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 260996, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260996 = 1;
SET @EVERLAKE_CS260996 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260996 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260996 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260996);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260996, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004942 AS `guid`, -7723.14 AS `x`, -3247.73 AS `y`, 178.73 AS `z`  -- questie:trace
  UNION ALL SELECT 920004943, -7716.03, -3310.78, 187.08  -- questie:trace
  UNION ALL SELECT 920004944, -7690.81, -3252.58, 177.02  -- questie:trace
  UNION ALL SELECT 920004945, -7671.73, -3274.89, 174.28  -- questie:trace
  UNION ALL SELECT 920004946, -7670.11, -3304.96, 174.1  -- questie:trace
  UNION ALL SELECT 920004947, -7649.42, -3334.54, 175.67  -- questie:trace
  UNION ALL SELECT 920004948, -7648.13, -3226.87, 179.94  -- questie:trace
  UNION ALL SELECT 920004949, -7630.67, -3290.89, 184.31  -- questie:trace
  UNION ALL SELECT 920004950, -7615.15, -3319.02, 186.7  -- questie:trace
  UNION ALL SELECT 920004951, -7605.45, -3350.06, 188.51  -- questie:trace
  UNION ALL SELECT 920004952, -7571.5, -3377.22, 207.32  -- questie:trace
) s
WHERE @EVERLAKE_CS260996 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS260996 = 1 AND c.`id` = 260996 AND c.`guid` BETWEEN 920004942 AND 920004952;

-- Twilight Firecaller (261497, Riverglades, kill: 95424). Faction 14 as Eastsea Buccaneer (257901); 24 spawn(s) from 43 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 257901; reaction by role; spawns questie:trace';
SET @EVERLAKE_C261497 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261497)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261497)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (142909));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261497, 0, 0, 'Twilight Firecaller', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261497 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261497, 0, 0, 0, 0, 0, 1.2, 1.15, 1, 1, 344736, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261497 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261497, 0, 142909, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261497 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261497, 40, 41 FROM DUAL
WHERE @EVERLAKE_C261497 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261497);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261497, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261497 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 261497);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261497, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261497 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261497, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261497 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261497, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261497 = 1;
SET @EVERLAKE_CS261497 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261497 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 261497 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 261497);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261497, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004953 AS `guid`, -7581.52 AS `x`, -5582.03 AS `y`, 59.02 AS `z`  -- questie:trace
  UNION ALL SELECT 920004954, -7543.04, -5474.36, 56.02  -- questie:trace
  UNION ALL SELECT 920004955, -7514.91, -5458.84, 58.11  -- questie:trace
  UNION ALL SELECT 920004956, -7503.6, -5509.77, 57.53  -- questie:trace
  UNION ALL SELECT 920004957, -7485.81, -5530.62, 57.39  -- questie:trace
  UNION ALL SELECT 920004958, -7479.02, -5626.65, 56.69  -- questie:trace
  UNION ALL SELECT 920004959, -7472.23, -5599.49, 57.7  -- questie:trace
  UNION ALL SELECT 920004960, -7468.35, -5659.15, 58.1  -- questie:trace
  UNION ALL SELECT 920004961, -7453.16, -5690.19, 58.31  -- questie:trace
  UNION ALL SELECT 920004962, -7449.6, -5576.7, 59.37  -- questie:trace
  UNION ALL SELECT 920004963, -7440.55, -5617.92, 58.58  -- questie:trace
  UNION ALL SELECT 920004964, -7426.64, -5558.75, 74.85  -- questie:trace
  UNION ALL SELECT 920004965, -7421.79, -5652.84, 60.44  -- questie:trace
  UNION ALL SELECT 920004966, -7419.21, -5599.01, 63.64  -- questie:trace
  UNION ALL SELECT 920004967, -7408.86, -5677.09, 60.71  -- questie:trace
  UNION ALL SELECT 920004968, -7404.66, -5714.44, 57.46  -- questie:trace
  UNION ALL SELECT 920004969, -7393.02, -5654.78, 65.54  -- questie:trace
  UNION ALL SELECT 920004970, -7390.75, -5626.17, 66.2  -- questie:trace
  UNION ALL SELECT 920004971, -7387.84, -5560.21, 76.85  -- questie:trace
  UNION ALL SELECT 920004972, -7382.67, -5587.37, 77.73  -- questie:trace
  UNION ALL SELECT 920004973, -7361.01, -5606.77, 73.41  -- questie:trace
  UNION ALL SELECT 920004974, -7359.07, -5650.9, 78.8  -- questie:trace
  UNION ALL SELECT 920004975, -7329.97, -5679.52, 75.45  -- questie:trace
  UNION ALL SELECT 920004976, -7327.38, -5634.9, 75.53  -- questie:trace
) s
WHERE @EVERLAKE_CS261497 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS261497 = 1 AND c.`id` = 261497 AND c.`guid` BETWEEN 920004953 AND 920004976;

-- Empowered Brute (261711, Riverglades, kill: 95601, 95643). Faction 16 as Twilight Shadowmancer (254560); 4 spawn(s) from 40 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 254560; reaction by role; spawns questie:trace';
SET @EVERLAKE_C261711 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 261711)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261711)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (142910));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 261711, 262006, 0, 'Empowered Brute', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C261711 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 261711, 0, 0, 0, 0, 0, 1.4, 1, 1, 1, 344950, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C261711 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 261711, 0, 142910, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C261711 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 261711, 38, 39 FROM DUAL
WHERE @EVERLAKE_C261711 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 261711);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 261711, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261711 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 261711);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 261711, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261711 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 261711, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261711 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 261711, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C261711 = 1;
SET @EVERLAKE_CS261711 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 261711 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 261711 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 261711);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 261711, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004977 AS `guid`, -8067.17 AS `x`, -4230.82 AS `y`, 24.4 AS `z`  -- questie:trace
  UNION ALL SELECT 920004978, -7991.51, -4364.68, 38.92  -- questie:trace
  UNION ALL SELECT 920004979, -7950.12, -4310.85, 25.73  -- questie:trace
  UNION ALL SELECT 920004980, -7936.54, -4217.24, 24.85  -- questie:trace
) s
WHERE @EVERLAKE_CS261711 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS261711 = 1 AND c.`id` = 261711 AND c.`guid` BETWEEN 920004977 AND 920004980;

-- Twilight Ritualist (262169, Riverglades, kill: 95601, 95643). Faction 16 as Twilight Shadowmancer (254560); 8 spawn(s) from 46 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels questie:trace; faction/speeds from 254560; reaction by role; spawns questie:trace';
SET @EVERLAKE_C262169 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262169)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262169)
  AND (SELECT COUNT(*) = 4 FROM `creature_model_info` WHERE `DisplayID` IN (138242, 139814, 140328, 143078));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262169, 262006, 0, 'Twilight Ritualist', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262169 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262169, 0, 0, 0, 0, 0, 1, 1, 1, 1, 345441, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262169 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262169, 0, 143078, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262169 = 1
UNION ALL SELECT 262169, 1, 139814, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262169 = 1
UNION ALL SELECT 262169, 2, 138242, 1, 0.75, 0 FROM DUAL WHERE @EVERLAKE_C262169 = 1
UNION ALL SELECT 262169, 3, 140328, 1, 0.75, 0 FROM DUAL WHERE @EVERLAKE_C262169 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262169, 39, 41 FROM DUAL
WHERE @EVERLAKE_C262169 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262169);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262169, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262169 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 262169);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262169, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262169 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262169, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262169 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262169, 1, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262169 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262169, 2, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262169 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262169, 3, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262169 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262169, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262169 = 1;
SET @EVERLAKE_CS262169 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262169 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 262169 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 262169);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262169, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004981 AS `guid`, -8098.53 AS `x`, -4185.23 AS `y`, 29.12 AS `z`  -- questie:trace
  UNION ALL SELECT 920004982, -8058.44, -4232.76, 24.9  -- questie:trace
  UNION ALL SELECT 920004983, -7986.98, -4370.5, 38.27  -- questie:trace
  UNION ALL SELECT 920004984, -7954.97, -4311.33, 26.08  -- questie:trace
  UNION ALL SELECT 920004985, -7953.03, -4238.1, 24.97  -- questie:trace
  UNION ALL SELECT 920004986, -7940.42, -4403.0, 32.24  -- questie:trace
  UNION ALL SELECT 920004987, -7926.52, -4363.71, 32.0  -- questie:trace
  UNION ALL SELECT 920004988, -7906.47, -4251.19, 26.8  -- questie:trace
) s
WHERE @EVERLAKE_CS262169 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS262169 = 1 AND c.`id` = 262169 AND c.`guid` BETWEEN 920004981 AND 920004988;

-- Nascent Pylon Protector (276401, Shen'dralas, kill: 99258). Faction 7 as Malevolent Marigold (254572); 48 spawn(s) from 159 points.
SET @EVERLAKE_NOTE := 'eglink@70938 creature_details; levels wowhead; faction/speeds from 254572; reaction by role; spawns questie:trace/wowhead';
SET @EVERLAKE_C276401 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 276401)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 276401)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (14252));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 276401, 0, 0, 'Nascent Pylon Protector', NULL, NULL, NULL, NULL, 0, 0, 7, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 8, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C276401 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 276401, 0, 0, 0, 0, 0, 3, 2, 1, 1, 360305, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C276401 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 276401, 0, 14252, 1.25, 1, 0 FROM DUAL WHERE @EVERLAKE_C276401 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 276401, 43, 43 FROM DUAL
WHERE @EVERLAKE_C276401 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 276401);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 276401, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C276401 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 276401);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 276401, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C276401 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 276401, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C276401 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 276401, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C276401 = 1;
SET @EVERLAKE_CS276401 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 276401 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 276401 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 276401);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 276401, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 600, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920004989 AS `guid`, -2800.63 AS `x`, 977.45 AS `y`, 124.31 AS `z`  -- wowhead
  UNION ALL SELECT 920004990, -2720.0, 1065.6, 98.0  -- wowhead
  UNION ALL SELECT 920004991, -2715.9, 1153.75, 83.61  -- wowhead
  UNION ALL SELECT 920004992, -2689.93, 1041.0, 95.55  -- wowhead
  UNION ALL SELECT 920004993, -2644.83, 1092.25, 98.8  -- wowhead
  UNION ALL SELECT 920004994, -2535.5, 1252.15, 116.09  -- wowhead
  UNION ALL SELECT 920004995, -3103.9, 989.55, 138.98  -- questie:trace
  UNION ALL SELECT 920004996, -3044.99, 924.76, 119.46  -- questie:trace
  UNION ALL SELECT 920004997, -3000.03, 829.64, 111.46  -- questie:trace
  UNION ALL SELECT 920004998, -2970.65, 850.56, 112.21  -- questie:trace
  UNION ALL SELECT 920004999, -2901.22, 733.3, 111.57  -- questie:trace
  UNION ALL SELECT 920005000, -2872.25, 719.15, 113.45  -- questie:trace
  UNION ALL SELECT 920005001, -2815.94, 908.78, 105.28  -- questie:trace
  UNION ALL SELECT 920005002, -2793.94, 935.01, 110.21  -- questie:trace
  UNION ALL SELECT 920005003, -2789.02, 1013.12, 117.07  -- questie:trace
  UNION ALL SELECT 920005004, -2780.82, 1063.35, 104.97  -- questie:trace
  UNION ALL SELECT 920005005, -2751.43, 1050.43, 103.79  -- questie:trace
  UNION ALL SELECT 920005006, -2741.05, 1125.87, 87.39  -- questie:trace
  UNION ALL SELECT 920005007, -2711.66, 1272.45, 58.72  -- questie:trace
  UNION ALL SELECT 920005008, -2702.37, 1103.32, 94.27  -- questie:trace
  UNION ALL SELECT 920005009, -2695.95, 1238.82, 61.03  -- questie:trace
  UNION ALL SELECT 920005010, -2683.51, 1075.64, 94.88  -- questie:trace
  UNION ALL SELECT 920005011, -2680.09, 1175.89, 94.85  -- questie:trace
  UNION ALL SELECT 920005012, -2680.09, 1282.08, 66.39  -- questie:trace
  UNION ALL SELECT 920005013, -2669.02, 1123.62, 93.63  -- questie:trace
  UNION ALL SELECT 920005014, -2667.25, 987.09, 85.47  -- questie:trace
  UNION ALL SELECT 920005015, -2665.74, 703.98, 90.22  -- questie:trace
  UNION ALL SELECT 920005016, -2656.72, 1044.89, 98.06  -- questie:trace
  UNION ALL SELECT 920005017, -2642.92, 963.1, 90.71  -- questie:trace
  UNION ALL SELECT 920005018, -2641.69, 1235.95, 89.25  -- questie:trace
  UNION ALL SELECT 920005019, -2631.3, 1154.16, 87.79  -- questie:trace
  UNION ALL SELECT 920005020, -2627.48, 1343.99, 101.06  -- questie:trace
  UNION ALL SELECT 920005021, -2620.1, 1067.65, 101.28  -- questie:trace
  UNION ALL SELECT 920005022, -2612.58, 941.37, 97.21  -- questie:trace
  UNION ALL SELECT 920005023, -2608.48, 1257.89, 95.36  -- questie:trace
  UNION ALL SELECT 920005024, -2606.98, 1176.1, 88.06  -- questie:trace
  UNION ALL SELECT 920005025, -2591.26, 1230.62, 96.41  -- questie:trace
  UNION ALL SELECT 920005026, -2590.03, 1111.11, 100.5  -- questie:trace
  UNION ALL SELECT 920005027, -2589.48, 915.34, 104.64  -- questie:trace
  UNION ALL SELECT 920005028, -2584.43, 1074.01, 103.99  -- questie:trace
  UNION ALL SELECT 920005029, -2551.9, 1067.44, 117.32  -- questie:trace
  UNION ALL SELECT 920005030, -2541.51, 1215.05, 104.57  -- questie:trace
  UNION ALL SELECT 920005031, -2531.4, 1162.97, 110.29  -- questie:trace
  UNION ALL SELECT 920005032, -2504.34, 1265.07, 129.88  -- questie:trace
  UNION ALL SELECT 920005033, -2489.03, 1033.01, 135.37  -- questie:trace
  UNION ALL SELECT 920005034, -2445.57, 1075.44, 128.44  -- questie:trace
  UNION ALL SELECT 920005035, -2414.14, 1092.45, 128.7  -- questie:trace
  UNION ALL SELECT 920005036, -2399.38, 988.52, 155.56  -- questie:trace
) s
WHERE @EVERLAKE_CS276401 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS276401 = 1 AND c.`id` = 276401 AND c.`guid` BETWEEN 920004989 AND 920005036;

-- Abigail Lawson (278088, Riverglades, ender: 94893). Faction 12 as Arthur the Faithful (5491); 1 spawn(s) from 1 points.
SET @EVERLAKE_NOTE := 'eglink@70959 creature_details; levels questie:trace; faction/speeds from 5491; reaction by role; spawns questie:trace';
SET @EVERLAKE_C278088 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 278088)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 278088)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (3485));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 278088, 0, 0, 'Abigail Lawson', NULL, NULL, NULL, NULL, 0, 0, 12, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 512, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C278088 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 278088, 0, 0, 0, 0, 0, 1, 1, 1, 1, 362168, 134217728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C278088 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 278088, 0, 3485, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C278088 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 278088, 10, 10 FROM DUAL
WHERE @EVERLAKE_C278088 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 278088);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 278088, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C278088 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 278088);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 278088, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C278088 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 278088, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C278088 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 278088, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C278088 = 1;
SET @EVERLAKE_CS278088 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 278088 AND `file` = '2026_11_18_929_world_everlake_south_quest_npcs.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 278088 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 278088);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 278088, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920005037 AS `guid`, -8592.95 AS `x`, 852.08 AS `y`, 97.04 AS `z`  -- questie:trace
) s
WHERE @EVERLAKE_CS278088 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS278088 = 1 AND c.`id` = 278088 AND c.`guid` BETWEEN 920005037 AND 920005037;

-- Satyrweed Quest Dummy (236987): credit for 86812, 86813, given by client spell 1217127. Template only.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; credit spell 1217127 (client SpellEffect)';
SET @EVERLAKE_K236987 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 236987)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236987)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (1126));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 236987, 0, 0, 'Satyrweed Quest Dummy', NULL, NULL, NULL, NULL, 0, 0, 35, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 33554434, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 128, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_K236987 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 236987, 0, 1126, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_K236987 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 236987, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_K236987 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 236987);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 236987, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_K236987 = 1;

-- [DNT] Kill Credit: Speak with Mordent Evenshade (253623): credit for 93016, given by client spell 1259496. Template only.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; credit spell 1259496 (client SpellEffect)';
SET @EVERLAKE_K253623 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 253623)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 253623)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (52318));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 253623, 0, 0, '[DNT] Kill Credit: Speak with Mordent Evenshade', NULL, NULL, NULL, NULL, 0, 0, 35, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 33554434, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 128, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_K253623 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 253623, 0, 52318, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_K253623 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 253623, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_K253623 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 253623);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 253623, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_K253623 = 1;

-- [DNT] Kill Credit: Shen'dralas wildlife slain with the blade (263491): credit for 96060, given by client spell 1289866. Template only.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; credit spell 1289866 (client SpellEffect)';
SET @EVERLAKE_K263491 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 263491)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 263491)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (52318));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 263491, 0, 0, '[DNT] Kill Credit: Shen''dralas wildlife slain with the blade', NULL, NULL, NULL, NULL, 0, 0, 35, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 33554434, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 128, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_K263491 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 263491, 0, 52318, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_K263491 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 263491, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_K263491 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 263491);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 263491, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_K263491 = 1;

-- [DNT] Kill Credit: Twilight Thrall (271293): credit for 94907, given by client spell 1283133. Template only.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; credit spell 1283133 (client SpellEffect)';
SET @EVERLAKE_K271293 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 271293)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 271293)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (52318));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 271293, 0, 0, '[DNT] Kill Credit: Twilight Thrall', NULL, NULL, NULL, NULL, 0, 0, 35, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 33554434, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 128, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_K271293 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 271293, 0, 52318, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_K271293 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 271293, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_K271293 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 271293);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 271293, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_K271293 = 1;

-- [DNT] Kill Credit (272737): credit for 94748, 94888, given by client spell 1277271. Template only.
SET @EVERLAKE_NOTE := 'DatabaseForever e0b21a2 creature_template/model; credit spell 1277271 (client SpellEffect)';
SET @EVERLAKE_K272737 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 272737)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 272737)
  AND (SELECT COUNT(*) = 1 FROM `creature_model_info` WHERE `DisplayID` IN (11686));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 272737, 0, 0, '[DNT] Kill Credit', NULL, NULL, NULL, NULL, 0, 0, 35, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 33554434, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 128, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_K272737 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 272737, 0, 11686, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_K272737 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 272737, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_K272737 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 272737);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 272737, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_K272737 = 1;

COMMIT;
