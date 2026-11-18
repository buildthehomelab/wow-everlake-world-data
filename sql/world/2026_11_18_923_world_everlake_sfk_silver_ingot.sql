-- Shadowfang Keep: the Enchanted Silver Ingot on the table in Archmage Arugal's room, which had no spawn.
-- 2026_11_18_923_world_everlake_sfk_silver_ingot.sql: written by hand.
--
-- The realm's world has the object (629065, a chest with lock 4287 whose loot 139485 gives the quest item Enchanted
-- Silver Ingot, 267361) but no spawn of it anywhere, so the item cannot be had. Wowhead's Forever page object=629065
-- has no map point; its comments put it on the table next to Arugal at the top of Shadowfang Keep. QuestieDB and the
-- tracker's locator have no point either.
--
-- The point is read from Everlake's own vmaps (tools/height.py of wow-forever-tracker, client 70790's files): a flat
-- surface 1 yard above the floor, about 3 by 1.6 yards, of its own model (a table doodad, FILE000307CB) inside the keep,
-- with smaller models standing on it, 13 yards west of Arugal's spawn (-76.75, 2152.41, 155.79). The ingot is put
-- in its middle, clear of those, at the table's height (156.65). Not checked in game. Respawn as the realm's other
-- dungeon chests with quest loot (604800), difficulty 1 as Arugal's.
-- Guid 920000200: a block of its own after Ta'shkal's (920000100 to 920000108).
-- Nothing is added when the realm already has a spawn of 629065. The added row is recorded in everlake_import_rows.
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added (docs/forever-import.md)';

SET @EVERLAKE_FILE := '2026_11_18_923_world_everlake_sfk_silver_ingot.sql';
SET @EVERLAKE_NOTE := 'Wowhead Forever object=629065 comments 2026-11-18; point from vmaps (table by Arugal)';

START TRANSACTION;

SET @EVERLAKE_INGOT := (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 629065)
                     AND (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 629065)
                     AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` = 920000200);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920000200, 629065, 33, 209, 209, '1', 0, 0, -87.40, 2160.00, 156.65, 0, 0, 0, 0, 1, 604800, 255, 1, '', NULL, 0 FROM DUAL
WHERE @EVERLAKE_INGOT = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` WHERE `guid` = 920000200);

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', 920000200, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL
WHERE @EVERLAKE_INGOT = 1 AND EXISTS (SELECT 1 FROM `gameobject` WHERE `guid` = 920000200 AND `id` = 629065);

COMMIT;
