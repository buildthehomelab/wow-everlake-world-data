-- "Saving the Best for Last" for the classes the realm lacked: 84197-84199, 84201 (Alliance, Deliana 230319) and 84205,
-- 84206, 84209 (Horde, Mokvar 230317), and a giver and class for 84207 (Horde rogue), which had a quest row only.
-- 2026_11_27_71_world_everlake_saving_the_best_class_quests.sql: written by hand from the tracker's kept facts (2026-11-27).
--
-- Live Forever's Tier 0.5 head and chest upgrade: give Deliana or Mokvar your Dungeon Set 1 head and chest, get Forever's
-- own Tier 0.5 pieces. 2026_11_21_101 held these back because no source named a giver or ender and 84201 had no
-- title; Wowhead's Forever quest pages now name Deliana (84197-84201) and Mokvar (84205-84209) as giver and ender of
-- each, and Icy Veins' WoW Forever records give every quest's title, texts, objectives (with their ids), rewards,
-- levels and XP. Wowhead's item pages show players rewarded by 84199, 84201, 84206 and 84209.
-- Races as the realm's own copies of the series have them (Icy Veins' race masks lost their last digits). Class and
-- chain as the other 842xx quests: INFERRED from the old quest asking for the same pieces (9001/9014 mage, 9002
-- paladin, 9003/9009 priest, 9004/9010 rogue, 9005/9012 warlock; after 8997 Alliance, 8998 Horde).
-- Left out: the progress and reward texts (no record holds them for these ids).
-- Game names and text belong to Blizzard Entertainment.
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
SET @EVERLAKE_FILE := '2026_11_27_71_world_everlake_saving_the_best_class_quests.sql';
START TRANSACTION;


-- 84197: Give Deliana your Magister's Crown and Magister's Robes.
SET @NOTE := 'Icy Veins WoW Forever record 84197; giver/ender Wowhead Forever quest page';
SET @MISSING := (SELECT COUNT(*) = 0 FROM `quest_template` WHERE `ID` = 84197);
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestSortID`, `QuestInfoID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoneyMultiplier`, `RewardArtifactXPMultiplier`, `Flags`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionCapIn1`, `RewardFactionCapIn2`, `RewardFactionCapIn3`, `RewardFactionCapIn4`, `RewardFactionCapIn5`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AllowableRaces`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`)
SELECT 84197, 2, 1537, 81, 2, 2, 1, 1, 8, 226935, 1, 226932, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 890, 878, 6130900294268439629, -2, 'Saving the Best for Last', 'Give Deliana your Magister''s Crown and Magister''s Robes.', 'That''s an amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved. Now maybe I''ll be able to sleep at night with both eyes shut.$B$BAs to your reward, I believe I have a few things that you''ll really enjoy.', '', '', 0 FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', 84197, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452055, 84197, 1, 0, 0, 16686, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452055);
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452056, 84197, 1, 1, 1, 16688, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452056);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', o.`ID`, @EVERLAKE_FILE, @NOTE FROM `quest_objectives` o WHERE @MISSING AND o.`QuestID` = 84197;
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT 84197, 60, 58, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` WHERE `ID` = 84197);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT 84197, 2, 60 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` WHERE `ID` = 84197);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_classic_level', 84197, 0, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING UNION ALL SELECT 'quest_template_classic_level', 84197, 2, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
SET @NOTE_A := 'INFERRED: mage class and chain of the old quest asking for the same pieces';
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID`) SELECT 84197, 128, 8997, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 84197);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template_addon', 84197, @EVERLAKE_FILE, @NOTE_A FROM DUAL WHERE @MISSING;
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT 230319, 84197, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `id` = 230319 AND `quest` = 84197);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', 230319, 84197, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT 230319, 84197, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_questender` WHERE `id` = 230319 AND `quest` = 84197);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', 230319, 84197, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;

