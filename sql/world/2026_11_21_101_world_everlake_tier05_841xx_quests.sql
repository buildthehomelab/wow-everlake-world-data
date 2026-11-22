-- Live WoW Forever's own Tier 0.5 quests (841xx) the realm lacks, with the class and chain of every 841xx quest.
-- 2026_11_21_101_world_everlake_tier05_841xx_quests.sql: written from public data by a script (the tracker's Icy Veins quest generator), checked by hand.
--
-- Live Forever replaced the old Tier 0.5 quests ("An Earnest Proposition", "Just Compensation", "Anthion's Parting
-- Words", "Saving the Best for Last") with its own copies, ids 84147-84210, given by its own Mokvar 230317 (Orgrimmar),
-- Deliana 230319 (Ironforge) and Anthion Harmon 16016. The realm had 14 of them. This adds 40 more:
--   * quest records (title, texts, objectives, rewards, levels, money, turn-in texts where every recording has one
--     wording) from the Icy Veins catalogue (https://db.icy-veins.com/wow-forever/), which players' addons recorded on
--     live Forever. Reputation as an override (amount x 100), money in quest_classic_money.
--   * givers and enders: Icy Veins' addon records, Wowhead's Forever quest pages and QuestieDB's Forever data (each
--     link's note names its sources); every quest here has a giver and an ender in at least one of them, and none of
--     them disagree.
--   * class and chain (quest_template_addon), for these 40 and the 14 the realm had without them: Icy Veins gives no
--     class, so each 841xx quest takes the class of the old quest asking for the same armour pieces, and the old
--     chain of its side (the prerequisite and next quest the old version had: A Supernatural Device 8922/8923, Return
--     to Deliana/Mokvar 8977/8978, The Challenge 9015, Back to the Beginning 8997/8998, Bodley's Unfortunate Fate
--     8960/9032). Only where the quest has no addon row yet. INFERRED from the old quests, not recorded on live.
--   * Anthion Harmon no longer offers the old "Anthion's Parting Words" (8951-8959, 9016-9022): live's Anthion offers
--     only the 841xx ones (QuestieDB's player traces), and the old ones are handed in only to the old Mokvar and
--     Deliana, who no longer stand anywhere (2026_11_21_01_world_everlake_old_twins_doubled.sql).
-- Held: 84185, 84197-84199, 84205-84207, 84209 (no source names a giver or ender), 84201 (no title), 84204 (its
-- objective items 226720/226723 are not on the server).
-- Game names and text belong to Blizzard Entertainment.
-- Each added row is recorded in `everlake_import_rows`. Never edit this file once it is deployed: a later fix is a new
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';
START TRANSACTION;
CREATE TEMPORARY TABLE `everlake_build_quests` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY, `note` VARCHAR(255) NOT NULL DEFAULT '', `missing` TINYINT NOT NULL DEFAULT 0) SELECT `ID`, `RewardItem1`, `RewardAmount1`, `ItemDrop1`, `ItemDropQuantity1`, `RewardItem2`, `RewardAmount2`, `ItemDrop2`, `ItemDropQuantity2`, `RewardItem3`, `RewardAmount3`, `ItemDrop3`, `ItemDropQuantity3`, `RewardItem4`, `RewardAmount4`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `QuestType`, `QuestInfoID`, `RewardNextQuest`, `StartItem`, `Flags`, `FlagsEx`, `FlagsEx2`, `TimeAllowed`, `QuestSortID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardSpell`, `AllowableRaces`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog` FROM `quest_template` WHERE 0;
INSERT INTO `everlake_build_quests` (`n`, `ID`, `RewardItem1`, `RewardAmount1`, `ItemDrop1`, `ItemDropQuantity1`, `RewardItem2`, `RewardAmount2`, `ItemDrop2`, `ItemDropQuantity2`, `RewardItem3`, `RewardAmount3`, `ItemDrop3`, `ItemDropQuantity3`, `RewardItem4`, `RewardAmount4`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `QuestType`, `QuestInfoID`, `RewardNextQuest`, `StartItem`, `Flags`, `FlagsEx`, `FlagsEx2`, `TimeAllowed`, `QuestSortID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardSpell`, `AllowableRaces`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `note`) VALUES
(1, 84151, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 226953, 1, 226949, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 264, 0, 0, 0, 1537, 5, 2.0, 0, 18446744073709551615, 890, 878, -2, 'An Earnest Proposition', 'Acquire 15 Winterspring Blood Samples and 20 gold and bring them along with 1 set of Devout Bracers to Deliana in Ironforge.', 'Well met, $c.  I''ve something that might interest you.$B$BI have in my possession a set of armor much like the one worn by those of your profession, but of much higher quality.  I''d be willing to trade the bracers for ordinary ones in exchange for a small favor.$B$BThe blood of the frostsabers and bears that inhabit Winterspring has properties I''m in need of at the moment.  Bring me a sizeable sample of it along with the bracers and a small amount of gold.  You shall find the effort worth your while.', '', '', 'seen-live: icyveins:catalog'), -- An Earnest Proposition
(2, 84152, 226830, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 264, 0, 0, 0, 1537, 5, 2.0, 0, 18446744073709551615, 890, 878, -2, 'An Earnest Proposition', 'Acquire 15 Winterspring Blood Samples and 20 gold and bring them along with a set of Shadowcraft Bracers to Deliana in Ironforge.\r\n', 'Well met, $c.  I''ve something that might interest you.$B$BI have in my possession a set of armor much like the one worn by those of your profession, but of much higher quality.  I''d be willing to trade the bracers for ordinary ones in exchange for a small favor.$B$BThe blood of the frostsabers and bears that inhabit Winterspring has properties I''m in need of at the moment.  Bring me a sizeable sample of it along with the bracers and a small amount of gold.  You shall find the effort worth your while.', '', '', 'seen-live: icyveins:catalog'), -- An Earnest Proposition
(3, 84153, 226907, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 264, 0, 0, 0, 1537, 5, 2.0, 0, 18446744073709551615, 890, 878, -2, 'An Earnest Proposition', 'Acquire 15 Winterspring Blood Samples and 20 gold and bring them along with a set of Dreadmist Bracers to Deliana in Ironforge.\r\n', 'Well met, $c.  I''ve something that might interest you.$B$BI have in my possession a set of armor much like the one worn by those of your profession, but of much higher quality.  I''d be willing to trade the bracers for ordinary ones in exchange for a small favor.$B$BThe blood of the frostsabers and bears that inhabit Winterspring has properties I''m in need of at the moment.  Bring me a sizeable sample of it along with the bracers and a small amount of gold.  You shall find the effort worth your while.', '', '', 'seen-live: icyveins:catalog'), -- An Earnest Proposition
(4, 84163, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227337, 1, 227338, 1, 227339, 1, 227340, 1, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Just Compensation', 'Bring a Wildheart Belt and a set of Wildheart Gloves Deliana in Ironforge.', 'You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me the belt and set of gloves that you wish to upgrade.  I promise the ones I give you in return will be far superior.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(5, 84164, 226883, 1, 0, 0, 226888, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Just Compensation', 'Bring a Beaststalker''s Belt and a set of Beaststalker''s Gloves to Deliana in Ironforge.', 'You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me an ordinary belt and a set of gloves that you wish to upgrade.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(6, 84165, 226934, 1, 0, 0, 226930, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Just Compensation', 'Bring a Magister''s Belt and a set of Magister''s Gloves to Deliana in Ironforge.\r\n', 'You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me an ordinary belt and a set of gloves that you wish to upgrade.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(7, 84166, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227343, 1, 227344, 1, 227345, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Just Compensation', 'Bring a Lightforge Belt and a set of Lightforge Gauntlets to Deliana in Ironforge.\r\n', 'You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me the belt and set of gauntlets that you wish to upgrade.  I promise the ones I give you in return will be far superior.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(8, 84167, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227346, 1, 227347, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Just Compensation', 'Bring a Devout Belt and a set of Devout Gloves to Deliana in Ironforge.', 'You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me the belt and set of gloves that you wish to upgrade.  I promise the ones I give you in return will be far superior.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(9, 84168, 226828, 1, 0, 0, 226832, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Just Compensation', 'Bring a Shadowcraft Belt and a set of Shadowcraft Gloves to Deliana in Ironforge.', 'You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me the belt and set of gloves that you wish to upgrade.  I promise the ones I give you in return will be far superior.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(10, 84169, 226911, 1, 0, 0, 226905, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Just Compensation', 'Bring a Dreadmist Belt and a set of Dreadmist Wraps to Deliana in Ironforge.', 'You kept your word and brought the device built by Mux.  I believe a reward is in order if I''m to keep you interested in saving my skin.  Bring me the belt and set of gloves that you wish to upgrade.  I promise the ones I give you in return will be far superior.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(11, 84171, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227337, 1, 227338, 1, 227339, 1, 227340, 1, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Just Compensation', 'Bring a Wildheart Belt and a set of Wildheart Gloves to Mokvar in Orgrimmar.', 'You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.$B$BFor now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(12, 84172, 226883, 1, 0, 0, 226888, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Just Compensation', 'Bring a Beaststalker''s Belt and a set of Beaststalker''s Gloves to Mokvar in Orgrimmar.', 'You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.$B$BFor now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(13, 84173, 226934, 1, 0, 0, 226930, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Just Compensation', 'Bring a Magister''s Belt and a set of Magister''s Gloves to Mokvar in Orgrimmar.', 'You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.$B$BFor now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(14, 84174, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227346, 1, 227347, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Just Compensation', 'Bring a Devout Belt and a set of Devout Gloves to Mokvar in Orgrimmar.', 'You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.$B$BFor now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(15, 84175, 226828, 1, 0, 0, 226832, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Just Compensation', 'Bring a Shadowcraft Belt and a set of Shadowcraft Gloves to Mokvar in Orgrimmar.', 'You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.$B$BFor now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(16, 84176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227350, 1, 227351, 1, 227352, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Just Compensation', 'Bring a Cord of the Elements and a set of Gauntlets of the Elements to Mokvar in Orgrimmar.\r\n', 'You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.$B$BFor now I will exchange your belt and gauntlets.  If we both see this through I shall make the rest of the pieces available to you.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(17, 84177, 226911, 1, 0, 0, 226905, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Just Compensation', 'Bring a Dreadmist Belt and a set of Dreadmist Wraps to Mokvar in Orgrimmar.\r\n', 'You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.$B$BFor now I will exchange your belt and gloves.  If we both see this through I shall make the rest of the pieces available to you.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(18, 84178, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227356, 1, 227357, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Just Compensation', 'Bring a Belt of Valor and a set of Gauntlets of Valor to Mokvar in Orgrimmar.\r\n', 'You''ve proven to be a very reliable individual, $n.  As much as I trust that you''ll help me through this predicament, it would be wise of me to reward you according to your performance.$B$BFor now I will exchange your belt and gauntlets.  If we both see this through I shall make the rest of the pieces available to you.', '', '', 'seen-live: icyveins:catalog'), -- Just Compensation
(19, 84179, 0, 0, 22047, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227359, 1, 227360, 1, 227361, 1, 227365, 1, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Deliana in Ironforge with a set of Wildheart Boots, a Wildheart Kilt and Wildheart Spaulders.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(20, 84180, 226881, 1, 22047, 1, 226882, 1, 0, 0, 226884, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Deliana in Ironforge with a set of Beaststalker''s Boots, Beaststalker''s Pants and Beaststalker''s Mantle.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(21, 84181, 226931, 1, 22047, 1, 226933, 1, 0, 0, 226936, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Deliana in Ironforge with a set of Magister''s Boots, Magister''s Leggings and Magister''s Mantle.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(22, 84182, 0, 0, 22047, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227368, 1, 227369, 1, 227370, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Deliana in Ironforge with a set of Lightforge Boots, Lightforge Legplates and Lightforge Spaulders.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(23, 84183, 0, 0, 22047, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227371, 1, 227372, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Deliana in Ironforge with a set of Devout Sandals, Devout Skirt and Devout Mantle.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(24, 84184, 226831, 1, 22047, 1, 226827, 1, 0, 0, 226826, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Deliana in Ironforge with a set of Shadowcraft Boots, Shadowcraft Pants and Shadowcraft Spaulders.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(25, 84186, 0, 0, 22047, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227381, 1, 227382, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1537, 7, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Deliana in Ironforge with a set of Boots of Valor, Legplates of Valor and Spaulders of Valor.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the medallion back together.  Return to Deliana and tell her that Bodley is her only hope for finding the remaining pieces.  Speak to her about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(26, 84187, 0, 0, 22047, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227359, 1, 227360, 1, 227361, 1, 227365, 1, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Mokvar in Orgimmar with a set of Wildheart Boots, a Wildheart Kilt and Wildheart Spaulders.\r\n', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(27, 84188, 226881, 1, 22047, 1, 226882, 1, 0, 0, 226884, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Mokvar in Orgimmar with a set of Beaststalker''s Boots, Beaststalker''s Pants and Beaststalker''s Mantle.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(28, 84189, 226931, 1, 21986, 1, 226933, 1, 0, 0, 226936, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 21986, 0, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Mokvar in Orgimmar with a set of Magister''s Boots, Magister''s Leggings and Magister''s Mantle.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(29, 84190, 0, 0, 22047, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227371, 1, 227372, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Mokvar in Orgimmar with a set of Devout Sandals, Devout Skirt and Devout Mantle.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(30, 84191, 226831, 1, 22047, 1, 226827, 1, 0, 0, 226826, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Mokvar in Orgimmar with a set of  Shadowcraft Boots, Shadowcraft Pants and Shadowcraft Spaulders.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(31, 84192, 0, 0, 22047, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227375, 1, 227376, 1, 227377, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Mokvar in Orgimmar with a set of Boots of Elements, Kilt of Elements and Pauldrons of Elements.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(32, 84193, 226908, 1, 22047, 1, 226910, 1, 0, 0, 226912, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Mokvar in Orgimmar with a set of Dreadmist Sandals, Dreadmist Leggings and Dreadmist Mantle.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(33, 84194, 0, 0, 22047, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227381, 1, 227382, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 22047, 0, 0, 0, 0, 1637, 7, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Anthion''s Parting Words', 'Return to Mokvar in Orgimmar with a set of Boots of Valor, Legplates of Valor and Spaulders of Valor.', 'Valthalak''s soul was stored in this amulet.  In our greed we foolishly split it into three parts, not knowing the curse that would await us.$B$BThe only way to stop Valthalak''s spell is to put the amulet back together.  Return to Mokvar and tell him that Bodley is his only hope for finding the remaining pieces.  Speak to him about any rewards you''ve arranged for.$B$BI, for once, shall rest in peace.  I wish you the best of luck; you shall need every bit of it!', '', '', 'seen-live: icyveins:catalog'), -- Anthion's Parting Words
(34, 84195, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227383, 1, 227384, 1, 227385, 1, 227387, 1, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 2, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Saving the Best for Last', 'Give Deliana your Wildheart Cowl and Wildheart Vest.', 'That''s an amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved. Now maybe I''ll be able to sleep at night with both eyes shut.$B$BAs to your reward, I believe I have a few things that you''ll really enjoy.', '', '', 'seen-live: icyveins:catalog'), -- Saving the Best for Last
(35, 84196, 226887, 1, 0, 0, 226886, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 2, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Saving the Best for Last', 'Give Deliana your Beaststalker''s Cap and Beaststalker''s Tunic.', 'That''s an amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved. Now maybe I''ll be able to sleep at night with both eyes shut.$B$BAs to your reward, I believe I have a few things that you''ll really enjoy.', '', '', 'seen-live: icyveins:catalog'), -- Saving the Best for Last
(36, 84200, 226829, 1, 0, 0, 226825, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 2, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Saving the Best for Last', 'Give Deliana your Shadowcraft Cap and Shadowcraft Tunic.', 'That''s an amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved. Now maybe I''ll be able to sleep at night with both eyes shut.$B$BAs to your reward, I believe I have a few things that you''ll really enjoy.', '', '', 'seen-live: icyveins:catalog'), -- Saving the Best for Last
(37, 84202, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227403, 1, 227404, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1537, 2, 2.0, 0, 6130900294268440000, 890, 878, -2, 'Saving the Best for Last', 'Give Deliana your Helm of Valor and Breastplate of Valor.', 'That''s an amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved. Now maybe I''ll be able to sleep at night with both eyes shut.$B$BAs to your reward, I believe I have a few things that you''ll really enjoy.', '', '', 'seen-live: icyveins:catalog'), -- Saving the Best for Last
(38, 84203, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227383, 1, 227384, 1, 227385, 1, 227387, 1, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 2, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Saving the Best for Last', 'Give Mokvar your Wildheart Cowl and Wildheart Vest.', 'A truly amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved, I can assure you. Through your efforts we are delivered from the mistakes of our past.$B$BAs to your reward, I believe I have a few things that you have definitely earned and will truly enjoy.', '', '', 'seen-live: icyveins:catalog'), -- Saving the Best for Last
(39, 84208, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227397, 1, 227398, 1, 227399, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 2, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Saving the Best for Last', 'Give Mokvar your Coif of Elements and Vest of Elements.', 'A truly amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved, I can assure you. Through your efforts we are delivered from the mistakes of our past.$B$BAs to your reward, I believe I have a few things that you have definitely earned and will truly enjoy.', '', '', 'seen-live: icyveins:catalog'), -- Saving the Best for Last
(40, 84210, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227403, 1, 227404, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 8, 0, 0, 0, 1637, 2, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Saving the Best for Last', 'Give Mokvar your Helm of Valor and Breastplate of Valor.', 'A truly amazing story, $n! You have my thanks, and the heartfelt gratitude of all who were involved, I can assure you. Through your efforts we are delivered from the mistakes of our past.$B$BAs to your reward, I believe I have a few things that you have definitely earned and will truly enjoy.', '', '', 'seen-live: icyveins:catalog'); -- Saving the Best for Last
CREATE TEMPORARY TABLE `everlake_build_objectives` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY, `taken` TINYINT NOT NULL DEFAULT 0) SELECT `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description` FROM `quest_objectives` WHERE 0;
INSERT INTO `everlake_build_objectives` (`n`, `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`) VALUES
(1, 451814, 84151, 1, 0, 0, 21928, 15, 32, ''),
(2, 451815, 84151, 1, 1, 1, 16697, 1, 32, ''),
(3, 451816, 84151, 8, 2, -1, 0, 200000, 32, ''),
(4, 451820, 84152, 1, 0, 0, 21928, 15, 32, ''),
(5, 451821, 84152, 1, 1, 1, 16710, 1, 32, ''),
(6, 451822, 84152, 8, 2, -1, 0, 200000, 32, ''),
(7, 451826, 84153, 1, 0, 0, 21928, 15, 32, ''),
(8, 451827, 84153, 1, 1, 1, 16703, 1, 32, ''),
(9, 451828, 84153, 8, 2, -1, 0, 200000, 32, ''),
(10, 451887, 84163, 1, 0, 0, 16716, 1, 32, ''),
(11, 451888, 84163, 1, 1, 1, 16717, 1, 32, ''),
(12, 451891, 84164, 1, 0, 0, 16680, 1, 32, ''),
(13, 451892, 84164, 1, 1, 1, 16676, 1, 32, ''),
(14, 451895, 84165, 1, 0, 0, 16685, 1, 32, ''),
(15, 451896, 84165, 1, 1, 1, 16684, 1, 32, ''),
(16, 451899, 84166, 1, 0, 0, 16723, 1, 32, ''),
(17, 451900, 84166, 1, 1, 1, 16724, 1, 32, ''),
(18, 451903, 84167, 1, 0, 0, 16696, 1, 32, ''),
(19, 451904, 84167, 1, 1, 1, 16692, 1, 32, ''),
(20, 451907, 84168, 1, 0, 0, 16713, 1, 32, ''),
(21, 451908, 84168, 1, 1, 1, 16712, 1, 32, ''),
(22, 451911, 84169, 1, 0, 0, 16702, 1, 32, ''),
(23, 451912, 84169, 1, 1, 1, 16705, 1, 32, ''),
(24, 451919, 84171, 1, 0, 0, 16716, 1, 32, ''),
(25, 451920, 84171, 1, 1, 1, 16717, 1, 32, ''),
(26, 451923, 84172, 1, 0, 0, 16680, 1, 32, ''),
(27, 451924, 84172, 1, 1, 1, 16676, 1, 32, ''),
(28, 451927, 84173, 1, 0, 0, 16685, 1, 32, ''),
(29, 451928, 84173, 1, 1, 1, 16684, 1, 32, ''),
(30, 451931, 84174, 1, 0, 0, 16696, 1, 32, ''),
(31, 451932, 84174, 1, 1, 1, 16692, 1, 32, ''),
(32, 451935, 84175, 1, 0, 0, 16713, 1, 32, ''),
(33, 451936, 84175, 1, 1, 1, 16712, 1, 32, ''),
(34, 451939, 84176, 1, 0, 0, 16673, 1, 32, ''),
(35, 451940, 84176, 1, 1, 1, 16672, 1, 32, ''),
(36, 451943, 84177, 1, 0, 0, 16702, 1, 32, ''),
(37, 451944, 84177, 1, 1, 1, 16705, 1, 32, ''),
(38, 451947, 84178, 1, 0, 0, 16736, 1, 32, ''),
(39, 451948, 84178, 1, 1, 1, 16737, 1, 32, ''),
(40, 451952, 84179, 1, 0, 0, 16715, 1, 32, ''),
(41, 451953, 84179, 1, 1, 1, 16719, 1, 32, ''),
(42, 451954, 84179, 1, 2, 2, 16718, 1, 32, ''),
(43, 451958, 84180, 1, 0, 0, 16675, 1, 32, ''),
(44, 451959, 84180, 1, 1, 1, 16678, 1, 32, ''),
(45, 451960, 84180, 1, 2, 2, 16679, 1, 32, ''),
(46, 451964, 84181, 1, 0, 0, 16682, 1, 32, ''),
(47, 451965, 84181, 1, 1, 1, 16687, 1, 32, ''),
(48, 451966, 84181, 1, 2, 2, 16689, 1, 32, ''),
(49, 451970, 84182, 1, 0, 0, 16725, 1, 32, ''),
(50, 451971, 84182, 1, 1, 1, 16728, 1, 32, ''),
(51, 451972, 84182, 1, 2, 2, 16729, 1, 32, ''),
(52, 451976, 84183, 1, 0, 0, 16691, 1, 32, ''),
(53, 451977, 84183, 1, 1, 1, 16694, 1, 32, ''),
(54, 451978, 84183, 1, 2, 2, 16695, 1, 32, ''),
(55, 451982, 84184, 1, 0, 0, 16711, 1, 32, ''),
(56, 451983, 84184, 1, 1, 1, 16709, 1, 32, ''),
(57, 451984, 84184, 1, 2, 2, 16708, 1, 32, ''),
(58, 451994, 84186, 1, 0, 0, 16734, 1, 32, ''),
(59, 451995, 84186, 1, 1, 1, 16732, 1, 32, ''),
(60, 451996, 84186, 1, 2, 2, 16733, 1, 32, ''),
(61, 452000, 84187, 1, 0, 0, 16715, 1, 32, ''),
(62, 452001, 84187, 1, 1, 1, 16719, 1, 32, ''),
(63, 452002, 84187, 1, 2, 2, 16718, 1, 32, ''),
(64, 452006, 84188, 1, 0, 0, 16675, 1, 32, ''),
(65, 452007, 84188, 1, 1, 1, 16678, 1, 32, ''),
(66, 452008, 84188, 1, 2, 2, 16679, 1, 32, ''),
(67, 452012, 84189, 1, 0, 0, 16682, 1, 32, ''),
(68, 452013, 84189, 1, 1, 1, 16687, 1, 32, ''),
(69, 452014, 84189, 1, 2, 2, 16689, 1, 32, ''),
(70, 452018, 84190, 1, 0, 0, 16691, 1, 32, ''),
(71, 452019, 84190, 1, 1, 1, 16694, 1, 32, ''),
(72, 452020, 84190, 1, 2, 2, 16695, 1, 32, ''),
(73, 452024, 84191, 1, 0, 0, 16711, 1, 32, ''),
(74, 452025, 84191, 1, 1, 1, 16709, 1, 32, ''),
(75, 452026, 84191, 1, 2, 2, 16708, 1, 32, ''),
(76, 452030, 84192, 1, 0, 0, 16670, 1, 32, ''),
(77, 452031, 84192, 1, 1, 1, 16668, 1, 32, ''),
(78, 452032, 84192, 1, 2, 2, 16669, 1, 32, ''),
(79, 452036, 84193, 1, 0, 0, 16704, 1, 32, ''),
(80, 452037, 84193, 1, 1, 1, 16699, 1, 32, ''),
(81, 452038, 84193, 1, 2, 2, 16701, 1, 32, ''),
(82, 452042, 84194, 1, 0, 0, 16734, 1, 32, ''),
(83, 452043, 84194, 1, 1, 1, 16732, 1, 32, ''),
(84, 452044, 84194, 1, 2, 2, 16733, 1, 32, ''),
(85, 452047, 84195, 1, 0, 0, 16720, 1, 32, ''),
(86, 452048, 84195, 1, 1, 1, 16706, 1, 32, ''),
(87, 452051, 84196, 1, 0, 0, 16677, 1, 32, ''),
(88, 452052, 84196, 1, 1, 1, 16674, 1, 32, ''),
(89, 452067, 84200, 1, 0, 0, 16707, 1, 32, ''),
(90, 452068, 84200, 1, 1, 1, 16721, 1, 32, ''),
(91, 452075, 84202, 1, 0, 0, 16731, 1, 32, ''),
(92, 452076, 84202, 1, 1, 1, 16730, 1, 32, ''),
(93, 452079, 84203, 1, 0, 0, 16720, 1, 32, ''),
(94, 452080, 84203, 1, 1, 1, 16706, 1, 32, ''),
(95, 452099, 84208, 1, 0, 0, 16667, 1, 32, ''),
(96, 452100, 84208, 1, 1, 1, 16666, 1, 32, ''),
(97, 452107, 84210, 1, 0, 0, 16731, 1, 32, ''),
(98, 452108, 84210, 1, 1, 1, 16730, 1, 32, '');
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.`ID` = p.`ID`) OR EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'quest_objectives' AND r.`k1` = p.`ID`);
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE (p.`Type` IN (0, 3) AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = p.`ObjectID`)) OR (p.`Type` = 2 AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = p.`ObjectID`));
UPDATE `everlake_build_quests` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `quest_template` t WHERE t.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` IN ('quest_template', 'quest_classic_level', 'quest_template_classic_level', 'quest_classic_money', 'quest_template_addon') AND r.`k1` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_objectives` c WHERE c.`QuestID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_money` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_build_objectives` p WHERE p.`QuestID` = s.`ID` AND p.`taken` = 1);
INSERT INTO `quest_template` (`ID`, `RewardItem1`, `RewardAmount1`, `ItemDrop1`, `ItemDropQuantity1`, `RewardItem2`, `RewardAmount2`, `ItemDrop2`, `ItemDropQuantity2`, `RewardItem3`, `RewardAmount3`, `ItemDrop3`, `ItemDropQuantity3`, `RewardItem4`, `RewardAmount4`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `QuestType`, `QuestInfoID`, `RewardNextQuest`, `StartItem`, `Flags`, `FlagsEx`, `FlagsEx2`, `TimeAllowed`, `QuestSortID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardSpell`, `AllowableRaces`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`) SELECT s.`ID`, s.`RewardItem1`, s.`RewardAmount1`, s.`ItemDrop1`, s.`ItemDropQuantity1`, s.`RewardItem2`, s.`RewardAmount2`, s.`ItemDrop2`, s.`ItemDropQuantity2`, s.`RewardItem3`, s.`RewardAmount3`, s.`ItemDrop3`, s.`ItemDropQuantity3`, s.`RewardItem4`, s.`RewardAmount4`, s.`ItemDrop4`, s.`ItemDropQuantity4`, s.`RewardChoiceItemID1`, s.`RewardChoiceItemQuantity1`, s.`RewardChoiceItemID2`, s.`RewardChoiceItemQuantity2`, s.`RewardChoiceItemID3`, s.`RewardChoiceItemQuantity3`, s.`RewardChoiceItemID4`, s.`RewardChoiceItemQuantity4`, s.`RewardChoiceItemID5`, s.`RewardChoiceItemQuantity5`, s.`RewardChoiceItemID6`, s.`RewardChoiceItemQuantity6`, s.`RewardFactionID1`, s.`RewardFactionValue1`, s.`RewardFactionOverride1`, s.`RewardFactionCapIn1`, s.`RewardFactionID2`, s.`RewardFactionValue2`, s.`RewardFactionOverride2`, s.`RewardFactionCapIn2`, s.`RewardFactionID3`, s.`RewardFactionValue3`, s.`RewardFactionOverride3`, s.`RewardFactionCapIn3`, s.`RewardFactionID4`, s.`RewardFactionValue4`, s.`RewardFactionOverride4`, s.`RewardFactionCapIn4`, s.`RewardFactionID5`, s.`RewardFactionValue5`, s.`RewardFactionOverride5`, s.`RewardFactionCapIn5`, s.`RewardCurrencyID1`, s.`RewardCurrencyQty1`, s.`RewardCurrencyID2`, s.`RewardCurrencyQty2`, s.`RewardCurrencyID3`, s.`RewardCurrencyQty3`, s.`RewardCurrencyID4`, s.`RewardCurrencyQty4`, s.`QuestType`, s.`QuestInfoID`, s.`RewardNextQuest`, s.`StartItem`, s.`Flags`, s.`FlagsEx`, s.`FlagsEx2`, s.`TimeAllowed`, s.`QuestSortID`, s.`RewardXPDifficulty`, s.`RewardXPMultiplier`, s.`RewardSpell`, s.`AllowableRaces`, s.`AcceptedSoundKitID`, s.`CompleteSoundKitID`, s.`Expansion`, s.`LogTitle`, s.`LogDescription`, s.`QuestDescription`, s.`AreaDescription`, s.`QuestCompletionLog`, 0 FROM `everlake_build_quests` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', s.`ID`, '2026_11_21_101_world_everlake_tier05_841xx_quests.sql', s.`note` FROM `everlake_build_quests` s WHERE s.`missing` = 1;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`) SELECT p.`ID`, p.`QuestID`, p.`Type`, p.`Order`, p.`StorageIndex`, p.`ObjectID`, p.`Amount`, p.`Flags`, p.`Description`, 0 FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', p.`ID`, '2026_11_21_101_world_everlake_tier05_841xx_quests.sql', s.`note` FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_objectives`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `QuestLevel`, `MinLevel`, `MaxLevel` FROM `quest_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) VALUES
(1, 84151, 60, 58, 0),
(2, 84152, 60, 58, 0),
(3, 84153, 60, 58, 0),
(4, 84163, 60, 58, 0),
(5, 84164, 60, 58, 0),
(6, 84165, 60, 58, 0),
(7, 84166, 60, 58, 0),
(8, 84167, 60, 58, 0),
(9, 84168, 60, 58, 0),
(10, 84169, 60, 58, 0),
(11, 84171, 60, 58, 0),
(12, 84172, 60, 58, 0),
(13, 84173, 60, 58, 0),
(14, 84174, 60, 58, 0),
(15, 84175, 60, 58, 0),
(16, 84176, 60, 58, 0),
(17, 84177, 60, 58, 0),
(18, 84178, 60, 58, 0),
(19, 84179, 60, 58, 0),
(20, 84180, 60, 58, 0),
(21, 84181, 60, 58, 0),
(22, 84182, 60, 58, 0),
(23, 84183, 60, 58, 0),
(24, 84184, 60, 58, 0),
(25, 84186, 60, 58, 0),
(26, 84187, 60, 58, 0),
(27, 84188, 60, 58, 0),
(28, 84189, 60, 58, 0),
(29, 84190, 60, 58, 0),
(30, 84191, 60, 58, 0),
(31, 84192, 60, 58, 0),
(32, 84193, 60, 58, 0),
(33, 84194, 60, 58, 0),
(34, 84195, 60, 58, 0),
(35, 84196, 60, 58, 0),
(36, 84200, 60, 58, 0),
(37, 84202, 60, 58, 0),
(38, 84203, 60, 58, 0),
(39, 84208, 60, 58, 0),
(40, 84210, 60, 58, 0);
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT p.`ID`, p.`QuestLevel`, p.`MinLevel`, p.`MaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_level', p.`ID`, '2026_11_21_101_world_everlake_tier05_841xx_quests.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `LevelType`, `QuestLevel` FROM `quest_template_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `LevelType`, `QuestLevel`) VALUES
(1, 84151, 2, 60),
(2, 84152, 2, 60),
(3, 84153, 2, 60),
(4, 84163, 2, 60),
(5, 84164, 2, 60),
(6, 84165, 2, 60),
(7, 84166, 2, 60),
(8, 84167, 2, 60),
(9, 84168, 2, 60),
(10, 84169, 2, 60),
(11, 84171, 2, 60),
(12, 84172, 2, 60),
(13, 84173, 2, 60),
(14, 84174, 2, 60),
(15, 84175, 2, 60),
(16, 84176, 2, 60),
(17, 84177, 2, 60),
(18, 84178, 2, 60),
(19, 84179, 2, 60),
(20, 84180, 2, 60),
(21, 84181, 2, 60),
(22, 84182, 2, 60),
(23, 84183, 2, 60),
(24, 84184, 2, 60),
(25, 84186, 2, 60),
(26, 84187, 2, 60),
(27, 84188, 2, 60),
(28, 84189, 2, 60),
(29, 84190, 2, 60),
(30, 84191, 2, 60),
(31, 84192, 2, 60),
(32, 84193, 2, 60),
(33, 84194, 2, 60),
(34, 84195, 2, 60),
(35, 84196, 2, 60),
(36, 84200, 2, 60),
(37, 84202, 2, 60),
(38, 84203, 2, 60),
(39, 84208, 2, 60),
(40, 84210, 2, 60);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT p.`ID`, p.`LevelType`, p.`QuestLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_template_classic_level', p.`ID`, p.`LevelType`, '2026_11_21_101_world_everlake_tier05_841xx_quests.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `RewardMoney`, `RewardMoneyMaxLevel` FROM `quest_classic_money` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `RewardMoney`, `RewardMoneyMaxLevel`) VALUES
(1, 84151, -200000, 0),
(2, 84152, -200000, 0),
(3, 84153, -200000, 0);
INSERT INTO `quest_classic_money` (`ID`, `RewardMoney`, `RewardMoneyMaxLevel`) SELECT p.`ID`, p.`RewardMoney`, p.`RewardMoneyMaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_money', p.`ID`, '2026_11_21_101_world_everlake_tier05_841xx_quests.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
DROP TEMPORARY TABLE `everlake_build_quests`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 230319, 84151, 'seen-live: icyveins:addon'),
(2, 230319, 84152, 'seen-live: icyveins:addon'),
(3, 230319, 84153, 'seen-live: icyveins:addon'),
(4, 230319, 84163, 'seen-live: wowhead questie'),
(5, 230319, 84164, 'seen-live: wowhead questie'),
(6, 230319, 84165, 'seen-live: icyveins:addon'),
(7, 230319, 84166, 'seen-live: icyveins:addon'),
(8, 230319, 84167, 'seen-live: questie'),
(9, 230319, 84168, 'seen-live: icyveins:addon'),
(10, 230319, 84169, 'seen-live: questie'),
(11, 230317, 84171, 'seen-live: wowhead questie'),
(12, 230317, 84172, 'seen-live: icyveins:addon'),
(13, 230317, 84173, 'seen-live: icyveins:addon'),
(14, 230317, 84174, 'seen-live: icyveins:addon'),
(15, 230317, 84175, 'seen-live: icyveins:addon'),
(16, 230317, 84176, 'seen-live: icyveins:addon'),
(17, 230317, 84177, 'seen-live: wowhead questie'),
(18, 230317, 84178, 'seen-live: icyveins:addon'),
(19, 16016, 84179, 'seen-live: questie'),
(20, 16016, 84180, 'seen-live: questie'),
(21, 16016, 84181, 'seen-live: questie'),
(22, 16016, 84182, 'seen-live: questie'),
(23, 16016, 84183, 'seen-live: questie'),
(24, 16016, 84184, 'seen-live: icyveins:addon'),
(25, 16016, 84186, 'seen-live: wowhead questie'),
(26, 16016, 84187, 'seen-live: questie'),
(27, 16016, 84188, 'seen-live: icyveins:addon'),
(28, 16016, 84189, 'seen-live: questie'),
(29, 16016, 84190, 'seen-live: questie'),
(30, 16016, 84191, 'seen-live: questie'),
(31, 16016, 84192, 'seen-live: wowhead questie'),
(32, 16016, 84193, 'seen-live: questie'),
(33, 16016, 84194, 'seen-live: wowhead questie'),
(34, 230319, 84195, 'seen-live: questie'),
(35, 230319, 84196, 'seen-live: questie'),
(36, 230319, 84200, 'seen-live: icyveins:addon'),
(37, 230319, 84202, 'seen-live: questie'),
(38, 230317, 84203, 'seen-live: questie'),
(39, 230317, 84208, 'seen-live: wowhead questie'),
(40, 230317, 84210, 'seen-live: wowhead questie');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', s.`id`, s.`quest`, '2026_11_21_101_world_everlake_tier05_841xx_quests.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 230319, 84151, 'seen-live: icyveins:addon'),
(2, 230319, 84152, 'seen-live: icyveins:addon'),
(3, 230319, 84153, 'seen-live: icyveins:addon'),
(4, 230319, 84163, 'seen-live: wowhead questie'),
(5, 230319, 84164, 'seen-live: wowhead questie'),
(6, 230319, 84165, 'seen-live: icyveins:addon'),
(7, 230319, 84166, 'seen-live: icyveins:addon'),
(8, 230319, 84167, 'seen-live: questie'),
(9, 230319, 84168, 'seen-live: icyveins:addon'),
(10, 230319, 84169, 'seen-live: questie'),
(11, 230317, 84171, 'seen-live: wowhead questie'),
(12, 230317, 84172, 'seen-live: icyveins:addon'),
(13, 230317, 84173, 'seen-live: icyveins:addon'),
(14, 230317, 84174, 'seen-live: icyveins:addon'),
(15, 230317, 84175, 'seen-live: icyveins:addon'),
(16, 230317, 84176, 'seen-live: icyveins:addon'),
(17, 230317, 84177, 'seen-live: wowhead questie'),
(18, 230317, 84178, 'seen-live: icyveins:addon'),
(19, 230319, 84179, 'seen-live: questie'),
(20, 230319, 84180, 'seen-live: questie'),
(21, 230319, 84181, 'seen-live: questie'),
(22, 230319, 84182, 'seen-live: questie'),
(23, 230319, 84183, 'seen-live: questie'),
(24, 230319, 84184, 'seen-live: icyveins:addon'),
(25, 230319, 84186, 'seen-live: wowhead questie'),
(26, 230317, 84187, 'seen-live: questie'),
(27, 230317, 84188, 'seen-live: icyveins:addon'),
(28, 230317, 84189, 'seen-live: questie'),
(29, 230317, 84190, 'seen-live: questie'),
(30, 230317, 84191, 'seen-live: questie'),
(31, 230317, 84192, 'seen-live: wowhead questie'),
(32, 230317, 84193, 'seen-live: questie'),
(33, 230317, 84194, 'seen-live: wowhead questie'),
(34, 230319, 84195, 'seen-live: questie'),
(35, 230319, 84196, 'seen-live: questie'),
(36, 230319, 84200, 'seen-live: icyveins:addon'),
(37, 230319, 84202, 'seen-live: questie'),
(38, 230317, 84203, 'seen-live: questie'),
(39, 230317, 84208, 'seen-live: wowhead questie'),
(40, 230317, 84210, 'seen-live: wowhead questie');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_questender' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', s.`id`, s.`quest`, '2026_11_21_101_world_everlake_tier05_841xx_quests.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 84151, 'Excellent!  Let''s perform the trade then.  It''s hard to part with this excellent armor, but I''m afraid I won''t be needing it any time soon.$B$BIf you''re interested in performing more work for me, I might be willing to give up the rest of the pieces.'),
(2, 84152, 'Excellent!  Let''s perform the trade then.  It''s hard to part with this excellent armor, but I''m afraid I won''t be needing it any time soon.$B$BIf you''re interested in performing more work for me, I might be willing to give up the rest of the pieces.'),
(3, 84153, 'Excellent!  Let''s perform the trade then.  It''s hard to part with this excellent armor, but I''m afraid I won''t be needing it any time soon.$B$BIf you''re interested in performing more work for me, I might be willing to give up the rest of the pieces.'),
(4, 84165, 'You''ve kept your end of the bargain, I shall keep mine.$B$BJust remember that I''m holding on to the best pieces until your work is finished.'),
(5, 84166, 'You''ve kept your end of the bargain, I shall keep mine.$B$BJust remember that I''m holding on to the best pieces until your work is finished.'),
(6, 84168, 'You''ve kept your end of the bargain, I shall keep mine.$B$BJust remember that I''m holding on to the best pieces until your work is finished.'),
(7, 84172, 'Our agreement remains in place.  Just remember, this is but a taste of what awaits you.  Free me of this cursed fate and I will reward you with items of truly great power.'),
(8, 84173, 'Our agreement remains in place.  Just remember, this is but a taste of what awaits you.  Free me of this cursed fate and I will reward you with items of truly great power.'),
(9, 84174, 'Our agreement remains in place.  Just remember, this is but a taste of what awaits you.  Free me of this cursed fate and I will reward you with items of truly great power.'),
(10, 84175, 'Our agreement remains in place.  Just remember, this is but a taste of what awaits you.  Free me of this cursed fate and I will reward you with items of truly great power.'),
(11, 84176, 'Our agreement remains in place.  Just remember, this is but a taste of what awaits you.  Free me of this cursed fate and I will reward you with items of truly great power.'),
(12, 84178, 'Our agreement remains in place.  Just remember, this is but a taste of what awaits you.  Free me of this cursed fate and I will reward you with items of truly great power.'),
(13, 84184, 'I can''t believe our lives are all but forfeit all because of a stupid medallion!  And you''re sure Anthion mentioned Bodley?$B$BWell, you''ve done your job so let''s get your reward out of the way.'),
(14, 84188, 'This curse was bestowed upon us but for a mere medallion.  Lord Valthalak certainly knows how to hold a grudge.$B$BWe''ll endeavor to find the remaining pieces - hopefully before I meet an untimely demise.  But before that, let us see about your reward.'),
(15, 84200, 'I''m going to miss you, $N. I owe you such a debt of gratitude; I think I''ll never be able to repay it.$B$BI hope that you enjoy your new head and chest armor, and that it protects you for a long time to come.');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_offer_reward` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, '2026_11_21_101_world_everlake_tier05_841xx_quests.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 84151, 'Have you brought me what I requested of you, $N?'),
(2, 84152, 'Have you brought me what I requested of you, $N?'),
(3, 84153, 'Have you brought me what I requested of you, $N?'),
(4, 84165, 'You''re ready to perform the trade?'),
(5, 84166, 'You''re ready to perform the trade?'),
(6, 84168, 'You''re ready to perform the trade?'),
(7, 84172, 'You''re ready to perform the exchange?'),
(8, 84173, 'You''re ready to perform the exchange?'),
(9, 84174, 'You''re ready to perform the exchange?'),
(10, 84175, 'You''re ready to perform the exchange?'),
(11, 84176, 'You''re ready to perform the exchange?'),
(12, 84178, 'You''re ready to perform the exchange?'),
(13, 84184, 'You''re back, $N.  You must tell me all about what you''ve found out.  But first let us arrange for your reward.'),
(14, 84188, 'You''ve returned and I see in your eyes that you''ve much to tell me, $N.  Let us take care of your reward first.'),
(15, 84200, 'As per our deal, are you ready to hand over your Shadowcraft pieces in exchange for your new Darkmantle Cap and Tunic?');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_request_items` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, '2026_11_21_101_world_everlake_tier05_841xx_quests.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_addon` (`ID` INT UNSIGNED NOT NULL PRIMARY KEY, `PrevQuestID` INT NOT NULL, `NextQuestID` INT NOT NULL, `AllowableClasses` INT UNSIGNED NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_addon` (`ID`, `PrevQuestID`, `NextQuestID`, `AllowableClasses`) VALUES
(84151, 0, 8922, 16),
(84152, 0, 8922, 8),
(84153, 0, 8922, 256),
(84163, 8977, 8929, 1024),
(84164, 8977, 8929, 4),
(84165, 8977, 8929, 128),
(84166, 8977, 8929, 2),
(84167, 8977, 8929, 16),
(84168, 8977, 8929, 8),
(84169, 8977, 8929, 256),
(84171, 8978, 8930, 1024),
(84172, 8978, 8930, 4),
(84173, 8978, 8930, 128),
(84174, 8978, 8930, 16),
(84175, 8978, 8930, 8),
(84176, 8978, 8930, 64),
(84177, 8978, 8930, 256),
(84178, 8978, 8930, 1),
(84179, 9015, 8960, 1024),
(84180, 9015, 8960, 4),
(84181, 9015, 8960, 128),
(84182, 9015, 8960, 2),
(84183, 9015, 8960, 16),
(84184, 9015, 8960, 8),
(84186, 9015, 8960, 1),
(84187, 9015, 9032, 1024),
(84188, 9015, 9032, 4),
(84189, 9015, 9032, 128),
(84190, 9015, 9032, 16),
(84191, 9015, 9032, 8),
(84192, 9015, 9032, 64),
(84193, 9015, 9032, 256),
(84194, 9015, 9032, 1),
(84195, 8997, 0, 1024),
(84196, 8997, 0, 4),
(84200, 8997, 0, 8),
(84202, 8997, 0, 1),
(84203, 8998, 0, 1024),
(84208, 8998, 0, 64),
(84210, 8998, 0, 1),
(84147, 0, 8922, 1024),
(84148, 0, 8922, 4),
(84149, 0, 8922, 128),
(84150, 0, 8922, 2),
(84154, 0, 8922, 1),
(84155, 0, 8923, 1024),
(84156, 0, 8923, 4),
(84157, 0, 8923, 128),
(84158, 0, 8923, 16),
(84159, 0, 8923, 8),
(84160, 0, 8923, 64),
(84161, 0, 8923, 256),
(84162, 0, 8923, 1),
(84170, 8977, 8929, 1);
UPDATE `everlake_build_addon` s SET s.`missing` = 1 WHERE EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` a WHERE a.`ID` = s.`ID`);
INSERT INTO `quest_template_addon` (`ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID`) SELECT `ID`, `AllowableClasses`, `PrevQuestID`, `NextQuestID` FROM `everlake_build_addon` WHERE `missing` = 1 ORDER BY `ID`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template_addon', `ID`, '2026_11_21_101_world_everlake_tier05_841xx_quests.sql', 'INFERRED: class and chain of the old quest with the same objective items' FROM `everlake_build_addon` WHERE `missing` = 1;
DROP TEMPORARY TABLE `everlake_build_addon`;
-- Anthion Harmon 16016 stops offering the old Anthion's Parting Words (live offers the 841xx ones), only while the quest's
-- ender is still no creature the realm spawns.
DELETE s FROM `creature_queststarter` s WHERE s.`id` = 16016 AND s.`quest` IN (8951, 8952, 8953, 8954, 8955, 8956, 8957, 8958, 8959, 9016, 9017, 9018, 9019, 9020, 9021, 9022)
  AND NOT EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.`id` = e.`id` WHERE e.`quest` = s.`quest`);
COMMIT;
