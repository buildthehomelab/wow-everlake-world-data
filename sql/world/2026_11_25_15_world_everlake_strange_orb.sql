-- Strange Orb (gameobject 409289), the start of the paladin quest A Strange Artifact (78088), on the top floor of the
-- Tower of Althalaxx in Darkshore. The realm has no template for it and no spawn.
-- 2026_11_25_15_world_everlake_strange_orb.sql: written by hand from the tracker's kept facts (2026-11-25).
--
-- Template: Icy Veins' WoW Forever database (https://db.icy-veins.com/wow-forever/: name, type 2 quest giver, model 404,
-- size 2, data fields as recorded). Place: Wowhead's (56.2, 26.4 and 56.2, 26.5 on Darkshore's map) and QuestieDB's
-- (GPL-3.0; 56.22, 26.44) points, turned into a world position with the client's UiMapAssignment rectangle for UiMap
-- 1439; Icy Veins' players stood beside it (56.23, 26.44). The tower has six floors there; the orb stands on the top
-- one (94.12, from the realm's maps and vmaps, tools/height.py), where Athrikus Narassin and Narassin's Strongbox stand
-- 5 yards away ("Did you find something in the tower?"). Orientation 0, rotation 0 and respawn 120 s are INFERRED.
-- The quest itself, and the orb as its giver, are in 2026_11_25_16.
--
-- Guid 920019100 (own block). Each added row is recorded in everlake_import_rows. Never edit this file once it is
-- deployed: a later fix is a new file. Running it again changes nothing. Not tried in game.

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
SET @EVERLAKE_FILE := '2026_11_25_15_world_everlake_strange_orb.sql';
START TRANSACTION;

SET @EVERLAKE_G := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 409289);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 409289, 2, 404, 'Strange Orb', '', '', '', 2.0, 0, 29897, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_template', 409289, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=409289' FROM DUAL WHERE @EVERLAKE_G = 1;

SET @EVERLAKE_GS := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 409289) AND (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` = 409289 AND `guid` <> 920019100);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920019100, 409289, 1, 0, 0, '0', 0, 0, 0, -1, 7178.79, -740.74, 94.12, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM DUAL
WHERE @EVERLAKE_GS = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` WHERE `guid` = 920019100);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', 920019100, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead + QuestieDB object=409289: map point; height.py top floor' FROM `gameobject` WHERE `guid` = 920019100 AND `id` = 409289;

COMMIT;
