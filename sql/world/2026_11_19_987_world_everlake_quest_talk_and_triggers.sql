-- What the quests of 2026_11_19_986_world_everlake_build.sql need besides their rows: "talk to" objectives the
-- player can click, and the two area triggers their "reach a place" objectives count.
-- 2026_11_19_987_world_everlake_quest_talk_and_triggers.sql: written by hand.
--
-- Talk to: this core credits a "talk to" objective when the creature's window opens (gossip or quest giver hello).
-- The stable mounts of "Your First Horse" (97171: Menethil Harbor's Pinto 268318, Brown Horse 268314, Chestnut Mare
-- 268316, Black Stallion 268313) and "Your First Riding Kodo" (97446: 269138-269141) have no gossip flag, so nothing
-- opens: they get npcflag 1 (gossip). Only while their npcflag is still 0.
-- Two of the horses have no spawn: 268313 and 268314 stand at QuestieDB's points (Wetlands 8.08 54.08 and
-- 7.96 54.11), at the floor of the two that stand there already (z 9.9; ForeverTracker tools/height.py with that
-- hint), facing as they do. INFERRED: no recording of their spot.
--
-- Area triggers: 92009 "Crate Expectations" counts server area trigger 39304 and 95753 "Challenge of the Desert Wolf"
-- 33147; the realm has neither. Each is placed at QuestieDB's objective point (Mount Hyjal 60.41 62.16, Tanaris
-- 45.72 37.79), height from tools/height.py, as a sphere of 10 yards (INFERRED: Blizzard's shape and size are not
-- public). Template ids are Blizzard's own (IsCustom 0) so the quest objective names them; create properties and
-- spawns use ids of their own, 9500101 and 9500102.
--
-- Only rows the world lacks are added; every row goes in the ledger. Never edit this file once it is deployed: a later
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added (docs/forever-import.md)';

SET @EVERLAKE_FILE := '2026_11_19_987_world_everlake_quest_talk_and_triggers.sql';
START TRANSACTION;

-- the stable mounts open a window (gossip), so the talk-to objectives count
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template.npcflag', t.`entry`, 0, 0, 0, @EVERLAKE_FILE, 'npcflag 0 -> 1 (gossip) for a talk-to objective'
FROM `creature_template` t WHERE t.`entry` IN (268313, 268314, 268316, 268318, 269138, 269139, 269140, 269141) AND t.`npcflag` = 0;
UPDATE `creature_template` SET `npcflag` = 1
WHERE `entry` IN (268313, 268314, 268316, 268318, 269138, 269139, 269140, 269141) AND `npcflag` = 0;

-- the two horses with no spawn
SET @EVERLAKE_H268313 := (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 268313) AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 268313);
SET @EVERLAKE_H268314 := (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 268314) AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 268314);
SET @EVERLAKE_O := (SELECT `orientation` FROM `creature` WHERE `id` = 268316 ORDER BY `guid` LIMIT 1);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920011000, 268313, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -3638.5, -723.72, 9.9, COALESCE(@EVERLAKE_O, 0), 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM DUAL WHERE @EVERLAKE_H268313 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `guid` = 920011000);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920011001, 268314, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -3639.32, -718.76, 9.9, COALESCE(@EVERLAKE_O, 0), 300, 0, 0, 100, 0, 0, 0, 0, 0, '', NULL, 0
FROM DUAL WHERE @EVERLAKE_H268314 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `guid` = 920011001);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'QuestieDB point; z as the stable''s other horses (INFERRED)'
FROM `creature` c WHERE c.`guid` IN (920011000, 920011001) AND c.`id` IN (268313, 268314);

-- area triggers 39304 (Mount Hyjal) and 33147 (Tanaris)
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `ActionSetId`, `ActionSetFlags`, `VerifiedBuild`)
SELECT s.`Id`, 0, 0, 0, 0, 0 FROM (SELECT 39304 AS `Id` UNION ALL SELECT 33147) s
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger_template` t WHERE t.`Id` = s.`Id` AND t.`IsCustom` = 0);
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Shape`, `ShapeData0`, `ShapeData1`)
SELECT s.`Id`, 1, s.`At`, 0, 0, 10, 10 FROM (SELECT 9500101 AS `Id`, 39304 AS `At` UNION ALL SELECT 9500102, 33147) s
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger_create_properties` p WHERE p.`Id` = s.`Id` AND p.`IsCustom` = 1);
INSERT INTO `areatrigger` (`SpawnId`, `AreaTriggerCreatePropertiesId`, `IsCustom`, `MapId`, `SpawnDifficulties`, `PosX`, `PosY`, `PosZ`, `Orientation`, `PhaseUseFlags`, `PhaseId`, `PhaseGroup`, `ScriptName`, `Comment`, `VerifiedBuild`)
SELECT s.`SpawnId`, s.`SpawnId`, 1, 1, '0', s.`x`, s.`y`, s.`z`, 0, 1, 0, 0, '', s.`c`, 0 FROM (
  SELECT 9500101 AS `SpawnId`, 4865.42 AS `x`, -3020.91 AS `y`, 1191.48 AS `z`, 'Quest 92009 Crate Expectations - shipment delivered (INFERRED place)' AS `c`
  UNION ALL SELECT 9500102, -7613.34, -3373.43, 51.92, 'Quest 95753 Challenge of the Desert Wolf - Old Totem (INFERRED place)'
) s WHERE NOT EXISTS (SELECT 1 FROM `areatrigger` a WHERE a.`SpawnId` = s.`SpawnId`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'areatrigger_template', t.`Id`, 0, 0, 0, @EVERLAKE_FILE, 'quest objective area trigger' FROM `areatrigger_template` t WHERE t.`Id` IN (39304, 33147) AND t.`IsCustom` = 0;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'areatrigger_create_properties', p.`Id`, 1, 0, 0, @EVERLAKE_FILE, 'sphere 10 yd (INFERRED)' FROM `areatrigger_create_properties` p WHERE p.`Id` IN (9500101, 9500102) AND p.`IsCustom` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'areatrigger', a.`SpawnId`, 0, 0, 0, @EVERLAKE_FILE, 'QuestieDB objective point, height.py (INFERRED)' FROM `areatrigger` a WHERE a.`SpawnId` IN (9500101, 9500102);

COMMIT;
