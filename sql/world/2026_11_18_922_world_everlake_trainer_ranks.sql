-- Class trainers: the higher ranks of Holy Shield, Death Mark and Shank that live WoW Forever's trainers teach.
-- 2026_11_18_922_world_everlake_trainer_ranks.sql: written by hand.
--
-- Wowhead's Forever pages list these ranks as "Taught by" the class trainers, with a level and a training cost; the
-- realm teaches the rank before each of them but not the rank itself, so no player can learn them (the Everlake tracker's
-- work list, 2026-11-18). The Forge's own trainer rows for them (2026-11-09) went with the PTR world rebuild of 2026-11-13.
--
--   spell     name                rank  level  cost (copper)  required rank            taught where the realm already teaches
--   1239570   Holy Shield         4     60     30526          Holy Shield 3 (20928)    Holy Shield 3 (20928): the paladin trainers
--   1325756   Death Mark          2     48     45263          Death Mark 1 (1316709)   Sinister Strike 2 (1757): the rogue trainers
--   1325757   Death Mark          3     56     50526          Death Mark 2 (1325756)   Sinister Strike 2 (1757)
--   1325758   Death Mark          4     60     53684          Death Mark 3 (1325757)   Sinister Strike 2 (1757)
--   1329549   Shank               2     44     24210          Shank 1 (1329283)        Sinister Strike 2 (1757)
--
-- The required rank is the client's SkillLineAbility.SupercedesSpell, except Holy Shield 4, where the client names none:
-- Holy Shield 3 is required, as Holy Shield's earlier ranks require theirs, so only paladins who took the talent can buy it.
-- Holy Shield 1 and Death Mark 1 come from the talent or perk trees, never from a trainer.
-- Sources: Wowhead's Forever pages spell=1239570, 1325756, 1325757, 1325758, 1329549 (taught by, Requires level, Training
-- cost), read 2026-11-18; the official client 1.60.1.70959 (SkillLineAbility: skill lines 267, 39, 38 and earlier ranks).
-- Nothing is added where the realm already has the row, or where this file added it before. Each added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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

SET @EVERLAKE_FILE := '2026_11_18_922_world_everlake_trainer_ranks.sql';
SET @EVERLAKE_NOTE := 'Wowhead Forever spell taught-by + training cost 2026-11-18; client 70959 SkillLineAbility';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_trainer_ranks`;
CREATE TEMPORARY TABLE `everlake_trainer_ranks` (
  `SpellId` int NOT NULL, `MoneyCost` int NOT NULL, `ReqAbility1` int NOT NULL, `ReqLevel` tinyint unsigned NOT NULL,
  `TaughtWith` int NOT NULL COMMENT 'a spell the realm teaches at the same trainers',
  PRIMARY KEY (`SpellId`)
);
INSERT INTO `everlake_trainer_ranks` (`SpellId`, `MoneyCost`, `ReqAbility1`, `ReqLevel`, `TaughtWith`) VALUES
(1239570, 30526, 20928, 60, 20928),
(1325756, 45263, 1316709, 48, 1757),
(1325757, 50526, 1325756, 56, 1757),
(1325758, 53684, 1325757, 60, 1757),
(1329549, 24210, 1329283, 44, 1757);

DROP TEMPORARY TABLE IF EXISTS `everlake_trainer_ranks_add`;
CREATE TEMPORARY TABLE `everlake_trainer_ranks_add`
SELECT DISTINCT t.`TrainerId`, r.`SpellId`, r.`MoneyCost`, r.`ReqAbility1`, r.`ReqLevel`
FROM `everlake_trainer_ranks` r
JOIN `trainer_spell` t ON t.`SpellId` = r.`TaughtWith`
WHERE NOT EXISTS (SELECT 1 FROM `trainer_spell` x WHERE x.`TrainerId` = t.`TrainerId` AND x.`SpellId` = r.`SpellId`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` i WHERE i.`tbl` = 'trainer_spell' AND i.`k1` = t.`TrainerId` AND i.`k2` = r.`SpellId`);

INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`)
SELECT `TrainerId`, `SpellId`, `MoneyCost`, 0, 0, `ReqAbility1`, 0, 0, `ReqLevel`, 0 FROM `everlake_trainer_ranks_add`;

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'trainer_spell', `TrainerId`, `SpellId`, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `everlake_trainer_ranks_add`;

DROP TEMPORARY TABLE `everlake_trainer_ranks_add`;
DROP TEMPORARY TABLE `everlake_trainer_ranks`;

COMMIT;
