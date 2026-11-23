-- Everlake Forge #275: Import, 1 resource(s), 1 row(s)
-- 2026_11_23_900_world_everlake_forge_00275_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 71037) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Wowhead 2026-11-21 (NOTICE.md, Forge exports).
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
-- values a source measured again: each statement names the value it replaces, so it changes nothing where the
-- row moved on, and nothing more when it runs again
UPDATE `creature_loot_template` SET `Chance` = 38.41 WHERE `Entry` = 10081 AND `ItemType` = 0 AND `Item` = 12471 AND ABS(`Chance` - 53.66) < 0.005 /* refresh */;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
