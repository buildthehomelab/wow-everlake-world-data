-- Turn-in texts for eleven Forever quests the realm has without them: what is said when the quest is handed in
-- (quest_offer_reward) and, for nine of them, while it is not done yet (quest_request_items).
-- 2026_11_23_02_world_everlake_quest_turnin_texts.sql: checked by hand.
--
-- The realm's tracker lists these quests as "no turn-in text". Icy Veins' Forever database holds the words players'
-- addons recorded on live for each of them (read through the ForeverTracker's mirror of it); no other source has them.
-- The tracker's own Icy Veins cards of 2026-11-20 and 2026-11-21 did not offer them; why is not known (the quests and
-- the recordings were both there). River Ends has a row without words, which that import leaves as it is by design.
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
SET @EVERLAKE_FILE := '2026_11_23_02_world_everlake_quest_turnin_texts.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_build_text`;
CREATE TEMPORARY TABLE `everlake_build_text` (`ID` INT UNSIGNED NOT NULL, `part` VARCHAR(8) NOT NULL, `txt` MEDIUMTEXT NOT NULL, `todo` TINYINT NOT NULL DEFAULT 0, PRIMARY KEY (`ID`, `part`)) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_build_text` (`ID`, `part`, `txt`) VALUES
-- River Ends
(7790, 'complete', 'Rotting on the soggy riverbank are badly decomposed remains. A tattered shred of black cloth with silver trim still glistens even in this dim light. This could have been somebody who met their unfortunate end swimming down the river until the waterfall overtook them.$B$BCould this have been what the two skyborne were here for?'),
-- It Must Be Destroyed
(78092, 'complete', '<You raise the orb towards the spear and bring it crashing down upon the blade.>'),
(78092, 'progress', '<Your hair stands on end as infernal energies surround you.>'),
-- On the Lam
(79235, 'complete', 'You need something? Make it quick.'),
-- Cherry for Your Thoughts?
(79236, 'complete', 'Ah, that''s the stuff. Now, where was I?'),
(79236, 'progress', 'How''s that drink coming?'),
-- No Honor Among Thieves
(79242, 'complete', '<Inside of the cache, you find a good deal of coin. Blood money, no doubt.>'),
(79242, 'progress', '<Using Illari''s key, you unlock the cache.>'),
-- The Broken Hammer
(79939, 'complete', '<Katherine''s eyes widen slightly as you show her the broken hammer.> $B$BYes $N, I do know of this weapon. I''d assumed its owner had died long ago.'),
(79939, 'progress', 'What is it you have there, my friend?'),
-- Best Laid Plans
(80453, 'complete', 'So you''re on Fahrad''s job, hm?  Very well. Give me the talisman and I''ll get to work.'),
(80453, 'progress', 'Yes, rogue? Do you need something from me?'),
-- One Last Drop
(80454, 'complete', '<You place the Modified Talisman into the chest.>'),
(80454, 'progress', '<The chest sits, empty.>'),
-- Wisdom of the Guardians
(81924, 'complete', 'You have proven a dedicated pupil, $N. The work of preserving ancient knowledge is often arduous, but you have taken on the duty admirably.$B$BThere are many more mysteries in this world for you to uncover. I hope these tools will aid you in that journey.'),
(81924, 'progress', 'Have the spirits imparted their wisdom unto you?'),
-- Oi!
(84318, 'complete', 'Aye I''m much obliged tae ye! Now that we''ve got that out of the way, let''s work on puttin'' the rest together so you can send me on me way!'),
(84318, 'progress', 'Whadda want?'),
-- In Memoriam
(95615, 'complete', 'The souls of our fallen look upon you with warmth and gratitude, as do I.$B$BThank you for helping keep the church alive, $N. May the Light guide and protect you on your journey.'),
(95615, 'progress', 'All out of candles, $N?');

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
