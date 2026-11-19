-- Quest items: the loot rows for the Tablets of I'lalai and The Lost Magic of the Runemasters, where 939 could not add them.
-- 2026_11_19_976_world_everlake_tablet_loot.sql: written by hand; the rows are 939's (EG Link object query, build 70959).
--
-- 939 adds these loot rows only while the object's template carries the loot id EG Link records. On a world where
-- the template was missing or different when 939 ran, the loot stayed empty. The PTR was one such world. Since 975
-- the templates are there with those loot ids, so the same rows can go in now. Same guard as 939: a row goes in only
-- while the template carries that loot id and the loot id has no rows yet, so it changes nothing where 939 already
-- added them (live).
--      642943 The First Tablet of I'lalai: loot 140217, item 270308, quest 95775/95787 The Drowned City, Take Two With Water
--      642944 The Second Tablet of I'lalai: loot 140218, item 270309, quest 95775/95787
--      642945 The Third Tablet of I'lalai: loot 140219, item 270310, quest 95775/95787
--      642946 The Fourth Tablet of I'lalai: loot 140220, item 270311, quest 95775/95787
--      650929 The Lost Magic of the Runemasters: loot 140820, item 273169, quest 96800 Past Due
--
-- Not checked in game. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing.

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

DROP TEMPORARY TABLE IF EXISTS `everlake_tablet_loot`;
CREATE TEMPORARY TABLE `everlake_tablet_loot` (`object` int unsigned NOT NULL, `Entry` int unsigned NOT NULL PRIMARY KEY, `Item` int unsigned NOT NULL, `Comment` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0') ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_tablet_loot` (`object`, `Entry`, `Item`, `Comment`) VALUES
(642943, 140217, 270308, 'The First Tablet of I''lalai'),
(642944, 140218, 270309, 'The Second Tablet of I''lalai'),
(642945, 140219, 270310, 'The Third Tablet of I''lalai'),
(642946, 140220, 270311, 'The Fourth Tablet of I''lalai'),
(650929, 140820, 273169, 'The Lost Magic of the Runemasters');
UPDATE `everlake_tablet_loot` s SET s.`missing` = 1
WHERE EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = s.`object` AND g.`type` = 3 AND g.`Data1` = s.`Entry`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` l WHERE l.`Entry` = s.`Entry`);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT `Entry`, 0, `Item`, 100, 1, 1, 0, 1, 1, `Comment` FROM `everlake_tablet_loot` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', s.`Entry`, 0, s.`Item`, 0, '2026_11_19_976_world_everlake_tablet_loot.sql', 'eglink@70959 object_details (as 939)' FROM `everlake_tablet_loot` s WHERE s.`missing` = 1
ON DUPLICATE KEY UPDATE `file` = '2026_11_19_976_world_everlake_tablet_loot.sql';
DROP TEMPORARY TABLE `everlake_tablet_loot`;

COMMIT;
