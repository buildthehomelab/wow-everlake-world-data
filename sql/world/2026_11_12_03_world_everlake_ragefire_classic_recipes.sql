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
-- Observed Ragefire Chasm crafting drops (Icy Veins Forever NPC loot tables).
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`Entry` int unsigned NOT NULL, `ItemType` tinyint NOT NULL, `Item` int unsigned NOT NULL, `Chance` float NOT NULL, `QuestRequired` tinyint(1) NOT NULL, `LootMode` smallint unsigned NOT NULL, `GroupId` tinyint unsigned NOT NULL, `MinCount` tinyint unsigned NOT NULL, `MaxCount` tinyint unsigned NOT NULL, `Comment` varchar(255) NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`Entry`, `ItemType`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`, `note`) VALUES
(11517, 0, 2882, 0.132, 0, 1, 0, 1, 1, 'Plans: Silvered Bronze Shoulders', 'https://db.icy-veins.com/wow-forever/npcs/11517'),
(11517, 0, 3608, 0.088, 0, 1, 0, 1, 1, 'Plans: Mighty Iron Hammer', 'https://db.icy-veins.com/wow-forever/npcs/11517'),
(11517, 0, 6375, 0.044, 0, 1, 0, 1, 1, 'Formula: Enchant Bracer - Lesser Spirit', 'https://db.icy-veins.com/wow-forever/npcs/11517'),
(11517, 0, 11081, 0.044, 0, 1, 0, 1, 1, 'Formula: Enchant Shield - Lesser Protection', 'https://db.icy-veins.com/wow-forever/npcs/11517'),
(11517, 0, 4297, 0.044, 0, 1, 0, 1, 1, 'Pattern: Barbaric Gloves', 'https://db.icy-veins.com/wow-forever/npcs/11517'),
(11517, 0, 5972, 0.044, 0, 1, 0, 1, 1, 'Pattern: Fine Leather Pants', 'https://db.icy-veins.com/wow-forever/npcs/11517'),
(11517, 0, 4349, 0.044, 0, 1, 0, 1, 1, 'Pattern: Phoenix Pants', 'https://db.icy-veins.com/wow-forever/npcs/11517'),
(11518, 0, 4296, 0.093, 0, 1, 0, 1, 1, 'Pattern: Dark Leather Shoulders', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 6375, 0.047, 0, 1, 0, 1, 1, 'Formula: Enchant Bracer - Lesser Spirit', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 6344, 0.047, 0, 1, 0, 1, 1, 'Formula: Enchant Bracer - Minor Spirit', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 6347, 0.047, 0, 1, 0, 1, 1, 'Formula: Enchant Bracer - Minor Strength', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 11081, 0.047, 0, 1, 0, 1, 1, 'Formula: Enchant Shield - Lesser Protection', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 2409, 0.047, 0, 1, 0, 1, 1, 'Pattern: Dark Leather Tunic', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 5972, 0.047, 0, 1, 0, 1, 1, 'Pattern: Fine Leather Pants', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 6390, 0.047, 0, 1, 0, 1, 1, 'Pattern: Stylish Blue Shirt', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 7091, 0.047, 0, 1, 0, 1, 1, 'Pattern: Truefaith Gloves', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 5578, 0.047, 0, 1, 0, 1, 1, 'Plans: Silvered Bronze Breastplate', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 10424, 0.047, 0, 1, 0, 1, 1, 'Plans: Silvered Bronze Leggings', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 3396, 0.047, 0, 1, 0, 1, 1, 'Recipe: Elixir of Lesser Agility', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11518, 0, 4409, 0.047, 0, 1, 0, 1, 1, 'Schematic: Small Seaforium Charge', 'https://db.icy-veins.com/wow-forever/npcs/11518'),
(11519, 0, 11039, 0.084, 0, 1, 0, 1, 1, 'Formula: Enchant Cloak - Minor Agility', 'https://db.icy-veins.com/wow-forever/npcs/11519'),
(11519, 0, 2601, 0.084, 0, 1, 0, 1, 1, 'Pattern: Gray Woolen Robe', 'https://db.icy-veins.com/wow-forever/npcs/11519'),
(11519, 0, 4350, 0.042, 0, 1, 0, 1, 1, 'Pattern: Spider Silk Slippers', 'https://db.icy-veins.com/wow-forever/npcs/11519'),
(11519, 0, 6390, 0.042, 0, 1, 0, 1, 1, 'Pattern: Stylish Blue Shirt', 'https://db.icy-veins.com/wow-forever/npcs/11519'),
(11519, 0, 6391, 0.042, 0, 1, 0, 1, 1, 'Pattern: Stylish Green Shirt', 'https://db.icy-veins.com/wow-forever/npcs/11519'),
(11519, 0, 5543, 0.042, 0, 1, 0, 1, 1, 'Plans: Iridescent Hammer', 'https://db.icy-veins.com/wow-forever/npcs/11519'),
(11519, 0, 2882, 0.042, 0, 1, 0, 1, 1, 'Plans: Silvered Bronze Shoulders', 'https://db.icy-veins.com/wow-forever/npcs/11519'),
(11520, 0, 6344, 0.073, 0, 1, 0, 1, 1, 'Formula: Enchant Bracer - Minor Spirit', 'https://db.icy-veins.com/wow-forever/npcs/11520'),
(11520, 0, 2883, 0.073, 0, 1, 0, 1, 1, 'Plans: Deadly Bronze Poniard', 'https://db.icy-veins.com/wow-forever/npcs/11520'),
(11520, 0, 4409, 0.073, 0, 1, 0, 1, 1, 'Schematic: Small Seaforium Charge', 'https://db.icy-veins.com/wow-forever/npcs/11520'),
(11520, 0, 6348, 0.037, 0, 1, 0, 1, 1, 'Formula: Enchant Weapon - Minor Beastslayer', 'https://db.icy-veins.com/wow-forever/npcs/11520'),
(11520, 0, 5972, 0.037, 0, 1, 0, 1, 1, 'Pattern: Fine Leather Pants', 'https://db.icy-veins.com/wow-forever/npcs/11520'),
(11520, 0, 4349, 0.037, 0, 1, 0, 1, 1, 'Pattern: Phoenix Pants', 'https://db.icy-veins.com/wow-forever/npcs/11520'),
(11520, 0, 4347, 0.037, 0, 1, 0, 1, 1, 'Pattern: Reinforced Woolen Shoulders', 'https://db.icy-veins.com/wow-forever/npcs/11520'),
(11520, 0, 3611, 0.037, 0, 1, 0, 1, 1, 'Plans: Green Iron Boots', 'https://db.icy-veins.com/wow-forever/npcs/11520'),
(11520, 0, 6044, 0.037, 0, 1, 0, 1, 1, 'Plans: Iron Shield Spike', 'https://db.icy-veins.com/wow-forever/npcs/11520'),
(11520, 0, 2882, 0.037, 0, 1, 0, 1, 1, 'Plans: Silvered Bronze Shoulders', 'https://db.icy-veins.com/wow-forever/npcs/11520'),
(11520, 0, 6211, 0.037, 0, 1, 0, 1, 1, 'Recipe: Elixir of Ogre''s Strength', 'https://db.icy-veins.com/wow-forever/npcs/11520');
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_loot_template` t WHERE t.`Entry` = s.`Entry` AND t.`ItemType` = s.`ItemType` AND t.`Item` = s.`Item`) AND EXISTS (SELECT 1 FROM `creature_template_difficulty` d
 WHERE d.`Entry` = s.`Entry` AND d.`DifficultyID` = 0 AND d.`LootID` = s.`Entry`)
AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = s.`Entry`
 AND c.`map` = 389)
AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`LootID` = s.`Entry` AND d.`Entry` <> s.`Entry`)
AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l JOIN `reference_loot_template` ref ON ref.`Entry` = l.`Item`
 WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 1 AND ref.`ItemType` = 0 AND ref.`Item` = s.`Item`)
AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l JOIN `reference_loot_template` r ON r.`Entry` = l.`Item`
 JOIN `reference_loot_template` ref ON ref.`Entry` = r.`Item` WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 1
 AND r.`ItemType` = 1 AND ref.`ItemType` = 0 AND ref.`Item` = s.`Item`)
AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template'
 AND r.`k1` = s.`Entry` AND r.`k2` = s.`ItemType` AND r.`k3` = s.`Item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, '2026_11_12_03_world_everlake_ragefire_classic_recipes.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_12_03_world_everlake_ragefire_classic_recipes.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

SET SESSION autocommit = 1;
