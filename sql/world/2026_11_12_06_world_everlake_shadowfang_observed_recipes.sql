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

SET SESSION autocommit = 0;
-- Observed Shadowfang Keep crafting drops (Icy Veins Forever NPC loot tables).
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`Entry` int unsigned NOT NULL, `ItemType` tinyint NOT NULL, `Item` int unsigned NOT NULL, `Chance` float NOT NULL, `QuestRequired` tinyint(1) NOT NULL, `LootMode` smallint unsigned NOT NULL, `GroupId` tinyint unsigned NOT NULL, `MinCount` tinyint unsigned NOT NULL, `MaxCount` tinyint unsigned NOT NULL, `Comment` varchar(255) NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`Entry`, `ItemType`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`, `note`) VALUES
(3914, 0, 253904, 0.631, 0, 1, 0, 1, 1, 'Pattern: Filigreed Silky Gown', 'https://db.icy-veins.com/wow-forever/npcs/3914'),
(3914, 0, 6347, 0.079, 0, 1, 0, 1, 1, 'Formula: Enchant Bracer - Minor Strength', 'https://db.icy-veins.com/wow-forever/npcs/3914'),
(3914, 0, 4346, 0.079, 0, 1, 0, 1, 1, 'Pattern: Heavy Woolen Cloak', 'https://db.icy-veins.com/wow-forever/npcs/3914'),
(3914, 0, 4348, 0.079, 0, 1, 0, 1, 1, 'Pattern: Phoenix Gloves', 'https://db.icy-veins.com/wow-forever/npcs/3914'),
(3914, 0, 4349, 0.079, 0, 1, 0, 1, 1, 'Pattern: Phoenix Pants', 'https://db.icy-veins.com/wow-forever/npcs/3914'),
(3914, 0, 6391, 0.079, 0, 1, 0, 1, 1, 'Pattern: Stylish Green Shirt', 'https://db.icy-veins.com/wow-forever/npcs/3914'),
(3914, 0, 5578, 0.079, 0, 1, 0, 1, 1, 'Plans: Silvered Bronze Breastplate', 'https://db.icy-veins.com/wow-forever/npcs/3914'),
(4275, 0, 4350, 0.092, 0, 1, 0, 1, 1, 'Pattern: Spider Silk Slippers', 'https://db.icy-veins.com/wow-forever/npcs/4275'),
(4275, 0, 3396, 0.092, 0, 1, 0, 1, 1, 'Recipe: Elixir of Lesser Agility', 'https://db.icy-veins.com/wow-forever/npcs/4275'),
(4278, 0, 3611, 0.221, 0, 1, 0, 1, 1, 'Plans: Green Iron Boots', 'https://db.icy-veins.com/wow-forever/npcs/4278'),
(4278, 0, 4412, 0.221, 0, 1, 0, 1, 1, 'Schematic: Moonsight Rifle', 'https://db.icy-veins.com/wow-forever/npcs/4278'),
(3872, 0, 2883, 0.476, 0, 1, 0, 1, 1, 'Plans: Deadly Bronze Poniard', 'https://db.icy-veins.com/wow-forever/npcs/3872'),
(3886, 0, 253944, 0.586, 0, 1, 0, 1, 1, 'Pattern: Filigreed Shadow Leggings', 'https://db.icy-veins.com/wow-forever/npcs/3886'),
(3886, 0, 3870, 0.073, 0, 1, 0, 1, 1, 'Plans: Green Iron Shoulders', 'https://db.icy-veins.com/wow-forever/npcs/3886'),
(3886, 0, 3608, 0.073, 0, 1, 0, 1, 1, 'Plans: Mighty Iron Hammer', 'https://db.icy-veins.com/wow-forever/npcs/3886'),
(3886, 0, 4414, 0.073, 0, 1, 0, 1, 1, 'Schematic: Portable Bronze Mortar', 'https://db.icy-veins.com/wow-forever/npcs/3886');
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_loot_template` t WHERE t.`Entry` = s.`Entry` AND t.`ItemType` = s.`ItemType` AND t.`Item` = s.`Item`) AND EXISTS (SELECT 1 FROM `creature_template_difficulty` d
 WHERE d.`Entry` = s.`Entry` AND d.`DifficultyID` = 0 AND d.`LootID` = s.`Entry`)
AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = s.`Entry`
 AND c.`map` = 33)
AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`LootID` = s.`Entry` AND d.`Entry` <> s.`Entry`)
AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l JOIN `reference_loot_template` ref ON ref.`Entry` = l.`Item`
 WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 1 AND ref.`ItemType` = 0 AND ref.`Item` = s.`Item`)
AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l JOIN `reference_loot_template` r ON r.`Entry` = l.`Item`
 JOIN `reference_loot_template` ref ON ref.`Entry` = r.`Item` WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 1
 AND r.`ItemType` = 1 AND ref.`ItemType` = 0 AND ref.`Item` = s.`Item`)
AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template'
 AND r.`k1` = s.`Entry` AND r.`k2` = s.`ItemType` AND r.`k3` = s.`Item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, '2026_11_12_06_world_everlake_shadowfang_observed_recipes.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_12_06_world_everlake_shadowfang_observed_recipes.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

SET SESSION autocommit = 1;
