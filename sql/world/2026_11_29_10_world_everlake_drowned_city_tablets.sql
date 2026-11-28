-- The Drowned City (map 2970): the four Tablets of I'lalai, which the realm had templates and loot for but never
-- spawned, so "The Drowned City" (95775) and "Take Two With Water" (95787) could not be finished.
-- 2026_11_29_10_world_everlake_drowned_city_tablets.sql: written by hand, not tried in game.
--
-- What the sources give:
--   - EG Link object_details 642943-642946: The First/Second/Third/Fourth Tablet of I'lalai, type 3, quest items
--     270308/270309/270310/270311; the realm's templates and loot 140217-140220 already match.
--   - EG Link loot: live players looted each tablet 2-3 times, so they are spawned on live. The records have no
--     position (EG Link keeps loot positions only on maps 0, 1 and 2991).
--   - Quest 95775 text (EG Link): "the ruins on the other side of the cavern the naga are guarding ... Enter the ruins
--     and gather etchings of any tablets you find there".
--   - No core script or SQL spawns them (wow-trinitycore-everlake classic_instance_the_drowned_city has none).
-- No source the tracker has gives a position (Wowhead's pages have no pins; Questie, NorgannonDB and Icy Veins have no
-- spawn points). INFERRED: one tablet in each of the four groups of the drowned troll ruins past the Brinescale naga
-- (Risen Sentries, Profane Necromancers, Champions of the Deep), a few yards from the pack, on the navmesh floor there.
-- Which tablet goes where, orientation 0, rotation 0 and a 30 s respawn are INFERRED. A look in game should move them
-- where live has them.
--
-- Own guid block 920027900-920027909 (920027900-920027903 used). Each spawn is added only while its guid is free and
-- the object has no spawn yet, and recorded in everlake_import_rows. Never edit this file once it is deployed: a later
-- fix is a new file. Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_29_10_world_everlake_drowned_city_tablets.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_tdc_tablets`;
CREATE TEMPORARY TABLE `everlake_tdc_tablets` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY, `id` int unsigned NOT NULL, `map` smallint unsigned NOT NULL,
  `diff` varchar(100) NOT NULL, `x` float NOT NULL, `y` float NOT NULL, `z` float NOT NULL, `respawn` int NOT NULL,
  `note` varchar(255) NOT NULL, `ok` tinyint NOT NULL DEFAULT 0);
INSERT INTO `everlake_tdc_tablets` (`guid`, `id`, `map`, `diff`, `x`, `y`, `z`, `respawn`, `note`) VALUES
(920027900, 642943, 2970, '1,201', -13422.0, 2648.0, -31.52, 30, 'INFERRED: First Tablet by the south ruin pack (EG Link loot, no position); navmesh floor'),
(920027901, 642944, 2970, '1,201', -13428.0, 2765.0, -31.37, 30, 'INFERRED: Second Tablet by the middle ruin pack (EG Link loot, no position); navmesh floor'),
(920027902, 642945, 2970, '1,201', -13385.0, 2905.0, -30.55, 30, 'INFERRED: Third Tablet by the north ruin pack (EG Link loot, no position); navmesh floor'),
(920027903, 642946, 2970, '1,201', -13185.0, 2915.0, -32.76, 30, 'INFERRED: Fourth Tablet by the far east ruin pack (EG Link loot, no position); navmesh floor');
-- a spawn goes in while its guid is free, the template exists and the object has no spawn but this file's own
UPDATE `everlake_tdc_tablets` s SET s.`ok` = 1
WHERE EXISTS (SELECT 1 FROM `gameobject_template` t WHERE t.`entry` = s.`id`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`id` = s.`id` AND (g.`guid` < 920027900 OR g.`guid` > 920027909));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, s.`map`, 0, 0, s.`diff`, 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, s.`respawn`, 255, 1, '', NULL, 0
FROM `everlake_tdc_tablets` s WHERE s.`ok` = 1 ORDER BY s.`guid`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', s.`guid`, 0, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_tdc_tablets` s WHERE s.`ok` = 1;
DROP TEMPORARY TABLE `everlake_tdc_tablets`;

COMMIT;
