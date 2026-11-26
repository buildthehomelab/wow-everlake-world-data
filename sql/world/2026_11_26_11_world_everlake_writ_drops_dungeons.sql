-- Craftsman's Writs drop inside dungeons too.
-- 2026_11_26_11_world_everlake_writ_drops_dungeons.sql: written by hand (2026-11-26).
--
-- Blizzard's server-side note of 9 November 2026 (step 70862+1): "Fixed a bug that prevented Waylaid Crates and
-- Craftsman's Writs from dropping inside dungeons." Waylaid Crates already drop in dungeons (the core's 2026_11_20_41).
-- The writ drop lists of 2026_11_19_982 (reference loot 9500001-9500003, Journeyman / Expert / Artisan) went only on
-- open-world creatures (maps 0, 1, 2991). This gives the same lists, on the same INFERRED terms (tier by the creature's
-- highest level: 20-34, 35-51, 52-63; 0.5% per kill; creatures that have loot and are not critters), to creatures that
-- stand in a five-player dungeon. The dungeon maps are the tracker's dungeon list (kind 1, not seasonal): 33, 34, 36,
-- 43, 47, 48, 70, 90, 109, 129, 189, 209, 229, 230, 289, 329, 349, 389, 429, 2959, 2970, 2974, 2994, 2998, 2999, 3001,
-- 3039, 3065, 3109. Raids are left out (the note names dungeons only).
--
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';

START TRANSACTION;
DROP TEMPORARY TABLE IF EXISTS `everlake_writ_loot`;
CREATE TEMPORARY TABLE `everlake_writ_loot` (`Entry` int unsigned NOT NULL, `Item` int unsigned NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`Entry`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT IGNORE INTO `everlake_writ_loot` (`Entry`, `Item`)
SELECT d.`LootID`, CASE WHEN l.`level_max` BETWEEN 20 AND 34 THEN 9500001 WHEN l.`level_max` BETWEEN 35 AND 51 THEN 9500002 ELSE 9500003 END
FROM `creature_template_difficulty` d
JOIN `creature_template` t ON t.`entry` = d.`Entry`
JOIN `creature_classic_level` l ON l.`entry` = d.`Entry`
WHERE d.`DifficultyID` = 0 AND d.`LootID` > 0 AND t.`type` <> 8 AND l.`level_max` BETWEEN 20 AND 63
  AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = d.`Entry` AND c.`map` IN (33, 34, 36, 43, 47, 48, 70, 90, 109, 129, 189, 209, 229, 230, 289, 329, 349, 389, 429, 2959, 2970, 2974, 2994, 2998, 2999, 3001, 3039, 3065, 3109));
UPDATE `everlake_writ_loot` s SET s.`missing` = 1
WHERE EXISTS (SELECT 1 FROM `reference_loot_template` r WHERE r.`Entry` = s.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` t WHERE t.`Entry` = s.`Entry` AND t.`ItemType` = 1 AND t.`Item` = s.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template' AND r.`k1` = s.`Entry` AND r.`k2` = 1 AND r.`k3` = s.`Item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`Entry`, 1, s.`Item`, 0.5, 0, 1, 0, 1, 1, 'Craftsman''s Writ dungeon drop (INFERRED)' FROM `everlake_writ_loot` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'creature_loot_template', s.`Entry`, 1, s.`Item`, '2026_11_26_11_world_everlake_writ_drops_dungeons.sql', 'note 70862+1 2026-11-09 (writs drop in dungeons); drop INFERRED as 2026_11_19_982' FROM `everlake_writ_loot` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_writ_loot`;
COMMIT;
