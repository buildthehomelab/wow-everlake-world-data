-- Young Wendigos at the Grizzled Den's mouth (Dun Morogh): 6 of the 12 spots stand at a time.
-- 2026_11_22_10_world_everlake_grizzled_den_young_wendigos.sql: written by hand.
--
-- 12 Young Wendigos (1134) stand in about 35 by 60 yards in front of the Grizzled Den, with 9 Wendigos beside them.
-- The 12 spots are Classic's own, one for one (QuestieDB and NorgannonDB list the same 12 points), and nothing stands
-- twice on a spot. In game it reads as a wall of them: the realm's owner asked for fewer (2026-11-22, live realm).
-- This is the realm's own choice, not a recorded fact about live: Wowhead's Forever map marks 9 points here and no
-- source says how many stand at once.
--
-- This puts the 12 spawns in one pool (920000150) that keeps 6 up: when one dies and respawns, the core picks the next
-- spot at random among the pool's members, so they still turn up on all 12 spots. Nothing is removed. The two Young
-- Wendigos away from the den (guids 3137, 20003126) and the Wendigos are untouched.
--
-- Only spawns that still hold Young Wendigo on map 0 and are in no pool yet. Each added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing.

SET @EVERLAKE_FILE := '2026_11_22_10_world_everlake_grizzled_den_young_wendigos.sql';

START TRANSACTION;

SET @EVERLAKE_POOL := (SELECT COUNT(*) = 0 FROM `pool_template` WHERE `entry` = 920000150)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'pool_template' AND `k1` = 920000150);
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
SELECT 920000150, 6, 'Young Wendigo (Grizzled Den mouth): 6 of 12 spots at a time' FROM DUAL WHERE @EVERLAKE_POOL = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_template', 920000150, 0, 0, 0, @EVERLAKE_FILE, 'Realm choice: 6 at a time, 12 Classic spots' FROM DUAL WHERE @EVERLAKE_POOL = 1;

INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`)
SELECT 0, c.`guid`, 920000150, 0, 'Young Wendigo (Grizzled Den mouth)' FROM `creature` c
WHERE @EVERLAKE_POOL = 1 AND c.`id` = 1134 AND c.`map` = 0
  AND c.`guid` IN (3255, 3261, 3262, 3548, 3551, 3554, 3558, 3583, 20003553, 20003555, 20003556, 20003581)
  AND NOT EXISTS (SELECT 1 FROM `pool_members` p WHERE p.`type` = 0 AND p.`spawnId` = c.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_members', 0, p.`spawnId`, 0, 0, @EVERLAKE_FILE, 'Young Wendigo rotation' FROM `pool_members` p
WHERE @EVERLAKE_POOL = 1 AND p.`type` = 0 AND p.`poolSpawnId` = 920000150;

COMMIT;
