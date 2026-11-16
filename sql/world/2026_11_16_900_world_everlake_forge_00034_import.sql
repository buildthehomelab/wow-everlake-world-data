-- Everlake Forge #34: Import, 1 resource(s), 24 row(s)
-- Applied on the test realm as the tracker's Forge operation #32; numbered 34 here, the next free number of this repository.
-- 2026_11_16_900_world_everlake_forge_00034_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
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
-- npc_vendor: 24 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `npc_vendor` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) VALUES
(12777, 0, 274176, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274177, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274178, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274179, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274180, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274181, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274182, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274192, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274193, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274194, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274195, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274196, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274197, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274214, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274215, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274217, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274218, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274219, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274220, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274221, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274222, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274223, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274224, 0, 0, 0, 1, NULL, 0, 0, 70938),
(12777, 0, 274225, 0, 0, 0, 1, NULL, 0, 0, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `npc_vendor` x ON x.`entry` <=> s.`entry` AND x.`item` <=> s.`item` AND x.`ExtendedCost` <=> s.`ExtendedCost` AND x.`type` <=> s.`type`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`entry`);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`) SELECT `entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'npc_vendor', s.`entry`, s.`item`, s.`ExtendedCost`, s.`type`, '2026_11_16_900_world_everlake_forge_00034_import.sql', 'Forge #34 (import)' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
