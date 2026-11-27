-- Five containers that opened empty get their contents from Wowhead.
-- 2026_11_27_61_world_everlake_container_contents.sql: written from the tracker's Wowhead pages (tabs.contains), by a script run once.
--
-- Follow-up to 2026_11_27_60_world_everlake_empty_containers.sql: the tracker's 'contents' check found 20 items with the
-- client's HAS_LOOT flag and no loot. Their Wowhead pages were crawled again on 11-27; five list what they contain:
--   13247  Quartermaster Zigris' Footlocker       78 green armour pieces, 3,993 opened (about 2.2 a time)
--   272151 Damaged Undermine Supply Crate         19 herbs, ores, leather, fish..., 130 opened
--   280567 Small Sack of Gems                     6 low gems, each about 46%, 5,736 opened
--   280943 Tome of Tremayne Family Blacksmithing  8 Plans, 567 opened, exactly one a time: one group, equal shares
--   285366 Whirleygig's Supply Stash              4 engineering parts, 398 opened
-- Every other row is its own roll: Chance = times seen / times opened, MinCount/MaxCount = Wowhead's stack range.
-- The other 15 have no Contains tab on Wowhead (coin purses, packages and others): left as they are.
--
-- Adds a row only while that Entry has no row for that Item; added rows go in the ledger. Never edit this file once
-- it is deployed: a later fix is a new file. Running it again changes nothing. Not tried in game.

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

