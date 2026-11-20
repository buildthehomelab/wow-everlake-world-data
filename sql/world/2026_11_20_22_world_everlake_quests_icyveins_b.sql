-- World build: 13 missing quests from the Icy Veins WoW Forever database
-- 2026_11_20_22_world_everlake_quests_icyveins_b.sql: quest records (title, texts, objectives, rewards, levels, givers and enders) from the Icy Veins catalogue
-- (https://db.icy-veins.com/wow-forever/), which players' addons recorded on live WoW Forever, written in the shape of the
-- tracker's build files. Only quests whose giver (or starting item), ender and objective targets the server already has.
-- Written against (not a replay): the world import up to 2026_11_20_10 and the PTR world as the tracker read it on 2026-11-20.
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
(1, 86777, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 259892, 1, 260166, 1, 260167, 1, 0, 0, 0, 0, 0, 0, 576, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700168, 0, 0, 0, 16, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Master Feardred', 'Kill Master Feardred, and bring his amulet to Korsa.', 'Many satyr corrupt Azshara, but none are as terrible as the Legashi. Led by Varrox Bleakhoof, their camps litter the northern peninsula. They have driven us from our homes, and I fear they will ransack Ursolan before long.\r\n\r\nWe must strike back if we are to have any chance of survival.\r\n\r\nMaster Feardred, a servant of Varrox, oversees a nearby camp to the south. You can see it from here. Feardred is a key target in weakening Varrox''s forces. Kill him, and bring me his amulet.', '', '', 'seen-live: icyveins:catalog'), -- Master Feardred
(2, 88884, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700168, 0, 0, 0, 16, 5, 1.0, 0, 6130900294268440000, 890, 878, -2, 'Highborne Tablets', 'Find the three highborne tablets among the ruins of Southridge Beach, then bring them to Saria Fairmoon in Azshara.', 'Just south of here, along the beach, there are some tablets of highborne writing. They document the highborne''s investigations into the laws and powers of the arcane. \r\n\r\nThe tablets are being kept in pagoda-like structures, guarded by naga, so I wouldn''t dare attempt to procure them myself.\r\n\r\nFortunately, I''ve found myself a new assistant! \r\n\r\nSo, what do you say? Think you could be of further use in the pursuit of knowledge?', '', '', 'seen-live: icyveins:catalog'), -- Highborne Tablets
(3, 88917, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700168, 0, 0, 0, 16, 5, 1.0, 0, 6130900294268440000, 890, 878, -2, 'Slithering Looters', 'Find the Staff of Archmage Selwyn among the Ruins of Eldarath, and bring it to Saria Fairmoon in Azshara.', 'I came here in search of highborne artifacts. You could call me an archaeologist of sorts.\r\n\r\nThe ruins of Eldarath to the west hold many of them, although the naga are looting the ruins as we speak.\r\n\r\nA naga called Lady Sesspira leads the pillaging; no doubt keeping the best finds for herself. \r\n\r\nIf my research is correct, I believe she may be in possession of the staff of Archmage Selwyn, a fallen highborne mage.\r\n\r\nI need your help to get that staff, $r. Scholars like me are ill-suited for combat.', '', '', 'seen-live: icyveins:catalog'), -- Slithering Looters
(4, 89038, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700168, 0, 0, 0, 16, 5, 1.0, 0, 6130900294268440000, 890, 878, -2, 'A Monumental Task', 'Search for the Mark of the Queen among the ruins of the Ravencrest Monument, and bring it to Saria Fairmoon in Azshara.', 'It is said that Queen Azshara once bestowed a gift upon the kaldorei of House Ravencrest; an emblem of great beauty and magical power. This mark was given as recognition of the Ravencrests'' unwavering loyalty to the queen. \r\n\r\nThe mark was last seen near the Ravencrest Monument, atop the cliffs of the southern peninsula. Securing such a relic would be the discovery of a lifetime.\r\n\r\nAs always, the ruins of the monument are crawling with Spitelash, but I trust you''re rather adept at handling them by now.', '', '', 'seen-live: icyveins:catalog'), -- A Monumental Task
(5, 92066, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 279891, 1, 279892, 1, 0, 0, 0, 0, 0, 0, 0, 0, 576, 0, 15000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 36700424, 0, 0, 0, 16554, 5, 2.0, 0, 18446744073709551615, 890, 878, -2, 'The Twin Bears', 'Find the Totem of Ursoc and the Totem of Ursol inside Blackmaw Hold. Then, return them to Lorekeeper Nok at Ursolan.', 'When the Legashi invaded, many precious things were left behind in the commotion. Of particular value to me are two totems. They depict legends of our twin gods, Ursoc and Ursol.\r\n\r\nI know our immediate survival is of greatest concern, but we must also think of saving our people''s history.\r\n\r\nThose totems are likely still in our former hold. If they are, you would be doing a great kindness by returning them to me.', '', '', 'seen-live: icyveins:catalog'), -- The Twin Bears
(6, 95198, 0, 0, 269000, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 269000, 0, 0, 0, 0, 15, 2, 1.0, 1285371, 6130900294268440000, 890, 878, -2, 'The Return of the King?', 'Use the SI:7 Disguise Kit to eavesdrop on Jaina and her inner circle at the Theramore Mage Tower.', 'Take this. It''s a handy bit o'' glamour that the mages back home put together to make a quick disguise. It''ll make you look like a Kul Tiras Marine which should do nicely for this mission.\r\n\r\nSneak in to the tower and do yer best to listen for any mention of the man that washed up on the beach. I warn you though, do not get too close to Jaina. She will see right through this disguise. \r\n\r\nCome back and see me if you lose your disguise, I''ll set you up with a new one.', '', '', 'seen-live: icyveins:catalog'), -- The Return of the King?
(7, 95273, 0, 0, 274373, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275390, 1, 275434, 1, 0, 0, 0, 0, 0, 0, 0, 0, 2747, 0, 35000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 274373, 0, 0, 0, 0, 616, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Water of Hyjal', 'Empty the Barkskin Purification Tonic provided by Fennar Mossmane in the water at the bottom of Deadwood Den.', 'Now that we know Deadwood don''t foul the water outright with their presence, we can take this sample and cast our wards with sound will. We''ve heard there is a pool of the mountain''s tears within their den.\r\n\r\nTravel with force and pour this water into the pool deep in Deadwood Den. \r\n\r\nReturn to us when you have learned what secrets the dark depths hold.', '', '', 'seen-live: icyveins:catalog'), -- Water of Hyjal
(8, 98231, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 369, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 33554440, 0, 0, 0, 15, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Active Ingredient', 'Bring 10 Wyrmtail to Gizzix Grimegurgle.', 'Miss Melly got burned pretty bad by those whelps. I think they scared her. I haven''t been able to convince her to move!\r\n\r\nListen, I have an idea.\r\n\r\nI once bought this snake oil potion that obviously didn''t work as intended but it DID heal a cut I had. One of the active ingredients was supposedly an herb called Wyrmtail that''s found around these parts.\r\n\r\nIf my hunch is correct that might help Miss Melly''s burns. Go see if you can find some and bring it back! Anything is worth a try.', '', '', 'seen-live: icyveins:catalog'), -- Active Ingredient
(9, 99187, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 286408, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, -141, 6, 1.75, 0, 12261800583900083616, 890, 878, -2, 'The Reliquary of Tyr', 'Travel to Blackmaw Hold in Kalimdor, and recover the Reliquary of Tyr.', 'You may not be a Knight of Lordaeron--though perhaps you are, in a way. However, a Paladin you remain... and you know the power of an oath.\r\n\r\nThe Blackmaw are powerful totemics, and they would recognize the power of such an artifact as the Reliquary. Undoubtedly, they still possess it.\r\n\r\nThusly I''d ask this of you now--finish the quest I started. Return the Reliquary of Tyr here to Tirisfal Glades where it belongs. Only then will my oath be discharged, and my spirit may move on from this world.', '', '', 'seen-live: icyveins:catalog'), -- The Reliquary of Tyr
(10, 79678, 213105, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 45, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Taste Testing', 'Taste test the recipe with Skonk.', 'Ok $r buddy, it time for Skonk favorite part. Skonk have fire hot and ready, and want to share new dish with new friend. You do such big favors for Skonk; it only right you get some too!\r\n\r\nLet Skonk know when you ready for tasting.', '', '', 'seen-live: icyveins:catalog'), -- Taste Testing
(11, 81944, 220169, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 65536, 0, 0, 0, -141, 6, 1.0, 0, 6130900294268440000, 890, 878, -2, 'A Newly Discovered Purpose...', '', '', '', '', 'seen-live: icyveins:catalog'), -- A Newly Discovered Purpose...
(12, 96321, 0, 0, 273845, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 273845, 36700160, 0, 0, 0, 616, 1, 1.0, 0, 18446744073709551615, 890, 878, -2, 'The Dying God', 'Find someone on Mount Hyjal who may be interested in the Faintly Glowing Staff.', 'I... don''t have much time, mortal. You must take this staff, a branch of the world tree... corrupted... wrong. I carried it here...\r\n\r\nThe Wild Gods... they must know. Take it to her. The... crow...\r\n\r\n<The dying Wild God grows still and his eyes stare blankly ahead. What little is left of his corporeal form seems to break apart and drift away. There is a faintly glowing branch on the ground, with a sickly green crystal affixed to its head.>', '', '', 'seen-live: icyveins:catalog'), -- The Dying God
(13, 92867, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 280505, 1, 278567, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 264, 0, 0, 0, 45, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Ground to Keep', 'Defeat the Boulderfist, Syndicate, and Witherbark intruders in Stromgarde Keep and return to Groundskeeper Lomar.', 'Our heritage may be crumbling, but this is not our final redoubt. We have more in reserve, and it must remain hidden for its own protection.\r\n\r\nSupport grows for preserving our remaining sculptures and sacred burial grounds. The rabble that have taken up residence in our old kingdom have no notion of the vengeance coming for them.\r\n\r\nDrive back the Boulderfist and Syndicate. They must learn Stromgarde is not merely fist, eagle, and stones.', '', '', 'seen-live: icyveins:catalog'); -- Ground to Keep
CREATE TEMPORARY TABLE `everlake_build_objectives` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY, `taken` TINYINT NOT NULL DEFAULT 0) SELECT `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description` FROM `quest_objectives` WHERE 0;
INSERT INTO `everlake_build_objectives` (`n`, `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`) VALUES
(1, 457386, 86777, 1, 0, 0, 235334, 1, 32, ''),
(2, 459187, 88884, 1, 0, 0, 238244, 1, 32, ''),
(3, 459188, 88884, 1, 1, 3, 238245, 1, 32, ''),
(4, 459189, 88884, 1, 2, 4, 238246, 1, 32, ''),
(5, 459261, 88917, 1, 0, 1, 238347, 1, 32, ''),
(6, 459552, 89038, 1, 0, 0, 238517, 1, 32, ''),
(7, 464116, 92066, 1, 0, 0, 249694, 1, 32, ''),
(8, 464117, 92066, 1, 1, 1, 249693, 1, 32, ''),
(9, 470485, 95198, 0, 0, 0, 260146, 1, 32, 'Relieve Jaina''s guard and eavesdrop'),
(10, 470486, 95198, 1, 1, 1, 269000, 1, 32, ''),
(11, 470217, 95273, 0, 0, 2, 265026, 1, 32, 'Secrets of the depths discovered'),
(12, 473683, 95273, 1, 1, 0, 274373, 1, 32, ''),
(13, 477082, 98231, 1, 0, 0, 280092, 10, 32, ''),
(14, 479557, 99187, 1, 0, 1, 286415, 1, 32, ''),
(15, 480570, 96321, 1, 0, 0, 273845, 1, 32, ''),
(16, 476306, 92867, 0, 0, 0, 2569, 5, 32, ''),
(17, 476307, 92867, 0, 1, 1, 2590, 3, 32, ''),
(18, 476308, 92867, 0, 2, 2, 2588, 6, 32, ''),
(19, 476309, 92867, 0, 3, 3, 2558, 3, 32, '');
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.`ID` = p.`ID`) OR EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'quest_objectives' AND r.`k1` = p.`ID`);
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE (p.`Type` IN (0, 3) AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = p.`ObjectID`)) OR (p.`Type` = 2 AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = p.`ObjectID`));
UPDATE `everlake_build_quests` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `quest_template` t WHERE t.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` IN ('quest_template', 'quest_classic_level', 'quest_template_classic_level', 'quest_classic_money', 'quest_template_addon') AND r.`k1` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_objectives` c WHERE c.`QuestID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_money` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_build_objectives` p WHERE p.`QuestID` = s.`ID` AND p.`taken` = 1);
INSERT INTO `quest_template` (`ID`, `RewardItem1`, `RewardAmount1`, `ItemDrop1`, `ItemDropQuantity1`, `RewardItem2`, `RewardAmount2`, `ItemDrop2`, `ItemDropQuantity2`, `RewardItem3`, `RewardAmount3`, `ItemDrop3`, `ItemDropQuantity3`, `RewardItem4`, `RewardAmount4`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `QuestType`, `QuestInfoID`, `RewardNextQuest`, `StartItem`, `Flags`, `FlagsEx`, `FlagsEx2`, `TimeAllowed`, `QuestSortID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardSpell`, `AllowableRaces`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`) SELECT s.`ID`, s.`RewardItem1`, s.`RewardAmount1`, s.`ItemDrop1`, s.`ItemDropQuantity1`, s.`RewardItem2`, s.`RewardAmount2`, s.`ItemDrop2`, s.`ItemDropQuantity2`, s.`RewardItem3`, s.`RewardAmount3`, s.`ItemDrop3`, s.`ItemDropQuantity3`, s.`RewardItem4`, s.`RewardAmount4`, s.`ItemDrop4`, s.`ItemDropQuantity4`, s.`RewardChoiceItemID1`, s.`RewardChoiceItemQuantity1`, s.`RewardChoiceItemID2`, s.`RewardChoiceItemQuantity2`, s.`RewardChoiceItemID3`, s.`RewardChoiceItemQuantity3`, s.`RewardChoiceItemID4`, s.`RewardChoiceItemQuantity4`, s.`RewardChoiceItemID5`, s.`RewardChoiceItemQuantity5`, s.`RewardChoiceItemID6`, s.`RewardChoiceItemQuantity6`, s.`RewardFactionID1`, s.`RewardFactionValue1`, s.`RewardFactionOverride1`, s.`RewardFactionCapIn1`, s.`RewardFactionID2`, s.`RewardFactionValue2`, s.`RewardFactionOverride2`, s.`RewardFactionCapIn2`, s.`RewardFactionID3`, s.`RewardFactionValue3`, s.`RewardFactionOverride3`, s.`RewardFactionCapIn3`, s.`RewardFactionID4`, s.`RewardFactionValue4`, s.`RewardFactionOverride4`, s.`RewardFactionCapIn4`, s.`RewardFactionID5`, s.`RewardFactionValue5`, s.`RewardFactionOverride5`, s.`RewardFactionCapIn5`, s.`RewardCurrencyID1`, s.`RewardCurrencyQty1`, s.`RewardCurrencyID2`, s.`RewardCurrencyQty2`, s.`RewardCurrencyID3`, s.`RewardCurrencyQty3`, s.`RewardCurrencyID4`, s.`RewardCurrencyQty4`, s.`QuestType`, s.`QuestInfoID`, s.`RewardNextQuest`, s.`StartItem`, s.`Flags`, s.`FlagsEx`, s.`FlagsEx2`, s.`TimeAllowed`, s.`QuestSortID`, s.`RewardXPDifficulty`, s.`RewardXPMultiplier`, s.`RewardSpell`, s.`AllowableRaces`, s.`AcceptedSoundKitID`, s.`CompleteSoundKitID`, s.`Expansion`, s.`LogTitle`, s.`LogDescription`, s.`QuestDescription`, s.`AreaDescription`, s.`QuestCompletionLog`, 0 FROM `everlake_build_quests` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', s.`ID`, '2026_11_20_22_world_everlake_quests_icyveins_b.sql', s.`note` FROM `everlake_build_quests` s WHERE s.`missing` = 1;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`) SELECT p.`ID`, p.`QuestID`, p.`Type`, p.`Order`, p.`StorageIndex`, p.`ObjectID`, p.`Amount`, p.`Flags`, p.`Description`, 0 FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', p.`ID`, '2026_11_20_22_world_everlake_quests_icyveins_b.sql', s.`note` FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_objectives`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `QuestLevel`, `MinLevel`, `MaxLevel` FROM `quest_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) VALUES
(1, 86777, 53, 47, 0),
(2, 88884, 52, 47, 0),
(3, 88917, 52, 47, 0),
(4, 89038, 55, 47, 0),
(5, 92066, 55, 47, 0),
(6, 95198, 53, 48, 0),
(7, 95273, 59, 54, 0),
(8, 98231, 44, 39, 0),
(9, 99187, 58, 50, 0),
(10, 79678, 40, 26, 0),
(11, 81944, 53, 45, 0),
(12, 96321, 58, 54, 0),
(13, 92867, 39, 32, 0);
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT p.`ID`, p.`QuestLevel`, p.`MinLevel`, p.`MaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_level', p.`ID`, '2026_11_20_22_world_everlake_quests_icyveins_b.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `LevelType`, `QuestLevel` FROM `quest_template_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `LevelType`, `QuestLevel`) VALUES
(1, 86777, 2, 53),
(2, 88884, 2, 52),
(3, 88917, 2, 52),
(4, 89038, 2, 55),
(5, 92066, 2, 55),
(6, 95198, 2, 53),
(7, 95273, 2, 59),
(8, 98231, 2, 44),
(9, 99187, 2, 58),
(10, 79678, 2, 40),
(11, 81944, 2, 53),
(12, 96321, 2, 58),
(13, 92867, 2, 39);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT p.`ID`, p.`LevelType`, p.`QuestLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_template_classic_level', p.`ID`, p.`LevelType`, '2026_11_20_22_world_everlake_quests_icyveins_b.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `RewardMoney`, `RewardMoneyMaxLevel` FROM `quest_classic_money` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `RewardMoney`, `RewardMoneyMaxLevel`) VALUES
(1, 88884, 10200, 0),
(2, 88917, 10200, 0),
(3, 89038, 15002, 0),
(4, 98231, 6500, 0),
(5, 79678, 5000, 0),
(6, 92867, 4500, 0);
INSERT INTO `quest_classic_money` (`ID`, `RewardMoney`, `RewardMoneyMaxLevel`) SELECT p.`ID`, p.`RewardMoney`, p.`RewardMoneyMaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_money', p.`ID`, '2026_11_20_22_world_everlake_quests_icyveins_b.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
DROP TEMPORARY TABLE `everlake_build_quests`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 236770, 86777, 'seen-live: icyveins:addon'),
(2, 239831, 88884, 'seen-live: icyveins:addon'),
(3, 239831, 88917, 'seen-live: icyveins:addon'),
(4, 239831, 89038, 'seen-live: icyveins:addon'),
(5, 249853, 92066, 'seen-live: icyveins:addon'),
(6, 260271, 95198, 'seen-live: icyveins:addon'),
(7, 256626, 95273, 'seen-live: icyveins:addon'),
(8, 270727, 98231, 'seen-live: icyveins:addon'),
(9, 276110, 99187, 'seen-live: icyveins:addon'),
(10, 217300, 79678, 'seen-live: icyveins:addon'),
(11, 214529, 81944, 'seen-live: icyveins:addon'),
(12, 278305, 96321, 'seen-live: icyveins:addon'),
(13, 219, 92867, 'seen-live: icyveins:addon');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', s.`id`, s.`quest`, '2026_11_20_22_world_everlake_quests_icyveins_b.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 236770, 86777, 'seen-live: icyveins:addon'),
(2, 239831, 88884, 'seen-live: icyveins:addon'),
(3, 239831, 88917, 'seen-live: icyveins:addon'),
(4, 239831, 89038, 'seen-live: icyveins:addon'),
(5, 249853, 92066, 'seen-live: icyveins:addon'),
(6, 260271, 95198, 'seen-live: icyveins:addon'),
(7, 256626, 95273, 'seen-live: icyveins:addon'),
(8, 270727, 98231, 'seen-live: icyveins:addon'),
(9, 276110, 99187, 'seen-live: icyveins:addon'),
(10, 217300, 79678, 'seen-live: icyveins:addon'),
(11, 214529, 81944, 'seen-live: icyveins:addon'),
(12, 257753, 96321, 'seen-live: icyveins:addon'),
(13, 219, 92867, 'seen-live: icyveins:addon');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_questender' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', s.`id`, s.`quest`, '2026_11_20_22_world_everlake_quests_icyveins_b.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 86777, 'Well done! With one of their key commanders slain, we''ve struck a decisive blow against the Legashi.$B$BBe well, $N, and keep up the fight.'),
(2, 88884, 'Nicely done, $R. These writings will provide me plenty of material to pore over.$B$BStill, there are always more discoveries to be made, and you seem to be quite the eager helper.'),
(3, 88917, 'The staff, and in pristine condition! Excellent! $B$BI find this little "mind and muscle" partnership of ours quite agreeable, $C.  Perhaps you would assist me further?'),
(4, 89038, 'The mark of Queen Azshara herself...I can hardly believe it! You''ve done well.$B$BThis concludes my need for an assistant, but I do have one last thing for you.'),
(5, 92066, 'Spirits be praised! The totems are unbroken. Although the Blackmaw have lost much, our stories will live on. Thank you, $R.'),
(6, 95198, 'So it seems the human they found isn''t our man. But a prison on Alcaz... with the Defias involved? I agree with Jaina, that is no coincidence. $B$BIf there''s a chance what you heard is true and that he was being held with the king, we''ve got to get in there and get him out as soon as we can. Lady Proudmoore can sit around thinkin'' about it if she wants, but my orders are to take whatever action is needed to return the king to Stormwind, and that''s just what we are going to do!$B$BAre you with me, $N?'),
(7, 95273, '<Fennar hesitantly sniffs the waterskin.>$B$BThis water is off, as was our fear.$B$BThank you for what you bring to us, and for giving us the chance to learn from it.'),
(8, 98231, 'Hey, you found it!$B$BWow, I can smell the wyrmtail from here! That herby smell sure is strong. It''s kinda refreshing, though. Sorta minty, ya know?$B$BMaybe that''s promising!$B$BI''ll see if I can apply some of this to a small area on Miss Melly''s tail. Hopefully it will soothe the burn at least a bit, if nothing else.$B$BWith any luck it will at least calm her down enough to convince her to move again so we can begin construction on the outpost.'),
(9, 99187, 'It is done. I can feel the chains that bind me to this existence loosening already. While I am now at peace, I feel that there may yet be a purpose for me to linger here... at least for a time.$B$BYou have my gratitude, $N. In life I may have named you as my enemy, but in death, I name you "brother."'),
(10, 79678, 'Mmm, recipe is delicious!$B$BSkonk get a bit lost in passion of moment, but you were good helper! $B$BHere, this your share. Skonk even add little something extra for your trouble.'),
(11, 81944, 'I... cannot explain this, human,  but I think I have something you need. I came to this land to seek knowledge, and that search led me up the mountain over yonder to a giant stone of light, fallen from the sky. In my contemplation at the stone, An''she gifted me with a great many things. One was a sense of new purpose. Another of which was a vision of you and me, here, having this conversation. I think I gave you this.$B$BPlease, take this totem. Use it well in service of An''she... in service of the light.'),
(12, 96321, '<The crow hops back as you reveal the staff you found and show it to her.> $B $BBy the wilds, what is that! Where did you find such a thing? It feels all kinds of wrong. $B$B<The crow fall silent as you recount your tale.> $B$BWait, an owl? Velician? It couldn''t be. She is demigod. She cannot just die. It takes tremendous power to even hurt a Wild God.$B$BThere is more to this tale. Dirtwalker, this is grave indeed. Thankfully I know just the oldstone to help.'),
(13, 92867, 'This is a worthy start. Their blood can feed the war-wracked soil while we wait for our next moves. Time will recover what it has lost.$B$BTake these remnants of Stromgarde. You have earned more than mere words of recognition.');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_offer_reward` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, '2026_11_20_22_world_everlake_quests_icyveins_b.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 86777, 'Is Feardred slain, $C?'),
(2, 88884, 'The finer points of the highborne''s writings may be lost on you, but I can provide a translation once you bring me the tablets.'),
(3, 88917, 'Sesspira, that covetous wretch; does she even know what priceless relics she hoards?'),
(4, 89038, 'Any luck finding the mark?'),
(5, 92066, 'I understand why we had to leave the totems. I just hope the satyr haven''t defaced them.'),
(6, 95198, 'Well?'),
(7, 95273, 'The Deadwood will be thick in their den--do not travel alone!'),
(8, 98231, 'I still can''t believe I was bamboozled by that stupid salesman!$B$BHow was I supposed to know wyrmtail, golden clovers, and rabbit''s feet crammed into a potion and waved over a horseshoe WOULDN''T make a potion of luck?$B$BIt sounds feasible!'),
(9, 99187, 'I thank you for your aid, hero.'),
(10, 96321, 'What have you brought me, dirtwalker?'),
(11, 92867, 'The impudent savages think living amongst the destroyed structures they themselves cannot even maintain makes them superior.');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_request_items` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, '2026_11_20_22_world_everlake_quests_icyveins_b.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
COMMIT;
