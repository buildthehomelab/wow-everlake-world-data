-- Ruins of Ahn'Qiraj: Lieutenant General Andorov and his four Kaldorei Elites, who had no spawn.
-- 2026_11_16_920_world_everlake_aq20_andorov.sql: written by hand.
--
-- The fork's AQ20 script (npc_andorov, instance_ruins_of_ahnqiraj) spawns spawn group 333 when Kurinnaxx dies:
-- Andorov walks in with his elites, starts the fight at a player's word, and opens his shop once Rajaxx is dead. His
-- shop sells the Cenarion Circle's plans, among them Plans: Obsidian Mail Tunic and Plans: Jagged Obsidian Shield.
-- The realm's world (the fork's forever-tdb-2026-10-14) has the group's template, his paths (4 and 5), his gossip, his
-- lines and his shop, but no creature in the group: the five spawns of TrinityCore's update for that script
-- (2026_02_04_00_world, folded into TDB 1210.26091) never reached it, so nothing appears and nobody can buy the plans.
--
-- This adds those five spawns as that update wrote them (one point, the formation spreading them out), in group 333
-- (a manual spawn group, flag 4: only the script spawns it), with their formation. They take AQ20's difficulty on
-- this realm, 148, like every other AQ20 spawn of the fork's world: TrinityCore's 3 would never spawn here. Guids 920000000 to 920000004: a
-- block of their own, clear of the import block (900000000) and the Forge's (910000000 + operation x 10000).
-- Nothing is added when the realm already has Andorov on map 509. Each added row is recorded in everlake_import_rows.
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

START TRANSACTION;

SET @EVERLAKE_ANDOROV_NEEDED := (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 15471 AND `map` = 509);

-- The spawns: Andorov (920000000) and four Kaldorei Elites, where TrinityCore's update puts them.
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `modelid`, `equipment_id`,
  `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `curHealthPct`, `MovementType`, `unit_flags`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, 509, 0, 0, '148', 0, 0, 1, -8624.473, 1471.7743, 32.0758, 2.3319497, 604800, 0, 100, 0, 0x8200, '', NULL, 0
FROM (SELECT 920000000 AS `guid`, 15471 AS `id` UNION ALL SELECT 920000001, 15473 UNION ALL SELECT 920000002, 15473
      UNION ALL SELECT 920000003, 15473 UNION ALL SELECT 920000004, 15473) s
WHERE @EVERLAKE_ANDOROV_NEEDED = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);

-- In spawn group 333, which the script spawns when Kurinnaxx dies.
INSERT IGNORE INTO `spawn_group` (`groupId`, `spawnType`, `spawnId`)
SELECT 333, 0, c.`guid` FROM `creature` c WHERE c.`guid` BETWEEN 920000000 AND 920000004 AND @EVERLAKE_ANDOROV_NEEDED = 1;

-- Andorov leads, his elites follow in formation.
INSERT IGNORE INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`, `point_1`, `point_2`)
SELECT 920000000, f.`member`, f.`dist`, f.`angle`, 515, 0, 0
FROM (SELECT 920000000 AS `member`, 0 AS `dist`, 0 AS `angle` UNION ALL SELECT 920000001, 5, 75 UNION ALL SELECT 920000002, 5, 285
      UNION ALL SELECT 920000003, 5, 330 UNION ALL SELECT 920000004, 5, 30) f
WHERE @EVERLAKE_ANDOROV_NEEDED = 1 AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = f.`member`);

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, '2026_11_16_920_world_everlake_aq20_andorov.sql', 'TrinityCore 2026_02_04_00_world (AQ20 Andorov event)'
FROM `creature` c WHERE c.`guid` BETWEEN 920000000 AND 920000004 AND @EVERLAKE_ANDOROV_NEEDED = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'spawn_group', 333, 0, g.`spawnId`, 0, '2026_11_16_920_world_everlake_aq20_andorov.sql', 'TrinityCore 2026_02_04_00_world (AQ20 Andorov event)'
FROM `spawn_group` g WHERE g.`groupId` = 333 AND g.`spawnType` = 0 AND g.`spawnId` BETWEEN 920000000 AND 920000004 AND @EVERLAKE_ANDOROV_NEEDED = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_formations', f.`memberGUID`, 0, 0, 0, '2026_11_16_920_world_everlake_aq20_andorov.sql', 'TrinityCore 2026_02_04_00_world (AQ20 Andorov event)'
FROM `creature_formations` f WHERE f.`leaderGUID` = 920000000 AND @EVERLAKE_ANDOROV_NEEDED = 1;

COMMIT;
