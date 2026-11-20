-- Everlake Forge #206: Import, the turn-in and progress words only (32 rows)
-- 2026_11_19_900_world_everlake_forge_00206_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70959) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Icy Veins 2026-11-19 (NOTICE.md, Forge exports).
-- The operation also refreshed 10 drop chances of creature 254588; those lines are left out of this file.
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
-- quest_offer_reward: 18 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `quest_offer_reward` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(87494, 0, 0, 0, 0, 0, 0, 0, 0, 'What a strange scale you\'ve found!$B$BIt looks like the creature must have ingested so much crystal dust that it started suffusing its scale layer. This is probably a result of feeding from an area near a broken crystal, where the dust made its way into the plants, and then was ingested.$B$BI suspect that larger doses would have a profound and visible effect. This beast was fortunate enough to avoid ingesting too much.$B$BI\'ll add this to my collection.', 0),
(90813, 0, 0, 0, 0, 0, 0, 0, 0, 'Oho, ye\'ve really got yer hands on something there! Only the mightiest prospectors could ever hope ta mine something off a bloody giant!$B$BWhat yer holdin\' is a chunk of raw Azsharite, purer than the stuff the giants usually...excrete. A rare find; an\' quite valuable!$B$BI\'d give ye a pretty penny for it, if ye\'d be willing ta trade.', 0),
(91607, 0, 0, 0, 0, 0, 0, 0, 0, 'Whoa mama! You say you mined this straight off a giant? You\'re nuts!$B$BThis is the biggest chunk of Azsharite I\'ve ever seen; and purer than the ... \"gifts\" ... the giants usually drop in the hills.$B$BThat must be heavy; lemme take it off our hands! You\'ll get a generous finder\'s fee, of course.', 0),
(92070, 0, 0, 0, 0, 0, 0, 0, 0, '<The furbolg snatches the necklace, barely acknowledging you. Cradling it in one paw, she runs her other paw over each charm and begins muttering.>$B$BOh...no. No. No! Nama would never have lost her necklace. It was her favorite. She must have...must have...no.$B$B<Before her words nearly devolve into sobs, she composes herself.>$B$BThank you, $R. Better to know the truth of my cub\'s fate, I suppose. But please, leave me now. I\'d like to be alone.', 0),
(93568, 0, 0, 0, 0, 0, 0, 0, 0, 'This belonged to Dahlia, my best friend and favorite feline. Dahlia... I never was creative with names. It fit her though, she was a vibrant, blooming flower in my life.$B$BThe origin of it isn\'t very exciting. I was passing by some dahlia flowers in the garden when this little kitten leapt out at me! So playfully menacing. She followed me back to the temple and... that was that!$B$BNo need to stick around while I reminisce. Here\'s something for your trouble, thank you for resurfacing some old memories.', 0),
(93574, 0, 0, 0, 0, 0, 0, 0, 0, '<The quilboar\'s eyes dart over toward the carapace jutting out from your backpack. He snorts once. Twice. Three times even, before pulling his blade away.>$B$BBig Worm dead?$B$BBig Worm dig through Bristleback land. Eat our dead. Devour our young.$B$BBig worm dead. Big Undead hero of Bristleback. Big Undead allowed in quilboar land. For now.$B$BWhat Big Undead want?', 0),
(93827, 0, 0, 0, 0, 0, 0, 0, 0, 'You bring the sky-witch gems. Good. Their storm will fade, and our wards will hold.', 0),
(93830, 0, 0, 0, 0, 0, 0, 0, 0, '<Fennar strongly sniffs the waterskin.> Ahh, thank you kind one. As you can see, even one pouch\'s worth is a lot to share with our small spring.', 0),
(93971, 0, 0, 0, 0, 0, 0, 0, 0, 'The human swine think they own these lands.$B$B<Krom\'rosh releases a lowly grunt.>$B$BIncreased patrols to the west. Mentions of reinforcements against the growing cultist threat. You\'ve done well, $N.', 0),
(94326, 0, 0, 0, 0, 0, 0, 0, 0, '<Kum\'isha examines the belt. His foul fanged expression flinches--a glimmer of hope for some semblance of approval.>$B$BWould you have been so careless had this been made for your own use? Would you truly present yourself wearing handcrafted equipment so rife with imperfections? $B$BHow many of these flaws are the result of an unpracticed hand, and how many are merely due to your predictable satisfaction with mediocrity?$B$BTake your coin and go, but chin up! So few among us are capable of greatness.', 0),
(94360, 0, 0, 0, 0, 0, 0, 0, 0, 'Master will be pleased! Big pouch for shards. You smart for giving pouch. Would eat you otherwise!$B$B<The imp fiendishly licks his lips.>$B$BStill want eat you. Leave before change mind!', 0),
(95384, 0, 0, 0, 0, 0, 0, 0, 0, 'Strange scroll, you say? Yeah, this looks like some top-grade magic. The GOOD stuff. Thanks for bringin\' it here, friend. Take this as a reward for your time.$B$BNow, let me just see about translating this mess and getting it transcribed into my records...', 0),
(95385, 0, 0, 0, 0, 0, 0, 0, 0, 'A magical scroll? Boy is it my lucky day! I\'ll just copy these runes over to my work and you\'ll get a front-row seat to the dawn of a new legendary engineer. Just don\'t get too close, I don\'t want to have to cut you any royalties... I mean I don\'t want you to get hurt.', 0),
(95935, 0, 0, 0, 0, 0, 0, 0, 0, 'Goodness, and here I thought we only had gnolls to worry about up in the hills!$B$BAlthough, I guess that\'s now true, seeing as how you\'ve delivered this head to me. I suppose I ought to be thankful.$B$BNice work, soldier. You\'ve shown some real grit.', 0),
(95936, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, I envy you, $N. To test my blade against such a foe would have been a thrill.$B$BStill, I honor your victory! You have shown bravery, strength, and protected us from a fearsome threat.$B$BGood work, my brother in arms!', 0),
(97047, 0, 0, 0, 0, 0, 0, 0, 0, '<A wave of relief washes over Wendel\'s face.>$B$BOh, thank you! Thank you so much, friend! You\'ve really saved my hide.', 0),
(97821, 0, 0, 0, 0, 0, 0, 0, 0, '<Dorgaron leaps to the side as you emerge seemingly from thin air offering the artifact to the archaeologist.>$B$BWhoa! Where did you come from?$B$B<His attention darts toward the artifact and he shifts his posture to appraise it from different angles.>$B$BWhere in the Badlands did you find this? Such an incredible find, and one I will be marking down in the books right away. Why don\'t you take it with you on your adventures, and someday you can add it to a museum?', 0),
(98166, 0, 0, 0, 0, 0, 0, 0, 0, 'Excellent, $N! I can see you\'ve made a choice, and what a fine pick it is.$B$BI\'m proud to be able to provide you with one of our horses. I must say the one you have picked seems fond of you already! I hope you will take good care of it, and it of you.$B$BCome back if you ever need new horseshoes! They\'re on the house.', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_offer_reward` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, 0, 0, 0, '2026_11_19_900_world_everlake_forge_00206_import.sql', 'Forge #206: Icy Veins 2026-11-19' FROM `everlake_forge_stage` s;

-- quest_request_items: 14 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `quest_request_items` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(87494, 0, 0, 0, 0, 'Un\'goro is nature at its wildest and most untamed.', 0),
(90813, 0, 0, 0, 0, 'Got somethin\' ta show me?', 0),
(91607, 0, 0, 0, 0, 'What\'s new, paladin? Got something for me?', 0),
(92070, 0, 0, 0, 0, 'Do you know where my cub is? Please, tell me something! Anything!', 0),
(93568, 0, 0, 0, 0, '<Liranne takes the collar and inspects it. She gently cradles the metal tag in her other hand, and flashes a brief smile upon reading it.>', 0),
(93574, 0, 0, 0, 0, '<Kog\'thug has a blade to your throat before you manage to say a word.>', 0),
(93827, 0, 0, 0, 0, 'Harpy magic is raw and primal, able to be shaped by sages.', 0),
(93830, 0, 0, 0, 0, 'Drink if you must while you\'re at the pond, as long as you fill the waterskin back up ere you bring it back.', 0),
(94326, 0, 0, 0, 0, 'My time is nigh infinite, but precious all the same. Speak with intent, or leave without a word.', 0),
(94360, 0, 0, 0, 0, 'Master gone! You got deal? Quick, quick, must seal deal!', 0),
(95935, 0, 0, 0, 0, 'You\'ve got burn marks all over. How did you manage that?', 0),
(95936, 0, 0, 0, 0, 'You are covered in burns and slashes, $C. Must have been quite the battle!', 0),
(97047, 0, 0, 0, 0, '<The young man in the cage is wracked with panic. He can hardly put words together.>', 0),
(97821, 0, 0, 0, 0, 'Huh? What was that?', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_request_items` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, 0, 0, 0, '2026_11_19_900_world_everlake_forge_00206_import.sql', 'Forge #206: Icy Veins 2026-11-19' FROM `everlake_forge_stage` s;


DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
-- Icy Veins writes the player's class and race as <Class> and <Race>; the core's tokens are $C and $R (as in
-- 2026_11_19_900_world_everlake_forge_00196_import.sql). Rows a realm took from the Forge with the brackets are corrected.
UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(REPLACE(`RewardText`, '<Class>', '$C'), '<Race>', '$R')
WHERE `ID` IN (87494,90813,91607,92070,93568,93574,93827,93830,93971,94326,94360,95384,95385,95935,95936,97047,97821,98166) AND (`RewardText` LIKE '%<Class>%' OR `RewardText` LIKE '%<Race>%');
UPDATE `quest_request_items` SET `CompletionText` = REPLACE(REPLACE(`CompletionText`, '<Class>', '$C'), '<Race>', '$R')
WHERE `ID` IN (87494,90813,91607,92070,93568,93574,93827,93830,93971,94326,94360,95384,95385,95935,95936,97047,97821,98166) AND (`CompletionText` LIKE '%<Class>%' OR `CompletionText` LIKE '%<Race>%');
COMMIT;
