-- 2026_11_20_31_world_everlake_quest_turnin_texts.sql: turn-in texts for quests the realm already has but that lack them (the tracker's "no turn-in text"),
-- from the Icy Veins WoW Forever catalogue (https://db.icy-veins.com/wow-forever/): the quest dialog players' addons
-- recorded on live WoW Forever. Completion text -> quest_offer_reward, progress text -> quest_request_items.
-- Written from public data by a script, checked by hand. Game text belongs to Blizzard Entertainment.
-- A text is written only where every recording has the same wording,
-- and only where the realm has the quest and no text in that table yet: a missing row is added, an empty text filled.
-- 33 completion texts: 79940, 81944, 84394, 87451, 90789, 92065, 93832, 94278, 94291, 94324, 94327, 94329, 94333, 94335, 94341, 94348, 94353, 94354, 94356, 95107, 96075, 96377, 97176, 97179, 97180, 97411, 97446, 98893, 98897, 98901, 99204, 99205, 99208.
-- 28 progress texts: 87451, 90789, 92065, 93832, 94278, 94291, 94324, 94327, 94329, 94333, 94335, 94341, 94348, 94353, 94354, 94356, 95107, 96075, 96377, 97176, 97179, 97180, 97411, 98893, 98897, 98901, 99205, 99208.
-- Each added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing. Not checked in game.
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
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 79940, 'You have few clues to go on so it may be difficult to find Aeonas, but perhaps some of the details I shared with you about the man will help you in your search.$B$BFeel free to speak with me again if you''d like me to remind you about anything we discussed.'),
(2, 81944, 'I... cannot explain this, human,  but I think I have something you need. I came to this land to seek knowledge, and that search led me up the mountain over yonder to a giant stone of light, fallen from the sky. In my contemplation at the stone, An''she gifted me with a great many things. One was a sense of new purpose. Another of which was a vision of you and me, here, having this conversation. I think I gave you this.$B$BPlease, take this totem. Use it well in service of An''she... in service of the light.'),
(3, 84394, 'Thanks to your donations, the library is thriving.$B$BPlease, take this.'),
(4, 87451, 'You say you found this among the ogres that overran Rockard?$B$BI remember... there was a stoneworker who started making these mementos for the warriors stationed there, to help them remember their families. It seems so long ago, but it was just a few years. So many good warriors died.$B$BI''ll make sure to send this on to any surviving family members. The sacrifice of Rockard will be remembered.$B$BThank you, $N.'),
(5, 90789, 'I must say, this shell has a strange aura.  It seems only fitting that part of your reward for retrieving it would be to test its magical capabilities...'),
(6, 92065, 'Words fail to express my gratitude, $N. $B$BOur struggles do not end here, as we will need much time and labor to rebuild. No doubt there will be a few remaining Legashi to rout as well. Nonetheless, you have delivered us from the brink of extinction.$B$BThe Blackmaw will remember you for generations.'),
(7, 93832, 'A rock falls a last time, then. Thank you, bear-friend.'),
(8, 94278, 'Not here to indulge? A shame, it is rare that we have visitors to our humble camp and rarer still that we have a surplus of ale to share.$B$BNo matter, I understand that you have a delivery to complete. Were I in your shoes, I would choose to forego the alcohol if I needed to travel anywhere through the Hinterlands. This forest is a dangerous place.'),
(9, 94291, 'By bolts and bombs! It''s finally time for my shipment of Dark Iron Bombs!$B$BI may be a weaponsmith, but I gotta tell you, I got into the wrong business. Bombs are where it''s at, especially those crafted with Dark Iron. Once I discovered just how destructive they are, I knew immediately I made the wrong career choice.$B$BOh well. At least it''s easy enough to import them all the way from Eastern Kingdoms. May take a few weeks but, eh, a good boom is always worth the trouble.'),
(10, 94324, 'What? Where did you find this? You definitely have not been out here sieging furbolg camps--we would recognize each other by now.$B$BHuh? Alchemists can craft it now? Nobody told me!$B$BJust wait until my guild master finds out about this. Teach me the recipe!!'),
(11, 94327, 'Wait, wait, wait, I take it back! I see you have what I ordered!$B$BI trust then that you did not come all of this way to ridicule me.$B$BIn that case, please just hand them over. I would like to regain my dignity.'),
(12, 94329, 'They sent a undead all the way out here for me? I''d consider that a kindness, were Light''s Hope not a mere stone''s throw away. Sending someone local would have been safer.$B$BAnd quicker.$B$BFortunately I am not dead nor dying, I think anyway. A new chestpiece ought to keep me protected well enough to make the short journey back.$B$BThen, someone''s got a lot of explaining to do...'),
(13, 94333, 'Oh good, my dagger arrived! You''re not gonna believe this story, $C, but I have to tell someone.$B$BThere''s a group of people that travel around murdering merchants in broad daylight. Supposedly that causes their shipments to arrive faster, or something? How does that even work?! If they were just killing people off to steal their loot that''s one thing, but I fail to see how it is supposed to improve shipping times!$B$BAnyway, want to buy something? My stock is limited, and I sell out fast!'),
(14, 94335, 'I can see now the potential beauty in your world''s gems. While they are tarnished and imperfect by nature, a careful and cautious hand can smooth away the blemishes.$B$BThis lens, however, fails to achieve its potential. I can ignore the fingerprints along the oblong rim, but the lens itself will never see with perfect clarity. The lapidary left far too many scars from their careless handling of their knife.$B$BThis lens dulls my dwindling senses. I see fewer glimmers than my own naked eye.$B$BUseless.'),
(15, 94341, 'Hand it over and get lost.'),
(16, 94348, 'I deeply apologize for the journey you must have taken to find me, and I hope the demons around the area did not give you too much trouble during your passage.$B$BNow then, let us complete this transaction. I have much work to do.'),
(17, 94353, 'There was a moment, so very brief, when I believed that this bag was to be offered to me in a moment of true selflessness. As though you read my note, and ventured all this way to offer some comfort to a broken man from another world.$B$BAnd in the moment thereafter, I knew that this was merely an exchange. A transaction, like all others. Are any of your kind capable of true kindness?$B$BNever have I been proven wrong, and I suspect I never will.'),
(18, 94354, 'What in the... how did you know I was in the market for some boots? Well, I am afraid to say you''re too late, bub. I wouldn''t have been caught dead dragging my feet around this place without some proper coverage. Not after what happened last time...$B$B<Gorzeeki shudders.>$B$BI have important stuff to get back to and you look like you aren''t going to take ''no'' for an answer. So I guess now I have a backup pair!'),
(19, 94356, 'Well, at least with these boots I can stomp away whatever scourge monstrosity bursts from the floor I suppose.$B$BThis feels like a prank. Who ordered this? Alen?'),
(20, 95107, 'This staff gave harsh rule to this land. Now Deadwood must lay one of their own to rest.'),
(21, 96075, 'Well done. My buyers will pay well for these. Enjoy the spoils!'),
(22, 96377, '<Renzik''s eyes widen when you show him the box of documents you recovered from Westfall.>$B$BWhere did you say you got this stuff? Found it under some floorboards in a random building? Sure bub... whatever you say.$B$BHere, take this as a reward for your, uh, service... and to help you keep your mouth shut about these documents or anything you read if you peeked at them.'),
(23, 97176, 'Well done, $N. You bear a heavy burden, but know that you have freed these souls from their unending torment. $B$BYour next steps will call on both sacrifice and judgment again. I trust that you will do your duty.'),
(24, 97179, 'This will do, paladin. You paladins are never lacking in resourcefulness, I will give you that.$B$BCome, let me finish your barding for you.'),
(25, 97180, 'This is most impressive work. The only thing more impressive than Ott''s work is his humility. One day I hope to convince him to join our service in a more permanent fashion. As our numbers grow, we will ever be in need of a good smith and his talent is wasted out there on the fringes of Forsaken territory.$B$BWhile this barding would be a fine addition to any normal steed, we are not seeking to empower an ordinary steed. The next step will be... delicate.'),
(26, 97411, 'Ah, yes. Mux will be quite happy with this.$B$BThose bracers were part of a larger armor set.  If you''re interested in providing me with further assistance,  I''d be willing to consider parting with the rest of it.'),
(27, 97446, 'Excellent, $N. I can see in your eyes that you have made a choice.$B$BI am happy to be able to provide you with one of our fine kodo. I must say the one you have picked seems fond of you already. I hope you will take good care of it, and it of you.$B$BMay the Earthmother guide you both.'),
(28, 98893, 'The sands of the Darkspear Islands are awash with the blood of the Alliance you''ve killed. Well done, $N.$B$BFor the horde!'),
(29, 98897, 'You''ve distinguished yourself honorably in battle at the Darkspear Islands and your efforts have not gone unnoticed.$B$BThere are ever more battles to fight, however. Continue to prove yourself in battle and you will surely reap the rewards.'),
(30, 98901, 'You''ve distinguished yourself honorably in battle at the Darkspear Islands and your efforts have not gone unnoticed.$B$BThere are ever more battles to fight, however. Continue to prove yourself in battle and you will surely reap the rewards.'),
(31, 99204, 'Throm''ka, hunter. You are now prepared.$B$BTreat your mount well, and he will bear you with honor. Treat him poorly, and he will throw you into the mud and leave you to the mercy of your enemies. If you''ve come this far, you already know this well. See that you don''t forget it.'),
(32, 99205, 'Greetings again, $C. Your training is now complete. $B$BLet''s get you your first armored saber.'),
(33, 99208, 'Now that you''ve gotten your training to ride a warhorse, let''s find the right mount for you. Just as it was for us in life, the mount often times picks the rider.');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_offer_reward` x WHERE x.`ID` = s.`ID` AND COALESCE(x.`RewardText`, '') <> '') OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, '2026_11_20_31_world_everlake_quest_turnin_texts.sql', 'seen-live: icyveins:addon_dialog (filled an empty RewardText)' FROM `everlake_build_stage` s JOIN `quest_offer_reward` x ON x.`ID` = s.`ID`;
UPDATE `quest_offer_reward` x JOIN `everlake_build_stage` s ON s.`ID` = x.`ID` SET x.`RewardText` = s.`txt`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, '2026_11_20_31_world_everlake_quest_turnin_texts.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s WHERE NOT EXISTS (SELECT 1 FROM `quest_offer_reward` x WHERE x.`ID` = s.`ID`);
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s WHERE NOT EXISTS (SELECT 1 FROM `quest_offer_reward` x WHERE x.`ID` = s.`ID`) ORDER BY s.`n`;
DROP TEMPORARY TABLE `everlake_build_stage`;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `ID` BIGINT NOT NULL, `txt` MEDIUMTEXT NOT NULL);
INSERT INTO `everlake_build_stage` (`n`, `ID`, `txt`) VALUES
(1, 87451, 'What is it now?'),
(2, 90789, 'There is not time to waste!  Have you the shell?'),
(3, 92065, 'My blood boils to think of the suffering we have endured by Varrox''s hand. His reign over the Legashi must come to an end.'),
(4, 93832, 'Do not take your eye off the undead, brave one.'),
(5, 94278, 'Ah, a visitor. Come to partake in our magnificent ale?'),
(6, 94291, 'Huh? What?'),
(7, 94324, 'I have had it with these furbolgs! All I want is some firewater! Why is it so hard to get?'),
(8, 94327, 'What are you staring at? Go away!'),
(9, 94329, 'Don''t mind me. I won the fight. Just... tending to my wounds.'),
(10, 94333, 'Please tell me you''re not one of the crazy ones.'),
(11, 94335, '<Kum''isha scoffs at you.>'),
(12, 94341, 'Shush.'),
(13, 94348, 'Yes?'),
(14, 94353, 'What business might you have with Kum''isha?'),
(15, 94354, 'Hey, hey, why are you looking at me like that? I am supposed to be the one giving people the look of uncertain intent!'),
(16, 94356, 'Watch your step in here--these floorboards are weak and I''ve started to hear skittering underneath ''em.'),
(17, 95107, 'The chief will not stand lone. Bring your own guards and kin to help in the fight.'),
(18, 96075, 'You fetch me those documents yet?'),
(19, 96377, '<It occurs to you that Shaw''s right-hand goblin might be interested to see the documents you''ve recovered from Westfall. Ask him if any of these documents make any sense to him.>'),
(20, 97176, 'So you return, $N. Is your work done in Terrordale?'),
(21, 97179, 'Do you have the materials I require?'),
(22, 97180, 'You''re progressing well, $N. Once you have made your barding, we will discuss your next task.'),
(23, 97411, 'Have you obtained the items I require, $N?'),
(24, 98893, 'What news from the Darkspear Islands, $N?'),
(25, 98897, 'How goes your campaign in the Darkspear Islands, $N?'),
(26, 98901, 'How goes your campaign in the Darkspear Islands, $N?'),
(27, 99205, 'Now you are truly a force to be reckoned with. You are sure to make the kaldorei proud.'),
(28, 99208, 'For the Forsaken!');
DELETE s FROM `everlake_build_stage` s WHERE EXISTS (SELECT 1 FROM `quest_request_items` x WHERE x.`ID` = s.`ID` AND COALESCE(x.`CompletionText`, '') <> '') OR NOT EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`ID`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, '2026_11_20_31_world_everlake_quest_turnin_texts.sql', 'seen-live: icyveins:addon_dialog (filled an empty CompletionText)' FROM `everlake_build_stage` s JOIN `quest_request_items` x ON x.`ID` = s.`ID`;
UPDATE `quest_request_items` x JOIN `everlake_build_stage` s ON s.`ID` = x.`ID` SET x.`CompletionText` = s.`txt`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, '2026_11_20_31_world_everlake_quest_turnin_texts.sql', 'seen-live: icyveins:addon_dialog' FROM `everlake_build_stage` s WHERE NOT EXISTS (SELECT 1 FROM `quest_request_items` x WHERE x.`ID` = s.`ID`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`, `VerifiedBuild`) SELECT s.`ID`, s.`txt`, 0 FROM `everlake_build_stage` s WHERE NOT EXISTS (SELECT 1 FROM `quest_request_items` x WHERE x.`ID` = s.`ID`) ORDER BY s.`n`;
DROP TEMPORARY TABLE `everlake_build_stage`;
COMMIT;
