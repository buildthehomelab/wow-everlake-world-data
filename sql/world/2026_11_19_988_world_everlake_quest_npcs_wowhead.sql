-- Creatures the missing Forever quests need as giver, ender or kill target, from their Wowhead WoW Forever pages
-- (https://www.wowhead.com/forever, read 2026-11-19: name, level, reaction, faction, type, model and map points).
-- 2026_11_19_988_world_everlake_quest_npcs_wowhead.sql: written from public data by a script, checked by hand.
--
-- These are the NPCs neither EG Link nor DatabaseForever-free sources covered (file 983 took EG Link's). The project's
-- decision of 2026-11-19 adds Wowhead as their source. INFERRED: faction (as a same-name twin the realm spawns; else the
-- realm's commonest faction template of Wowhead's faction; else a stock faction by Wowhead's reaction: friendly to both
-- 35, Alliance 12, Horde 29, hostile 14, neutral 7), speeds, attack times, respawn 300 s (the core's defaults), and the
-- model sizes below. Heights from the realm's maps and vmaps (ForeverTracker tools/height.py); a cave under terrain
-- takes its lowest floor. One spawn per Wowhead point at least 8 yards apart, at most 10. A talk-to target gets the gossip flag, givers and enders the
-- quest-giver flag when a quest names them as giver or ender. Not checked in game.
-- Guids: creatures 920012000 upward, a block of their own (920012000-920012999).
-- No template is added where the realm already has one; spawns only while the template is this file's and the realm
-- has no spawn of it. Each added row is recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.
--
-- Held back:
--   217957 Slain Scarlet Crusader: no ground height at its points (or only instance points)
--   247449 Sin'dorei Tome of Summoning: Wowhead names no map point
--   254777 Personal Survival Pack: Wowhead names no level
--   254797 Lost One: Wowhead names no map point
--   254825 Gelkis Captive: Wowhead names no map point
--   254930 [DNT] Kill Credit: Mulara spoken with: Wowhead names no map point
--   255777 Credit: Wowhead names no map point
--   260417 [DNT] Kill Credit: Ogre Miner: Wowhead names no map point
--   260674 Ve'han Talongrasp: Wowhead names no map point
--   262006 Twilight Ritual Circle: Wowhead names no map point
--   262036 Ruined Ballista: Wowhead names no map point
--   262049 Spirit of the Stag: Wowhead names no map point
--   263277 [DNT] Kill Credit: Drained Crystal: Wowhead names no map point
--   263426 Mazzogore the Weak: Wowhead names no map point
--   263427 Bethra'zel the Feeble: Wowhead names no map point
--   263435 [DNT] Kill Credit: Western pylon repaired: Wowhead names no map point
--   263436 [DNT] Kill Credit: Eastern pylon repaired: Wowhead names no map point
--   263458 [DNT] Kill Credit: Pillar of Assimilation: Wowhead names no map point
--   263460 [DNT] Kill Credit: Regrowth Vestibule: Wowhead names no map point
--   263461 [DNT] Kill Credit: The Doors: Wowhead names no map point
--   263462 [DNT] Kill Credit: Destroyed Watcher: Wowhead names no map point
--   263806 [DNT] Kill Credit: Work Stations Disrupted [Vessel]: Wowhead names no map point
--   264352 [DNT] Kill Credit: Work Stations Disrupted [Slime]: Wowhead names no map point
--   264715 Wisp: Wowhead names no map point
--   264861 KC Creature: Wowhead names no map point
--   266883 [DNT] Kill Credit Young Paletusk: Wowhead names no map point
--   266886 Ruined Flying Machine: Wowhead names no map point
--   266887 Ruined Catapult: Wowhead names no map point
--   267462 [DNT] Kill Credit: Wowhead names no map point
--   268423 Zalfan Moonshadow: Wowhead names no level
--   270573 Credit: Wowhead names no map point
--   270574 Credit: Wowhead names no map point
--   271182 Credit: Wowhead names no map point
--   272603 [DNT] Kill Credit: Wowhead names no map point
--   278305 Velician: Wowhead names no level
--   278309 Credit: Wowhead names no map point

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

SET @EVERLAKE_FILE := '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql';

START TRANSACTION;

SET @EVERLAKE_NOTE := 'INFERRED from model 7300: 333 of 339 realm displays on it at scale 1';
SET @EVERLAKE_M127409 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 127409);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 127409, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M127409 = 1;  -- INFERRED from model 7300: 333 of 339 realm displays on it at scale 1
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 127409, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M127409 = 1;
SET @EVERLAKE_NOTE := 'INFERRED from model 6838: 482 of 515 realm displays on it at scale 1';
SET @EVERLAKE_M142439 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 142439);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 142439, 0.372, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M142439 = 1;  -- INFERRED from model 6838: 482 of 515 realm displays on it at scale 1
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 142439, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M142439 = 1;
SET @EVERLAKE_NOTE := 'INFERRED from model 6838: 482 of 515 realm displays on it at scale 1';
SET @EVERLAKE_M143051 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 143051);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 143051, 0.372, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M143051 = 1;  -- INFERRED from model 6838: 482 of 515 realm displays on it at scale 1
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 143051, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M143051 = 1;
SET @EVERLAKE_NOTE := 'INFERRED from model 5408: 664 of 705 realm displays on it at scale 1';
SET @EVERLAKE_M143121 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 143121);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 143121, 0.347, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M143121 = 1;  -- INFERRED from model 5408: 664 of 705 realm displays on it at scale 1
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 143121, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M143121 = 1;
SET @EVERLAKE_NOTE := 'INFERRED from model 831: 256 of 267 realm displays on it at scale 1';
SET @EVERLAKE_M146436 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 146436);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 146436, 0.306, 1.5, 0, 0 FROM DUAL WHERE @EVERLAKE_M146436 = 1;  -- INFERRED from model 831: 256 of 267 realm displays on it at scale 1
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 146436, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_M146436 = 1;

