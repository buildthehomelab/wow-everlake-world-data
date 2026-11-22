-- Turn-in texts for live Forever's 841xx Tier 0.5 quests, copied from the old quests they replace (INFERRED).
-- 2026_11_21_102_world_everlake_tier05_turnin_texts.sql: written by a script from the realm's own old quest texts, checked by hand.
--
-- 2026_11_21_101_world_everlake_tier05_841xx_quests.sql added live's 841xx Tier 0.5 quests; Icy Veins recorded no
-- turn-in words for 26 of them. Each 841xx quest is live's copy of an old one (the same title, the same armour pieces
-- asked for, the same side), and where Icy Veins did record the words they match: 25 of 26 recorded copies say what
-- the old quest says word for word, the last differs by one word ("bracers" for "bindings"). So each of these takes
-- its old quest's quest_offer_reward and quest_request_items text. INFERRED, not recorded on live.
-- Only where the quest has no row of that table yet; each added row is recorded in everlake_import_rows.
-- Game text belongs to Blizzard Entertainment.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

SET @EVERLAKE_FILE := '2026_11_21_102_world_everlake_tier05_turnin_texts.sql';

START TRANSACTION;

CREATE TEMPORARY TABLE `everlake_build_text` (`ID` INT UNSIGNED NOT NULL PRIMARY KEY, `old` INT UNSIGNED NOT NULL, `txt` MEDIUMTEXT NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_build_text` (`ID`, `old`, `txt`) VALUES
(84163, 8926, 'You''ve kept your end of the bargain, I shall keep mine.$B$BJust remember that I''m holding on to the best pieces until your work is finished.'),
(84164, 8931, 'You''ve kept your end of the bargain, I shall keep mine.$B$BJust remember that I''m holding on to the best pieces until your work is finished.'),
(84167, 8934, 'You''ve kept your end of the bargain, I shall keep mine.$B$BJust remember that I''m holding on to the best pieces until your work is finished.'),
(84169, 8936, 'You''ve kept your end of the bargain, I shall keep mine.$B$BJust remember that I''m holding on to the best pieces until your work is finished.'),
(84170, 8937, 'You''ve kept your end of the bargain, I shall keep mine.$B$BJust remember that I''m holding on to the best pieces until your work is finished.'),
(84171, 8927, 'Our agreement remains in place. Just remember, this is but a taste of what awaits you. Free me of this cursed fate and I will reward you with items of truly great power.'),
(84177, 8943, 'Our agreement remains in place. Just remember, this is but a taste of what awaits you. Free me of this cursed fate and I will reward you with items of truly great power.'),
(84179, 8951, 'I can''t believe our lives are all but forfeit all because of a stupid medallion! And you''re sure Anthion mentioned Bodley?$B$BWell, you''ve done your job so let''s get your reward out of the way.'),
(84180, 8952, 'I can''t believe our lives are all but forfeit all because of a stupid medallion! And you''re sure Anthion mentioned Bodley?$B$BWell, you''ve done your job so let''s get your reward out of the way.'),
(84181, 8953, 'I can''t believe our lives are all but forfeit all because of a stupid medallion! And you''re sure Anthion mentioned Bodley?$B$BWell, you''ve done your job so let''s get your reward out of the way.'),
(84182, 8954, 'I can''t believe our lives are all but forfeit all because of a stupid medallion! And you''re sure Anthion mentioned Bodley?$B$BWell, you''ve done your job so let''s get your reward out of the way.'),
(84183, 8955, 'I can''t believe our lives are all but forfeit all because of a stupid medallion! And you''re sure Anthion mentioned Bodley?$B$BWell, you''ve done your job so let''s get your reward out of the way.'),
(84186, 8959, 'I can''t believe our lives are all but forfeit all because of a stupid medallion! And you''re sure Anthion mentioned Bodley?$B$BWell, you''ve done your job so let''s get your reward out of the way.'),
(84187, 9016, 'This curse was bestowed upon us but for a mere medallion. Lord Valthalak certainly knows how to hold a grudge.$B$BWe''ll endeavor to find the remaining pieces - hopefully before I meet an untimely demise. But before that, let us see about your reward.'),
(84189, 9018, 'This curse was bestowed upon us but for a mere medallion. Lord Valthalak certainly knows how to hold a grudge.$B$BWe''ll endeavor to find the remaining pieces - hopefully before I meet an untimely demise. But before that, let us see about your reward.'),
(84190, 9019, 'This curse was bestowed upon us but for a mere medallion. Lord Valthalak certainly knows how to hold a grudge.$B$BWe''ll endeavor to find the remaining pieces - hopefully before I meet an untimely demise. But before that, let us see about your reward.'),
(84191, 9020, 'This curse was bestowed upon us but for a mere medallion. Lord Valthalak certainly knows how to hold a grudge.$B$BWe''ll endeavor to find the remaining pieces - hopefully before I meet an untimely demise. But before that, let us see about your reward.'),
(84192, 8957, 'I can''t believe our lives are all but forfeit all because of a stupid medallion! And you''re sure Anthion mentioned Bodley?$B$BWell, you''ve done your job so let''s get your reward out of the way.'),
(84193, 9021, 'This curse was bestowed upon us but for a mere medallion. Lord Valthalak certainly knows how to hold a grudge.$B$BWe''ll endeavor to find the remaining pieces - hopefully before I meet an untimely demise. But before that, let us see about your reward.'),
(84194, 9022, 'This curse was bestowed upon us but for a mere medallion. Lord Valthalak certainly knows how to hold a grudge.$B$BWe''ll endeavor to find the remaining pieces - hopefully before I meet an untimely demise. But before that, let us see about your reward.'),
(84195, 8999, 'I''m going to miss you, $N. I owe you such a debt of gratitude; I think I''ll never be able to repay it.$B$BI hope that you enjoy your new head and chest armor, and that it protects you for a long time to come.'),
(84196, 9000, 'I''m going to miss you, $N. I owe you such a debt of gratitude; I think I''ll never be able to repay it.$B$BI hope that you enjoy your new head and chest armor, and that it protects you for a long time to come.'),
(84202, 9006, 'I''m going to miss you, $N. I owe you such a debt of gratitude; I think I''ll never be able to repay it.$B$BI hope that you enjoy your new head and chest armor, and that it protects you for a long time to come.'),
(84203, 9007, 'I will truly miss you, $N. There is a debt that I owe you, which I may never be able to repay.$B$BEnjoy your new head and chest armor. May it protect you for a long time to come, and help you to achieve even greater honor!'),
(84208, 9011, 'I will truly miss you, $N. There is a debt that I owe you, which I may never be able to repay.$B$BEnjoy your new head and chest armor. May it protect you for a long time to come, and help you to achieve even greater honor!'),
(84210, 9013, 'I will truly miss you, $N. There is a debt that I owe you, which I may never be able to repay.$B$BEnjoy your new head and chest armor. May it protect you for a long time to come, and help you to achieve even greater honor!');
UPDATE `everlake_build_text` s SET s.`missing` = 1 WHERE EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_offer_reward` t WHERE t.`ID` = s.`ID`);
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`, `VerifiedBuild`) SELECT `ID`, `txt`, 0 FROM `everlake_build_text` WHERE `missing` = 1 ORDER BY `ID`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', `ID`, @EVERLAKE_FILE, CONCAT('INFERRED: text of old quest ', `old`) FROM `everlake_build_text` WHERE `missing` = 1;
DROP TEMPORARY TABLE `everlake_build_text`;

CREATE TEMPORARY TABLE `everlake_build_text` (`ID` INT UNSIGNED NOT NULL PRIMARY KEY, `old` INT UNSIGNED NOT NULL, `txt` MEDIUMTEXT NOT NULL, `missing` TINYINT NOT NULL DEFAULT 0) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_build_text` (`ID`, `old`, `txt`) VALUES
(84163, 8926, 'You''re ready to perform the trade?'),
(84164, 8931, 'You''re ready to perform the trade?'),
(84167, 8934, 'You''re ready to perform the trade?'),
(84169, 8936, 'You''re ready to perform the trade?'),
(84170, 8937, 'You''re ready to perform the trade?'),
(84171, 8927, 'You''re ready to perform the exchange?'),
(84177, 8943, 'You''re ready to perform the exchange?'),
(84179, 8951, 'You''re back, $N. You must tell me all about what you''ve found out. But first let us arrange for your reward.'),
(84180, 8952, 'You''re back, $N. You must tell me all about what you''ve found out. But first let us arrange for your reward.'),
(84181, 8953, 'You''re back, $N. You must tell me all about what you''ve found out. But first let us arrange for your reward.'),
(84182, 8954, 'You''re back, $N. You must tell me all about what you''ve found out. But first let us arrange for your reward.'),
(84183, 8955, 'You''re back, $N. You must tell me all about what you''ve found out. But first let us arrange for your reward.'),
(84186, 8959, 'You''re back, $N. You must tell me all about what you''ve found out. But first let us arrange for your reward.'),
(84187, 9016, 'You''ve returned and I see in your eyes that you''ve much to tell me, $N.  Let us take care of your reward first.'),
(84189, 9018, 'You''ve returned and I see in your eyes that you''ve much to tell me, $N.  Let us take care of your reward first.'),
(84190, 9019, 'You''ve returned and I see in your eyes that you''ve much to tell me, $N.  Let us take care of your reward first.'),
(84191, 9020, 'You''ve returned and I see in your eyes that you''ve much to tell me, $N.  Let us take care of your reward first.'),
(84192, 8957, 'You''re back, $N. You must tell me all about what you''ve found out. But first let us arrange for your reward.'),
(84193, 9021, 'You''ve returned and I see in your eyes that you''ve much to tell me, $N.  Let us take care of your reward first.'),
(84194, 9022, 'You''ve returned and I see in your eyes that you''ve much to tell me, $N. Let us take care of your reward first.'),
(84195, 8999, 'As per our deal, are you ready to hand over your Wildheart pieces in exchange for your new Feralheart Cowl and Vest?'),
(84196, 9000, 'As per our deal, are you ready to hand over your Beaststalker pieces in exchange for your new Beastmaster''s Cap and Tunic?'),
(84202, 9006, 'As per our deal, are you ready to hand over your Valor pieces in exchange for your new Helm and Breastplate of Heroism?'),
(84203, 9007, 'As per our deal, are you ready to hand over your Wildheart pieces in exchange for your new Feralheart Cowl and Vest?'),
(84208, 9011, 'As per our deal, are you ready to hand over your Elements pieces in exchange for your new Coif and Vest of The Five Thunders'),
(84210, 9013, 'As per our deal, are you ready to hand over your Valor pieces in exchange for your new Helm and Breastplate of Heroism?');
UPDATE `everlake_build_text` s SET s.`missing` = 1 WHERE EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`) AND NOT EXISTS (SELECT 1 FROM `quest_request_items` t WHERE t.`ID` = s.`ID`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`, `VerifiedBuild`) SELECT `ID`, `txt`, 0 FROM `everlake_build_text` WHERE `missing` = 1 ORDER BY `ID`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', `ID`, @EVERLAKE_FILE, CONCAT('INFERRED: text of old quest ', `old`) FROM `everlake_build_text` WHERE `missing` = 1;
DROP TEMPORARY TABLE `everlake_build_text`;

COMMIT;
