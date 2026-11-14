-- Everlake Forge #21: Import, 1 resource(s), 119 row(s)
-- 2026_11_14_900_world_everlake_forge_00021_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70862) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Icy Veins 2026-11-14 (what its players recorded on live Forever: creature drops, with its measured chances) (NOTICE.md, Forge exports).
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
-- creature_loot_template: 108 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(588, 0, 277957, 1.09, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(595, 0, 277957, 1.35, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(597, 0, 277957, 0.79, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(660, 0, 277957, 0.92, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(671, 0, 277957, 0.35, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(699, 0, 277957, 0.96, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(701, 0, 277957, 1.88, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(780, 0, 213127, 7.75, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(813, 0, 216616, 1.61, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(939, 0, 216616, 12.39, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(978, 0, 216616, 5.51, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1094, 0, 264210, 0.57, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1564, 0, 217161, 8.43, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2287, 0, 284870, 0.46, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2347, 0, 213526, 86.96, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2567, 0, 249487, 0.93, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2570, 0, 264212, 0.62, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2596, 0, 251393, 1.5, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2656, 0, 264218, 1.12, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2701, 0, 278515, 5.26, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2715, 0, 278515, 5.11, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2739, 0, 278402, 19.26, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2740, 0, 278402, 13.61, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2748, 0, 252868, 2.38, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2748, 0, 252870, 2.38, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2748, 0, 252919, 2.38, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2893, 0, 278402, 1.49, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2894, 0, 278402, 0.73, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2927, 0, 221359, 1.31, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2928, 0, 221359, 1.49, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(2929, 0, 221359, 1.14, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(4323, 0, 279934, 2.1, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(4324, 0, 279934, 1.7, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(4329, 0, 279934, 2.99, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(4331, 0, 279934, 1.61, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(4357, 0, 279601, 22.22, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(4392, 0, 280203, 19.36, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(4467, 0, 254078, 0.75, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(4467, 0, 279225, 9.77, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(5232, 0, 251464, 2.04, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(5245, 0, 221361, 1.33, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(5246, 0, 221361, 4.62, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(5247, 0, 221361, 1.21, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(5297, 0, 254094, 3.45, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(5616, 0, 264215, 1.06, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(5846, 0, 252859, 1.59, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(6195, 0, 280608, 5.71, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(6199, 0, 274966, 3.33, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(6505, 0, 280459, 1.54, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(6506, 0, 280459, 2.94, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7030, 0, 264213, 3.7, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7267, 0, 254100, 2.08, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7271, 0, 251403, 4.35, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7271, 0, 251404, 2.17, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7271, 0, 252868, 4.35, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7271, 0, 252869, 2.17, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7271, 0, 277112, 32.61, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7272, 0, 251403, 1.61, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7273, 0, 252868, 2.08, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7273, 0, 252869, 2.08, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7273, 0, 252871, 2.08, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7273, 0, 254104, 4.17, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7286, 0, 221360, 12.65, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7796, 0, 252868, 2.22, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7797, 0, 252918, 1.96, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7797, 0, 252919, 1.96, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(7797, 0, 254100, 1.96, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(8127, 0, 251403, 2.17, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(8127, 0, 251405, 2.17, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(8127, 0, 252869, 2.17, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(8127, 0, 252870, 2.17, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(8960, 0, 277959, 37.93, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(9164, 0, 280459, 10, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(11561, 0, 254663, 0.64, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(12225, 0, 251405, 8.7, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(12225, 0, 254098, 4.35, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(12225, 0, 274964, 4.35, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(12236, 0, 274964, 4.55, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(12258, 0, 254100, 4.55, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(13282, 0, 254100, 4.76, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(250187, 0, 249695, 10.91, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(254560, 0, 266427, 0.8, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(255851, 0, 268632, 24.76, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(255901, 0, 268632, 3.5, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(256798, 0, 266427, 1.9, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(256799, 0, 265821, 46.45, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(256807, 0, 268632, 14.91, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(256952, 0, 266148, 4.86, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(256952, 0, 266427, 1.64, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(258331, 0, 268632, 28.77, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(258818, 0, 279046, 23.56, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(258966, 0, 273101, 4.55, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(258968, 0, 271721, 15.94, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(258972, 0, 267091, 10, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(258972, 0, 267234, 5.71, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(259046, 0, 268632, 9.52, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(259267, 0, 268632, 1.26, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(259269, 0, 268632, 14.52, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(260211, 0, 268581, 89.74, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(260235, 0, 268632, 9.2, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(262037, 0, 268632, 2.5, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(262397, 0, 270305, 38.82, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(263343, 0, 268632, 7.71, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(263348, 0, 268632, 8.55, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(263380, 0, 268632, 4.05, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(268831, 0, 268632, 37.1, 1, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(269175, 0, 256036, 14.53, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(269175, 0, 256037, 81.29, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_14_900_world_everlake_forge_00021_import.sql', 'Forge #21: Icy Veins 2026-11-14' FROM `everlake_forge_stage` s;

-- flags and empty columns the operation set (only where still unset)
UPDATE `creature_template_difficulty` SET `LootID` = 250187 WHERE `Entry` = 250187 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 256799 WHERE `Entry` = 256799 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 258331 WHERE `Entry` = 258331 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 258818 WHERE `Entry` = 258818 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 259046 WHERE `Entry` = 259046 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 259269 WHERE `Entry` = 259269 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 260211 WHERE `Entry` = 260211 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 262037 WHERE `Entry` = 262037 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 262397 WHERE `Entry` = 262397 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 268831 WHERE `Entry` = 268831 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 269175 WHERE `Entry` = 269175 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