-- Ada Gelhardt (205153): quests 95771. Faction 12 (the realm's commonest template of Wowhead's faction 72); 3 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=205153 page; faction the realm''s commonest template of Wowhead''s faction 72';
SET @EVERLAKE_C205153 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 205153)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 205153);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 205153, 0, 0, 'Ada Gelhardt', NULL, NULL, NULL, NULL, 0, 0, 12, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C205153 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 205153, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C205153 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 205153, 0, 13648, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C205153 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 205153, 10, 10 FROM DUAL
WHERE @EVERLAKE_C205153 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 205153);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 205153, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C205153 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 205153);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 205153, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C205153 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 205153, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C205153 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 205153, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C205153 = 1;
SET @EVERLAKE_CS205153 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 205153 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 205153 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 205153);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 205153, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012000 AS `guid`, 0 AS `map`, -10231.47 AS `x`, 719.93 AS `y`, 24.5 AS `z`  -- height.py
  UNION ALL
  SELECT 920012001 AS `guid`, 0 AS `map`, -10217.07 AS `x`, 709.13 AS `y`, 24.81 AS `z`  -- height.py
  UNION ALL
  SELECT 920012002 AS `guid`, 0 AS `map`, -10231.47 AS `x`, 709.13 AS `y`, 24.23 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS205153 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS205153 = 1 AND c.`id` = 205153 AND c.`guid` BETWEEN 920012000 AND 920012002;

-- Sentinel Keldara Sunblade (222478): quests 88857. Faction 124 (as its twin 8397); 6 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=222478 page; faction as its twin 8397';
SET @EVERLAKE_C222478 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 222478)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 222478);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 222478, 0, 0, 'Sentinel Keldara Sunblade', NULL, NULL, NULL, NULL, 0, 0, 124, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C222478 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 222478, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C222478 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 222478, 0, 7603, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C222478 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 222478, 44, 45 FROM DUAL
WHERE @EVERLAKE_C222478 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 222478);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 222478, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222478 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 222478);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 222478, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222478 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 222478, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222478 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 222478, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C222478 = 1;
SET @EVERLAKE_CS222478 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 222478 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 222478 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 222478);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 222478, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012003 AS `guid`, 1 AS `map`, 3174.29 AS `x`, -4250.68 AS `y`, 98.16 AS `z`  -- height.py
  UNION ALL
  SELECT 920012004 AS `guid`, 1 AS `map`, 3262.2 AS `x`, -4260.82 AS `y`, 120.15 AS `z`  -- height.py
  UNION ALL
  SELECT 920012005 AS `guid`, 1 AS `map`, 3221.62 AS `x`, -4260.82 AS `y`, 103.86 AS `z`  -- height.py
  UNION ALL
  SELECT 920012006 AS `guid`, 1 AS `map`, 3312.92 AS `x`, -4311.53 AS `y`, 130.86 AS `z`  -- height.py
  UNION ALL
  SELECT 920012007 AS `guid`, 1 AS `map`, 3252.05 AS `x`, -4321.67 AS `y`, 160.74 AS `z`  -- height.py
  UNION ALL
  SELECT 920012008 AS `guid`, 1 AS `map`, 3296.01 AS `x`, -4326.75 AS `y`, 130.39 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS222478 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS222478 = 1 AND c.`id` = 222478 AND c.`guid` BETWEEN 920012003 AND 920012008;

