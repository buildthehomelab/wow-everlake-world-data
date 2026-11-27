-- Digestible Research (95790, Alliance, ends at Curator Thorius 8256): the quest had no giver on the realm (tracker
-- quest gaps, 2026-11-26). 2026_11_26_96_world_everlake_digestible_research_journal.sql: written by hand, not tried in game.
--
-- What the sources give:
--   - Wowhead Forever quest 95790: no starter listed; its one comment: "Quest is given inside the instance, at the start."
--     Its text opens "<This journal seems to have been torn to shreds ... a field journal of one of the unfortunate
--     Explorers' League adventurers. Chew marks ... raptors.>": the giver is a journal, not a person.
--   - Icy Veins WoW Forever gameobject 649128 "Partially Digested Journal" (added in 70888): type 2 (quest giver),
--     display 470, scale 1, content tuning 5841, props [0, 29809, 0 ...]. The realm had no template for it.
-- INFERRED (no source links the object to the quest by id, and none gives its position): 649128 is the giver of 95790
-- (the only journal object of that build, named for the quest's 15 Partially Digested Journal Pages, item 271972), and it
-- lies at the start of The Shaper's Terrace (map 3001), 4 yards beside the spot players arrive at (world_safe_locs
-- 1104146, -6117.1 -1246.4 -143.25), at the height of the server's maps (ForeverTracker tools/height.py). Orientation 0,
-- rotation 0 and a 2 min respawn are INFERRED. A look in game should move it where live has it.
--
-- Own guid block 920027310-920027319 (920027310 used). Each row goes in only while missing and is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_26_96_world_everlake_digestible_research_journal.sql';

START TRANSACTION;

-- the object (Icy Veins gameobject 649128), only while the realm has none
SET @EVERLAKE_NEW_T := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 649128);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `ContentTuningId`, `AIName`, `ScriptName`, `VerifiedBuild`)
SELECT 649128, 2, 470, 'Partially Digested Journal', '', '', '', 1, 0, 29809, 5841, '', '', 70888 FROM DUAL WHERE @EVERLAKE_NEW_T;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 649128, 0, 0, 0, @EVERLAKE_FILE, 'icyveins gameobject 649128' FROM DUAL WHERE @EVERLAKE_NEW_T;

-- it gives Digestible Research (INFERRED from the quest text and the Wowhead comment)
SET @EVERLAKE_NEW_S := (SELECT COUNT(*) = 0 FROM `gameobject_queststarter` WHERE `id` = 649128 AND `quest` = 95790)
  AND (SELECT COUNT(*) = 1 FROM `quest_template` WHERE `ID` = 95790);
INSERT INTO `gameobject_queststarter` (`id`, `quest`) SELECT 649128, 95790 FROM DUAL WHERE @EVERLAKE_NEW_S;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_queststarter', 649128, 95790, 0, 0, @EVERLAKE_FILE, 'INFERRED: journal text of 95790; Wowhead quest 95790 comment' FROM DUAL WHERE @EVERLAKE_NEW_S;

-- one spawn at the start of the dungeon, while its guid is free and the object has no spawn but this file's own
SET @EVERLAKE_NEW_G := (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `guid` = 920027310)
  AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 649128 AND (`guid` < 920027310 OR `guid` > 920027319));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920027310, 649128, 3001, 0, 0, '1,201', 0, 0, 0, -1, -6117.1, -1242.4, -143.25, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0
FROM DUAL WHERE @EVERLAKE_NEW_G;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', 920027310, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED: beside the landing (Wowhead quest 95790 comment); height.py' FROM DUAL WHERE @EVERLAKE_NEW_G;

COMMIT;
