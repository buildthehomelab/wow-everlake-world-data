-- Everlake Forge #44: Import, 1 resource(s), 265 row(s)
-- Applied on the test realm as the tracker's Forge operation #169; numbered 44 here, the next free number of this repository.
-- 2026_11_18_900_world_everlake_forge_00044_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
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
-- item_loot_template: 3 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `item_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(21975, 0, 22143, 47.92, 1, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(22155, 0, 22140, 46.67, 1, 1, 0, 1, 1, 'Wowhead 2026-11-18'),
(22157, 0, 22145, 46.11, 1, 1, 0, 1, 1, 'Wowhead 2026-11-18');
DELETE s FROM `everlake_forge_stage` s JOIN `item_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'item_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_18_900_world_everlake_forge_00044_import.sql', 'Forge #44: Wowhead 2026-11-18' FROM `everlake_forge_stage` s;

-- npc_vendor: 232 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `npc_vendor` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES
(12777, 0, 272657, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12777, 0, 272670, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12777, 0, 272671, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12777, 0, 272677, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12777, 0, 272678, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12777, 0, 272700, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12777, 0, 272701, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12777, 0, 272702, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12777, 0, 272703, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12777, 0, 272705, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12777, 0, 272711, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12777, 0, 272712, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12777, 0, 272713, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12777, 0, 272715, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12777, 0, 272718, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12777, 0, 272719, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12777, 0, 272720, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12777, 0, 272721, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12777, 0, 272722, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12777, 0, 272723, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12777, 0, 272724, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12777, 0, 272725, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12777, 0, 272730, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12777, 0, 272732, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12777, 0, 272734, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12777, 0, 272735, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12777, 0, 272736, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12777, 0, 272737, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12777, 0, 272742, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12777, 0, 272744, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12777, 0, 272745, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12777, 0, 272794, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12777, 0, 272795, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12777, 0, 272796, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12777, 0, 272797, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12777, 0, 272800, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12777, 0, 272801, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12777, 0, 272810, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12777, 0, 272811, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12777, 0, 272812, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12777, 0, 272813, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12777, 0, 272814, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12777, 0, 272815, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12777, 0, 272816, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12777, 0, 272817, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12777, 0, 272830, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12777, 0, 272852, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12777, 0, 272853, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12777, 0, 272855, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12777, 0, 273363, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12777, 0, 273364, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12777, 0, 273365, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12777, 0, 273366, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12777, 0, 273369, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12777, 0, 273370, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12777, 0, 273371, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12777, 0, 273375, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12777, 0, 273378, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12777, 0, 273379, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12777, 0, 273380, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12777, 0, 273443, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12777, 0, 273444, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12777, 0, 273445, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12777, 0, 273447, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12777, 0, 273448, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12777, 0, 273449, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 272453, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 272454, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 272455, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 272456, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 272457, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 272458, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 272459, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 272461, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 272462, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 272463, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 272464, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 272469, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 272470, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 272471, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 272472, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 272483, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 272484, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 272485, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 272486, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 272487, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 272488, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 272489, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 272490, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 272491, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 272492, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 272494, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 272495, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 272496, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 272497, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 272548, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 272549, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 272550, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 272551, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 272552, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 272553, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 272562, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 272563, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 272564, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 272565, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 272566, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 272567, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 272568, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 272569, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 272582, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 272606, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 272609, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 272611, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 272614, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 272617, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 272619, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 272625, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 272626, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 272627, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 272630, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 272634, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 272636, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 272640, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 272641, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 272642, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 272643, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 272647, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 272648, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 272649, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 272650, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 272663, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 272680, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 273352, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 273353, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 273355, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 273356, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 273357, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 273358, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 273359, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 273360, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 273361, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 273362, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 273367, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 273372, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 273381, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 273382, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 273383, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(12792, 0, 273384, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 273385, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 273386, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(12792, 0, 273387, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 273388, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 273450, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 274227, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 274228, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 274229, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 274230, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 274232, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 274233, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 274244, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(12792, 0, 274245, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(12792, 0, 274247, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(12792, 0, 274256, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(12792, 0, 274257, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(12792, 0, 274259, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(12792, 0, 275437, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(30885, 0, 272657, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(30885, 0, 272670, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(30885, 0, 272671, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(30885, 0, 272677, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(30885, 0, 272678, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(30885, 0, 272700, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(30885, 0, 272701, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(30885, 0, 272702, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(30885, 0, 272703, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(30885, 0, 272705, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(30885, 0, 272711, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(30885, 0, 272712, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(30885, 0, 272713, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(30885, 0, 272715, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(30885, 0, 272718, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(30885, 0, 272719, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(30885, 0, 272720, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(30885, 0, 272721, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(30885, 0, 272722, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(30885, 0, 272723, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(30885, 0, 272724, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(30885, 0, 272725, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(30885, 0, 272730, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(30885, 0, 272732, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(30885, 0, 272734, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(30885, 0, 272735, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(30885, 0, 272736, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(30885, 0, 272737, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(30885, 0, 272742, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(30885, 0, 272744, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(30885, 0, 272745, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(30885, 0, 272794, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(30885, 0, 272795, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(30885, 0, 272796, 0, 0, 11580, 1, NULL, 0, 0, 70959);
INSERT INTO `everlake_forge_stage` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES
(30885, 0, 272797, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(30885, 0, 272800, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(30885, 0, 272801, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(30885, 0, 272810, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(30885, 0, 272811, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(30885, 0, 272812, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(30885, 0, 272813, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(30885, 0, 272814, 0, 0, 11575, 1, NULL, 0, 0, 70959),
(30885, 0, 272815, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(30885, 0, 272816, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(30885, 0, 272817, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(30885, 0, 272830, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(30885, 0, 272852, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(30885, 0, 272853, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(30885, 0, 272855, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(30885, 0, 273363, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(30885, 0, 273364, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(30885, 0, 273365, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(30885, 0, 273366, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(30885, 0, 273369, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(30885, 0, 273370, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(30885, 0, 273371, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(30885, 0, 273375, 0, 0, 11576, 1, NULL, 0, 0, 70959),
(30885, 0, 273378, 0, 0, 11581, 1, NULL, 0, 0, 70959),
(30885, 0, 273379, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(30885, 0, 273380, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(30885, 0, 273443, 0, 0, 11583, 1, NULL, 0, 0, 70959),
(30885, 0, 273444, 0, 0, 11579, 1, NULL, 0, 0, 70959),
(30885, 0, 273445, 0, 0, 11580, 1, NULL, 0, 0, 70959),
(30885, 0, 273447, 0, 0, 11582, 1, NULL, 0, 0, 70959),
(30885, 0, 273448, 0, 0, 11578, 1, NULL, 0, 0, 70959),
(30885, 0, 273449, 0, 0, 11581, 1, NULL, 0, 0, 70959);
DELETE s FROM `everlake_forge_stage` s JOIN `npc_vendor` x ON x.`entry` <=> s.`entry` AND x.`item` <=> s.`item` AND x.`ExtendedCost` <=> s.`ExtendedCost` AND x.`type` <=> s.`type`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`entry`);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'npc_vendor', s.`entry`, s.`item`, s.`ExtendedCost`, s.`type`, '2026_11_18_900_world_everlake_forge_00044_import.sql', 'Forge #44: Wowhead 2026-11-18' FROM `everlake_forge_stage` s;

-- flags and empty columns the operation set (only where still unset)
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94004 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94212 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94213 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94214 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94215 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94216 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94217 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94231 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94233 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94235 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94241 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94247 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94248 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94249 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardItem1` = 284584 WHERE `ID` = 94255 AND (`RewardItem1` IS NULL OR `RewardItem1` = 0 OR `RewardItem1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94004 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94212 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94213 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94214 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94215 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94216 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94217 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94231 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94233 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94235 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94241 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94247 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94248 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94249 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');
UPDATE `quest_template` SET `RewardAmount1` = 1 WHERE `ID` = 94255 AND (`RewardAmount1` IS NULL OR `RewardAmount1` = 0 OR `RewardAmount1` = '');

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