-- Elder Bramblesnap (235906): quests 86799, 86804, 86812, 86813, 86927. Faction 414 (the realm's commonest template of Wowhead's faction 576); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=235906 page; faction the realm''s commonest template of Wowhead''s faction 576';
SET @EVERLAKE_C235906 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 235906)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 235906);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 235906, 0, 0, 'Elder Bramblesnap', NULL, NULL, NULL, NULL, 0, 0, 414, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C235906 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 235906, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C235906 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 235906, 0, 6829, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C235906 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 235906, 55, 55 FROM DUAL
WHERE @EVERLAKE_C235906 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 235906);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 235906, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235906 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 235906);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 235906, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235906 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 235906, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235906 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 235906, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235906 = 1;
SET @EVERLAKE_CS235906 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 235906 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 235906 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 235906);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 235906, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012009 AS `guid`, 1 AS `map`, 4685.7 AS `x`, -5386.55 AS `y`, 112.52 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS235906 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS235906 = 1 AND c.`id` = 235906 AND c.`guid` BETWEEN 920012009 AND 920012009;

-- Furze (235909): quests 86799. Faction 414 (the realm's commonest template of Wowhead's faction 576); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=235909 page; faction the realm''s commonest template of Wowhead''s faction 576';
SET @EVERLAKE_C235909 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 235909)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 235909);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 235909, 0, 0, 'Furze', NULL, NULL, NULL, NULL, 0, 0, 414, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C235909 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 235909, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C235909 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 235909, 0, 3028, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C235909 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 235909, 50, 50 FROM DUAL
WHERE @EVERLAKE_C235909 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 235909);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 235909, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235909 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 235909);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 235909, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235909 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 235909, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235909 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 235909, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C235909 = 1;
SET @EVERLAKE_CS235909 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 235909 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 235909 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 235909);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 235909, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012010 AS `guid`, 1 AS `map`, 4591.03 AS `x`, -5569.1 AS `y`, 98.1 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS235909 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS235909 = 1 AND c.`id` = 235909 AND c.`guid` BETWEEN 920012010 AND 920012010;

-- Korsa (236770): quests 86777, 86791, 86792, 86796, 86797. Faction 414 (the realm's commonest template of Wowhead's faction 576); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=236770 page; faction the realm''s commonest template of Wowhead''s faction 576';
SET @EVERLAKE_C236770 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 236770)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236770);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 236770, 0, 0, 'Korsa', NULL, NULL, NULL, NULL, 0, 0, 414, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C236770 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 236770, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C236770 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 236770, 0, 5851, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C236770 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 236770, 50, 50 FROM DUAL
WHERE @EVERLAKE_C236770 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 236770);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 236770, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236770 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 236770);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 236770, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236770 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 236770, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236770 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 236770, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C236770 = 1;
SET @EVERLAKE_CS236770 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 236770 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 236770 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 236770);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 236770, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012011 AS `guid`, 1 AS `map`, 4618.08 AS `x`, -6471.71 AS `y`, 115.95 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS236770 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS236770 = 1 AND c.`id` = 236770 AND c.`guid` BETWEEN 920012011 AND 920012011;

-- Graal (237007): quests 86796. Faction 414 (the realm's commonest template of Wowhead's faction 576); 6 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=237007 page; faction the realm''s commonest template of Wowhead''s faction 576';
SET @EVERLAKE_C237007 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 237007)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 237007);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 237007, 0, 0, 'Graal', NULL, NULL, NULL, NULL, 0, 0, 414, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C237007 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 237007, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C237007 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 237007, 0, 2003, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C237007 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 237007, 53, 53 FROM DUAL
WHERE @EVERLAKE_C237007 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 237007);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 237007, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C237007 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 237007);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 237007, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C237007 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 237007, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C237007 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 237007, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C237007 = 1;
SET @EVERLAKE_CS237007 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 237007 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 237007 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 237007);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 237007, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012012 AS `guid`, 1 AS `map`, 4739.8 AS `x`, -6451.42 AS `y`, 108.35 AS `z`  -- height.py
  UNION ALL
  SELECT 920012013 AS `guid`, 1 AS `map`, 4777.0 AS `x`, -6542.7 AS `y`, 100.04 AS `z`  -- height.py
  UNION ALL
  SELECT 920012014 AS `guid`, 1 AS `map`, 4827.72 AS `x`, -6578.2 AS `y`, 101.87 AS `z`  -- height.py
  UNION ALL
  SELECT 920012015 AS `guid`, 1 AS `map`, 4817.57 AS `x`, -6578.2 AS `y`, 101.27 AS `z`  -- height.py
  UNION ALL
  SELECT 920012016 AS `guid`, 1 AS `map`, 4854.77 AS `x`, -6644.12 AS `y`, 93.85 AS `z`  -- height.py
  UNION ALL
  SELECT 920012017 AS `guid`, 1 AS `map`, 4854.77 AS `x`, -6654.26 AS `y`, 93.48 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS237007 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS237007 = 1 AND c.`id` = 237007 AND c.`guid` BETWEEN 920012012 AND 920012017;

