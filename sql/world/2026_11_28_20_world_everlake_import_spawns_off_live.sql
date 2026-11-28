-- Imported spawns that stand far from every live record of where their creature or object is.
-- 2026_11_28_20_world_everlake_import_spawns_off_live.sql: written by hand, not tried in game (2026-11-27).
--
-- Checked: every creature spawn of the realm (PTR) whose creature no Classic world places (the tracker's spawn audit
-- verdict "unknown": 3,216 spawns outside the VMaNGOS blocks) against three live sources in the tracker's tables:
-- Wowhead Forever's map pins and QuestieDB's Forever points and traces (zone percentages turned into world positions
-- with the client's UiMapAssignment rectangles, as tools/ft/geo.py does) and EG Link's live sightings. 2,513 have a
-- source point on their map; 77 stand more than 60 yards from every point. Fixed here, where the evidence is plain:
--
--   Eastsea Buccaneer 257901 and Eastsea Musketeer 257910 (47221001-47221016, core 2026_11_10_73): placed "around our
--     only Eastsea Raider" because no source had their spots then; they stand on a hillside (z 56-81) 200-255 yards from
--     their camp. Now 26 + 50 Wowhead pins, 40 + 32 EG Link sightings and 497 Questie points put the camp on the shore
--     around -7650 -6090. Each of the 16 moves onto a Wowhead pin of its own creature, picked to spread over the camp
--     (farthest-point picks; pins in the water left out).
--   Snargl 255906 (47221029, same file, "in the middle of our gnoll camp"): 243 yards from every point. Moves onto its
--     Wowhead pin on open ground (-8789.3 -2671.2); the other three pins are over a mine model with unclear floors.
--   Harvest Golem V000-A 212252 (47600000-47600001, core 2026_11_22_60 Karrz 0139): several hundred yards (up to 672) from its 16 Wowhead
--     pins and 146 Questie points in Westfall. Both move onto pins.
--   Hyjal (file 2026_11_18_926): five Mountain Squallclimbers 249491 and two Awakened Fel Ash Slimes 264306 stand
--     163-540 yards from every one of their points, most on mountain tops (z 1373-1401). Removed; the other 76 and 13 of
--     those creatures stand near their points and stay. (Those within 150 yards of a point are left: Hyjal's mobs roam.)
--
-- Left as they are: Kirin Tor Guard 246848 (14 spawns, the Forever Dalaran set on map 0, held by the realm owner),
-- Colossal Anubisath Warbringer 15743 (Ahn'Qiraj war; the realm keeps the war closed), and rares 60-80 yards off.
-- Heights from the server's maps and vmaps (tools/height.py, terrain at every point). Rows change only while they stand
-- where the import put them. Every change is recorded in everlake_import_rows.
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
SET @EVERLAKE_FILE := '2026_11_28_20_world_everlake_import_spawns_off_live.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_moves`;
CREATE TEMPORARY TABLE `everlake_moves` (`guid` BIGINT UNSIGNED NOT NULL PRIMARY KEY, `id` INT UNSIGNED NOT NULL,
  `old_x` FLOAT NOT NULL, `old_y` FLOAT NOT NULL, `x` FLOAT NOT NULL, `y` FLOAT NOT NULL, `z` FLOAT NOT NULL, `note` VARCHAR(160) NOT NULL);
INSERT INTO `everlake_moves` VALUES
(47221001, 257901, -7337.90, -5702.95, -7601.6, -6125.7, 2.46, 'Eastsea Buccaneer onto its Wowhead Forever pin (camp on the shore)'),
(47221003, 257901, -7334.99, -5680.43, -7882.9, -5888.1, 16.48, 'Eastsea Buccaneer onto its Wowhead Forever pin (camp on the shore)'),
(47221005, 257901, -7362.94, -5671.60, -7333.2, -6198.5, 0.57, 'Eastsea Buccaneer onto its Wowhead Forever pin (camp on the shore)'),
(47221007, 257901, -7372.88, -5691.97, -7701.8, -6130.6, 1.51, 'Eastsea Buccaneer onto its Wowhead Forever pin (camp on the shore)'),
(47221009, 257901, -7399.45, -5703.30, -7721.2, -5999.6, 17.85, 'Eastsea Buccaneer onto its Wowhead Forever pin (camp on the shore)'),
(47221011, 257901, -7370.76, -5719.44, -7776.2, -6116.0, 1.89, 'Eastsea Buccaneer onto its Wowhead Forever pin (camp on the shore)'),
(47221013, 257901, -7358.87, -5729.53, -7524.0, -6135.4, 1.47, 'Eastsea Buccaneer onto its Wowhead Forever pin (camp on the shore)'),
(47221015, 257901, -7344.91, -5714.89, -7808.5, -5956.0, 15.55, 'Eastsea Buccaneer onto its Wowhead Forever pin (camp on the shore)'),
(47221002, 257910, -7333.24, -5691.32, -7608.0, -6125.7, 2.25, 'Eastsea Musketeer onto its Wowhead Forever pin (camp on the shore)'),
(47221004, 257910, -7348.09, -5665.30, -7928.1, -5926.9, 10.39, 'Eastsea Musketeer onto its Wowhead Forever pin (camp on the shore)'),
(47221006, 257910, -7367.00, -5683.54, -7391.4, -5989.9, 1.55, 'Eastsea Musketeer onto its Wowhead Forever pin (camp on the shore)'),
(47221008, 257910, -7377.19, -5693.74, -7815.0, -6213.0, 4.45, 'Eastsea Musketeer onto its Wowhead Forever pin (camp on the shore)'),
(47221010, 257910, -7397.77, -5719.15, -7753.5, -5965.7, 19.04, 'Eastsea Musketeer onto its Wowhead Forever pin (camp on the shore)'),
(47221012, 257910, -7368.86, -5724.54, -7478.7, -6004.5, 4.66, 'Eastsea Musketeer onto its Wowhead Forever pin (camp on the shore)'),
(47221014, 257910, -7344.27, -5735.20, -7410.8, -6232.4, 1.78, 'Eastsea Musketeer onto its Wowhead Forever pin (camp on the shore)'),
(47221016, 257910, -7338.67, -5717.07, -7743.8, -6086.9, 2.50, 'Eastsea Musketeer onto its Wowhead Forever pin (camp on the shore)'),
(47221029, 255906, -8472.19, -3367.48, -8789.3, -2671.2, 195.98, 'Snargl onto its Wowhead Forever pin on open ground'),
(47600000, 212252, -9922.66, 1854.65, -10368.3, 1112.7, 35.43, 'Harvest Golem V000-A onto its Wowhead Forever pin (Westfall)'),
(47600001, 212252, -10538.70, 1504.66, -10627.3, 1060.2, 34.37, 'Harvest Golem V000-A onto its Wowhead Forever pin (Westfall)');
DELETE m FROM `everlake_moves` m
WHERE NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = m.`guid` AND c.`id` = m.`id`
  AND ABS(c.`position_x` - m.`old_x`) < 1 AND ABS(c.`position_y` - m.`old_y`) < 1);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', m.`guid`, 0, 0, 0, @EVERLAKE_FILE, m.`note` FROM `everlake_moves` m;
UPDATE `creature` c JOIN `everlake_moves` m ON m.`guid` = c.`guid`
SET c.`position_x` = m.`x`, c.`position_y` = m.`y`, c.`position_z` = m.`z`;
DROP TEMPORARY TABLE `everlake_moves`;

-- Hyjal spawns far from every point of their creature (file 2026_11_18_926)
DROP TEMPORARY TABLE IF EXISTS `everlake_drops`;
CREATE TEMPORARY TABLE `everlake_drops` (`guid` BIGINT UNSIGNED NOT NULL PRIMARY KEY, `id` INT UNSIGNED NOT NULL,
  `old_x` FLOAT NOT NULL, `old_y` FLOAT NOT NULL, `note` VARCHAR(160) NOT NULL);
INSERT INTO `everlake_drops` VALUES
(920001335, 249491, 4242.80, -2483.99, 'removed: Mountain Squallclimber 540 yd from every live point'),
(920001352, 249491, 5034.62, -2164.48, 'removed: Mountain Squallclimber 277 yd from every live point'),
(920001353, 249491, 5042.72, -2111.00, 'removed: Mountain Squallclimber 294 yd from every live point'),
(920001354, 249491, 5046.88, -2260.68, 'removed: Mountain Squallclimber 297 yd from every live point'),
(920001356, 249491, 5077.21, -2172.12, 'removed: Mountain Squallclimber 319 yd from every live point'),
(920003124, 264306, 4285.39, -2688.89, 'removed: Awakened Fel Ash Slime 223 yd from every live point'),
(920003125, 264306, 4293.95, -2627.77, 'removed: Awakened Fel Ash Slime 163 yd from every live point');
DELETE d FROM `everlake_drops` d
WHERE NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = d.`guid` AND c.`id` = d.`id`
  AND ABS(c.`position_x` - d.`old_x`) < 1 AND ABS(c.`position_y` - d.`old_y`) < 1)
   OR EXISTS (SELECT 1 FROM `pool_members` p WHERE p.`type` = 0 AND p.`spawnId` = d.`guid`)
   OR EXISTS (SELECT 1 FROM `game_event_creature` e WHERE e.`guid` = d.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', d.`guid`, 0, 0, 0, @EVERLAKE_FILE, d.`note` FROM `everlake_drops` d;
DELETE a FROM `creature_addon` a JOIN `everlake_drops` d ON d.`guid` = a.`guid`;
DELETE g FROM `spawn_group` g JOIN `everlake_drops` d ON d.`guid` = g.`spawnId` WHERE g.`spawnType` = 0;
DELETE c FROM `creature` c JOIN `everlake_drops` d ON d.`guid` = c.`guid`;
DROP TEMPORARY TABLE `everlake_drops`;

-- Gameobjects (the same check over the 2,091 imported object spawns that are neither sniffed nor tied to an event,
-- against Wowhead Forever pins, QuestieDB object points and traces and Icy Veins' recorded points: 1,490 have a point on
-- their map, 13 stand more than 40 yards off; two are plain):
--   Orthas's Hammer 461639 (47500105, core Karrz 0139 2026_11_22_50): 448 yards from QuestieDB's and Icy Veins' point
--     (2012 -4560, Eastern Plaguelands). Moves there. INFERRED height: the point is inside a building with floors at
--     75, 79.5 and 85-86; the ground floor (74.99) is used, no source gives a height.
UPDATE `gameobject` g
SET g.`position_x` = 2012.0, g.`position_y` = -4560.0, g.`position_z` = 74.99
WHERE g.`guid` = 47500105 AND g.`id` = 461639 AND ABS(g.`position_x` - 1708.12) < 1 AND ABS(g.`position_y` + 4893.26) < 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', 47500105, 0, 0, 0, @EVERLAKE_FILE, 'Orthas''s Hammer onto QuestieDB / Icy Veins point; ground floor INFERRED'
FROM `gameobject` g WHERE g.`guid` = 47500105 AND g.`id` = 461639 AND g.`position_x` = 2012.0;
--   Apple Bob 180523 (900000000, import slice 4): a Hallow's End tub standing all year in Razor Hill, on top of the
--     realm's own Hallow's End Apple Bob 30332855 (event 12, same spot). Removed; the event one stays.
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'removed: year-round Apple Bob over the Hallow''s End one (30332855)'
FROM `gameobject` g WHERE g.`guid` = 900000000 AND g.`id` = 180523
  AND NOT EXISTS (SELECT 1 FROM `game_event_gameobject` e WHERE e.`guid` = 900000000)
  AND EXISTS (SELECT 1 FROM `game_event_gameobject` e JOIN `gameobject` o ON o.`guid` = e.`guid` WHERE o.`id` = 180523 AND o.`map` = 1
    AND ABS(o.`position_x` - g.`position_x`) < 5 AND ABS(o.`position_y` - g.`position_y`) < 5);
DELETE g FROM `gameobject` g JOIN `everlake_import_rows` r ON r.`tbl` = 'gameobject' AND r.`k1` = g.`guid` AND r.`file` = @EVERLAKE_FILE
WHERE g.`guid` = 900000000 AND g.`id` = 180523;
DELETE FROM `gameobject_addon` WHERE `guid` = 900000000 AND NOT EXISTS (SELECT 1 FROM `gameobject` WHERE `guid` = 900000000);
DELETE FROM `spawn_group` WHERE `spawnType` = 1 AND `spawnId` = 900000000 AND NOT EXISTS (SELECT 1 FROM `gameobject` WHERE `guid` = 900000000);

COMMIT;
