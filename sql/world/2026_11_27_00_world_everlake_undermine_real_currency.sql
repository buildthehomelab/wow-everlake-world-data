-- 2026_11_27_00_world_everlake_undermine_real_currency.sql: the Tarnished Undermine Real drops as WoW Forever's currency 3469, not as the item 226404.
-- Forever made the Season of Discovery coin a currency: the client's ItemExtendedCost rows Pix Xizzix (227853) sells for
-- (9077-9881) ask CurrencyTypes 3469, and Show Me the Money! (83934) is an obtain-currency objective on 3469. Nothing turns
-- the item into the currency, so a looted coin bought nothing. The drops (bosses and chests, chances from Wowhead Classic
-- and QuestieDB, NOTICE.md) were on the test realm as item rows from a ForeverTracker import (2026-11-17) and in no file
-- here: this file adds them as currency rows (ItemType 2; the core gives a currency drop to everyone who loots) and
-- removes the item rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing: a row is added only
-- where none exists, and each added row is recorded in everlake_import_rows.

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
-- creature_loot_template: 104 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1853, 2, 3469, 55.51, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(6109, 2, 3469, 1.21, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(8983, 2, 3469, 59.28, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9016, 2, 3469, 59.34, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9017, 2, 3469, 51.89, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9019, 2, 3469, 48.42, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9033, 2, 3469, 58.75, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9056, 2, 3469, 59.79, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9156, 2, 3469, 58.3, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9196, 2, 3469, 42.04, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9236, 2, 3469, 50.75, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9237, 2, 3469, 48.04, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9502, 2, 3469, 60.37, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9537, 2, 3469, 61.34, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9568, 2, 3469, 52.72, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9816, 2, 3469, 43.61, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(9938, 2, 3469, 44.89, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10184, 2, 3469, 4.24, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10220, 2, 3469, 54.14, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10268, 2, 3469, 53.12, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10363, 2, 3469, 49.97, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10429, 2, 3469, 46.95, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10430, 2, 3469, 47.05, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10432, 2, 3469, 62.73, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10433, 2, 3469, 63.28, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10435, 2, 3469, 44.7, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10436, 2, 3469, 53.08, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10437, 2, 3469, 49.91, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10438, 2, 3469, 52.57, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10439, 2, 3469, 51.98, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10440, 2, 3469, 51.84, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10502, 2, 3469, 54.59, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10503, 2, 3469, 59.39, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10504, 2, 3469, 54.89, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10505, 2, 3469, 54.86, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10506, 2, 3469, 55.74, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10507, 2, 3469, 53.11, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10508, 2, 3469, 51.87, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10516, 2, 3469, 56.93, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10584, 2, 3469, 53.38, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10596, 2, 3469, 57.16, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10808, 2, 3469, 57.67, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10811, 2, 3469, 59.55, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10813, 2, 3469, 58.52, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10901, 2, 3469, 56.68, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(10997, 2, 3469, 58.55, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11032, 2, 3469, 95.29, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11058, 2, 3469, 65.36, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11143, 2, 3469, 66.4, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11261, 2, 3469, 53.99, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11380, 2, 3469, 71.63, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11382, 2, 3469, 70.91, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11486, 2, 3469, 62.08, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11487, 2, 3469, 63.08, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11488, 2, 3469, 65.01, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11489, 2, 3469, 64.99, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11490, 2, 3469, 52.47, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11492, 2, 3469, 55.28, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11496, 2, 3469, 60.46, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11501, 2, 3469, 51.98, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11583, 2, 3469, 75.08, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11622, 2, 3469, 55.62, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11981, 2, 3469, 84.85, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(11983, 2, 3469, 85.87, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(12017, 2, 3469, 80.66, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(12435, 2, 3469, 81.84, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(13020, 2, 3469, 82.39, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(13280, 2, 3469, 52.14, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14020, 2, 3469, 77.77, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14327, 2, 3469, 60.6, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14354, 2, 3469, 64.75, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14507, 2, 3469, 73.94, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14509, 2, 3469, 74.72, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14510, 2, 3469, 72.31, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14515, 2, 3469, 68.79, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14517, 2, 3469, 73.26, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14601, 2, 3469, 83.81, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14684, 2, 3469, 42.46, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14690, 2, 3469, 48.15, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14695, 2, 3469, 61.59, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(14834, 2, 3469, 71.8, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15082, 2, 3469, 76.63, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15083, 2, 3469, 82.96, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15084, 2, 3469, 82.12, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15085, 2, 3469, 79.17, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15114, 2, 3469, 67.61, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15263, 2, 3469, 6.06, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15275, 2, 3469, 8.01, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15276, 2, 3469, 9.57, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15299, 2, 3469, 6.41, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15339, 2, 3469, 6.71, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15340, 2, 3469, 5.69, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15341, 2, 3469, 5.86, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15348, 2, 3469, 6.23, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15369, 2, 3469, 6.54, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15370, 2, 3469, 7.24, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15509, 2, 3469, 7.79, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15510, 2, 3469, 7.16, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15511, 2, 3469, 12.28, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15516, 2, 3469, 7.57, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15517, 2, 3469, 4.02, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15543, 2, 3469, 23.08, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15544, 2, 3469, 8.09, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17'),
(15727, 2, 3469, 36.59, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_27_00_world_everlake_undermine_real_currency.sql', CONCAT(s.`Comment`, ': Tarnished Undermine Real as currency 3469') FROM `everlake_forge_stage` s;
-- the item rows: the Undermine Real is no item drop on Forever
DELETE FROM `creature_loot_template` WHERE `ItemType` = 0 AND `Item` = 226404;
DELETE FROM `everlake_import_rows` WHERE `tbl` = 'creature_loot_template' AND `k2` = 0 AND `k3` = 226404;

-- gameobject_loot_template: 2 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `gameobject_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(13645, 2, 3469, 95.29, 0, 1, 0, 1, 1, 'QuestieDB v1.1.2'),
(16719, 2, 3469, 84.17, 0, 1, 0, 1, 1, 'Wowhead Classic 2026-11-17');
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_27_00_world_everlake_undermine_real_currency.sql', CONCAT(s.`Comment`, ': Tarnished Undermine Real as currency 3469') FROM `everlake_forge_stage` s;
-- the item rows: the Undermine Real is no item drop on Forever
DELETE FROM `gameobject_loot_template` WHERE `ItemType` = 0 AND `Item` = 226404;
DELETE FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_loot_template' AND `k2` = 0 AND `k3` = 226404;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