-- Saria Fairmoon (239831): quests 88821, 88884, 88917, 89037, 89038, 89053. Faction 35 (stock 35 by Wowhead reaction A friendly / H friendly); 3 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=239831 page; faction stock 35 by Wowhead reaction A friendly / H friendly';
SET @EVERLAKE_C239831 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 239831)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 239831);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 239831, 0, 0, 'Saria Fairmoon', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C239831 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 239831, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C239831 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 239831, 0, 127409, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C239831 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 239831, 55, 55 FROM DUAL
WHERE @EVERLAKE_C239831 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 239831);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 239831, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239831 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 239831);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 239831, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239831 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 239831, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239831 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 239831, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C239831 = 1;
SET @EVERLAKE_CS239831 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 239831 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 239831 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 239831);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 239831, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012018 AS `guid`, 1 AS `map`, 3921.54 AS `x`, -5782.07 AS `y`, 14.28 AS `z`  -- height.py
  UNION ALL
  SELECT 920012019 AS `guid`, 1 AS `map`, 3901.25 AS `x`, -5832.78 AS `y`, 6.92 AS `z`  -- height.py
  UNION ALL
  SELECT 920012020 AS `guid`, 1 AS `map`, 3901.25 AS `x`, -5842.92 AS `y`, 6.66 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS239831 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS239831 = 1 AND c.`id` = 239831 AND c.`guid` BETWEEN 920012018 AND 920012020;

-- Barkskin Matriarch (244425): quests 91696, 91698. Faction 35 (stock 35 by Wowhead reaction A friendly / H friendly); 8 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=244425 page; faction stock 35 by Wowhead reaction A friendly / H friendly';
SET @EVERLAKE_C244425 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 244425)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 244425);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 244425, 0, 0, 'Barkskin Matriarch', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C244425 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 244425, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C244425 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 244425, 0, 6826, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C244425 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 244425, 57, 57 FROM DUAL
WHERE @EVERLAKE_C244425 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 244425);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 244425, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244425 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 244425);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 244425, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244425 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 244425, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244425 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 244425, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C244425 = 1;
SET @EVERLAKE_CS244425 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 244425 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 244425 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 244425);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 244425, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012021 AS `guid`, 1 AS `map`, 4829.78 AS `x`, -1746.0 AS `y`, 1155.99 AS `z`  -- height.py
  UNION ALL
  SELECT 920012022 AS `guid`, 1 AS `map`, 4836.72 AS `x`, -1756.42 AS `y`, 1190.28 AS `z`  -- height.py
  UNION ALL
  SELECT 920012023 AS `guid`, 1 AS `map`, 4864.5 AS `x`, -1773.78 AS `y`, 1155.69 AS `z`  -- height.py lowest floor (cave, INFERRED)
  UNION ALL
  SELECT 920012024 AS `guid`, 1 AS `map`, 4883.01 AS `x`, -1791.15 AS `y`, 1149.06 AS `z`  -- height.py lowest floor (cave, INFERRED)
  UNION ALL
  SELECT 920012025 AS `guid`, 1 AS `map`, 4887.64 AS `x`, -1829.35 AS `y`, 1143.89 AS `z`  -- height.py lowest floor (cave, INFERRED)
  UNION ALL
  SELECT 920012026 AS `guid`, 1 AS `map`, 4876.07 AS `x`, -1874.5 AS `y`, 1150.88 AS `z`  -- height.py lowest floor (cave, INFERRED)
  UNION ALL
  SELECT 920012027 AS `guid`, 1 AS `map`, 4933.93 AS `x`, -1909.22 AS `y`, 1462.64 AS `z`  -- height.py
  UNION ALL
  SELECT 920012028 AS `guid`, 1 AS `map`, 4913.1 AS `x`, -1912.7 AS `y`, 1370.87 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS244425 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS244425 = 1 AND c.`id` = 244425 AND c.`guid` BETWEEN 920012021 AND 920012028;

-- Lorekeeper Nok (249853): quests 92066. Faction 414 (the realm's commonest template of Wowhead's faction 576); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=249853 page; faction the realm''s commonest template of Wowhead''s faction 576';
SET @EVERLAKE_C249853 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 249853)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249853);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 249853, 0, 0, 'Lorekeeper Nok', NULL, NULL, NULL, NULL, 0, 0, 414, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C249853 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 249853, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C249853 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 249853, 0, 11363, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C249853 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 249853, 50, 50 FROM DUAL
WHERE @EVERLAKE_C249853 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 249853);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 249853, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249853 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249853);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 249853, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249853 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 249853, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249853 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 249853, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249853 = 1;
SET @EVERLAKE_CS249853 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249853 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 249853 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 249853);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 249853, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012029 AS `guid`, 1 AS `map`, 4665.42 AS `x`, -5376.41 AS `y`, 108.48 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS249853 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS249853 = 1 AND c.`id` = 249853 AND c.`guid` BETWEEN 920012029 AND 920012029;

