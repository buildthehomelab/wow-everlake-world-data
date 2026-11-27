-- Crystalline Elements (95928, Mayena Earthseeker): the four crystal fragments in The Shaper's Terrace (map 3001), which
-- the realm had templates and loot for but never spawned (tracker quest gaps, 2026-11-26).
-- 2026_11_26_95_world_everlake_crystalline_elements_fragments.sql: written by hand, not tried in game.
--
-- What the sources give:
--   - Wowhead Forever item pages 271894/271898/271902/271912: each crystal "is looted from" its Fragment object
--     (649099 Fiery, 649097 Charged, 649100 Noxious, 649103 Moist); the realm's templates and loot already match.
--   - Icy Veins quest 95928, Mayena's progress text: a fellow "reports seeing 'elemental raptors'".
--   - Wowhead Forever NPC comments: the four elemental raptors are summoned at a console fed with Power Crystals of one
--     colour: Cinder (261974) red, Bolt (262081) yellow, Snowtalon (262297) blue, Vitrix (272561) green. The core script
--     (classic_instance_shapers_terrace) has the same pairs on the realm's four Archival Panels 650303 (red),
--     673520 (yellow), 672255 (blue), 672256 (green), and summons each raptor 5 yards in front of its panel.
-- No source the tracker has gives a position for the fragments (Wowhead shows them only as "in a dungeon"; Questie,
-- NorgannonDB, Icy Veins and EG Link have no spawn points). INFERRED: each fragment stands by the panel of the raptor of
-- its element (Fiery = red/Cinder, Charged = yellow/Bolt, Moist = blue/Snowtalon, Noxious = green/Vitrix), 4 yards to
-- the panel's side so it does not sit where the raptor appears, at the height of the server's maps (ForeverTracker
-- tools/height.py). Orientation 0, rotation 0 and a 30 s respawn are INFERRED. Live may instead drop the fragment when
-- the raptor dies; a look in game should move them where live has them.
--
-- Own guid block 920027300-920027309 (920027300-920027303 used). Each spawn is added only while its guid is free and
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
SET @EVERLAKE_FILE := '2026_11_26_95_world_everlake_crystalline_elements_fragments.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_cef_stage`;
CREATE TEMPORARY TABLE `everlake_cef_stage` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY, `id` int unsigned NOT NULL, `map` smallint unsigned NOT NULL,
  `diff` varchar(100) NOT NULL, `x` float NOT NULL, `y` float NOT NULL, `z` float NOT NULL, `respawn` int NOT NULL,
  `note` varchar(255) NOT NULL, `ok` tinyint NOT NULL DEFAULT 0);
INSERT INTO `everlake_cef_stage` (`guid`, `id`, `map`, `diff`, `x`, `y`, `z`, `respawn`, `note`) VALUES
(920027300, 649099, 3001, '1,201', -5901.6, -859.4, 112.75, 30, 'INFERRED: Fiery Crystal Fragment by the red panel 650303 (Cinder, Wowhead npc 261974 comment); height.py'),
(920027301, 649097, 3001, '1,201', -5929.9, -1224.7, 9.22, 30, 'INFERRED: Charged Crystal Fragment by the yellow panel 673520 (Bolt, Wowhead npc 262081 comment); height.py'),
(920027302, 649103, 3001, '1,201', -5684.5, -606.8, 13.76, 30, 'INFERRED: Moist Crystal Fragment by the blue panel 672255 (Snowtalon, Wowhead npc 262297 comment); height.py'),
(920027303, 649100, 3001, '1,201', -5517.5, -843.5, 22.14, 30, 'INFERRED: Noxious Crystal Fragment by the green panel 672256 (Vitrix, Wowhead npc 272561 comment); height.py');
-- a spawn goes in while its guid is free, the template exists and the object has no spawn but this file's own
UPDATE `everlake_cef_stage` s SET s.`ok` = 1
WHERE EXISTS (SELECT 1 FROM `gameobject_template` t WHERE t.`entry` = s.`id`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`id` = s.`id` AND (g.`guid` < 920027300 OR g.`guid` > 920027309));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, s.`map`, 0, 0, s.`diff`, 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, s.`respawn`, 255, 1, '', NULL, 0
FROM `everlake_cef_stage` s WHERE s.`ok` = 1 ORDER BY s.`guid`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', s.`guid`, 0, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_cef_stage` s WHERE s.`ok` = 1;
DROP TEMPORARY TABLE `everlake_cef_stage`;

COMMIT;
