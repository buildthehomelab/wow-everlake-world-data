-- Alther's Mill (Redridge Mountains): the new Greater Tarantula of live Forever, 20 spawns.
-- 2026_11_23_04_world_everlake_althers_mill_tarantulas.sql: written from public data by a script, checked by hand.
--
-- Live Forever (1.60.1) put a second Greater Tarantula (271898, level 18-19) all around Alther's Mill, where rogues
-- train lockpicking on the Practice Lockboxes. The realm has its template, level and loot, and no spawn of it; only
-- twelve of the old Greater Tarantula (505) stand in the area.
--   * points: Wowhead's Forever page shows 41 points for it, all around the mill. Icy Veins' players looted it at 86
--     spots in the same area (1,242 reports) and QuestieDB's traces hold 159 points there, so it is no stray record.
--     Wowhead's points are sightings of roaming creatures, not spawn points: one is kept per 15 yards, and none
--     within 15 yards of a Greater Tarantula the realm already has. 20 remain. The count is a choice, not a record.
--   * heights: from the realm's maps and vmaps (ForeverTracker tools/height.py). Three points lie under the mill's
--     roof and two under trees: the ground or the mill's floor under them is taken.
--   * respawn 300 seconds, random movement in 10 yards (5 under the roof), as the realm's Greater Tarantulas there.
--   * model size: the core does not load a creature whose display has no creature_model_info row. Display 146855 has
--     none. INFERRED from display 520 (the old Greater Tarantula): the same client model (63) at scale 0.7 has
--     bounding radius 1.84634 and combat reach 0.9375; 146855 draws it at scale 0.45.
-- Not added: the other new Greater Tarantula (271988: smaller, no loot, seen at two points beside the lockboxes). It
-- looks like one the eggs call; nothing says where it stands.
--
-- Sources: Wowhead's Forever database through the ForeverTracker's page cache (points only); Icy Veins and QuestieDB
-- (GPL-3.0) as witnesses; client CreatureDisplayInfo. Not checked in game.
-- Guids: creatures 920016010 to 920016029.
-- Spawns only while the realm has the template and no spawn of it. Each added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing.

SET @EVERLAKE_FILE := '2026_11_23_04_world_everlake_althers_mill_tarantulas.sql';
SET @EVERLAKE_NOTE := 'wowhead points (1 per 15 yd); icyveins + questie witnesses';

START TRANSACTION;

SET @EVERLAKE_M146855 := (SELECT COUNT(*) = 0 FROM `creature_model_info` WHERE `DisplayID` = 146855);
INSERT IGNORE INTO `creature_model_info` (`DisplayID`, `BoundingRadius`, `CombatReach`, `DisplayID_Other_Gender`, `VerifiedBuild`)
SELECT 146855, 1.18693, 0.602679, 0, 0 FROM DUAL WHERE @EVERLAKE_M146855 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_model_info', 146855, 0, 0, 0, @EVERLAKE_FILE, 'INFERRED from display 520: same client model 63, scale 0.45 against 0.7' FROM DUAL WHERE @EVERLAKE_M146855 = 1;

SET @EVERLAKE_CS271898 := (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 271898)
  AND (SELECT COUNT(*) = 0 FROM `creature` WHERE `id` = 271898);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, 271898, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 300, s.`w`, 0, 100, 1, 0, 0, 0, 0, '', NULL, 0
FROM (
  SELECT 920016010 AS `guid`, -9141.14 AS `x`, -2671.15 AS `y`, 90.16 AS `z`, 0.0 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016011 AS `guid`, -9184.57 AS `x`, -2684.18 AS `y`, 92.91 AS `z`, 2.4 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016012 AS `guid`, -9115.07 AS `x`, -2686.35 AS `y`, 90.86 AS `z`, 4.8 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016013 AS `guid`, -9154.17 AS `x`, -2686.35 AS `y`, 91.35 AS `z`, 0.92 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016014 AS `guid`, -9216.43 AS `x`, -2686.35 AS `y`, 88.81 AS `z`, 3.32 AS `o`, 5 AS `w` UNION ALL
  SELECT 920016015 AS `guid`, -9233.80 AS `x`, -2697.20 AS `y`, 89.10 AS `z`, 5.72 AS `o`, 5 AS `w` UNION ALL
  SELECT 920016016 AS `guid`, -9197.60 AS `x`, -2701.54 AS `y`, 89.19 AS `z`, 1.83 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016017 AS `guid`, -9222.22 AS `x`, -2714.57 AS `y`, 91.19 AS `z`, 4.23 AS `o`, 5 AS `w` UNION ALL
  SELECT 920016018 AS `guid`, -9255.52 AS `x`, -2714.57 AS `y`, 88.80 AS `z`, 0.35 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016019 AS `guid`, -9151.27 AS `x`, -2747.13 AS `y`, 92.10 AS `z`, 2.75 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016020 AS `guid`, -9136.79 AS `x`, -2751.47 AS `y`, 93.10 AS `z`, 5.15 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016021 AS `guid`, -9226.56 AS `x`, -2753.64 AS `y`, 90.13 AS `z`, 1.27 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016022 AS `guid`, -9122.31 AS `x`, -2755.81 AS `y`, 92.55 AS `z`, 3.67 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016023 AS `guid`, -9136.79 AS `x`, -2766.67 AS `y`, 91.33 AS `z`, 6.07 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016024 AS `guid`, -9223.67 AS `x`, -2768.84 AS `y`, 89.12 AS `z`, 2.18 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016025 AS `guid`, -9157.06 AS `x`, -2775.35 AS `y`, 88.97 AS `z`, 4.58 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016026 AS `guid`, -9225.11 AS `x`, -2784.03 AS `y`, 90.84 AS `z`, 0.7 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016027 AS `guid`, -9174.44 AS `x`, -2790.55 AS `y`, 90.80 AS `z`, 3.1 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016028 AS `guid`, -9259.86 AS `x`, -2792.72 AS `y`, 89.29 AS `z`, 5.5 AS `o`, 10 AS `w` UNION ALL
  SELECT 920016029 AS `guid`, -9206.29 AS `x`, -2807.91 AS `y`, 93.09 AS `z`, 1.62 AS `o`, 10 AS `w`
) s
WHERE @EVERLAKE_CS271898 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
WHERE @EVERLAKE_CS271898 = 1 AND c.`id` = 271898 AND c.`guid` BETWEEN 920016010 AND 920016029;

COMMIT;