-- 84198: Give Deliana your Lightforge Helm and Lightforge Breastplate.
SET @NOTE := 'Icy Veins WoW Forever record 84198; giver/ender Wowhead Forever quest page';
SET @MISSING := (SELECT COUNT(*) = 0 FROM `quest_template` WHERE `ID` = 84198);
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestSortID`, `QuestInfoID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoneyMultiplier`, `RewardArtifactXPMultiplier`, `Flags`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionCapIn1`, `RewardFactionCapIn2`, `RewardFactionCapIn3`, `RewardFactionCapIn4`, `RewardFactionCapIn5`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AllowableRaces`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`)
SELECT 84198, 2, 1537, 81, 2, 2, 1, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 227390, 1, 227391, 1, 227392, 1, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 890, 878, 6130900294268439629, -2, 'Saving the Best for Last', 'Give Deliana your Lightforge Helm and Lightforge Breastplate.', 'That''s an amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved. Now maybe I''ll be able to sleep at night with both eyes shut.$B$BAs to your reward, I believe I have a few things that you''ll really enjoy.', '', '', 0 FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', 84198, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452059, 84198, 1, 0, 0, 16727, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452059);
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452060, 84198, 1, 1, 1, 16726, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452060);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', o.`ID`, @EVERLAKE_FILE, @NOTE FROM `quest_objectives` o WHERE @MISSING AND o.`QuestID` = 84198;
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT 84198, 60, 58, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` WHERE `ID` = 84198);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT 84198, 2, 60 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` WHERE `ID` = 84198);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_classic_level', 84198, 0, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING UNION ALL SELECT 'quest_template_classic_level', 84198, 2, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
SET @NOTE_A := 'INFERRED: paladin class and chain of the old quest asking for the same pieces';
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID`) SELECT 84198, 2, 8997, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 84198);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template_addon', 84198, @EVERLAKE_FILE, @NOTE_A FROM DUAL WHERE @MISSING;
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT 230319, 84198, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `id` = 230319 AND `quest` = 84198);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', 230319, 84198, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT 230319, 84198, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_questender` WHERE `id` = 230319 AND `quest` = 84198);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', 230319, 84198, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;

-- 84199: Give Deliana your Devout Crown and Devout Robe.
SET @NOTE := 'Icy Veins WoW Forever record 84199; giver/ender Wowhead Forever quest page';
SET @MISSING := (SELECT COUNT(*) = 0 FROM `quest_template` WHERE `ID` = 84199);
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestSortID`, `QuestInfoID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoneyMultiplier`, `RewardArtifactXPMultiplier`, `Flags`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionCapIn1`, `RewardFactionCapIn2`, `RewardFactionCapIn3`, `RewardFactionCapIn4`, `RewardFactionCapIn5`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AllowableRaces`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`)
SELECT 84199, 2, 1537, 81, 2, 2, 1, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 227393, 1, 227394, 1, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 890, 878, 6130900294268439629, -2, 'Saving the Best for Last', 'Give Deliana your Devout Crown and Devout Robe.', 'That''s an amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved. Now maybe I''ll be able to sleep at night with both eyes shut.$B$BAs to your reward, I believe I have a few things that you''ll really enjoy.', '', '', 0 FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', 84199, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452063, 84199, 1, 0, 0, 16693, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452063);
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452064, 84199, 1, 1, 1, 16690, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452064);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', o.`ID`, @EVERLAKE_FILE, @NOTE FROM `quest_objectives` o WHERE @MISSING AND o.`QuestID` = 84199;
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT 84199, 60, 58, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` WHERE `ID` = 84199);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT 84199, 2, 60 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` WHERE `ID` = 84199);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_classic_level', 84199, 0, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING UNION ALL SELECT 'quest_template_classic_level', 84199, 2, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
SET @NOTE_A := 'INFERRED: priest class and chain of the old quest asking for the same pieces';
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID`) SELECT 84199, 16, 8997, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 84199);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template_addon', 84199, @EVERLAKE_FILE, @NOTE_A FROM DUAL WHERE @MISSING;
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT 230319, 84199, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `id` = 230319 AND `quest` = 84199);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', 230319, 84199, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT 230319, 84199, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_questender` WHERE `id` = 230319 AND `quest` = 84199);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', 230319, 84199, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;

-- 84201: Give Deliana your Dreadmist Mask and Dreadmist Robe.
SET @NOTE := 'Icy Veins WoW Forever record 84201; giver/ender Wowhead Forever quest page';
SET @MISSING := (SELECT COUNT(*) = 0 FROM `quest_template` WHERE `ID` = 84201);
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestSortID`, `QuestInfoID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoneyMultiplier`, `RewardArtifactXPMultiplier`, `Flags`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionCapIn1`, `RewardFactionCapIn2`, `RewardFactionCapIn3`, `RewardFactionCapIn4`, `RewardFactionCapIn5`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AllowableRaces`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`)
SELECT 84201, 2, 1537, 81, 2, 2, 1, 1, 8, 226909, 1, 226906, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 890, 878, 6130900294268439629, -2, 'Saving the Best for Last', 'Give Deliana your Dreadmist Mask and Dreadmist Robe.', 'That''s an amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved. Now maybe I''ll be able to sleep at night with both eyes shut.$B$BAs to your reward, I believe I have a few things that you''ll really enjoy.', '', '', 0 FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', 84201, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452071, 84201, 1, 0, 0, 16698, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452071);
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452072, 84201, 1, 1, 1, 16700, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452072);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', o.`ID`, @EVERLAKE_FILE, @NOTE FROM `quest_objectives` o WHERE @MISSING AND o.`QuestID` = 84201;
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT 84201, 60, 58, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` WHERE `ID` = 84201);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT 84201, 2, 60 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` WHERE `ID` = 84201);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_classic_level', 84201, 0, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING UNION ALL SELECT 'quest_template_classic_level', 84201, 2, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
SET @NOTE_A := 'INFERRED: warlock class and chain of the old quest asking for the same pieces';
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID`) SELECT 84201, 256, 8997, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 84201);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template_addon', 84201, @EVERLAKE_FILE, @NOTE_A FROM DUAL WHERE @MISSING;
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT 230319, 84201, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `id` = 230319 AND `quest` = 84201);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', 230319, 84201, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT 230319, 84201, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_questender` WHERE `id` = 230319 AND `quest` = 84201);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', 230319, 84201, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;

