-- Five more Ogre Miners (260995) in their mine in the Riverglades, for Rise Up! (95432, "Recruit 5 Ogre Miners").
-- 2026_11_25_11_world_everlake_ogre_miner_spawns.sql: written by hand, not tried in game.
--
-- 2026_11_25_10 gave the miner its client proxy credit (260417), but the realm spawns one miner (920010021) and the
-- quest needs five. EG Link saw miners at 12 points in builds 70938, 70959 and 71037 (creatures.json positions, map 0);
-- Icy Veins' map points (22, from loot) cover the same ground. The new spawns are the EG Link points at least 10 yards
-- from the realm's miner and from each other. Their heights are the mine's floor from the realm's vmaps (ForeverTracker
-- tools/height.py, hint 180, the existing miner's height): 179.7 to 181.6, the same floor as 920010021.
-- Orientation 0 is INFERRED. Respawn 300 s and wander 5 yards are copied from 920010021.
--
-- Guids: creatures 920018010-920018014, in this batch's block (920018000-920018099).
-- Only added while the realm has no miner other than 920010021 and these. Each added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again
-- changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_25_11_world_everlake_ogre_miner_spawns.sql';
START TRANSACTION;

SET @EVERLAKE_OM := (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 260995)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 260995 AND `guid` <> 920010021 AND `guid` NOT BETWEEN 920018010 AND 920018014);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 260995, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 5, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM (
  SELECT 920018010 AS `guid`, -7624.1 AS `x`, -3212.2 AS `y`, 181.57 AS `z`
  UNION ALL SELECT 920018011, -7599.1, -3184.4, 179.72
  UNION ALL SELECT 920018012, -7577.9, -3195.3, 181.41
  UNION ALL SELECT 920018013, -7561.3, -3205.2, 180.37
  UNION ALL SELECT 920018014, -7595.3, -3197.1, 181.04
) s
WHERE @EVERLAKE_OM = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'EG Link creatures.json positions (70938-71037); height.py mine floor'
FROM `creature` c WHERE @EVERLAKE_OM = 1 AND c.`id` = 260995 AND c.`guid` BETWEEN 920018010 AND 920018014;

COMMIT;
