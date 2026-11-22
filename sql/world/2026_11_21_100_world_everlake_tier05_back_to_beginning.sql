-- "Back to the Beginning" handed in to the Mokvar and Deliana that live Forever shows.
-- 2026_11_21_100_world_everlake_tier05_back_to_beginning.sql: written by hand from Wowhead's Forever quest pages.
--
-- Follows 2026_11_21_99_world_everlake_tier05_live_givers.sql: Bodley's "Back to the Beginning" (8997 Alliance, 8998
-- Horde) was still handed in only to the old Deliana 16013 and Mokvar 16012, whose spawns are gone (live never shows
-- them). Wowhead's Forever pages list live's Deliana 230319 and Mokvar 230317 as enders. This links them as well.
-- Only where the link is not there yet; each added row is recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

SET @EVERLAKE_FILE := '2026_11_21_100_world_everlake_tier05_back_to_beginning.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_tier05`;
CREATE TEMPORARY TABLE `everlake_tier05` (
  `tbl` varchar(32) NOT NULL,
  `id` int unsigned NOT NULL,
  `quest` int unsigned NOT NULL,
  `note` varchar(255) NOT NULL,
  `missing` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`tbl`, `id`, `quest`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_tier05` (`tbl`, `id`, `quest`, `note`) VALUES
('creature_questender', 230319, 8997, 'wowhead end 230319'),  -- Back to the Beginning (Alliance)
('creature_questender', 230317, 8998, 'wowhead end 230317');  -- Back to the Beginning (Horde)

UPDATE `everlake_tier05` s SET s.`missing` = 1
WHERE EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = s.`id`)
  AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`)
  AND ((s.`tbl` = 'creature_queststarter' AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` c WHERE c.`id` = s.`id` AND c.`quest` = s.`quest`))
    OR (s.`tbl` = 'creature_questender' AND NOT EXISTS (SELECT 1 FROM `creature_questender` c WHERE c.`id` = s.`id` AND c.`quest` = s.`quest`)));
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`)
SELECT `id`, `quest`, 0 FROM `everlake_tier05` WHERE `tbl` = 'creature_queststarter' AND `missing` = 1;
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`)
SELECT `id`, `quest`, 0 FROM `everlake_tier05` WHERE `tbl` = 'creature_questender' AND `missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT `tbl`, `id`, `quest`, 0, 0, @EVERLAKE_FILE, `note` FROM `everlake_tier05` WHERE `missing` = 1;
DROP TEMPORARY TABLE `everlake_tier05`;

COMMIT;
