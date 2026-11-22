-- Cookie's Feast in Wetlands rotates: 4 of its 16 spots stand at a time.
-- 2026_11_21_103_world_everlake_cookies_feast_pool.sql: written by hand.
--
-- 2026_11_19_937_world_everlake_quest_item_objects.sql spawned Cookie's Feast (612073, holds Expiring Crab Cake) on all
-- 16 of the points Wowhead's Forever map gives for it that had a readable height (it has 17 sightings), 10 of them
-- across Menethil Harbor, all standing at once: a player saw a town full of feasts. Wowhead's points are where players
-- saw it over time, not how many stand at once (NorgannonDB records a single Wetlands point). This puts the 16 spawns
-- in one pool (920000101) that keeps 4 of them up: when one is looted and respawns, the core picks the next spot at
-- random among the pool's members, so the feast moves around the sightings. How many live shows at once is not
-- recorded: 4 is INFERRED.
--
-- Only spawns that still hold Cookie's Feast, were added by file 937 and are in no pool yet. Each added row is recorded
-- in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again
-- changes nothing.

SET @EVERLAKE_FILE := '2026_11_21_103_world_everlake_cookies_feast_pool.sql';

START TRANSACTION;

SET @EVERLAKE_POOL := (SELECT COUNT(*) = 0 FROM `pool_template` WHERE `entry` = 920000101)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'pool_template' AND `k1` = 920000101);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
SELECT 920000101, 4, 'Cookie''s Feast (Wetlands): 4 of 16 spots at a time' FROM DUAL WHERE @EVERLAKE_POOL = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_template', 920000101, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED: 4 at a time, 16 Wowhead sightings' FROM DUAL WHERE @EVERLAKE_POOL = 1;

INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`)
SELECT 1, g.`guid`, 920000101, 0, 'Cookie''s Feast (Wetlands)' FROM `gameobject` g
WHERE @EVERLAKE_POOL = 1 AND g.`id` = 612073 AND g.`guid` BETWEEN 920007127 AND 920007142
  AND EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject' AND r.`k1` = g.`guid`
              AND r.`file` = '2026_11_19_937_world_everlake_quest_item_objects.sql')
  AND NOT EXISTS (SELECT 1 FROM `pool_members` p WHERE p.`type` = 1 AND p.`spawnId` = g.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_members', 1, p.`spawnId`, 0, 0, @EVERLAKE_FILE, 'Cookie''s Feast rotation' FROM `pool_members` p
WHERE @EVERLAKE_POOL = 1 AND p.`type` = 1 AND p.`poolSpawnId` = 920000101;

COMMIT;
