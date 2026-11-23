-- Skyhoppers in Valanaar (Zephras Isle): one per spot instead of two.
-- 2026_11_22_08_world_everlake_zephras_skyhopper_pools.sql: written by hand.
--
-- The fork's Zephras Isle spawns (map 2991) hold two creatures named Skyhopper, 251314 (46 spawns) and 251727 (55).
-- 34 spots hold one of each, 0 to 0.8 yards apart, so the city showed two Skyhoppers standing in each other on most
-- spots (checked on the test realm's world, 2026-11-22). Live shows both entries: Icy Veins has the same player
-- sighting points for both with about the same number of reports, and quest 93949 "Bugged" counts 251727 while 251314
-- gives kill credit for it. A spot there holds one Skyhopper that comes back as either entry; the packet captures the
-- fork's spawns were made from kept both. INFERRED from that: nothing records the spot's rule itself.
--
-- This puts each of the 34 doubled spots in a pool of its own (920000110 to 920000143) that keeps one of its two
-- spawns up, picked at random on each respawn. Nothing is removed. The 33 Skyhoppers with no twin within 6 yards stay
-- as they are: 101 spawned at once becomes 67.
--
-- A spot is pooled only while both spawns still hold their entries and neither is in a pool. Each added row is
-- recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it
-- again changes nothing.

SET @EVERLAKE_FILE := '2026_11_22_08_world_everlake_zephras_skyhopper_pools.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_skyhopper_spots`;
CREATE TEMPORARY TABLE `everlake_skyhopper_spots` (
  `pool` int unsigned NOT NULL PRIMARY KEY,
  `guid_a` bigint unsigned NOT NULL,  -- 251314
  `guid_b` bigint unsigned NOT NULL   -- 251727
);
INSERT INTO `everlake_skyhopper_spots` (`pool`, `guid_a`, `guid_b`) VALUES
(920000110, 21100391, 21100850),
(920000111, 21100392, 21100848),
(920000112, 21100393, 21100852),
(920000113, 21100395, 21100853),
(920000114, 21100396, 21100883),
(920000115, 21100397, 21100887),
(920000116, 21100398, 21100888),
(920000117, 21100402, 21100858),
(920000118, 21100405, 21100882),
(920000119, 21100406, 21100881),
(920000120, 21100407, 21100886),
(920000121, 21100408, 21100884),
(920000122, 21100409, 21100885),
(920000123, 21100410, 21100880),
(920000124, 21100412, 21100863),
(920000125, 21100413, 21100864),
(920000126, 21100417, 21100869),
(920000127, 21100418, 21100896),
(920000128, 21100419, 21100895),
(920000129, 21100420, 21100874),
(920000130, 21100421, 21100875),
(920000131, 21100422, 43000220),
(920000132, 21100423, 21100876),
(920000133, 21100425, 21100870),
(920000134, 21100426, 21100871),
(920000135, 21100430, 21100865),
(920000136, 21100432, 21100889),
(920000137, 21100433, 43000223),
(920000138, 21100435, 21100855),
(920000139, 21100436, 21100859),
(920000140, 21100437, 21100854),
(920000141, 21100439, 21100872),
(920000142, 43000158, 21100890),
(920000143, 43000159, 21100849);

-- Drop the spots that are no longer as this file was written against, or were pooled already (a second run).
DELETE s FROM `everlake_skyhopper_spots` s
WHERE NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid_a` AND c.`id` = 251314 AND c.`map` = 2991)
   OR NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid_b` AND c.`id` = 251727 AND c.`map` = 2991)
   OR EXISTS (SELECT 1 FROM `pool_members` p WHERE p.`type` = 0 AND p.`spawnId` IN (s.`guid_a`, s.`guid_b`))
   OR EXISTS (SELECT 1 FROM `pool_template` t WHERE t.`entry` = s.`pool`)
   OR EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'pool_template' AND r.`k1` = s.`pool`);

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
SELECT s.`pool`, 1, CONCAT('Skyhopper (Valanaar): one of spawns ', s.`guid_a`, ' / ', s.`guid_b`)
FROM `everlake_skyhopper_spots` s;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_template', s.`pool`, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED: one Skyhopper per doubled spot (251314 or 251727)'
FROM `everlake_skyhopper_spots` s;

INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`)
SELECT 0, s.`guid_a`, s.`pool`, 0, 'Skyhopper 251314 (Valanaar)' FROM `everlake_skyhopper_spots` s;
INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`)
SELECT 0, s.`guid_b`, s.`pool`, 0, 'Skyhopper 251727 (Valanaar)' FROM `everlake_skyhopper_spots` s;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_members', 0, s.`guid_a`, 0, 0, @EVERLAKE_FILE, 'Skyhopper spot pool' FROM `everlake_skyhopper_spots` s;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_members', 0, s.`guid_b`, 0, 0, @EVERLAKE_FILE, 'Skyhopper spot pool' FROM `everlake_skyhopper_spots` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_skyhopper_spots`;

COMMIT;
