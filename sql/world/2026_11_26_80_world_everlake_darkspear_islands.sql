-- Darkspear Islands battleground (map 2997, BattlemasterList 1157): spirit guides and battlemasters.
-- 2026_11_26_80_world_everlake_darkspear_islands.sql: written by hand (2026-11-26) for the core's battleground_darkspear_islands
-- script and its world file 2026_11_26_40_world_forever_darkspear_islands (battleground_template 1157, graveyards
-- 1129970-1129975, map world states). Needs that core commit; without it these rows are harmless but unused.
--
-- Spirit guides (Alliance 13116 / Horde 13117). No source records live's spirit guide spots; the realm owner chose the
-- Eye of the Storm layout (2026-11-26): a guide at each start area, and one beside each base for the team that has
-- captured it. Each base guide stands beside its graveyard, facing the base; heights from the server's maps and vmaps
-- (tools/height.py, terrain everywhere). Base guides are spawn groups with conditions on the base's capture point world
-- state (5 = Alliance captured, 4 = Horde captured), the same states the core's graveyard conditions use, so the core
-- spawns and despawns them by itself (flag 0x20: despawn when the condition fails).
--   Shipwreck Cove capture point 637677 (world state 30840)   groups 2997001 Alliance / 2997002 Horde
--   Abandoned Tower 637675 (30839)                            groups 2997003 / 2997004
--   Camp 637673 (30837)                                       groups 2997005 / 2997006
--   Ruins 637674 (30838)                                      groups 2997007 / 2997008
--
-- Battlemasters. The six capital Darkspear Islands battlemasters (subname "Darkspear Islands Battlemaster", already
-- spawned) had no battlemaster_entry row and four lacked the battlemaster npcflag, so none could queue anyone. No
-- portal object for the Barrens entrances exists in the client data; the realm owner chose to make the Northwatch
-- (Brelinda McFarry 275273) and Merchant Coast (Nizook Boof 275276) quest givers battlemasters instead. All eight get
-- gossip | battlemaster (1048577 added to npcflag) and a menu with live's line "Wanna join a battle out in Darkspear
-- Islands?" (broadcast text 317087) and the usual battlemaster option (broadcast text 10355).
--
-- Own guid block 920029970-920029979, spawn groups 2997001-2997008, gossip menu / npc_text 2997001, GossipOptionID
-- 299700101. Every added row is recorded in everlake_import_rows; npcflag changes only while the flag is as written.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.
-- Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_26_80_world_everlake_darkspear_islands.sql';
START TRANSACTION;

-- spirit guides
DROP TEMPORARY TABLE IF EXISTS `everlake_dsi_guides`;
CREATE TEMPORARY TABLE `everlake_dsi_guides` (`guid` bigint unsigned NOT NULL PRIMARY KEY, `id` int unsigned NOT NULL, `x` float NOT NULL, `y` float NOT NULL, `z` float NOT NULL, `o` float NOT NULL, `grp` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT 0) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_dsi_guides` (`guid`, `id`, `x`, `y`, `z`, `o`, `grp`, `note`) VALUES
(920029970, 13116, 84, 1975, 43.87, 3.1416, 0, 'Darkspear Islands spirit guide: Alliance start (owner''s EotS layout, height.py terrain)'),
(920029971, 13117, -561, 1903, 43.79, 0, 0, 'Darkspear Islands spirit guide: Horde start (owner''s EotS layout, height.py terrain)'),
(920029972, 13116, -76, 2117, 3.48, 2.566, 2997001, 'Darkspear Islands spirit guide: Shipwreck Cove, Alliance (owner''s EotS layout)'),
(920029973, 13117, -76, 2117, 3.48, 2.566, 2997002, 'Darkspear Islands spirit guide: Shipwreck Cove, Horde (owner''s EotS layout)'),
(920029974, 13116, -86, 1743, 46.21, 3.035, 2997003, 'Darkspear Islands spirit guide: Abandoned Tower, Alliance (owner''s EotS layout)'),
(920029975, 13117, -86, 1743, 46.21, 3.035, 2997004, 'Darkspear Islands spirit guide: Abandoned Tower, Horde (owner''s EotS layout)'),
(920029976, 13116, -372, 2148, 47.61, 5.330, 2997005, 'Darkspear Islands spirit guide: Camp, Alliance (owner''s EotS layout)'),
(920029977, 13117, -372, 2148, 47.61, 5.330, 2997006, 'Darkspear Islands spirit guide: Camp, Horde (owner''s EotS layout)'),
(920029978, 13116, -369, 1711, 3.21, 0.960, 2997007, 'Darkspear Islands spirit guide: Ruins, Alliance (owner''s EotS layout)'),
(920029979, 13117, -369, 1711, 3.21, 0.960, 2997008, 'Darkspear Islands spirit guide: Ruins, Horde (owner''s EotS layout)');
UPDATE `everlake_dsi_guides` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`,
    `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`,
    `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, 2997, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 120, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM `everlake_dsi_guides` s WHERE s.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', s.`guid`, 0, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_dsi_guides` s WHERE s.`missing` = 1;