DROP TEMPORARY TABLE IF EXISTS `everlake_contents`;
CREATE TEMPORARY TABLE `everlake_contents` (
  `Entry` int unsigned NOT NULL, `Item` int unsigned NOT NULL, `Chance` float NOT NULL, `GroupId` tinyint unsigned NOT NULL,
  `MinCount` tinyint unsigned NOT NULL, `MaxCount` tinyint unsigned NOT NULL, `missing` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`Entry`, `Item`)
) ENGINE=InnoDB;
INSERT INTO `everlake_contents` (`Entry`, `Item`, `Chance`, `GroupId`, `MinCount`, `MaxCount`) VALUES
(13247, 10144, 7.31, 0, 1, 1),
(13247, 10228, 7.11, 0, 1, 1),
(13247, 10219, 7.11, 0, 1, 1),
(13247, 10147, 6.91, 0, 1, 1),
(13247, 10380, 6.86, 0, 1, 1),
(13247, 10156, 6.56, 0, 1, 1),
(13247, 10105, 6.54, 0, 1, 1),
(13247, 10258, 6.51, 0, 1, 1),
(13247, 10230, 6.46, 0, 1, 1),
(13247, 10210, 6.26, 0, 1, 1),
(13247, 10136, 6.16, 0, 1, 1),
(13247, 10376, 5.96, 0, 1, 1),
(13247, 10275, 5.66, 0, 1, 1),
(13247, 10391, 5.28, 0, 1, 1),
(13247, 10377, 5.26, 0, 1, 1),
(13247, 10214, 4.71, 0, 1, 1),
(13247, 10145, 4.46, 0, 1, 1),
(13247, 10236, 4.33, 0, 1, 1),
(13247, 10104, 4.13, 0, 1, 1),
(13247, 10211, 4.13, 0, 1, 1),
(13247, 10280, 4.11, 0, 1, 1),
(13247, 10225, 4.11, 0, 1, 1),
(13247, 10222, 3.86, 0, 1, 1),
(13247, 10159, 3.73, 0, 1, 1),
(13247, 10235, 3.73, 0, 1, 1),
(13247, 10138, 3.41, 0, 1, 1),
(13247, 10381, 2.98, 0, 1, 1),
(13247, 10226, 2.7, 0, 1, 1),
(13247, 10267, 2.68, 0, 1, 1),
(13247, 10154, 2.68, 0, 1, 1),
(13247, 10155, 2.48, 0, 1, 1),
(13247, 10146, 2.43, 0, 1, 1),
(13247, 10256, 2.3, 0, 1, 1),
(13247, 10387, 2.23, 0, 1, 1),
(13247, 10140, 2.15, 0, 1, 1),
(13247, 10137, 2.13, 0, 1, 1),
(13247, 10379, 2.1, 0, 1, 1),
(13247, 10149, 2, 0, 1, 1),
(13247, 10248, 1.98, 0, 1, 1),
(13247, 10160, 1.95, 0, 1, 1),
(13247, 10373, 1.93, 0, 1, 1),
(13247, 10257, 1.9, 0, 1, 1),
(13247, 10255, 1.9, 0, 1, 1),
(13247, 10249, 1.88, 0, 1, 1),
(13247, 10161, 1.8, 0, 1, 1),
(13247, 10265, 1.7, 0, 1, 1),
(13247, 10259, 1.63, 0, 1, 1),
(13247, 10382, 1.6, 0, 1, 1),
(13247, 10269, 1.55, 0, 1, 1),
(13247, 10227, 1.5, 0, 1, 1),
(13247, 10383, 1.5, 0, 1, 1),
(13247, 10385, 1.48, 0, 1, 1),
(13247, 10150, 1.45, 0, 1, 1),
(13247, 10142, 1.45, 0, 1, 1),
(13247, 10217, 1.4, 0, 1, 1),
(13247, 10215, 1.38, 0, 1, 1),
(13247, 10153, 1.33, 0, 1, 1),
(13247, 10386, 1.3, 0, 1, 1),
(13247, 10163, 1.28, 0, 1, 1),
(13247, 10261, 1.2, 0, 1, 1),
(13247, 10251, 1.2, 0, 1, 1),
(13247, 10260, 1.18, 0, 1, 1),
(13247, 10270, 1.18, 0, 1, 1),
(13247, 10390, 1.18, 0, 1, 1),
(13247, 10152, 1.13, 0, 1, 1),
(13247, 10274, 1.08, 0, 1, 1),
(13247, 10247, 1.03, 0, 1, 1),
(13247, 10250, 1.03, 0, 1, 1),
(13247, 10220, 0.95, 0, 1, 1),
(13247, 10141, 0.95, 0, 1, 1),
(13247, 10263, 0.93, 0, 1, 1),
(13247, 10139, 0.9, 0, 1, 1),
(13247, 10272, 0.9, 0, 1, 1),
(13247, 10268, 0.88, 0, 1, 1),
(13247, 10388, 0.85, 0, 1, 1),
(13247, 10378, 0.83, 0, 1, 1),
(13247, 10253, 0.8, 0, 1, 1),
(13247, 10162, 0.73, 0, 1, 1),
(272151, 13467, 10.77, 0, 2, 5),
(272151, 13466, 10.77, 0, 2, 5),
(272151, 13465, 10.77, 0, 3, 5),
(272151, 15417, 10, 0, 2, 3),
(272151, 13463, 9.23, 0, 2, 5),
(272151, 10620, 8.46, 0, 2, 5),
(272151, 13755, 8.46, 0, 2, 4),
(272151, 13422, 7.69, 0, 2, 5),
(272151, 8846, 6.92, 0, 2, 5),
(272151, 7082, 6.15, 0, 1, 1),
(272151, 7080, 5.38, 0, 1, 1),
(272151, 13468, 5.38, 0, 1, 1),
(272151, 12820, 5.38, 0, 2, 3),
(272151, 14344, 4.62, 0, 1, 3),
(272151, 7078, 4.62, 0, 1, 1),
(272151, 16203, 3.85, 0, 2, 2),
(272151, 12363, 3.08, 0, 1, 1),
(272151, 12811, 2.31, 0, 1, 1),
(272151, 12364, 0.77, 0, 1, 1),
(280567, 1705, 47.75, 0, 1, 1),
(280567, 818, 47.11, 0, 1, 1),
(280567, 774, 46.44, 0, 1, 1),
(280567, 1210, 45.76, 0, 1, 1),
(280567, 1529, 45.59, 0, 1, 1),
(280567, 1206, 45.43, 0, 1, 1),
(280943, 3874, 0, 1, 1, 1),
(280943, 3869, 0, 1, 1, 1),
(280943, 3868, 0, 1, 1, 1),
(280943, 7976, 0, 1, 1, 1),
(280943, 7975, 0, 1, 1, 1),
(280943, 7992, 0, 1, 1, 1),
(280943, 8029, 0, 1, 1, 1),
(280943, 3873, 0, 1, 1, 1),
(285366, 4357, 90.2, 0, 5, 12),
(285366, 4359, 89.95, 0, 4, 7),
(285366, 4360, 87.19, 0, 3, 5),
(285366, 260793, 80.4, 0, 2, 4);
UPDATE `everlake_contents` k SET k.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `item_loot_template` i WHERE i.`Entry` = k.`Entry` AND i.`ItemType` = 0 AND i.`Item` = k.`Item`);
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT k.`Entry`, 0, k.`Item`, k.`Chance`, 0, 1, k.`GroupId`, k.`MinCount`, k.`MaxCount`, 'Wowhead Contains'
FROM `everlake_contents` k WHERE k.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'item_loot_template', k.`Entry`, 0, k.`Item`, '2026_11_27_61_world_everlake_container_contents.sql', 'Wowhead item page Contains (tracker crawl 11-27)'
FROM `everlake_contents` k WHERE k.`missing` = 1;
DROP TEMPORARY TABLE `everlake_contents`;

COMMIT;
