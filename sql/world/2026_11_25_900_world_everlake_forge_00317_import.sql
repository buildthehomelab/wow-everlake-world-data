-- Everlake Forge #317: Import, 1 resource(s), 66 row(s)
-- 2026_11_25_900_world_everlake_forge_00317_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 71091) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Wowhead 2026-11-25 (NOTICE.md, Forge exports).
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
-- creature_loot_template: 65 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(92, 0, 212723, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(769, 0, 213529, 97.48, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(1047, 0, 235789, 8.33, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2265, 0, 210055, 0.02, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2266, 0, 210055, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2267, 0, 210055, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2268, 0, 210055, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2269, 0, 210055, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2270, 0, 210055, 0.02, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2360, 0, 210055, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2387, 0, 210055, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2503, 0, 210055, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2735, 0, 212723, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2736, 0, 212723, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2752, 0, 212723, 2.56, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(2791, 0, 212723, 0.02, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(3780, 0, 210045, 0.08, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(3781, 0, 210045, 0.06, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(3782, 0, 210045, 0.07, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(3783, 0, 210045, 0.05, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(3784, 0, 210045, 0.07, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(4382, 0, 212726, 0.49, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(4385, 0, 212726, 2.38, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(4386, 0, 212726, 0.31, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(4387, 0, 212726, 0.75, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(5461, 0, 220510, 0.03, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(5462, 0, 220510, 0.03, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(5843, 0, 227767, 0.02, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(5844, 0, 227767, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(5846, 0, 227767, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6071, 0, 210966, 0.65, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6073, 0, 210966, 0.09, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6115, 0, 210966, 0.08, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6224, 0, 216634, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6225, 0, 216634, 0.05, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6226, 0, 216634, 0.04, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6227, 0, 216634, 0.04, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6229, 0, 216634, 0.03, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6230, 0, 216634, 0.05, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6232, 0, 216634, 0.04, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6233, 0, 216634, 0.01, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6234, 0, 216634, 0.02, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(6235, 0, 216634, 0.02, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(7369, 0, 235785, 0.27, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(7371, 0, 235785, 0.16, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(7372, 0, 235785, 0.14, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(7379, 0, 235785, 0.22, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(7445, 0, 229416, 0.12, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(7449, 0, 229416, 0.14, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(8528, 0, 227041, 0.23, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(8543, 0, 227689, 1.64, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(8550, 0, 227041, 1.45, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(9449, 0, 228912, 1.09, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(9450, 0, 228912, 1.64, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(9451, 0, 228912, 1.89, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(9452, 0, 228912, 0.97, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(10438, 0, 227690, 0.56, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(11487, 0, 227912, 0.23, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(11576, 0, 212724, 0.59, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(11577, 0, 212724, 1.1, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(11578, 0, 212724, 1.18, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(11697, 0, 210966, 0.11, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(212252, 0, 243177, 87.5, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(269275, 0, 229416, 4.76, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25'),
(269276, 0, 229416, 4.55, 0, 1, 0, 1, 1, 'Wowhead 2026-11-25');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_25_900_world_everlake_forge_00317_import.sql', 'Forge #317: Wowhead 2026-11-25' FROM `everlake_forge_stage` s;

-- flags and empty columns the operation set (only where still unset)
UPDATE `creature_template_difficulty` SET `LootID` = 212252 WHERE `Entry` = 212252 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
