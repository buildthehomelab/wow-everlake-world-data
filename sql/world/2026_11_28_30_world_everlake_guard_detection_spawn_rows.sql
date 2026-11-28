-- Guards whose own spawn row hides their stealth detection.
-- 2026_11_28_30_world_everlake_guard_detection_spawn_rows.sql: written by hand, not tried in game (2026-11-27).
--
-- The core takes a spawn's creature_addon row INSTEAD of its creature's template addon (Creature::GetCreatureAddon). 15
-- guard creatures carry Invisibility and Stealth Detection (18950; the Infernal Sentry 8278 + 8279) on their template,
-- but 51 of their spawns have their own addon row with no auras at all, mostly a patrol path (PathId 800...) that the
-- VMaNGOS waypoint import wrote without copying the template's auras. Those spawns cannot see stealthed players or mobs,
-- unlike every other spawn of the same guard:
--   Coldridge Mountaineer 853 (5 of 17), Northshire Guard 1642 (3 of 7), Deathguard Oliver 1737 (1), Deathguard Phillip
--   1739 (1), Ratchet Bruiser 3502 (1 of 9), Booty Bay Bruiser 4624 (13 of 54), Den Grunt 5952 (4 of 14), Infernal Sentry
--   7136 (4 of 4), Gadgetzan Bruiser 9460 (5 of 34), Everlook Bruiser 11190 (2 of 18), Moonglade Warden 11822 (3 of 35),
--   Shadowglen Sentinel 12160 (2 of 17), Cenarion Hold Infantry 15184 (4 of 30), Steamwheedle Bruiser 16096 (1 of 11),
--   Argent Sentry 16378 (2 of 23).
-- No live source in the tracker records creature auras (Wowhead lists only spells a creature casts), so this goes by
-- the realm's own templates: those rows get their template's auras and keep their paths and the rest.
-- Only rows whose auras are empty, and only while the template still has its detection. Every change is recorded in
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';
SET @EVERLAKE_FILE := '2026_11_28_30_world_everlake_guard_detection_spawn_rows.sql';

START TRANSACTION;

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_addon', ca.`guid`, 0, 0, 0, @EVERLAKE_FILE, CONCAT('auras empty -> template ', t.`auras`, ' (guard detection; creature ', c.`id`, ')')
FROM `creature_addon` ca JOIN `creature` c ON c.`guid` = ca.`guid` JOIN `creature_template_addon` t ON t.`entry` = c.`id`
WHERE c.`id` IN (853, 1642, 1737, 1739, 3502, 4624, 5952, 7136, 9460, 11190, 11822, 12160, 15184, 16096, 16378)
  AND IFNULL(ca.`auras`, '') = '' AND t.`auras` REGEXP '(^| )(18950|8278|8279)( |$)';
UPDATE `creature_addon` ca JOIN `creature` c ON c.`guid` = ca.`guid` JOIN `creature_template_addon` t ON t.`entry` = c.`id`
SET ca.`auras` = t.`auras`
WHERE c.`id` IN (853, 1642, 1737, 1739, 3502, 4624, 5952, 7136, 9460, 11190, 11822, 12160, 15184, 16096, 16378)
  AND IFNULL(ca.`auras`, '') = '' AND t.`auras` REGEXP '(^| )(18950|8278|8279)( |$)';

COMMIT;