-- Unele (249855): quests 92070. Faction 414 (the realm's commonest template of Wowhead's faction 576); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=249855 page; faction the realm''s commonest template of Wowhead''s faction 576';
SET @EVERLAKE_C249855 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 249855)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249855);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 249855, 0, 0, 'Unele', NULL, NULL, NULL, NULL, 0, 0, 414, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C249855 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 249855, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C249855 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 249855, 0, 1996, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C249855 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 249855, 50, 50 FROM DUAL
WHERE @EVERLAKE_C249855 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 249855);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 249855, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249855 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 249855);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 249855, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249855 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 249855, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249855 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 249855, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C249855 = 1;
SET @EVERLAKE_CS249855 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 249855 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 249855 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 249855);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 249855, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012030 AS `guid`, 1 AS `map`, 4726.28 AS `x`, -5467.68 AS `y`, 109.25 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS249855 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS249855 = 1 AND c.`id` = 249855 AND c.`guid` BETWEEN 920012030 AND 920012030;

-- Khan Jehn (254357): quests 93196. Faction 133 (as its twin 5601); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=254357 page; faction as its twin 5601';
SET @EVERLAKE_C254357 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 254357)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254357);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 254357, 0, 0, 'Khan Jehn', NULL, NULL, NULL, NULL, 0, 0, 133, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C254357 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 254357, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C254357 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 254357, 0, 9433, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C254357 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 254357, 42, 42 FROM DUAL
WHERE @EVERLAKE_C254357 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 254357);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 254357, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254357 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 254357);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 254357, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254357 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 254357, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254357 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 254357, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C254357 = 1;
SET @EVERLAKE_CS254357 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 254357 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 254357 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 254357);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 254357, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012031 AS `guid`, 1 AS `map`, -1760.38 AS `x`, 915.41 AS `y`, 107.01 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS254357 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS254357 = 1 AND c.`id` = 254357 AND c.`guid` BETWEEN 920012031 AND 920012031;

-- Veteran of the Third War (255009): quests 92100. Faction 35 (stock 35 by Wowhead reaction A friendly / H friendly); 10 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=255009 page; faction stock 35 by Wowhead reaction A friendly / H friendly';
SET @EVERLAKE_C255009 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 255009)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 255009);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 255009, 0, 0, 'Veteran of the Third War', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 6, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C255009 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 255009, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C255009 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 255009, 0, 144574, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C255009 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 255009, 61, 61 FROM DUAL
WHERE @EVERLAKE_C255009 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 255009);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 255009, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255009 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 255009);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 255009, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255009 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 255009, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255009 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 255009, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255009 = 1;
SET @EVERLAKE_CS255009 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 255009 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 255009 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 255009);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 255009, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012032 AS `guid`, 1 AS `map`, 4906.16 AS `x`, -1568.88 AS `y`, 1328.26 AS `z`  -- height.py
  UNION ALL
  SELECT 920012033 AS `guid`, 1 AS `map`, 4896.9 AS `x`, -1589.72 AS `y`, 1324.27 AS `z`  -- height.py
  UNION ALL
  SELECT 920012034 AS `guid`, 1 AS `map`, 4869.12 AS `x`, -1610.55 AS `y`, 1315.41 AS `z`  -- height.py
  UNION ALL
  SELECT 920012035 AS `guid`, 1 AS `map`, 4924.67 AS `x`, -1624.45 AS `y`, 1324.66 AS `z`  -- height.py
  UNION ALL
  SELECT 920012036 AS `guid`, 1 AS `map`, 4933.93 AS `x`, -1631.39 AS `y`, 1324.88 AS `z`  -- height.py
  UNION ALL
  SELECT 920012037 AS `guid`, 1 AS `map`, 4901.53 AS `x`, -1631.39 AS `y`, 1320.36 AS `z`  -- height.py
  UNION ALL
  SELECT 920012038 AS `guid`, 1 AS `map`, 4980.22 AS `x`, -1638.34 AS `y`, 1352.73 AS `z`  -- height.py
  UNION ALL
  SELECT 920012039 AS `guid`, 1 AS `map`, 4943.19 AS `x`, -1638.34 AS `y`, 1329.81 AS `z`  -- height.py
  UNION ALL
  SELECT 920012040 AS `guid`, 1 AS `map`, 4920.05 AS `x`, -1645.28 AS `y`, 1324.12 AS `z`  -- height.py
  UNION ALL
  SELECT 920012041 AS `guid`, 1 AS `map`, 4970.97 AS `x`, -1666.12 AS `y`, 1338.85 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS255009 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS255009 = 1 AND c.`id` = 255009 AND c.`guid` BETWEEN 920012032 AND 920012041;

