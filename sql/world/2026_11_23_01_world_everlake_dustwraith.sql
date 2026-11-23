-- Dustwraith (10081), the rare of Zul'Farrak: the realm has its template, loot and equipment but no spawn, so
-- Desertwalker Cane (12471), which only it drops, cannot be had (the tracker: "loot of a creature that is not
-- spawned").
-- 2026_11_23_01_world_everlake_dustwraith.sql: checked by hand.
-- One spawn, as AzerothCore and TrinityCore 3.3.5 have it (AzerothCore creature guid 205800): the point, the facing,
-- the one-day respawn, equipment 1, no wandering. The height is the terrain of the realm's own maps there (12.93,
-- ForeverTracker tools/height.py), the same as AzerothCore's. Neither reference world pools it with a stand-in, so it
-- is not pooled here either. spawnDifficulties '1' as the realm's other Zul'Farrak spawns.
-- Source: AzerothCore (AGPL-3.0, github.com/azerothcore/azerothcore-wotlk, db_world creature).
-- Guid 920016007. The added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later
-- fix is a new file. Running it again changes nothing. Not tried in game.
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
SET @EVERLAKE_FILE := '2026_11_23_01_world_everlake_dustwraith.sql';
START TRANSACTION;
SET @EVERLAKE_CS := (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 10081) AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 10081 AND `guid` <> 920016007);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920016007, 10081, 209, 0, 0, '1', 0, 0, 0, -1, 0, 1, 1863.89, 1151.66, 12.93, 0.540263, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM DUAL WHERE @EVERLAKE_CS = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = 920016007);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'AzerothCore creature 205800: only dropper of item 12471' FROM `creature` c
WHERE @EVERLAKE_CS = 1 AND c.`id` = 10081 AND c.`guid` = 920016007;
COMMIT;
