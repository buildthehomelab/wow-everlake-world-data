-- Six live WoW Forever vendors and trainers the test realm never had standing (2026-11-25).
-- 2026_11_25_27_world_everlake_profession_trainer_spawns.sql: written by hand from the tracker's kept facts (2026-11-25).
--
--   Naria (255703), Food Vendor, Shen'dralar town (Forever zone 16651, UiMap 2652): 12 foods.
--   Jarael (255721), Leatherworking trainer, same town: trainer list 1004212 (Telonis' list, 67 of its 68 spells are
--     the 67 Icy Veins records for Jarael).
--   Melanori (255724), Tailoring trainer, same town: trainer list 1251972 (Charles Worth's, holds all 75 Icy Veins
--     records for Melanori, 77 spells).
--   Hunter Moore (255877), Fisherman, Hillsbrad Foothills south coast pier: trainer list 1001651 (Lee Brown's: Apprentice
--     and Journeyman Fishing and Fish Bowl, the three Wowhead lists). Faction 12 (Stormwind), as Wowhead gives
--     (Stormwind, friendly to Alliance, hostile to Horde) and as the realm's other Stormwind fishing trainers have.
--   Bordolf Axegrim (270278), Warrior Trainer, and Torin Treehame (270280), Hunter Trainer, Aerie Peak (The Hinterlands):
--     no template on the realm. New templates from Icy Veins' record of the live creature (display 146355 / 146356,
--     CreatureDifficulty 353955 / 353957, flags, movement 1693, level 45) with faction 694 (Wildhammer, as Wowhead
--     names for Bordolf and the rest of Aerie Peak has). They get the shared warrior (23) and hunter (20) lists, which
--     hold 101 of Icy Veins' 102 and all 86 of its records.
--
-- The four in the Shen'dralar town and Hillsbrad came in as stand-in templates (2026_11_22_60 Karrz import in the core:
-- faction 16, hostile, no vendor or trainer flag); they change only while they still hold those values.
-- Gossip: each trainer gets the menu of the trainer whose list it shares where that menu says "Train me." (4241, 5665)
-- or the class trainer menus 523 (warrior) and 4474 (hunter); Icy Veins recorded Torin's option as "I seek training in
-- the ways of the Hunter.", which is 4474's.
--
-- Where: Icy Veins' WoW Forever database records where players stood to talk to each one (4 to 11 players, thousandths
-- of the zone map); Wowhead's map pins (tenths of a percent) agree within 3 yards. Map points are turned into world
-- positions with the client's UiMapAssignment rectangles, as the tracker's locator does. Heights from the server's maps
-- and vmaps (tools/height.py): Naria on terrain (149.41, as Arondel beside her); Jarael and Melanori on the town
-- building's lower floor (151.33, Maralus' floor, 2026_11_25_14); Hunter Moore on the pier (4.18); Bordolf and Torin
-- on the Aerie Peak building's floor (120.45; Farseer Maret Firetend stands at 121.09 ten yards east). Facing unknown.
--
-- Left out: Gabbi Goodwhistle (278680, "Specialty Beta Goods & Training"): no source places her on live.
--
-- Own guid block 920019300-920019305. Every added row besides the spawns is recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.
-- Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_25_27_world_everlake_profession_trainer_spawns.sql';
START TRANSACTION;

-- stand-in templates (faction 16, no flags) become what live shows
UPDATE `creature_template` SET `faction` = 35, `npcflag` = 128 WHERE `entry` = 255703 AND `faction` = 16 AND `npcflag` = 0;
UPDATE `creature_template` SET `faction` = 35, `npcflag` = 81 WHERE `entry` IN (255721, 255724) AND `faction` = 16 AND `npcflag` = 0;
UPDATE `creature_template` SET `faction` = 12, `npcflag` = 81 WHERE `entry` = 255877 AND `faction` = 16 AND `npcflag` = 0;

-- the two Aerie Peak trainers' templates, where the realm has none
DROP TEMPORARY TABLE IF EXISTS `everlake_new_trainers`;
CREATE TEMPORARY TABLE `everlake_new_trainers` (`entry` int unsigned NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`))
  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_new_trainers` (`entry`) VALUES (270278), (270280);
UPDATE `everlake_new_trainers` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = s.`entry`);

INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 270278, 0, 0, 'Bordolf Axegrim', NULL, 'Warrior Trainer', NULL, NULL, 0, 0, 694, 49, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 1, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0
FROM `everlake_new_trainers` s WHERE s.`entry` = 270278 AND s.`missing` = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 270278, 0, 0, 0, 0, 0, 1, 1, 1, 1, 353955, 134217728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FROM `everlake_new_trainers` s WHERE s.`entry` = 270278 AND s.`missing` = 1
  AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`Entry` = 270278 AND d.`DifficultyID` = 0);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 270278, 0, 146355, 1, 1, 0
FROM `everlake_new_trainers` s WHERE s.`entry` = 270278 AND s.`missing` = 1
  AND NOT EXISTS (SELECT 1 FROM `creature_template_model` m WHERE m.`CreatureID` = 270278 AND m.`Idx` = 0);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 270280, 0, 0, 'Torin Treehame', NULL, 'Hunter Trainer', NULL, NULL, 0, 0, 694, 49, 1, 1.14286, 1, 0, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 3, 7, 0, '', 0, 1, 0, 1693, 0, 0, 1, 0, 0, '', NULL, 0
FROM `everlake_new_trainers` s WHERE s.`entry` = 270280 AND s.`missing` = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 270280, 0, 0, 0, 0, 0, 1, 1, 1, 1, 353957, 134217728, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FROM `everlake_new_trainers` s WHERE s.`entry` = 270280 AND s.`missing` = 1
  AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`Entry` = 270280 AND d.`DifficultyID` = 0);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 270280, 0, 146356, 1, 1, 0
FROM `everlake_new_trainers` s WHERE s.`entry` = 270280 AND s.`missing` = 1
  AND NOT EXISTS (SELECT 1 FROM `creature_template_model` m WHERE m.`CreatureID` = 270280 AND m.`Idx` = 0);

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', s.`entry`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins + Wowhead (live WoW Forever)' FROM `everlake_new_trainers` s WHERE s.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', s.`entry`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins (live WoW Forever)' FROM `everlake_new_trainers` s WHERE s.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', s.`entry`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins (live WoW Forever)' FROM `everlake_new_trainers` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_new_trainers`;

-- levels (Icy Veins and Wowhead agree), trainer lists and gossip menus, where missing
DROP TEMPORARY TABLE IF EXISTS `everlake_trainer_rows`;
CREATE TEMPORARY TABLE `everlake_trainer_rows` (`entry` int unsigned NOT NULL, `lvl` tinyint unsigned NOT NULL, `trainer` int unsigned NOT NULL,
  `menu` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `lvl_missing` tinyint NOT NULL DEFAULT 0, `tr_missing` tinyint NOT NULL DEFAULT 0,
  `menu_missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_trainer_rows` (`entry`, `lvl`, `trainer`, `menu`, `note`) VALUES
(255703, 60, 0, 0, 'Icy Veins + Wowhead (live WoW Forever): level 60'),
(255721, 60, 1004212, 4241, 'Icy Veins (live WoW Forever): 67 recipes = list 1004212'),
(255724, 60, 1251972, 4241, 'Icy Veins (live WoW Forever): 75 recipes, all in list 1251972'),
(255877, 31, 1001651, 5665, 'Icy Veins + Wowhead (live WoW Forever): fishing, list 1001651'),
(270278, 45, 23, 523, 'Icy Veins (live WoW Forever): warrior, list 23'),
(270280, 45, 20, 4474, 'Icy Veins (live WoW Forever): hunter, list 20, option as 4474');
DELETE s FROM `everlake_trainer_rows` s WHERE NOT EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = s.`entry`);
UPDATE `everlake_trainer_rows` s SET s.`lvl_missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_classic_level` l WHERE l.`entry` = s.`entry`);
UPDATE `everlake_trainer_rows` s SET s.`tr_missing` = 1 WHERE s.`trainer` > 0
  AND NOT EXISTS (SELECT 1 FROM `creature_trainer` c WHERE c.`CreatureID` = s.`entry`);
UPDATE `everlake_trainer_rows` s SET s.`menu_missing` = 1 WHERE s.`menu` > 0
  AND NOT EXISTS (SELECT 1 FROM `creature_template_gossip` g WHERE g.`CreatureID` = s.`entry`);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`) SELECT s.`entry`, s.`lvl`, s.`lvl` FROM `everlake_trainer_rows` s WHERE s.`lvl_missing` = 1;
