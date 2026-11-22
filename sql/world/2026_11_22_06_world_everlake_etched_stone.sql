-- The Etched Stone (668004), the "Large rock rubbing" of quest 97663 Supplies and Studies: the realm has its template
-- but no spawn, so the quest cannot be finished (the tracker: "object 668004 not spawned"). The giver 269647, the small
-- rubbing stone 668003 and the drop 278515 are all on the realm already.
-- Three spawns in the Badlands at the points the ForeverTracker spawn locator worked out for it on 2026-11-22 (from
-- players' recorded positions; height and facing from the realm's maps, height.py), a short walk north of the small
-- stone 668003 (-6901 -2863).
-- 2026_11_22_06_world_everlake_etched_stone.sql: checked by hand.
-- Respawn 120 s INFERRED, as file 2026_11_22_02. Guids 920015326-920015328, in the quest-object block (920015000-920015999).
-- Each added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing. Not tried in game.
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
SET @EVERLAKE_FILE := '2026_11_22_06_world_everlake_etched_stone.sql';
START TRANSACTION;
SET @EVERLAKE_GS := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 668004) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 668004 AND `guid` NOT BETWEEN 920015326 AND 920015328);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 668004, 0, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, s.`o`, 0, 0, s.`r2`, s.`r3`, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920015326 AS `guid`, -6882.92 AS `x`, -2785.62 AS `y`, 242.26 AS `z`, 3.118 AS `o`, 0.999930 AS `r2`, 0.011796 AS `r3`
  UNION ALL
  SELECT 920015327 AS `guid`, -6907.80 AS `x`, -2785.62 AS `y`, 242.38 AS `z`, 0.016 AS `o`, 0.008000 AS `r2`, 0.999968 AS `r3`
  UNION ALL
  SELECT 920015328 AS `guid`, -6896.19 AS `x`, -2798.05 AS `y`, 242.05 AS `z`, 1.144 AS `o`, 0.541315 AS `r2`, 0.840820 AS `r3`
) s WHERE @EVERLAKE_GS = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'ForeverTracker spawn locator 2026-11-22: quest 97663 objective' FROM `gameobject` g WHERE @EVERLAKE_GS = 1 AND g.`id` = 668004 AND g.`guid` BETWEEN 920015326 AND 920015328;
COMMIT;
