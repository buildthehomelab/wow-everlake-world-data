-- Items quest objectives need that nothing gave on the realm: who drops them, as players' addons saw it on live WoW
-- Forever (Icy Veins' WoW Forever database, https://db.icy-veins.com/wow-forever/, read 2026-11-19).
-- 2026_11_19_993_world_everlake_quest_item_drops.sql: written by a script, checked by hand.
--
-- Creature drops: the chance Icy Veins measured; a quest item seen dropping fewer than 5 times gets 40 (the tracker's
-- quest_chance, as its own Icy Veins card does). QuestRequired where Icy Veins says the drop is for a quest. A creature
-- whose LootID is 0 gets its own loot table (LootID = its entry), as the tracker's cards do.
-- Object contents: into the loot table the chest's template names (Data1).
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
DROP TEMPORARY TABLE IF EXISTS `everlake_drop_stage`;
CREATE TEMPORARY TABLE `everlake_drop_stage` (`npc` int unsigned NOT NULL, `item` int unsigned NOT NULL, `chance` float NOT NULL, `qr` tinyint NOT NULL, `note` varchar(255) NOT NULL, `loot` int unsigned NOT NULL DEFAULT 0, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`npc`, `item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_drop_stage` (`npc`, `item`, `chance`, `qr`, `note`) VALUES
(6147, 243203, 40, 1, 'Icy Veins: 1 drop(s) seen, fewer than 5: 40 as the tracker''s quest_chance'),
(6148, 246888, 40, 1, 'Icy Veins: 2 drop(s) seen, fewer than 5: 40 as the tracker''s quest_chance'),
(268864, 249698, 4.545, 1, 'Icy Veins: 5 drop(s) seen'),
(247248, 249698, 1.333, 1, 'Icy Veins: 5 drop(s) seen'),
(255347, 249698, 1.017, 1, 'Icy Veins: 5 drop(s) seen'),
(249221, 263028, 40, 1, 'Icy Veins: 4 drop(s) seen, fewer than 5: 40 as the tracker''s quest_chance'),
(249220, 263028, 40, 1, 'Icy Veins: 4 drop(s) seen, fewer than 5: 40 as the tracker''s quest_chance'),
(249222, 263028, 40, 1, 'Icy Veins: 4 drop(s) seen, fewer than 5: 40 as the tracker''s quest_chance'),
(260826, 263028, 40, 1, 'Icy Veins: 4 drop(s) seen, fewer than 5: 40 as the tracker''s quest_chance'),
(269756, 278744, 40, 1, 'Icy Veins: 1 drop(s) seen, fewer than 5: 40 as the tracker''s quest_chance'),
(5974, 280390, 40, 1, 'Icy Veins: 4 drop(s) seen, fewer than 5: 40 as the tracker''s quest_chance'),
(5976, 280390, 40, 1, 'Icy Veins: 4 drop(s) seen, fewer than 5: 40 as the tracker''s quest_chance');
-- a creature with no loot table gets its own, as the tracker's cards do
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty.LootID', d.`Entry`, 0, 0, 0, '2026_11_19_993_world_everlake_quest_item_drops.sql', 'LootID 0 -> its entry, for an Icy Veins drop'
FROM `creature_template_difficulty` d WHERE d.`DifficultyID` = 0 AND d.`LootID` = 0 AND d.`Entry` IN (SELECT `npc` FROM `everlake_drop_stage`);
UPDATE `creature_template_difficulty` d JOIN (SELECT DISTINCT `npc` FROM `everlake_drop_stage`) s ON s.`npc` = d.`Entry`
SET d.`LootID` = d.`Entry` WHERE d.`DifficultyID` = 0 AND d.`LootID` = 0;
UPDATE `everlake_drop_stage` s JOIN `creature_template_difficulty` d ON d.`Entry` = s.`npc` AND d.`DifficultyID` = 0 SET s.`loot` = d.`LootID`;
UPDATE `everlake_drop_stage` s SET s.`missing` = 1
WHERE s.`loot` > 0
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` t WHERE t.`Entry` = s.`loot` AND t.`ItemType` = 0 AND t.`Item` = s.`item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template' AND r.`k1` = s.`loot` AND r.`k2` = 0 AND r.`k3` = s.`item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`loot`, 0, s.`item`, s.`chance`, s.`qr`, 1, 0, 1, 1, LEFT(s.`note`, 255) FROM `everlake_drop_stage` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'creature_loot_template', s.`loot`, 0, s.`item`, '2026_11_19_993_world_everlake_quest_item_drops.sql', LEFT(s.`note`, 255) FROM `everlake_drop_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_drop_stage`;

DROP TEMPORARY TABLE IF EXISTS `everlake_drop_stage`;
CREATE TEMPORARY TABLE `everlake_drop_stage` (`go` int unsigned NOT NULL, `loot` int unsigned NOT NULL, `item` int unsigned NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`loot`, `item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_drop_stage` (`go`, `loot`, `item`) VALUES
(424002, 122215, 216617);
UPDATE `everlake_drop_stage` s SET s.`missing` = 1
WHERE s.`loot` > 0 AND EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = s.`go` AND g.`type` = 3 AND g.`Data1` = s.`loot`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` t WHERE t.`Entry` = s.`loot` AND t.`ItemType` = 0 AND t.`Item` = s.`item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject_loot_template' AND r.`k1` = s.`loot` AND r.`k2` = 0 AND r.`k3` = s.`item`);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`loot`, 0, s.`item`, 100, 1, 1, 0, 1, 1, 'Icy Veins: looted from this object' FROM `everlake_drop_stage` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'gameobject_loot_template', s.`loot`, 0, s.`item`, '2026_11_19_993_world_everlake_quest_item_drops.sql', 'Icy Veins: looted from this object' FROM `everlake_drop_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_drop_stage`;
COMMIT;
