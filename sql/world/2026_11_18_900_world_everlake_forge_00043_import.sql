-- Everlake Forge #43: Import, 1 resource(s), 67 row(s)
-- Applied on the test realm as the tracker's Forge operation #165; numbered 43 here, the next free number of this repository.
-- 2026_11_18_900_world_everlake_forge_00043_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70959) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Wowhead 2026-11-18 (NOTICE.md, Forge exports).
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
-- creature_loot_template: 66 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1809, 0, 252880, 1.89, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(1831, 0, 252881, 0.67, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(1853, 0, 272023, 0.6, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(1853, 0, 285962, 0.51, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(2640, 0, 250992, 0.95, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(2655, 0, 220351, 0.04, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(2656, 0, 220351, 0.04, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5243, 0, 234728, 0.45, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5261, 0, 234728, 0.47, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5262, 0, 252916, 0.93, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5420, 0, 221349, 0.11, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5426, 0, 221349, 0.03, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5465, 0, 221349, 2.17, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5616, 0, 221549, 0.02, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5617, 0, 221547, 0.04, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5709, 0, 272026, 0.26, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5852, 0, 221347, 0.3, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5855, 0, 221347, 0.12, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(5858, 0, 278160, 0.05, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(6125, 0, 221348, 0.16, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(6126, 0, 221348, 0.17, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(6127, 0, 221348, 0.19, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(7037, 0, 264223, 1.2, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(7132, 0, 238798, 0.32, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(7372, 0, 264225, 1.11, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(7379, 0, 252936, 7.14, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(7434, 0, 250180, 3.03, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(8205, 0, 286570, 9.09, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(8277, 0, 282568, 7.14, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(8283, 0, 282094, 5.88, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(8527, 0, 264226, 0.64, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(8534, 0, 252885, 3.33, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(8597, 0, 252935, 2.22, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(9019, 0, 272019, 0.29, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(9156, 0, 273122, 0.9, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(9568, 0, 272018, 0.48, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10363, 0, 285868, 0.42, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10366, 0, 284587, 0.47, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10425, 0, 252937, 3.85, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10426, 0, 264230, 0.59, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10429, 0, 285808, 0.45, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10432, 0, 273121, 5.88, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10432, 0, 276072, 1.54, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10438, 0, 284587, 0.53, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10440, 0, 272024, 0.57, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10440, 0, 285873, 0.48, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10499, 0, 252940, 8.33, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10508, 0, 273112, 2.04, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10508, 0, 285960, 0.48, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10659, 0, 268503, 2.44, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10660, 0, 268503, 2.94, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10813, 0, 272025, 0.55, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(10813, 0, 285872, 0.48, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(11291, 0, 252934, 1.96, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(11496, 0, 285949, 1.11, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(14231, 0, 285283, 4.76, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(14516, 0, 276784, 3.85, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(228609, 0, 269757, 2.63, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(228610, 0, 269757, 1.96, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(244525, 0, 257228, 0.61, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(248041, 0, 257228, 0.24, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(249551, 0, 268967, 0.25, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(256809, 0, 257228, 0.4, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(260822, 0, 269011, 10, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(267182, 0, 270301, 4.55, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(269254, 0, 278159, 1.18, 0, 1, 0, 1, 1, 'Wowhead 2026-11-18');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_18_900_world_everlake_forge_00043_import.sql', 'Forge #43: Wowhead 2026-11-18' FROM `everlake_forge_stage` s;

-- flags and empty columns the operation set (only where still unset)
UPDATE `creature_template_difficulty` SET `LootID` = 267182 WHERE `Entry` = 267182 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
