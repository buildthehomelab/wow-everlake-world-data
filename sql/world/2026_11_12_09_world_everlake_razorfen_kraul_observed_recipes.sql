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
-- Observed Razorfen Kraul crafting drops (Icy Veins Forever NPC loot tables).
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`Entry` int unsigned NOT NULL, `ItemType` tinyint NOT NULL, `Item` int unsigned NOT NULL, `Chance` float NOT NULL, `QuestRequired` tinyint(1) NOT NULL, `LootMode` smallint unsigned NOT NULL, `GroupId` tinyint unsigned NOT NULL, `MinCount` tinyint unsigned NOT NULL, `MaxCount` tinyint unsigned NOT NULL, `Comment` varchar(255) NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`Entry`, `ItemType`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`, `note`) VALUES
(6168, 0, 252816, 1.68, 0, 1, 0, 1, 1, 'Pattern: Defender''s Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/6168'),
(6168, 0, 253978, 1.68, 0, 1, 0, 1, 1, 'Pattern: Filigreed Silky Circlet', 'https://db.icy-veins.com/wow-forever/npcs/6168'),
(6168, 0, 251352, 1.68, 0, 1, 0, 1, 1, 'Plans: Protector''s Chain Helm', 'https://db.icy-veins.com/wow-forever/npcs/6168'),
(6168, 0, 253980, 0.84, 0, 1, 0, 1, 1, 'Pattern: Filigreed Flame Circlet', 'https://db.icy-veins.com/wow-forever/npcs/6168'),
(6168, 0, 252817, 0.84, 0, 1, 0, 1, 1, 'Pattern: Totemic Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/6168'),
(6168, 0, 251353, 0.84, 0, 1, 0, 1, 1, 'Plans: Acolyte''s Chain Helm', 'https://db.icy-veins.com/wow-forever/npcs/6168'),
(4842, 0, 252816, 2.44, 0, 1, 0, 1, 1, 'Pattern: Defender''s Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/4842'),
(4842, 0, 253980, 1.22, 0, 1, 0, 1, 1, 'Pattern: Filigreed Flame Circlet', 'https://db.icy-veins.com/wow-forever/npcs/4842'),
(4842, 0, 253984, 1.22, 0, 1, 0, 1, 1, 'Pattern: Filigreed Pearly Circlet', 'https://db.icy-veins.com/wow-forever/npcs/4842'),
(4842, 0, 253982, 1.22, 0, 1, 0, 1, 1, 'Pattern: Filigreed Shadow Circlet', 'https://db.icy-veins.com/wow-forever/npcs/4842'),
(4842, 0, 252818, 1.22, 0, 1, 0, 1, 1, 'Pattern: Stormrider''s Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/4842'),
(4842, 0, 251354, 1.22, 0, 1, 0, 1, 1, 'Plans: Crusader''s Chain Helm', 'https://db.icy-veins.com/wow-forever/npcs/4842'),
(4842, 0, 251352, 1.22, 0, 1, 0, 1, 1, 'Plans: Protector''s Chain Helm', 'https://db.icy-veins.com/wow-forever/npcs/4842');
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_loot_template` t WHERE t.`Entry` = s.`Entry` AND t.`ItemType` = s.`ItemType` AND t.`Item` = s.`Item`) AND EXISTS (SELECT 1 FROM `creature_template_difficulty` d
 WHERE d.`Entry` = s.`Entry` AND d.`DifficultyID` = 0 AND d.`LootID` = s.`Entry`)
AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = s.`Entry`
 AND c.`map` = 47)
AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`LootID` = s.`Entry` AND d.`Entry` <> s.`Entry`)
AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l JOIN `reference_loot_template` ref ON ref.`Entry` = l.`Item`
 WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 1 AND ref.`ItemType` = 0 AND ref.`Item` = s.`Item`)
AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l JOIN `reference_loot_template` r ON r.`Entry` = l.`Item`
 JOIN `reference_loot_template` ref ON ref.`Entry` = r.`Item` WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 1
 AND r.`ItemType` = 1 AND ref.`ItemType` = 0 AND ref.`Item` = s.`Item`)
AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template'
 AND r.`k1` = s.`Entry` AND r.`k2` = s.`ItemType` AND r.`k3` = s.`Item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, '2026_11_12_09_world_everlake_razorfen_kraul_observed_recipes.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_12_09_world_everlake_razorfen_kraul_observed_recipes.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

SET SESSION autocommit = 1;
