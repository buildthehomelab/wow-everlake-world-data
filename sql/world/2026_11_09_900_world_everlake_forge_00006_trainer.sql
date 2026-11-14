-- Everlake Forge #6: Trainers, 100 resource(s), 14 row(s)
-- 2026_11_09_900_world_everlake_forge_00006_trainer.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70862) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: the official client's skill line, price from the trainer's neighbours (NOTICE.md, Forge exports).
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
-- trainer_spell: 14 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild` FROM `trainer_spell` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(1011017, 1249634, 500, 202, 120, 0, 0, 0, 0, 0),
(1002391, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0),
(1002837, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0),
(1003009, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0),
(1003347, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0),
(1003964, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0),
(1004160, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0),
(1004609, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0),
(1004611, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0),
(1005174, 1249634, 500, 202, 120, 0, 0, 0, 0, 0),
(1005177, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0),
(1005499, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0),
(1008736, 1249634, 500, 202, 120, 0, 0, 0, 0, 0),
(1011042, 1249631, 1500, 171, 120, 0, 0, 0, 0, 0);
DELETE s FROM `everlake_forge_stage` s JOIN `trainer_spell` x ON x.`TrainerId` <=> s.`TrainerId` AND x.`SpellId` <=> s.`SpellId`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `trainer` p WHERE p.`Id` = `everlake_forge_stage`.`TrainerId`);
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) SELECT `TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'trainer_spell', s.`TrainerId`, s.`SpellId`, 0, 0, '2026_11_09_900_world_everlake_forge_00006_trainer.sql', 'Forge #6 (trainer): the official client''s skill line, price from the trainer''s neighbours' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
