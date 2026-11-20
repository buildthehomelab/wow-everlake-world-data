-- World build: 5 missing quests from the Icy Veins WoW Forever database
-- 2026_11_20_28_world_everlake_quests_tome_folkar_thera.sql: quest records (title, texts, objectives, rewards, levels, givers and enders) from the Icy Veins catalogue
-- (https://db.icy-veins.com/wow-forever/), which players' addons recorded on live WoW Forever, written in the shape of the
-- tracker's build files.
-- Quests 91497, 91500, 91538 (Sin'dorei Tome of Summoning, Azshara) and 96265 (taken by Thera Duskwhisper) need the NPCs
-- of file 2026_11_20_27, which runs first. Enders checked against NorgannonDB and QuestieDB's Forever data.
-- INFERRED enders (no source records one; the quest text names the NPC): 95309 No Orc Left Behind -> Commander Folkar
-- (260386), 96265 Secret of the Barrow Deeps -> Thera Duskwhisper (268606). 96265 starts from the Corrupted Gemstone.
-- Written against (not a replay): the world import up to 2026_11_20_27 and the PTR world as the tracker read it on 2026-11-20.
-- Reputation is written as an override (amount x 100), money in quest_classic_money; quest_template_addon, POIs,
-- quest_details and emotes are left to defaults. Turn-in texts only where every recording has one wording.
-- Game names and text belong to Blizzard Entertainment.
-- Each row is recorded in `everlake_import_rows`. Never edit this file once it is deployed: a later fix is a new file.
-- Running it again changes nothing.
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
START TRANSACTION;
CREATE TEMPORARY TABLE `everlake_build_quests` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY, `note` VARCHAR(255) NOT NULL DEFAULT '', `missing` TINYINT NOT NULL DEFAULT 0) SELECT `ID`, `RewardItem1`, `RewardAmount1`, `ItemDrop1`, `ItemDropQuantity1`, `RewardItem2`, `RewardAmount2`, `ItemDrop2`, `ItemDropQuantity2`, `RewardItem3`, `RewardAmount3`, `ItemDrop3`, `ItemDropQuantity3`, `RewardItem4`, `RewardAmount4`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `QuestType`, `QuestInfoID`, `RewardNextQuest`, `StartItem`, `Flags`, `FlagsEx`, `FlagsEx2`, `TimeAllowed`, `QuestSortID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardSpell`, `AllowableRaces`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog` FROM `quest_template` WHERE 0;
INSERT INTO `everlake_build_quests` (`n`, `ID`, `RewardItem1`, `RewardAmount1`, `ItemDrop1`, `ItemDropQuantity1`, `RewardItem2`, `RewardAmount2`, `ItemDrop2`, `ItemDropQuantity2`, `RewardItem3`, `RewardAmount3`, `ItemDrop3`, `ItemDropQuantity3`, `RewardItem4`, `RewardAmount4`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `QuestType`, `QuestInfoID`, `RewardNextQuest`, `StartItem`, `Flags`, `FlagsEx`, `FlagsEx2`, `TimeAllowed`, `QuestSortID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardSpell`, `AllowableRaces`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `note`) VALUES
(1, 91497, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 8, 0, 0, 0, 16, 5, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Seals of the Sin''dorei', 'Bring the Seal of the Warden, Seal of the Warrior, and Seal of the Ranger to the Sin''dorei Tome of Summoning.', '<The seal of the first crystal bears the mark of a sword. Its energy must be channeled by an expert warrior.\r\n\r\nThe seal of the middle crystal bears the mark of a glaive. Its energy must be channeled by one of both martial and magical prowess.\r\n\r\nThe seal of the last crystal bears the mark of a talon. Its energy must be channeled by one at home in the wilds.\r\n\r\nIt''s likely that some of Rimtori''s officers are carrying these seals to aid her in the spell. Taking them would no doubt be troublesome for her.>', '', '', 'seen-live: icyveins:catalog'), -- Seals of the Sin'dorei
(2, 91500, 0, 0, 249390, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 249390, 0, 0, 0, 0, 16, 4, 1.0, 0, 12261800583900083616, 890, 878, -2, 'An Explosive Gambit', 'Break the Seals of the Sin''dorei, then bring Magus Rimtori''s head to Ag''tor Bloodfist in Valormok.', '<Seeing how the energies of the crystals are attuned to the seals, you reason that destroying a seal, thereby releasing its energy all at once, could cause its crystal to do the same.\r\n\r\nThe explosive results would certainly draw Rimtori''s ire. It would also present the perfect opportunity to attack her while she''s flustered.>', '', '', 'seen-live: icyveins:catalog'), -- An Explosive Gambit
(3, 91538, 0, 0, 246770, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 1000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 246770, 0, 0, 0, 0, 16, 1, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Sin''dorei Tome of Summoning', 'Bring the Sin''dorei Tome of Summoning back to Jediga in Valormok.', 'Rimtori''s tome still sits atop its pedestal. Who knows what secrets its pages could hold? \r\n\r\nPerhaps it would be best not to leave such a powerful artifact out here in the wilds.', '', '', 'seen-live: icyveins:catalog'), -- Sin'dorei Tome of Summoning
(4, 95309, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 15000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 2097160, 0, 0, 0, 16620, 6, 1.85, 0, 12261800583900083616, 890, 878, -2, 'No Orc Left Behind', 'Enter the Alcaz Prison and find Commander Folkar.', 'Your orders are simple-- Go into the dungeons beneath the keep and find Commander Folkar. Free him if he lives, and learn what you can about what in the twisting nether is going on here.\r\n\r\nThere''s an army waiting for you down there and you won''t survive on your own. I hope you have allies... preferably strong ones.', '', '', 'seen-live: icyveins:catalog'), -- No Orc Left Behind
(5, 96265, 0, 0, 277154, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 277154, 0, 0, 0, 0, 618, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Secret of the Barrow Deeps', 'Take the Corrupted Gemstone to Thera Duskwhisper in Winterspring.', '<The corrupted shards combine into a gem seething with tainted power. The Watchers will want to see this.>', '', 'Take the Corrupted Gemstone to Thera Duskwhisper in Winterspring.', 'seen-live: icyveins:catalog'); -- Secret of the Barrow Deeps
CREATE TEMPORARY TABLE `everlake_build_objectives` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY, `taken` TINYINT NOT NULL DEFAULT 0) SELECT `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description` FROM `quest_objectives` WHERE 0;
INSERT INTO `everlake_build_objectives` (`n`, `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`) VALUES
(1, 462973, 91497, 1, 0, 0, 246725, 1, 32, ''),
(2, 462908, 91497, 1, 1, 1, 246721, 1, 32, ''),
(3, 462974, 91497, 1, 2, 2, 246722, 1, 32, ''),
(4, 462912, 91500, 1, 0, 1, 10597, 1, 32, ''),
(5, 462956, 91538, 1, 0, 0, 246770, 1, 32, ''),
(6, 472860, 95309, 0, 0, 0, 257016, 1, 32, 'Find Commander Folkar'),
(7, 475476, 96265, 1, 0, 0, 277154, 1, 40, '');
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.`ID` = p.`ID`) OR EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'quest_objectives' AND r.`k1` = p.`ID`);
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE (p.`Type` IN (0, 3) AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = p.`ObjectID`)) OR (p.`Type` = 2 AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = p.`ObjectID`));
UPDATE `everlake_build_quests` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `quest_template` t WHERE t.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` IN ('quest_template', 'quest_classic_level', 'quest_template_classic_level', 'quest_classic_money', 'quest_template_addon') AND r.`k1` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_objectives` c WHERE c.`QuestID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_money` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_build_objectives` p WHERE p.`QuestID` = s.`ID` AND p.`taken` = 1);
INSERT INTO `quest_template` (`ID`, `RewardItem1`, `RewardAmount1`, `ItemDrop1`, `ItemDropQuantity1`, `RewardItem2`, `RewardAmount2`, `ItemDrop2`, `ItemDropQuantity2`, `RewardItem3`, `RewardAmount3`, `ItemDrop3`, `ItemDropQuantity3`, `RewardItem4`, `RewardAmount4`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `QuestType`, `QuestInfoID`, `RewardNextQuest`, `StartItem`, `Flags`, `FlagsEx`, `FlagsEx2`, `TimeAllowed`, `QuestSortID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardSpell`, `AllowableRaces`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`) SELECT s.`ID`, s.`RewardItem1`, s.`RewardAmount1`, s.`ItemDrop1`, s.`ItemDropQuantity1`, s.`RewardItem2`, s.`RewardAmount2`, s.`ItemDrop2`, s.`ItemDropQuantity2`, s.`RewardItem3`, s.`RewardAmount3`, s.`ItemDrop3`, s.`ItemDropQuantity3`, s.`RewardItem4`, s.`RewardAmount4`, s.`ItemDrop4`, s.`ItemDropQuantity4`, s.`RewardChoiceItemID1`, s.`RewardChoiceItemQuantity1`, s.`RewardChoiceItemID2`, s.`RewardChoiceItemQuantity2`, s.`RewardChoiceItemID3`, s.`RewardChoiceItemQuantity3`, s.`RewardChoiceItemID4`, s.`RewardChoiceItemQuantity4`, s.`RewardChoiceItemID5`, s.`RewardChoiceItemQuantity5`, s.`RewardChoiceItemID6`, s.`RewardChoiceItemQuantity6`, s.`RewardFactionID1`, s.`RewardFactionValue1`, s.`RewardFactionOverride1`, s.`RewardFactionCapIn1`, s.`RewardFactionID2`, s.`RewardFactionValue2`, s.`RewardFactionOverride2`, s.`RewardFactionCapIn2`, s.`RewardFactionID3`, s.`RewardFactionValue3`, s.`RewardFactionOverride3`, s.`RewardFactionCapIn3`, s.`RewardFactionID4`, s.`RewardFactionValue4`, s.`RewardFactionOverride4`, s.`RewardFactionCapIn4`, s.`RewardFactionID5`, s.`RewardFactionValue5`, s.`RewardFactionOverride5`, s.`RewardFactionCapIn5`, s.`RewardCurrencyID1`, s.`RewardCurrencyQty1`, s.`RewardCurrencyID2`, s.`RewardCurrencyQty2`, s.`RewardCurrencyID3`, s.`RewardCurrencyQty3`, s.`RewardCurrencyID4`, s.`RewardCurrencyQty4`, s.`QuestType`, s.`QuestInfoID`, s.`RewardNextQuest`, s.`StartItem`, s.`Flags`, s.`FlagsEx`, s.`FlagsEx2`, s.`TimeAllowed`, s.`QuestSortID`, s.`RewardXPDifficulty`, s.`RewardXPMultiplier`, s.`RewardSpell`, s.`AllowableRaces`, s.`AcceptedSoundKitID`, s.`CompleteSoundKitID`, s.`Expansion`, s.`LogTitle`, s.`LogDescription`, s.`QuestDescription`, s.`AreaDescription`, s.`QuestCompletionLog`, 0 FROM `everlake_build_quests` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', s.`ID`, '2026_11_20_28_world_everlake_quests_tome_folkar_thera.sql', s.`note` FROM `everlake_build_quests` s WHERE s.`missing` = 1;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`) SELECT p.`ID`, p.`QuestID`, p.`Type`, p.`Order`, p.`StorageIndex`, p.`ObjectID`, p.`Amount`, p.`Flags`, p.`Description`, 0 FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', p.`ID`, '2026_11_20_28_world_everlake_quests_tome_folkar_thera.sql', s.`note` FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_objectives`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `QuestLevel`, `MinLevel`, `MaxLevel` FROM `quest_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) VALUES
(1, 91497, 53, 44, 0),
(2, 91500, 55, 44, 0),
(3, 91538, 55, 44, 0),
(4, 95309, 53, 48, 0),
(5, 96265, 60, 60, 0);
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT p.`ID`, p.`QuestLevel`, p.`MinLevel`, p.`MaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_level', p.`ID`, '2026_11_20_28_world_everlake_quests_tome_folkar_thera.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `LevelType`, `QuestLevel` FROM `quest_template_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `LevelType`, `QuestLevel`) VALUES
(1, 91497, 2, 53),
(2, 91500, 2, 55),
(3, 91538, 2, 55),
(4, 95309, 2, 53),
(5, 96265, 2, 60);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT p.`ID`, p.`LevelType`, p.`QuestLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_template_classic_level', p.`ID`, p.`LevelType`, '2026_11_20_28_world_everlake_quests_tome_folkar_thera.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `RewardMoney`, `RewardMoneyMaxLevel` FROM `quest_classic_money` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `RewardMoney`, `RewardMoneyMaxLevel`) VALUES
(1, 91497, 11156, 0),
(2, 91500, 9975, 0),
(3, 95309, 13919, 0),
(4, 96265, 24300, 0);
INSERT INTO `quest_classic_money` (`ID`, `RewardMoney`, `RewardMoneyMaxLevel`) SELECT p.`ID`, p.`RewardMoney`, p.`RewardMoneyMaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_money', p.`ID`, '2026_11_20_28_world_everlake_quests_tome_folkar_thera.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
DROP TEMPORARY TABLE `everlake_build_quests`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 247449, 91497, 'seen-live: icyveins:addon'),
(2, 247449, 91500, 'seen-live: icyveins:addon'),
(3, 247449, 91538, 'seen-live: icyveins:addon'),
(4, 260383, 95309, 'seen-live: icyveins:addon');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', s.`id`, s.`quest`, '2026_11_20_28_world_everlake_quests_tome_folkar_thera.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 247449, 91497, 'seen-live: icyveins:addon'),
(2, 8576, 91500, 'seen-live: icyveins:addon'),
(3, 8587, 91538, 'seen-live: icyveins:addon'),
(4, 260386, 95309, 'INFERRED: the quest text names Commander Folkar'),
(5, 268606, 96265, 'INFERRED: the quest text names Thera Duskwhisper');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_questender' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', s.`id`, s.`quest`, '2026_11_20_28_world_everlake_quests_tome_folkar_thera.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 91497, '<Studying each seal, you see they do indeed match those in the tome. As you feel the power of the crystals thrumming in response to their presence, a reckless idea enters your mind.>'),
(2, 91500, 'Incredible!$B$BYou''ve done it! Belgrom will be pleased! Finally the spirits of dozens of our warriors can be at peace. Thank you, $N.'),
(3, 91538, 'Well now, perhaps Belgrom''s petty quest for riches and revenge hasn''t all been for naught...'),
(4, 95309, 'So Ulka survived and sent you in here after me? You found her surrounded by bodies? Ulka is a credit to the Kor''kron and I will see to it that she gets a field promotion when we are done here.$B$BWe can''t leave yet though. Our mission is not yet complete.');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_offer_reward` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, '2026_11_20_28_world_everlake_quests_tome_folkar_thera.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 91497, '<The tome lies open before you, detailing Rimtori''s spell.>'),
(2, 91500, 'How goes your slaughter of the blood elf traitors, $N? Have you made any progress?$B$BRimtori deserves nothing but a painful death for all that she has done!'),
(3, 91538, 'What do you have there, $C?'),
(4, 95309, 'Wh...what? Ulka is alive?');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_request_items` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, '2026_11_20_28_world_everlake_quests_tome_folkar_thera.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
COMMIT;
