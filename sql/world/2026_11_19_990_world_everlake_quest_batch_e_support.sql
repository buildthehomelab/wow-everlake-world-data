-- What the quests of 2026_11_19_989_world_everlake_build.sql need besides their rows.
-- 2026_11_19_990_world_everlake_quest_batch_e_support.sql: written by hand.
--
-- Three more Craftsman's Writs (94263, 94287, 94324) join their tier's world-drop list of 2026_11_19_982
-- (reference loot 9500001-9500003, INFERRED drops), only once their quest is on the realm.
-- Brie (255773), a talk-to target of 93615 "Kits and Cats", has no gossip flag, so nothing opens when clicked and the
-- objective never counts: npcflag 1, only while it is 0.
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
(9500002, 264063, 'Expert: Craftsman''s Writ: Fire Protection Potion (quest 94263)'),
(9500002, 264087, 'Expert: Craftsman''s Writ: Fire Goggles (quest 94287)'),
(9500003, 264124, 'Artisan: Craftsman''s Writ: Distilled Firewater (quest 94324)');
UPDATE `everlake_writ_ref` s SET s.`missing` = 1
WHERE EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` IN (94263,94287,94324))
  AND NOT EXISTS (SELECT 1 FROM `reference_loot_template` t WHERE t.`Entry` = s.`Entry` AND t.`ItemType` = 0 AND t.`Item` = s.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'reference_loot_template' AND r.`k1` = s.`Entry` AND r.`k2` = 0 AND r.`k3` = s.`Item`);
INSERT INTO `reference_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`Entry`, 0, s.`Item`, 0, 0, 1, 1, 1, 1, LEFT(s.`note`, 255) FROM `everlake_writ_ref` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'reference_loot_template', s.`Entry`, 0, s.`Item`, '2026_11_19_990_world_everlake_quest_batch_e_support.sql', 'Wowhead Forever writ guide (tier); drop list INFERRED' FROM `everlake_writ_ref` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_writ_ref`;

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template.npcflag', `entry`, 0, 0, 0, '2026_11_19_990_world_everlake_quest_batch_e_support.sql', 'npcflag 0 -> 1 (gossip) for a talk-to objective' FROM `creature_template` WHERE `entry` = 255773 AND `npcflag` = 0;
UPDATE `creature_template` SET `npcflag` = 1 WHERE `entry` = 255773 AND `npcflag` = 0;
COMMIT;
