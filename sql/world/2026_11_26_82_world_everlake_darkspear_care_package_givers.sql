-- Darkspear Islands care packages (98910-98915): givers and enders, and the quest flag for the two quartermasters.
-- 2026_11_26_82_world_everlake_darkspear_care_package_givers.sql
-- Wowhead WoW Forever quest pages (kept by the tracker): Creeg Bothunk 263570, Darkspear Raiders Quartermaster, gives
--   and takes 98910 Darkspear's Basic Care Package and 98912 Darkspear's Advanced Care Package.
-- Inferred, no source records them:
--   98911 Darkspear's Standard Care Package -> Creeg Bothunk, the giver of the Basic and Advanced packages of the same
--   faction (reputation objective: Darkspear Raiders 2798).
--   98913-98915 Theramore Basic/Standard/Advanced Care Package -> Bryanna Embreeze 263569, Theramore Expeditionary
--   Force Quartermaster (reputation objective: Theramore Expeditionary Force 2799), the Alliance side's copy of Creeg.
-- Both quartermasters are spawned but have only the vendor flag (npcflag 128), so they show no quests: the quest giver
-- flag (2) is added.
-- Game names and text belong to Blizzard Entertainment.
-- Each row is recorded in `everlake_import_rows`. Never edit this file once it is deployed: a later fix is a new file.
-- Running it again changes nothing.
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
START TRANSACTION;
CREATE TEMPORARY TABLE `everlake_build_stage` (`n` INT NOT NULL PRIMARY KEY, `id` INT UNSIGNED NOT NULL, `quest` INT UNSIGNED NOT NULL, `note` VARCHAR(255) NOT NULL DEFAULT '', `missing` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_build_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 263570, 98911, 'inferred: Creeg Bothunk gives 98910 and 98912 (Wowhead), the same faction''s other packages'),
(2, 263569, 98913, 'inferred: Bryanna Embreeze, Theramore Expeditionary Force Quartermaster, the Alliance copy of Creeg'),
(3, 263569, 98914, 'inferred: Bryanna Embreeze, Theramore Expeditionary Force Quartermaster, the Alliance copy of Creeg'),
(4, 263569, 98915, 'inferred: Bryanna Embreeze, Theramore Expeditionary Force Quartermaster, the Alliance copy of Creeg');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', s.`id`, s.`quest`, '2026_11_26_82_world_everlake_darkspear_care_package_givers.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
UPDATE `everlake_build_stage` SET `missing` = 0;
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_questender' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_questender', s.`id`, s.`quest`, '2026_11_26_82_world_everlake_darkspear_care_package_givers.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
-- the quest giver flag, so both quartermasters show their packages
UPDATE `creature_template` SET `npcflag` = `npcflag` | 2 WHERE `entry` IN (263569, 263570) AND (`npcflag` & 2) = 0;
COMMIT;
