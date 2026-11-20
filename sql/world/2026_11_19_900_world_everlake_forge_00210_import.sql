-- Everlake Forge #210: Import, 1 resource(s), 32 row(s)
-- 2026_11_19_900_world_everlake_forge_00210_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
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
-- quest_offer_reward: 22 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `quest_offer_reward` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(86804, 0, 0, 0, 0, 0, 0, 0, 0, 'This looks promising.', 0),
(86925, 0, 0, 0, 0, 0, 0, 0, 0, 'Paper in hand, peering over the cauldron, you begin to make sense of the satyr\'s scrawled instructions.', 0),
(89053, 0, 0, 0, 0, 0, 0, 0, 0, '<The artifacts you gathered for Saria lay in the knapsack before you.>', 0),
(90702, 0, 0, 0, 0, 0, 0, 0, 0, 'I can\'t quite make out the name, but the name Belle is familiar...$B$BI apologize, $N. Years have passed and my memory is not what it once was. I will hold onto this for the time being. Perhaps it will come back to me.', 0),
(92100, 0, 0, 0, 0, 0, 0, 0, 0, 'You see a well-worn, embroidered leather scabbard lying inconspicuously on the stone.', 0),
(92858, 0, 0, 0, 0, 0, 0, 0, 0, 'I see; nicely done.$B $BAs promised, I gladly grant you this reward. You\'ve done all of Feralas a great favor.', 0),
(93443, 0, 0, 0, 0, 0, 0, 0, 0, 'Where did you say you found this? I\'m surprised you\'re still fully intact. Thanks, kid.$B$BY\'know. If you\'re in the habit of doin\' favors, I bet plenty of folk \'round here will have a use for ya. Why don\'tcha stick around for a bit?', 0),
(93521, 0, 0, 0, 0, 0, 0, 0, 0, 'This explains much. Ve\'han\'s notes describe how the Wild King brokered a deal with the warlocks of the Ashen Reign. He has combined their soul-prisons with his druidic magic to trap and siphon the Wild Gods.$B$BVe\'han seems to have been trying to emulate this magic for himself. If what we witnessed was unskilled imitation, I shudder to think what the true architect of this magic could be capable of.', 0),
(94479, 0, 0, 0, 0, 0, 0, 0, 0, 'Ah, yes, the solid cast pieces of metal used to build the war machines that ravaged these hills years ago. Many have already been reclaimed by survivors or beasts. This piece is different--one I think that a particular engineer might still be looking for.', 0),
(94895, 0, 0, 0, 0, 0, 0, 0, 0, 'Where did you say you found this? I\'m surprised you\'re still fully intact. Thanks, kid.$B$BY\'know. If you\'re in the habit of doin\' favors, I bet plenty of folk \'round here will have a use for ya. Why don\'tcha stick around for a bit?', 0),
(95325, 0, 0, 0, 0, 0, 0, 0, 0, '<A grease covered tome filled with notes of business deals between the Venture Co. and its associates.>', 0),
(95326, 0, 0, 0, 0, 0, 0, 0, 0, 'That\'s more like it! If a caravaneer can\'t be trusted with a delivery, what else does he have? $B$BSay, you don\'t need help shipping this to Powderfuse Port, do ya?', 0),
(95882, 0, 0, 0, 0, 0, 0, 0, 0, 'The scoutmaster is dead, is he? Almost a shame you had to kill him. He deserved a life of wandering the world blind after everything he has seen.$B$BGood work, $N. The Riverglades have become that much safer to traverse for the Horde.', 0),
(96255, 0, 0, 0, 0, 0, 0, 0, 0, 'Whoa, what happened to you? You look terrible. I mean, you did anyway, but you look extra terrible and caked with goo.$B$B<Felflick listens as you recount the slime encounter and grins.>$B$BReally now? Fascinating. I guess the slime eating the first \'Master of Slimes\' warlock did something, and the newly added warlock bones gave it a bit of awareness? I wonder if their minds all fused together at the end.$B$BWell regardless, I\'ll keep that little gem in the back of my mind for later.', 0),
(96435, 0, 0, 0, 0, 0, 0, 0, 0, '<There is something deeply unsettling about this bone pile. Perhaps caution would be wise?>', 0),
(96438, 0, 0, 0, 0, 0, 0, 0, 0, '<A Broken Warhammer lies before you surrounded by Scarlet Crusade and Burning Blade Corpses.>', 0),
(96550, 0, 0, 0, 0, 0, 0, 0, 0, 'It\'s... it\'s too much, yet. The darkness in my mind clouds how I remember it.$B$BCould he be in the same torpor, restless as I was? Soul suffocated by the stench of walking amongst the dead?', 0),
(96558, 0, 0, 0, 0, 0, 0, 0, 0, '<Dark spirits lingered here, feeding on doubt. The magic animating frost wyrms twists their will, leaving unnatural spirits behind. $B$BWith the haunting presence fading, the contents of the battle cache reflect the light more brightly.>', 0),
(96784, 0, 0, 0, 0, 0, 0, 0, 0, '<Anastasia\'s eyes narrow with suspicion.>$B$B...how exactly do you know about the deal?', 0),
(96998, 0, 0, 0, 0, 0, 0, 0, 0, 'Dis... dis be a Darkspear battle wrap. See how it wrinkle dis way? Means it was rolled tight, yeah? Keep da colors from bleedin\' together.$B$BWe paint fresh before battle--keep da spirits stirred, keep da strength flowin\'. Old ways. Important ones.', 0),
(97000, 0, 0, 0, 0, 0, 0, 0, 0, 'Opening the dusty wardrobe, it\'s clear no beast nor hands have disturbed it since it was used.$B$BAlong with formal clothes, work aprons, and linens--papers and sketches are strewn on the bottom of the cabinet.$B$BYou lift a book to look more closely and realize it\'s a ledger of property owned by the Sawyer family.', 0),
(97001, 0, 0, 0, 0, 0, 0, 0, 0, 'This is more than I expected. Yes, we made our living selling bows, arrows, and wagons. Always in demand, and with dry lumber we could turn over a wagon and have it fully stocked with our goods in a single day.$B$BThanks. Having this ledger may allow me to reclaim some of our land.', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_offer_reward` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, 0, 0, 0, '2026_11_19_900_world_everlake_forge_00210_import.sql', 'Forge #210: Icy Veins 2026-11-19' FROM `everlake_forge_stage` s;

-- quest_request_items: 10 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `quest_request_items` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(86925, 0, 0, 0, 0, 'I need to find that recipe.', 0),
(90702, 0, 0, 0, 0, 'Help you with something?', 0),
(92858, 0, 0, 0, 0, 'Come to collect the bounty for Ohk\'zi?', 0),
(93521, 0, 0, 0, 0, 'What is that book?', 0),
(94479, 0, 0, 0, 0, 'Yes?', 0),
(95326, 0, 0, 0, 0, 'Well? You find out who took my stuff?', 0),
(95882, 0, 0, 0, 0, 'Keep your voice down. The humans are always watching.', 0),
(96435, 0, 0, 0, 0, '<This appears to be the bone pile Felflick had mentioned. There certainly seems to be plenty of slime.>', 0),
(96998, 0, 0, 0, 0, 'Days be gettin\' faster...', 0),
(97001, 0, 0, 0, 0, 'Are you back from Hyjal already?', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_request_items` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, 0, 0, 0, '2026_11_19_900_world_everlake_forge_00210_import.sql', 'Forge #210: Icy Veins 2026-11-19' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
