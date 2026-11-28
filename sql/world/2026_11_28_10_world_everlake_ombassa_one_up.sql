-- Ombassa (263315, rare elite cat, level 41): seven of it stood at once, one of them inside the Rog'mar camp, where
-- it fought the camp's grunts and the players they guard.
-- 2026_11_28_10_world_everlake_ombassa_one_up.sql: written by hand, not tried in game (2026-11-27).
--
-- The realm: seven spawns 974002120-974002126 (the tracker's Forge spawn run 336, 2026-11-25, one per Wowhead Forever
-- map pin), no pool, 2-minute respawn. 974002124 (-7951.1, -4770.6) stands 22 yards from Kreza Darkthorn and beside
-- the Rog'mar Grunts and the inn, so it is always in a fight. Found by a realm-wide check of mobs hostile to players
-- standing within 30 yards of guards and town defenders (the client's FactionTemplate and Faction reputation bases).
-- Live (the tracker's tables): Wowhead Forever pins and EG Link's live sightings (-8208 -4779, -8181 -4785,
-- -8179 -4798) are around the glade west of the camp; a rare is one at a time.
--
-- Rows: 974002124 removed; the other six become one pool, one up at a time, 5 h respawn, as the other Forever rares
-- (2026_11_25_28). Only while the rows are as the Forge left them. Every change is recorded in everlake_import_rows.
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
SET @EVERLAKE_FILE := '2026_11_28_10_world_everlake_ombassa_one_up.sql';
SET @EVERLAKE_NOTE := 'Ombassa one at a time; Wowhead Forever pins + EG Link live sightings west of the Rog''mar camp';

START TRANSACTION;

-- the spot inside the Rog'mar camp
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'removed: Ombassa spot 22 yd from Kreza Darkthorn in the Rog''mar camp'
FROM `creature` c WHERE c.`guid` = 974002124 AND c.`id` = 263315;
DELETE FROM `creature` WHERE `guid` = 974002124 AND `id` = 263315;

-- the other six: one pool, one up, 5 h respawn
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
SELECT 920000205, 1, 'Ombassa (263315) - one of its spots'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `pool_template` WHERE `entry` = 920000205)
  AND EXISTS (SELECT 1 FROM `creature` WHERE `id` = 263315 AND `guid` BETWEEN 974002120 AND 974002126);
INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`)
SELECT 0, c.`guid`, 920000205, 0, 'Ombassa (263315)'
FROM `creature` c
WHERE c.`id` = 263315 AND c.`guid` BETWEEN 974002120 AND 974002126
  AND EXISTS (SELECT 1 FROM `pool_template` WHERE `entry` = 920000205)
  AND NOT EXISTS (SELECT 1 FROM `pool_members` p WHERE p.`type` = 0 AND p.`spawnId` = c.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_template', 920000205, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `pool_template` WHERE `entry` = 920000205;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_members', 0, p.`spawnId`, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE
FROM `pool_members` p WHERE p.`type` = 0 AND p.`poolSpawnId` = 920000205;
UPDATE `creature` SET `spawntimesecs` = 18000
WHERE `id` = 263315 AND `guid` BETWEEN 974002120 AND 974002126 AND `spawntimesecs` = 120;

COMMIT;
