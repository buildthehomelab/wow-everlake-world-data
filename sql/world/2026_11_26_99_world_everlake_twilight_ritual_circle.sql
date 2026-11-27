-- Twilight Ritual Circle (262006) for Sickening Lights (95602, Horde, Riverglades), template only (2026-11-26).
-- 2026_11_26_99_world_everlake_twilight_ritual_circle.sql: written by hand from the tracker's kept facts, not tried in game.
--
-- 95602 "Destroy 5 Twilight Ritual Circles found throughout the caves underneath Sunnyglade" counts 272603
-- "[DNT] Kill Credit" (on the realm since the core's 2026_11_22_60, unspawned like on live). The thing the player
-- destroys is the creature 262006 "Twilight Ritual Circle" (EG Link creatures 70938-71037: seen 13-30 times, level 1,
-- hostile to the Horde; Icy Veins npc 262006: 16 sightings on UiMap 2548 Riverglades, level 1; Wowhead Forever:
-- objective of the Alliance twin 95642). The realm has no template for it. It gets one from Icy Veins' record (type 10,
-- unit class 1, model 143045, health x1.35, CreatureDifficultyID 345276), level 1, faction 14 (hostile to both: the
-- Alliance quest destroys them too, INFERRED), no movement. KillCredit1 = 272603, so destroying one counts for 95602
-- (INFERRED: no source names the link; 272603 has no spawn and is objective of 95602 only).
--
-- NOT spawned: Icy Veins' sightings are where the watching player stood (they sit 30-100 yards from each other above
-- a cave model with floors from about +8 down to -55), and no source gives a circle's own position or cave floor.
-- Place them in game (Forge) in the caves under Sunnyglade near Clubtoe (260931).
--
-- Rows are only added where none exist and are recorded in everlake_import_rows.
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';
SET @EVERLAKE_FILE := '2026_11_26_99_world_everlake_twilight_ritual_circle.sql';

START TRANSACTION;

SET @EVERLAKE_NEW_262006 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 262006);
SET @EVERLAKE_HAS_272603 := (SELECT COUNT(*) > 0 FROM `creature_template` WHERE `entry` = 272603);

INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 262006, IF(@EVERLAKE_HAS_272603, 272603, 0), 0, 'Twilight Ritual Circle', NULL, NULL, NULL, NULL, 0, 0, 14, 0, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0
FROM DUAL WHERE @EVERLAKE_NEW_262006;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 262006, 0, 0, 0, 0, 0, 1.35, 1, 1, 1, 345276, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FROM DUAL WHERE @EVERLAKE_NEW_262006 AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` WHERE `Entry` = 262006 AND `DifficultyID` = 0);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 262006, 0, 143045, 1, 1, 0
FROM DUAL WHERE @EVERLAKE_NEW_262006 AND NOT EXISTS (SELECT 1 FROM `creature_template_model` WHERE `CreatureID` = 262006);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 262006, 1, 1 FROM DUAL WHERE @EVERLAKE_NEW_262006 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 262006);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 262006, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins + EG Link npc 262006; KillCredit1 272603 INFERRED (95602)'
FROM DUAL WHERE @EVERLAKE_NEW_262006;

COMMIT;
