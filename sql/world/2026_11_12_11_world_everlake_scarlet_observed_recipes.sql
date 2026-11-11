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
-- Observed Scarlet Monastery crafting drops (Icy Veins Forever NPC loot tables).
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`Entry` int unsigned NOT NULL, `ItemType` tinyint NOT NULL, `Item` int unsigned NOT NULL, `Chance` float NOT NULL, `QuestRequired` tinyint(1) NOT NULL, `LootMode` smallint unsigned NOT NULL, `GroupId` tinyint unsigned NOT NULL, `MinCount` tinyint unsigned NOT NULL, `MaxCount` tinyint unsigned NOT NULL, `Comment` varchar(255) NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`Entry`, `ItemType`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`, `note`) VALUES
(3974, 0, 252814, 0.377, 0, 1, 0, 1, 1, 'Pattern: Brawler''s Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/3974'),
(3974, 0, 253982, 0.377, 0, 1, 0, 1, 1, 'Pattern: Filigreed Shadow Circlet', 'https://db.icy-veins.com/wow-forever/npcs/3974'),
(3974, 0, 3867, 0.377, 0, 1, 0, 1, 1, 'Plans: Golden Iron Destroyer', 'https://db.icy-veins.com/wow-forever/npcs/3974'),
(3974, 0, 3873, 0.377, 0, 1, 0, 1, 1, 'Plans: Golden Scale Cuirass', 'https://db.icy-veins.com/wow-forever/npcs/3974'),
(3975, 0, 10606, 1.56, 0, 1, 0, 1, 1, 'Schematic: Parachute Cloak', 'https://db.icy-veins.com/wow-forever/npcs/3975'),
(3975, 0, 251402, 1.04, 0, 1, 0, 1, 1, 'Plans: Justicar''s Boots', 'https://db.icy-veins.com/wow-forever/npcs/3975'),
(3975, 0, 254042, 0.521, 0, 1, 0, 1, 1, 'Pattern: Fiery Cord', 'https://db.icy-veins.com/wow-forever/npcs/3975'),
(3975, 0, 254040, 0.521, 0, 1, 0, 1, 1, 'Pattern: Frothing Cord', 'https://db.icy-veins.com/wow-forever/npcs/3975'),
(3975, 0, 252844, 0.521, 0, 1, 0, 1, 1, 'Pattern: Skulker''s Leather Shoes', 'https://db.icy-veins.com/wow-forever/npcs/3975'),
(3975, 0, 252846, 0.521, 0, 1, 0, 1, 1, 'Pattern: Skycaller''s Leather Shoes', 'https://db.icy-veins.com/wow-forever/npcs/3975'),
(3975, 0, 4353, 0.521, 0, 1, 0, 1, 1, 'Pattern: Spider Belt', 'https://db.icy-veins.com/wow-forever/npcs/3975'),
(3975, 0, 251398, 0.521, 0, 1, 0, 1, 1, 'Plans: Officer''s Boots', 'https://db.icy-veins.com/wow-forever/npcs/3975'),
(3975, 0, 251401, 0.521, 0, 1, 0, 1, 1, 'Plans: Prefect''s Boots', 'https://db.icy-veins.com/wow-forever/npcs/3975'),
(3976, 0, 254046, 2.08, 0, 1, 0, 1, 1, 'Pattern: Golden Cord', 'https://db.icy-veins.com/wow-forever/npcs/3976'),
(3976, 0, 251400, 2.08, 0, 1, 0, 1, 1, 'Plans: Warder''s Boots', 'https://db.icy-veins.com/wow-forever/npcs/3976'),
(3976, 0, 254044, 1.04, 0, 1, 0, 1, 1, 'Pattern: Black Cord', 'https://db.icy-veins.com/wow-forever/npcs/3976'),
(3976, 0, 254042, 1.04, 0, 1, 0, 1, 1, 'Pattern: Fiery Cord', 'https://db.icy-veins.com/wow-forever/npcs/3976'),
(3976, 0, 252899, 1.04, 0, 1, 0, 1, 1, 'Pattern: Mender''s Mail Boots', 'https://db.icy-veins.com/wow-forever/npcs/3976'),
(3976, 0, 252898, 1.04, 0, 1, 0, 1, 1, 'Pattern: Skirmisher''s Mail Boots', 'https://db.icy-veins.com/wow-forever/npcs/3976'),
(3976, 0, 252844, 1.04, 0, 1, 0, 1, 1, 'Pattern: Skulker''s Leather Shoes', 'https://db.icy-veins.com/wow-forever/npcs/3976'),
(3976, 0, 252897, 1.04, 0, 1, 0, 1, 1, 'Pattern: Skycaller''s Mail Boots', 'https://db.icy-veins.com/wow-forever/npcs/3976'),
(3976, 0, 252896, 1.04, 0, 1, 0, 1, 1, 'Pattern: Stalker''s Mail Boots', 'https://db.icy-veins.com/wow-forever/npcs/3976'),
(3976, 0, 251399, 1.04, 0, 1, 0, 1, 1, 'Plans: Sentinel''s Boots', 'https://db.icy-veins.com/wow-forever/npcs/3976'),
(3977, 0, 254044, 1.18, 0, 1, 0, 1, 1, 'Pattern: Black Cord', 'https://db.icy-veins.com/wow-forever/npcs/3977'),
(3977, 0, 254040, 1.18, 0, 1, 0, 1, 1, 'Pattern: Frothing Cord', 'https://db.icy-veins.com/wow-forever/npcs/3977'),
(3977, 0, 252899, 1.18, 0, 1, 0, 1, 1, 'Pattern: Mender''s Mail Boots', 'https://db.icy-veins.com/wow-forever/npcs/3977'),
(3977, 0, 251402, 1.18, 0, 1, 0, 1, 1, 'Plans: Justicar''s Boots', 'https://db.icy-veins.com/wow-forever/npcs/3977'),
(4543, 0, 252819, 1.08, 0, 1, 0, 1, 1, 'Pattern: Wisdom''s Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 251350, 1.08, 0, 1, 0, 1, 1, 'Plans: Veteran''s Chain Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 7084, 0.719, 0, 1, 0, 1, 1, 'Pattern: Crimson Silk Shoulders', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 252816, 0.719, 0, 1, 0, 1, 1, 'Pattern: Defender''s Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 253984, 0.719, 0, 1, 0, 1, 1, 'Pattern: Filigreed Pearly Circlet', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 253982, 0.719, 0, 1, 0, 1, 1, 'Pattern: Filigreed Shadow Circlet', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 253986, 0.719, 0, 1, 0, 1, 1, 'Pattern: Filigreed Shining Circlet', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 252818, 0.719, 0, 1, 0, 1, 1, 'Pattern: Stormrider''s Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 252817, 0.719, 0, 1, 0, 1, 1, 'Pattern: Totemic Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 252815, 0.719, 0, 1, 0, 1, 1, 'Pattern: Trapper''s Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 251353, 0.719, 0, 1, 0, 1, 1, 'Plans: Acolyte''s Chain Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 251352, 0.719, 0, 1, 0, 1, 1, 'Plans: Protector''s Chain Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 252814, 0.36, 0, 1, 0, 1, 1, 'Pattern: Brawler''s Leather Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 253980, 0.36, 0, 1, 0, 1, 1, 'Pattern: Filigreed Flame Circlet', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 253978, 0.36, 0, 1, 0, 1, 1, 'Pattern: Filigreed Silky Circlet', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 4353, 0.36, 0, 1, 0, 1, 1, 'Pattern: Spider Belt', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 251354, 0.36, 0, 1, 0, 1, 1, 'Plans: Crusader''s Chain Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(4543, 0, 251351, 0.36, 0, 1, 0, 1, 1, 'Plans: Guard''s Chain Helm', 'https://db.icy-veins.com/wow-forever/npcs/4543'),
(6487, 0, 254044, 0.752, 0, 1, 0, 1, 1, 'Pattern: Black Cord', 'https://db.icy-veins.com/wow-forever/npcs/6487'),
(6487, 0, 254042, 0.376, 0, 1, 0, 1, 1, 'Pattern: Fiery Cord', 'https://db.icy-veins.com/wow-forever/npcs/6487'),
(6487, 0, 254046, 0.376, 0, 1, 0, 1, 1, 'Pattern: Golden Cord', 'https://db.icy-veins.com/wow-forever/npcs/6487'),
(6487, 0, 252843, 0.376, 0, 1, 0, 1, 1, 'Pattern: Prowler''s Leather Shoes', 'https://db.icy-veins.com/wow-forever/npcs/6487'),
(6487, 0, 251398, 0.376, 0, 1, 0, 1, 1, 'Plans: Officer''s Boots', 'https://db.icy-veins.com/wow-forever/npcs/6487'),
(6487, 0, 251400, 0.376, 0, 1, 0, 1, 1, 'Plans: Warder''s Boots', 'https://db.icy-veins.com/wow-forever/npcs/6487'),
(4542, 0, 251401, 1.94, 0, 1, 0, 1, 1, 'Plans: Prefect''s Boots', 'https://db.icy-veins.com/wow-forever/npcs/4542'),
(4542, 0, 252847, 0.971, 0, 1, 0, 1, 1, 'Pattern: Mender''s Leather Shoes', 'https://db.icy-veins.com/wow-forever/npcs/4542'),
(4542, 0, 252843, 0.971, 0, 1, 0, 1, 1, 'Pattern: Prowler''s Leather Shoes', 'https://db.icy-veins.com/wow-forever/npcs/4542'),
(4542, 0, 252897, 0.971, 0, 1, 0, 1, 1, 'Pattern: Skycaller''s Mail Boots', 'https://db.icy-veins.com/wow-forever/npcs/4542');
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_loot_template` t WHERE t.`Entry` = s.`Entry` AND t.`ItemType` = s.`ItemType` AND t.`Item` = s.`Item`) AND EXISTS (SELECT 1 FROM `creature_template_difficulty` d
 WHERE d.`Entry` = s.`Entry` AND d.`DifficultyID` = 0 AND d.`LootID` = s.`Entry`)
AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = s.`Entry`
 AND c.`map` = 189)
AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`LootID` = s.`Entry` AND d.`Entry` <> s.`Entry`)
AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l JOIN `reference_loot_template` ref ON ref.`Entry` = l.`Item`
 WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 1 AND ref.`ItemType` = 0 AND ref.`Item` = s.`Item`)
AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l JOIN `reference_loot_template` r ON r.`Entry` = l.`Item`
 JOIN `reference_loot_template` ref ON ref.`Entry` = r.`Item` WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 1
 AND r.`ItemType` = 1 AND ref.`ItemType` = 0 AND ref.`Item` = s.`Item`)
AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template'
 AND r.`k1` = s.`Entry` AND r.`k2` = s.`ItemType` AND r.`k3` = s.`Item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, '2026_11_12_11_world_everlake_scarlet_observed_recipes.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_12_11_world_everlake_scarlet_observed_recipes.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

SET SESSION autocommit = 1;
