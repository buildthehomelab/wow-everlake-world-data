-- World build: 21 missing quests from the Icy Veins WoW Forever database
-- 2026_11_20_24_world_everlake_quests_icyveins_c.sql: quest records (title, texts, objectives, rewards, levels, givers and enders) from the Icy Veins catalogue
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
(1, 78093, 277205, 1, 209800, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 209800, 33554432, 0, 0, 0, -141, 6, 1.5, 0, 6130900294268440000, 890, 878, -2, 'Return to Delgren', 'Return the Orb Shards to Delgren.', '<The shattered remains of the orb lay at your feet. Delgren will want to see you have succeeded.>', '', '', 'seen-live: icyveins:catalog'), -- Return to Delgren
(2, 84146, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 35652096, 0, 0, 0, 618, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Red Bag Blues', 'Locate the Red Bag that Nami in Everlook lost in a zeppelin mishap over Burning Steppes.', 'What you want is safely hidden, and I can only hope the same can be said for what I''m looking for.\r\n\r\nI had a red bag containing some valuable tooling that I use for electro-optics. But, I lost it in a zeppelin accident over Burning Steppes! The bag could still be there, but with orcs, ogres, and poachers, I''ve had to put my work on hold.\r\n\r\nIf you can locate it and bring it back to me, I''ll let you have Jurgens'' old book.', '', '', 'seen-live: icyveins:catalog'), -- Red Bag Blues
(3, 84211, 0, 0, 226698, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 226698, 304611840, 0, 0, 0, 46, 5, 1.0, 461322, 18446744073709551615, 890, 878, -2, 'Poacher''s Den', 'Recover the rest of the materials and return to Nami in Everlook.', 'Picking up the bag, you immediately notice it''s nearly empty. Somehow you get the impression Nami wont trade the book for the bag by itself. But what''s not empty, is the camp. You''d better defend yourself and keep your eyes peeled for more of this stuff.', '', '', 'seen-live: icyveins:catalog'), -- Poacher's Den
(4, 84332, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 227935, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, -141, 6, 1.5, 0, 18446744073709551615, 890, 878, -2, 'A Thane''s Gratitude', '', '<You hear a disembodied voice in your head as you touch the small chest> \r\n\r\nCan''t be thankin'' ye enough, $n. Not how ye''d be expecting it to turn out, no doubt! Just so you aren''t too sour about it, I''ve got something for ye that I''ve no more use for that I think ye might find useful.\r\n\r\nGood luck to ye, $n. Ah, one last thing... if ye happen to see a giant floating necropolis in the distance someday soon, I''d be turnin'' tail and runnin'' if I were ye. Hah!', '', '', 'seen-live: icyveins:catalog'), -- A Thane's Gratitude
(5, 86611, 0, 0, 277973, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 277973, 36700160, 0, 0, 0, 361, 3, 1.0, 0, 6130900294268440000, 890, 878, -2, 'Stag Lord''s Bauble', 'Take the Stag Lord''s Bauble to someone in Talonbranch Glade who may know about it.', '<The pool of fetid slime has eroded the statue of the stag. It is unclear how it arrived here at the bottom of the lake.\r\n\r\nA single crystal stone set in a medallion around its neck bears an unwholesome green gleam. It is worth taking to someone who might know the history of this monument.>', '', '', 'seen-live: icyveins:catalog'), -- Stag Lord's Bauble
(6, 86612, 0, 0, 277973, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 277973, 36700160, 0, 0, 0, 361, 3, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Stag Lord''s Bauble', 'Take the Stag Lord''s Bauble to someone in Bloodvenom Post who may know about it.', '<The pool of fetid slime has eroded the statue of the stag. It is unclear how it arrived here at the bottom of the lake.\r\n\r\nA single crystal stone set in a medallion around its neck bears an unwholesome green gleam. It is worth taking to someone who might know the history of this monument.>', '', '', 'seen-live: icyveins:catalog'), -- Stag Lord's Bauble
(7, 86926, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 576, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700424, 0, 0, 0, 16, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Felfire Burn, Cauldron Bubble', 'Bring 5 Satyrweed and a Fel Mote to the Legashi Cauldron in the Legashi Encampment.', 'The recipe reads:\r\n\r\nHarvest ye the sprout of hell\r\nbushel o'' five will serve ye well\r\nmixed with mote of demon''s power\r\nshall usher in their final hour', '', '', 'seen-live: icyveins:catalog'), -- Felfire Burn, Cauldron Bubble
(8, 86927, 236754, 1, 235472, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 576, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 235472, 36700160, 0, 0, 0, 16, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Running Firewater', 'Bring the Legashi Firewater to Elder Bramblesnap at Ursolan.', 'As the satyrweed and fel mote splash into the boiling liquid, a plume of noxious gas emerges.\r\n\r\nBest to hold your nose, quickly grab a sample, and bring it back to Elder Bramblesnap.', '', '', 'seen-live: icyveins:catalog'), -- Running Firewater
(9, 89470, 0, 0, 239609, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 69, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 239609, 36700160, 0, 0, 0, 16, 3, 1.0, 0, 6130900294268440000, 890, 878, -2, 'Ill Tidings', 'Bring Saria''s Knapsack back to Commander Truesong at Talrendis Point.', '<With Saria''s true intentions revealed, and a bag of powerful artifacts in hand, perhaps now would be a good time give Commander Truesong her report.>', '', '', 'seen-live: icyveins:catalog'), -- Ill Tidings
(10, 93127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 275666, 1, 275668, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 8, 0, 0, 0, 616, 4, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Summit Sentries', 'Reactivate the sentinel stones north, west, and south around the Blackthorne cultists.', 'The Wild King may have a numbers advantage, but we can outmaneuver him with tactics.\r\n\r\nEmpower our living sentinel stones across the encircling hills, they can track Blackthorne movements for us. The northern ridges, the southern slopes, and the western high ground all have drained stones that will activate upon detecting your allied presence.\r\n\r\nTread carefully as you work, Blackthorne patrols crowd these paths, and their presence is precisely why we must bring this land under vigilant surveillance.', '', '', 'seen-live: icyveins:catalog'), -- Summit Sentries
(11, 93161, 282315, 1, 272313, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 272313, 2097152, 0, 0, 0, 16593, 0, 1.0, 0, 18446744073709551615, 890, 878, 0, 'The Ancient Hilt', 'Find someone who would be interested in the Ancient Hilt you found in the ruins of Ban''aethal.', 'In the faint illumination of your torchlight, you can make out a small glint of metal. Upon further inspection, it''s clear that this is the broken hilt of an ancient sword.\r\n\r\nDespite missing a blade, you can clearly see that this hilt is a product of masterful workmanship. This is a precious heirloom, and there may be those who are interested to learn more about this.', '', '', 'seen-live: icyveins:catalog'), -- The Ancient Hilt
(12, 93547, 275649, 1, 259268, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 259268, 36700160, 0, 0, 0, 616, 2, 1.0, 0, 18446744073709551615, 890, 878, -2, 'A Thorny Solution', 'Plant thorn seeds near the inn, the storage tower, and the grouping of trees at the loyalist druid camp.', 'We are constantly under threat here, both by the Blackthorne Pact and by the hostile creatures of Hyjal. But we can use the thorns to our advantage! With a little help from the power of nature, we can grow new thorn bushes to help protect our enclosure.\r\n\r\nPlant thorn seeds near the road to help create barricades by the inn, the storage tower, and the grouping of trees near the road.', '', '', 'seen-live: icyveins:catalog'), -- A Thorny Solution
(13, 93828, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2747, 0, 32500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 4194568, 8192, 0, 0, 616, 3, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Herbs of the Hollow', 'Collect 10 Dried Hanging Herbs from around Barkskin Burrow and return them to Fennar Mossmane.', 'The mountain''s breath is damp here by the spring, and my herbs will not dry in this thick air. When our kin return from the wild, they hang their packs wherever the roots allow good air, spread through the den.\r\n\r\nGo now. Find the strands of dried herbs hung round our home and bring them to me. With them, I will weave wraps and wards to keep our spirits strong.', '', '', 'seen-live: icyveins:catalog'), -- Herbs of the Hollow
(14, 94829, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2826, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36831240, 0, 0, 0, 16591, 4, 1.0, 0, 6130900294268440000, 890, 878, -2, 'What We Lost', 'Collect 5 Farmers'' Mementos from Twilight Raiders and place them on the graves west of Elbrim''s Farm.', 'If you''ve come to demand more of our crop, you''re too late. No doubt you saw my farm. Destroyed. All of it.\r\n\r\nGood folk toiled in these fields for years to feed troops and civilians alike. But when those cultists arrived, where was the military? Where was our promised protection after all the rations they''d taken from us?\r\n\r\nIf you''ve any sense of decency, I beg you. The least we can do is recover their belongings from those cursed raiders. Let my people rest with their kin in the graveyard to the west.', '', '', 'seen-live: icyveins:catalog'), -- What We Lost
(15, 94843, 0, 0, 266161, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2826, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 266161, 3145984, 0, 0, 0, 16591, 4, 1.0, 0, 6130900294268440000, 890, 878, -2, 'From Seed to Sprout', 'Plant 5 saplings around the lumber camp with Halligan Turner''s tree sprouting kit.', 'Considering you got yourself wrist-deep in guts and manure for us, it''s only right you get to do the fun part too.\r\n\r\nThe boys and I gather seeds from the trees as we work. With the fertilizer you''ve provided, I''ve made a planting kit to put them in the ground to grow new saplings.\r\n\r\nTake it, and find some good planting spots around the work sites.', '', '', 'seen-live: icyveins:catalog'), -- From Seed to Sprout
(16, 95165, 0, 0, 268505, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2827, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 268505, 36700160, 0, 0, 0, 16591, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'See Ya, Scallywags!', 'Plant a remote explosive charge on each of the Eastsea''s three boats.', 'So, here''s how we''re gonna sink those ships. \r\n\r\nI can use that gunpowder you stole and make timed charges. All you''ve gotta do is hop on each of the Eastsea''s boats, and plant one charge in the hull of each. Look for a spot near their cannons, that gunpowder''ll make our explosives even more powerful. Once the charges are set, get outta there, and I''ll hit the detonator!\r\n\r\nThe elegance of the plan is in its simplicity, don''t ya think?', '', '', 'seen-live: icyveins:catalog'), -- See Ya, Scallywags!
(17, 95599, 0, 0, 287992, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 287992, 33554432, 0, 0, 0, 357, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'The Old Key', 'Find the old chest that the key belongs to nearby in Feralas.', '<The key is covered in a thick layer of rust, suggesting that the key has been underwater for a significant amount of time.\r\n\r\nThere must be a matching lock somewhere nearby to use it on but you''ll have to search for it. Perhaps the pool of water to the southwest of this camp might be a good place to start?>', '', '', 'seen-live: icyveins:catalog'), -- The Old Key
(18, 96296, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700168, 0, 0, 0, 616, 4, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Fetid Corruption', 'Find and remove 6 Corrupted Knots from the trees nearby.', '<The second you near the pulsing nodule it falls from the tree, exposing a weeping green sap. It seems the tree has corruption within its bark that has spread deep, but the tree is not yet dead.\r\n\r\nLooking around it is clear it has spread to some of the surrounding trees, but not all suffer from the same level of corruption.\r\n\r\nPerhaps it is not too late to save the infected trees nearby.\r\n\r\nSurely the Highfeathers would be grateful if you remove as many corrupted knots as you can find.>', '', '', 'seen-live: icyveins:catalog'), -- Fetid Corruption
(19, 96561, 0, 0, 274795, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 274795, 35651584, 0, 0, 0, 616, 3, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Last Wishes', 'Find the fishing pond near the destroyed Alliance lumbermill in the Cradle of Tranquility.', '<You unfold the simple parchment.>\r\n\r\nTo my Rowdy Redridge Rebels,\r\n\r\nThe lumberjacks here say the gulpers in that pond are biting like they''re racing each other to the bait. Good fish, better eating. After this war is over, we''re due an angling competition between friends.\r\n\r\nThe setting is simple: we stand on the center island and fish till the sun slips behind Hyjal''s highest peak.\r\n\r\nWhoever catches the most, doesn''t have to gut ''em for our dinner!\r\n\r\n-- Tobin --', '', '', 'seen-live: icyveins:catalog'), -- Last Wishes
(20, 96959, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 35651592, 0, 0, 0, 616, 3, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Blademaster''s Bonfires', 'Light the two bonfires in Dae''gun and return to Yashiro.', 'War.\r\n\r\nBy the time I heeded the call of our clans, the battle had passed, and only ashes answered my blade.\r\n\r\nMy purpose is forged anew.\r\n\r\nThis mountain remembers strength--ancient power riding its winds and holding its water. I would earn the right to walk its spine, to reach the fallen stronghold that lies upon the road to the summit.\r\n\r\nDemons profane these graves. Before I fight at your side, I must know you stand capable. Light the two bonfires and return to me. Their flames draw our enemy out.', '', '', 'seen-live: icyveins:catalog'), -- Blademaster's Bonfires
(21, 97270, 0, 0, 277556, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 41, 0, 277556, 0, 1, 0, 0, 3217, 1, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Brawl at the Maul', 'Speak with Griniblix the Spectator above the Maul in Dire Maul.', 'There must be more to the Maul than this!$B$BPerhaps the loud Spectator who oversees the event at Dire Maul will know!', '', '', 'seen-live: icyveins:catalog'); -- Brawl at the Maul
CREATE TEMPORARY TABLE `everlake_build_objectives` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY, `taken` TINYINT NOT NULL DEFAULT 0) SELECT `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description` FROM `quest_objectives` WHERE 0;
INSERT INTO `everlake_build_objectives` (`n`, `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`) VALUES
(1, 443908, 78093, 1, 0, 0, 209800, 1, 32, ''),
(2, 452110, 84211, 1, 0, 0, 226698, 5, 32, ''),
(3, 452159, 84211, 1, 1, 1, 226699, 5, 32, ''),
(4, 475841, 86611, 1, 0, 0, 277973, 1, 32, ''),
(5, 475842, 86612, 1, 0, 0, 277973, 1, 32, ''),
(6, 457572, 86926, 1, 0, 1, 235470, 5, 32, ''),
(7, 457573, 86926, 1, 1, 2, 235471, 1, 32, ''),
(8, 457578, 86927, 1, 0, 0, 235472, 1, 32, ''),
(9, 460645, 89470, 1, 0, 0, 239609, 1, 32, ''),
(10, 472769, 93127, 2, 0, 1, 651979, 1, 32, 'Northern Sentinel Stone empowered'),
(11, 472770, 93127, 2, 1, 2, 651987, 1, 32, 'Western Sentinel Stone empowered'),
(12, 472771, 93127, 2, 2, 3, 651986, 1, 32, 'Southern Sentinel Stone empowered'),
(13, 472389, 93161, 1, 0, 0, 272313, 1, 32, ''),
(14, 466733, 93547, 2, 0, 0, 613773, 1, 32, 'Thorn seed planted near inn'),
(15, 475072, 93547, 2, 1, 1, 659199, 1, 32, 'Thorn seed planted near storage tower'),
(16, 475073, 93547, 2, 2, 2, 659200, 1, 32, 'Thorn seed planted near group of trees'),
(17, 467540, 93828, 2, 0, 2, 617129, 10, 32, ''),
(18, 476247, 94829, 1, 0, 1, 266148, 5, 60, ''),
(19, 469212, 94829, 2, 1, 0, 621813, 5, 32, 'Mementos buried'),
(20, 469232, 94843, 2, 0, 1, 621767, 5, 32, 'Sapling planted'),
(21, 470322, 94843, 1, 1, 0, 266161, 1, 32, ''),
(22, 470100, 95165, 2, 0, 1, 629425, 1, 32, 'First Ship Charge planted'),
(23, 470101, 95165, 2, 1, 2, 629426, 1, 32, 'Second Ship Charge planted'),
(24, 470102, 95165, 2, 2, 3, 629427, 1, 32, 'Third Ship Charge planted'),
(25, 473166, 95165, 1, 3, 0, 268505, 1, 32, ''),
(26, 480314, 95599, 1, 0, 0, 287992, 1, 32, ''),
(27, 472745, 96296, 2, 0, 1, 651430, 6, 32, ''),
(28, 473578, 96561, 1, 0, 0, 274795, 1, 32, ''),
(29, 473579, 96561, 1, 1, 1, 274800, 1, 32, ''),
(30, 474601, 96959, 2, 0, 2, 656668, 1, 32, 'South Bonfire lit'),
(31, 474648, 96959, 2, 1, 0, 656669, 1, 32, 'Southeast Bonfire lit');
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.`ID` = p.`ID`) OR EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'quest_objectives' AND r.`k1` = p.`ID`);
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE (p.`Type` IN (0, 3) AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = p.`ObjectID`)) OR (p.`Type` = 2 AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = p.`ObjectID`));
UPDATE `everlake_build_quests` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `quest_template` t WHERE t.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` IN ('quest_template', 'quest_classic_level', 'quest_template_classic_level', 'quest_classic_money', 'quest_template_addon') AND r.`k1` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_objectives` c WHERE c.`QuestID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_money` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_build_objectives` p WHERE p.`QuestID` = s.`ID` AND p.`taken` = 1);
INSERT INTO `quest_template` (`ID`, `RewardItem1`, `RewardAmount1`, `ItemDrop1`, `ItemDropQuantity1`, `RewardItem2`, `RewardAmount2`, `ItemDrop2`, `ItemDropQuantity2`, `RewardItem3`, `RewardAmount3`, `ItemDrop3`, `ItemDropQuantity3`, `RewardItem4`, `RewardAmount4`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `QuestType`, `QuestInfoID`, `RewardNextQuest`, `StartItem`, `Flags`, `FlagsEx`, `FlagsEx2`, `TimeAllowed`, `QuestSortID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardSpell`, `AllowableRaces`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`) SELECT s.`ID`, s.`RewardItem1`, s.`RewardAmount1`, s.`ItemDrop1`, s.`ItemDropQuantity1`, s.`RewardItem2`, s.`RewardAmount2`, s.`ItemDrop2`, s.`ItemDropQuantity2`, s.`RewardItem3`, s.`RewardAmount3`, s.`ItemDrop3`, s.`ItemDropQuantity3`, s.`RewardItem4`, s.`RewardAmount4`, s.`ItemDrop4`, s.`ItemDropQuantity4`, s.`RewardChoiceItemID1`, s.`RewardChoiceItemQuantity1`, s.`RewardChoiceItemID2`, s.`RewardChoiceItemQuantity2`, s.`RewardChoiceItemID3`, s.`RewardChoiceItemQuantity3`, s.`RewardChoiceItemID4`, s.`RewardChoiceItemQuantity4`, s.`RewardChoiceItemID5`, s.`RewardChoiceItemQuantity5`, s.`RewardChoiceItemID6`, s.`RewardChoiceItemQuantity6`, s.`RewardFactionID1`, s.`RewardFactionValue1`, s.`RewardFactionOverride1`, s.`RewardFactionCapIn1`, s.`RewardFactionID2`, s.`RewardFactionValue2`, s.`RewardFactionOverride2`, s.`RewardFactionCapIn2`, s.`RewardFactionID3`, s.`RewardFactionValue3`, s.`RewardFactionOverride3`, s.`RewardFactionCapIn3`, s.`RewardFactionID4`, s.`RewardFactionValue4`, s.`RewardFactionOverride4`, s.`RewardFactionCapIn4`, s.`RewardFactionID5`, s.`RewardFactionValue5`, s.`RewardFactionOverride5`, s.`RewardFactionCapIn5`, s.`RewardCurrencyID1`, s.`RewardCurrencyQty1`, s.`RewardCurrencyID2`, s.`RewardCurrencyQty2`, s.`RewardCurrencyID3`, s.`RewardCurrencyQty3`, s.`RewardCurrencyID4`, s.`RewardCurrencyQty4`, s.`QuestType`, s.`QuestInfoID`, s.`RewardNextQuest`, s.`StartItem`, s.`Flags`, s.`FlagsEx`, s.`FlagsEx2`, s.`TimeAllowed`, s.`QuestSortID`, s.`RewardXPDifficulty`, s.`RewardXPMultiplier`, s.`RewardSpell`, s.`AllowableRaces`, s.`AcceptedSoundKitID`, s.`CompleteSoundKitID`, s.`Expansion`, s.`LogTitle`, s.`LogDescription`, s.`QuestDescription`, s.`AreaDescription`, s.`QuestCompletionLog`, 0 FROM `everlake_build_quests` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', s.`ID`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', s.`note` FROM `everlake_build_quests` s WHERE s.`missing` = 1;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`) SELECT p.`ID`, p.`QuestID`, p.`Type`, p.`Order`, p.`StorageIndex`, p.`ObjectID`, p.`Amount`, p.`Flags`, p.`Description`, 0 FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', p.`ID`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', s.`note` FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_objectives`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `QuestLevel`, `MinLevel`, `MaxLevel` FROM `quest_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) VALUES
(1, 78093, 30, 22, 0),
(2, 84146, 60, 55, 0),
(3, 84211, 60, 58, 0),
(4, 84332, 59, 54, 0),
(5, 86611, 55, 48, 0),
(6, 86612, 55, 48, 0),
(7, 86926, 53, 47, 0),
(8, 86927, 53, 47, 0),
(9, 89470, 55, 47, 0),
(10, 93127, 60, 54, 0),
(11, 93161, 60, 1, 0),
(12, 93547, 60, 57, 0),
(13, 93828, 57, 54, 0),
(14, 94829, 40, 36, 0),
(15, 94843, 38, 36, 0),
(16, 95165, 44, 38, 0),
(17, 95599, 42, 35, 0),
(18, 96296, 58, 55, 0),
(19, 96561, 60, 56, 0),
(20, 96959, 59, 56, 0),
(21, 97270, 60, 55, 0);
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT p.`ID`, p.`QuestLevel`, p.`MinLevel`, p.`MaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_level', p.`ID`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `LevelType`, `QuestLevel` FROM `quest_template_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `LevelType`, `QuestLevel`) VALUES
(1, 78093, 2, 30),
(2, 84146, 2, 60),
(3, 84211, 2, 60),
(4, 84332, 2, 59),
(5, 86611, 2, 55),
(6, 86612, 2, 55),
(7, 86926, 2, 53),
(8, 86927, 2, 53),
(9, 89470, 2, 55),
(10, 93127, 2, 60),
(11, 93161, 2, 60),
(12, 93547, 2, 60),
(13, 93828, 2, 57),
(14, 94829, 2, 40),
(15, 94843, 2, 38),
(16, 95165, 2, 44),
(17, 95599, 2, 42),
(18, 96296, 2, 58),
(19, 96561, 2, 60),
(20, 96959, 2, 59),
(21, 97270, 2, 60);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT p.`ID`, p.`LevelType`, p.`QuestLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_template_classic_level', p.`ID`, p.`LevelType`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `RewardMoney`, `RewardMoneyMaxLevel` FROM `quest_classic_money` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `RewardMoney`, `RewardMoneyMaxLevel`) VALUES
(1, 78093, 2500, 0),
(2, 86611, 4000, 0),
(3, 86612, 4000, 0),
(4, 86926, 11156, 0),
(5, 89470, 8500, 0),
(6, 93547, 2300, 0),
(7, 95599, 5500, 0),
(8, 96296, 12788, 0);
INSERT INTO `quest_classic_money` (`ID`, `RewardMoney`, `RewardMoneyMaxLevel`) SELECT p.`ID`, p.`RewardMoney`, p.`RewardMoneyMaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_money', p.`ID`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
DROP TEMPORARY TABLE `everlake_build_quests`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 228216, 84146, 'seen-live: icyveins:addon'),
(2, 40833, 93127, 'seen-live: icyveins:addon'),
(3, 40833, 93547, 'seen-live: icyveins:addon'),
(4, 256626, 93828, 'seen-live: icyveins:addon'),
(5, 258697, 94829, 'seen-live: icyveins:addon'),
(6, 256438, 94843, 'seen-live: icyveins:addon'),
(7, 259961, 95165, 'seen-live: icyveins:addon'),
(8, 267121, 96959, 'seen-live: icyveins:addon');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', s.`id`, s.`quest`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 3663, 78093, 'seen-live: icyveins:addon'),
(2, 228216, 84211, 'seen-live: icyveins:addon'),
(3, 9465, 86611, 'seen-live: icyveins:addon'),
(4, 9996, 86612, 'seen-live: icyveins:addon'),
(5, 235906, 86927, 'seen-live: icyveins:addon'),
(6, 239822, 89470, 'seen-live: icyveins:addon'),
(7, 40833, 93127, 'seen-live: icyveins:addon'),
(8, 259012, 93161, 'seen-live: icyveins:addon'),
(9, 40833, 93547, 'seen-live: icyveins:addon'),
(10, 256626, 93828, 'seen-live: icyveins:addon'),
(11, 258697, 94829, 'seen-live: icyveins:addon'),
(12, 256438, 94843, 'seen-live: icyveins:addon'),
(13, 259961, 95165, 'seen-live: icyveins:addon'),
(14, 260825, 96296, 'seen-live: icyveins:addon'),
(15, 267121, 96959, 'seen-live: icyveins:addon'),
(16, 14395, 97270, 'seen-live: icyveins:addon');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_questender' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', s.`id`, s.`quest`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 409315, 78093, 'seen-live: icyveins:addon'),
(2, 457056, 84211, 'seen-live: icyveins:addon'),
(3, 462236, 84332, 'seen-live: icyveins:addon'),
(4, 661778, 86611, 'seen-live: icyveins:addon'),
(5, 661778, 86612, 'seen-live: icyveins:addon'),
(6, 506307, 86926, 'seen-live: icyveins:addon'),
(7, 506307, 86927, 'seen-live: icyveins:addon'),
(8, 527828, 89470, 'seen-live: icyveins:addon'),
(9, 676059, 93161, 'seen-live: icyveins:addon'),
(10, 651409, 96296, 'seen-live: icyveins:addon');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `gameobject_queststarter` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `gameobject_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `gameobject_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'gameobject_queststarter', s.`id`, s.`quest`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 457056, 84146, 'seen-live: icyveins:addon'),
(2, 462236, 84332, 'seen-live: icyveins:addon'),
(3, 506307, 86926, 'seen-live: icyveins:addon'),
(4, 642451, 95599, 'seen-live: icyveins:addon'),
(5, 654150, 96561, 'seen-live: icyveins:addon');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `gameobject_questender` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject_questender' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `gameobject_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `gameobject_questender` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'gameobject_questender', s.`id`, s.`quest`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 78093, 'This is a relief, $N. But whatever was watching Azeroth through that orb... I have a feeling they will not be happy it was destroyed.$B$BTake this as my thanks for your efforts. And... be careful.'),
(2, 84146, 'You find the Red Bag laying on the table in a simple, carefree way.'),
(3, 84211, 'Well, you turned out to be quite resourceful! These materials are irreplaceable to me. I can''t thank you enough! Here, like I promised you, is the book Jurgens wants back. $B$BPlease, take this hot beverage with you before leaving, it''s cold out there.'),
(4, 84332, 'Even the chest reeks of necromantic energy...'),
(5, 86611, 'I recognize this crystal! The statue of Malorne once decorated his shrine, but the demons must have thrown it off the side of the mountain during the war.$B$BThis is unfortunate; the crystal has absorbed fel energy and now it holds a measure of unwholesome power. I am afraid I must destroy it.$B$BThank you for bringing this to me.'),
(6, 86612, 'Fascinating! This gem has absorbed some measure of the fel power contained in the cursed waters flowing down into Felwood. More research is needed, but perhaps I can coax... something... from it. If it was a sacred artifact that predated the war, it may have power of its own, and combined with the demon-taint, it shows promise.$B$BWell done, $C!'),
(7, 86926, 'You have everything you need, now all that''s left is to brew the firewater.'),
(8, 86927, 'Excellent! Now the real work can begin.'),
(9, 89470, '<You recount your time assisting Saria to the commander, and tell her who, or rather what, Saria really was.>$B$BThis is most troubling. Lady Vashj is a name I''d never expect to hear again. An envoy will be sent to Darnassus to report this incident immediately. You may have handled the situation for now, but I fear this carries greater implications.$B$BOn the bright side, the artifacts you''ve recovered are of tremendous value to the kaldorei. You have done well by us, $N. Take pride in that.'),
(10, 93127, 'Well done. Your ability to slip through their encampments and enable our sentry stones to establish their bond with our sentinel''s sight is a considerable boon to our efforts, $N.'),
(11, 93161, 'This item is valuable to my people beyond words. This sword was forged by the legendary magesmith, Luminarian. $B$BLuminarian accompanied our people when we fled from Kalimdor and went on to continue his work in the Skyborne Isles for centuries. Many of the weapons and armor you see wielded on Zephras today are fashioned in the style of his incredible work.$B$BThe blade is broken and its magic spent, but not beyond repair. Take it. Find someone who knows more of Luminarian''s works. Perhaps they can help.'),
(12, 93547, 'The brambles become our protectors now. Predators know to shy away from the thorns, and we can sleep a little easier.'),
(13, 93828, 'These herbs are prime, dry--time to grind to dust.'),
(14, 94829, 'It won''t bring these folks back, but it does my heart good to know their souls are put to rest.'),
(15, 94843, 'Nothing like a hard day''s work, eh $N? Good on you for helping out.'),
(16, 95165, 'Look at you, still got all your fingers and both your eyebrows! Er...not that I ever doubted my handiwork, of course.$B$BThink I''ll pull up a chair and watch the fireworks show. Good goin'' out there.'),
(17, 95599, '<The key fits perfectly in the old lock.$B$BWith some muscle, you manage to turn the rusted iron. It clicks open with a resounding thud.$B$BThe water around you shudders. Something is angered by your presence.>'),
(18, 96296, '<Phoebe cringes as you show her the corrupted knots from the nearby trees.>$B$BThis is far worse than I was hoping. With the Wormwings taking over, the infection has spread much faster than previously. My sisters and matrons were originally the ones overseeing the removal of it.$B$BRemoving these corrupted knots will not completely fix the problem, but is akin to lancing an infected wound. It will help, even if only a little.$B$BThank you for taking the time to care for my home, $C.'),
(19, 96561, '<Being the only possession you know for sure belonged to the war veteran, you take the Embroidered Scabbard from your bags. You place it--with Tobin''s note--inside the broken fishing basket.$B$BStanding, you listen to the waterfall feeding the pond nearby.$B$BSeveral fish suddenly jump and make multiple splashes as you survey the water.>'),
(20, 96959, 'The demon commanders will be drawn out by the smell of these bonfires being lit anew.$B$BThis is our chance to end their reign.');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_offer_reward` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 78093, 'Did you find a way to destroy the orb?'),
(2, 84211, 'Have you found the red bag yet? I need that stuff back if I''m going to finish these telescope upgrades in time for meteorite season!'),
(3, 86611, 'What is that?'),
(4, 86612, 'What is that?'),
(5, 86926, 'The cauldron bubbles fiercely, awaiting the ingredients.'),
(6, 86927, 'Ah, you''ve returned. Have you obtained any firewater?'),
(7, 89470, 'What is it, $N? You look worried.'),
(8, 93127, 'He who controls the land has a solid foundation. She who controls the sky commands the perspective.'),
(9, 93161, 'Wait... what is that you have there? Could it be?'),
(10, 94829, 'Every minute those Twilight Raiders defile my home is an insult to its memory. Get rid of them, and take back what is ours.'),
(11, 94843, 'We grow ''em up, cut ''em down, and grow ''em back up again. It''s a beautiful cycle.'),
(12, 95165, 'You may be wondering: What''s a little ol'' wharfmaster know about homemade explosives?$B$BLet''s just say... I used to make a less honest living.'),
(13, 95599, '<The old chest is waterlogged. Despite this, it appears to be made of strong timber.>'),
(14, 96561, '<The old fishmonger''s basket is shattered beyond repair.>');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_request_items` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, '2026_11_20_24_world_everlake_quests_icyveins_c.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
COMMIT;
