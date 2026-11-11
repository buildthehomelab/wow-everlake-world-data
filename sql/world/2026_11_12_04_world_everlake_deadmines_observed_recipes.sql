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
-- Observed Deadmines crafting drops (Icy Veins Forever NPC loot tables).
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`Entry` int unsigned NOT NULL, `ItemType` tinyint NOT NULL, `Item` int unsigned NOT NULL, `Chance` float NOT NULL, `QuestRequired` tinyint(1) NOT NULL, `LootMode` smallint unsigned NOT NULL, `GroupId` tinyint unsigned NOT NULL, `MinCount` tinyint unsigned NOT NULL, `MaxCount` tinyint unsigned NOT NULL, `Comment` varchar(255) NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`Entry`, `ItemType`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`, `note`) VALUES
(644, 0, 11039, 0.061, 0, 1, 0, 1, 1, 'Formula: Enchant Cloak - Minor Agility', 'https://db.icy-veins.com/wow-forever/npcs/644'),
(644, 0, 6391, 0.061, 0, 1, 0, 1, 1, 'Pattern: Stylish Green Shirt', 'https://db.icy-veins.com/wow-forever/npcs/644'),
(644, 0, 2883, 0.061, 0, 1, 0, 1, 1, 'Plans: Deadly Bronze Poniard', 'https://db.icy-veins.com/wow-forever/npcs/644'),
(644, 0, 6044, 0.061, 0, 1, 0, 1, 1, 'Plans: Iron Shield Spike', 'https://db.icy-veins.com/wow-forever/npcs/644'),
(643, 0, 251343, 0.613, 0, 1, 0, 1, 1, 'Plans: Acolyte''s Chain Shirt', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 251344, 0.613, 0, 1, 0, 1, 1, 'Plans: Crusader''s Chain Shirt', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 251341, 0.613, 0, 1, 0, 1, 1, 'Plans: Guard''s Chain Shirt', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 252775, 0.511, 0, 1, 0, 1, 1, 'Pattern: Stormrider''s Leather Armor', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 251340, 0.511, 0, 1, 0, 1, 1, 'Plans: Veteran''s Chain Shirt', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 252771, 0.306, 0, 1, 0, 1, 1, 'Pattern: Brawler''s Leather Armor', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 253906, 0.306, 0, 1, 0, 1, 1, 'Pattern: Filigreed Flame Gown', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 6347, 0.102, 0, 1, 0, 1, 1, 'Formula: Enchant Bracer - Minor Strength', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 4294, 0.102, 0, 1, 0, 1, 1, 'Pattern: Hillman''s Belt', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 4348, 0.102, 0, 1, 0, 1, 1, 'Pattern: Phoenix Gloves', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 2881, 0.102, 0, 1, 0, 1, 1, 'Plans: Runed Copper Breastplate', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 10424, 0.102, 0, 1, 0, 1, 1, 'Plans: Silvered Bronze Leggings', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(643, 0, 4410, 0.102, 0, 1, 0, 1, 1, 'Schematic: Shadow Goggles', 'https://db.icy-veins.com/wow-forever/npcs/643'),
(1763, 0, 6375, 0.063, 0, 1, 0, 1, 1, 'Formula: Enchant Bracer - Lesser Spirit', 'https://db.icy-veins.com/wow-forever/npcs/1763'),
(1763, 0, 11039, 0.063, 0, 1, 0, 1, 1, 'Formula: Enchant Cloak - Minor Agility', 'https://db.icy-veins.com/wow-forever/npcs/1763'),
(1763, 0, 4296, 0.063, 0, 1, 0, 1, 1, 'Pattern: Dark Leather Shoulders', 'https://db.icy-veins.com/wow-forever/npcs/1763'),
(1763, 0, 3611, 0.063, 0, 1, 0, 1, 1, 'Plans: Green Iron Boots', 'https://db.icy-veins.com/wow-forever/npcs/1763'),
(1763, 0, 5543, 0.063, 0, 1, 0, 1, 1, 'Plans: Iridescent Hammer', 'https://db.icy-veins.com/wow-forever/npcs/1763'),
(1763, 0, 10424, 0.063, 0, 1, 0, 1, 1, 'Plans: Silvered Bronze Leggings', 'https://db.icy-veins.com/wow-forever/npcs/1763'),
(1763, 0, 3396, 0.063, 0, 1, 0, 1, 1, 'Recipe: Elixir of Lesser Agility', 'https://db.icy-veins.com/wow-forever/npcs/1763'),
(1763, 0, 4410, 0.063, 0, 1, 0, 1, 1, 'Schematic: Shadow Goggles', 'https://db.icy-veins.com/wow-forever/npcs/1763'),
(646, 0, 10316, 0.129, 0, 1, 0, 1, 1, 'Pattern: Colorful Kilt', 'https://db.icy-veins.com/wow-forever/npcs/646'),
(646, 0, 7092, 0.129, 0, 1, 0, 1, 1, 'Pattern: Hands of Darkness', 'https://db.icy-veins.com/wow-forever/npcs/646'),
(646, 0, 4345, 0.129, 0, 1, 0, 1, 1, 'Pattern: Red Woolen Boots', 'https://db.icy-veins.com/wow-forever/npcs/646'),
(646, 0, 6390, 0.129, 0, 1, 0, 1, 1, 'Pattern: Stylish Blue Shirt', 'https://db.icy-veins.com/wow-forever/npcs/646'),
(646, 0, 11098, 0.064, 0, 1, 0, 1, 1, 'Formula: Enchant Cloak - Lesser Shadow Resistance', 'https://db.icy-veins.com/wow-forever/npcs/646'),
(646, 0, 11081, 0.064, 0, 1, 0, 1, 1, 'Formula: Enchant Shield - Lesser Protection', 'https://db.icy-veins.com/wow-forever/npcs/646'),
(646, 0, 2409, 0.064, 0, 1, 0, 1, 1, 'Pattern: Dark Leather Tunic', 'https://db.icy-veins.com/wow-forever/npcs/646'),
(646, 0, 4348, 0.064, 0, 1, 0, 1, 1, 'Pattern: Phoenix Gloves', 'https://db.icy-veins.com/wow-forever/npcs/646'),
(646, 0, 5578, 0.064, 0, 1, 0, 1, 1, 'Plans: Silvered Bronze Breastplate', 'https://db.icy-veins.com/wow-forever/npcs/646'),
(645, 0, 11098, 0.078, 0, 1, 0, 1, 1, 'Formula: Enchant Cloak - Lesser Shadow Resistance', 'https://db.icy-veins.com/wow-forever/npcs/645'),
(645, 0, 4297, 0.078, 0, 1, 0, 1, 1, 'Pattern: Barbaric Gloves', 'https://db.icy-veins.com/wow-forever/npcs/645'),
(645, 0, 10316, 0.078, 0, 1, 0, 1, 1, 'Pattern: Colorful Kilt', 'https://db.icy-veins.com/wow-forever/npcs/645'),
(645, 0, 6391, 0.078, 0, 1, 0, 1, 1, 'Pattern: Stylish Green Shirt', 'https://db.icy-veins.com/wow-forever/npcs/645'),
(639, 0, 10316, 0.125, 0, 1, 0, 1, 1, 'Pattern: Colorful Kilt', 'https://db.icy-veins.com/wow-forever/npcs/639'),
(639, 0, 4352, 0.063, 0, 1, 0, 1, 1, 'Pattern: Boots of the Enchanter', 'https://db.icy-veins.com/wow-forever/npcs/639'),
(639, 0, 5543, 0.063, 0, 1, 0, 1, 1, 'Plans: Iridescent Hammer', 'https://db.icy-veins.com/wow-forever/npcs/639'),
(639, 0, 5578, 0.063, 0, 1, 0, 1, 1, 'Plans: Silvered Bronze Breastplate', 'https://db.icy-veins.com/wow-forever/npcs/639'),
(639, 0, 10601, 0.063, 0, 1, 0, 1, 1, 'Schematic: Bright-Eye Goggles', 'https://db.icy-veins.com/wow-forever/npcs/639');
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_loot_template` t WHERE t.`Entry` = s.`Entry` AND t.`ItemType` = s.`ItemType` AND t.`Item` = s.`Item`) AND EXISTS (SELECT 1 FROM `creature_template_difficulty` d
 WHERE d.`Entry` = s.`Entry` AND d.`DifficultyID` = 0 AND d.`LootID` = s.`Entry`)
AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = IF(s.`Entry` = 643, 642, s.`Entry`)
 AND c.`map` = 36)
AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`LootID` = s.`Entry` AND d.`Entry` <> s.`Entry`)
AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l JOIN `reference_loot_template` ref ON ref.`Entry` = l.`Item`
 WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 1 AND ref.`ItemType` = 0 AND ref.`Item` = s.`Item`)
AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l JOIN `reference_loot_template` r ON r.`Entry` = l.`Item`
 JOIN `reference_loot_template` ref ON ref.`Entry` = r.`Item` WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 1
 AND r.`ItemType` = 1 AND ref.`ItemType` = 0 AND ref.`Item` = s.`Item`)
AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template'
 AND r.`k1` = s.`Entry` AND r.`k2` = s.`ItemType` AND r.`k3` = s.`Item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, '2026_11_12_04_world_everlake_deadmines_observed_recipes.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_12_04_world_everlake_deadmines_observed_recipes.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

SET SESSION autocommit = 1;
