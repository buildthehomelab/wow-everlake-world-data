-- Turn-in texts for thirteen more Forever quests the realm has without them: what is said when the quest is handed
-- in (quest_offer_reward) and, for five of them, while it is not done yet (quest_request_items).
-- 2026_11_23_03_world_everlake_quest_turnin_texts_2.sql: checked by hand.
--
-- The realm's tracker listed these quests as "no turn-in text". Icy Veins' Forever database now holds the words
-- players' addons recorded on live for each of them (read on 2026-11-23 through the ForeverTracker's mirror of it); a
-- week earlier it had none.
-- Swift as the Wind (99201), a quest for trolls of any class, was recorded as "Spirits be with ya, rogue.": the
-- recording player's own class. It is written with the class token ($c). INFERRED: no recording shows the token.
-- Where a test realm already holds the recorded wording (the tracker's own import wrote it), that one row is corrected.
-- "Loredaron" in An Epic Ride (99211) is as recorded.
-- Only where the quest exists and has no words in that table yet: a missing row is added, an empty one filled. Each
-- added row is recorded in everlake_import_rows.
-- Source: Icy Veins (db.icy-veins.com/wow-forever, no licence stated). Game text belongs to Blizzard Entertainment.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing. Not read in game.
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
SET @EVERLAKE_FILE := '2026_11_23_03_world_everlake_quest_turnin_texts_2.sql';

START TRANSACTION;

-- the recorded wording of Swift as the Wind, where it was already written: the class token for the recorder's class
UPDATE `quest_offer_reward` SET `RewardText` = 'Spirits be with ya, $c. I''m glad to see ya back here, taking your next steps as a seasoned raptor rider!'
WHERE `ID` = 99201 AND `RewardText` = 'Spirits be with ya, rogue. I''m glad to see ya back here, taking your next steps as a seasoned raptor rider!';

DROP TEMPORARY TABLE IF EXISTS `everlake_build_text`;
CREATE TEMPORARY TABLE `everlake_build_text` (`ID` INT UNSIGNED NOT NULL, `part` VARCHAR(8) NOT NULL, `txt` MEDIUMTEXT NOT NULL, `todo` TINYINT NOT NULL DEFAULT 0, PRIMARY KEY (`ID`, `part`)) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_build_text` (`ID`, `part`, `txt`) VALUES
-- Some Good News
(81762, 'complete', 'Good to see you again, $N. Let''s get you caught up.'),
-- The Mysterious Merchant
(81764, 'complete', 'Ah, you made it! Katherine sent me to assist you in your mission. We must hurry though, our quarry has escaped!'),
-- The Price of Hope
(82135, 'complete', 'That is quite the troubling tale. The part of me that is a paladin finds it impossible to reconcile that he willingly consorted with a member of the scourge... but the human part of me understands how strong the bonds of friendship can be. $B$BI thank you for bringing the orb here. I will see that it is stored in the deepest vault we have for now. $B$BOh, One last thing, I had this repaired and had hoped to present it to Aeonas on his return. I think he would want you to wield it in his stead.'),
(82135, 'progress', 'Welcome back, $N. What is that you have there... $B$BOh my.'),
-- Beach Bot
(84135, 'complete', 'Using your weapon and field skills you pry the compartment free, revealing a vial of glowing liquid within.'),
-- Mystic Mix
(95108, 'complete', 'You smell of their deepest, foulest den--proof alone you''ve put the mystics to death.'),
-- The Divination Scryer
(97184, 'complete', 'Good, these will do.$B$BIn the depths of the Great Ossuary of Scholomance are the skeletal remains of many beings. Amongst them is a once-noble charger, enslaved and debased by one of the dark masters of the scourge--a death knight known now only as the Darkreaver.$B$BShow Darkreaver the light''s merciless retribution. Free the soul of his steed, and make it an offering to join you in service of the light''s unyielding justice.'),
(97184, 'progress', 'This last, small act of sacrifice is all that is needed for you to begin your final trial.'),
-- Manna-Enriched Horse Feed
(97186, 'complete', 'Thank you for the gold, paladin. I think this feed should be sufficient for your needs.$B$BDo be sure to drop by again... well, never.$B$B<Blightcaller''s hounds growl at you menacingly. You are clearly dismissed.>'),
(97186, 'progress', 'You know, I''d have put money on the Dark Lady marching her deathguard up to your keep and wiping you all off the map months ago.$B$BI know that''s what I would have if I were her. She must see some value in keeping you overly-righteous lot around, even if the vast majority of her people can''t stand your presence.$B$BStill though I have to wonder, how does it feel to be hated by your own people? What truly motivates you to keep moving forward?'),
-- Just Compensation
(97412, 'complete', 'Our agreement remains in place. Just remember, this is but a taste of what awaits you.  Free me of this cursed fate and I will reward you with items of truly great power.'),
(97412, 'progress', 'You''re ready to perform the exchange?'),
-- Swift as the Wind
(99201, 'complete', 'Spirits be with ya, $c. I''m glad to see ya back here, taking your next steps as a seasoned raptor rider!'),
-- An Epic Ride
(99210, 'complete', 'Ah, that one is a great companion and will do ye well, $N.$B$BI''m proud teh be the one able to send you and your armored ram on yer way. Seems teh me that the ram ye picked seems fond of you already. I hope you''ll take good care of it, and it of you.$B$BDon''t forget to drop by sometime! I''d love teh hear about yer epic adventures together.'),
-- An Epic Ride
(99211, 'complete', 'Excellent, $N. I can see you have made a choice, and it is a fine one indeed.$B$BToday you leave with one of our finest steeds; one that not even the boundary of death can stop.$B$BThough it is dead, the bond you share is real enough, so please do take care of it as you both venture forth into the world.$B$BI wish you well on your adventures. Go with the blessings of the Dark Lady.'),
(99211, 'progress', 'Have you made your choice? These were once some of the finest horses in all of Loredaron. Now they serve us in death as they did in life.$B$BBe warned, the process used to raise them is more intense than that of our regular undead steeds, which in-turn makes them far more powerful and ferocious. Those horns are not just for show, you know.$B$BThey are fitting companions for the most daring adventurers and heroes of the Forsaken.'),
-- An Epic Ride
(99214, 'complete', 'Excellent, $N. I can see in your eyes that you have made a choice.$B$BI am so happy to be able to provide you with one of our fine armored sabers. I must say the one you have picked seems fond of you already. I hope you will take good care of it, and it of you.$B$BMay you both go into the world with Elune''s blessing.'),
-- An Epic Ride
(99215, 'complete', '<Ogunaro gives you a satisfied grunt.> $B$BIt seems you have found your companion. Treat them well and they will bear you into battle with honor.$B$BBlood and thunder, $N.');

-- to do: the quest is on the realm and that table has no words for it
UPDATE `everlake_build_text` b SET b.`todo` = 1
WHERE EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = b.`ID`)
  AND ((b.`part` = 'complete' AND NOT EXISTS (SELECT 1 FROM `quest_offer_reward` o WHERE o.`ID` = b.`ID` AND COALESCE(o.`RewardText`, '') <> ''))
    OR (b.`part` = 'progress' AND NOT EXISTS (SELECT 1 FROM `quest_request_items` r WHERE r.`ID` = b.`ID` AND COALESCE(r.`CompletionText`, '') <> '')));

INSERT INTO `quest_offer_reward` (`ID`, `RewardText`, `VerifiedBuild`)
SELECT b.`ID`, b.`txt`, 0 FROM `everlake_build_text` b WHERE b.`todo` = 1 AND b.`part` = 'complete'
ON DUPLICATE KEY UPDATE `RewardText` = VALUES(`RewardText`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`, `VerifiedBuild`)
SELECT b.`ID`, b.`txt`, 0 FROM `everlake_build_text` b WHERE b.`todo` = 1 AND b.`part` = 'progress'
ON DUPLICATE KEY UPDATE `CompletionText` = VALUES(`CompletionText`);

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT IF(b.`part` = 'complete', 'quest_offer_reward', 'quest_request_items'), b.`ID`, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins: words recorded on live'
FROM `everlake_build_text` b WHERE b.`todo` = 1;

DROP TEMPORARY TABLE `everlake_build_text`;
COMMIT;
