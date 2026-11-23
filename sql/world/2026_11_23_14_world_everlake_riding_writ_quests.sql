-- 14 missing quests: riding quests (Swift as the Wind, An Epic Ride, Your First Horse) and 4 Craftsman's Writs.
-- 2026_11_23_14_world_everlake_riding_writ_quests.sql: quest records (title, texts, objectives, rewards, levels, givers and enders)
-- from the Icy Veins catalogue (https://db.icy-veins.com/wow-forever/), which players' addons recorded on live WoW Forever.
-- Writ enders: Icy Veins, and QuestieDB Forever traces for 94351. The other writs' enders are recorded in no source and stay out.
-- Riding quests with no recorded giver or ender get the trainer/vendor their sibling quests (99201-99218, 96982-98166) use;
-- those rows say 'inferred' in everlake_import_rows. Written against the PTR world as the tracker read it on 2026-11-23.
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
(1, 94321, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2586, 0, 20000, 7, 2587, 0, 20000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 3149824, 33281, 268435456, 0, 16941, 0, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Craftsman''s Writ: Flask of Chromatic Resistance', 'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.', '\n\n<Penned in faded ink, the note is requesting 1 Flask of Chromatic Resistance, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>', '', '', 'seen-live: icyveins:catalog'), -- Craftsman's Writ: Flask of Chromatic Resistance
(2, 94337, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2586, 0, 20000, 7, 2587, 0, 20000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 3149824, 33281, 268435456, 0, 16941, 0, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Craftsman''s Writ: Gnomish Alarm-O-Bot', 'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.', '<Penned in faded ink, the note is requesting 1 Gnomish Alarm-O-Bot, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>', '', '', 'seen-live: icyveins:catalog'), -- Craftsman's Writ: Gnomish Alarm-O-Bot
(3, 94338, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2586, 0, 20000, 7, 2587, 0, 20000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 3149824, 33281, 268435456, 0, 16941, 0, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Craftsman''s Writ: Goblin Jumper Cables XL', 'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.', '<Penned in faded ink, the note is requesting 1 Goblin Jumper Cables XL, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>', '', '', 'seen-live: icyveins:catalog'), -- Craftsman's Writ: Goblin Jumper Cables XL
(4, 94351, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2586, 0, 20000, 7, 2587, 0, 20000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 3149824, 33281, 268435456, 0, 16941, 0, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Craftsman''s Writ: Frostsaber Boots', 'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.', '<Penned in faded ink, the note is requesting 1 Frostsaber Boots, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>', '', '', 'seen-live: icyveins:catalog'), -- Craftsman's Writ: Frostsaber Boots
(5, 99203, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1048576, 0, 0, 0, 16593, 0, 1.0, 0, 12884901888, 890, 878, -2, 'Swift as the Wind', 'Learn the Journeyman Riding skill from Genn Fairweather.', 'Ah, you''ve returned. Very good. Are you ready to learn to ride an armored galestrider?\r\n\r\nAs before, if you take the next step in your training with me, I will provide you with a free mount, and after you will be able to purchase any additional mounts you would like. \r\n\r\nIt won''t be cheap, but speak to me when you have enough coin. I will teach you about riding armored galestriders.', '', '', 'seen-live: icyveins:catalog'), -- Swift as the Wind
(6, 99206, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72, 0, 2500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1048576, 0, 0, 0, 12, 0, 1.0, 0, 1, 890, 878, -2, 'Swift as the Wind', 'Learn the Journeyman Riding skill from Randal Hunter.', 'I''m glad you made your way back to me. I can tell by the scratches on your skin and the dirt on your armor that you''ve seen much of the world. It''s time we got you a proper steed.\r\n\r\nKatie will provide you with a free mount once ye have completed the final leg of your training with me, and after you will be able to purchase any additional mounts you would like just as before.\r\n\r\nSpeak to me when you have enough coin, and I will teach you all I know about riding armored horses.', '', '', 'seen-live: icyveins:catalog'), -- Swift as the Wind
(7, 99207, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 54, 0, 2500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1048576, 0, 0, 0, 1, 0, 1.0, 0, 64, 890, 878, -2, 'Swift as the Wind', 'Learn the Journeyman Riding skill from Binjy Featherwhistle.', 'I can tell that you''ve come far enough to handle one of our top of the line, most powerful swift mechanostriders.\r\n\r\nMilli will provide you with a free mount once you have completed your final round of training with me, and after you will be able to purchase any additional mounts you would like just as before.\r\n\r\nThis won''t be cheap, but speak to me when you have enough gold. I will teach you about riding our supercharged mechanostriders!', '', '', 'seen-live: icyveins:catalog'), -- Swift as the Wind
(8, 99209, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 47, 0, 2500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1048576, 0, 0, 0, 1, 0, 1.0, 0, 4, 890, 878, -2, 'Swift as the Wind', 'Learn the Journeyman Riding skill from Ultham Ironhorn.', 'Yer back! Good, good. \r\n\r\nAre ye ready for a proper mountaineer''s mount, $n?\r\n\r\nVeron will set ye up with a free armored ram once ye have finished the final leg of yer training with me, and afterwards you''ll be able to purchase any additional mounts ye would like. \r\n\r\nSpeak ta me when you have enough coin, and I''ll teach ye all I know about riding armored rams.', '', '', 'seen-live: icyveins:catalog'), -- Swift as the Wind
(9, 99212, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18772, 1, 18773, 1, 18774, 1, 0, 0, 0, 0, 0, 0, 54, 0, 2500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1048576, 0, 0, 0, 1, 3, 1.0, 0, 64, 890, 878, -2, 'An Epic Ride', 'Inspect the upgraded riding mechanostriders to choose your epic mount.', 'Salutations! I see today is a big day indeed; today you will synchronize your biometrics to the rider detection protocol of our fastest and fiercest mechanostriders! This protocol will help the strider distinguish you from other possible riders.\r\n\r\nIt clearly seems like you have enough strider experience to handle one of our very best.\r\n\r\nGo examine the upgraded mechanostriders and return to me when you have made your choice.', '', '', 'seen-live: icyveins:catalog'), -- An Epic Ride
(10, 99213, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18776, 1, 18777, 1, 18778, 1, 0, 0, 0, 0, 0, 0, 72, 0, 2500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1048576, 0, 0, 0, 12, 0, 1.0, 0, 1, 890, 878, -2, 'An Epic Ride', 'Inspect the armored riding horses to choose your epic mount.', 'Greetings, $n! I am so glad to see you''ve returned to us.\r\n\r\nIt would seem you have enough experience to ride our fastest and fiercest steeds. You won''t find a more steadfast companion for your journeys.\r\n\r\nChoosing one may be difficult as they are all excellent and trained to be steady even when in danger. Some may even recognize you from the last time you were here.\r\n\r\nGo and examine the armored horses and return to me when you have made your choice.', '', '', 'seen-live: icyveins:catalog'), -- An Epic Ride
(11, 99216, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 269671, 1, 274933, 1, 269678, 1, 0, 0, 0, 0, 0, 0, 2779, 0, 2500, 7, 2778, 0, 2500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1048576, 0, 0, 0, 16593, 5, 1.0, 0, 12884901888, 890, 878, -2, 'An Epic Ride', 'Inspect the armored riding striders to choose your epic mount.', 'Gales greetings, $n! I can''t believe this day has come so soon. Today I am proud to say you have mastered galestrider riding, so I may now offer you our finest, fastest and boldest striders.\r\n\r\nLike before, you and your strider will traverse the world together, so you have an important choice to make. Many of these striders have grown in your time apart, but I would be willing to bet they still recognize you.\r\n\r\nGo examine the armored striders and return to me when you have made your choice.', '', '', 'seen-live: icyveins:catalog'), -- An Epic Ride
(12, 99218, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18788, 1, 18789, 1, 18790, 1, 0, 0, 0, 0, 0, 0, 530, 0, 2500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1048576, 0, 0, 0, 14, 0, 1.0, 0, 128, 890, 878, -2, 'An Epic Ride', 'Inspect the armored riding raptors to choose your epic mount.', 'Ey, $n! Today be a big day for ya, I see. It seems ya be ready to take de reins of our fastest and fiercest raptors. \r\n\r\nNow that you be ridin'' a raptor, you know how intelligent and savage these beasts be. I think you be ready for a real raptor now. An armored raptor.\r\n\r\nSo, you be havin'' an important choice to make. Ya raptor and ya will be traversin'' the world together, and the raptor will also be needin'' to choose ya in return.\r\n\r\nGo an'' take a look and return ta me when ya made ya choice.', '', '', 'seen-live: icyveins:catalog'), -- An Epic Ride
(13, 99326, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5656, 1, 5655, 1, 2414, 1, 0, 0, 0, 0, 0, 0, 72, 0, 2500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1048576, 0, 0, 0, 267, 0, 1.0, 0, 1, 890, 878, -2, 'Your First Horse', 'Inspect the riding horses to choose your first mount.', 'Greetings! Are you here to examine our horses?\r\n\r\nThese steeds are descendants from both the historical Lordaeron stock and our own local horses. You won''t find a more steadfast companion for your journeys.\r\n\r\nChoosing one may be difficult as they are all excellent and trained to be steady even when in danger. Don''t forget, you and your horse will traverse the world together. I''m sure whatever choice you make will suit you best.\r\n\r\nGo examine the horses and return to me when you have made your choice.', '', '', 'seen-live: icyveins:catalog'), -- Your First Horse
(14, 99367, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18776, 1, 18777, 1, 18778, 1, 0, 0, 0, 0, 0, 0, 72, 0, 2500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 1048576, 0, 0, 0, 12, 0, 1.0, 0, 1, 890, 878, -2, 'An Epic Ride', 'Inspect the armored riding horses to choose your epic mount.', 'Greetings, $n! I am so glad to see you''ve returned to us.\r\n\r\nIt would seem you have enough experience to ride our fastest and fiercest steeds. You won''t find a more steadfast companion for your journeys.\r\n\r\nChoosing one may be difficult as they are all excellent and trained to be steady even when in danger. Some may even recognize you from the last time you were here.\r\n\r\nGo and examine the armored horses and return to me when you have made your choice.', '', '', 'seen-live: icyveins:catalog'); -- An Epic Ride
CREATE TEMPORARY TABLE `everlake_build_objectives` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY, `taken` TINYINT NOT NULL DEFAULT 0) SELECT `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description` FROM `quest_objectives` WHERE 0;
INSERT INTO `everlake_build_objectives` (`n`, `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`) VALUES
(1, 468353, 94321, 1, 0, 0, 264121, 1, 32, ''),
(2, 468354, 94321, 1, 1, 1, 13513, 1, 32, ''),
(3, 468385, 94337, 1, 0, 0, 264137, 1, 32, ''),
(4, 468386, 94337, 1, 1, 1, 18645, 1, 32, ''),
(5, 468387, 94338, 1, 0, 0, 264138, 1, 32, ''),
(6, 468388, 94338, 1, 1, 1, 18587, 1, 32, ''),
(7, 468413, 94351, 1, 0, 0, 264151, 1, 32, ''),
(8, 468414, 94351, 1, 1, 1, 15071, 1, 32, ''),
(9, 479618, 99203, 14, 0, 1, 234953, 1, 32, 'Learn: Journeyman Riding'),
(10, 479621, 99206, 14, 0, 1, 234965, 1, 32, 'Learn: Journeyman Riding'),
(11, 479622, 99207, 14, 0, 1, 234969, 1, 32, 'Learn: Journeyman Riding'),
(12, 479624, 99209, 14, 0, 1, 234977, 1, 32, 'Learn: Journeyman Riding'),
(13, 479635, 99212, 3, 0, 4, 276734, 1, 32, 'Swift White Mechanostrider'),
(14, 479636, 99212, 3, 1, 5, 276735, 1, 32, 'Swift Yellow Mechanostrider'),
(15, 479637, 99212, 3, 2, 6, 276736, 1, 32, 'Swift Green Mechanostrider'),
(16, 479638, 99213, 3, 0, 3, 276785, 1, 32, 'Swift Brown Steed'),
(17, 479639, 99213, 3, 1, 4, 276786, 1, 32, 'Swift Palomino'),
(18, 479640, 99213, 3, 2, 5, 276787, 1, 32, 'Swift White Steed'),
(19, 479647, 99216, 3, 0, 0, 265762, 1, 32, 'Swift Empyrean Galestrider'),
(20, 479648, 99216, 3, 1, 1, 265761, 1, 32, 'Swift Stormy Galestrider'),
(21, 479649, 99216, 3, 2, 2, 265760, 1, 32, 'Swift Umber Galestrider'),
(22, 479653, 99218, 3, 0, 0, 276803, 1, 32, 'Swift Blue Raptor'),
(23, 479654, 99218, 3, 1, 1, 276800, 1, 32, 'Swift Olive Raptor'),
(24, 479655, 99218, 3, 2, 2, 276801, 1, 32, 'Swift Orange Raptor'),
(25, 479980, 99326, 3, 0, 0, 276789, 1, 32, 'Pinto Horse'),
(26, 479981, 99326, 3, 1, 1, 276788, 1, 32, 'Brown Horse'),
(27, 479982, 99326, 3, 2, 2, 276790, 1, 32, 'Chestnut Mare'),
(28, 480034, 99367, 3, 0, 0, 276891, 1, 32, 'Swift Brown Steed'),
(29, 480035, 99367, 3, 1, 1, 276893, 1, 32, 'Swift Palomino'),
(30, 480036, 99367, 3, 2, 2, 276892, 1, 32, 'Swift White Steed');
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.`ID` = p.`ID`) OR EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'quest_objectives' AND r.`k1` = p.`ID`);
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE (p.`Type` IN (0, 3) AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = p.`ObjectID`)) OR (p.`Type` = 2 AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = p.`ObjectID`));
UPDATE `everlake_build_quests` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `quest_template` t WHERE t.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` IN ('quest_template', 'quest_classic_level', 'quest_template_classic_level', 'quest_classic_money', 'quest_template_addon') AND r.`k1` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_objectives` c WHERE c.`QuestID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_money` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_build_objectives` p WHERE p.`QuestID` = s.`ID` AND p.`taken` = 1);
INSERT INTO `quest_template` (`ID`, `RewardItem1`, `RewardAmount1`, `ItemDrop1`, `ItemDropQuantity1`, `RewardItem2`, `RewardAmount2`, `ItemDrop2`, `ItemDropQuantity2`, `RewardItem3`, `RewardAmount3`, `ItemDrop3`, `ItemDropQuantity3`, `RewardItem4`, `RewardAmount4`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `QuestType`, `QuestInfoID`, `RewardNextQuest`, `StartItem`, `Flags`, `FlagsEx`, `FlagsEx2`, `TimeAllowed`, `QuestSortID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardSpell`, `AllowableRaces`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`) SELECT s.`ID`, s.`RewardItem1`, s.`RewardAmount1`, s.`ItemDrop1`, s.`ItemDropQuantity1`, s.`RewardItem2`, s.`RewardAmount2`, s.`ItemDrop2`, s.`ItemDropQuantity2`, s.`RewardItem3`, s.`RewardAmount3`, s.`ItemDrop3`, s.`ItemDropQuantity3`, s.`RewardItem4`, s.`RewardAmount4`, s.`ItemDrop4`, s.`ItemDropQuantity4`, s.`RewardChoiceItemID1`, s.`RewardChoiceItemQuantity1`, s.`RewardChoiceItemID2`, s.`RewardChoiceItemQuantity2`, s.`RewardChoiceItemID3`, s.`RewardChoiceItemQuantity3`, s.`RewardChoiceItemID4`, s.`RewardChoiceItemQuantity4`, s.`RewardChoiceItemID5`, s.`RewardChoiceItemQuantity5`, s.`RewardChoiceItemID6`, s.`RewardChoiceItemQuantity6`, s.`RewardFactionID1`, s.`RewardFactionValue1`, s.`RewardFactionOverride1`, s.`RewardFactionCapIn1`, s.`RewardFactionID2`, s.`RewardFactionValue2`, s.`RewardFactionOverride2`, s.`RewardFactionCapIn2`, s.`RewardFactionID3`, s.`RewardFactionValue3`, s.`RewardFactionOverride3`, s.`RewardFactionCapIn3`, s.`RewardFactionID4`, s.`RewardFactionValue4`, s.`RewardFactionOverride4`, s.`RewardFactionCapIn4`, s.`RewardFactionID5`, s.`RewardFactionValue5`, s.`RewardFactionOverride5`, s.`RewardFactionCapIn5`, s.`RewardCurrencyID1`, s.`RewardCurrencyQty1`, s.`RewardCurrencyID2`, s.`RewardCurrencyQty2`, s.`RewardCurrencyID3`, s.`RewardCurrencyQty3`, s.`RewardCurrencyID4`, s.`RewardCurrencyQty4`, s.`QuestType`, s.`QuestInfoID`, s.`RewardNextQuest`, s.`StartItem`, s.`Flags`, s.`FlagsEx`, s.`FlagsEx2`, s.`TimeAllowed`, s.`QuestSortID`, s.`RewardXPDifficulty`, s.`RewardXPMultiplier`, s.`RewardSpell`, s.`AllowableRaces`, s.`AcceptedSoundKitID`, s.`CompleteSoundKitID`, s.`Expansion`, s.`LogTitle`, s.`LogDescription`, s.`QuestDescription`, s.`AreaDescription`, s.`QuestCompletionLog`, 0 FROM `everlake_build_quests` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', s.`ID`, '2026_11_23_14_world_everlake_riding_writ_quests.sql', s.`note` FROM `everlake_build_quests` s WHERE s.`missing` = 1;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`) SELECT p.`ID`, p.`QuestID`, p.`Type`, p.`Order`, p.`StorageIndex`, p.`ObjectID`, p.`Amount`, p.`Flags`, p.`Description`, 0 FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', p.`ID`, '2026_11_23_14_world_everlake_riding_writ_quests.sql', s.`note` FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_objectives`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `QuestLevel`, `MinLevel`, `MaxLevel` FROM `quest_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) VALUES
(1, 94321, 60, 1, 0),
(2, 94337, 60, 1, 0),
(3, 94338, 60, 1, 0),
(4, 94351, 60, 1, 0),
(5, 99203, 60, 60, 0),
(6, 99206, 60, 60, 0),
(7, 99207, 60, 60, 0),
(8, 99209, 60, 60, 0),
(9, 99212, 60, 60, 0),
(10, 99213, 60, 60, 0),
(11, 99216, 60, 60, 0),
(12, 99218, 60, 60, 0),
(13, 99326, 40, 40, 0),
(14, 99367, 60, 60, 0);
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT p.`ID`, p.`QuestLevel`, p.`MinLevel`, p.`MaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_level', p.`ID`, '2026_11_23_14_world_everlake_riding_writ_quests.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `LevelType`, `QuestLevel` FROM `quest_template_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `LevelType`, `QuestLevel`) VALUES
(1, 94321, 2, 60),
(2, 94337, 2, 60),
(3, 94338, 2, 60),
(4, 94351, 2, 60),
(5, 99203, 2, 60),
(6, 99206, 2, 60),
(7, 99207, 2, 60),
(8, 99209, 2, 60),
(9, 99212, 2, 60),
(10, 99213, 2, 60),
(11, 99216, 2, 60),
(12, 99218, 2, 60),
(13, 99326, 2, 40),
(14, 99367, 2, 60);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT p.`ID`, p.`LevelType`, p.`QuestLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_template_classic_level', p.`ID`, p.`LevelType`, '2026_11_23_14_world_everlake_riding_writ_quests.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
DROP TEMPORARY TABLE `everlake_build_quests`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 265756, 99203, 'seen-live: icyveins:addon'),
(2, 4732, 99206, 'inferred: quest text names Randal Hunter'),
(3, 7954, 99207, 'inferred: quest text names Binjy Featherwhistle'),
(4, 4772, 99209, 'seen-live: icyveins:addon'),
(5, 7955, 99212, 'inferred: mount vendor beside its three mechanostriders'),
(6, 384, 99213, 'inferred: mount vendor beside its three steeds'),
(7, 265756, 99216, 'seen-live: icyveins:addon'),
(8, 7952, 99218, 'seen-live: icyveins:addon'),
(9, 2357, 99326, 'seen-live: icyveins:addon'),
(10, 2357, 99367, 'inferred: mount vendor beside its three steeds');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', s.`id`, s.`quest`, '2026_11_23_14_world_everlake_riding_writ_quests.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 14348, 94321, 'seen-live: icyveins:addon'),
(2, 257743, 94337, 'seen-live: icyveins:addon'),
(3, 11038, 94338, 'seen-live: icyveins:addon'),
(4, 11183, 94351, 'seen-live: icyveins:addon'),
(5, 265756, 99203, 'seen-live: icyveins:addon'),
(6, 384, 99206, 'inferred: same pattern as 99201-99209 (trainer gives, mount vendor takes)'),
(7, 7955, 99207, 'inferred: same pattern as 99201-99209 (trainer gives, mount vendor takes)'),
(8, 1261, 99209, 'seen-live: icyveins:addon'),
(9, 7955, 99212, 'inferred: mount vendor beside its three mechanostriders'),
(10, 384, 99213, 'inferred: mount vendor beside its three steeds'),
(11, 265756, 99216, 'seen-live: icyveins:addon'),
(12, 7952, 99218, 'seen-live: icyveins:addon'),
(13, 2357, 99326, 'seen-live: icyveins:addon'),
(14, 2357, 99367, 'inferred: mount vendor beside its three steeds');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_questender' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', s.`id`, s.`quest`, '2026_11_23_14_world_everlake_riding_writ_quests.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 94321, 'Flasks of Chromatic Resistance are a vital tool when tampering with various elements at once.$B$BDespite my years of practice, I still find myself overwhelmed by these forces when I take my power for granted.$B$BA little boost will go a long way in my research. Should you ever decide to follow in my footsteps, I advise seeking many out long before your trials begin.$B$BThank you for bringing this to me.'),
(2, 94337, 'Oh thank goodness, you ARE beeping! I was beginning to think my time in the tower was starting to take its toll on me.$B$BYou say that this is the security device I requested? And it is, indeed, called an Alarm-O-Bot? A fun name, but not particularly imaginative if a simple servant came up with it too, hah.$B$BIn any case, this will be a fun trial run. I trust it won''t explode?'),
(3, 94351, 'Yep, those are the boots I ordered. I had a pair of wonderful snow-trudging shoes that got swapped for some of my usual armor that I tend to have on hand to sell. Didn''t even notice what I sold off until the buyer brought them back and asked for a repair!$B$BEver since then, I''ve been on the hunt for an extra warm, cozy pair of boots for those chilly nights.$B$BAnd now, here they are! Thanks, pal.'),
(4, 99203, 'You''ve gone on a lot of adventures out there, both here in Skywall, and beyond. $B$BI hope your new armored galestrider will serve you well in your future travels, as well.'),
(5, 99209, 'Trainin''s done, I see. Good for you! It''s time to pick out your armored ram. Come, I''ll help ye decide.'),
(6, 99216, 'Excellent, $N. I can see in your eyes that you have made a choice.$B$BI must say the one you have picked seems fond of you already, and it will be nice to have a reminder of home with you as your adventures take you far from Zephras. I hope you will take good care of it, and it of you.$B$BWinds guide you both!'),
(7, 99218, 'Ah, good. I be seein'' in your eyes that you have made a choice. A fine one at that.$B$BDe one you have picked seems fond of you already, though I am not surprised. I hope you two be taking good care of each other out there in de world.$B$BBlessings of Gonk go wit ya both.'),
(8, 99326, 'Excellent, $N! I can see you''ve made a choice, and what a fine pick it is.$B$BI''m proud to be able to provide you with one of our horses. I must say the one you have picked seems fond of you already! I hope you will take good care of it, and it of you.$B$BCome back if you ever need new horseshoes! They''re on the house.');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_offer_reward` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, '2026_11_23_14_world_everlake_riding_writ_quests.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 94321, 'Yes?'),
(2, 94337, 'Greetings, I am afraid that unless--$B$B<Hastings pauses and examines your equipment curiously.>$B$BPardon my asking, but are you beeping?'),
(3, 94351, 'Hey there, I bet you''ve got that delivery I have been waiting for!'),
(4, 99326, 'You''ve returned! Have you made your choice? These horses are some of the finest this side of the Eastern Kingdoms.$B$BYou won''t find a more courageous steed.');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_request_items` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, '2026_11_23_14_world_everlake_riding_writ_quests.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
COMMIT;
