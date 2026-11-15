-- Everlake Forge #27: Import, 1 resource(s), 25 row(s)
-- 2026_11_15_900_world_everlake_forge_00027_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70938) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Wowhead 2026-11-15 (NOTICE.md, Forge exports).
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
-- gameobject_loot_template: 5 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `gameobject_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(136239, 0, 254841, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(138719, 0, 265806, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(139485, 0, 267361, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(140538, 0, 271823, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(141342, 0, 274975, 100, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15');
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_15_900_world_everlake_forge_00027_import.sql', 'Forge #27: Wowhead 2026-11-15' FROM `everlake_forge_stage` s;

-- creature_loot_template: 13 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1852, 0, 17114, 1.19, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(6004, 0, 220214, 1.68, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(8519, 0, 17309, 24.24, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(8520, 0, 17309, 23.63, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(8521, 0, 17309, 47.83, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(8522, 0, 17309, 46.95, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(9456, 0, 11227, 1.12, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(9938, 0, 277129, 23.08, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(11486, 0, 272021, 40.63, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(11492, 0, 272020, 26.53, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(11501, 0, 272022, 44.83, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(249228, 0, 272973, 3.53, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15'),
(249247, 0, 272973, 1.42, 1, 1, 0, 1, 1, 'Wowhead 2026-11-15');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_15_900_world_everlake_forge_00027_import.sql', 'Forge #27: Wowhead 2026-11-15' FROM `everlake_forge_stage` s;

-- npc_vendor: 4 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `npc_vendor` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES
(5398, 0, 254840, 0, 0, 0, 1, NULL, 0, 0, 70938),
(10856, 0, 12844, 0, 0, 0, 1, NULL, 0, 0, 70938),
(10857, 0, 12844, 0, 0, 0, 1, NULL, 0, 0, 70938),
(11536, 0, 12844, 0, 0, 0, 1, NULL, 0, 0, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `npc_vendor` x ON x.`entry` <=> s.`entry` AND x.`item` <=> s.`item` AND x.`ExtendedCost` <=> s.`ExtendedCost` AND x.`type` <=> s.`type`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`entry`);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'npc_vendor', s.`entry`, s.`item`, s.`ExtendedCost`, s.`type`, '2026_11_15_900_world_everlake_forge_00027_import.sql', 'Forge #27: Wowhead 2026-11-15' FROM `everlake_forge_stage` s;

-- flags and empty columns the operation set (only where still unset)
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` = 5398 AND (`npcflag` & 128) <> 128;
UPDATE `creature_template_difficulty` SET `LootID` = 249228 WHERE `Entry` = 249228 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');
UPDATE `creature_template_difficulty` SET `LootID` = 249247 WHERE `Entry` = 249247 AND `DifficultyID` = 0 AND (`LootID` IS NULL OR `LootID` = 0 OR `LootID` = '');

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
