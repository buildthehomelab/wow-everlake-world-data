-- Everlake Forge #316: Import, 1 resource(s), 48 row(s)
-- 2026_11_25_900_world_everlake_forge_00316_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 71091) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Wowhead 2026-11-25 (NOTICE.md, Forge exports).
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing: a row is added only
-- where none exists, spawns only where the same creature or object is not already within 5 yards, and each added row is recorded in everlake_import_rows.

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

START TRANSACTION;
-- quest_request_items: 12 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `quest_request_items` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(81731, 0, 0, 0, 0, 'You\'ve dealt with the ogres?', 0),
(81745, 0, 0, 0, 0, 'You rescued Kroll?', 0),
(81786, 0, 0, 0, 0, 'You\'ve dealt with the moonkin?', 0),
(81787, 0, 0, 0, 0, 'You\'ve dealt with the turtles?', 0),
(81837, 0, 0, 0, 0, 'You\'ve dealt with Florius?', 0),
(81838, 0, 0, 0, 0, 'You\'ve dealt with the Doomkin?', 0),
(81857, 0, 0, 0, 0, 'You\'ve dealt with the dragonkin?', 0),
(91564, 0, 0, 0, 0, 'Any luck with the scavenging?', 0),
(97413, 0, 0, 0, 0, 'You\'ve returned and I see in your eyes that you\'ve much to tell me, $n. Let us take care of your reward first.', 0),
(98891, 0, 0, 0, 0, 'What news from the Darkspear Islands, $n?', 0),
(98899, 0, 0, 0, 0, 'How goes your campaign in the Darkspear Islands, $n?', 0),
(99217, 0, 0, 0, 0, 'Have you made your choice? These kodos have carried our ancestors across the plains for generations. They are a steadfast and mighty beast.$B$BYou will not find a more loyal and noble mount for your travels.', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_request_items` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, 0, 0, 0, '2026_11_25_900_world_everlake_forge_00316_import.sql', 'Forge #316: Wowhead 2026-11-25' FROM `everlake_forge_stage` s;

-- quest_offer_reward: 34 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `quest_offer_reward` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(81730, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81731, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81732, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81742, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81743, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81744, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81745, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81746, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81747, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81786, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81787, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81788, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81837, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81838, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81839, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81855, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81856, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81857, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81868, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(81871, 0, 0, 0, 0, 0, 0, 0, 0, 'Well done! Your services shall be well rewarded. Perhaps another mission?', 0),
(91564, 0, 0, 0, 0, 0, 0, 0, 0, 'Great job! Now I can make the axle on our well perfectly frictionless. That\'ll be a huge improvement!$B$BDon\'t worry, I haven\'t forgotten about you! I\'ve had a lot of time to think up some unusual engineering ideas...', 0),
(94778, 0, 0, 0, 0, 0, 0, 0, 0, 'I\'m glad you\'ve arrived, $n. There are many things we will have to discuss, but more importantly is your training in the ways of the Light.$B$BThere are lessons all servants of the Light must learn. If you are ready, we\'ll begin discussing some of those now.', 0),
(95820, 0, 0, 0, 0, 0, 0, 0, 0, 'Time for another batch of signs, I see. Not a problem, you aren\'t the first that Jornah has sent to me and I hope you are not the last!$B$BGive me a moment to remember what we need.', 0),
(96383, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, the great $n is back. Just as I expected.$B$BWhy might I, Wiley, the humble innkeeper, expect the arrival of a specific adventurer? Because whoever your secret admirer is still hasn\'t updated your delivery address!$B$BNo, no, don\'t say anything. We\'re all busy, I get it. Just make sure they get it sorted, alright?$B$BHere\'s your package. I am pretty sure whatever is in it is alive. Or was? At this point, I don\'t care to find out. I will forever remember it as being both alive and dead.', 0),
(97413, 0, 0, 0, 0, 0, 0, 0, 0, 'This curse was bestowed upon us but for a mere medallion. Lord Valthalak certainly knows how to hold a grudge.$B$BWe\'ll endeavor to find the remaining pieces - hopefully before I meet an untimely demise. But before that, let us see about your reward.', 0),
(98891, 0, 0, 0, 0, 0, 0, 0, 0, 'The sands of the Darkspear Islands are awash with the blood of the Alliance you\'ve killed. Well done, $n.$B$BFor the horde!', 0),
(98899, 0, 0, 0, 0, 0, 0, 0, 0, 'You\'ve distinguished yourself honorably in battle at the Darkspear Islands and your efforts have not gone unnoticed.$B$BThere are ever more battles to fight, however. Continue to prove yourself in battle and you will surely reap the rewards.', 0),
(98904, 0, 0, 0, 0, 0, 0, 0, 0, 'The Theramore Expeditionary Force are grateful for your dedication and prowess in the battle for the Darkspear Islands, $n.$B$BFor the Alliance!', 0),
(98908, 0, 0, 0, 0, 0, 0, 0, 0, 'You be showin\' strength and dedication out at the Darkspear Islands! Your prowess in battle is to be admired, mon!', 0),
(99202, 0, 0, 0, 0, 0, 0, 0, 0, 'Welcome back, $c. I\'m happy to see you\'ve completed the final leg of your training with Kar.$B$BI\'m proud to present you with your first armored kodo. Come, let us choose your mount.', 0),
(99206, 0, 0, 0, 0, 0, 0, 0, 0, 'Well met again, $n. I\'m glad you\'ve returned to us. Let\'s get you your armored horse!', 0),
(99207, 0, 0, 0, 0, 0, 0, 0, 0, 'I\'m pleased that you\'ve graduated to one of our swift mechanostriders, $n. Now--let\'s find the perfect machine for you!', 0),
(99212, 0, 0, 0, 0, 0, 0, 0, 0, 'Excellent, $n, most excellent indeed! You have made a great choice.$B$BThe biometrics are all set up and the upgraded mechanostrider seems excited to get its system processes started. I hope you both will take care of one another out there in the vast world!$B$BCome back if you ever need a tune-up!', 0),
(99217, 0, 0, 0, 0, 0, 0, 0, 0, 'Excellent, $n. I can see in your eyes that you have made a choice.$B$BI am so happy to be able to provide you with one of our fastest and fiercest kodos. I must say the one you have picked seems fond of you already. I hope you will take good care of it, and it of you.$B$BMay the Earth Mother guide you both.', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_offer_reward` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, 0, 0, 0, '2026_11_25_900_world_everlake_forge_00316_import.sql', 'Forge #316: Wowhead 2026-11-25' FROM `everlake_forge_stage` s;

-- fishing_loot_template: 1 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `fishing_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(16651, 0, 6309, 2.26, 0, 1, 1, 1, 1, 'Wowhead 2026-11-25');
DELETE s FROM `everlake_forge_stage` s JOIN `fishing_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `fishing_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'fishing_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_25_900_world_everlake_forge_00316_import.sql', 'Forge #316: Wowhead 2026-11-25' FROM `everlake_forge_stage` s;

-- flags and empty columns the operation set (only where still unset)
UPDATE `quest_offer_reward` SET `RewardText` = 'The cries of the Alliance as you and your compatriots attacked them could be heard even from here, $n. I can almost pity them for the pain and fear you delivered to their ranks. Almost, but not quite.$B$BYour value to the Defilers is without question. Your deeds in Arathi Basin have been most impressive, and have echoed among the chambers of Varimathras... and the Dark Lady herself.' WHERE `ID` = 8122 AND (`RewardText` IS NULL OR `RewardText` = '');

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
