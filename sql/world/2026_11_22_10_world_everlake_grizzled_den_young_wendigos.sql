-- Young Wendigos at the Grizzled Den's mouth (Dun Morogh): 4 of the 12 spots stand at a time.
-- 2026_11_22_10_world_everlake_grizzled_den_young_wendigos.sql: written by hand.
--
-- 12 Young Wendigos (1134) stand in about 35 by 60 yards in front of the Grizzled Den: in game a wall of them (the
-- realm's owner, 2026-11-22, live realm). Four are the world's own spawns (guids 20003553, 20003555, 20003556,
-- 20003581). The other eight came with the core's 2026_11_02_29 file, which put AnoCore's spawns back wherever nothing
-- of ours stood within 5 yards: a second spawn set beside the first.
-- VMaNGOS (patch 1.12, db_latest 34aeaa8), AzerothCore (aebaf3e7) and TrinityCore 3.3.5 (TDB335.26091) all hold 4
-- Young Wendigos here and 5 on the map. Their counts only: nothing is copied from them.
--
-- More spots are welcome; too many up at once is the fault. So nothing is removed: the 12 spawns go into one pool
-- (920000150) that keeps 4 up. When one dies and respawns, the core picks the next spot at random among the pool's
-- members, so they still turn up on all 12 spots. The two Young Wendigos away from the den (guids 3137, 20003126)
-- and the Wendigos are untouched.
--
-- Only spawns that still hold Young Wendigo on map 0 and are in no pool yet. Each added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing.

SET @EVERLAKE_FILE := '2026_11_22_10_world_everlake_grizzled_den_young_wendigos.sql';

START TRANSACTION;

SET @EVERLAKE_POOL := (SELECT COUNT(*) = 0 FROM `pool_template` WHERE `entry` = 920000150)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'pool_template' AND `k1` = 920000150);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
SELECT 920000150, 4, 'Young Wendigo (Grizzled Den mouth): 4 of 12 spots at a time' FROM DUAL WHERE @EVERLAKE_POOL = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_template', 920000150, 0, 0, 0, @EVERLAKE_FILE, '4 at a time as in VMaNGOS, AzerothCore and TrinityCore 3.3.5; 12 spots kept' FROM DUAL WHERE @EVERLAKE_POOL = 1;

INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`)
SELECT 0, c.`guid`, 920000150, 0, 'Young Wendigo (Grizzled Den mouth)' FROM `creature` c
WHERE @EVERLAKE_POOL = 1 AND c.`id` = 1134 AND c.`map` = 0
  AND c.`guid` IN (3255, 3261, 3262, 3548, 3551, 3554, 3558, 3583, 20003553, 20003555, 20003556, 20003581)
  AND NOT EXISTS (SELECT 1 FROM `pool_members` p WHERE p.`type` = 0 AND p.`spawnId` = c.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_members', 0, p.`spawnId`, 0, 0, @EVERLAKE_FILE, 'Young Wendigo rotation' FROM `pool_members` p
WHERE @EVERLAKE_POOL = 1 AND p.`type` = 0 AND p.`poolSpawnId` = 920000150;

COMMIT;
