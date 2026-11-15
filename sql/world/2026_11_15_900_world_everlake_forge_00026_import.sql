-- Everlake Forge #26: Import, 1 resource(s), 16 row(s)
-- 2026_11_15_900_world_everlake_forge_00026_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70938) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Classic database 2026-11-14 (NOTICE.md, Forge exports).
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
-- trainer_spell: 7 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild` FROM `trainer_spell` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) VALUES
(1008696, 13028, 0, 185, 175, 0, 0, 0, 0, 70938),
(1012920, 10841, 100000, 129, 240, 0, 0, 0, 0, 70938),
(1012920, 18629, 125000, 129, 260, 0, 0, 0, 35, 70938),
(1012920, 18630, 150000, 129, 290, 0, 0, 0, 35, 70938),
(1012939, 10841, 100000, 129, 240, 0, 0, 0, 0, 70938),
(1012939, 18629, 125000, 129, 260, 0, 0, 0, 35, 70938),
(1012939, 18630, 150000, 129, 290, 0, 0, 0, 35, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `trainer_spell` x ON x.`TrainerId` <=> s.`TrainerId` AND x.`SpellId` <=> s.`SpellId`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `trainer` p WHERE p.`Id` = `everlake_forge_stage`.`TrainerId`);
INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`) SELECT `TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'trainer_spell', s.`TrainerId`, s.`SpellId`, 0, 0, '2026_11_15_900_world_everlake_forge_00026_import.sql', 'Forge #26: Classic database 2026-11-14' FROM `everlake_forge_stage` s;

-- creature_trainer: 3 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `CreatureID`, `TrainerID`, `MenuID`, `OptionID` FROM `creature_trainer` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`CreatureID`, `TrainerID`, `MenuID`, `OptionID`) VALUES
(8696, 1008696, 0, 0),
(12920, 1012920, 0, 0),
(12939, 1012939, 0, 0);
DELETE s FROM `everlake_forge_stage` s JOIN `creature_trainer` x ON x.`CreatureID` <=> s.`CreatureID` AND x.`MenuID` <=> s.`MenuID` AND x.`OptionID` <=> s.`OptionID`;
INSERT INTO `creature_trainer` (`CreatureID`, `TrainerID`, `MenuID`, `OptionID`) SELECT `CreatureID`, `TrainerID`, `MenuID`, `OptionID` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_trainer', s.`CreatureID`, s.`MenuID`, s.`OptionID`, 0, '2026_11_15_900_world_everlake_forge_00026_import.sql', 'Forge #26: Classic database 2026-11-14' FROM `everlake_forge_stage` s;

-- trainer: 3 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Id`, `Type`, `Greeting`, `VerifiedBuild` FROM `trainer` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Id`, `Type`, `Greeting`, `VerifiedBuild`) VALUES
(1008696, 2, '', 70938),
(1012920, 2, '', 70938),
(1012939, 2, '', 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `trainer` x ON x.`Id` <=> s.`Id`;
INSERT INTO `trainer` (`Id`, `Type`, `Greeting`, `VerifiedBuild`) SELECT `Id`, `Type`, `Greeting`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'trainer', s.`Id`, 0, 0, 0, '2026_11_15_900_world_everlake_forge_00026_import.sql', 'Forge #26: Classic database 2026-11-14' FROM `everlake_forge_stage` s;

-- flags and empty columns the operation set (only where still unset)
UPDATE `creature_template` SET `npcflag` = `npcflag` | 80 WHERE `entry` = 8696 AND (`npcflag` & 80) <> 80;
UPDATE `creature_template` SET `npcflag` = `npcflag` | 80 WHERE `entry` = 12920 AND (`npcflag` & 80) <> 80;
UPDATE `creature_template` SET `npcflag` = `npcflag` | 80 WHERE `entry` = 12939 AND (`npcflag` & 80) <> 80;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