-- 84205: Give Mokvar your Magister's Crown and Magister's Robes.
SET @NOTE := 'Icy Veins WoW Forever record 84205; giver/ender Wowhead Forever quest page';
SET @MISSING := (SELECT COUNT(*) = 0 FROM `quest_template` WHERE `ID` = 84205);
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestSortID`, `QuestInfoID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoneyMultiplier`, `RewardArtifactXPMultiplier`, `Flags`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionCapIn1`, `RewardFactionCapIn2`, `RewardFactionCapIn3`, `RewardFactionCapIn4`, `RewardFactionCapIn5`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AllowableRaces`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`)
SELECT 84205, 2, 1637, 81, 2, 1, 1, 1, 8, 226935, 1, 226932, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 890, 878, 12261800583900083616, -2, 'Saving the Best for Last', 'Give Mokvar your Magister''s Crown and Magister''s Robes.', 'A truly amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved, I can assure you. Through your efforts we are delivered from the mistakes of our past.$B$BAs to your reward, I believe I have a few things that you have definitely earned and will truly enjoy.', '', '', 0 FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', 84205, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452087, 84205, 1, 0, 0, 16686, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452087);
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452088, 84205, 1, 1, 1, 16688, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452088);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', o.`ID`, @EVERLAKE_FILE, @NOTE FROM `quest_objectives` o WHERE @MISSING AND o.`QuestID` = 84205;
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT 84205, 60, 58, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` WHERE `ID` = 84205);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT 84205, 2, 60 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` WHERE `ID` = 84205);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_classic_level', 84205, 0, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING UNION ALL SELECT 'quest_template_classic_level', 84205, 2, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
SET @NOTE_A := 'INFERRED: mage class and chain of the old quest asking for the same pieces';
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID`) SELECT 84205, 128, 8998, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 84205);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template_addon', 84205, @EVERLAKE_FILE, @NOTE_A FROM DUAL WHERE @MISSING;
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT 230317, 84205, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `id` = 230317 AND `quest` = 84205);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', 230317, 84205, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT 230317, 84205, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_questender` WHERE `id` = 230317 AND `quest` = 84205);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', 230317, 84205, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;

-- 84206: Give Mokvar your Devout Crown and Devout Robe.
SET @NOTE := 'Icy Veins WoW Forever record 84206; giver/ender Wowhead Forever quest page';
SET @MISSING := (SELECT COUNT(*) = 0 FROM `quest_template` WHERE `ID` = 84206);
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestSortID`, `QuestInfoID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoneyMultiplier`, `RewardArtifactXPMultiplier`, `Flags`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionCapIn1`, `RewardFactionCapIn2`, `RewardFactionCapIn3`, `RewardFactionCapIn4`, `RewardFactionCapIn5`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AllowableRaces`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`)
SELECT 84206, 2, 1637, 81, 2, 1, 1, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0, 227393, 1, 227394, 1, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 890, 878, 12261800583900083616, -2, 'Saving the Best for Last', 'Give Mokvar your Devout Crown and Devout Robe.', 'A truly amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved, I can assure you. Through your efforts we are delivered from the mistakes of our past.$B$BAs to your reward, I believe I have a few things that you have definitely earned and will truly enjoy.', '', '', 0 FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', 84206, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452091, 84206, 1, 0, 0, 16693, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452091);
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452092, 84206, 1, 1, 1, 16690, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452092);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', o.`ID`, @EVERLAKE_FILE, @NOTE FROM `quest_objectives` o WHERE @MISSING AND o.`QuestID` = 84206;
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT 84206, 60, 58, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` WHERE `ID` = 84206);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT 84206, 2, 60 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` WHERE `ID` = 84206);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_classic_level', 84206, 0, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING UNION ALL SELECT 'quest_template_classic_level', 84206, 2, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
SET @NOTE_A := 'INFERRED: priest class and chain of the old quest asking for the same pieces';
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID`) SELECT 84206, 16, 8998, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 84206);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template_addon', 84206, @EVERLAKE_FILE, @NOTE_A FROM DUAL WHERE @MISSING;
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT 230317, 84206, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `id` = 230317 AND `quest` = 84206);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', 230317, 84206, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT 230317, 84206, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_questender` WHERE `id` = 230317 AND `quest` = 84206);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', 230317, 84206, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;

