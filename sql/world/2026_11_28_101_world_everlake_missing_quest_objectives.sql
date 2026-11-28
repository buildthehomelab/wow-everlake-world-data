-- Quest objectives the client has on live that the realm's quests lack, so those quests finish without them.
-- 2026_11_28_101_world_everlake_missing_quest_objectives.sql: written by hand, not tried in game (2026-11-28).
--
-- Checked: every quest objective in Icy Veins' Forever quest records (6,368, from the client's QuestObjective data, with
-- their ids) against quest_objectives on the PTR, by id and by quest + type + object. 85 are missing on 80 quests: a quest
-- without them is complete as soon as it is taken (no gold paid, no reputation needed, no item or talk needed).
-- Added, 61 objectives on 58 quests, with the client's ids, types, amounts and flags:
--   Gold (37): An Earnest Proposition (16 class quests, 20 gold each), the five Librams of the Burning Steppes (30 gold),
--   Emphasis on Sacrifice and Collection of Goods (150 gold), Manna-Enriched Horse Feed (50 gold), The Ectoplasmic
--   Distiller, The Dread Citadel - Naxxramas (60 and 30 gold), The Ice Guard and The Shadow Guard, Membership Card
--   Renewal (4), More Sparklematic Action (3), Mold Rhymes With...
--   Reputation (13): Avast Ye, Scallywag and Avast Ye, Admiral! (Bloodsail Buccaneers 3000 and below -6001 with Booty
--   Bay), Mantles of the Dawn and Chromatic Mantle of the Dawn (Argent Dawn), Paragons of Power (Zandalar Tribe), The Root
--   of All Evil and The Brokering of Peace (Timbermaw Hold), The Dread Citadel - Naxxramas (Argent Dawn).
--   Talking to an NPC (3), which the core credits as the gossip opens (WorldSession::HandleGossipHelloOpcode): Ragged
--   John's Story (The True Masters 4224), Speak with Squire Rowe (Stormwind Rendezvous 6402: Rowe's script still sees the
--   quest complete and calls Windsor), Speak with Lumina Windsinger (The Debt 95034).
--   Items (8) the realm hands out or drops: Water of the Seers for Rite of Vision (given at the start), Three Kings of
--   Flame's 279415, and the Season of Discovery book quests' items (gameobject loot).
-- Gold and reputation rows use StorageIndex -1, as the realm's others. Where the realm already fills a quest's Order or
-- StorageIndex slot, the new row takes the next free one.
-- Left out: quests marked unused or NYI; objectives with no way to earn them on the realm (How Big a Threat?'s furbolg
-- camp, Meet at the Grave, Lady Prestor's advice, Kerlonian's escort, the Deadmines detonator, Rapid Escape's item, the
-- 274895 honor items for For Great Honor / Concerted Efforts, Dragonslayer's Helm and Shield); Saving Sharpbeak (the
-- realm builds it differently); quests no one gives; Blood in the Streets' type 19 objective.
-- Rows only go in while the quest exists and neither the id nor an objective of that type and object is there. Every
-- added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file.
-- Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_28_101_world_everlake_missing_quest_objectives.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_qobj`;
CREATE TEMPORARY TABLE `everlake_qobj` (`id` INT UNSIGNED NOT NULL PRIMARY KEY, `quest` INT UNSIGNED NOT NULL, `type` TINYINT UNSIGNED NOT NULL,
  `ord` TINYINT UNSIGNED NOT NULL, `si` TINYINT NOT NULL, `obj` INT NOT NULL, `amount` INT NOT NULL, `flags` INT UNSIGNED NOT NULL,
  `flags2` INT UNSIGNED NOT NULL, `weight` FLOAT NOT NULL, `parent` INT UNSIGNED NOT NULL, `descr` TEXT NULL, `ok` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_qobj` (`id`, `quest`, `type`, `ord`, `si`, `obj`, `amount`, `flags`, `flags2`, `weight`, `parent`, `descr`) VALUES
