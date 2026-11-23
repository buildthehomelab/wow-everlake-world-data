-- Thirteen open-world creatures that stand far more often than any other world has them: their spots are pooled.
-- 2026_11_22_11_world_everlake_pool_overspawned_creatures.sql: written by hand from the ForeverTracker's Spawn audit of the test realm (2026-11-22).
--
-- The core's 2026_11_02_29 file put AnoCore's spawns back wherever nothing of ours stood within 5 yards, beside the
-- world's own (VMaNGOS') spawns: a second spawn set over the first. The Spawn audit counts, per creature and map, how
-- many stand at one time, against the worlds of VMaNGOS (patch 1.12, db_latest 34aeaa8), AzerothCore (aebaf3e7) and
-- TrinityCore 3.3.5 (TDB335.26091). These thirteen stand more often than in every one of them that has the creature
-- (Eyeless Watcher 22 against 7 in all three, Mudrock Snapjaw 43 against 12). The references' counts only: nothing is
-- copied from them.
--
-- More spots are welcome; too many up at once is the fault. So nothing is removed. Each creature's free spawns on
-- its map (in no pool yet) go into one pool whose limit brings the creature back to the most any reference has:
-- limit = that number, less what its spawns in earlier pools already keep up, at least 1. When one dies and respawns,
-- the core picks the next spot at random among the pool's members, so the creature still turns up on every spot.
-- Left out of the pools, and so always up: a spawn of a world event, one that walks a path (MovementType 2 or a
-- creature_addon path), a formation's member, a linked respawn.
-- Not here: the instance creatures the audit lists (Plagued Gargoyle, Arcane Feedback, Arcane Torrent, Oozeling: a
-- random pool would reshuffle an instance's packs), Mo'grosh Mystic (every spawn already in a pool), and Corrupted
-- Red Whelp (Blackwing Lair's whelp spots lost their other colours: another fault).
--
-- A creature is pooled only while it still has more free spawns than its limit, its pool does not exist and this file
-- never made it. Each added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later
-- fix is a new file. Running it again changes nothing.

SET @EVERLAKE_FILE := '2026_11_22_11_world_everlake_pool_overspawned_creatures.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_spawn_caps`;
CREATE TEMPORARY TABLE `everlake_spawn_caps` (
  `pool` int unsigned NOT NULL PRIMARY KEY,
  `entry` int unsigned NOT NULL,
  `map` smallint unsigned NOT NULL,
  `max_limit` int unsigned NOT NULL,
  `name` varchar(64) NOT NULL,
  `note` varchar(120) NOT NULL
) DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_spawn_caps` (`pool`, `entry`, `map`, `max_limit`, `name`, `note`) VALUES
(920000151, 97, 0, 11, 'Riverpaw Runt', '40 up, references 26; 15 stay up in pools made earlier'),
(920000152, 1179, 0, 1, 'Mo''grosh Enforcer', '17.5 up, references 11; 12.5 stay up in pools made earlier'),
(920000153, 2234, 1, 17, 'Young Reef Crawler', '30 up, references 17'),
(920000154, 2347, 0, 2, 'Wild Gryphon', '6 up, references 2'),
(920000155, 4154, 1, 8, 'Salt Flats Scavenger', '14 up, references 8'),
(920000156, 4355, 1, 2, 'Bloodfen Scytheclaw', '55.9 up, references 35.4; 33.9 stay up in pools made earlier'),
(920000157, 4398, 1, 15, 'Mudrock Burrower', '60.5 up, references 17.5; 2.5 stay up in pools made earlier'),
(920000158, 4400, 1, 12, 'Mudrock Snapjaw', '43 up, references 12'),
(920000159, 8538, 0, 2, 'Unseen Servant', '5 up, references 2'),
(920000160, 8539, 0, 7, 'Eyeless Watcher', '22 up, references 7'),
(920000161, 8889, 0, 1, 'Anvilrage Overseer', '13.5 up, references 7.5; 6.5 stay up in pools made earlier'),
(920000162, 8890, 0, 1, 'Anvilrage Warden', '12.5 up, references 6.5; 6.5 stay up in pools made earlier'),
(920000163, 9683, 1, 1, 'Lar''korwi Mate', '4 up, references 1');

-- The spawns that may be pooled: free, standing all year, not walking a path, not tied to another spawn.
DROP TEMPORARY TABLE IF EXISTS `everlake_spawn_free`;
CREATE TEMPORARY TABLE `everlake_spawn_free` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY,
  `pool` int unsigned NOT NULL,
  KEY (`pool`)
);
INSERT INTO `everlake_spawn_free` (`guid`, `pool`)
SELECT c.`guid`, s.`pool` FROM `everlake_spawn_caps` s
JOIN `creature` c ON c.`id` = s.`entry` AND c.`map` = s.`map`
WHERE c.`MovementType` <> 2
  AND NOT EXISTS (SELECT 1 FROM `pool_members` p WHERE p.`type` = 0 AND p.`spawnId` = c.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `game_event_creature` e WHERE e.`guid` = c.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `creature_addon` a WHERE a.`guid` = c.`guid` AND a.`PathId` <> 0)
  AND NOT EXISTS (SELECT 1 FROM `creature_formations` f WHERE f.`memberGUID` = c.`guid` OR f.`leaderGUID` = c.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `linked_respawn` l WHERE l.`linkType` = 0 AND (l.`guid` = c.`guid` OR l.`linkedGuid` = c.`guid`));

-- Drop the creatures that are no longer as this file was written against, or were pooled already (a second run).
DELETE s FROM `everlake_spawn_caps` s
WHERE (SELECT COUNT(*) FROM `everlake_spawn_free` f WHERE f.`pool` = s.`pool`) <= s.`max_limit`
   OR EXISTS (SELECT 1 FROM `pool_template` t WHERE t.`entry` = s.`pool`)
   OR EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'pool_template' AND r.`k1` = s.`pool`);

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
SELECT s.`pool`, s.`max_limit`, CONCAT(s.`name`, ' (', s.`entry`, ', map ', s.`map`, '): ', s.`max_limit`, ' of its free spots at a time')
FROM `everlake_spawn_caps` s;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_template', s.`pool`, 0, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_spawn_caps` s;

INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`)
SELECT 0, f.`guid`, f.`pool`, 0, s.`name` FROM `everlake_spawn_free` f
JOIN `everlake_spawn_caps` s ON s.`pool` = f.`pool`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_members', 0, f.`guid`, 0, 0, @EVERLAKE_FILE, CONCAT('spot pool ', f.`pool`) FROM `everlake_spawn_free` f
JOIN `everlake_spawn_caps` s ON s.`pool` = f.`pool`;

DROP TEMPORARY TABLE IF EXISTS `everlake_spawn_free`;
DROP TEMPORARY TABLE IF EXISTS `everlake_spawn_caps`;

COMMIT;
