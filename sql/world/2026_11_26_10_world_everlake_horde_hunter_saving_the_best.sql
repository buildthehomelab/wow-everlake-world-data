-- Horde hunter "Saving the Best for Last" (84204, Mokvar 230317 in Orgrimmar) can be completed.
-- 2026_11_26_10_world_everlake_horde_hunter_saving_the_best.sql: written by hand from the tracker's kept facts (2026-11-26).
--
-- Blizzard's server-side note of 25 November 2026 (step 71139+1): "Hunter - The Horde version of "Saving the Best for
-- Last" can now be properly completed." The quest is 84204: Icy Veins' WoW Forever records and EG Link's 71139 quest
-- record give "Give Mokvar your Beaststalker's Cap and Beaststalker's Tunic.", zone Orgrimmar (1637), Horde races, and
-- Icy Veins' addon records Mokvar 230317 as its giver and ender. The realm never had it: 2026_11_21_101 held it back
-- because both records name the objective items 226720 and 226723, which exist nowhere (no item record on the server
-- or the client). That is the bug Blizzard fixed; the objective text names Beaststalker's Cap 16677 and Beaststalker's
-- Tunic 16674, the items the Alliance copy 84196 and the old Horde quest 9008 ask for, so the objectives here are
-- 16677 and 16674 (objective ids 452083/452084 from EG Link).
--
-- Rewards Beastmaster's Cap 226887 and Beastmaster's Tunic 226886 (Icy Veins and EG Link), XP difficulty 2 with
-- multiplier 1 (EG Link), level 60, min level 58. Progress text from Icy Veins' addon dialog record. Class (hunter) and
-- chain (after Back to the Beginning 8998) as the other Horde 841xx quests have (2026_11_21_101, INFERRED from 9008).
-- Left out: a choice reward (the Alliance copy has one, 227388; no record names one for 84204) and the reward text
-- (no record).
--
-- Every added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing. Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_26_10_world_everlake_horde_hunter_saving_the_best.sql';
SET @NOTE := 'Icy Veins + EG Link 71139 quest 84204; objectives from its text (16677/16674); note 71139+1 2026-11-25';
START TRANSACTION;

SET @MISSING := (SELECT COUNT(*) = 0 FROM `quest_template` WHERE `ID` = 84204);

INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestSortID`, `QuestInfoID`, `RewardXPDifficulty`, `RewardXPMultiplier`,
    `RewardMoneyMultiplier`, `RewardArtifactXPMultiplier`, `Flags`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`,
    `RewardFactionCapIn1`, `RewardFactionCapIn2`, `RewardFactionCapIn3`, `RewardFactionCapIn4`, `RewardFactionCapIn5`,
    `AcceptedSoundKitID`, `CompleteSoundKitID`, `AllowableRaces`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`,
    `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`)
SELECT 84204, 2, 1637, 81, 2, 1, 1, 1, 8, 226887, 1, 226886, 1, 7, 7, 7, 7, 7, 890, 878, 12261800583900083122, -2,
    'Saving the Best for Last', 'Give Mokvar your Beaststalker''s Cap and Beaststalker''s Tunic.',
    'A truly amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved, I can assure you. Through your efforts we are delivered from the mistakes of our past.$B$BAs to your reward, I believe I have a few things that you have definitely earned and will truly enjoy.',
    '', '', 0
FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', 84204, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;

INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452083, 84204, 1, 0, 0, 16677, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452083)
UNION ALL
SELECT 452084, 84204, 1, 1, 1, 16674, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452084);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`)
SELECT 'quest_objectives', o.`ID`, @EVERLAKE_FILE, @NOTE FROM `quest_objectives` o WHERE @MISSING AND o.`QuestID` = 84204;

INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`)
SELECT 84204, 60, 58, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` WHERE `ID` = 84204);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`)
SELECT 84204, 2, 60 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` WHERE `ID` = 84204);
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID`)
SELECT 84204, 4, 8998, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 84204);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`, `VerifiedBuild`)
SELECT 84204, 'Are you ready to give me your Beaststalker''s pieces in exchange for your new Beastmaster''s Cap and Tunic?', 0
FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_request_items` WHERE `ID` = 84204);
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`)
SELECT 230317, 84204, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `id` = 230317 AND `quest` = 84204);
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`)
SELECT 230317, 84204, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_questender` WHERE `id` = 230317 AND `quest` = 84204);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`)
SELECT 'quest_classic_level', 84204, 0, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING
UNION ALL
SELECT 'quest_template_classic_level', 84204, 2, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING
UNION ALL
SELECT 'quest_template_addon', 84204, 0, @EVERLAKE_FILE, 'INFERRED: hunter class and chain of the old Horde quest 9008' FROM DUAL WHERE @MISSING
UNION ALL
SELECT 'quest_request_items', 84204, 0, @EVERLAKE_FILE, 'Icy Veins addon dialog (progress)' FROM DUAL WHERE @MISSING
UNION ALL
SELECT 'creature_queststarter', 230317, 84204, @EVERLAKE_FILE, 'Icy Veins addon givers' FROM DUAL WHERE @MISSING
UNION ALL
SELECT 'creature_questender', 230317, 84204, @EVERLAKE_FILE, 'Icy Veins addon givers' FROM DUAL WHERE @MISSING;

COMMIT;
