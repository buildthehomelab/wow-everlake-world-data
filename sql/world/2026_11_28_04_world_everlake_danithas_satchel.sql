-- 2026_11_28_04_world_everlake_danithas_satchel.sql: Danitha's Satchel (276785), what Justice and Retribution (97185, the
-- paladin's Forever charger quest) hands over on accept, opened empty on the realm (the client marks it as holding loot).
-- Wowhead's Forever item page lists what it holds: Blessed Arcanite Barding (18792, the quest's own objective; 22 of 29
-- openings) and the Divination Scryer (18746, which brings Death Knight Darkreaver in Scholomance; 18 of 29). Both are
-- unique, and players who already carried one did not get another, which is what keeps Wowhead's counts below every
-- opening: here each is in every satchel (INFERRED). Written by hand from the tracker's kept Wowhead page (2026-11-28).
-- The rows are recorded in everlake_import_rows. Running it again changes nothing. Never edit this file once it is
-- deployed: a later fix is a new file. Not checked in game.

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

SET @EVERLAKE_FILE := '2026_11_28_04_world_everlake_danithas_satchel.sql';
START TRANSACTION;
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 276785, 0, v.`item`, 100, 0, 1, 0, 1, 1, v.`comment`
FROM (SELECT 18792 AS `item`, 'Danitha''s Satchel: Blessed Arcanite Barding' AS `comment` UNION ALL
      SELECT 18746, 'Danitha''s Satchel: Divination Scryer') v
WHERE NOT EXISTS (SELECT 1 FROM `item_loot_template` l WHERE l.`Entry` = 276785 AND l.`ItemType` = 0 AND l.`Item` = v.`item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'item_loot_template' AND r.`k1` = 276785 AND r.`k2` = 0 AND r.`k3` = v.`item`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'item_loot_template', 276785, 0, l.`Item`, 0, @EVERLAKE_FILE, 'Wowhead Forever: Danitha''s Satchel contains this item (rate INFERRED 100%)'
FROM `item_loot_template` l WHERE l.`Entry` = 276785 AND l.`ItemType` = 0 AND l.`Item` IN (18792, 18746) AND l.`Comment` LIKE 'Danitha''s Satchel:%';
COMMIT;
