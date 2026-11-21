-- Old twins standing beside their live copy: removes the old spawn, keeps the live one.
-- 2026_11_21_01_world_everlake_old_twins_doubled.sql: written by hand from the ForeverTracker's Extras > Old twin list.
--
-- An old twin is a creature the live server never sent to a client while it did send another entry of the same name
-- (Forever's copy of a Classic creature: the mount vendors' display mounts 12363-14553 against 267683-276736, Deliana
-- 16013 against 230319). The tracker lists 94 of them by name alone. Each spawn was checked on the test realm's world
-- (2026-11-21): only these 20 have a spawn of the live entry on the same map within 15 yards, in the same phase, with
-- no world event on either. Those are one creature shown twice; the old one goes.
-- Not here, on purpose: old twins with no live spawn near them (Mangled Cadaver, Skeletal Soldier, Searing Lava Spider,
-- the Ungoro map 3001 creatures and others stand where no live copy does), the chickens (critters that wander, 5 to
-- 11 yards from a live chicken) and Sentinel Keldara Sunblade (30 yards from the live one).
--
-- A spawn goes only while it still holds its old entry and a live-entry spawn still stands within 15 yards on its map.
-- With it go its addon, event, pool, spawn group and formation rows, and its rows in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_old_twins`;
CREATE TEMPORARY TABLE `everlake_old_twins` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY,
  `old_id` int unsigned NOT NULL,
  `live_id` int unsigned NOT NULL
);
INSERT INTO `everlake_old_twins` (`guid`, `old_id`, `live_id`) VALUES
(20009536, 5404, 268313),    -- Black Stallion, 2.6 yd
(20000171, 12363, 267687),   -- Blue Mechanostrider, 0.2 yd
(9953239, 270542, 12376),    -- Brown Horse, 3.3 yd
(20004147, 12372, 267473),   -- Brown Ram, 4.3 yd
(9953240, 270543, 12375),    -- Chestnut Mare, 7 yd
(20302422, 16013, 230319),   -- Deliana, 2.6 yd
(20000172, 12367, 267684),   -- Green Mechanostrider, 0.4 yd
(20302423, 16012, 230317),   -- Mokvar, 10 yd
(21101716, 259843, 259006),  -- Musical Gustjumper, 4.6 yd
(9953241, 270544, 5405),     -- Pinto, 6.6 yd
(20001725, 12365, 267683),   -- Red Mechanostrider, 0.1 yd
(20095107, 14546, 276779),   -- Swift Brown Ram, 6.9 yd
(20095125, 14561, 276785),   -- Swift Brown Steed, 11.3 yd
(20095114, 14553, 276736),   -- Swift Green Mechanostrider, 4.5 yd
(20095100, 14539, 276832),   -- Swift Timber Wolf, 13 yd
(20095113, 14552, 276734),   -- Swift White Mechanostrider, 0 yd
(20095108, 14547, 276783),   -- Swift White Ram, 12.1 yd
(20095112, 14551, 276735),   -- Swift Yellow Mechanostrider, 0 yd
(20006615, 12353, 267301),   -- Timber Riding Wolf, 12 yd
(20000175, 12366, 267688);   -- Unpainted Mechanostrider, 0.2 yd

-- keep only the rows whose spawn is still the old entry with a live copy within 15 yards
DROP TEMPORARY TABLE IF EXISTS `everlake_old_twins_go`;
CREATE TEMPORARY TABLE `everlake_old_twins_go` (`guid` bigint unsigned NOT NULL PRIMARY KEY);
INSERT IGNORE INTO `everlake_old_twins_go` (`guid`)
SELECT c.`guid` FROM `everlake_old_twins` t
JOIN `creature` c ON c.`guid` = t.`guid` AND c.`id` = t.`old_id`
JOIN `creature` x ON x.`id` = t.`live_id` AND x.`map` = c.`map` AND x.`guid` <> c.`guid`
  AND (x.`position_x` - c.`position_x`) * (x.`position_x` - c.`position_x`)
    + (x.`position_y` - c.`position_y`) * (x.`position_y` - c.`position_y`)
    + (x.`position_z` - c.`position_z`) * (x.`position_z` - c.`position_z`) <= 225;

DELETE g FROM `game_event_creature` g JOIN `everlake_old_twins_go` t ON t.`guid` = g.`guid`;
DELETE a FROM `creature_addon` a JOIN `everlake_old_twins_go` t ON t.`guid` = a.`guid`;
DELETE p FROM `pool_members` p JOIN `everlake_old_twins_go` t ON t.`guid` = p.`spawnId` WHERE p.`type` = 0;
DELETE s FROM `spawn_group` s JOIN `everlake_old_twins_go` t ON t.`guid` = s.`spawnId` WHERE s.`spawnType` = 0;
DELETE f FROM `creature_formations` f JOIN `everlake_old_twins_go` t ON t.`guid` = f.`memberGUID`;
DELETE r FROM `everlake_import_rows` r JOIN `everlake_old_twins_go` t ON t.`guid` = r.`k1` WHERE r.`tbl` IN ('creature', 'creature_addon', 'game_event_creature');
DELETE c FROM `creature` c JOIN `everlake_old_twins_go` t ON t.`guid` = c.`guid`;

DROP TEMPORARY TABLE IF EXISTS `everlake_old_twins_go`;
DROP TEMPORARY TABLE IF EXISTS `everlake_old_twins`;

COMMIT;
