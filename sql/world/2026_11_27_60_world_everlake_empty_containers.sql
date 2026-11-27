-- Two bags that opened empty: Arena Spoils and the Entomology Starter Kit.
-- 2026_11_27_60_world_everlake_empty_containers.sql: written by hand.
--
-- Found by the tracker's new 'contents' check (an item with the client's HAS_LOOT flag, no item loot and no money).
-- Its 22 hits were checked against the tracker's Wowhead and Icy Veins data; only these two have their contents on
-- record. The other 20 stay as they are until a source gives their contents.
--
-- 1. Arena Spoils (277534). On live the Gurubashi Arena Treasure Chest (179697, loot 16718) gives Arena Spoils every
--    time (Wowhead: 30 of 30) and the old chest loot comes out of the Spoils (Wowhead "Contains": Arena Master 37 of
--    48, Mageweave and Silk Cloth, then the green and blue items). Here the chest still dropped the old loot itself and
--    an empty Arena Spoils on top. The chest's rows move into the Spoils unchanged (same chances and counts), so the
--    chest gives only the Spoils.
-- 2. Entomology Starter Kit (213565, sold by 217412). Wowhead "Contains": 213563 (194 of 216) and 213562 (192 of 216),
--    both nearly every time, so both at 100%.
--
-- Corrections change a row only while it is as written against; added rows go in the ledger. Never edit this file
-- once it is deployed: a later fix is a new file. Running it again changes nothing. Not tried in game.

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

-- 1. the Arena Treasure Chest's loot goes inside Arena Spoils
DROP TEMPORARY TABLE IF EXISTS `everlake_spoils`;
CREATE TEMPORARY TABLE `everlake_spoils` ENGINE=InnoDB AS
SELECT g.`ItemType`, g.`Item`, g.`Chance`, g.`QuestRequired`, g.`LootMode`, g.`GroupId`, g.`MinCount`, g.`MaxCount`
FROM `gameobject_loot_template` g
WHERE g.`Entry` = 16718 AND NOT (g.`ItemType` = 0 AND g.`Item` = 277534)
  AND EXISTS (SELECT 1 FROM `gameobject_loot_template` s WHERE s.`Entry` = 16718 AND s.`ItemType` = 0 AND s.`Item` = 277534)
  AND NOT EXISTS (SELECT 1 FROM `item_loot_template` i WHERE i.`Entry` = 277534 AND i.`ItemType` = g.`ItemType` AND i.`Item` = g.`Item`);
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 277534, s.`ItemType`, s.`Item`, s.`Chance`, s.`QuestRequired`, s.`LootMode`, s.`GroupId`, s.`MinCount`, s.`MaxCount`, 'Arena Treasure Chest loot (Wowhead Contains)'
FROM `everlake_spoils` s;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'item_loot_template', 277534, s.`ItemType`, s.`Item`, '2026_11_27_60_world_everlake_empty_containers.sql', 'moved from Arena Treasure Chest loot 16718; Wowhead item 277534 Contains'
FROM `everlake_spoils` s;
DELETE g FROM `gameobject_loot_template` g
JOIN `everlake_spoils` s ON s.`ItemType` = g.`ItemType` AND s.`Item` = g.`Item`
WHERE g.`Entry` = 16718;
DROP TEMPORARY TABLE `everlake_spoils`;

-- 2. Entomology Starter Kit contents
DROP TEMPORARY TABLE IF EXISTS `everlake_kit`;
CREATE TEMPORARY TABLE `everlake_kit` (`Item` int unsigned NOT NULL PRIMARY KEY, `missing` tinyint NOT NULL DEFAULT 0) ENGINE=InnoDB;
INSERT INTO `everlake_kit` (`Item`) VALUES (213562), (213563);
UPDATE `everlake_kit` k SET k.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `item_loot_template` i WHERE i.`Entry` = 213565 AND i.`ItemType` = 0 AND i.`Item` = k.`Item`);
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 213565, 0, k.`Item`, 100, 0, 1, 0, 1, 1, 'Entomology Starter Kit (Wowhead Contains)' FROM `everlake_kit` k WHERE k.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'item_loot_template', 213565, 0, k.`Item`, '2026_11_27_60_world_everlake_empty_containers.sql', 'Wowhead item 213565 Contains (about 9 in 10 each)'
FROM `everlake_kit` k WHERE k.`missing` = 1;
DROP TEMPORARY TABLE `everlake_kit`;

COMMIT;
