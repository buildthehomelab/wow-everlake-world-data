-- Everlake Forge #19: Import, 1 resource(s), 33 row(s)
-- 2026_11_14_900_world_everlake_forge_00019_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70862) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Icy Veins 2026-11-14 (what its players recorded on live Forever: vendor windows and chest loot, with its measured chances) (NOTICE.md, Forge exports).
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
-- gameobject_loot_template: 19 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `gameobject_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1417, 0, 268416, 1.16, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1418, 0, 268416, 1.24, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1419, 0, 268416, 1.14, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1420, 0, 268416, 1.04, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1421, 0, 268416, 2.38, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1423, 0, 268417, 0.45, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1424, 0, 268416, 1.28, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1730, 0, 268417, 1.11, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1731, 0, 268417, 1.2, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1733, 0, 268416, 0.84, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(1734, 0, 268418, 1.18, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(6142, 0, 268418, 1.61, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(6152, 0, 268418, 1.37, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(137445, 0, 260927, 24.75, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(137455, 0, 260927, 24.82, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(137456, 0, 260927, 24.58, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(139192, 0, 252023, 18.59, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(140476, 0, 271629, 68.59, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14'),
(142369, 0, 278029, 100, 0, 1, 0, 1, 1, 'Icy Veins 2026-11-14');
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_14_900_world_everlake_forge_00019_import.sql', 'Forge #19: Icy Veins 2026-11-14' FROM `everlake_forge_stage` s;

-- npc_vendor: 13 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `npc_vendor` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES
(12792, 0, 274226, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 274231, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 274246, 0, 0, 0, 1, NULL, 0, 0, 70862),
(12792, 0, 274258, 0, 0, 0, 1, NULL, 0, 0, 70862),
(30885, 0, 272743, 0, 0, 0, 1, NULL, 0, 0, 70862),
(30885, 0, 272854, 0, 0, 0, 1, NULL, 0, 0, 70862),
(255705, 0, 260629, 0, 0, 0, 1, NULL, 0, 0, 70862),
(255705, 0, 260632, 0, 0, 0, 1, NULL, 0, 0, 70862),
(255705, 0, 260633, 0, 0, 0, 1, NULL, 0, 0, 70862),
(265346, 0, 274616, 0, 0, 0, 1, NULL, 0, 0, 70862),
(265347, 0, 278118, 0, 0, 0, 1, NULL, 0, 0, 70862),
(265347, 0, 278120, 0, 0, 0, 1, NULL, 0, 0, 70862),
(265347, 0, 278122, 0, 0, 0, 1, NULL, 0, 0, 70862);
DELETE s FROM `everlake_forge_stage` s JOIN `npc_vendor` x ON x.`entry` <=> s.`entry` AND x.`item` <=> s.`item` AND x.`ExtendedCost` <=> s.`ExtendedCost` AND x.`type` <=> s.`type`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`entry`);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'npc_vendor', s.`entry`, s.`item`, s.`ExtendedCost`, s.`type`, '2026_11_14_900_world_everlake_forge_00019_import.sql', 'Forge #19: Icy Veins 2026-11-14' FROM `everlake_forge_stage` s;

-- flags and empty columns the operation set (only where still unset)
UPDATE `creature_template` SET `npcflag` = `npcflag` | 128 WHERE `entry` = 255705 AND (`npcflag` & 128) <> 128;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
