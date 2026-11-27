-- Three Mount Hyjal (Forever zone 616, UiMap 2482) quests whose objective creatures were not on the realm (2026-11-26).
-- 2026_11_26_98_world_everlake_hyjal_quest_credit_npcs.sql: written by hand from the tracker's kept facts, not tried in game.
-- The core has no script for any NPC, spell or quest below (checked in the fork's src/ and sql/custom/).
--
-- 1. 92833 Ve'han's Fall counts creature 260674 "Ve'han Talongrasp", which has no spawn on live either (Wowhead
--    Forever and Icy Veins give no map point for it). The one in the world is the elite 267182 "Ve'han Talongrasp,
--    Disciple of the Wild King" (Wowhead Forever tooltip, Icy Veins, EG Link creature_details 71091): it drops the
--    same quest item 270301 and its map points (Wowhead 75.8 32.6 / 75.8 35 / 76.0 33.8, Icy Veins loot point 76.5
--    34.9) are the realm's three 267182 spawns (42000067-69, from 2026_11_05_99). The realm still holds the old
--    record for 267182, "Ve'ho Manyhorns, Lieutenant of the Wild King", model 142562; live has Ve'han, model 149297
--    at scale 1.25 (Icy Veins npc_display, EG Link). So:
--      - 267182 gets the live name, title and model, each only while it holds the old one;
--      - 260674 gets a template (Icy Veins / EG Link: humanoid, unit class 2, model 149297, health x1.5, mana x1.1,
--        CreatureDifficultyID 343881; level 60 INFERRED from 267182 and the quest level) and is 267182's KillCredit1,
--        so killing Ve'han counts. INFERRED: live may turn the elite into 260674 once the staff is used; the credit
--        is the same either way.
--      - Wowhead Forever lists 1326056 Blackthorne's Ward among 267182's abilities, and the quest's Staff of the
--        Mountain (267079) casts 1279523 Remove Protection, whose client SpellEffect is REMOVE_AURA 1326056 on the
--        target ("Dispel the magic protecting him", quest text). 267182 wears the ward from spawn (addon aura), so
--        the staff has something to strip, only where 267182 has no addon row.
-- 2. 96003 Drawing Down the Malevolent counts 263427 "Bethra'zel the Feeble" and 263426 "Mazzogore the Weak". Live
--    has no spawn of either (no map point in any source). The demons in the world are the elites 263394 Bethra'zel
--    and 252457 Mazzogore (Wowhead Forever: level 60 elite demons, hostile to both factions; Icy Veins: level 60,
--    one loot point each, Mount Hyjal 58.6 32.5 and 50.5 39.7). The realm has none of the four. All four get
--    templates from Icy Veins' npc records (type, unit class, model and scale, health and mana multipliers,
--    CreatureDifficultyID), level 60 (Icy Veins addon_levels for the elites, INFERRED for the weak ones), faction 14
--    like the camp's Doomguards (249236). The elites carry the weak ones as KillCredit1 (INFERRED as in 1: the quest's
--    Eye of Endless Influence casts 1289714 Power Sap, a dummy effect the core does not script). One spawn each at
--    Icy Veins' loot point, turned into a world position with the client's UiMapAssignment, height from the realm's
--    maps and vmaps (ForeverTracker tools/height.py) on the floor nearest the camp's Doomguards (z hints 1497 and
--    1540). Respawn 300 s, no wander, orientation 0: INFERRED. Their loot and abilities are left out.
-- 3. 93383 Contents Under Pressure: "Wait until you can safely open the Personal Survival Pack." counts 254777, an
--    invisible Personal Survival Pack (Icy Veins: type 10, model 11686, the realm's other kill-credit bunnies use the
--    same). No source records how long the wait is or what gives the credit. The pack the player talks to (254644,
--    spawned on the realm at Icy Veins' talk point) gives the credit when the quest is accepted, by SmartAI. INFERRED:
--    live makes the player wait a moment first (the progress text "The red indicator light on the radio flashes
--    dimly"); no source gives the time, so there is no wait here. 254777 gets a bunny template (as 272603 in the
--    core's 2026_11_22_60) because the SmartAI credit needs one.
--
-- Guids 920036600-920036601, a block of their own (920036600-920036649).
-- Rows are only added where none exist, AI only where the NPC has none. Added rows are recorded in everlake_import_rows.
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
SET @EVERLAKE_FILE := '2026_11_26_98_world_everlake_hyjal_quest_credit_npcs.sql';

START TRANSACTION;

-- new templates, only where the entry has none
DROP TEMPORARY TABLE IF EXISTS `everlake_hy_npc`;
CREATE TEMPORARY TABLE `everlake_hy_npc` (
  `entry` int unsigned NOT NULL, `credit` int unsigned NOT NULL, `name` varchar(100) NOT NULL, `subname` varchar(100) NULL,
  `faction` int unsigned NOT NULL, `classification` tinyint NOT NULL, `unit_class` tinyint NOT NULL, `unit_flags` int unsigned NOT NULL,
  `type` tinyint NOT NULL, `flags_extra` int unsigned NOT NULL, `display` int unsigned NOT NULL, `scale` float NOT NULL,
  `health` float NOT NULL, `mana` float NOT NULL, `cdid` int NOT NULL, `level` tinyint unsigned NOT NULL, `note` varchar(255) NOT NULL,
  `ok` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_hy_npc` VALUES
(260674, 0, 'Ve''han Talongrasp', 'Disciple of the Wild King', 14, 0, 2, 0, 7, 0, 149297, 1, 1.5, 1.1, 343881, 60, 'Icy Veins + EG Link 71091 npc 260674; level INFERRED', 0),
(263426, 0, 'Mazzogore the Weak', NULL, 14, 0, 1, 0, 3, 0, 137433, 1, 1.2, 1, 346733, 60, 'Icy Veins + EG Link 71091 npc 263426; level INFERRED', 0),
(263427, 0, 'Bethra''zel the Feeble', NULL, 14, 0, 2, 0, 3, 0, 4426, 1.25, 1.5, 5, 346734, 60, 'Icy Veins + EG Link 71091 npc 263427; level INFERRED', 0),
(252457, 263426, 'Mazzogore', NULL, 14, 1, 1, 0, 3, 0, 137433, 1.5, 5, 1, 333297, 60, 'Icy Veins + EG Link 71091 npc 252457, Wowhead Forever elite; KillCredit1 INFERRED', 0),
(263394, 263427, 'Bethra''zel', NULL, 14, 1, 2, 0, 3, 0, 4426, 2, 20, 5, 346701, 60, 'Icy Veins + EG Link 71091 npc 263394, Wowhead Forever elite; KillCredit1 INFERRED', 0),
(254777, 0, 'Personal Survival Pack', NULL, 35, 0, 2, 33554432, 10, 128, 11686, 1, 5.05, 1, 335683, 57, 'Icy Veins npc 254777 (type 10, model 11686), Wowhead level 57; bunny flags as 272603', 0);
UPDATE `everlake_hy_npc` s SET s.`ok` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = s.`entry`);

INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`entry`, s.`credit`, 0, s.`name`, NULL, s.`subname`, NULL, NULL, 0, 0, s.`faction`, 0, 1, 1.14286, 1, s.`classification`, 0, 2000, 2000, 1, 1, s.`unit_class`, s.`unit_flags`, 2048, 0, 0, 0, s.`type`, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, s.`flags_extra`, '', NULL, 0
FROM `everlake_hy_npc` s WHERE s.`ok` = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT s.`entry`, 0, 0, 0, 0, 0, s.`health`, s.`mana`, 1, 1, s.`cdid`, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
FROM `everlake_hy_npc` s WHERE s.`ok` = 1 AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`DifficultyID` = 0);
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT s.`entry`, 0, s.`display`, s.`scale`, 1, 0
FROM `everlake_hy_npc` s WHERE s.`ok` = 1 AND NOT EXISTS (SELECT 1 FROM `creature_template_model` m WHERE m.`CreatureID` = s.`entry`);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT s.`entry`, s.`level`, s.`level` FROM `everlake_hy_npc` s WHERE s.`ok` = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` l WHERE l.`entry` = s.`entry`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', s.`entry`, 0, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_hy_npc` s WHERE s.`ok` = 1;
DROP TEMPORARY TABLE `everlake_hy_npc`;

-- 1. 267182: live name, title and model; credit 260674; Blackthorne's Ward from spawn
UPDATE `creature_template` SET `name` = 'Ve''han Talongrasp', `subname` = 'Disciple of the Wild King'
WHERE `entry` = 267182 AND `name` = 'Ve''ho Manyhorns';
UPDATE `creature_template_model` SET `CreatureDisplayID` = 149297, `DisplayScale` = 1.25
WHERE `CreatureID` = 267182 AND `Idx` = 0 AND `CreatureDisplayID` = 142562;
SET @EVERLAKE_HAS_260674 := (SELECT COUNT(*) FROM `creature_template` WHERE `entry` = 260674);
UPDATE `creature_template` SET `KillCredit1` = 260674
WHERE `entry` = 267182 AND `KillCredit1` = 0 AND `KillCredit2` <> 260674 AND @EVERLAKE_HAS_260674 > 0;
INSERT INTO `creature_template_addon` (`entry`, `PathId`, `mount`, `MountCreatureID`, `StandState`, `AnimTier`, `VisFlags`, `SheathState`, `PvPFlags`, `emote`, `aiAnimKit`, `movementAnimKit`, `meleeAnimKit`, `visibilityDistanceType`, `auras`)
SELECT 267182, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '1326056' FROM DUAL
WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 267182)
  AND NOT EXISTS (SELECT 1 FROM `creature_template_addon` WHERE `entry` = 267182);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_addon', 267182, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead Forever ability 1326056; client SpellEffect of 1279523 removes it'
FROM `creature_template_addon` WHERE `entry` = 267182 AND `auras` = '1326056';

-- 2. Bethra'zel and Mazzogore (own block: put back as written)
DELETE FROM `creature` WHERE `guid` BETWEEN 920036600 AND 920036649;
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnDifficulties`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`)
SELECT 920036600, 252457, 1, '0', 5385.51, -2676.05, 1494.20, 0, 300, 0, 0, 0 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 252457);
INSERT INTO `creature` (`guid`, `id`, `map`, `spawnDifficulties`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`)
SELECT 920036601, 263394, 1, '0', 5552.85, -2958.05, 1537.19, 0, 300, 0, 0, 0 FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 263394);

-- 3. Personal Survival Pack (254644): credit 254777 when Contents Under Pressure is accepted
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `action_param_string`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_param_string`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 254644, 0, 0, 0, '', 19, 0, 100, 0, 93383, 0, 0, 0, 0, '', 33, 254777, 0, 0, 0, 0, 0, 0, '', 7, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Personal Survival Pack - On quest 93383 accepted - Kill credit 254777 to the player'
FROM DUAL
WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 254644 AND `AIName` = '' AND `ScriptName` = '')
  AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 254777)
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` WHERE `entryorguid` = 254644 AND `source_type` = 0);
UPDATE `creature_template` SET `AIName` = 'SmartAI'
WHERE `entry` = 254644 AND `AIName` = '' AND `ScriptName` = ''
  AND EXISTS (SELECT 1 FROM `smart_scripts` WHERE `entryorguid` = 254644 AND `source_type` = 0 AND `event_type` = 19 AND `event_param1` = 93383);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', 254644, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins/Wowhead: 254644 starts and ends 93383, objective 254777; no wait (time unknown)'
FROM `smart_scripts` WHERE `entryorguid` = 254644 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 19;

COMMIT;
