-- Trainers that teach a spell on live but not on the realm.
-- 2026_11_28_98_world_everlake_missing_trainer_spells.sql: written by hand, not tried in game (2026-11-28).
--
-- Checked: every spawned trainer (602) against Wowhead Forever's teaches tabs (abilities, recipes, other): 369 spells at
-- 63 trainers are missing. Added here, 115 spells on 28 trainer lists:
--   The apprentice spell of the profession, missing from six shared lists, so 28 trainers could not start anyone in
--   it: Cooking on list 36 (Gremlock Pilsnor in Ironforge and nine more cooks), Blacksmithing on 293 and 376, Alchemy on
--   353, Engineering on 361, Tailoring on 388, plus single trainers (Gelman Stonehand, Thuwd, Narv Hidecrafter, Charles
--   Worth and Melanori, Linzy Blackbolt, Patricia Egan). Every trainer on each list misses it on Wowhead, so the list is
--   the gap.
--   Pet trainers' Great Stamina, Natural Armor and resistance ranks (Nalesette Wildbringer 33, Grokor 15 and eight more).
--   Recipes at Lawrence Schneider (9), Tel'Athir (3), Sylvanna Forestmoon (4), Timothy Worthington (3) and Meilosh (10),
--   and Fahrad's 399956.
-- Each row copies cost, skill and level requirements from the realm's most common row for that spell on another list.
-- Left out:
--   Abilities Wowhead puts on profession trainers (priest spells at Victor Ward, mage spells at Lawrence Schneider,
--   warrior spells and Parry at Smith Argus) and Herb Gathering at Tel'Athir: other trainers' lists, not these.
--   Cat Form, Claw, Rip and Prowl on the druid list 17: no trainer on the realm teaches them, and only 3 of the 18 druid
--   trainers' Wowhead pages list them (the other 15 list everything else), so live may grant them another way.
--   Pet family skills (Growl, Claw, Bite and others at nine pet trainers) and the racial riding skills at Jartsam and
--   Xar'Ti: no realm list teaches them, so there is no row to copy.
--   Alard Schmied's list 813, which the tracker's own Alard fix covers; one pet skill on list 273 its other trainer has.
-- Rows only go in while the list does not teach the spell. Every added row is recorded in everlake_import_rows. Never
-- edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';
SET @EVERLAKE_FILE := '2026_11_28_98_world_everlake_missing_trainer_spells.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_tspell`;
CREATE TEMPORARY TABLE `everlake_tspell` (`trainer` INT UNSIGNED NOT NULL, `spell` INT NOT NULL, `cost` INT UNSIGNED NOT NULL,
  `skill` INT UNSIGNED NOT NULL, `rank` INT UNSIGNED NOT NULL, `a1` INT UNSIGNED NOT NULL, `a2` INT UNSIGNED NOT NULL,
  `a3` INT UNSIGNED NOT NULL, `lvl` TINYINT UNSIGNED NOT NULL, PRIMARY KEY (`trainer`, `spell`));
