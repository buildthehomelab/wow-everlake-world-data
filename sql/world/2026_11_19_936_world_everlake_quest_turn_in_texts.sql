-- Turn-in texts for 29 quests, and the four Forever cloth donations handed in like the original game's.
-- 2026_11_19_936_world_everlake_quest_turn_in_texts.sql: written by hand.
--
-- 1. Turn-in texts. These quests had no quest_request_items or quest_offer_reward row, so their turn-in window showed
--    nothing: the Earnest Proposition bracer trades (84147-84162, 97447), Arathi Basin's Control Five / Take Four /
--    Take Five Bases (8115, 8121, 8122), The Keeper's Call (9247), Dragonslayer's Lance (78134), Jarl Needs a Blade
--    (81570), Chains That Bind (81917), Brought to Heel (81919), Leather for Inclement Weather (90854), The Grand
--    Alliance (91882), Now We're Cooking (92433), Visions of Another (93679), The Found One (93684), Material Assistance
--    (97168) and The Darkreaver Menace (97169). Texts from their Wowhead Forever pages (Progress / Completion),
--    2026-11-19; <name>, <race> and <class> written as $n, $r and $c. Where Wowhead shows no progress text, the quest
--    gets its completion text only. A row is only added where the world has none.
--
--    Left out, because no source has a turn-in text for them (Wowhead Forever shows none, and VMaNGOS's newest row
--    has none either): The Black Box (708), Vimes's Report (1288), The Legend of Korrak (7181), Korrak the Bloodrager
--    (7202), Defusing the Threat (7367, 7368), To Serve Kum'isha (93685).
--
-- 2. Cloth donations. A Donation of Wool / Silk to the High Order (99191, 99192) and the Windshapers (99196, 99197)
--    were QuestType 2 with no giver's text. On Wowhead Forever their page has only a progress and a completion text:
--    the giver takes the cloth straight away. That is how the original game's donations work on this realm too
--    (A Donation of Wool 7791 / 7792: QuestType 0, no giver's text). They become QuestType 0 (handed in without being
--    accepted), only while they are still QuestType 2 with no giver's text. Not checked in game.
--
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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

