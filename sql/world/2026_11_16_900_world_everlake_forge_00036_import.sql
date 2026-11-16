-- Everlake Forge #36: Import, 1 resource(s), 51 row(s)
-- Applied on the test realm as the tracker's Forge operation #37; numbered 36 here, the next free number of this repository.
-- 2026_11_16_900_world_everlake_forge_00036_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70938) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
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
-- gameobject_loot_template: 10 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `gameobject_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(142278, 0, 277953, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(142409, 0, 278191, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(142450, 0, 278404, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(142452, 0, 278462, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(142510, 0, 278868, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(142688, 0, 279383, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(142837, 0, 280132, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(142838, 0, 280132, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(142869, 0, 280369, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(143081, 0, 280806, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16');
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_16_900_world_everlake_forge_00036_import.sql', 'Forge #36 (import)' FROM `everlake_forge_stage` s;

-- creature_loot_template: 36 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1785, 0, 254120, 3.11, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(1795, 0, 254138, 2.08, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(5471, 0, 252908, 1.08, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(5710, 0, 273119, 0.96, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(5852, 0, 254076, 2.09, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(6004, 0, 252928, 2.23, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(6006, 0, 252931, 2.56, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(6193, 0, 250980, 1.08, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(6527, 0, 252927, 2.53, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(6557, 0, 252878, 2.17, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7025, 0, 252888, 7.14, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7033, 0, 264224, 1.75, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7376, 0, 252889, 0.99, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7448, 0, 281241, 22.41, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7449, 0, 281241, 28.81, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7451, 0, 251443, 2.05, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7455, 0, 281242, 50, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7456, 0, 281242, 32.31, 1, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7523, 0, 254122, 5.88, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7885, 0, 252886, 4.55, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(7886, 0, 250189, 10.61, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(8983, 0, 273113, 9.76, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(9262, 0, 252895, 9.59, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(9583, 0, 251451, 3.85, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(9736, 0, 273115, 7.35, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(9816, 0, 249520, 15.79, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(10318, 0, 252939, 13.04, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(10399, 0, 249524, 12.7, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(10417, 0, 254140, 2.9, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(10436, 0, 273124, 7.14, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(10498, 0, 249523, 13.16, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(10596, 0, 249521, 11.54, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(11058, 0, 273117, 5.88, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(11261, 0, 273118, 3.85, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(11441, 0, 251452, 12.82, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16'),
(11462, 0, 252891, 7.04, 0, 1, 0, 1, 1, 'Wowhead 2026-11-16');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_16_900_world_everlake_forge_00036_import.sql', 'Forge #36 (import)' FROM `everlake_forge_stage` s;

-- npc_vendor: 2 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `npc_vendor` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES
(214954, 0, 221315, 0, 0, 0, 1, NULL, 0, 0, 70938),
(269152, 0, 277960, 0, 0, 0, 1, NULL, 0, 0, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `npc_vendor` x ON x.`entry` <=> s.`entry` AND x.`item` <=> s.`item` AND x.`ExtendedCost` <=> s.`ExtendedCost` AND x.`type` <=> s.`type`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`entry`);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'npc_vendor', s.`entry`, s.`item`, s.`ExtendedCost`, s.`type`, '2026_11_16_900_world_everlake_forge_00036_import.sql', 'Forge #36 (import)' FROM `everlake_forge_stage` s;

-- flags and empty columns the operation set (only where still unset)
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` = 214954 AND (`npcflag` & 128) <> 128;
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` = 269152 AND (`npcflag` & 128) <> 128;

-- values a source measured again: each statement names the value it replaces, so it changes nothing where the
-- row moved on, and nothing more when it runs again
UPDATE `creature_loot_template` SET `Chance` = 1.83 WHERE `Entry` = 2720 AND `ItemType` = 0 AND `Item` = 249512 AND ABS(`Chance` - 2.04) < 0.005 /* refresh */;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
