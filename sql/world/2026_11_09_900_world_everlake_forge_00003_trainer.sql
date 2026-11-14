-- Everlake Forge #3: Trainers, 100 resource(s), 24 row(s)
-- 2026_11_09_900_world_everlake_forge_00003_trainer.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70862) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: higher ranks the official client lists for the class, each needing the rank before it, priced by level like the trainer's other ranks (NOTICE.md, Forge exports).
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
-- trainer_spell: 24 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild` FROM `trainer_spell` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(8, 1277325, 6000, 0, 0, 1277324, 0, 0, 30, 0),
(8, 1277328, 29000, 0, 0, 1277327, 0, 0, 60, 0),
(1005994, 1277325, 150, 0, 0, 1277324, 0, 0, 30, 0),
(1005994, 1277328, 1500, 0, 0, 1277327, 0, 0, 60, 0),
(8, 1277326, 13000, 0, 0, 1277325, 0, 0, 40, 0),
(8, 1277327, 20000, 0, 0, 1277326, 0, 0, 50, 0),
(8, 1277332, 6000, 0, 0, 1277331, 0, 0, 30, 0),
(8, 1277333, 13000, 0, 0, 1277332, 0, 0, 40, 0),
(8, 1277334, 20000, 0, 0, 1277333, 0, 0, 50, 0),
(8, 1277335, 29000, 0, 0, 1277334, 0, 0, 60, 0),
(8, 1277634, 6000, 0, 0, 1277462, 0, 0, 30, 0),
(8, 1277638, 13000, 0, 0, 1277634, 0, 0, 40, 0),
(8, 1277639, 20000, 0, 0, 1277638, 0, 0, 50, 0),
(8, 1277640, 29000, 0, 0, 1277639, 0, 0, 60, 0),
(1005994, 1277326, 500, 0, 0, 1277325, 0, 0, 40, 0),
(1005994, 1277327, 900, 0, 0, 1277326, 0, 0, 50, 0),
(1005994, 1277332, 150, 0, 0, 1277331, 0, 0, 30, 0),
(1005994, 1277333, 500, 0, 0, 1277332, 0, 0, 40, 0),
(1005994, 1277334, 900, 0, 0, 1277333, 0, 0, 50, 0),
(1005994, 1277335, 1500, 0, 0, 1277334, 0, 0, 60, 0),
(1005994, 1277634, 150, 0, 0, 1277462, 0, 0, 30, 0),
(1005994, 1277638, 500, 0, 0, 1277634, 0, 0, 40, 0),
(1005994, 1277639, 900, 0, 0, 1277638, 0, 0, 50, 0),
(1005994, 1277640, 1500, 0, 0, 1277639, 0, 0, 60, 0);
DELETE s FROM `everlake_forge_stage` s JOIN `trainer_spell` x ON x.`TrainerId` <=> s.`TrainerId` AND x.`SpellId` <=> s.`SpellId`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `trainer` p WHERE p.`Id` = `everlake_forge_stage`.`TrainerId`);
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) SELECT `TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'trainer_spell', s.`TrainerId`, s.`SpellId`, 0, 0, '2026_11_09_900_world_everlake_forge_00003_trainer.sql', 'Forge #3 (trainer): higher ranks the official client lists for the class, each needing the rank before it, priced by level like the trainer''s other ranks' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
