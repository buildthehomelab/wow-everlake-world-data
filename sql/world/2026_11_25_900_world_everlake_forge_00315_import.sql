-- Everlake Forge #315: Import, 1 resource(s), 8 row(s)
-- 2026_11_25_900_world_everlake_forge_00315_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 71091) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Wowhead 2026-11-25 (NOTICE.md, Forge exports).
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
-- fishing_loot_template: 7 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `fishing_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(616, 0, 3371, 0.01, 1, 1, 1, 1, 1, 'Wowhead 2026-11-25'),
(616, 0, 3860, 0.02, 1, 1, 1, 1, 1, 'Wowhead 2026-11-25'),
(616, 0, 4235, 0.02, 0, 1, 1, 1, 1, 'Wowhead 2026-11-25'),
(616, 0, 6370, 0.01, 0, 1, 1, 1, 1, 'Wowhead 2026-11-25'),
(616, 0, 8839, 0.03, 0, 1, 1, 1, 1, 'Wowhead 2026-11-25'),
(616, 0, 13904, 0.02, 0, 1, 1, 1, 1, 'Wowhead 2026-11-25'),
(616, 0, 13905, 0.02, 0, 1, 1, 1, 1, 'Wowhead 2026-11-25');
DELETE s FROM `everlake_forge_stage` s JOIN `fishing_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `fishing_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'fishing_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_25_900_world_everlake_forge_00315_import.sql', 'Forge #315: Wowhead 2026-11-25' FROM `everlake_forge_stage` s;

-- values a source measured again: each statement names the value it replaces, so it changes nothing where the
-- row moved on, and nothing more when it runs again
UPDATE `creature_loot_template` SET `Chance` = 18.95 WHERE `Entry` = 10584 AND `ItemType` = 0 AND `Item` = 18784 AND ABS(`Chance` - 17.01) < 0.005 /* refresh */;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
