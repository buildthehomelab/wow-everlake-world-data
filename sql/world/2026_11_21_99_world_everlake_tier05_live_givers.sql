-- Tier 0.5 quests that live Forever still gives, moved to the Mokvar and Deliana that live shows.
-- 2026_11_21_99_world_everlake_tier05_live_givers.sql: written by hand from players' QuestieDB traces and Wowhead.
--
-- 2026_11_21_01_world_everlake_old_twins_doubled.sql took away the old Mokvar 16012 (Orgrimmar) and Deliana 16013
-- (Ironforge) spawns, which stood beside live Forever's own Mokvar 230317 and Deliana 230319: live never sends the
-- old ones to a client (EG Link has only the new ones). Live replaced most of the old Tier 0.5 quests with its own
-- (84147-84210, which the new pair already gives), but players' QuestieDB traces show the new pair also giving
-- "A Supernatural Device" (8922, 8929 Deliana; 8923, 8930 Mokvar) and taking "Return to Deliana" (8977) and
-- "Return to Mokvar" (8978); Wowhead's Forever pages list 230319 and 230317 as starters of 8922 and 8923 too. On
-- the realm those six were still linked only to the old pair, which no longer stands anywhere.
-- This links them to the new pair as well. The old links stay (they do nothing without a spawn).
-- Only where the link is not there yet; each added row is recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

SET @EVERLAKE_FILE := '2026_11_21_99_world_everlake_tier05_live_givers.sql';

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
('creature_queststarter', 230319, 8922, 'questietrace startedBy_add 230319; wowhead start 230319'), -- A Supernatural Device (Alliance)
('creature_queststarter', 230319, 8929, 'questietrace questStarts_add 230319'),                      -- A Supernatural Device (Alliance)
('creature_queststarter', 230317, 8923, 'questietrace startedBy_add 230317; wowhead start 230317'), -- A Supernatural Device (Horde)
('creature_queststarter', 230317, 8930, 'questietrace questStarts_add 230317'),                      -- A Supernatural Device (Horde)
('creature_questender', 230319, 8977, 'questietrace questEnds_add 230319'),                          -- Return to Deliana
('creature_questender', 230317, 8978, 'questietrace questEnds_add 230317');                          -- Return to Mokvar

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
