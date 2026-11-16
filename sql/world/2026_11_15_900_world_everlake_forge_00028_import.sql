-- Everlake Forge #28: Import, 1 resource(s), 81 row(s)
-- Applied on the test realm as the tracker's Forge operation #27; numbered 28 here, the next free number of this repository.
-- 2026_11_15_900_world_everlake_forge_00028_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70938) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Icy Veins 2026-11-15 (gaps) (NOTICE.md, Forge exports).
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing: a row is added only
-- where none exists, spawns only where the same creature or object is not already within 5 yards, and each added row is recorded in everlake_import_rows.

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
-- creature_loot_template: 81 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1784, 0, 252930, 2.42, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(2552, 0, 254014, 0.52, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(2653, 0, 251396, 0.7, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(2720, 0, 249512, 2.04, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(2748, 0, 251406, 0.37, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(2748, 0, 254106, 0.37, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(4334, 0, 254684, 2.86, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(4658, 0, 254681, 1.92, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(4684, 0, 250363, 0.69, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(5296, 0, 252909, 1.28, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(5333, 0, 254686, 1.4, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(5363, 0, 250986, 1.43, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(5709, 0, 251407, 1.92, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(5710, 0, 251406, 3.7, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(5710, 0, 254102, 1.85, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(5715, 0, 254106, 5, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(5839, 0, 264214, 0.46, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(5856, 0, 254685, 1.34, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(6005, 0, 252883, 2.97, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(6116, 0, 252858, 2.47, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(6117, 0, 251438, 1.11, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(6126, 0, 254074, 2.48, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(6195, 0, 252932, 0.99, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(6198, 0, 252929, 0.66, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(6199, 0, 251441, 1.03, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(6520, 0, 252882, 2.27, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7108, 0, 251442, 2.44, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7115, 0, 252926, 0.74, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7139, 0, 254126, 2.33, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7153, 0, 252866, 0.98, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7154, 0, 249514, 1.68, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7155, 0, 251440, 1.28, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7158, 0, 252865, 2.19, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7267, 0, 251406, 1.05, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7267, 0, 251407, 0.7, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7267, 0, 252867, 0.7, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7267, 0, 254102, 0.7, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7267, 0, 254106, 0.35, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7271, 0, 254102, 0.32, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7271, 0, 254106, 0.64, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7273, 0, 251407, 0.38, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7273, 0, 252867, 0.38, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7273, 0, 254102, 0.76, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7273, 0, 254106, 0.76, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7275, 0, 251406, 0.39, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7275, 0, 251407, 0.39, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7275, 0, 254102, 0.78, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7440, 0, 252890, 3.43, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7796, 0, 251406, 0.37, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7797, 0, 251407, 0.36, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(7797, 0, 254102, 0.36, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(8127, 0, 251406, 0.38, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(8127, 0, 251407, 1.52, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(8440, 0, 251406, 1.85, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(8566, 0, 251439, 1.4, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(8600, 0, 251444, 3.33, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(8602, 0, 250175, 9.09, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(8893, 0, 251467, 1.64, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(9018, 0, 252867, 3.03, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(9018, 0, 254102, 3.03, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(9024, 0, 252867, 3.7, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(9318, 0, 252915, 2.14, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(9502, 0, 252867, 4.55, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(9543, 0, 251407, 4.55, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(9543, 0, 254102, 4.55, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(9862, 0, 264228, 5.66, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(9878, 0, 252879, 2.5, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(12201, 0, 251407, 0.81, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(12203, 0, 252867, 1.79, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(12203, 0, 254106, 1.79, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(12225, 0, 251407, 0.96, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(12225, 0, 254102, 0.96, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(12225, 0, 254106, 0.96, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(12236, 0, 254106, 0.86, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(12258, 0, 251407, 0.91, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(13596, 0, 252867, 0.9, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(13596, 0, 254102, 0.9, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(13596, 0, 254106, 1.8, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(13601, 0, 252867, 1.15, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(13601, 0, 254106, 1.15, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)'),
(249229, 0, 284871, 1.45, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-15 (gaps)');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_15_900_world_everlake_forge_00028_import.sql', 'Forge #28: Icy Veins 2026-11-15 (gaps)' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
