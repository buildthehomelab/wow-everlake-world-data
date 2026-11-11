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
-- Observed Fel Steed crafting drops: https://db.icy-veins.com/wow-forever/npcs/3864
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`Entry` int unsigned NOT NULL, `ItemType` tinyint NOT NULL, `Item` int unsigned NOT NULL, `Chance` float NOT NULL, `QuestRequired` tinyint(1) NOT NULL, `LootMode` smallint unsigned NOT NULL, `GroupId` tinyint unsigned NOT NULL, `MinCount` tinyint unsigned NOT NULL, `MaxCount` tinyint unsigned NOT NULL, `Comment` varchar(255) NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`Entry`, `ItemType`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`, `note`) VALUES
(3864, 0, 251344, 1.9, 0, 1, 0, 1, 1, 'Plans: Crusader''s Chain Shirt', 'Icy Veins observed Fel Steed drop'),
(3864, 0, 252773, 1.71, 0, 1, 0, 1, 1, 'Pattern: Defender''s Leather Armor', 'Icy Veins observed Fel Steed drop'),
(3864, 0, 252776, 1.71, 0, 1, 0, 1, 1, 'Pattern: Wisdom''s Leather Armor', 'Icy Veins observed Fel Steed drop'),
(3864, 0, 251343, 1.71, 0, 1, 0, 1, 1, 'Plans: Acolyte''s Chain Shirt', 'Icy Veins observed Fel Steed drop'),
(3864, 0, 252771, 1.52, 0, 1, 0, 1, 1, 'Pattern: Brawler''s Leather Armor', 'Icy Veins observed Fel Steed drop'),
(3864, 0, 252772, 1.33, 0, 1, 0, 1, 1, 'Pattern: Trapper''s Leather Armor', 'Icy Veins observed Fel Steed drop'),
(3864, 0, 251342, 1.33, 0, 1, 0, 1, 1, 'Plans: Protector''s Chain Shirt', 'Icy Veins observed Fel Steed drop'),
(3864, 0, 251340, 0.951, 0, 1, 0, 1, 1, 'Plans: Veteran''s Chain Shirt', 'Icy Veins observed Fel Steed drop'),
(3864, 0, 252774, 0.76, 0, 1, 0, 1, 1, 'Pattern: Totemic Leather Armor', 'Icy Veins observed Fel Steed drop');
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
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, '2026_11_12_01_world_everlake_fel_steed_recipes.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_12_01_world_everlake_fel_steed_recipes.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

SET SESSION autocommit = 1;
