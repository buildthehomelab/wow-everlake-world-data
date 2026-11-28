-- 2026_11_28_03_world_everlake_released_recipe_drops.sql: six recipes the tracker had kept as "not out yet" (its hand list of
-- 2026-11-18: Wowhead's Forever pages named no source) drop on live WoW Forever by the Icy Veins WoW Forever catalogue, which
-- records players' addons looting them, with a rate; QuestieDB names the same creatures. The realm owner released them
-- (2026-11-28). Each creature is spawned and has its own loot table; the rate is Icy Veins'.
--   Swamp Talker (950)        Pattern: Charged Scorpid Shoulders (252917)   0.86%
--   Scarlet Paladin (1834)    Plans: Blessed Plate Helm (251445)            1.82%
--   Scourge Soldier (8523)    Pattern: Wicked Leather Shoulders (252884)    1.99%
--   Flamekin Sprite (9777)    Pattern: Tooled Leather Epaulets (252887)     2.44%
--   Flamekin Torcher (9778)   Formula: Greater Eternal Wand (249522)        1.56%
--   Gordok Ogre-Mage (11443)  Pattern: Dawn Armor (252892)                  10.53%
-- Every row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file.
-- Running it again changes nothing. Not checked in game.

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

SET @EVERLAKE_FILE := '2026_11_28_03_world_everlake_released_recipe_drops.sql';
START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_recipe_drops`;
CREATE TEMPORARY TABLE `everlake_recipe_drops` (`entry` int unsigned NOT NULL, `item` int unsigned NOT NULL, `chance` float NOT NULL, `comment` varchar(100) NOT NULL, `note` varchar(255) NOT NULL, `lid` int unsigned NOT NULL DEFAULT 0, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`, `item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_recipe_drops` (`entry`, `item`, `chance`, `comment`, `note`) VALUES
(950, 252917, 0.86, 'Swamp Talker: Pattern: Charged Scorpid Shoulders', 'Icy Veins (live WoW Forever) 0.855%, QuestieDB: 950 drops 252917; released 2026-11-28'),
(1834, 251445, 1.82, 'Scarlet Paladin: Plans: Blessed Plate Helm', 'Icy Veins (live WoW Forever) 1.818%, QuestieDB: 1834 drops 251445; released 2026-11-28'),
(8523, 252884, 1.99, 'Scourge Soldier: Pattern: Wicked Leather Shoulders', 'Icy Veins (live WoW Forever) 1.987%, QuestieDB: 8523 drops 252884; released 2026-11-28'),
(9777, 252887, 2.44, 'Flamekin Sprite: Pattern: Tooled Leather Epaulets', 'Icy Veins (live WoW Forever) 2.439%, QuestieDB: 9777 drops 252887; released 2026-11-28'),
(9778, 249522, 1.56, 'Flamekin Torcher: Formula: Greater Eternal Wand', 'Icy Veins (live WoW Forever) 1.563%, QuestieDB: 9778 drops 249522; released 2026-11-28'),
(11443, 252892, 10.53, 'Gordok Ogre-Mage: Pattern: Dawn Armor', 'Icy Veins (live WoW Forever) 10.526%, QuestieDB: 11443 drops 252892; released 2026-11-28');

-- the creature's own loot id, while the creature stands somewhere and its table lacks the item
UPDATE `everlake_recipe_drops` s SET s.`lid` = COALESCE((SELECT d.`LootID` FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`DifficultyID` = 0 AND d.`LootID` > 0), 0);
UPDATE `everlake_recipe_drops` s SET s.`missing` = 1 WHERE s.`lid` > 0
  AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = s.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l WHERE l.`Entry` = s.`lid` AND l.`ItemType` = 0 AND l.`Item` = s.`item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template' AND r.`k1` = s.`lid` AND r.`k2` = 0 AND r.`k3` = s.`item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`lid`, 0, s.`item`, s.`chance`, 0, 1, 0, 1, 1, s.`comment` FROM `everlake_recipe_drops` s WHERE s.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', s.`lid`, 0, s.`item`, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_recipe_drops` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_recipe_drops`;

COMMIT;