-- base spirit guide spawn groups and their conditions
INSERT INTO `spawn_group_template` (`groupId`, `groupName`, `groupFlags`)
SELECT g.`groupId`, g.`groupName`, 32 FROM (
  SELECT 2997001 AS `groupId`, 'Darkspear Islands - Shipwreck Cove spirit guide - Alliance' AS `groupName` UNION ALL
  SELECT 2997002, 'Darkspear Islands - Shipwreck Cove spirit guide - Horde' UNION ALL
  SELECT 2997003, 'Darkspear Islands - Abandoned Tower spirit guide - Alliance' UNION ALL
  SELECT 2997004, 'Darkspear Islands - Abandoned Tower spirit guide - Horde' UNION ALL
  SELECT 2997005, 'Darkspear Islands - Camp spirit guide - Alliance' UNION ALL
  SELECT 2997006, 'Darkspear Islands - Camp spirit guide - Horde' UNION ALL
  SELECT 2997007, 'Darkspear Islands - Ruins spirit guide - Alliance' UNION ALL
  SELECT 2997008, 'Darkspear Islands - Ruins spirit guide - Horde') g
WHERE NOT EXISTS (SELECT 1 FROM `spawn_group_template` t WHERE t.`groupId` = g.`groupId`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'spawn_group_template', t.`groupId`, 0, 0, 0, @EVERLAKE_FILE, 'Darkspear Islands base spirit guide group (owner''s EotS layout)'
FROM `spawn_group_template` t WHERE t.`groupId` BETWEEN 2997001 AND 2997008 AND t.`groupName` LIKE 'Darkspear Islands - %';

INSERT INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`)
SELECT s.`grp`, 0, s.`guid` FROM `everlake_dsi_guides` s
WHERE s.`grp` <> 0 AND s.`missing` = 1 AND NOT EXISTS (SELECT 1 FROM `spawn_group` g WHERE g.`spawnType` = 0 AND g.`spawnId` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'spawn_group', s.`grp`, 0, s.`guid`, 0, @EVERLAKE_FILE, 'Darkspear Islands base spirit guide in its group' FROM `everlake_dsi_guides` s WHERE s.`grp` <> 0 AND s.`missing` = 1;

DROP TEMPORARY TABLE IF EXISTS `everlake_dsi_conditions`;
CREATE TEMPORARY TABLE `everlake_dsi_conditions` (`grp` int unsigned NOT NULL PRIMARY KEY, `ws` int unsigned NOT NULL, `val` int unsigned NOT NULL, `comment` varchar(255) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_dsi_conditions` (`grp`, `ws`, `val`, `comment`) VALUES
(2997001, 30840, 5, 'Darkspear Islands - Shipwreck Cove spirit guide while the Alliance holds it'),
(2997002, 30840, 4, 'Darkspear Islands - Shipwreck Cove spirit guide while the Horde holds it'),
(2997003, 30839, 5, 'Darkspear Islands - Abandoned Tower spirit guide while the Alliance holds it'),
(2997004, 30839, 4, 'Darkspear Islands - Abandoned Tower spirit guide while the Horde holds it'),
(2997005, 30837, 5, 'Darkspear Islands - Camp spirit guide while the Alliance holds it'),
(2997006, 30837, 4, 'Darkspear Islands - Camp spirit guide while the Horde holds it'),
(2997007, 30838, 5, 'Darkspear Islands - Ruins spirit guide while the Alliance holds it'),
(2997008, 30838, 4, 'Darkspear Islands - Ruins spirit guide while the Horde holds it');
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 33, 0, c.`grp`, 0, 0, 11, 0, c.`ws`, c.`val`, 0, '', 0, 0, 0, '', c.`comment` FROM `everlake_dsi_conditions` c
WHERE NOT EXISTS (SELECT 1 FROM `conditions` x WHERE x.`SourceTypeOrReferenceId` = 33 AND x.`SourceGroup` = 0 AND x.`SourceEntry` = c.`grp`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 33, c.`grp`, c.`ws`, c.`val`, @EVERLAKE_FILE, c.`comment` FROM `everlake_dsi_conditions` c;
DROP TEMPORARY TABLE `everlake_dsi_conditions`;
DROP TEMPORARY TABLE `everlake_dsi_guides`;

-- battlemaster gossip: live's greeting 317087 and the battlemaster option
INSERT INTO `npc_text` (`ID`, `Probability0`, `BroadcastTextID0`, `VerifiedBuild`)
SELECT 2997001, 1, 317087, 0 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `npc_text` WHERE `ID` = 2997001);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`)
SELECT 2997001, 2997001, 0 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu` WHERE `MenuID` = 2997001);
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`,
    `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`)
SELECT 2997001, 299700101, 0, 9, 'I would like to go to the battleground.', 10355, 0, 0, 0, 0, NULL, 0, 0, '', 0, NULL, NULL, 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu_option` WHERE `MenuID` = 2997001 OR `GossipOptionID` = 299700101);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) VALUES
('npc_text', 2997001, 0, 0, 0, @EVERLAKE_FILE, 'Darkspear Islands battlemaster greeting: broadcast text 317087 (client data)'),
('gossip_menu', 2997001, 2997001, 0, 0, @EVERLAKE_FILE, 'Darkspear Islands battlemaster menu'),
('gossip_menu_option', 2997001, 0, 299700101, 0, @EVERLAKE_FILE, 'Darkspear Islands battlemaster option (OptionNpc 9, broadcast text 10355)');

