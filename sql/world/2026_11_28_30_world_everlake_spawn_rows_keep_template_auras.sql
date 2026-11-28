-- Spawns whose own addon row hides their creature's auras (stealth detection, stealth, armors, sleep and the rest).
-- 2026_11_28_30_world_everlake_spawn_rows_keep_template_auras.sql: written by hand, not tried in game (2026-11-27).
--
-- The core takes a spawn's creature_addon row INSTEAD of its creature's template addon (Creature::GetCreatureAddon).
-- On the realm (PTR, 2026-11-27) 476 spawn rows of 179 creatures have an addon row with no auras at all while their
-- creature's template addon has some; 368 of them carry a patrol path (PathId 800...) that the VMaNGOS waypoint import
-- wrote without copying the template's auras. Those spawns lack what every other spawn of the same creature has, e.g.:
--   Invisibility and Stealth Detection 18950: 66 rows of 19 creatures (Booty Bay, Gadgetzan, Ratchet, Everlook and
--     Steamwheedle Bruisers, Coldridge Mountaineers, Northshire Guards, Den Grunts, Deathguards Oliver and Phillip,
--     Moonglade Wardens, Shadowglen Sentinels, Cenarion Hold Infantry, Argent Sentries, Ancient Core Hounds, the
--     Thunder Bluff hunters); Infernal Sentry 8278 + 8279.
--   Armors 12544 (Dalaran Wizards and Apprentices, Defias Conjurers, Evokers, Squallshapers and others), stealth 5916 /
--   6408 (Shadowstalkers, Stalkers, Wastewander Rogues), invisibility 16380 (Eldreth Spectres), the Lazy Peons' sleep
--   17743, Stormwind Guards' 5301, and the rest.
-- No live source in the tracker records creature auras, so this goes by the realm's own templates: each such row gets
-- its template's auras; paths, emotes, mounts and stand states stay. Rows that have auras of their own are left alone.
-- Covers the rows 2026_11_27_80 fixes too (that file runs first; nothing is left for this one there).
-- Every change is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file.
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
SET @EVERLAKE_FILE := '2026_11_28_30_world_everlake_spawn_rows_keep_template_auras.sql';

START TRANSACTION;

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_addon', ca.`guid`, 0, 0, 0, @EVERLAKE_FILE, LEFT(CONCAT('auras empty -> template ', t.`auras`, ' (creature ', c.`id`, ')'), 255)
FROM `creature_addon` ca JOIN `creature` c ON c.`guid` = ca.`guid` JOIN `creature_template_addon` t ON t.`entry` = c.`id`
WHERE IFNULL(ca.`auras`, '') = '' AND IFNULL(t.`auras`, '') <> '';
UPDATE `creature_addon` ca JOIN `creature` c ON c.`guid` = ca.`guid` JOIN `creature_template_addon` t ON t.`entry` = c.`id`
SET ca.`auras` = t.`auras`
WHERE IFNULL(ca.`auras`, '') = '' AND IFNULL(t.`auras`, '') <> '';

COMMIT;
