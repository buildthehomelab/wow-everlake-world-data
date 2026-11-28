-- The Lyn the Ignored chain: the Black Tome in Shadowfang Keep (map 33) and the Leyline Focus at Ambermill in Silverpine
-- Forest (map 0). The realm had both templates (and the tome's loot 141991 -> item 276561) but spawned neither.
-- 2026_11_29_20_world_everlake_black_tome_leyline_focus.sql: written by hand, not tried in game.
--
-- What the sources give:
--   - ForeverDB.net SpecialQuests "lyn-the-ignored": "Kill Arugal in Shadowfang Keep and take the Black Tome from the
--     room behind him", then "Use the Black Tome at the Ambermill Leyline Focus in Silverpine Forest" (uiMap 1421,
--     63.4, 64.3), where it becomes the Tome of Dalaran (275989), which calls Lyn the Ignored in City of Dalaran.
--   - ForeverDB.net Loot: item 276561 in Archmage Arugal's (4275) loot at 22% of 27 looted kills.
--   - EG Link: live players looted Black Tome 659376 (item 276561), no position recorded; Leyline Focus 672323 is a
--     spell focus (type 8, focus 2327).
--   - No core script or SQL spawns either object.
-- Black Tome, INFERRED: 6 yards behind Arugal (his spawn faces 2.5 rad) at (-71.94, 2148.82), on the navmesh floor of
-- his platform (155.76). The walkable floor ends about 8 yards behind him, so no room past him is reachable there.
-- Leyline Focus: ForeverDB's map point is (-133.73, 787.2) in world terms, 0.7 yards from Archmage Ataeric (-133.0, 787.2,
-- 67.5) inside the Ambermill building. Of the four floors there (61.1 ground, 67.4, 79.3, 91.2) it takes 67.38, Ataeric's
-- floor (INFERRED). Orientation, rotation and respawn times are INFERRED. Lyn the Ignored (247032) is a standing spawn on
-- this realm, so the chain is optional here.
--
-- Own guid block 920027910-920027919 (920027910-920027911 used). Each spawn is added only while its guid is free and
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
SET @EVERLAKE_FILE := '2026_11_29_20_world_everlake_black_tome_leyline_focus.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_lyn_chain`;
CREATE TEMPORARY TABLE `everlake_lyn_chain` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY, `id` int unsigned NOT NULL, `map` smallint unsigned NOT NULL,
  `diff` varchar(100) NOT NULL, `x` float NOT NULL, `y` float NOT NULL, `z` float NOT NULL, `o` float NOT NULL,
  `respawn` int NOT NULL, `note` varchar(255) NOT NULL, `ok` tinyint NOT NULL DEFAULT 0);
INSERT INTO `everlake_lyn_chain` (`guid`, `id`, `map`, `diff`, `x`, `y`, `z`, `o`, `respawn`, `note`) VALUES
(920027910, 659376, 33, '1', -71.94, 2148.82, 155.76, 2.5, 7200, 'INFERRED: Black Tome 6 yd behind Arugal (ForeverDB SpecialQuests "room behind him"); navmesh floor'),
(920027911, 672323, 0, '0', -133.73, 787.2, 67.38, 0, 300, 'Leyline Focus at ForeverDB SpecialQuests point uiMap 1421 63.4,64.3; floor 67.38 INFERRED');
-- a spawn goes in while its guid is free, the template exists and the object has no spawn but this file's own
UPDATE `everlake_lyn_chain` s SET s.`ok` = 1
WHERE EXISTS (SELECT 1 FROM `gameobject_template` t WHERE t.`entry` = s.`id`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`id` = s.`id` AND (g.`guid` < 920027910 OR g.`guid` > 920027919));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, s.`map`, 0, 0, s.`diff`, 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, s.`o`, 0, 0, SIN(s.`o` / 2), COS(s.`o` / 2), s.`respawn`, 255, 1, '', NULL, 0
FROM `everlake_lyn_chain` s WHERE s.`ok` = 1 ORDER BY s.`guid`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', s.`guid`, 0, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_lyn_chain` s WHERE s.`ok` = 1;
DROP TEMPORARY TABLE `everlake_lyn_chain`;

COMMIT;
