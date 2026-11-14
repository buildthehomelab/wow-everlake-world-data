-- Everlake Forge #15: Import, 1 resource(s), 35 row(s)
-- 2026_11_13_900_world_everlake_forge_00015_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70862) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: ForeverDB.net 2026-11-14.852e11f0 (seen on live Forever) (NOTICE.md, Forge exports).
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
-- creature_loot_template: 1 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(4829, 0, 16782, 9.09, 1, 1, 0, 1, 1, 'ForeverDB.net 2026-11-14.852e11f0');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_13_900_world_everlake_forge_00015_import.sql', 'Forge #15: ForeverDB.net 2026-11-14.852e11f0 (seen on live Forever)' FROM `everlake_forge_stage` s;

-- npc_vendor: 34 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `npc_vendor` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES
(12777, 0, 272716, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12777, 0, 272717, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12777, 0, 272738, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12777, 0, 272739, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12777, 0, 272740, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12777, 0, 272741, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12777, 0, 272828, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12777, 0, 273325, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 272465, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 272467, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 272468, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 272473, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 272474, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 272475, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 272476, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 272608, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271903, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271904, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271905, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271906, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271908, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271909, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271910, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271913, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271914, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271915, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271917, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271918, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271919, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271940, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271941, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271945, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271946, 0, 0, 0, 1, NULL, 0, 0, 70862),
(263569, 0, 271955, 0, 0, 0, 1, NULL, 0, 0, 70862);
DELETE s FROM `everlake_forge_stage` s JOIN `npc_vendor` x ON x.`entry` <=> s.`entry` AND x.`item` <=> s.`item` AND x.`ExtendedCost` <=> s.`ExtendedCost` AND x.`type` <=> s.`type`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`entry`);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'npc_vendor', s.`entry`, s.`item`, s.`ExtendedCost`, s.`type`, '2026_11_13_900_world_everlake_forge_00015_import.sql', 'Forge #15: ForeverDB.net 2026-11-14.852e11f0 (seen on live Forever)' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
