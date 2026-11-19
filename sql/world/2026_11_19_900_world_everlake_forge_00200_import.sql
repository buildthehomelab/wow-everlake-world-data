-- Everlake Forge #200: Import, 1 resource(s), 32 row(s)
-- 2026_11_19_900_world_everlake_forge_00200_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70959) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Icy Veins 2026-11-19 (NOTICE.md, Forge exports).
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
-- quest_offer_reward: 24 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `quest_offer_reward` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(86791, 0, 0, 0, 0, 0, 0, 0, 0, 'Rageroar sent you? Well, not a moment too soon.', 0),
(86792, 0, 0, 0, 0, 0, 0, 0, 0, 'This land is lousy with satyr, but your efforts to weaken them are valuable. Perhaps we will strike while their forces are depleted, and they are licking their wounds.', 0),
(86796, 0, 0, 0, 0, 0, 0, 0, 0, 'I am relieved to hear Graal has escaped; his intelligence will be valuable. Thank you, $N. You\'d make a good scout yourself.', 0),
(86797, 0, 0, 0, 0, 0, 0, 0, 0, 'I am relieved to hear that Korsa is safe and that you have made significant progress towards weakening the Legashi. $B$BStill, I fear we may need further reinforcements if we are to defeat Prince Halanox.', 0),
(86799, 0, 0, 0, 0, 0, 0, 0, 0, 'Furze has fallen ill with an unusually vicious sickness, you say?$B$BIt is as I feared; the satyr\'s corruption is upon us.', 0),
(86812, 0, 0, 0, 0, 0, 0, 0, 0, 'So the tincture healed the affected beasts? This is incredible news!$B$BI think it is time to pay Furze a visit and put an end to my people\'s suffering.', 0),
(86813, 0, 0, 0, 0, 0, 0, 0, 0, 'What!? No...$B$B<The elder\'s face falls with grief.>$B$BI don\'t understand. Why Furze and not the beasts? Was he too weak to withstand its effects? Was his corruption too far along? I can\'t know without giving the panacea to another, but how could I justify doing so now?$B$BThis is a great setback, and Furze may sadly never recover. Nonetheless, I must continue my research. The panacea is close. I can\'t give up now. $B$BThis did not end how we wanted, $N, but I still thank you for all you have done.', 0),
(88821, 0, 0, 0, 0, 0, 0, 0, 0, 'So there is a camp of other night elves here? I had no idea.', 0),
(88857, 0, 0, 0, 0, 0, 0, 0, 0, 'So Keldara lives? This is a great relief. I will eagerly await her return.', 0),
(89037, 0, 0, 0, 0, 0, 0, 0, 0, 'Remarkable, the crystal is entirely intact. Its clamoring voices are quite curious; alluring, even. $B$BYou\'ve saved a great piece of history, $C.', 0),
(91696, 0, 0, 0, 0, 0, 0, 0, 0, 'Goma, one of our matriarchs, rushed her cub back into the safety of the den moments ago. Your scent was shared, and it is you we must thank for her life.$B$B<She holds up a resolute paw in a sign of trust.>$B$BTake this, a gift is a small thing. A life is not.', 0),
(91698, 0, 0, 0, 0, 0, 0, 0, 0, '<The maternal voice continues>$B$B\"You free us. I did not think soft-walk folk would stand so true. My thanks deep as root and stone. Deadwood still hunt us. Fight not done yet.\"', 0),
(93196, 0, 0, 0, 0, 0, 0, 0, 0, 'The Gelkis recruit outsiders to perform underhanded war strategies, where our clan would send them off to die.$B$BAnd yet, here you are, $N. An outsider who has demonstrated fierce loyalty to the Magram Clan despite being so unwelcome.$B$BI do not know your motivations, but I recognize first-hand your potential. You have my gratitude, and that of our clan.$B$BTo us, you are no longer an outsider. To us, you are Magram.', 0),
(93444, 0, 0, 0, 0, 0, 0, 0, 0, 'The skies and hills will be much safer now. Thank you, $N. We\'ve been suffering that poisonous venom for too long.', 0),
(93615, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, the young ones are rambunctious and curious. As products of wild magic they lack the fear drive of mortal creatures as well, which makes their rearing... challenging. Soon they will sleep, and dream, and then they will make mischief once more.$B$BAs a token of my esteem, I gift you with this shed claw. Keep sharp memories with it.', 0),
(94263, 0, 0, 0, 0, 0, 0, 0, 0, 'Oh! I\'ve been stuck up here for ages without a way to get down! Nobody\'s taking the time to rescue me and I can\'t climb out, all I can do is jump into the lava... which would kill me without this potion!$B$B<Durganon completes the transaction, and then \"accidentally\" drops the vial.>$B$BWhoops! Guess I\'m stuck here \'til the end of my shift.', 0),
(94287, 0, 0, 0, 0, 0, 0, 0, 0, 'Oh, a clumsy $C is what they sent to deliver my new specs to me? $B$BNow I see how little they care about my wellbeing! This already took two weeks to arrive. TWO WEEKS! How is a dwarf supposed to work with molten lava without protective eyewear?$B$BBah! Take your coin. I am only upholding my end of the deal because you managed to deliver them without a single scratch on the lenses.', 0),
(95196, 0, 0, 0, 0, 0, 0, 0, 0, 'So that\'s the score, $C. I need ye to sneak into that tower and find out what ye can. How \'bout it?', 0),
(95264, 0, 0, 0, 0, 0, 0, 0, 0, '<Shaw reads the words on the page, but shows little outward emotion.>$B$BI... see. Thank you for bringing me this information. I\'ll take it from here, $C. $B$BI must emphatically insist that you keep this to yourself. If word gets out about this before we are ready it won\'t go well for the people of Stormwind.$B$BAs bad as this news is, you\'ve done a tremendous thing for Stormwind, and it won\'t be forgotten. Here--please, take this as a small token of SI:7\'s appreciation for your service.', 0),
(95379, 0, 0, 0, 0, 0, 0, 0, 0, 'What do you mean you didn\'t find his soul stone?!$B$BNo, no, no, NO!! You have failed me! He has ESCAPED. You fool, he will resurrect!$B$B<Felflick seethes for a moment before calming himself.>$B$BNo. This is just a simple setback. Once you free me I will find him on my own. At least in this state he will be severely weakened, and the ward is shattered.$B$B...Yes, perhaps this will work in my favor. No use letting him have a quick death.', 0),
(96381, 0, 0, 0, 0, 0, 0, 0, 0, 'I know, I know, these slimy sea snakes smell worse on the inside than they do on the outside. Just rest easy knowing that the world is a tiny bit better with a few fewer naga slinkin\' about.', 0),
(96799, 0, 0, 0, 0, 0, 0, 0, 0, 'I... have a nephew and that\'s why you came to find me?$B$BI had no idea my brother Denric ever had a child. This is a lot to take in...', 0),
(96812, 0, 0, 0, 0, 0, 0, 0, 0, 'It is encouraging to hear that Sergeant Danneth is willing to take the boy in. We do our best for our orphans, but there\'s nothing quite like real family.$B$BThank you for saving the Sergeant and helping to reunite a family. Please, take this as a reward for your efforts. It\'s not much, but it\'s the least I can do.', 0),
(96983, 0, 0, 0, 0, 0, 0, 0, 0, 'The fall of one of their commanders has weakened the Legion\'s nerve. The chaos will allow my blade to cleave their divisions wide apart.$B$BYou have fought beside me at a decisive moment, and your resolve has not wavered. For that, you have my regard. May the mountain\'s spirits judge you worthy of what you carry forward.$B$BPart of our rite is to pass on weaponry. This is yours now. Value what life in it still remains.$B$BOur paths may cross again, but they do not run together. Farewell.', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_offer_reward` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, 0, 0, 0, '2026_11_19_900_world_everlake_forge_00200_import.sql', 'Forge #200: Icy Veins 2026-11-19' FROM `everlake_forge_stage` s;

-- quest_request_items: 8 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `quest_request_items` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(89037, 0, 0, 0, 0, 'That crystal could hold the key to untold arcane power. To think some lowly murloc just stumbled onto it by chance. It probably views such a thing as nothing more than a shiny bauble.', 0),
(91698, 0, 0, 0, 0, 'The cage stands fastened strong, the crude latch locked.', 0),
(93444, 0, 0, 0, 0, 'Ghansurok is as noxious as it is ferocious. You must not hesitate.', 0),
(93615, 0, 0, 0, 0, 'Have you found my young?', 0),
(94263, 0, 0, 0, 0, 'Where does a dwarf have to sit to get some peace and quiet around here?!', 0),
(94287, 0, 0, 0, 0, 'What do you want? Can\'t you see that I am very busy?$B$B<Durganon glares dead into your eyes as he takes an enormous bite from his bread.>', 0),
(95196, 0, 0, 0, 0, 'Followed a little too close on me heels for my comfort, but it doesn\'t seem ye were followed.', 0),
(96381, 0, 0, 0, 0, 'How goes the \'wet work\'?', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_request_items` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, 0, 0, 0, '2026_11_19_900_world_everlake_forge_00200_import.sql', 'Forge #200: Icy Veins 2026-11-19' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
-- Icy Veins writes the player's class and race as <Class> and <Race>; the core's tokens are $C and $R (as in
-- 2026_11_19_900_world_everlake_forge_00196_import.sql). Rows a realm took from the Forge with the brackets are corrected.
UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(REPLACE(`RewardText`, '<Class>', '$C'), '<Race>', '$R')
WHERE `ID` IN (86791,86792,86796,86797,86799,86812,86813,88821,88857,89037,91696,91698,93196,93444,93615,94263,94287,95196,95264,95379,96381,96799,96812,96983) AND (`RewardText` LIKE '%<Class>%' OR `RewardText` LIKE '%<Race>%');
UPDATE `quest_request_items` SET `CompletionText` = REPLACE(REPLACE(`CompletionText`, '<Class>', '$C'), '<Race>', '$R')
WHERE `ID` IN (86791,86792,86796,86797,86799,86812,86813,88821,88857,89037,91696,91698,93196,93444,93615,94263,94287,95196,95264,95379,96381,96799,96812,96983) AND (`CompletionText` LIKE '%<Class>%' OR `CompletionText` LIKE '%<Race>%');
COMMIT;