-- Solstice (255685): quests 93615. Faction 35 (stock 35 by Wowhead reaction A friendly / H friendly); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=255685 page; faction stock 35 by Wowhead reaction A friendly / H friendly';
SET @EVERLAKE_C255685 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 255685)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 255685);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 255685, 0, 0, 'Solstice', NULL, NULL, NULL, NULL, 0, 0, 35, 1, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 1, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C255685 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 255685, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C255685 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 255685, 0, 139033, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C255685 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 255685, 60, 60 FROM DUAL
WHERE @EVERLAKE_C255685 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 255685);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 255685, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255685 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 255685);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 255685, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255685 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 255685, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255685 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 255685, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255685 = 1;
SET @EVERLAKE_CS255685 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 255685 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 255685 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 255685);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 255685, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012042 AS `guid`, 1 AS `map`, 5207.05 AS `x`, -2256.52 AS `y`, 1258.83 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS255685 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS255685 = 1 AND c.`id` = 255685 AND c.`guid` BETWEEN 920012042 AND 920012042;

-- Whisperfur (255771): quests 93615. Faction 35 (stock 35 by Wowhead reaction A friendly / H friendly); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=255771 page; faction stock 35 by Wowhead reaction A friendly / H friendly';
SET @EVERLAKE_C255771 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 255771)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 255771);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 255771, 0, 0, 'Whisperfur', NULL, NULL, NULL, NULL, 0, 0, 35, 1, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 1, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C255771 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 255771, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C255771 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 255771, 0, 139033, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C255771 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 255771, 60, 60 FROM DUAL
WHERE @EVERLAKE_C255771 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 255771);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 255771, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255771 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 255771);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 255771, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255771 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 255771, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255771 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 255771, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C255771 = 1;
SET @EVERLAKE_CS255771 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 255771 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 255771 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 255771);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 255771, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012043 AS `guid`, 1 AS `map`, 4869.12 AS `x`, -1860.6 AS `y`, 1151.2 AS `z`  -- height.py lowest floor (cave, INFERRED)
) s
WHERE @EVERLAKE_CS255771 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS255771 = 1 AND c.`id` = 255771 AND c.`guid` BETWEEN 920012043 AND 920012043;

-- Sully McCleary (260271): quests 95196, 95198, 95262, 95263, 95264, 96381. Faction 15 (as its twin 260146); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=260271 page; faction as its twin 260146';
SET @EVERLAKE_C260271 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 260271)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260271);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 260271, 0, 0, 'Sully McCleary', NULL, NULL, NULL, NULL, 0, 0, 15, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C260271 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 260271, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C260271 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 260271, 0, 142287, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C260271 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 260271, 50, 50 FROM DUAL
WHERE @EVERLAKE_C260271 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 260271);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 260271, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260271 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 260271);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 260271, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260271 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260271, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260271 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 260271, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260271 = 1;
SET @EVERLAKE_CS260271 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260271 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260271 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260271);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260271, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012044 AS `guid`, 1 AS `map`, -3517.33 AS `x`, -4303.5 AS `y`, 6.36 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS260271 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS260271 = 1 AND c.`id` = 260271 AND c.`guid` BETWEEN 920012044 AND 920012044;

-- Brashann Grimdark (260440): quests 95379. Faction 14 (stock 14 by Wowhead reaction A hostile / H hostile); 4 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=260440 page; faction stock 14 by Wowhead reaction A hostile / H hostile';
SET @EVERLAKE_C260440 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 260440)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260440);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 260440, 0, 0, 'Brashann Grimdark', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 1, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C260440 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 260440, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C260440 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 260440, 0, 142439, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C260440 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 260440, 58, 58 FROM DUAL
WHERE @EVERLAKE_C260440 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 260440);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 260440, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260440 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 260440);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 260440, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260440 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 260440, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260440 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 260440, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C260440 = 1;
SET @EVERLAKE_CS260440 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 260440 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260440 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260440);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260440, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012045 AS `guid`, 1 AS `map`, 4683.96 AS `x`, -2603.81 AS `y`, 1147.03 AS `z`  -- height.py
  UNION ALL
  SELECT 920012046 AS `guid`, 1 AS `map`, 4693.22 AS `x`, -2638.54 AS `y`, 1152.53 AS `z`  -- height.py
  UNION ALL
  SELECT 920012047 AS `guid`, 1 AS `map`, 4644.61 AS `x`, -2662.85 AS `y`, 1146.28 AS `z`  -- height.py
  UNION ALL
  SELECT 920012048 AS `guid`, 1 AS `map`, 4658.5 AS `x`, -2666.32 AS `y`, 1145.97 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS260440 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS260440 = 1 AND c.`id` = 260440 AND c.`guid` BETWEEN 920012045 AND 920012048;

