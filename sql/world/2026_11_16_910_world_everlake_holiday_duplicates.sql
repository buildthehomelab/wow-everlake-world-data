-- Holiday spawns the realm had twice: removes the second copies that holiday imports added.
-- 2026_11_16_910_world_everlake_holiday_duplicates.sql: written by hand for the ForeverTracker's holiday cards.
--
-- The realm's holiday spawns come from VMaNGOS (the fork's 2026_10_17_53_world_classic_game_event_spawns.sql). The
-- holiday imports (Forge files 29 to 31 here, and the same operations on the test realm) came from cmangos classic-db,
-- which places the same NPC a few yards from where VMaNGOS does. They were matched at 5 yards (3 on the test realm), so
-- the realm got a second copy of some: Lunar Festival Elders, Guchie Jinglepocket, Sergeant Hartman, a Wickerman
-- Guardian, Hallow's End objects (and, on the test realm only, Silas Darkmoon, Burth and the Love is in the Air
-- perfume sellers). The tracker now matches a holiday's spawns at 30 yards for a creature and 10 for an object.
--
-- This file applies that rule to what is already there. A spawn goes when all of these hold:
--   - it was added by an import: guid 900000000 or more (the import block, and the Forge files' 910000000 + ...);
--   - an event brings it in (game_event_creature / game_event_gameobject with a positive event);
--   - a spawn from the realm's own world (guid below 900000000) of the same creature or object stands on the same map
--     within 30 yards (creature) or 10 yards (object), and that spawn is either there all year (no event) or brought
--     in by the same event. A realm spawn the event hides (a negative event) does not count: the import's spawn
--     replaces it.
-- With the spawn go its event links, its addon and its rows in everlake_import_rows. Nothing else is touched.
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added (docs/forever-import.md)';

START TRANSACTION;

-- creatures: the realm's copy within 30 yards
DROP TEMPORARY TABLE IF EXISTS `everlake_holiday_twins`;
CREATE TEMPORARY TABLE `everlake_holiday_twins` (`guid` bigint unsigned NOT NULL PRIMARY KEY);
INSERT IGNORE INTO `everlake_holiday_twins` (`guid`)
SELECT c.`guid` FROM `creature` c
JOIN `game_event_creature` e ON e.`guid` = c.`guid` AND e.`eventEntry` > 0
JOIN `creature` x ON x.`id` = c.`id` AND x.`map` = c.`map` AND x.`guid` < 900000000
  AND (x.`position_x` - c.`position_x`) * (x.`position_x` - c.`position_x`) + (x.`position_y` - c.`position_y`) * (x.`position_y` - c.`position_y`) <= 900
WHERE c.`guid` >= 900000000
  AND (NOT EXISTS (SELECT 1 FROM `game_event_creature` xe WHERE xe.`guid` = x.`guid`)
       OR EXISTS (SELECT 1 FROM `game_event_creature` xe WHERE xe.`guid` = x.`guid` AND xe.`eventEntry` = e.`eventEntry`));
DELETE g FROM `game_event_creature` g JOIN `everlake_holiday_twins` t ON t.`guid` = g.`guid`;
DELETE a FROM `creature_addon` a JOIN `everlake_holiday_twins` t ON t.`guid` = a.`guid`;
DELETE r FROM `everlake_import_rows` r JOIN `everlake_holiday_twins` t ON t.`guid` = r.`k1` WHERE r.`tbl` IN ('creature', 'creature_addon', 'game_event_creature');
DELETE c FROM `creature` c JOIN `everlake_holiday_twins` t ON t.`guid` = c.`guid`;
DROP TEMPORARY TABLE IF EXISTS `everlake_holiday_twins`;

-- objects: the realm's copy within 10 yards
CREATE TEMPORARY TABLE `everlake_holiday_twins` (`guid` bigint unsigned NOT NULL PRIMARY KEY);
INSERT IGNORE INTO `everlake_holiday_twins` (`guid`)
SELECT o.`guid` FROM `gameobject` o
JOIN `game_event_gameobject` e ON e.`guid` = o.`guid` AND e.`eventEntry` > 0
JOIN `gameobject` x ON x.`id` = o.`id` AND x.`map` = o.`map` AND x.`guid` < 900000000
  AND (x.`position_x` - o.`position_x`) * (x.`position_x` - o.`position_x`) + (x.`position_y` - o.`position_y`) * (x.`position_y` - o.`position_y`) <= 100
WHERE o.`guid` >= 900000000
  AND (NOT EXISTS (SELECT 1 FROM `game_event_gameobject` xe WHERE xe.`guid` = x.`guid`)
       OR EXISTS (SELECT 1 FROM `game_event_gameobject` xe WHERE xe.`guid` = x.`guid` AND xe.`eventEntry` = e.`eventEntry`));
DELETE g FROM `game_event_gameobject` g JOIN `everlake_holiday_twins` t ON t.`guid` = g.`guid`;
DELETE a FROM `gameobject_addon` a JOIN `everlake_holiday_twins` t ON t.`guid` = a.`guid`;
DELETE r FROM `everlake_import_rows` r JOIN `everlake_holiday_twins` t ON t.`guid` = r.`k1` WHERE r.`tbl` IN ('gameobject', 'gameobject_addon', 'game_event_gameobject');
DELETE o FROM `gameobject` o JOIN `everlake_holiday_twins` t ON t.`guid` = o.`guid`;
DROP TEMPORARY TABLE IF EXISTS `everlake_holiday_twins`;

COMMIT;