INSERT INTO `everlake_tspell` VALUES
(36,2550,100,0,0,0,0,0,0),
(273,4188,120,0,0,0,0,0,12),
(273,24549,120,0,0,0,0,0,12),
(293,2018,9,0,0,0,0,0,5),
(353,2259,10,0,0,0,0,0,5),
(361,4036,10,0,0,0,0,0,1),
(376,2018,9,0,0,0,0,0,5),
(388,3908,10,0,0,0,0,0,5),
(1000543,4188,120,0,0,0,0,0,12),
(1000543,4189,400,0,0,0,0,0,18),
(1000543,4190,1400,0,0,0,0,0,24),
(1000543,4191,1600,0,0,0,0,0,30),
(1000543,4192,2800,0,0,0,0,0,36),
(1000543,4193,4800,0,0,0,0,0,42),
(1000543,4194,6400,0,0,0,0,0,48),
(1000543,14917,440,0,0,0,0,0,20),
(1000543,14918,1600,0,0,0,0,0,30),
(1000543,14919,3600,0,0,0,0,0,40),
(1000543,14920,7200,0,0,0,0,0,50),
(1000543,24439,1600,0,0,0,0,0,30),
(1000543,24444,3600,0,0,0,0,0,40),
(1000543,24445,7200,0,0,0,0,0,50),
(1000543,24447,1600,0,0,0,0,0,30),
(1000543,24448,3600,0,0,0,0,0,40),
(1000543,24449,7200,0,0,0,0,0,50),
(1000543,24497,1600,0,0,0,0,0,30),
(1000543,24500,3600,0,0,0,0,0,40),
(1000543,24501,7200,0,0,0,0,0,50),
(1000543,24502,1600,0,0,0,0,0,30),
(1000543,24503,3600,0,0,0,0,0,40),
(1000543,24504,7200,0,0,0,0,0,50),
(1000543,24505,1600,0,0,0,0,0,30),
(1000543,24506,3600,0,0,0,0,0,40),
(1000543,24507,7200,0,0,0,0,0,50),
(1000543,24549,120,0,0,0,0,0,12),
(1000543,24550,400,0,0,0,0,0,18),
(1000543,24551,1400,0,0,0,0,0,24),
(1000543,24552,1600,0,0,0,0,0,30),
(1000543,24553,2800,0,0,0,0,0,36),
(1000543,24554,4800,0,0,0,0,0,42),
(1000543,24555,6400,0,0,0,0,0,48),
(1001300,3865,900,197,175,0,0,0,0),
(1001300,3909,450,197,50,0,0,0,10),
(1001300,3910,4500,197,125,0,0,0,20),
(1001300,8489,675,197,175,0,0,0,0),
(1001300,8762,675,197,160,0,0,0,0),
(1001300,8799,2700,197,195,0,0,0,0),
(1001300,12049,3600,197,205,0,0,0,0),
(1001300,12053,4500,197,215,0,0,0,0),
(1001300,12065,4500,197,225,0,0,0,0),
(1002879,4188,120,0,0,0,0,0,12),
(1002879,4189,400,0,0,0,0,0,18),
(1002879,24549,120,0,0,0,0,0,12),
(1002879,24550,400,0,0,0,0,0,18),
(1003545,4188,120,0,0,0,0,0,12),
(1003545,24549,120,0,0,0,0,0,12),
(1003622,4188,120,0,0,0,0,0,12),
(1003622,4189,400,0,0,0,0,0,18),
(1003622,4190,1400,0,0,0,0,0,24),
(1003622,4191,1600,0,0,0,0,0,30),
(1003622,14917,440,0,0,0,0,0,20),
(1003622,14918,1600,0,0,0,0,0,30),
(1003622,24439,1600,0,0,0,0,0,30),
(1003622,24447,1600,0,0,0,0,0,30),
(1003622,24497,1600,0,0,0,0,0,30),
(1003622,24502,1600,0,0,0,0,0,30),
(1003622,24505,1600,0,0,0,0,0,30),
(1003622,24549,120,0,0,0,0,0,12),
(1003622,24550,400,0,0,0,0,0,18),
(1003622,24551,1400,0,0,0,0,0,24),
(1003622,24552,1600,0,0,0,0,0,30),
(1003624,4188,120,0,0,0,0,0,12),
(1003624,4189,400,0,0,0,0,0,18),
(1003624,14917,440,0,0,0,0,0,20),
(1003624,24549,120,0,0,0,0,0,12),
(1003624,24550,400,0,0,0,0,0,18),
(1003698,4188,120,0,0,0,0,0,12),
(1003698,24549,120,0,0,0,0,0,12),
(1003698,24550,400,0,0,0,0,0,18),
(1004320,4188,120,0,0,0,0,0,12),
(1004320,4189,400,0,0,0,0,0,18),
(1004320,24549,120,0,0,0,0,0,12),
(1004320,24550,400,0,0,0,0,0,18),
(1005500,2368,500,182,50,0,0,0,10),
(1005500,3570,5000,182,125,0,0,0,20),
(1005500,11993,50000,182,200,0,0,0,35),
(1005513,2018,9,0,0,0,0,0,5),
(1006707,399956,10000,0,0,1310707,0,0,40),
(1007088,2108,10,0,0,0,0,0,5),
(1008153,2108,10,0,0,0,0,0,5),
(1010086,4188,120,0,0,0,0,0,12),
(1010086,24549,120,0,0,0,0,0,12),
(1010090,4188,120,0,0,0,0,0,12),
(1010090,14917,440,0,0,0,0,0,20),
(1010090,24549,120,0,0,0,0,0,12),
(1011042,3448,4500,171,165,0,0,0,0),
(1011042,3464,5000,171,125,0,0,0,20),
(1011042,11448,8100,171,205,0,0,0,0),
(1011042,11451,7200,171,205,0,0,0,0),
(1011052,1257368,526,197,35,0,0,0,0),
(1011052,1257369,526,197,35,0,0,0,0),
(1011052,1263425,100,197,20,0,0,0,0),
(1011557,1229504,100,197,20,0,0,0,0),
(1011557,1257368,526,197,35,0,0,0,0),
(1011557,1257369,526,197,35,0,0,0,0),
(1011557,1257426,1450,197,150,0,0,0,0),
(1011557,1257427,1450,197,150,0,0,0,0),
(1011557,1257428,1450,197,150,0,0,0,0),
(1011557,1257429,1450,197,150,0,0,0,0),
(1011557,1257430,1450,197,150,0,0,0,0),
(1011557,1257431,1450,197,150,0,0,0,0),
(1011557,1263425,100,197,20,0,0,0,0),
(1251972,3908,10,0,0,0,0,0,5),
(10246795,2259,10,0,0,0,0,0,5),
(10275322,2259,10,0,0,0,0,0,5);

