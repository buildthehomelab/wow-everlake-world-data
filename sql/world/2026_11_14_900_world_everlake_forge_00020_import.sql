-- Everlake Forge #20: Import, 1 resource(s), 4 row(s)
-- 2026_11_14_900_world_everlake_forge_00020_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70862) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Wowhead's WoW Forever database, read 2026-11-14: the NPC a quest's summary sends the player back to, where exactly one spawned creature has that name (NOTICE.md, Forge exports).
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
-- creature_questender: 4 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `id`, `quest`, `VerifiedBuild` FROM `creature_questender` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`id`, `quest`, `VerifiedBuild`) VALUES
(4606, 5659, 70862),
(11216, 5383, 70862),
(14733, 8290, 70862),
(14781, 8295, 70862);
DELETE s FROM `everlake_forge_stage` s JOIN `creature_questender` x ON x.`id` <=> s.`id` AND x.`quest` <=> s.`quest`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`id`);
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT `id`, `quest`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_questender', s.`id`, s.`quest`, 0, 0, '2026_11_14_900_world_everlake_forge_00020_import.sql', 'Forge #20: Wowhead Forever quest summary 2026-11-14' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
