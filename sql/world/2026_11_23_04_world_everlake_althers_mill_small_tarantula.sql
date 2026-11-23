-- Alther's Mill (Redridge Mountains): the small Greater Tarantula (271988) beside the Practice Lockboxes.
-- 2026_11_23_04_world_everlake_althers_mill_small_tarantula.sql: written by hand.
--
-- Live Forever (1.60.1) has a smaller Greater Tarantula (271988: the new spider model at three quarters of its
-- size, no loot) inside Alther's Mill, where rogues train lockpicking. The realm has its template and no spawn.
--   * spawn: one. Icy Veins' players saw it at two points 5 yards apart beside the lockboxes (3 players each, 8
--     reports); the point with more reports is taken, on the mill's floor (height from the realm's maps and vmaps,
--     ForeverTracker tools/height.py). Respawn 300 seconds and random movement as the realm's Greater Tarantulas
--     there, in 3 yards so it stays inside. Whether live has more than one is not known.
--   * level 18-19: Icy Veins' players' records, the only source. The realm had no level row for it.
--   * kill credit 505: EG Link's creature details and Icy Veins both give the old Greater Tarantula as its proxy, so
--     it counts for the quest Alther's Mill (98386).
--   * model size: the core does not load a creature whose display has no creature_model_info row. Display 146855 has
--     none. INFERRED from display 520 (the old Greater Tarantula): the same client model (63) at scale 0.7 has
--     bounding radius 1.84634 and combat reach 0.9375; 146855 draws it at scale 0.45.
-- Not added: the other new Greater Tarantula (271898). The client's spell "Summon Greater Tarantula" (1309513) calls
-- it for five minutes, so it hatches from the eggs; what casts the spell (trap 673083 of egg 673085) is recorded
-- nowhere.
--
-- Sources: Icy Veins (the point and the level); EG Link (Efficient Games, CC BY 4.0); client CreatureDisplayInfo.
-- Not checked in game.
-- Guid: creature 920016010.
-- Spawns only while the realm has the template and no spawn of it. Each added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing.

SET @EVERLAKE_FILE := '2026_11_23_04_world_everlake_althers_mill_small_tarantula.sql';
SET @EVERLAKE_NOTE := 'icyveins sight point (5 of 8 reports) and level; eglink + icyveins proxy 505';

START TRANSACTION;

SET @EVERLAKE_M146855 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 146855);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 146855, 1.18693, 0.602679, 0, 0 FROM DUAL WHERE @EVERLAKE_M146855 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 146855, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from display 520: same client model 63, scale 0.45 against 0.7' FROM DUAL WHERE @EVERLAKE_M146855 = 1;

SET @EVERLAKE_L271988 := (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 271988)
  AND (SELECT COUNT(*) = 0 FROM `creature_classic_level` WHERE `entry` = 271988);
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 271988, 18, 19 FROM DUAL WHERE @EVERLAKE_L271988 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 271988, 0, 0, 0, @EVERLAKE_FILE, 'icyveins: levels players recorded' FROM DUAL WHERE @EVERLAKE_L271988 = 1;

UPDATE `creature_template` SET `KillCredit1` = 505 WHERE `entry` = 271988 AND `KillCredit1` = 0 AND `KillCredit2` = 0;

SET @EVERLAKE_CS271988 := (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 271988)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 271988);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920016010, 271988, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -9229.46, -2699.37, 89.09, 0, 300, 3, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM DUAL
WHERE @EVERLAKE_CS271988 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = 920016010);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS271988 = 1 AND c.`id` = 271988 AND c.`guid` = 920016010;

COMMIT;
