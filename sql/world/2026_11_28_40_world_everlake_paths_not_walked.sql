-- Three spawns that have a waypoint path but never walk it.
-- 2026_11_28_40_world_everlake_paths_not_walked.sql: written by hand, not tried in game (2026-11-28).
--
-- The core picks a creature's movement from its spawn's MovementType (CreatureAISelector::SelectMovementGenerator); a
-- creature_addon PathId is walked only with WAYPOINT_MOTION_TYPE (2). These three carry a path with nodes, but their
-- MovementType is 0 (idle), and no script of theirs starts the path, so they stand still:
--   William 2533 (20079720, path 800797200, 82 nodes), Elaadrin Evengale 253847 (21101331, path 211013310, 6 nodes,
--   from a live sniff) and a Windshaper Shaman 256618 (21101578, path 211015780, 6 nodes, from a live sniff).
-- Rows: MovementType 2, only while it is 0 and the path still has nodes. Every change is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.
--
-- Not changed: 45 spawns set to walk a path (MovementType 2) that have none (13 Drunken Bruisers, Moonrage worgen,
-- Brood of Nozdormu, Highperch Soarers, Soaring Razorbeaks, Blackrock Drakes and others): no source in the tracker has
-- their routes, so they stay as they are (the core leaves them standing).

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
SET @EVERLAKE_FILE := '2026_11_28_40_world_everlake_paths_not_walked.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_walk`;
CREATE TEMPORARY TABLE `everlake_walk` (`guid` BIGINT UNSIGNED NOT NULL PRIMARY KEY, `id` INT UNSIGNED NOT NULL, `path` INT UNSIGNED NOT NULL);
INSERT INTO `everlake_walk` VALUES (20079720, 2533, 800797200), (21101331, 253847, 211013310), (21101578, 256618, 211015780);
DELETE w FROM `everlake_walk` w
WHERE NOT EXISTS (SELECT 1 FROM `creature` c JOIN `creature_addon` a ON a.`guid` = c.`guid`
    WHERE c.`guid` = w.`guid` AND c.`id` = w.`id` AND c.`MovementType` = 0 AND a.`PathId` = w.`path`)
   OR NOT EXISTS (SELECT 1 FROM `waypoint_path_node` n WHERE n.`PathId` = w.`path`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', w.`guid`, 0, 0, 0, @EVERLAKE_FILE, CONCAT('MovementType 0 -> 2: walks its path ', w.`path`) FROM `everlake_walk` w;
UPDATE `creature` c JOIN `everlake_walk` w ON w.`guid` = c.`guid` SET c.`MovementType` = 2;
DROP TEMPORARY TABLE `everlake_walk`;

COMMIT;
