-- Everlake Forge #274: Import, 1 resource(s), 53 row(s)
-- 2026_11_23_900_world_everlake_forge_00274_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 71037) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Icy Veins 2026-11-23 (gaps) (NOTICE.md, Forge exports).
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
-- quest_offer_reward: 23 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `quest_offer_reward` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(78092, 0, 0, 0, 0, 0, 0, 0, 0, '<You raise the orb towards the spear and bring it crashing down upon the blade.>', 0),
(79235, 0, 0, 0, 0, 0, 0, 0, 0, 'You need something? Make it quick.', 0),
(79236, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, that\'s the stuff. Now, where was I?', 0),
(79242, 0, 0, 0, 0, 0, 0, 0, 0, '<Inside of the cache, you find a good deal of coin. Blood money, no doubt.>', 0),
(79939, 0, 0, 0, 0, 0, 0, 0, 0, '<Katherine\'s eyes widen slightly as you show her the broken hammer.> $B$BYes $N, I do know of this weapon. I\'d assumed its owner had died long ago.', 0),
(80453, 0, 0, 0, 0, 0, 0, 0, 0, 'So you\'re on Fahrad\'s job, hm?  Very well. Give me the talisman and I\'ll get to work.', 0),
(80454, 0, 0, 0, 0, 0, 0, 0, 0, '<You place the Modified Talisman into the chest.>', 0),
(81762, 0, 0, 0, 0, 0, 0, 0, 0, 'Good to see you again, $N. Let\'s get you caught up.', 0),
(81764, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, you made it! Katherine sent me to assist you in your mission. We must hurry though, our quarry has escaped!', 0),
(81924, 0, 0, 0, 0, 0, 0, 0, 0, 'You have proven a dedicated pupil, $N. The work of preserving ancient knowledge is often arduous, but you have taken on the duty admirably.$B$BThere are many more mysteries in this world for you to uncover. I hope these tools will aid you in that journey.', 0),
(82135, 0, 0, 0, 0, 0, 0, 0, 0, 'That is quite the troubling tale. The part of me that is a paladin finds it impossible to reconcile that he willingly consorted with a member of the scourge... but the human part of me understands how strong the bonds of friendship can be. $B$BI thank you for bringing the orb here. I will see that it is stored in the deepest vault we have for now. $B$BOh, One last thing, I had this repaired and had hoped to present it to Aeonas on his return. I think he would want you to wield it in his stead.', 0),
(84135, 0, 0, 0, 0, 0, 0, 0, 0, 'Using your weapon and field skills you pry the compartment free, revealing a vial of glowing liquid within.', 0),
(84318, 0, 0, 0, 0, 0, 0, 0, 0, 'Aye I\'m much obliged tae ye! Now that we\'ve got that out of the way, let\'s work on puttin\' the rest together so you can send me on me way!', 0),
(95108, 0, 0, 0, 0, 0, 0, 0, 0, 'You smell of their deepest, foulest den--proof alone you\'ve put the mystics to death.', 0),
(95615, 0, 0, 0, 0, 0, 0, 0, 0, 'The souls of our fallen look upon you with warmth and gratitude, as do I.$B$BThank you for helping keep the church alive, $N. May the Light guide and protect you on your journey.', 0),
(97184, 0, 0, 0, 0, 0, 0, 0, 0, 'Good, these will do.$B$BIn the depths of the Great Ossuary of Scholomance are the skeletal remains of many beings. Amongst them is a once-noble charger, enslaved and debased by one of the dark masters of the scourge--a death knight known now only as the Darkreaver.$B$BShow Darkreaver the light\'s merciless retribution. Free the soul of his steed, and make it an offering to join you in service of the light\'s unyielding justice.', 0),
(97186, 0, 0, 0, 0, 0, 0, 0, 0, 'Thank you for the gold, paladin. I think this feed should be sufficient for your needs.$B$BDo be sure to drop by again... well, never.$B$B<Blightcaller\'s hounds growl at you menacingly. You are clearly dismissed.>', 0),
(97412, 0, 0, 0, 0, 0, 0, 0, 0, 'Our agreement remains in place. Just remember, this is but a taste of what awaits you.  Free me of this cursed fate and I will reward you with items of truly great power.', 0),
(99201, 0, 0, 0, 0, 0, 0, 0, 0, 'Spirits be with ya, $c. I\'m glad to see ya back here, taking your next steps as a seasoned raptor rider!', 0),
(99210, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, that one is a great companion and will do ye well, $N.$B$BI\'m proud teh be the one able to send you and your armored ram on yer way. Seems teh me that the ram ye picked seems fond of you already. I hope you\'ll take good care of it, and it of you.$B$BDon\'t forget to drop by sometime! I\'d love teh hear about yer epic adventures together.', 0),
(99211, 0, 0, 0, 0, 0, 0, 0, 0, 'Excellent, $N. I can see you have made a choice, and it is a fine one indeed.$B$BToday you leave with one of our finest steeds; one that not even the boundary of death can stop.$B$BThough it is dead, the bond you share is real enough, so please do take care of it as you both venture forth into the world.$B$BI wish you well on your adventures. Go with the blessings of the Dark Lady.', 0),
(99214, 0, 0, 0, 0, 0, 0, 0, 0, 'Excellent, $N. I can see in your eyes that you have made a choice.$B$BI am so happy to be able to provide you with one of our fine armored sabers. I must say the one you have picked seems fond of you already. I hope you will take good care of it, and it of you.$B$BMay you both go into the world with Elune\'s blessing.', 0),
(99215, 0, 0, 0, 0, 0, 0, 0, 0, '<Ogunaro gives you a satisfied grunt.> $B$BIt seems you have found your companion. Treat them well and they will bear you into battle with honor.$B$BBlood and thunder, $N.', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_offer_reward` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, 0, 0, 0, '2026_11_23_900_world_everlake_forge_00274_import.sql', 'Forge #274: Icy Veins 2026-11-23 (gaps)' FROM `everlake_forge_stage` s;

-- quest_request_items: 14 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `quest_request_items` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(78092, 0, 0, 0, 0, '<Your hair stands on end as infernal energies surround you.>', 0),
(79236, 0, 0, 0, 0, 'How\'s that drink coming?', 0),
(79242, 0, 0, 0, 0, '<Using Illari\'s key, you unlock the cache.>', 0),
(79939, 0, 0, 0, 0, 'What is it you have there, my friend?', 0),
(80453, 0, 0, 0, 0, 'Yes, rogue? Do you need something from me?', 0),
(80454, 0, 0, 0, 0, '<The chest sits, empty.>', 0),
(81924, 0, 0, 0, 0, 'Have the spirits imparted their wisdom unto you?', 0),
(82135, 0, 0, 0, 0, 'Welcome back, $N. What is that you have there... $B$BOh my.', 0),
(84318, 0, 0, 0, 0, 'Whadda want?', 0),
(95615, 0, 0, 0, 0, 'All out of candles, $N?', 0),
(97184, 0, 0, 0, 0, 'This last, small act of sacrifice is all that is needed for you to begin your final trial.', 0),
(97186, 0, 0, 0, 0, 'You know, I\'d have put money on the Dark Lady marching her deathguard up to your keep and wiping you all off the map months ago.$B$BI know that\'s what I would have if I were her. She must see some value in keeping you overly-righteous lot around, even if the vast majority of her people can\'t stand your presence.$B$BStill though I have to wonder, how does it feel to be hated by your own people? What truly motivates you to keep moving forward?', 0),
(97412, 0, 0, 0, 0, 'You\'re ready to perform the exchange?', 0),
(99211, 0, 0, 0, 0, 'Have you made your choice? These were once some of the finest horses in all of Loredaron. Now they serve us in death as they did in life.$B$BBe warned, the process used to raise them is more intense than that of our regular undead steeds, which in-turn makes them far more powerful and ferocious. Those horns are not just for show, you know.$B$BThey are fitting companions for the most daring adventurers and heroes of the Forsaken.', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_request_items` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, 0, 0, 0, '2026_11_23_900_world_everlake_forge_00274_import.sql', 'Forge #274: Icy Veins 2026-11-23 (gaps)' FROM `everlake_forge_stage` s;

-- trainer_spell: 16 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild` FROM `trainer_spell` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(1011869, 1742, 0, 0, 0, 0, 0, 0, 5, 71037),
(1011869, 2649, 0, 0, 0, 0, 0, 0, 1, 71037),
(1011869, 4187, 0, 0, 0, 0, 0, 0, 1, 71037),
(1011869, 7371, 0, 0, 0, 0, 0, 0, 1, 71037),
(1011869, 16827, 0, 0, 0, 0, 0, 0, 1, 71037),
(1011869, 17253, 0, 0, 0, 0, 0, 0, 1, 71037),
(1011869, 23992, 0, 0, 0, 0, 0, 0, 20, 71037),
(1011869, 24423, 0, 0, 0, 0, 0, 0, 8, 71037),
(1011869, 24446, 0, 0, 0, 0, 0, 0, 20, 71037),
(1011869, 24488, 0, 0, 0, 0, 0, 0, 20, 71037),
(1011869, 24492, 0, 0, 0, 0, 0, 0, 20, 71037),
(1011869, 24493, 0, 0, 0, 0, 0, 0, 20, 71037),
(1011869, 24545, 0, 0, 0, 0, 0, 0, 1, 71037),
(1011869, 1264494, 0, 0, 0, 0, 0, 0, 12, 71037),
(1011869, 1265065, 0, 0, 0, 0, 0, 0, 12, 71037),
(1251972, 3909, 500, 197, 50, 0, 0, 0, 10, 71037);
DELETE s FROM `everlake_forge_stage` s JOIN `trainer_spell` x ON x.`TrainerId` <=> s.`TrainerId` AND x.`SpellId` <=> s.`SpellId`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `trainer` p WHERE p.`Id` = `everlake_forge_stage`.`TrainerId`);
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) SELECT `TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'trainer_spell', s.`TrainerId`, s.`SpellId`, 0, 0, '2026_11_23_900_world_everlake_forge_00274_import.sql', 'Forge #274: Icy Veins 2026-11-23 (gaps)' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