INSERT INTO `creature_trainer` (`CreatureID`, `TrainerID`, `MenuID`, `OptionID`) SELECT s.`entry`, s.`trainer`, s.`menu`, 0 FROM `everlake_trainer_rows` s WHERE s.`tr_missing` = 1;
INSERT INTO `creature_template_gossip` (`CreatureID`, `MenuID`, `VerifiedBuild`) SELECT s.`entry`, s.`menu`, 0 FROM `everlake_trainer_rows` s WHERE s.`menu_missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', s.`entry`, 0, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_trainer_rows` s WHERE s.`lvl_missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_trainer', s.`entry`, s.`menu`, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_trainer_rows` s WHERE s.`tr_missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_gossip', s.`entry`, s.`menu`, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_trainer_rows` s WHERE s.`menu_missing` = 1;
DROP TEMPORARY TABLE `everlake_trainer_rows`;

-- spawns (own block: put back as written)
DELETE FROM `creature` WHERE `guid` BETWEEN 920019300 AND 920019305;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnDifficulties`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`MovementType`,`VerifiedBuild`) VALUES
(920019300,255703,1,'0',-2888.92,968.43,149.41,0.000,300,0,0,0),
(920019301,255721,1,'0',-2963.27,1152.52,151.33,0.000,300,0,0,0),
(920019302,255724,1,'0',-2962.99,1134.89,151.33,0.000,300,0,0,0),
(920019303,255877,0,'0',-1313.28,-666.13,4.18,0.000,300,0,0,0),
(920019304,270278,0,'0',361.97,-2133.25,120.45,0.000,300,0,0,0),
(920019305,270280,0,'0',361.72,-2138.26,120.45,0.000,300,0,0,0);

-- what Naria sells (Icy Veins and Wowhead list the same 12), where she has no row for the item yet
DROP TEMPORARY TABLE IF EXISTS `everlake_live_vendor`;
CREATE TEMPORARY TABLE `everlake_live_vendor` (`entry` int unsigned NOT NULL, `slot` smallint NOT NULL, `item` int NOT NULL,
  `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`, `item`))
  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_live_vendor` (`entry`, `slot`, `item`, `note`) VALUES
(255703, 1, 2070, 'Icy Veins + Wowhead: 255703 sells 2070'),
(255703, 2, 414, 'Icy Veins + Wowhead: 255703 sells 414'),
(255703, 3, 422, 'Icy Veins + Wowhead: 255703 sells 422'),
(255703, 4, 1707, 'Icy Veins + Wowhead: 255703 sells 1707'),
(255703, 5, 3927, 'Icy Veins + Wowhead: 255703 sells 3927'),
(255703, 6, 8932, 'Icy Veins + Wowhead: 255703 sells 8932'),
(255703, 7, 4536, 'Icy Veins + Wowhead: 255703 sells 4536'),
(255703, 8, 4537, 'Icy Veins + Wowhead: 255703 sells 4537'),
(255703, 9, 4538, 'Icy Veins + Wowhead: 255703 sells 4538'),
(255703, 10, 4539, 'Icy Veins + Wowhead: 255703 sells 4539'),
(255703, 11, 4602, 'Icy Veins + Wowhead: 255703 sells 4602'),
(255703, 12, 8953, 'Icy Veins + Wowhead: 255703 sells 8953');
UPDATE `everlake_live_vendor` s SET s.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `npc_vendor` v WHERE v.`entry` = s.`entry` AND v.`item` = s.`item` AND v.`ExtendedCost` = 0 AND v.`type` = 1)
  AND EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = s.`entry` AND (t.`npcflag` & 128) <> 0);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`)
SELECT s.`entry`, s.`slot`, s.`item`, 0, 0, 0, 1, NULL, 0, 0, 0 FROM `everlake_live_vendor` s WHERE s.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'npc_vendor', s.`entry`, s.`item`, 0, 1, @EVERLAKE_FILE, s.`note` FROM `everlake_live_vendor` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_live_vendor`;

COMMIT;
