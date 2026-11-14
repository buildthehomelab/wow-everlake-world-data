-- Everlake Forge #18: Import, 1 resource(s), 8 row(s)
-- 2026_11_14_900_world_everlake_forge_00018_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70862) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: EG Link ea970da0 trainer windows (live Forever) (NOTICE.md, Forge exports).
-- A pet trainer's rank takes the rank it needs and its level from the official pet trainer list (trainer 273), as the
-- core's 2026_11_13_95_world_forever_pet_trainer_ranks.sql does for the ranks these trainers already sold: EG Link's
-- window shows level 10 for the first ranks of Great Stamina and Natural Armor, the official list asks for none.
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
-- trainer_spell: 8 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild` FROM `trainer_spell` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(10, 2645, 2300, 0, 0, 0, 0, 0, 20, 70862),
(1002878, 4187, 10, 0, 0, 0, 0, 0, 10, 70862),
(1002878, 23992, 440, 0, 0, 0, 0, 0, 20, 70862),
(1002878, 24446, 440, 0, 0, 0, 0, 0, 20, 70862),
(1002878, 24488, 440, 0, 0, 0, 0, 0, 20, 70862),
(1002878, 24492, 440, 0, 0, 0, 0, 0, 20, 70862),
(1002878, 24493, 440, 0, 0, 0, 0, 0, 20, 70862),
(1002878, 24545, 10, 0, 0, 0, 0, 0, 10, 70862);
UPDATE `everlake_forge_stage` s JOIN `trainer` t ON t.`Id` = s.`TrainerId` AND t.`Type` = 3 JOIN `trainer_spell` a ON a.`TrainerId` = 273 AND a.`SpellId` = s.`SpellId` SET s.`ReqAbility1` = a.`ReqAbility1`, s.`ReqLevel` = a.`ReqLevel` WHERE s.`TrainerId` BETWEEN 1000000 AND 1999999;
DELETE s FROM `everlake_forge_stage` s JOIN `trainer_spell` x ON x.`TrainerId` <=> s.`TrainerId` AND x.`SpellId` <=> s.`SpellId`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `trainer` p WHERE p.`Id` = `everlake_forge_stage`.`TrainerId`);
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) SELECT `TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'trainer_spell', s.`TrainerId`, s.`SpellId`, 0, 0, '2026_11_14_900_world_everlake_forge_00018_import.sql', 'Forge #18: EG Link ea970da0 trainer windows (live Forever)' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
