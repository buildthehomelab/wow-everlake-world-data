-- Everlake Forge #4: Instances, 23 resource(s), 4 row(s)
-- 2026_11_09_900_world_everlake_forge_00004_instance.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70862) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: the official client's Map table, the fork's instance script (NOTICE.md, Forge exports).
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
-- instance_template: 4 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `map`, `parent`, `script` FROM `instance_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`map`, `parent`, `script`) VALUES
(2959, 0, 'classic_instance_city_of_dalaran'),
(2970, 0, 'classic_instance_the_drowned_city'),
(2998, 0, 'classic_instance_excavation_site_wetlands'),
(3039, 0, 'classic_instance_kroldok_stronghold');
DELETE s FROM `everlake_forge_stage` s JOIN `instance_template` x ON x.`map` <=> s.`map`;
INSERT INTO `instance_template` (`map`, `parent`, `script`) SELECT `map`, `parent`, `script` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'instance_template', s.`map`, 0, 0, 0, '2026_11_09_900_world_everlake_forge_00004_instance.sql', 'Forge #4 (instance): the official client''s Map table, the fork''s instance script' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
