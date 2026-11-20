-- Portable Repair Bot (creature 277849): what the Portable Repair Bot item (287961) summons.
-- 2026_11_20_10_world_everlake_portable_repair_bot.sql: written by hand.
--
-- The item is CN WoW Forever's Launch Supply Pack bot ("portable repair robots" x30, Battle.net China shop, Nov 2026). Its
-- use spell 1324661 is in the client: SpellEffect 1361582 is effect 28 (summon) of creature 277849, SummonProperties 64,
-- 5 minutes. The realm had no such creature, so the item summoned nothing. The core's hotfix file of the same day adds
-- the item's ItemSparse row (2026_11_20_10_hotfixes_everlake_portable_repair_bot.sql in wow-trinitycore-everlake).
--
-- Sources: Wowhead WoW Forever spell=1324661 and item=287961 (summons npc 277849, model viewer display 149103, "repair
-- damaged items and purchase unwanted goods. After 5 minutes its internal motor fails"); the client's CreatureDisplayInfo
-- 149103 (model 18428, scale 0.5).
-- INFERRED, copied from the Field Repair Bot 74A (14337), the engineers' bot that does the same: faction 35, npcflag
-- 4224 (vendor + repairer), type 9 (mechanical), unit flags, speeds, level 50, no vendor stock (it buys, sells nothing).
-- creature_model_info of display 149103: the Field Repair Bot's display 14379 values (0.6002 / 0.75). Model 18428 has
-- the same CollisionWidth (0.6111) as 14379's model 771, at the same display scale 0.5; no other display uses 18428.
-- No spawn: the item summons it. Not checked in game.
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added (docs/forever-import.md)';

SET @EVERLAKE_FILE := '2026_11_20_10_world_everlake_portable_repair_bot.sql';
SET @EVERLAKE_NOTE := 'Wowhead spell=1324661 summons npc 277849 (display 149103); flags copied from Field Repair Bot 74A 14337';

START TRANSACTION;
SET @EVERLAKE_C277849 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 277849)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 277849);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 277849, 0, 0, 'Portable Repair Bot', NULL, NULL, NULL, NULL, 0, 0, 35, 4224, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 768, 2048, 0, 0, 0, 9, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 64, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C277849 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 277849, 0, 0, 0, 0, 11, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C277849 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 277849, 0, 149103, 1, 1, 0 FROM DUAL WHERE @EVERLAKE_C277849 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 277849, 50, 50 FROM DUAL
WHERE @EVERLAKE_C277849 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 277849);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 277849, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C277849 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 277849);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 277849, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C277849 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 277849, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C277849 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 277849, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C277849 = 1;

SET @EVERLAKE_M149103 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 149103);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 149103, 0.6002, 0.75, 0, 0 FROM DUAL WHERE @EVERLAKE_M149103 = 1;  -- INFERRED from display 14379 (Field Repair Bot 74A)
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 149103, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from display 14379 (Field Repair Bot 74A): same CollisionWidth at scale 0.5' FROM DUAL WHERE @EVERLAKE_M149103 = 1;
COMMIT;
