-- Turn-in quests nobody could hand in: givers for 15 autocomplete quests (QuestType 0) that had only an ender.
-- 2026_11_27_70_world_everlake_autocomplete_quest_givers.sql
-- The core offers a turn-in quest from the quest giver list only (Player::PrepareQuestMenu: IsTurnIn() quests come from
-- the creature's quest relations, never from its involved relations), so a turn-in with an ender and no giver never
-- shows. Every turn-in quest of the world that does have a giver (640) has the same creature as giver and ender.
-- Sources (the tracker's tables: Wowhead WoW Forever quest pages, Icy Veins, EG Link's live recording):
--   Gelvas Grimegate 14828 gives and takes the Darkmoon Faire ticket prizes 7930-7936, 7940, 7981 (Wowhead).
--   Jang 15078 gives and takes Apprentice Angler 8194 (Wowhead).
--   Fishbot 5000 15079 gives and takes the Stranglethorn rare fish 8221, 8224, 8225 (EG Link live, Icy Veins, Wowhead).
--   Grinkle 15116 gives and takes Could I get a Fishing Flier? 8228 (EG Link live, Icy Veins, Wowhead); Barrus 15119
--   gives and takes 8229 (Icy Veins, Wowhead).
-- Left out: 9249 (40 Tickets - Schematic: Steam Tonk Controller), which no source records, and Bang a Gong! 8743 (the
-- Scarab Gong), part of the Ahn'Qiraj war effort the realm keeps closed.
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
(1, 14828, 7930, 'Wowhead WoW Forever quest page: Gelvas Grimegate gives and takes it'),
(2, 14828, 7931, 'Wowhead WoW Forever quest page: Gelvas Grimegate gives and takes it'),
(3, 14828, 7932, 'Wowhead WoW Forever quest page: Gelvas Grimegate gives and takes it'),
(4, 14828, 7933, 'Wowhead WoW Forever quest page: Gelvas Grimegate gives and takes it'),
(5, 14828, 7934, 'Wowhead WoW Forever quest page: Gelvas Grimegate gives and takes it'),
(6, 14828, 7935, 'Wowhead WoW Forever quest page: Gelvas Grimegate gives and takes it'),
(7, 14828, 7936, 'Wowhead WoW Forever quest page: Gelvas Grimegate gives and takes it'),
(8, 14828, 7940, 'Wowhead WoW Forever quest page: Gelvas Grimegate gives and takes it'),
(9, 14828, 7981, 'Wowhead WoW Forever quest page: Gelvas Grimegate gives and takes it'),
(10, 15078, 8194, 'Wowhead WoW Forever quest page: Jang gives and takes it'),
(11, 15079, 8221, 'EG Link live, Icy Veins, Wowhead WoW Forever: Fishbot 5000 gives and takes it'),
(12, 15079, 8224, 'EG Link live, Icy Veins, Wowhead WoW Forever: Fishbot 5000 gives and takes it'),
(13, 15079, 8225, 'EG Link live, Icy Veins, Wowhead WoW Forever: Fishbot 5000 gives and takes it'),
(14, 15116, 8228, 'EG Link live, Icy Veins, Wowhead WoW Forever: Grinkle gives and takes it'),
(15, 15119, 8229, 'Icy Veins, Wowhead WoW Forever: Barrus gives and takes it');
UPDATE `everlake_build_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`) AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`) AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_build_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'creature_queststarter', s.`id`, s.`quest`, '2026_11_27_70_world_everlake_autocomplete_quest_givers.sql', s.`note` FROM `everlake_build_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_build_stage`;
COMMIT;