-- Bor'dorc (262041): quests 94324. Faction 35 (stock 35 by Wowhead reaction A friendly / H friendly); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=262041 page; faction stock 35 by Wowhead reaction A friendly / H friendly';
SET @EVERLAKE_C262041 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262041)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262041);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262041, 0, 0, 'Bor''dorc', NULL, NULL, NULL, NULL, 0, 0, 35, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262041 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262041, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262041 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262041, 0, 143051, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262041 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262041, 60, 60 FROM DUAL
WHERE @EVERLAKE_C262041 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262041);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262041, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262041 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 262041);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262041, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262041 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262041, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262041 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262041, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262041 = 1;
SET @EVERLAKE_CS262041 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262041 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 262041 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 262041);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262041, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012049 AS `guid`, 1 AS `map`, 6961.87 AS `x`, -4917.47 AS `y`, 693.57 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS262041 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS262041 = 1 AND c.`id` = 262041 AND c.`guid` BETWEEN 920012049 AND 920012049;

-- Durganon (262294): quests 94263, 94287. Faction 14 (stock 14 by Wowhead reaction A hostile / H hostile); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=262294 page; faction stock 14 by Wowhead reaction A hostile / H hostile';
SET @EVERLAKE_C262294 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262294)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262294);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262294, 0, 0, 'Durganon', NULL, NULL, NULL, NULL, 0, 0, 14, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C262294 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262294, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C262294 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262294, 0, 143121, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C262294 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262294, 59, 59 FROM DUAL
WHERE @EVERLAKE_C262294 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262294);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262294, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262294 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 262294);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 262294, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262294 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 262294, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262294 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 262294, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C262294 = 1;
SET @EVERLAKE_CS262294 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 262294 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 262294 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 262294);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 262294, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012050 AS `guid`, 0 AS `map`, -6968.7 AS `x`, -1237.73 AS `y`, 180.72 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS262294 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS262294 = 1 AND c.`id` = 262294 AND c.`guid` BETWEEN 920012050 AND 920012050;

-- Ghansurok (264867): quests 93444. Faction 14 (stock 14 by Wowhead reaction A hostile / H hostile); 5 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=264867 page; faction stock 14 by Wowhead reaction A hostile / H hostile';
SET @EVERLAKE_C264867 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 264867)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 264867);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 264867, 0, 0, 'Ghansurok', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 1, 0, '', 1, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C264867 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 264867, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C264867 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 264867, 0, 4269, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C264867 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 264867, 61, 61 FROM DUAL
WHERE @EVERLAKE_C264867 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 264867);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 264867, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C264867 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 264867);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 264867, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C264867 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 264867, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C264867 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 264867, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C264867 = 1;
SET @EVERLAKE_CS264867 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 264867 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 264867 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 264867);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 264867, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012051 AS `guid`, 1 AS `map`, 5790.33 AS `x`, -3298.39 AS `y`, 1611.87 AS `z`  -- height.py
  UNION ALL
  SELECT 920012052 AS `guid`, 1 AS `map`, 5757.92 AS `x`, -3305.34 AS `y`, 1603.49 AS `z`  -- height.py
  UNION ALL
  SELECT 920012053 AS `guid`, 1 AS `map`, 5808.85 AS `x`, -3326.18 AS `y`, 1643.82 AS `z`  -- height.py
  UNION ALL
  SELECT 920012054 AS `guid`, 1 AS `map`, 5799.59 AS `x`, -3326.18 AS `y`, 1638.65 AS `z`  -- height.py
  UNION ALL
  SELECT 920012055 AS `guid`, 1 AS `map`, 5771.81 AS `x`, -3326.18 AS `y`, 1622.73 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS264867 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS264867 = 1 AND c.`id` = 264867 AND c.`guid` BETWEEN 920012051 AND 920012055;

-- Murkborn Elemental (265026): quests 95273. Faction 7 (stock 7 by Wowhead reaction A None / H None); 2 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=265026 page; faction stock 7 by Wowhead reaction A None / H None';
SET @EVERLAKE_C265026 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 265026)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 265026);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 265026, 0, 0, 'Murkborn Elemental', NULL, NULL, NULL, NULL, 0, 0, 7, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 1, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C265026 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 265026, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C265026 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 265026, 0, 5987, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C265026 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 265026, 59, 59 FROM DUAL
WHERE @EVERLAKE_C265026 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 265026);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 265026, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C265026 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 265026);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 265026, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C265026 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 265026, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C265026 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 265026, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C265026 = 1;
SET @EVERLAKE_CS265026 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 265026 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 265026 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 265026);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 265026, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012056 AS `guid`, 1 AS `map`, 4896.9 AS `x`, -2027.3 AS `y`, 1128.63 AS `z`  -- height.py lowest floor (cave, INFERRED)
  UNION ALL
  SELECT 920012057 AS `guid`, 1 AS `map`, 4901.53 AS `x`, -2055.09 AS `y`, 1127.7 AS `z`  -- height.py lowest floor (cave, INFERRED)
) s
WHERE @EVERLAKE_CS265026 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS265026 = 1 AND c.`id` = 265026 AND c.`guid` BETWEEN 920012056 AND 920012057;