(480587,772,1,0,0,4823,1,36,1,0,0,NULL),
(381105,1036,6,0,-1,87,3000,32,0,0,0,NULL),
(381106,1036,7,1,-1,21,-6001,40,0,0,0,NULL),
(390878,2953,8,1,-1,0,300,32,0,0,0,NULL),
(390890,3644,8,0,-1,0,20000,32,0,0,0,NULL),
(390891,3645,8,0,-1,0,20000,32,0,0,0,NULL),
(390901,3646,8,0,-1,0,20000,32,0,0,0,NULL),
(390900,3647,8,0,-1,0,20000,32,0,0,0,NULL),
(476336,4224,0,0,0,9563,1,32,0,0,0,'Ragged John''s Story'),
(390868,4463,8,8,-1,0,300000,32,0,0,0,NULL),
(390871,4481,8,8,-1,0,300000,32,0,0,0,NULL),
(390884,4482,8,8,-1,0,300000,32,0,0,0,NULL),
(390885,4483,8,8,-1,0,300000,32,0,0,0,NULL),
(390881,4484,8,8,-1,0,300000,32,0,0,0,NULL),
(390914,4603,8,1,-1,0,300,32,0,0,0,NULL),
(390912,4604,8,1,-1,0,300,32,0,0,0,NULL),
(383676,4621,6,2,-1,87,3000,32,0,0,0,NULL),
(383677,4621,7,3,-1,21,-6001,40,0,0,0,NULL),
(381749,5504,6,1,-1,529,21000,32,0,0,0,NULL),
(390902,5514,8,1,-1,0,150000,32,0,0,0,NULL),
(381631,5517,6,1,-1,529,42000,32,0,0,0,NULL),
(381638,5521,6,1,-1,529,42000,32,0,0,0,NULL),
(476346,6402,0,0,0,17804,1,32,0,0,0,'Speak with Squire Rowe'),
(390920,7637,8,0,-1,0,1500000,32,0,0,0,NULL),
(390921,7642,8,8,-1,0,1500000,32,0,0,0,NULL),
(390922,7645,8,1,-1,0,500000,32,0,0,0,NULL),
(382925,8059,6,1,-1,270,3000,32,0,0,0,NULL),
(383147,8077,6,1,-1,270,21000,32,0,0,0,NULL),
(381714,8481,6,2,-1,576,42000,32,0,0,0,NULL),
(382071,8484,6,1,-1,576,42000,32,0,0,0,NULL),
(382143,8485,6,1,-1,576,42000,32,0,0,0,NULL),
(390867,8905,8,2,-1,0,200000,32,0,0,0,NULL),
(390869,8906,8,2,-1,0,200000,32,0,0,0,NULL),
(390873,8907,8,2,-1,0,200000,32,0,0,0,NULL),
(390875,8908,8,2,-1,0,200000,32,0,0,0,NULL),
(390893,8909,8,2,-1,0,200000,32,0,0,0,NULL),
(390872,8910,8,2,-1,0,200000,32,0,0,0,NULL),
(390879,8911,8,2,-1,0,200000,32,0,0,0,NULL),
(390876,8912,8,2,-1,0,200000,32,0,0,0,NULL),
(390889,8913,8,2,-1,0,200000,32,0,0,0,NULL),
(390896,8914,8,2,-1,0,200000,32,0,0,0,NULL),
(390894,8915,8,2,-1,0,200000,32,0,0,0,NULL),
(390888,8916,8,2,-1,0,200000,32,0,0,0,NULL),
(390886,8917,8,2,-1,0,200000,32,0,0,0,NULL),
(390895,8918,8,2,-1,0,200000,32,0,0,0,NULL),
(390917,8919,8,2,-1,0,200000,32,0,0,0,NULL),
(390918,8920,8,2,-1,0,200000,32,0,0,0,NULL),
(390915,8921,8,8,-1,0,400000,32,0,0,0,NULL),
(384644,8961,1,2,2,279415,1,32,1,0,0,NULL),
(390887,9121,8,7,-1,0,600000,32,0,0,0,NULL),
(382874,9122,6,2,-1,529,21000,32,0,0,0,NULL),
(390897,9122,8,3,-1,0,300000,32,0,0,0,NULL),
(390924,9211,8,1,-1,0,300000,32,0,0,0,NULL),
(390923,9213,8,1,-1,0,300000,32,0,0,0,NULL),
(443984,78146,1,0,0,209848,1,32,0,0,0,NULL),
(443986,78148,1,0,0,209850,1,32,0,0,0,NULL),
(446383,79535,1,0,1,213165,1,32,0,0,0,NULL),
(449022,81947,1,0,0,220345,1,32,0,0,0,NULL),
(449033,81952,1,0,0,220348,1,32,0,0,0,NULL),
(449035,81953,1,0,0,220349,1,32,0,0,0,NULL),
(469647,95034,0,1,3,259620,1,32,0,0,0,'Speak with Lumina Windsinger');

UPDATE `everlake_qobj` x SET x.`ok` = 1
WHERE EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = x.`quest`)
  AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.`ID` = x.`id`)
  AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.`QuestID` = x.`quest` AND o.`Type` = x.`type` AND o.`ObjectID` = x.`obj`)
  AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.`QuestID` = x.`quest` AND (o.`Order` = x.`ord` OR (x.`si` >= 0 AND o.`StorageIndex` = x.`si`)));

INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `ConditionalAmount`, `Flags`, `Flags2`,
    `ProgressBarWeight`, `ParentObjectiveID`, `Visible`, `Description`, `VerifiedBuild`)
SELECT x.`id`, x.`quest`, x.`type`, x.`ord`, x.`si`, x.`obj`, x.`amount`, 0, x.`flags`, x.`flags2`, x.`weight`, x.`parent`, 1, x.`descr`, 0
FROM `everlake_qobj` x WHERE x.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'quest_objectives', x.`id`, 0, 0, 0, @EVERLAKE_FILE, CONCAT('quest ', x.`quest`, ' type ', x.`type`, ' object ', x.`obj`, ' x', x.`amount`, ' (client data via Icy Veins)')
FROM `everlake_qobj` x WHERE x.`ok` = 1;
DROP TEMPORARY TABLE `everlake_qobj`;

COMMIT;
