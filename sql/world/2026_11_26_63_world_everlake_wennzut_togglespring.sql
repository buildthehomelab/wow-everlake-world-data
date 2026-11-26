-- Wennzut Togglespring (249550), who gives 92094 Rocket Gnomes ("Wennzut Togglespring lost sight of his brother,
-- Fenwick, floating in his parachute into Hyjal"). The quest is taken by his brother Fenwick (249549) in Mount Hyjal, but
-- the realm had no Wennzut, so nobody gave it. 2026-11-26.
-- 2026_11_26_63_world_everlake_wennzut_togglespring.sql: written by hand from the tracker's kept facts, not tried in game.
--
-- Sources:
--   Wowhead Forever quest 92094, comment 6478099: the quest starts at Wennzut Togglespring (npc=249550), "in the
--     mountains between Winterspring and Felwood", reached by the old Dancing Troll Village path.
--   Icy Veins npc=249550: name, humanoid (type 7), unit class 2, health multiplier 1.05, display 146930 (scale 1),
--     level 57 (UiMap 1452), and two sightings on the Winterspring map (UiMap 1452) at 26.83 43.99 (1 player) and
--     27.63 44.11 (2 players).
--   Client CreatureDisplayInfo: display 146930 uses model 6837, the model of Fenwick's display 131979, so its
--     creature_model_info (bounding radius 0.306, reach 1.5) is copied from 131979.
-- One spawn at the sighting seen by two players: 27.63 44.11 -> map 1 6445.46 -2278.40, height 634.15 from the realm's
--   maps (ForeverTracker tools/height.py --zone 618, terrain). The other sighting is 57 yards off.
-- INFERRED, as for his brother Fenwick on the realm: faction 12, speeds, attack times, no subname, orientation 0,
--   respawn 300 s. No AI, no gossip text: he only gives the quest.
--
-- Guid: creature 920019810 (this group's block 920019800-920020199).
-- No template is added where the realm already has one; the spawn only while the template is this file's.
-- Each added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_26_63_world_everlake_wennzut_togglespring.sql';

START TRANSACTION;

SET @EVERLAKE_M146930 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 146930);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 146930, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M146930 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 146930, 0, 0, 0, @EVERLAKE_FILE, 'copied from display 131979 (same model 6837)' FROM DUAL WHERE @EVERLAKE_M146930 = 1;

SET @EVERLAKE_NOTE := 'Icy Veins npc=249550 + Wowhead quest 92094 comment 6478099; faction/speeds as Fenwick 249549 (INFERRED)';
SET @EVERLAKE_C249550 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 249550)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249550);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 249550, 0, 0, 'Wennzut Togglespring', NULL, NULL, NULL, NULL, 0, 0, 12, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 2, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C249550 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 249550, 0, 0, 0, 0, 0, 1.05, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C249550 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 249550, 0, 146930, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C249550 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 249550, 57, 57 FROM DUAL
WHERE @EVERLAKE_C249550 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 249550);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 249550, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249550 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249550);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 249550, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249550 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 249550, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249550 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 249550, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249550 = 1;

SET @EVERLAKE_CS249550 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249550 AND `file` = '2026_11_26_63_world_everlake_wennzut_togglespring.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 249550 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 249550);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920019810, 249550, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 6445.46, -2278.40, 634.15, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM DUAL WHERE @EVERLAKE_CS249550 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = 920019810);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins sighting 27.63 44.11 (UiMap 1452); height.py' FROM `creature` c
WHERE @EVERLAKE_CS249550 = 1 AND c.`id` = 249550 AND c.`guid` = 920019810;

-- He gives Rocket Gnomes (Wowhead comment 6478099); Fenwick already takes it.
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`)
SELECT 249550, 92094, 0 FROM DUAL
WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249550)
  AND EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 92094)
  AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `quest` = 92094);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_queststarter', 249550, 92094, 0, 0, @EVERLAKE_FILE, 'Wowhead quest 92094 comment 6478099'
FROM `creature_queststarter` WHERE `id` = 249550 AND `quest` = 92094;

COMMIT;