-- Sergeant Danneth (266593): quests 96799, 96812. Faction 1630 (as its twin 266508); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=266593 page; faction as its twin 266508';
SET @EVERLAKE_C266593 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 266593)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 266593);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 266593, 0, 0, 'Sergeant Danneth', NULL, NULL, NULL, NULL, 0, 0, 1630, 3, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C266593 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 266593, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C266593 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 266593, 0, 144845, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C266593 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 266593, 52, 52 FROM DUAL
WHERE @EVERLAKE_C266593 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 266593);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 266593, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C266593 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 266593);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 266593, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C266593 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 266593, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C266593 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 266593, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C266593 = 1;
SET @EVERLAKE_CS266593 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 266593 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 266593 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 266593);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 266593, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012058 AS `guid`, 0 AS `map`, -10915.07 AS `x`, -3419.17 AS `y`, 110.21 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS266593 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS266593 = 1 AND c.`id` = 266593 AND c.`guid` BETWEEN 920012058 AND 920012058;

-- Doomguard Xarkul (267439): quests 96983. Faction 90 (the realm's commonest template of Wowhead's faction 73); 8 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=267439 page; faction the realm''s commonest template of Wowhead''s faction 73';
SET @EVERLAKE_C267439 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 267439)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 267439);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 267439, 0, 0, 'Doomguard Xarkul', NULL, NULL, NULL, NULL, 0, 0, 90, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 3, 0, '', 1, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C267439 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 267439, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C267439 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 267439, 0, 2727, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C267439 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 267439, 61, 61 FROM DUAL
WHERE @EVERLAKE_C267439 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 267439);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 267439, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C267439 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 267439);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 267439, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C267439 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 267439, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C267439 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 267439, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C267439 = 1;
SET @EVERLAKE_CS267439 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 267439 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 267439 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 267439);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 267439, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012059 AS `guid`, 1 AS `map`, 5538.04 AS `x`, -3034.45 AS `y`, 1549.51 AS `z`  -- height.py
  UNION ALL
  SELECT 920012060 AS `guid`, 1 AS `map`, 5494.06 AS `x`, -3048.34 AS `y`, 1574.24 AS `z`  -- height.py
  UNION ALL
  SELECT 920012061 AS `guid`, 1 AS `map`, 5577.39 AS `x`, -3055.29 AS `y`, 1559.7 AS `z`  -- height.py
  UNION ALL
  SELECT 920012062 AS `guid`, 1 AS `map`, 5563.5 AS `x`, -3055.29 AS `y`, 1564.1 AS `z`  -- height.py
  UNION ALL
  SELECT 920012063 AS `guid`, 1 AS `map`, 5549.61 AS `x`, -3069.18 AS `y`, 1561.86 AS `z`  -- height.py
  UNION ALL
  SELECT 920012064 AS `guid`, 1 AS `map`, 5563.5 AS `x`, -3083.07 AS `y`, 1565.12 AS `z`  -- height.py
  UNION ALL
  SELECT 920012065 AS `guid`, 1 AS `map`, 5540.35 AS `x`, -3093.49 AS `y`, 1562.54 AS `z`  -- height.py
  UNION ALL
  SELECT 920012066 AS `guid`, 1 AS `map`, 5556.56 AS `x`, -3096.96 AS `y`, 1565.07 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS267439 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS267439 = 1 AND c.`id` = 267439 AND c.`guid` BETWEEN 920012059 AND 920012066;

-- Gizzix Grimegurgle (270727): quests 98231. Faction 474 (the realm's commonest template of Wowhead's faction 369); 1 spawn(s).
SET @EVERLAKE_NOTE := 'Wowhead npc=270727 page; faction the realm''s commonest template of Wowhead''s faction 369';
SET @EVERLAKE_C270727 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 270727)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 270727);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 270727, 0, 0, 'Gizzix Grimegurgle', NULL, NULL, NULL, NULL, 0, 0, 474, 2, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 7, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C270727 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 270727, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C270727 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 270727, 0, 146436, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C270727 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 270727, 40, 40 FROM DUAL
WHERE @EVERLAKE_C270727 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 270727);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 270727, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270727 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 270727);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 270727, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270727 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 270727, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270727 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 270727, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C270727 = 1;
SET @EVERLAKE_CS270727 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 270727 AND `file` = '2026_11_19_988_world_everlake_quest_npcs_wowhead.sql')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 270727 AND `VerifiedBuild` = 0)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 270727);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 270727, s.`map`, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920012067 AS `guid`, 1 AS `map`, -4679.33 AS `x`, -3127.5 AS `y`, 52.3 AS `z`  -- height.py
) s
WHERE @EVERLAKE_CS270727 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS270727 = 1 AND c.`id` = 270727 AND c.`guid` BETWEEN 920012067 AND 920012067;

COMMIT;
