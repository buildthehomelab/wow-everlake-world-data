-- The Bundle of Scrolls (277651), the mage's Study bundle (Research Access 97286 teaches Study 1302508, which makes it):
-- the realm has the item but nothing in it. Its contents from Wowhead's WoW Forever item page
-- (https://www.wowhead.com/forever/item=277651, read through the tracker's kept pages): 2699 bundles opened, each scroll
-- counted. Ids and counts only.
-- 2026_11_22_04_world_everlake_bundle_of_scrolls.sql: checked by hand.
--
-- Each scroll is its own roll at count / 2699 (GroupId 0). The counts add up to 6040 scrolls in 2699 bundles,
-- about 2.24 a bundle, which independent rolls give on average; how live groups them is not recorded
-- (INFERRED). Four of these scrolls are on the tracker's "no source" list: 213548, 213550, 213564, 217495.
-- Each added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing. Not tried in game.
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
SET @EVERLAKE_FILE := '2026_11_22_04_world_everlake_bundle_of_scrolls.sql';
START TRANSACTION;
CREATE TEMPORARY TABLE `everlake_bundle` (`Item` INT UNSIGNED NOT NULL PRIMARY KEY, `Chance` FLOAT NOT NULL, `n` INT NOT NULL);
INSERT INTO `everlake_bundle` (`Item`, `Chance`, `n`) VALUES
(213564, 41.5, 1120),
(274947, 31.57, 852),
(275069, 31.34, 846),
(275067, 18.86, 509),
(217495, 15.82, 427),
(213550, 14.56, 393),
(277483, 12.04, 325),
(277484, 10.97, 296),
(277489, 7.26, 196),
(277488, 6.04, 163),
(277485, 5.89, 159),
(277487, 5.82, 157),
(277486, 5.82, 157),
(277493, 3.15, 85),
(277491, 2.96, 80),
(213548, 2.48, 67),
(277496, 1.52, 41),
(277497, 1.52, 41),
(277498, 1.41, 38),
(277494, 1.33, 36),
(277495, 1.04, 28),
(277492, 0.89, 24);
DELETE b FROM `everlake_bundle` b WHERE EXISTS (SELECT 1 FROM `item_loot_template` l WHERE l.`Entry` = 277651 AND l.`Item` = b.`Item`);
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 277651, 0, b.`Item`, b.`Chance`, 0, 1, 0, 1, 1, 'Bundle of Scrolls' FROM `everlake_bundle` b ORDER BY b.`Item`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'item_loot_template', 277651, 0, b.`Item`, 0, @EVERLAKE_FILE, CONCAT('Wowhead item=277651: ', b.`n`, ' of 2699 opened') FROM `everlake_bundle` b;
DROP TEMPORARY TABLE `everlake_bundle`;
COMMIT;
