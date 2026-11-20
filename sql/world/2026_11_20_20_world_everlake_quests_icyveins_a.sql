-- World build: 25 missing quests from the Icy Veins WoW Forever database
-- 2026_11_20_20_world_everlake_quests_icyveins_a.sql: quest records (title, texts, objectives, rewards, levels, givers and enders) from the Icy Veins catalogue
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
(1, 84394, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 281637, 1, 281636, 1, 277202, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 33554688, 0, 0, 0, -284, 1, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Greater Friend of the Library', '', '', '', '', 'seen-live: icyveins:catalog'), -- Greater Friend of the Library
(2, 88757, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 36700168, 0, 0, 0, 11, 5, 1.0, 0, 6130900294268440000, 890, 878, -2, 'Accessories of the Lost', 'Bring back Essene''s Necklace, Essene''s Spellbook, and Essene''s Waterskin.', 'While I was fleeing from those Dark Irons, I wound up dropping lots of my gear!\r\n\r\nIt looks like I lost... my green leather waterskin, my spellbook, my necklace, and... well I need these things!\r\n\r\nIf you can find them while I repack and catch my breath, that would be a great help.', '', '', 'seen-live: icyveins:catalog'), -- Accessories of the Lost
(3, 88813, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 260208, 1, 260209, 1, 0, 0, 0, 0, 0, 0, 0, 0, 69, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700168, 0, 0, 0, 16, 5, 1.0, 0, 6130900294268440000, 890, 878, -2, 'The Head of the Serpent', 'Bring Warlord Krellian''s head to Commander Truesong in Azshara.', 'Your final target is Warlord Krellian, the leader of the Spitelash. He cowers behind his guards in the Temple of Zin-Malor in the ruins of Eldarath.\r\n\r\nCut off Krelian''s head, and his minions will be slithering back to the sea in fear. Then, finally, Azshara will belong to Kaldorei once again.', '', '', 'seen-live: icyveins:catalog'), -- The Head of the Serpent
(4, 92343, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 81, 0, 15000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 36700424, 0, 0, 0, 16554, 5, 2.0, 0, 12261800583900083616, 890, 878, -2, 'Get to the Roots of It', 'Gather 10 Nordrassil Root Caps inside Blackmaw Hold for Nara Wildmane in Thunder Bluff.', 'The burrow you speak of is a tunnel to Blackmaw Hold. In the past, the furbolg have guarded it fiercely, making it inaccessible to outsiders. With this satyr situation, however, we can get inside.\r\n\r\nSo close to Nordrassil, there would be actively growing roots. Older roots can be seen on the world''s surface, but newer ones can only be found deep underground. Little is known of their magical properties.\r\n\r\nIf you were to bring me some samples to study, the druids of Thunder Bluff would be in your debt.', '', '', 'seen-live: icyveins:catalog'), -- Get to the Roots of It
(5, 92707, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 45, 6, 1.0, 0, 12261800583900083616, 890, 878, -2, 'The Giant in the Den', 'Bring the Goliath''s Wristguards to Drum Fel in Hammerfall.', 'Wrenched from its hulking corpse, the goliath''s bracers are massive. Your whole arm, up to the shoulder, can fit through one without touching the sides.\r\n\r\nYou should bring these back to Hammerfall, as a warning. Drum Fel ought to know what he''s up against.', '', '', 'seen-live: icyveins:catalog'), -- The Giant in the Den
(6, 93176, 280456, 1, 213565, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 213565, 36700160, 0, 0, 0, 8, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'My Little Friends', 'Use the items contained in the Entomology Starter Kit to find and catch an Arbor Tarantula, Hay Weevil Specimen, and a Flesh Picker.', 'Admiring my little menagerie, are you? They are my un-life''s work. I''ve spent countless hours studying them: their anatomy, their diets, even their social rituals.\r\n\r\nDo you wish to join me in the hobby? Here, take this package. The notes and materials contained within should get you started. If you lose it, you''ll have to purchase another one from me for a small fee.', '', '', 'seen-live: icyveins:catalog'), -- My Little Friends
(7, 93450, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700168, 0, 0, 0, 16651, 2, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Phantasmal Problems', 'Take Vindael''s unfinished sword and figure out a way to usher it into the spirit realm, then return the Phantasmal Blade to him at Shen''dralas.', 'Being corporeal has its challenges, as you know, but being INcorporeal is a whole other situation. Will I fall through THIS chair? Will I trip over THAT cat? Worst of all, however, it makes everyday work impossible!\r\n\r\nDo you see this sword on my anvil? I began work on this thousands of years ago, but met my demise before it was finished. Now it taunts me, AND takes up precious real estate! I cannot work with it! I cannot MOVE it!\r\n\r\nI need you to help, uh, "ferry" it to the spirit realm. What do you say?', '', '', 'seen-live: icyveins:catalog'), -- Phantasmal Problems
(8, 93546, 0, 0, 259229, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 259229, 36700160, 0, 0, 0, 16651, 4, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Spectral Iron Ore', 'Search for Spectral Iron Deposits around Shen''dralas and collect 10 Spectral Iron Ore. Return to Vindael in Shen''dralas once you have found enough.', 'Finally, FINALLY I can use this anvil for something other than a monumentally heavy table. I am delighted to finally hone my craft again after centuries of missed practice.\r\n\r\nNow, you are probably thinking, "Vindael, this sounds like you are setting the stage for another request." And you would be correct!\r\n\r\nI need to replenish my supply of iron, but your iron has a similar predicament to my blade. Fortunately, the solution is MUCH simpler.\r\n\r\n<He hands you a ghostly pickaxe, without a chance to refuse.>', '', '', 'seen-live: icyveins:catalog'), -- Spectral Iron Ore
(9, 93609, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 272184, 1, 272185, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700160, 0, 0, 0, 16651, 6, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Forlorn Necklace', 'Bring the Forlorn Necklace to Mithera at the temple of Shen''dralas in the Desolace.', '<The necklace you have been seeking is at last in your possession, but unfortunately the magic contained within has been entirely depleted. While not ideal for your current situation, at least it made its acquisition from the quilboar relatively easy.\r\n\r\nIt is probably best to bring this back to Mithera.>', '', '', 'seen-live: icyveins:catalog'), -- Forlorn Necklace
(10, 93825, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2747, 0, 32500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 8, 0, 0, 0, 616, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Barkbound Blessings', 'Gather 12 clumps of Moonveil Moss and return to Suma Mossmane.', 'You wish to learn from us? The trees of Hyjal speak to us. Their bark holds life, and on it grows the moss we call Moonveil. It is soft, green, and strong with the mountain''s soul. We need this moss to heal our hurt and bless roots.\r\n\r\nGo, gentle one. Seek the old trees where the mist clings and the sun hides. Take Moonveil moss from their bark and bring it back to me. With it, we will mend what pains us.', '', '', 'seen-live: icyveins:catalog'), -- Barkbound Blessings
(11, 93831, 267341, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2747, 0, 20000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 33554440, 0, 0, 0, 616, 4, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Sweetpaw Jam', 'Gather 30 Bear Berries from Hyjal and return to Osi Mistpaw.', 'You smell like mountain winds, strong and free! I have a task, if your paws are not full.\r\n\r\nWe love bear berries, they''re round, red, and sweet as honey after frost. Look for them near the shade of trees. Too many sharp rocks and mad wings for us to get the ripest bush.\r\n\r\nBring me a bunch, and I make Sweetpaw Jam! My best treat, and I will share a taste.\r\n\r\nDeal?', '', '', 'seen-live: icyveins:catalog'), -- Sweetpaw Jam
(12, 93834, 18253, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2747, 0, 32500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 8, 0, 0, 0, 616, 3, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Burrow Beetles', 'Gather 10 Burrow Beetle Bits for Dala Fairmaw.', 'Burrow beetles! They''re a bane... and now they dig in our den more than their own. We beat them back and swing clubs when we see them skulk by, but they are quick, and to hide in the dark is their shield.\r\n\r\nIf you spot them as you climb our den, squash them! We will take their crushed shells and make a meal, so it is not all bad.', '', '', 'seen-live: icyveins:catalog'), -- Burrow Beetles
(13, 94223, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2586, 0, 7500, 7, 2587, 0, 7500, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 3149824, 33281, 268435456, 0, 16941, 0, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Craftsman''s Writ: Silver Skeleton Key', 'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.', '<Penned in faded ink, the note is requesting 1 Silver Skeleton Key, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>', '', '', 'seen-live: icyveins:catalog'), -- Craftsman's Writ: Silver Skeleton Key
(14, 94336, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2586, 0, 20000, 7, 2587, 0, 20000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 3149824, 33281, 268435456, 0, 16941, 0, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Craftsman''s Writ: Lifelike Mechanical Toad', 'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.', '<Penned in faded ink, the note is requesting 1 Lifelike Mechanical Toad, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>', '', '', 'seen-live: icyveins:catalog'), -- Craftsman's Writ: Lifelike Mechanical Toad
(15, 94885, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 3145728, 1, 0, 0, 16591, 5, 1.0, 0, 6130900294268440000, 890, 878, -2, 'Field Marshal''s Log', 'Deliver the Field Marshal''s Log to Demar Brant in Farholde Keep.', 'The log is full of meticulous recordings on the comings and goings of Twilight''s Hammer forces throughout the Riverglades. \r\n\r\nThe author is nowhere to be found, but this information could help shed light on enemy movements.\r\n\r\nSomeone in Farholde will want to see this.', '', '', 'seen-live: icyveins:catalog'), -- Field Marshal's Log
(16, 94926, 275036, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2826, 0, 15000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 36700416, 0, 0, 0, 16591, 6, 1.0, 0, 6130900294268440000, 890, 878, -2, 'Drop the Hammer', 'Take Komuk''s Maul to Farholde Keep as proof of the ogre''s demise.', 'Like most ogre weaponry, this hammer is large, unwieldy, and well-worn. A creature of any other race could hardly swing it at all.\r\n\r\nTo you, it is of little more use than a trophy, but perhaps someone at Farholde would appreciate knowing of Komuk''s demise.', '', '', 'seen-live: icyveins:catalog'), -- Drop the Hammer
(17, 94973, 0, 0, 267137, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 267137, 36700160, 0, 0, 0, 16842, 5, 1.0, 0, 12261800583900083616, 890, 878, -2, 'Krol''dok Moulding', 'Find someone in Rog''mar who may know about the mould.', '<The moulding appears to be for a key.>', '', '', 'seen-live: icyveins:catalog'), -- Krol'dok Moulding
(18, 94980, 0, 0, 267138, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 267138, 36700160, 0, 0, 0, 16842, 5, 1.0, 0, 6130900294268440000, 890, 878, -2, 'Krol''dok Moulding', 'Find someone in Farholde Keep who may know about the mould.', '<The moulding appears to be for a key.>', '', '', 'seen-live: icyveins:catalog'), -- Krol'dok Moulding
(19, 95124, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2827, 0, 15000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700168, 0, 0, 0, 16591, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Admiral Lamora', 'Slay Admiral Lamora, locate his stash of loot, and return it to Wharfmaster Whizzbuzz.', 'Now it''s time to go after the big man himself: Admiral Lamora. Obviously, I want him dead, but I need a little something extra from him too.\r\n\r\nSeeing how all his plundering has been costing me a fortune, I figure it''s only right that I recoup some losses.\r\n\r\nLamora''s on one of the Eastsea''s boats northeast of here. Find out which and where on it he''s keeping his loot. Bring me whatever he''s got. If it''s locked up, he''s likely got the key on him.', '', '', 'seen-live: icyveins:catalog'), -- Admiral Lamora
(20, 95534, 277206, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 33554432, 0, 0, 0, 36, 5, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Strahnbrad Mystery', 'Solve the mystery of Strahnbrad and report your findings in town in Hillsbrad.', '<The note is singed in places, but is still readable.>\r\n\r\nRumor has it those old bellows have a mind of their own, springing to life when no one is watching. I don''t care if it''s a ghost story, you''d better get to the bottom of it before I return.\r\n\r\nThere''s great power in Strahnbrad, I know it.\r\n\r\n< The rest of the note is singed and torn, as if burnt by fire magic. >', '', '', 'seen-live: icyveins:catalog'), -- Strahnbrad Mystery
(21, 95926, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 279908, 1, 279910, 1, 279912, 1, 0, 0, 0, 0, 0, 0, 68, 0, 10000, 7, 76, 0, 5000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 33554696, 0, 0, 0, 16985, 5, 2.675, 0, 12261800583900083616, 890, 878, -2, 'The Dark Crystal', 'Gather a colorless Drained Crystal Fragment near the Achromatic Crystal in the Shaper''s Terrace.', 'You there! I have a job for someone of your... skills.\r\n\r\nI have gotten word from my sources of a crystal found in Shaper''s Terrace that can seemingly drain the elements around it. Or perhaps it can drain life essence itself. It is unclear from this report.\r\n\r\nI must have a fragment of this crystal! Just think of the applications of such a powerful artifact.\r\n\r\nGo to Shaper''s Terrace and bring me back a sample of this colorless Achromatic Crystal, and I will reward you for your efforts.', '', '', 'seen-live: icyveins:catalog'), -- The Dark Crystal
(22, 95928, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 279904, 1, 279906, 1, 0, 0, 0, 0, 0, 0, 0, 0, 76, 0, 5000, 7, 2787, 0, 10000, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 81, 0, 0, 33554696, 0, 0, 0, 16985, 5, 2.675, 0, 12261800583900083616, 890, 878, -2, 'Crystalline Elements', 'Bring Mayena Earthseeker a Moist Crystal, a Charged Crystal, a Noxious Crystal and a Fiery Crystal from Shaper''s Terrace.', 'Ah, it is good you have come here, $c.\r\n\r\nI have been studying crystals of late and word has reached me about a peculiar set of crystals said to be from Un''Goro Crater. I have samples of the most basic ones, but I have heard tell of larger more potent crystals seen in a place called Shaper''s Terrace.\r\n\r\nI do not know much of this place aside from it containing these crystals that supposedly have the very elements within them. If you find yourself there, please bring me a sample of each color.', '', '', 'seen-live: icyveins:catalog'), -- Crystalline Elements
(23, 97029, 276188, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 18874368, 0, 0, 0, 16593, 0, 1.0, 0, 18446744073709551615, 890, 878, 0, 'Eluvi''ana', 'Deliver the Ancient Skyborne Blade to Ealaane Nimbuswalker to learn more about it.', '', '', '', 'seen-live: icyveins:catalog'), -- Eluvi'ana
(24, 97420, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 36700168, 0, 0, 0, 33, 5, 1.0, 0, 6130900294268440000, 890, 878, -2, 'Reduce, Reuse, Reconcile', 'Acquire 4 Drums of Crude Oil from the Venture Co. operations at Lake Nazferiti, then return to Knaz Blunderflame in Stranglethorn Vale.', 'I have a favor to ask of someone, and you look helpful!\r\n\r\nYou see this baby here? Ain''t she a beaut? This is my newest racer, designed and built all by myself, because SOMEONE wouldn''t help. I plan on taking this to the races in Thousand Needles, but it needs a little extra kick.\r\n\r\nNow, I''m too handsome to be a goblin, and I know better than to trust their tech, but I know the Venture Co struck liquid gold over at the lake. I''m sure they won''t mind if you, erm, borrowed some? They won''t even notice!', '', '', 'seen-live: icyveins:catalog'), -- Reduce, Reuse, Reconcile
(25, 99233, 0, 0, 277557, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 2, 41, 0, 277557, 0, 1, 0, 0, 3217, 1, 1.0, 0, 18446744073709551615, 890, 878, -2, 'Brawl at the Maul', 'Speak with Griniblix the Spectator above the Maul in Dire Maul.', 'There must be more to the Maul than this!$B$BPerhaps the loud Spectator who oversees the event at Dire Maul will know!', '', '', 'seen-live: icyveins:catalog'); -- Brawl at the Maul
CREATE TEMPORARY TABLE `everlake_build_objectives` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY, `taken` TINYINT NOT NULL DEFAULT 0) SELECT `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description` FROM `quest_objectives` WHERE 0;
INSERT INTO `everlake_build_objectives` (`n`, `ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`) VALUES
(1, 478823, 88757, 1, 0, 2, 284705, 1, 32, ''),
(2, 478525, 88757, 1, 1, 1, 284150, 1, 32, ''),
(3, 478524, 88757, 1, 2, 0, 284146, 1, 32, ''),
(4, 459142, 88813, 1, 0, 0, 238057, 1, 32, ''),
(5, 464441, 92343, 1, 0, 1, 250773, 10, 32, ''),
(6, 465442, 92707, 1, 0, 2, 253711, 1, 32, ''),
(7, 466283, 93176, 1, 0, 0, 213566, 1, 32, ''),
(8, 466284, 93176, 1, 1, 1, 213568, 1, 32, ''),
(9, 466285, 93176, 1, 2, 2, 213567, 1, 32, ''),
(10, 466608, 93450, 1, 0, 0, 258735, 1, 32, ''),
(11, 466722, 93546, 1, 0, 0, 259226, 10, 32, ''),
(12, 466983, 93609, 1, 0, 0, 260247, 1, 32, ''),
(13, 467534, 93825, 1, 0, 2, 262802, 12, 32, ''),
(14, 470335, 93831, 1, 0, 0, 262818, 30, 32, ''),
(15, 467559, 93834, 1, 0, 1, 262803, 10, 32, ''),
(16, 468157, 94223, 1, 0, 0, 264023, 1, 32, ''),
(17, 468158, 94223, 1, 1, 1, 15869, 1, 32, ''),
(18, 468383, 94336, 1, 0, 0, 264136, 1, 32, ''),
(19, 468384, 94336, 1, 1, 1, 15996, 1, 32, ''),
(20, 469574, 94885, 1, 0, 0, 266427, 1, 32, ''),
(21, 469341, 94926, 1, 0, 1, 266889, 1, 32, ''),
(22, 469875, 95124, 0, 0, 1, 257861, 1, 32, ''),
(23, 470103, 95124, 1, 1, 0, 268506, 1, 32, ''),
(24, 470850, 95534, 0, 0, 0, 217305, 1, 32, 'Discover the fiery mystery of Strahnbrad'),
(25, 471748, 95926, 1, 0, 0, 271771, 1, 32, ''),
(26, 471856, 95928, 1, 0, 0, 271894, 1, 32, ''),
(27, 471857, 95928, 1, 1, 1, 271898, 1, 32, ''),
(28, 471858, 95928, 1, 2, 2, 271902, 1, 32, ''),
(29, 471859, 95928, 1, 3, 3, 271912, 1, 32, ''),
(30, 474836, 97029, 1, 0, 1, 264501, 1, 32, ''),
(31, 475892, 97420, 1, 0, 0, 277986, 4, 32, '');
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.`ID` = p.`ID`) OR EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'quest_objectives' AND r.`k1` = p.`ID`);
UPDATE `everlake_build_objectives` p SET p.`taken` = 1 WHERE (p.`Type` IN (0, 3) AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = p.`ObjectID`)) OR (p.`Type` = 2 AND p.`ObjectID` > 0 AND NOT EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = p.`ObjectID`));
UPDATE `everlake_build_quests` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `quest_template` t WHERE t.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` IN ('quest_template', 'quest_classic_level', 'quest_template_classic_level', 'quest_classic_money', 'quest_template_addon') AND r.`k1` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_objectives` c WHERE c.`QuestID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_template_classic_level` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_classic_money` c WHERE c.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `everlake_build_objectives` p WHERE p.`QuestID` = s.`ID` AND p.`taken` = 1);
INSERT INTO `quest_template` (`ID`, `RewardItem1`, `RewardAmount1`, `ItemDrop1`, `ItemDropQuantity1`, `RewardItem2`, `RewardAmount2`, `ItemDrop2`, `ItemDropQuantity2`, `RewardItem3`, `RewardAmount3`, `ItemDrop3`, `ItemDropQuantity3`, `RewardItem4`, `RewardAmount4`, `ItemDrop4`, `ItemDropQuantity4`, `RewardChoiceItemID1`, `RewardChoiceItemQuantity1`, `RewardChoiceItemID2`, `RewardChoiceItemQuantity2`, `RewardChoiceItemID3`, `RewardChoiceItemQuantity3`, `RewardChoiceItemID4`, `RewardChoiceItemQuantity4`, `RewardChoiceItemID5`, `RewardChoiceItemQuantity5`, `RewardChoiceItemID6`, `RewardChoiceItemQuantity6`, `RewardFactionID1`, `RewardFactionValue1`, `RewardFactionOverride1`, `RewardFactionCapIn1`, `RewardFactionID2`, `RewardFactionValue2`, `RewardFactionOverride2`, `RewardFactionCapIn2`, `RewardFactionID3`, `RewardFactionValue3`, `RewardFactionOverride3`, `RewardFactionCapIn3`, `RewardFactionID4`, `RewardFactionValue4`, `RewardFactionOverride4`, `RewardFactionCapIn4`, `RewardFactionID5`, `RewardFactionValue5`, `RewardFactionOverride5`, `RewardFactionCapIn5`, `RewardCurrencyID1`, `RewardCurrencyQty1`, `RewardCurrencyID2`, `RewardCurrencyQty2`, `RewardCurrencyID3`, `RewardCurrencyQty3`, `RewardCurrencyID4`, `RewardCurrencyQty4`, `QuestType`, `QuestInfoID`, `RewardNextQuest`, `StartItem`, `Flags`, `FlagsEx`, `FlagsEx2`, `TimeAllowed`, `QuestSortID`, `RewardXPDifficulty`, `RewardXPMultiplier`, `RewardSpell`, `AllowableRaces`, `AcceptedSoundKitID`, `CompleteSoundKitID`, `Expansion`, `LogTitle`, `LogDescription`, `QuestDescription`, `AreaDescription`, `QuestCompletionLog`, `VerifiedBuild`) SELECT s.`ID`, s.`RewardItem1`, s.`RewardAmount1`, s.`ItemDrop1`, s.`ItemDropQuantity1`, s.`RewardItem2`, s.`RewardAmount2`, s.`ItemDrop2`, s.`ItemDropQuantity2`, s.`RewardItem3`, s.`RewardAmount3`, s.`ItemDrop3`, s.`ItemDropQuantity3`, s.`RewardItem4`, s.`RewardAmount4`, s.`ItemDrop4`, s.`ItemDropQuantity4`, s.`RewardChoiceItemID1`, s.`RewardChoiceItemQuantity1`, s.`RewardChoiceItemID2`, s.`RewardChoiceItemQuantity2`, s.`RewardChoiceItemID3`, s.`RewardChoiceItemQuantity3`, s.`RewardChoiceItemID4`, s.`RewardChoiceItemQuantity4`, s.`RewardChoiceItemID5`, s.`RewardChoiceItemQuantity5`, s.`RewardChoiceItemID6`, s.`RewardChoiceItemQuantity6`, s.`RewardFactionID1`, s.`RewardFactionValue1`, s.`RewardFactionOverride1`, s.`RewardFactionCapIn1`, s.`RewardFactionID2`, s.`RewardFactionValue2`, s.`RewardFactionOverride2`, s.`RewardFactionCapIn2`, s.`RewardFactionID3`, s.`RewardFactionValue3`, s.`RewardFactionOverride3`, s.`RewardFactionCapIn3`, s.`RewardFactionID4`, s.`RewardFactionValue4`, s.`RewardFactionOverride4`, s.`RewardFactionCapIn4`, s.`RewardFactionID5`, s.`RewardFactionValue5`, s.`RewardFactionOverride5`, s.`RewardFactionCapIn5`, s.`RewardCurrencyID1`, s.`RewardCurrencyQty1`, s.`RewardCurrencyID2`, s.`RewardCurrencyQty2`, s.`RewardCurrencyID3`, s.`RewardCurrencyQty3`, s.`RewardCurrencyID4`, s.`RewardCurrencyQty4`, s.`QuestType`, s.`QuestInfoID`, s.`RewardNextQuest`, s.`StartItem`, s.`Flags`, s.`FlagsEx`, s.`FlagsEx2`, s.`TimeAllowed`, s.`QuestSortID`, s.`RewardXPDifficulty`, s.`RewardXPMultiplier`, s.`RewardSpell`, s.`AllowableRaces`, s.`AcceptedSoundKitID`, s.`CompleteSoundKitID`, s.`Expansion`, s.`LogTitle`, s.`LogDescription`, s.`QuestDescription`, s.`AreaDescription`, s.`QuestCompletionLog`, 0 FROM `everlake_build_quests` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_template', s.`ID`, '2026_11_20_20_world_everlake_quests_icyveins_a.sql', s.`note` FROM `everlake_build_quests` s WHERE s.`missing` = 1;
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `Flags`, `Description`, `VerifiedBuild`) SELECT p.`ID`, p.`QuestID`, p.`Type`, p.`Order`, p.`StorageIndex`, p.`ObjectID`, p.`Amount`, p.`Flags`, p.`Description`, 0 FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_objectives', p.`ID`, '2026_11_20_20_world_everlake_quests_icyveins_a.sql', s.`note` FROM `everlake_build_objectives` p JOIN `everlake_build_quests` s ON s.`ID` = p.`QuestID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_objectives`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `QuestLevel`, `MinLevel`, `MaxLevel` FROM `quest_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) VALUES
(1, 84394, 58, 50, 0),
(2, 88757, 33, 28, 0),
(3, 88813, 55, 47, 0),
(4, 92343, 55, 45, 0),
(5, 92707, 33, 30, 0),
(6, 93176, 35, 25, 0),
(7, 93450, 42, 35, 0),
(8, 93546, 42, 35, 0),
(9, 93609, 45, 35, 0),
(10, 93825, 57, 54, 0),
(11, 93831, 57, 54, 0),
(12, 93834, 57, 54, 0),
(13, 94223, 60, 1, 0),
(14, 94336, 60, 1, 0),
(15, 94885, 40, 36, 0),
(16, 94926, 45, 38, 0),
(17, 94973, 41, 38, 0),
(18, 94980, 41, 38, 0),
(19, 95124, 45, 38, 0),
(20, 95534, 36, 25, 0),
(21, 95926, 60, 55, 0),
(22, 95928, 60, 55, 0),
(23, 97029, 60, 1, 0),
(24, 97420, 36, 31, 0),
(25, 99233, 60, 55, 0);
INSERT INTO `quest_classic_level` (`ID`, `QuestLevel`, `MinLevel`, `MaxLevel`) SELECT p.`ID`, p.`QuestLevel`, p.`MinLevel`, p.`MaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_level', p.`ID`, '2026_11_20_20_world_everlake_quests_icyveins_a.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `LevelType`, `QuestLevel` FROM `quest_template_classic_level` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `LevelType`, `QuestLevel`) VALUES
(1, 84394, 2, 58),
(2, 88757, 2, 33),
(3, 88813, 2, 55),
(4, 92343, 2, 55),
(5, 92707, 2, 33),
(6, 93176, 2, 35),
(7, 93450, 2, 42),
(8, 93546, 2, 42),
(9, 93609, 2, 45),
(10, 93825, 2, 57),
(11, 93831, 2, 57),
(12, 93834, 2, 57),
(13, 94223, 2, 60),
(14, 94336, 2, 60),
(15, 94885, 2, 40),
(16, 94926, 2, 45),
(17, 94973, 2, 41),
(18, 94980, 2, 41),
(19, 95124, 2, 45),
(20, 95534, 2, 36),
(21, 95926, 2, 60),
(22, 95928, 2, 60),
(23, 97029, 2, 60),
(24, 97420, 2, 36),
(25, 99233, 2, 60);
INSERT INTO `quest_template_classic_level` (`ID`, `LevelType`, `QuestLevel`) SELECT p.`ID`, p.`LevelType`, p.`QuestLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'quest_template_classic_level', p.`ID`, p.`LevelType`, '2026_11_20_20_world_everlake_quests_icyveins_a.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL DEFAULT 0 PRIMARY KEY) SELECT `ID`, `RewardMoney`, `RewardMoneyMaxLevel` FROM `quest_classic_money` WHERE 0;
INSERT INTO `everlake_build_stage` (`n`, `ID`, `RewardMoney`, `RewardMoneyMaxLevel`) VALUES
(1, 84394, 900, 0),
(2, 92343, 13419, 0),
(3, 92707, 6500, 0),
(4, 93176, 3500, 0),
(5, 93609, 13000, 0),
(6, 93825, 15750, 0),
(7, 94885, 2500, 0),
(8, 94973, 5500, 0),
(9, 94980, 5500, 0),
(10, 95124, 6500, 0),
(11, 95534, 4000, 0);
INSERT INTO `quest_classic_money` (`ID`, `RewardMoney`, `RewardMoneyMaxLevel`) SELECT p.`ID`, p.`RewardMoney`, p.`RewardMoneyMaxLevel` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1 ORDER BY p.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_classic_money', p.`ID`, '2026_11_20_20_world_everlake_quests_icyveins_a.sql', s.`note` FROM `everlake_build_stage` p JOIN `everlake_build_quests` s ON s.`ID` = p.`ID` WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
DROP TEMPORARY TABLE `everlake_build_quests`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 5497, 84394, 'seen-live: icyveins:addon'),
(2, 271322, 88757, 'seen-live: icyveins:addon'),
(3, 239822, 88813, 'seen-live: icyveins:addon'),
(4, 5770, 92343, 'seen-live: icyveins:addon'),
(5, 217412, 93176, 'seen-live: icyveins:addon'),
(6, 254717, 93450, 'seen-live: icyveins:addon'),
(7, 254717, 93546, 'seen-live: icyveins:addon'),
(8, 260661, 93825, 'seen-live: icyveins:addon'),
(9, 256646, 93831, 'seen-live: icyveins:addon'),
(10, 256629, 93834, 'seen-live: icyveins:addon'),
(11, 259961, 95124, 'seen-live: icyveins:addon'),
(12, 2055, 95926, 'seen-live: icyveins:addon'),
(13, 263445, 95928, 'seen-live: icyveins:addon'),
(14, 259012, 97029, 'seen-live: icyveins:addon'),
(15, 2687, 97420, 'seen-live: icyveins:addon');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', s.`id`, s.`quest`, '2026_11_20_20_world_everlake_quests_icyveins_a.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 5497, 84394, 'seen-live: icyveins:addon'),
(2, 271322, 88757, 'seen-live: icyveins:addon'),
(3, 239822, 88813, 'seen-live: icyveins:addon'),
(4, 5770, 92343, 'seen-live: icyveins:addon'),
(5, 2771, 92707, 'seen-live: icyveins:addon'),
(6, 217412, 93176, 'seen-live: icyveins:addon'),
(7, 254717, 93450, 'seen-live: icyveins:addon'),
(8, 254717, 93546, 'seen-live: icyveins:addon'),
(9, 254578, 93609, 'seen-live: icyveins:addon'),
(10, 260661, 93825, 'seen-live: icyveins:addon'),
(11, 256646, 93831, 'seen-live: icyveins:addon'),
(12, 256629, 93834, 'seen-live: icyveins:addon'),
(13, 257673, 94336, 'seen-live: icyveins:addon'),
(14, 257558, 94885, 'seen-live: icyveins:addon'),
(15, 257558, 94926, 'seen-live: icyveins:addon'),
(16, 256657, 94973, 'seen-live: icyveins:addon'),
(17, 259250, 94980, 'seen-live: icyveins:addon'),
(18, 259961, 95124, 'seen-live: icyveins:addon'),
(19, 2378, 95534, 'seen-live: icyveins:addon'),
(20, 2402, 95534, 'seen-live: icyveins:addon'),
(21, 2055, 95926, 'seen-live: icyveins:addon'),
(22, 263445, 95928, 'seen-live: icyveins:addon'),
(23, 259012, 97029, 'seen-live: icyveins:addon'),
(24, 2687, 97420, 'seen-live: icyveins:addon'),
(25, 14395, 99233, 'seen-live: icyveins:addon');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_questender' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_build_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', s.`id`, s.`quest`, '2026_11_20_20_world_everlake_quests_icyveins_a.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` BIGINT NOT NULL, `quest` BIGINT NOT NULL, `note` VARCHAR(255) NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 642320, 94223, 'seen-live: icyveins:addon');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `gameobject_questender` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject_questender' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `gameobject_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `gameobject_questender` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'gameobject_questender', s.`id`, s.`quest`, '2026_11_20_20_world_everlake_quests_icyveins_a.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 84394, 'Thanks to your donations, the library is thriving.$B$BPlease, take this.'),
(2, 88757, 'You got my book! And my waterskin! And my necklace! Oh, good fortune finds me today... thank you so much.$B$BI''d better make sure everything is intact!'),
(3, 88813, 'With Krellian dead, the Spitelash will be easily routed. Your duty is complete, $N, and I dismiss you with the highest honor. Thank you.'),
(4, 92343, 'Yes, I can sense these roots teeming with the power of the world tree. I am sure my study of them will be fruitful. You have my thanks, $N.'),
(5, 92707, 'The Witherbark''s goliaths are hardly news to me, $N. We have crossed blades with the brutes before, and will again. I know what threat they pose.$B$BStill, by bringing these to me, you have shown a good soldier''s instincts. Those will serve you well here.'),
(6, 93176, 'These are simply delightful! Look at the forelegs on this one! The coloring of this one''s carapace! Oh, and this one''s mandibles!$B$BI didn''t take you for an entomologist, but you have quite a keen eye.$B$BPlease, take this. I think he might have taken a liking to you, and I''ve already catalogued this particular species.$B$BNow, if you''ll excuse me, I must return to my research. You''ve given me much to study!'),
(7, 93450, 'Wait... you did it? Err, I mean... you did it!$B$BMy problem was very real but my desired solution certainly was not. I am unsure what surprises me the most. That you made the plunge? That the blade followed you into the spirit realm?$B$B<Vindael eyes you up and down once, then again with suspicion overtaking his expression.>$B$BYou still seem very much alive for someone who has tasted death. Why not share your secret with the rest of us?'),
(8, 93546, 'Wow, what a haul! You are tremendously helpful for someone that has to waste a third of your life sleeping. Where do you find the time to help a stranger out?$B$BAh, a reward? You were expecting a reward?$B$BNo, I don''t think I''m quite ready to offer you one just yet.'),
(9, 93609, 'Is that my daughter''s necklace? Oh $N... I assumed the worst. $B$BYou are saying the quilboar had this? I am truly surprised that they took such good care of it. But...$B$BI can no longer feel the magic within. This is terrible news, $N, but it is something we can address. For now, I need to consider our options... and gather my feelings.$B$B<Mithera examines the necklace, on the verge of tears, but quickly regains composure.>$B$BReturn to me again in the future. For now, I need time to ponder.'),
(10, 93825, '<Suma Mossmane slowly inhales.>$B$BThis is healthy, strong moss.'),
(11, 93831, '<Osi immediately pops one into her mouth.> You found some ripe ones! Thanks, I will start to make jam now.'),
(12, 93834, 'Gross. Yum!'),
(13, 94223, '<With the undead hordes endlessly gathering nearby and no sign of others, you choose to make use of your Silver Skeleton Key to effortlessly open the chest.$B$BDespite the claims of impressive riches, the trunk is nearly empty. At the very least there is enough present to cover some of the cost of this ordeal.>'),
(14, 94336, 'What is this? What IS this?$B$B<The orc takes the mechanical critter off your hands and inspects it cautiously. Every new noise it produces causes him to flinch, but over time he grows increasingly more comfortable handling it.>$B$BI ordered PANTS. Whoever wrote this note does not have a clue how to do their job.$B$BIf it will get you away from me faster, take this coin and get lost. I am keeping this machine, however.'),
(15, 94885, 'These notes come too late, I''m afraid. We are now well aware of the dangers within Sunnyglade. What''s more troubling is that you have found them.'),
(16, 94926, 'You say this weapon belonged to Komuk? How tremendous! One less of those ogre brutes for us to worry about! You''ve made the roads safer for our horsemen. I heartily commend you.'),
(17, 94973, 'A curious find, $N. If this is from the stronghold it must be important.'),
(18, 94980, 'Quite a find you have here. Let''s see what we can do.'),
(19, 95124, 'I''ll be honest, I wasn''t sure you''d survive a tangle with Lamora. Guess you''re the real deal!$B$BIf you ever need a favor you can call on ol'' Whizzbuzz. Heck, I might call on you for one too if I need it!$B$B<Wharfmaster Whizzbuzz gives you a wink and a crooked grin.>'),
(20, 95534, 'So there was a fire elemental living in the old bellows up in Strahnbrad? The real mystery is how it got there, I suppose. Either way, good work. Your efforts will be rewarded.'),
(21, 95926, 'Ah, excellent! This is a fine specimen.$B$BThe Royal Apothecary Society thanks you for your... contributions to our knowledge.$B$BDark Lady watch over you, $C.'),
(22, 95928, 'Fascinating. I will begin my studies on these right away.$B$BHopefully in time we can understand how the elements and the creatures of this, ''Shaper''s Terrace'', have influenced one another.'),
(23, 97029, 'Yes, this is in fact Eluvi''ana. This sword has been missing for centuries, and was thought lost. Its magic seems weak, but it still has a deadly edge and will serve you well in battle.$B$BI''d suggest you keep that blade safe as it is a priceless artifact. Who knows, someday there might be a way to restore both blades to their former glory?'),
(24, 97420, 'Wowee! This can make enough rocket fuel to propel me all the way to the raceway! Well, not really, that would be impossible given the ocean and all... but I can probably drive this thing the rest of the way once I get it shipped over to Kalimdor!$B$BThanks, friend! I don''t have much to offer for a reward, but maybe we can race together sometime?'),
(25, 99233, 'You won!$B$BBut one victory ain''t enough to be Grandmaster of the Maul!$B$BYou''ll needa defeat ALL the monsters that call the Maul home.');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_offer_reward` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, '2026_11_20_20_world_everlake_quests_icyveins_a.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 88757, 'Just relacing my boots! Any luck getting past those Dark Irons and finding my things?'),
(2, 88813, 'There is not much more to say at this point, $C, but to make haste. Your mission is critical. Good luck.'),
(3, 92343, 'I''m not usually one to take advantage of a situation like this, but we can''t let this opportunity pass us by.'),
(4, 92707, 'Something to tell me? Then speak! I do not suffer the timid.'),
(5, 93176, 'I must say, though, there''s nothing like the thrill of finding new specimens. I used to delight in scrounging for them through all manner of muck and grime, but I rarely get the opportunity these days.$B$BIn that sense, my little brood is both a blessing and a curse. Because they require so much attention, I cannot travel beyond the swamp.'),
(6, 93450, 'I know of only one way to get things into the spirit realm, $R, but I am sure you can come up with something better.'),
(7, 93546, 'Regular iron just won''t do, I''m afraid. By now I am sure you understand why.'),
(8, 93609, '<Mithera stares toward the gardens. She did not notice you approach, at least until you entered into her field of view.>$B$BHello again, $N. I am grateful to see you again, though I expect you do not bring good news.'),
(9, 93825, 'The trees with shade around their lower bark hide the most Moonveil moss.'),
(10, 93831, 'On the wide hill, if a dark shape looms on you, duck and hide!'),
(11, 93834, 'Hard to see till you stand on them--and then they dart away!'),
(12, 94223, '<After following the instructions on the writ, you find yourself deep in a crypt surrounded by undead. There is a note on a nearby trunk.>$B$BWhoever first reads this will be the first to learn of my death. I am a mere caretaker of the Raven Hill Cemetery, whose presence is largely forgotten by even his employers at Darkshire. I have no heir upon whom to bestow my vast wealth. I have since stashed it away, in this box, for who or whatever manages to open it.'),
(13, 94336, 'Ever tried to swim in lava, orc? You should try it.'),
(14, 94885, 'What have you found?'),
(15, 94926, 'It appears you''ve seen some combat recently, $C.'),
(16, 95124, 'Killing Lamora is about getting even. Stealing back his loot is about breaking even.'),
(17, 95534, 'Hm? There''s a mystery in Strahnbrad you''re investigating? Pah, that old ghost town is nothing special.'),
(18, 95926, 'Hello, can I help you? Oh, yes, $N.$B$BApologies I had forgotten about your errand. Have you returned with the crystal fragment?'),
(19, 95928, 'Have you brought the crystals? I have read reports from one of our fellows that traveled that way. He reports seeing ''elemental raptors''.$B$BIn all my years I have yet to see such a thing, but I feel the crystals and creatures must have some relation.'),
(20, 97029, 'If I may beg your pardon, that blade you carry there, may I see it? Much like the ancient hilt you brought me previously, I believe that blade was also created by the same master magesmith, Luminarian. $B$BIf I am correct, it is called Eluvi''ana and it was the twin of the blade whose hilt you gave me, which itself was called Eluvi''tor. What are the odds that you would come into possession of both of these priceless artifacts? It must be fate.$B$BLet me inspect it to be sure...'),
(21, 97420, 'Well, hello again! Any luck with the oil?');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_request_items` x WHERE x.`ID` = s.`ID`) OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s ORDER BY s.`n`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, '2026_11_20_20_world_everlake_quests_icyveins_a.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;
COMMIT;
