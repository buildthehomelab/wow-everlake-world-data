-- Zalfan Moonshadow (268423), the elite highborne quest 96771 (Vengeance of the Highborne) sends you to kill, from the Icy
-- Veins WoW Forever catalogue (https://db.icy-veins.com/wow-forever/: name, type, elite, unit class, health multiplier,
-- model) and Wowhead's WoW Forever NPC page (https://www.wowhead.com/forever, read 2026-11-20 through the tracker's kept
-- pages: two points on the Eastern Kingdoms map, 57.1 62.5 and 57.2 62.3).
-- 2026_11_20_29_world_everlake_quest_npc_zalfan.sql: written from public data by a script, checked by hand.
--
-- The points turn into map 0 -7200.02 -4099.14 and -7153.09 -4134.34 with the client's UiMapAssignment rectangles: the
--   Riverglades map (UiMap 2548) at 45.5 22.7, where the quest text puts Krol'dok Stronghold. One spawn at the first
--   point; the second is 58 yards off and taken as the same NPC seen walking. Height from the realm's maps and vmaps
--   (ForeverTracker tools/height.py): terrain 262.34.
-- INFERRED: level 45 (the quest's level and its giver's; no source gives his), faction 16 (no source names one), speeds,
--   attack times, respawn 300 s and the model size below. No spells, loot or AI: he fights in melee and drops nothing.
-- The quest comes in file 2026_11_20_30. Guid: creature 920014006, in the quest-giver block (920014000-920014099).
-- No template is added where the realm already has one; spawns only while the template is this file's.
-- Each added row is recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing. Not checked in game.

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

SET @EVERLAKE_FILE := '2026_11_20_29_world_everlake_quest_npc_zalfan.sql';

START TRANSACTION;

SET @EVERLAKE_NOTE := 'INFERRED: the commonest realm size of displays sharing model 7369 at scale 1';
SET @EVERLAKE_M145448 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 145448);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 145448, 0.389, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M145448 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 145448, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M145448 = 1;

-- Zalfan Moonshadow (268423): quests 96771. Faction 16; 1 spawn(s).
SET @EVERLAKE_NOTE := 'Icy Veins npc=268423 record + Wowhead point; faction: hostile kill target; no faction on any source: 16, the realm''s commonest Twilight faction';
SET @EVERLAKE_C268423 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 268423)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 268423);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 268423, 0, 0, 'Zalfan Moonshadow', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C268423 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 268423, 0, 0, 0, 0, 0, 5.75, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C268423 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 268423, 0, 145448, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C268423 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 268423, 45, 45 FROM DUAL
WHERE @EVERLAKE_C268423 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 268423);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 268423, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C268423 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 268423);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 268423, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C268423 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 268423, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C268423 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 268423, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C268423 = 1;
SET @EVERLAKE_CS268423 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 268423 AND `file` = '2026_11_20_29_world_everlake_quest_npc_zalfan.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 268423 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 268423);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 268423, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920014006 AS `guid`, 0 AS `map`, -7200.02 AS `x`, -4099.14 AS `y`, 262.34 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS268423 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS268423 = 1 AND c.`id` = 268423 AND c.`guid` BETWEEN 920014006 AND 920014006;

COMMIT;