DROP TEMPORARY TABLE IF EXISTS `everlake_dsi_battlemasters`;
CREATE TEMPORARY TABLE `everlake_dsi_battlemasters` (`entry` int unsigned NOT NULL PRIMARY KEY, `oldflag` bigint unsigned NOT NULL, `note` varchar(255) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_dsi_battlemasters` (`entry`, `oldflag`, `note`) VALUES
(263349, 1, 'James Battlewing, Darkspear Islands Battlemaster (Stormwind)'),
(263643, 1048577, 'Sean Guardoff, Darkspear Islands Battlemaster (Ironforge)'),
(263644, 1048577, 'Pherry Leftee, Darkspear Islands Battlemaster (Darnassus)'),
(263645, 1, 'Gruga Bloodblade, Darkspear Islands Battlemaster (Orgrimmar)'),
(263646, 1, 'Rugbul Boomfirst, Darkspear Islands Battlemaster (Undercity)'),
(263647, 1, 'Borook Gallfist, Darkspear Islands Battlemaster (Thunder Bluff)'),
(275273, 2, 'Brelinda McFarry, Northwatch Hold: battlemaster in place of the portal (owner''s choice)'),
(275276, 2, 'Nizook Boof, the Merchant Coast: battlemaster in place of the portal (owner''s choice)');
UPDATE `creature_template` t JOIN `everlake_dsi_battlemasters` b ON b.`entry` = t.`entry`
SET t.`npcflag` = t.`npcflag` | 1048577 WHERE t.`npcflag` = b.`oldflag`;
INSERT INTO `creature_template_gossip` (`CreatureID`, `MenuID`, `VerifiedBuild`)
SELECT b.`entry`, 2997001, 0 FROM `everlake_dsi_battlemasters` b
WHERE NOT EXISTS (SELECT 1 FROM `creature_template_gossip` g WHERE g.`CreatureID` = b.`entry`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_gossip', g.`CreatureID`, 2997001, 0, 0, @EVERLAKE_FILE, b.`note`
FROM `creature_template_gossip` g JOIN `everlake_dsi_battlemasters` b ON b.`entry` = g.`CreatureID` WHERE g.`MenuID` = 2997001;
INSERT INTO `battlemaster_entry` (`entry`, `bg_template`)
SELECT b.`entry`, 1157 FROM `everlake_dsi_battlemasters` b WHERE NOT EXISTS (SELECT 1 FROM `battlemaster_entry` e WHERE e.`entry` = b.`entry`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'battlemaster_entry', e.`entry`, 0, 0, 0, @EVERLAKE_FILE, b.`note`
FROM `battlemaster_entry` e JOIN `everlake_dsi_battlemasters` b ON b.`entry` = e.`entry` WHERE e.`bg_template` = 1157;
DROP TEMPORARY TABLE `everlake_dsi_battlemasters`;

COMMIT;
