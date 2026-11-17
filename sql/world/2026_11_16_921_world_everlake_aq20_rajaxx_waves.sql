-- Ruins of Ahn'Qiraj: General Rajaxx's seven waves, which never chained because none of them was tagged.
-- 2026_11_16_921_world_everlake_aq20_rajaxx_waves.sql: written by hand.
--
-- The fork's AQ20 instance script finds Rajaxx's waves by StringId, GeneralRajaxxWave1 to GeneralRajaxxWave7. When
-- Andorov's event starts, wave 1 attacks; when a wave is dead the next one attacks and Rajaxx yells, and when the
-- seventh is dead Rajaxx comes in himself. TrinityCore's update for that script (2026_02_04_00_world) tags its own
-- guids, which are not the realm's: the realm's world (the fork's forever-tdb-2026-10-14) keeps the same 49 spawns
-- under Forever's guids and has no tag on any of them, so the waves stand still and must be pulled by hand.
--
-- This tags the realm's spawns. Each wave is a captain and the six soldiers the world already puts in his formation
-- (creature_formations, leader = the captain), in the order the waves come: Captain Qeez, Captain Tuubid, Captain
-- Drenn, Captain Xurrem, Major Yeggeth, Major Pakkon and Colonel Zerran, each standing nearer Rajaxx than the last.
-- A spawn is tagged only when it is still that creature on map 509 with no StringId of its own.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

START TRANSACTION;

UPDATE `creature` c
JOIN (
  -- wave 1: Captain Qeez (15391) and his formation
  SELECT 20301057 AS `guid`, 15391 AS `id`, 'GeneralRajaxxWave1' AS `tag`
  UNION ALL SELECT 20301051, 15387, 'GeneralRajaxxWave1' UNION ALL SELECT 20301052, 15387, 'GeneralRajaxxWave1'
  UNION ALL SELECT 20301053, 15387, 'GeneralRajaxxWave1' UNION ALL SELECT 20301054, 15387, 'GeneralRajaxxWave1'
  UNION ALL SELECT 20301055, 15344, 'GeneralRajaxxWave1' UNION ALL SELECT 20301056, 15344, 'GeneralRajaxxWave1'
  -- wave 2: Captain Tuubid (15392)
  UNION ALL SELECT 20301058, 15392, 'GeneralRajaxxWave2'
  UNION ALL SELECT 20301059, 15387, 'GeneralRajaxxWave2' UNION ALL SELECT 20301060, 15387, 'GeneralRajaxxWave2'
  UNION ALL SELECT 20301061, 15387, 'GeneralRajaxxWave2' UNION ALL SELECT 20301062, 15344, 'GeneralRajaxxWave2'
  UNION ALL SELECT 20301063, 15344, 'GeneralRajaxxWave2' UNION ALL SELECT 20301064, 15344, 'GeneralRajaxxWave2'
  -- wave 3: Captain Drenn (15389)
  UNION ALL SELECT 20301168, 15389, 'GeneralRajaxxWave3'
  UNION ALL SELECT 20301071, 15387, 'GeneralRajaxxWave3' UNION ALL SELECT 20301072, 15344, 'GeneralRajaxxWave3'
  UNION ALL SELECT 20301073, 15344, 'GeneralRajaxxWave3' UNION ALL SELECT 20301074, 15344, 'GeneralRajaxxWave3'
  UNION ALL SELECT 20301075, 15344, 'GeneralRajaxxWave3' UNION ALL SELECT 20301076, 15344, 'GeneralRajaxxWave3'
  -- wave 4: Captain Xurrem (15390)
  UNION ALL SELECT 20301172, 15390, 'GeneralRajaxxWave4'
  UNION ALL SELECT 20301065, 15344, 'GeneralRajaxxWave4' UNION ALL SELECT 20301066, 15344, 'GeneralRajaxxWave4'
  UNION ALL SELECT 20301067, 15344, 'GeneralRajaxxWave4' UNION ALL SELECT 20301068, 15387, 'GeneralRajaxxWave4'
  UNION ALL SELECT 20301069, 15387, 'GeneralRajaxxWave4' UNION ALL SELECT 20301070, 15387, 'GeneralRajaxxWave4'
  -- wave 5: Major Yeggeth (15386)
  UNION ALL SELECT 20301169, 15386, 'GeneralRajaxxWave5'
  UNION ALL SELECT 20301077, 15344, 'GeneralRajaxxWave5' UNION ALL SELECT 20301078, 15344, 'GeneralRajaxxWave5'
  UNION ALL SELECT 20301079, 15344, 'GeneralRajaxxWave5' UNION ALL SELECT 20301080, 15344, 'GeneralRajaxxWave5'
  UNION ALL SELECT 20301081, 15387, 'GeneralRajaxxWave5' UNION ALL SELECT 20301082, 15387, 'GeneralRajaxxWave5'
  -- wave 6: Major Pakkon (15388)
  UNION ALL SELECT 20301171, 15388, 'GeneralRajaxxWave6'
  UNION ALL SELECT 20301089, 15387, 'GeneralRajaxxWave6' UNION ALL SELECT 20301090, 15387, 'GeneralRajaxxWave6'
  UNION ALL SELECT 20301091, 15387, 'GeneralRajaxxWave6' UNION ALL SELECT 20301092, 15344, 'GeneralRajaxxWave6'
  UNION ALL SELECT 20301093, 15387, 'GeneralRajaxxWave6' UNION ALL SELECT 20301094, 15344, 'GeneralRajaxxWave6'
  -- wave 7: Colonel Zerran (15385)
  UNION ALL SELECT 20301170, 15385, 'GeneralRajaxxWave7'
  UNION ALL SELECT 20301083, 15387, 'GeneralRajaxxWave7' UNION ALL SELECT 20301084, 15387, 'GeneralRajaxxWave7'
  UNION ALL SELECT 20301085, 15387, 'GeneralRajaxxWave7' UNION ALL SELECT 20301086, 15344, 'GeneralRajaxxWave7'
  UNION ALL SELECT 20301087, 15344, 'GeneralRajaxxWave7' UNION ALL SELECT 20301088, 15344, 'GeneralRajaxxWave7'
) w ON w.`guid` = c.`guid` AND w.`id` = c.`id`
SET c.`StringId` = w.`tag`
WHERE c.`map` = 509 AND (c.`StringId` IS NULL OR c.`StringId` = '');

COMMIT;
