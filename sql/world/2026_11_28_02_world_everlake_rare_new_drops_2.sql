-- Fifteen more new WoW Forever items that Classic rares drop on live are added to those rares' loot, at 35% each.
-- 2026_11_28_02_world_everlake_rare_new_drops_2.sql: written by hand from the tracker's kept facts (2026-11-28).
--
-- The same case as 2026_11_25_26: QuestieDB's WoW Forever data (and for all but one the Icy Veins WoW Forever
-- catalogue; Malfunctioning Reaver's only there) records each item as dropped by the rare below, and the test realm's
-- loot table for that rare lacks it. The tracker had filed them as "not out yet" because Wowhead's Forever page for
-- each names no source, so the 2026-11-25 batch missed them. No source has a kill sample (Icy Veins lists the pairs
-- with no rate); 35% is the rate the realm owner chose for these rare drops (2026-11-25).
-- Each rare has its own loot table (no other creature shares its loot id) and is spawned on the realm.
--
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

SET @EVERLAKE_FILE := '2026_11_28_02_world_everlake_rare_new_drops_2.sql';
START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_rare_drops`;
CREATE TEMPORARY TABLE `everlake_rare_drops` (`entry` int unsigned NOT NULL, `item` int unsigned NOT NULL, `chance` float NOT NULL, `comment` varchar(100) NOT NULL, `note` varchar(255) NOT NULL, `lid` int unsigned NOT NULL DEFAULT 0, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`, `item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_rare_drops` (`entry`, `item`, `chance`, `comment`, `note`) VALUES
(14487, 281750, 35, 'Gluggle: Murloc Oracle''s Dagger', 'QuestieDB + Icy Veins (live WoW Forever): 14487 drops 281750; rate 35% as 2026_11_25_26'),
(8303, 282010, 35, 'Grunter: Tusk of Grunter', 'QuestieDB + Icy Veins (live WoW Forever): 8303 drops 282010; rate 35% as 2026_11_25_26'),
(8298, 282019, 35, 'Akubar the Seer: Braided Seer Stones', 'QuestieDB + Icy Veins (live WoW Forever): 8298 drops 282019; rate 35% as 2026_11_25_26'),
(8297, 282026, 35, 'Magronos the Unyielding: Unyielding Battle Signet', 'QuestieDB + Icy Veins (live WoW Forever): 8297 drops 282026; rate 35% as 2026_11_25_26'),
(8981, 282029, 35, 'Malfunctioning Reaver: Reaver''s Repeater', 'Icy Veins (live WoW Forever): 8981 drops 282029; rate 35% as 2026_11_25_26'),
(9604, 282074, 35, 'Gorgon''och: Ogre Sorcerer Belt', 'QuestieDB + Icy Veins (live WoW Forever): 9604 drops 282074; rate 35% as 2026_11_25_26'),
(8218, 284046, 35, 'Witherheart the Stalker: Witherheart''s Stabber', 'QuestieDB + Icy Veins (live WoW Forever): 8218 drops 284046; rate 35% as 2026_11_25_26'),
(10822, 284158, 35, 'Warlord Thresh''jin: Mossflayer Warlord''s Girdle', 'QuestieDB + Icy Veins (live WoW Forever): 10822 drops 284158; rate 35% as 2026_11_25_26'),
(10641, 284574, 35, 'Branch Snapper: Snapped Branch Wand', 'QuestieDB + Icy Veins (live WoW Forever): 10641 drops 284574; rate 35% as 2026_11_25_26'),
(10640, 284696, 35, 'Oakpaw: Carved Furbolg Tooth', 'QuestieDB + Icy Veins (live WoW Forever): 10640 drops 284696; rate 35% as 2026_11_25_26'),
(10639, 284700, 35, 'Rorgish Jowl: Den Guardian''s Crusher', 'QuestieDB + Icy Veins (live WoW Forever): 10639 drops 284700; rate 35% as 2026_11_25_26'),
(14233, 285093, 35, 'Ripscale: Ripscaled Cuffs', 'QuestieDB + Icy Veins (live WoW Forever): 14233 drops 285093; rate 35% as 2026_11_25_26'),
(8208, 286568, 35, 'Murderous Blisterpaw: Blisterpaw Bones', 'QuestieDB + Icy Veins (live WoW Forever): 8208 drops 286568; rate 35% as 2026_11_25_26'),
(6581, 286616, 35, 'Ravasaur Matriarch: Matriarch''s Prowlers', 'QuestieDB + Icy Veins (live WoW Forever): 6581 drops 286616; rate 35% as 2026_11_25_26'),
(5400, 286644, 35, 'Zekkis: Shattered Atal''ai Spear', 'QuestieDB + Icy Veins (live WoW Forever): 5400 drops 286644; rate 35% as 2026_11_25_26');

-- the creature's own loot id, while the creature stands somewhere and its table lacks the item
UPDATE `everlake_rare_drops` s SET s.`lid` = COALESCE((SELECT d.`LootID` FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`DifficultyID` = 0 AND d.`LootID` > 0), 0);
UPDATE `everlake_rare_drops` s SET s.`missing` = 1 WHERE s.`lid` > 0
  AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = s.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l WHERE l.`Entry` = s.`lid` AND l.`ItemType` = 0 AND l.`Item` = s.`item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template' AND r.`k1` = s.`lid` AND r.`k2` = 0 AND r.`k3` = s.`item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`lid`, 0, s.`item`, s.`chance`, 0, 1, 0, 1, 1, s.`comment` FROM `everlake_rare_drops` s WHERE s.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', s.`lid`, 0, s.`item`, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_rare_drops` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_rare_drops`;

COMMIT;
