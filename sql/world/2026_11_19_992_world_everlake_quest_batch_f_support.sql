-- What the quests of 2026_11_19_991_world_everlake_build.sql need besides their rows.
-- 2026_11_19_992_world_everlake_quest_batch_f_support.sql: written by hand.
--
-- 8 more Craftsman's Writs join their tier's world-drop list of 2026_11_19_982 (reference loot 9500001-9500003,
-- INFERRED drops), only once their quest is on the realm.
-- The three stable horses of 98166 "Your First Horse" (270542-270544) open a gossip window so the talk-to objective
-- counts: npcflag 1, only while it is 0.
-- Only rows the world lacks are added; every row goes in the ledger. Never edit this file once it is deployed: a later
-- fix is a new file. Running it again changes nothing. Not tried in game.

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
DROP TEMPORARY TABLE IF EXISTS `everlake_writ_ref`;
CREATE TEMPORARY TABLE `everlake_writ_ref` (`Entry` int unsigned NOT NULL, `Item` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`Entry`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_writ_ref` (`Entry`, `Item`, `note`) VALUES
(9500002, 264091, 'Expert: Craftsman''s Writ: Dark Iron Bomb (quest 94291)'),
(9500003, 264126, 'Artisan: Craftsman''s Writ: Radiant Belt (quest 94326)'),
(9500003, 264127, 'Artisan: Craftsman''s Writ: Orcish War Leggings (quest 94327)'),
(9500003, 264129, 'Artisan: Craftsman''s Writ: Imperial Plate Chest (quest 94329)'),
(9500003, 264133, 'Artisan: Craftsman''s Writ: Ebon Shiv (quest 94333)'),
(9500003, 264148, 'Artisan: Craftsman''s Writ: Chimeric Vest (quest 94348)'),
(9500003, 264156, 'Artisan: Craftsman''s Writ: Felcloth Boots (quest 94356)'),
(9500003, 264160, 'Artisan: Craftsman''s Writ: Soul Pouch (quest 94360)');
UPDATE `everlake_writ_ref` s SET s.`missing` = 1
WHERE EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` IN (94291,94326,94327,94329,94333,94348,94356,94360))
  AND NOT EXISTS (SELECT 1 FROM `reference_loot_template` t WHERE t.`Entry` = s.`Entry` AND t.`ItemType` = 0 AND t.`Item` = s.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'reference_loot_template' AND r.`k1` = s.`Entry` AND r.`k2` = 0 AND r.`k3` = s.`Item`);
INSERT INTO `reference_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`Entry`, 0, s.`Item`, 0, 0, 1, 1, 1, 1, LEFT(s.`note`, 255) FROM `everlake_writ_ref` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'reference_loot_template', s.`Entry`, 0, s.`Item`, '2026_11_19_992_world_everlake_quest_batch_f_support.sql', 'Wowhead Forever writ guide (tier); drop list INFERRED' FROM `everlake_writ_ref` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_writ_ref`;

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template.npcflag', `entry`, 0, 0, 0, '2026_11_19_992_world_everlake_quest_batch_f_support.sql', 'npcflag 0 -> 1 (gossip) for a talk-to objective' FROM `creature_template` WHERE `entry` IN (270542, 270543, 270544) AND `npcflag` = 0;
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` IN (270542, 270543, 270544) AND `npcflag` = 0;
COMMIT;
