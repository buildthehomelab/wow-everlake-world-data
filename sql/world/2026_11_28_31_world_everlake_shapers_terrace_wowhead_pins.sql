-- The Shaper's Terrace: five spawns far from their creature's Wowhead Forever pins, moved onto them.
-- 2026_11_28_31_world_everlake_shapers_terrace_wowhead_pins.sql: written by hand, not tried in game (2026-11-28).
--
-- The dungeon's 69 creature spawns (map 3001) were placed by hand with INFERRED spots. EG Link has no record of the map
-- (no sightings, no encounter), and Icy Veins, QuestieDB and NorgannonDB keep no positions for its creatures. Wowhead's
-- Forever database pins four of its 44 creatures on the Kalimdor map (UiMap 1414); map 3001 keeps Un'Goro Crater's
-- coordinates, so those pins turn into positions inside it (the client's UiMapAssignment rectangles, as the tracker's
-- tools/ft/geo.py does). Seeping Slime 262684's two spawns (920014007-8) already stand on its two pins. The others:
--
--   Ravasaur Hunter 253214 (974002001-2): 241 and 301 yards from its pins (-5649.1 -1002.1, -5796.3 -1038.9).
--   Ironhide Ravasaur 261786 (974002029-30): 155 and 291 yards from its pins, the same two as the Hunter's (a rider and
--     its mount, or two at one spot: Wowhead rounds pins to about 12 yards). Each stands 3 yards from its Hunter
--     (INFERRED offset).
--   Azurepetal Sporecaller 261968 (974002039): 295 yards from its pin (-5526.4 -928.5), in shallow water; on the ground
--     under it.
--
-- All five are plain spawns: MovementType 0, no path, formation, pool or game event; the instance script places nothing
-- by them. Heights from the server's maps and vmaps (tools/height.py), each spot on the navmesh floor that joins the
-- dungeon's rooms. Orientation is kept. The other 64 spawns have no live source to check them by: left as they are.
-- Rows change only while they stand where the import put them. Every change is recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_28_31_world_everlake_shapers_terrace_wowhead_pins.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_moves`;
CREATE TEMPORARY TABLE `everlake_moves` (`guid` BIGINT UNSIGNED NOT NULL PRIMARY KEY, `id` INT UNSIGNED NOT NULL,
  `old_x` FLOAT NOT NULL, `old_y` FLOAT NOT NULL, `x` FLOAT NOT NULL, `y` FLOAT NOT NULL, `z` FLOAT NOT NULL, `note` VARCHAR(160) NOT NULL);
INSERT INTO `everlake_moves` VALUES
(974002001, 253214, -5620.80, -762.50, -5649.07, -1002.11, 16.65, 'Ravasaur Hunter: 241 yd onto its Wowhead Forever pin'),
(974002002, 253214, -5795.80, -737.50, -5796.27, -1038.91, 12.20, 'Ravasaur Hunter: 301 yd onto its Wowhead Forever pin'),
(974002029, 261786, -5812.50, -1329.20, -5646.07, -1002.11, 16.72, 'Ironhide Ravasaur: onto its Wowhead Forever pin, 3 yd from the Hunter (offset INFERRED)'),
(974002030, 261786, -5862.50, -1179.20, -5793.27, -1038.91, 12.83, 'Ironhide Ravasaur: onto its Wowhead Forever pin, 3 yd from the Hunter (offset INFERRED)'),
(974002039, 261968, -5770.80, -762.50, -5526.40, -928.51, 18.06, 'Azurepetal Sporecaller: 295 yd onto its Wowhead Forever pin (shallow water)');
DELETE m FROM `everlake_moves` m
WHERE NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = m.`guid` AND c.`id` = m.`id`
  AND ABS(c.`position_x` - m.`old_x`) < 1 AND ABS(c.`position_y` - m.`old_y`) < 1);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', m.`guid`, 0, 0, 0, @EVERLAKE_FILE, m.`note` FROM `everlake_moves` m;
UPDATE `creature` c JOIN `everlake_moves` m ON m.`guid` = c.`guid`
SET c.`position_x` = m.`x`, c.`position_y` = m.`y`, c.`position_z` = m.`z`;
DROP TEMPORARY TABLE `everlake_moves`;

COMMIT;