-- quest_request_items: progress texts for quests the world has no row for
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`ID` int unsigned NOT NULL, `CompletionText` mediumtext, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`ID`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`ID`, `CompletionText`, `note`) VALUES
(84147, 'Have you brought me what I requested of you, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84148, 'Have you brought me what I requested of you, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84149, 'Have you brought me what I requested of you, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84150, 'Have you brought me what I requested of you, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84154, 'Have you brought me what I requested of you, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(97447, 'Have you brought me what I requested of you, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84155, 'Have you obtained the items I require, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84156, 'Have you obtained the items I require, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84157, 'Have you obtained the items I require, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84158, 'Have you obtained the items I require, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84159, 'Have you obtained the items I require, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84160, 'Have you obtained the items I require, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84161, 'Have you obtained the items I require, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84162, 'Have you obtained the items I require, $n?', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(8115, 'You have not yet completed your mission, $n.  It is difficult, but my faith in you is strong.', 'wowhead-forever@2026-11-19'), -- Control Five Bases
(8121, 'Return to Arathi Basin, $n, and perform the task for which you were sent to do!  Capture and hold four bases!', 'wowhead-forever@2026-11-19'), -- Take Four Bases
(9247, 'Ah, $n, it is good to see you.', 'wowhead-forever@2026-11-19'), -- The Keeper's Call
(78134, 'The lance of the Dragonslayer has changed hands many times. Every now and then, rumor spreads of it appearing in black market arms deals. Perhaps the lance''s current unsavory proprietor would be willing to part with it; for a price.', 'wowhead-forever@2026-11-19'), -- Dragonslayer's Lance
(81570, 'You have my blade??', 'wowhead-forever@2026-11-19'), -- Jarl Needs a Blade
(81917, 'Have you found a tool to weaken Calefactus, $r?', 'wowhead-forever@2026-11-19'), -- Chains That Bind
(81919, 'Find that core hound quickly, $n. Before the Twilight''s Hammer finds him first.', 'wowhead-forever@2026-11-19'), -- Brought to Heel
(90854, 'You got da supplies?', 'wowhead-forever@2026-11-19'), -- Leather for Inclement Weather
(92433, 'How goes the hunt? You got some Savory Stag Sliders for me?', 'wowhead-forever@2026-11-19'), -- Now We're Cooking
(97168, 'I feel a burden asking for material assistance, but my divination scryer--the device I''m hopin'' ta finish--requires one o'' each. If ye cannot help me, I''d not hold it against ye.', 'wowhead-forever@2026-11-19'), -- Material Assistance
(97169, 'Time is critical, $n - have you succeeded in stopping Death Knight Darkreaver''s threat?', 'wowhead-forever@2026-11-19'); -- The Darkreaver Menace
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `quest_request_items` t WHERE t.`ID` = s.`ID`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`) SELECT `ID`, `CompletionText` FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, '2026_11_19_936_world_everlake_quest_turn_in_texts.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_19_936_world_everlake_quest_turn_in_texts.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

-- quest_offer_reward: completion texts for quests the world has no row for
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`ID` int unsigned NOT NULL, `RewardText` mediumtext, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`ID`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`ID`, `RewardText`, `note`) VALUES
(84147, 'Excellent!  Let''s perform the trade then.  It''s hard to part with this excellent armor, but I''m afraid I won''t be needing it any time soon.\r\n\r\nIf you''re interested in performing more work for me, I might be willing to give up the rest of the pieces.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84148, 'Excellent!  Let''s perform the trade then.  It''s hard to part with this excellent armor, but I''m afraid I won''t be needing it any time soon.\r\n\r\nIf you''re interested in performing more work for me, I might be willing to give up the rest of the pieces.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84149, 'Excellent!  Let''s perform the trade then.  It''s hard to part with this excellent armor, but I''m afraid I won''t be needing it any time soon.\r\n\r\nIf you''re interested in performing more work for me, I might be willing to give up the rest of the pieces.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84150, 'Excellent!  Let''s perform the trade then.  It''s hard to part with this excellent armor, but I''m afraid I won''t be needing it any time soon.\r\n\r\nIf you''re interested in performing more work for me, I might be willing to give up the rest of the pieces.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84154, 'Excellent!  Let''s perform the trade then.  It''s hard to part with this excellent armor, but I''m afraid I won''t be needing it any time soon.\r\n\r\nIf you''re interested in performing more work for me, I might be willing to give up the rest of the pieces.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(97447, 'Excellent! Let''s perform the trade then. It''s hard to part with this excellent armor, but I''m afraid I won''t be needing it any time soon.\r\n\r\nIf you''re interested in performing more work for me, I might be willing to give up the rest of the pieces.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84155, 'Ah, yes.  Mux will be quite happy with this.\r\n\r\nThose bracers were part of a larger armor set.  If you''re interested in providing me with further assistance,  I''d be willing to consider parting with the rest of it.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84156, 'Ah, yes.  Mux will be quite happy with this.\r\n\r\nThose bracers were part of a larger armor set.  If you''re interested in providing me with further assistance,  I''d be willing to consider parting with the rest of it.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84157, 'Ah, yes.  Mux will be quite happy with this.\r\n\r\nThose bracers were part of a larger armor set.  If you''re interested in providing me with further assistance,  I''d be willing to consider parting with the rest of it.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84158, 'Ah, yes.  Mux will be quite happy with this.\r\n\r\nThose bracers were part of a larger armor set.  If you''re interested in providing me with further assistance,  I''d be willing to consider parting with the rest of it.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84159, 'Ah, yes.  Mux will be quite happy with this.\r\n\r\nThose bracers were part of a larger armor set.  If you''re interested in providing me with further assistance,  I''d be willing to consider parting with the rest of it.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84160, 'Ah, yes.  That old goblin shall be quite happy with this blood.\r\n\r\nThose bracers were part of a larger armor set.  If you''re interested in providing me with further assistance I''d be willing to consider parting with the rest of it.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84161, 'Ah, yes.  Mux will be quite happy with this.\r\n\r\nThose bracers were part of a larger armor set.  If you''re interested in providing me with further assistance,  I''d be willing to consider parting with the rest of it.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(84162, 'Ah, yes.  Mux will be quite happy with this.\r\n\r\nThose bracers were part of a larger armor set.  If you''re interested in providing me with further assistance,  I''d be willing to consider parting with the rest of it.', 'wowhead-forever@2026-11-19'), -- An Earnest Proposition
(8115, 'You did it!  You took all of the bases!  Well done, $n!\r\n\r\nThere were those who doubted your chances, but I knew you could do it.  Thank you, and know that the League of Arathor holds you in high regard, just as the Defilers of the Forsaken must fear the very mention of your name!', 'wowhead-forever@2026-11-19'), -- Control Five Bases
(8121, 'Good work, $n!  Your latest actions in Arathi Basin were quite difficult, and so their successes are quite praiseworthy.  The League of Arathor must be reeling from the last skirmishes in the basin, licking their wounds and, let us hope, rethinking their choice to fight here.', 'wowhead-forever@2026-11-19'), -- Take Four Bases
(8122, 'The cries of the Alliance as you and your compatriots attacked them could be heard even from here, $n.  I can almost pity them for the pain and fear you delivered to their ranks.  Almost, but not quite.\r\n\r\nYour value to the Defilers is without question.  Your deeds in Arathi Basin have been most impressive, and have echoed among the chambers of Varimathras... and the Dark Lady herself.', 'wowhead-forever@2026-11-19'), -- Take Five Bases
(9247, 'Simply by answering the call, we are in your debt, $n. The Argent Dawn is certain that through your shining example, others that are here to aid us will gain great insight into how best to throw back this Scourge Invasion!', 'wowhead-forever@2026-11-19'), -- The Keeper's Call
(78134, 'Splendid job, $n! With this, I am one step further on my path to glory.', 'wowhead-forever@2026-11-19'), -- Dragonslayer's Lance
(81570, 'That''s a good blade.  It has a good swing.  It''s a good swing blade.  Thank you.  Thank you, thank you, thank you!!!  Now I want to try it....\r\n\r\nLater.  I''ll try it later.  But like I was saying... thanks.', 'wowhead-forever@2026-11-19'), -- Jarl Needs a Blade
(81917, 'Interesting... yes, I can work with this.', 'wowhead-forever@2026-11-19'), -- Chains That Bind
(81919, 'Such an exquisite sample! Who knows what mysteries lie in the essence of a beast from beyond the portal?\r\n\r\nAs thanks, you may keep the lasso. I doubt I''ll ever have use for such a thing, anyway.', 'wowhead-forever@2026-11-19'), -- Brought to Heel
(90854, 'Yeah, dis work nicely.\r\n\r\nHere, lemme show you something special. We gonna put all of dis to good use.', 'wowhead-forever@2026-11-19'), -- Leather for Inclement Weather
(91882, 'Yes, we are the survivors you seek. As you can see, we''ve been forced to keep... uneasy company.\r\n\r\nOnce the threat of Archimonde was gone, prior hostilities flared to the surface again. Though Alliance and Horde can work together in the face of the Scourge, we do not forget our old conflicts, nor do we forgive.\r\n\r\nIt is survival that binds us, not friendship.', 'wowhead-forever@2026-11-19'), -- The Grand Alliance
(92433, 'Hey, this is great! Thanks! We''re gonna eat well today!\r\n\r\nUsually I just heat up some stag steaks over a bucket of water. Here, I''ll give you the recipe.', 'wowhead-forever@2026-11-19'), -- Now We're Cooking
(93679, 'So, there is another of our kind who also seeks a draenethyst sphere? This is most curious...', 'wowhead-forever@2026-11-19'), -- Visions of Another
(93684, 'You come to Kum''isha speaking of draenethyst, $r? What could you possibly know of such a thing?', 'wowhead-forever@2026-11-19'), -- The Found One
(97168, 'Your generosity is unrivaled, $n. I thank ye for yer kindness.\r\n\r\nI will be able to finish my divination scryer now, and I should be able to fashion more without further need o'' diamonds... perhaps you would be interested in helping me in its use? It is for a most important task, I assure you... one that left unchecked could spell unmitigated disaster for the spirit realm!', 'wowhead-forever@2026-11-19'), -- Material Assistance
(97169, 'This is a victory to savor, $n! The demise of Darkreaver should restore the fragile fetters that anchor the spirit realm.\r\n\r\nYou have far exceeded what was asked of you, even when you had no notion of reward or compensation. You are truly a $c of worth, my friend.\r\n\r\nI know that acting to preserve the spirit realm should be thanks enough, but please - accept this simple gift with my thanks.', 'wowhead-forever@2026-11-19'); -- The Darkreaver Menace
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `quest_offer_reward` t WHERE t.`ID` = s.`ID`);
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`) SELECT `ID`, `RewardText` FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, '2026_11_19_936_world_everlake_quest_turn_in_texts.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_19_936_world_everlake_quest_turn_in_texts.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

-- The Forever cloth donations: handed in without being accepted, like the original game's (7791, 7792)
UPDATE `quest_template`
SET `QuestType` = 0
WHERE `ID` IN (99191, 99192, 99196, 99197) AND `QuestType` = 2
  AND COALESCE(`QuestDescription`, '') = '' AND COALESCE(`LogDescription`, '') = '';

COMMIT;