-- 84209: Give Mokvar your Dreadmist Mask and Dreadmist Robe.
SET @NOTE := 'Icy Veins WoW Forever record 84209; giver/ender Wowhead Forever quest page';
SET @MISSING := (SELECT COUNT(*) = 0 FROM `quest_template` WHERE `ID` = 84209);
INSERT INTO `quest_template` (`ID`, `QuestType`, `QuestSortID`, `QuestInfoID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardMoneyMultiplier`, `RewardArtifactXPMultiplier`, `Flags`, `RewardItem1`, `RewardAmount1`, `RewardItem2`, `RewardAmount2`, `RewardItem3`, `RewardAmount3`, `RewardItem4`, `RewardAmount4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionCapIn1`, `RewardFactionCapIn2`, `RewardFactionCapIn3`, `RewardFactionCapIn4`, `RewardFactionCapIn5`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `AllowableRaces`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`)
SELECT 84209, 2, 1637, 81, 2, 1, 1, 1, 8, 226909, 1, 226906, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 890, 878, 12261800583900083616, -2, 'Saving the Best for Last', 'Give Mokvar your Dreadmist Mask and Dreadmist Robe.', 'A truly amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved, I can assure you. Through your efforts we are delivered from the mistakes of our past.$B$BAs to your reward, I believe I have a few things that you have definitely earned and will truly enjoy.', '', '', 0 FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', 84209, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452103, 84209, 1, 0, 0, 16698, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452103);
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`)
SELECT 452104, 84209, 1, 1, 1, 16700, 1, 32, '', 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 452104);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', o.`ID`, @EVERLAKE_FILE, @NOTE FROM `quest_objectives` o WHERE @MISSING AND o.`QuestID` = 84209;
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT 84209, 60, 58, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` WHERE `ID` = 84209);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT 84209, 2, 60 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` WHERE `ID` = 84209);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_classic_level', 84209, 0, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING UNION ALL SELECT 'quest_template_classic_level', 84209, 2, @EVERLAKE_FILE, @NOTE FROM DUAL WHERE @MISSING;
SET @NOTE_A := 'INFERRED: warlock class and chain of the old quest asking for the same pieces';
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID`) SELECT 84209, 256, 8998, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 84209);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template_addon', 84209, @EVERLAKE_FILE, @NOTE_A FROM DUAL WHERE @MISSING;
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT 230317, 84209, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `id` = 230317 AND `quest` = 84209);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', 230317, 84209, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT 230317, 84209, 0 FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `creature_questender` WHERE `id` = 230317 AND `quest` = 84209);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', 230317, 84209, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM DUAL WHERE @MISSING;

-- 84207 (Horde rogue, Shadowcraft Cap and Tunic): the realm has its quest row but no class, chain, giver or ender
SET @HAS := (SELECT COUNT(*) = 1 FROM `quest_template` WHERE `ID` = 84207);
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID`) SELECT 84207, 8, 8998, 0 FROM DUAL WHERE @HAS AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 84207) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` WHERE `tbl` = 'quest_template_addon' AND `k1` = 84207);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template_addon', 84207, @EVERLAKE_FILE, 'INFERRED: rogue class and chain of the old quest 9010' FROM `quest_template_addon` WHERE `ID` = 84207 AND `AllowableClasses` = 8 AND `PrevQuestID` = 8998;
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT 230317, 84207, 0 FROM DUAL WHERE @HAS AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` WHERE `quest` = 84207) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_queststarter' AND `k2` = 84207);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', 230317, 84207, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM `creature_queststarter` WHERE `id` = 230317 AND `quest` = 84207;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT 230317, 84207, 0 FROM DUAL WHERE @HAS AND NOT EXISTS (SELECT 1 FROM `creature_questender` WHERE `quest` = 84207) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_questender' AND `k2` = 84207);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', 230317, 84207, @EVERLAKE_FILE, 'Wowhead WoW Forever quest page' FROM `creature_questender` WHERE `id` = 230317 AND `quest` = 84207;

COMMIT;