-- only while the list does not teach the spell, and only onto lists that exist
DROP TEMPORARY TABLE IF EXISTS `everlake_tspell_ok`;
CREATE TEMPORARY TABLE `everlake_tspell_ok` (`trainer` INT UNSIGNED NOT NULL, `spell` INT NOT NULL, PRIMARY KEY (`trainer`, `spell`));
INSERT INTO `everlake_tspell_ok` (`trainer`, `spell`)
SELECT s.`trainer`, s.`spell` FROM `everlake_tspell` s
WHERE EXISTS (SELECT 1 FROM `trainer` t WHERE t.`Id` = s.`trainer`)
  AND NOT EXISTS (SELECT 1 FROM `trainer_spell` x WHERE x.`TrainerId` = s.`trainer` AND x.`SpellId` = s.`spell`);

INSERT INTO `trainer_spell` (`TrainerId`, `SpellId`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqAbility1`, `ReqAbility2`, `ReqAbility3`, `ReqLevel`, `VerifiedBuild`)
SELECT s.`trainer`, s.`spell`, s.`cost`, s.`skill`, s.`rank`, s.`a1`, s.`a2`, s.`a3`, s.`lvl`, 0
FROM `everlake_tspell` s JOIN `everlake_tspell_ok` o ON o.`trainer` = s.`trainer` AND o.`spell` = s.`spell`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'trainer_spell', s.`trainer`, s.`spell`, 0, 0, @EVERLAKE_FILE, 'Wowhead Forever: taught on live; values from the realm''s other lists'
FROM `everlake_tspell` s JOIN `everlake_tspell_ok` o ON o.`trainer` = s.`trainer` AND o.`spell` = s.`spell`;
DROP TEMPORARY TABLE `everlake_tspell_ok`;
DROP TEMPORARY TABLE `everlake_tspell`;

COMMIT;
