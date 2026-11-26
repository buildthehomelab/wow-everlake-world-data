-- Sixteen new WoW Forever items that Classic rares drop on live are added to those rares' loot, at 35% each.
-- 2026_11_25_26_world_everlake_rare_new_drops.sql: written by hand from the tracker's kept facts (2026-11-25).
--
-- The tracker's work list had these items as "no source": QuestieDB's WoW Forever data (and for some NorgannonDB,
-- Icy Veins' WoW Forever database or Wowhead's WoW Forever pages) records each one as dropped by the rare below, but
-- the test realm's loot table for that rare lacks it. No source has a usable rate: Icy Veins lists the pairs with no
-- kill sample, and Wowhead's samples are 1 to 5 kills (Smoldar 2 of 2, Ravage 1 of 2, Hawkspear 1 of 5, Amarassan
-- 1 of 4, Stegodon 1 of 2). The realm owner chose 35% for all of them (2026-11-25), the middle of those samples.
-- Each rare has its own loot table (no other creature shares its loot id) and is spawned on the realm.
--
-- Left out: Duke Ragereaver (10820, Blade of Senseless Slaughter 284101) and Old Rusthowl (263935, Rusthowl's Worn
-- Collar 281598) are not spawned.
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

SET @EVERLAKE_FILE := '2026_11_25_26_world_everlake_rare_new_drops.sql';
START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_rare_drops`;
CREATE TEMPORARY TABLE `everlake_rare_drops` (`entry` int unsigned NOT NULL, `item` int unsigned NOT NULL, `chance` float NOT NULL, `comment` varchar(100) NOT NULL, `note` varchar(255) NOT NULL, `lid` int unsigned NOT NULL DEFAULT 0, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`, `item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_rare_drops` (`entry`, `item`, `chance`, `comment`, `note`) VALUES
(14446, 282005, 35, 'Fingat: Saltwater Shawl', 'QuestieDB (live WoW Forever): 14446 drops 282005; rate 35% chosen 2026-11-25'),
(8300, 282009, 35, 'Ravage: Ravaged Leather Leggings', 'QuestieDB; Wowhead 1 of 2 kills (live WoW Forever): 8300 drops 282009; rate 35% chosen 2026-11-25'),
(8278, 282088, 35, 'Smoldar: Heart of Smoldar', 'QuestieDB; Wowhead 2 of 2 kills (live WoW Forever): 8278 drops 282088; rate 35% chosen 2026-11-25'),
(8212, 284043, 35, 'The Reak: Dissolved Link Legguards', 'QuestieDB + NorgannonDB (live WoW Forever): 8212 drops 284043; rate 35% chosen 2026-11-25'),
(10827, 284104, 35, 'Deathspeaker Selendre: Cultist''s Cuffs', 'QuestieDB (live WoW Forever): 10827 drops 284104; rate 35% chosen 2026-11-25'),
(10824, 284157, 35, 'Ranger Lord Hawkspear: Ranger Lord''s Longsword', 'QuestieDB + Icy Veins; Wowhead 1 of 5 kills (live WoW Forever): 10824 drops 284157; rate 35% chosen 2026-11-25'),
(10823, 284162, 35, 'Zul''Brin Warpbranch: Mossflayer Witchdoctor''s Robe', 'QuestieDB (live WoW Forever): 10823 drops 284162; rate 35% chosen 2026-11-25'),
(14344, 284197, 35, 'Mongress: Hide of Mongress', 'QuestieDB (live WoW Forever): 14344 drops 284197; rate 35% chosen 2026-11-25'),
(14345, 284218, 35, 'The Ongar: Slime-Coated Gloves', 'QuestieDB (live WoW Forever): 14345 drops 284218; rate 35% chosen 2026-11-25'),
(8660, 284272, 35, 'The Evalcharr: Chimaera Hide Legs', 'QuestieDB (live WoW Forever): 8660 drops 284272; rate 35% chosen 2026-11-25'),
(6118, 284282, 35, 'Varo''then''s Ghost: Queen Guard''s Royal Seal', 'QuestieDB (live WoW Forever): 6118 drops 284282; rate 35% chosen 2026-11-25'),
(6648, 284283, 35, 'Antilos: Horn of Antilos', 'QuestieDB (live WoW Forever): 6648 drops 284283; rate 35% chosen 2026-11-25'),
(5916, 284403, 35, 'Sentinel Amarassan: Shapeshifting Sentinel''s Strides', 'QuestieDB + Icy Veins; Wowhead 1 of 4 kills (live WoW Forever): 5916 drops 284403; rate 35% chosen 2026-11-25'),
(14237, 285088, 35, 'Oozeworm: Ooze Dripping Robes', 'QuestieDB + Icy Veins (live WoW Forever): 14237 drops 285088; rate 35% chosen 2026-11-25'),
(8200, 286552, 35, 'Jin''Zallah the Sandbringer: Sandcaster''s Mantle', 'QuestieDB + Icy Veins (live WoW Forever): 8200 drops 286552; rate 35% chosen 2026-11-25'),
(6504, 220916, 35, 'Thunderstomp Stegodon: Thunderstomp Stegodon Horn', 'QuestieDB; Wowhead 1 of 2 kills (live WoW Forever): 6504 drops 220916; rate 35% chosen 2026-11-25');

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
