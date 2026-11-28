-- Patrolling spawns whose path row hides their creature's mount, sheath, PvP flags or view distance.
-- 2026_11_28_50_world_everlake_patrol_rows_keep_template_addon.sql: written by hand, not tried in game (2026-11-28).
--
-- The core takes a spawn's creature_addon row INSTEAD of its creature's template addon (Creature::GetCreatureAddon). A
-- patrol row (PathId set) written without the template's other values leaves them at 0 for that spawn only, while the
-- creature's other spawns keep them. 2026_11_28_30 put back the auras; these are the other fields (PTR, 2026-11-28, 21
-- rows; emote and stand state lose nothing):
--   mount: Silas Darkmoon 14823 (2 of 2, both patrolling) and Peacekeeper 263930 (2 of 5) walk on foot.
--   visibilityDistanceType: Emeriss 14889 (1 of 1) is seen only from the usual range.
--   SheathState: one Dark Iron Looter 263396 (of 32).
--   PvPFlags: patrolling Stormpike, Silverwing and Defilers Emissaries (3 of 34, 3 of 34, 3 of 31), Thunder Bluff Revelers
--   (2 of 26), William 2533, Donna 2532, Miss Danna 3513, Karlee Chaddis 2330.
-- Rows: only rows with a path, only fields that are 0 there and set on the template; the rest of each row stays.
-- Left alone: creatures whose every spawn differs from the template the same way (all 14 Lazy Peons unarmed, all 86
-- Winter Revelers, the Festival Flamekeepers, Khaz Modan Rams, Tesla Coils, Guards Narrisha, Kahil and Tark): those are
-- the source's choice, not a patrol row.
-- No live source in the tracker records these fields, so this goes by the realm's own templates. Every changed row is
-- recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file.
-- Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_28_50_world_everlake_patrol_rows_keep_template_addon.sql';

START TRANSACTION;

-- record first (k2 = 50 keeps these apart from the auras file's rows for the same guids)
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_addon', ca.`guid`, 50, 0, 0, @EVERLAKE_FILE, LEFT(CONCAT('patrol row takes the template''s:',
    IF(ca.`mount` = 0 AND t.`mount` <> 0, CONCAT(' mount ', t.`mount`), ''),
    IF(ca.`MountCreatureID` = 0 AND t.`MountCreatureID` <> 0, CONCAT(' MountCreatureID ', t.`MountCreatureID`), ''),
    IF(ca.`SheathState` = 0 AND t.`SheathState` <> 0, CONCAT(' SheathState ', t.`SheathState`), ''),
    IF(ca.`PvPFlags` = 0 AND t.`PvPFlags` <> 0, CONCAT(' PvPFlags ', t.`PvPFlags`), ''),
    IF(ca.`visibilityDistanceType` = 0 AND t.`visibilityDistanceType` <> 0, CONCAT(' visibilityDistanceType ', t.`visibilityDistanceType`), ''),
    IF(ca.`emote` = 0 AND t.`emote` <> 0, CONCAT(' emote ', t.`emote`), ''),
    IF(ca.`StandState` = 0 AND t.`StandState` <> 0, CONCAT(' StandState ', t.`StandState`), ''),
    ' (creature ', c.`id`, ')'), 255)
FROM `creature_addon` ca JOIN `creature` c ON c.`guid` = ca.`guid` JOIN `creature_template_addon` t ON t.`entry` = c.`id`
WHERE ca.`PathId` > 0 AND (
     (ca.`mount` = 0 AND t.`mount` <> 0) OR (ca.`MountCreatureID` = 0 AND t.`MountCreatureID` <> 0)
  OR (ca.`SheathState` = 0 AND t.`SheathState` <> 0) OR (ca.`PvPFlags` = 0 AND t.`PvPFlags` <> 0)
  OR (ca.`visibilityDistanceType` = 0 AND t.`visibilityDistanceType` <> 0)
  OR (ca.`emote` = 0 AND t.`emote` <> 0) OR (ca.`StandState` = 0 AND t.`StandState` <> 0));

UPDATE `creature_addon` ca JOIN `creature` c ON c.`guid` = ca.`guid` JOIN `creature_template_addon` t ON t.`entry` = c.`id`
SET ca.`mount` = IF(ca.`mount` = 0, t.`mount`, ca.`mount`),
    ca.`MountCreatureID` = IF(ca.`MountCreatureID` = 0, t.`MountCreatureID`, ca.`MountCreatureID`),
    ca.`SheathState` = IF(ca.`SheathState` = 0, t.`SheathState`, ca.`SheathState`),
    ca.`PvPFlags` = IF(ca.`PvPFlags` = 0, t.`PvPFlags`, ca.`PvPFlags`),
    ca.`visibilityDistanceType` = IF(ca.`visibilityDistanceType` = 0, t.`visibilityDistanceType`, ca.`visibilityDistanceType`),
    ca.`emote` = IF(ca.`emote` = 0, t.`emote`, ca.`emote`),
    ca.`StandState` = IF(ca.`StandState` = 0, t.`StandState`, ca.`StandState`)
WHERE ca.`PathId` > 0 AND (
     (ca.`mount` = 0 AND t.`mount` <> 0) OR (ca.`MountCreatureID` = 0 AND t.`MountCreatureID` <> 0)
  OR (ca.`SheathState` = 0 AND t.`SheathState` <> 0) OR (ca.`PvPFlags` = 0 AND t.`PvPFlags` <> 0)
  OR (ca.`visibilityDistanceType` = 0 AND t.`visibilityDistanceType` <> 0)
  OR (ca.`emote` = 0 AND t.`emote` <> 0) OR (ca.`StandState` = 0 AND t.`StandState` <> 0));

COMMIT;
