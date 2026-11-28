-- Forge spawns that stand off their live spots: Ombassa (263315, named elite cat, 41) and two Children of Tortolla
-- (249224, Mount Hyjal).
-- 2026_11_28_10_world_everlake_forge_spawns_off_pins.sql: written by hand, not tried in game (2026-11-27).
--
-- Found by checking every creature spawn the tracker's Forge still owns on the realm (runs 56, 101, 336; 32 rows)
-- against Wowhead Forever's map pins, turned into world positions with the client's UiMapAssignment rectangles (the
-- tracker's tools/ft/geo.py), and against EG Link's live sightings. 29 rows stand within 20 yards of a pin; these do not:
--
--   Ombassa: seven Forge spawns 974002120-974002126 (run 336), no pool, 31-255 yards from every pin, one of them
--     (974002124) inside the Rog'mar camp, 22 yards from Kreza Darkthorn, where it fought the camp all the time.
--     Wowhead's nine pins (UiMap 2548) and EG Link's three live sightings (-8208 -4779, -8181 -4785, -8179 -4798) put it
--     on a rise west of the camp (six pins within 25 yards of -8206 -4777) and along a trail south-east of it
--     (-8222 -4865, -8151 -4923, -8119 -4957). Now: four spots, the rise and the three trail pins, one pool, one up.
--     974002124-974002126 are removed. Respawn time and wander are left as they are (no source gives them).
--   Child of Tortolla: 974002116 (5192 -2008) and 974002117 (5105 -2209) stand 85 and 62 yards from the nearest of its
--     18 pins (UiMap 2482), about 100 yards up the mountain (z 1366 and 1385; the pins' ground is 1261-1282). They move
--     onto pins: 5283 -2045 and 5212 -2187. 974002115 (18 yards from a pin) stays.
--
-- Heights from the server's maps and vmaps (tools/height.py, terrain at every point). Rows are changed only while they
-- are as the Forge left them. Every change is recorded in everlake_import_rows.
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
SET @EVERLAKE_FILE := '2026_11_28_10_world_everlake_forge_spawns_off_pins.sql';
SET @EVERLAKE_NOTE := 'moved onto Wowhead Forever pins (client UiMapAssignment) + EG Link live sightings';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_moves`;
CREATE TEMPORARY TABLE `everlake_moves` (`guid` BIGINT UNSIGNED NOT NULL PRIMARY KEY, `id` INT UNSIGNED NOT NULL,
  `old_x` FLOAT NOT NULL, `old_y` FLOAT NOT NULL, `x` FLOAT NOT NULL, `y` FLOAT NOT NULL, `z` FLOAT NOT NULL, `label` VARCHAR(80) NOT NULL);
INSERT INTO `everlake_moves` VALUES
(974002120, 263315, -8170.63, -4804.09, -8206.0, -4777.0, 46.79, 'Ombassa: the rise west of the Rog''mar camp'),
(974002121, 263315, -8287.03, -4647.92, -8222.0, -4865.0, 24.77, 'Ombassa: trail pin'),
(974002122, 263315, -8048.74, -4690.60, -8151.0, -4923.0, 24.99, 'Ombassa: trail pin'),
(974002123, 263315, -8380.80, -4747.83, -8119.0, -4957.0, 24.35, 'Ombassa: trail pin'),
(974002116, 249224, 5192.01, -2007.51, 5283.0, -2045.0, 1282.46, 'Child of Tortolla: onto a pin'),
(974002117, 249224, 5105.44, -2208.59, 5212.0, -2187.0, 1261.41, 'Child of Tortolla: onto a pin');
DELETE m FROM `everlake_moves` m
WHERE NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = m.`guid` AND c.`id` = m.`id`
  AND ABS(c.`position_x` - m.`old_x`) < 1 AND ABS(c.`position_y` - m.`old_y`) < 1);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', m.`guid`, 0, 0, 0, @EVERLAKE_FILE, CONCAT(m.`label`, '; ', @EVERLAKE_NOTE) FROM `everlake_moves` m;
UPDATE `creature` c JOIN `everlake_moves` m ON m.`guid` = c.`guid`
SET c.`position_x` = m.`x`, c.`position_y` = m.`y`, c.`position_z` = m.`z`;
DROP TEMPORARY TABLE `everlake_moves`;

-- Ombassa's other three Forge spots, none on a pin (974002124 inside the Rog'mar camp)
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'removed: Ombassa Forge spot off every pin'
FROM `creature` c WHERE c.`guid` BETWEEN 974002124 AND 974002126 AND c.`id` = 263315;
DELETE FROM `creature` WHERE `guid` BETWEEN 974002124 AND 974002126 AND `id` = 263315;

-- Ombassa: one pool, one up
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
SELECT 920000205, 1, 'Ombassa (263315) - one of its spots'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `pool_template` WHERE `entry` = 920000205)
  AND EXISTS (SELECT 1 FROM `creature` WHERE `id` = 263315 AND `guid` BETWEEN 974002120 AND 974002123);
INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`)
SELECT 0, c.`guid`, 920000205, 0, 'Ombassa (263315)'
FROM `creature` c
WHERE c.`id` = 263315 AND c.`guid` BETWEEN 974002120 AND 974002123
  AND EXISTS (SELECT 1 FROM `pool_template` WHERE `entry` = 920000205)
  AND NOT EXISTS (SELECT 1 FROM `pool_members` p WHERE p.`type` = 0 AND p.`spawnId` = c.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_template', 920000205, 0, 0, 0, @EVERLAKE_FILE, 'Ombassa one at a time' FROM `pool_template` WHERE `entry` = 920000205;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_members', 0, p.`spawnId`, 0, 0, @EVERLAKE_FILE, 'Ombassa one at a time'
FROM `pool_members` p WHERE p.`type` = 0 AND p.`poolSpawnId` = 920000205;

COMMIT;
