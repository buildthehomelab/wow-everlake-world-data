-- Two quest objects for Incomplete quests, from Icy Veins' WoW Forever database (https://db.icy-veins.com/wow-forever/:
-- template data, who takes the quest and a map point, recorded by players' addons) and Wowhead's WoW Forever object page
-- (https://www.wowhead.com/forever, read 2026-11-20 through the tracker's kept pages: map point).
-- 2026_11_20_34_world_everlake_quest_objects_wayfinder_etched_stone.sql: written from public data by a script, checked by hand.
--
-- Argent Wayfinder (668183), quest-giver object: takes quest 7790 River Ends (the tracker: "No quest ender"). Template
--   from Icy Veins where the realm has none, one spawn at Icy Veins' point (Eastern Plaguelands 4.04 33.10, 48 reports,
--   by the Thondroril River the quest names) = map 0 2742.80 -2430.05, terrain 56.79; gameobject_questender row.
-- Etched Stone (668003): the realm has its template (quest 97663 Supplies and Studies) but no spawn. One spawn at Wowhead's
--   point (Badlands 31.5 61) = map 0 -6901.17 -2862.73, terrain 241.89.
-- Heights from the realm's maps and vmaps (ForeverTracker tools/height.py). Orientation and rotation 0, respawn 120 s INFERRED.
-- Guids: objects 920015285-286, in the quest-object block (920015000-920015999).
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
SET @EVERLAKE_FILE := '2026_11_20_34_world_everlake_quest_objects_wayfinder_etched_stone.sql';
START TRANSACTION;

-- Argent Wayfinder (668183).
SET @EVERLAKE_G := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 668183);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 668183, 2, 128669, 'Argent Wayfinder', '', '', '', 1, 0, 30297, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 668183, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=668183' FROM DUAL WHERE @EVERLAKE_G = 1;
SET @EVERLAKE_E := EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 7790) AND NOT EXISTS (SELECT 1 FROM `gameobject_questender` WHERE `id` = 668183 AND `quest` = 7790);
INSERT INTO `gameobject_questender` (`id`, `quest`, `VerifiedBuild`) SELECT 668183, 7790, 0 FROM DUAL WHERE @EVERLAKE_E = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_questender', 668183, 7790, 0, 0, @EVERLAKE_FILE, 'seen-live: icyveins:addon (ends)' FROM DUAL WHERE @EVERLAKE_E = 1;

SET @EVERLAKE_GS := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 668183) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 668183 AND `guid` <> 920015285) AND NOT EXISTS (SELECT 1 FROM `gameobject` WHERE `guid` = 920015285);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920015285, 668183, 0, 0, 0, '0', 0, 0, 0, -1, 2742.8, -2430.05, 56.79, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_GS = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', 920015285, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=668183 point; height.py' FROM DUAL WHERE @EVERLAKE_GS = 1;

-- Etched Stone (668003).
SET @EVERLAKE_GS := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 668003) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 668003 AND `guid` <> 920015286) AND NOT EXISTS (SELECT 1 FROM `gameobject` WHERE `guid` = 920015286);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920015286, 668003, 0, 0, 0, '0', 0, 0, 0, -1, -6901.17, -2862.73, 241.89, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_GS = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', 920015286, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object=668003 page: map point; height.py' FROM DUAL WHERE @EVERLAKE_GS = 1;

COMMIT;
