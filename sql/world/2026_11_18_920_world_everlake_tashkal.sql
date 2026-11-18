-- Mount Hyjal: Ta'shkal <Escaped Experiment>, the hidden level 58 cat that tames with Broken Tooth's 1.0 sec attack speed.
-- 2026_11_18_920_world_everlake_tashkal.sql: written by hand.
--
-- Live WoW Forever (found by players 2026-11-16): a Corrupted Cat Figurine (object 660432) lies half buried in the fel pools
-- of Felblood Scar. Looting it (instant, no cast) gives the grey Corrupted Cat Figurine (item 276909). With it in the bags
-- the Lonely Lantern (object 660408) above Mourning's Rest can be used: the player casts Corrupted Cat Figurine (spell
-- 1301234, 3 sec, the figurine is its reagent), whose Send Event 104925 makes Ta'shkal (268231) appear, a level 57-58
-- tameable cat with Prowl 3 and Cower 6 whose tamed form swings at 1.0 sec (Faster Attack VII).
-- The item, the spell and its event are client data the server already reads. The realm's world (the fork's
-- forever-tdb-2026-10-14 and every import since) has no Ta'shkal, no lantern and no figurine, so this adds them:
--   * Ta'shkal's template: stats, faction and type flags (tameable) copied from Frostsaber Stalker (7432), the
--     level 59-60 Winterspring cat of the same world, with Wowhead's name, title, family, level 57-58, model 9230 and
--     its 1.0 sec swing. classic_pet_tame_spell gives the tamed cat Faster Attack VII (1263110), as the fork's
--     2026_11_15_00_world_forever_pet_attack_speed does for Broken Tooth, plus the two abilities Wowhead says it teaches.
--   * The Lonely Lantern: a goober whose user casts spell 1301234 (so the figurine is taken and a player without one is
--     told it is missing), at Wowhead's point. event_scripts 104925 summons Ta'shkal beside it for 5 minutes out of combat.
--   * The figurine: a chest with the instant "open" lock (43, as EG Link records for Forever's other small pickups)
--     whose loot is the item, at Wowhead's eight points, in a pool that keeps one of them out at a time (15 min respawn).
-- Sources: Wowhead's Forever pages npc=268231, object=660408, object=660432, item=276909, spell=1301234, read 2026-11-18
-- (ids, level, family, abilities, attack speed, models, map points), their comments (the figurine loots instantly, the
-- lantern needs it); X and Y from those points through the client's UiMapAssignment 69032 (UiMap 2482 on map 1); heights
-- from the realm's terrain files (maps extracted from client 70790), not checked in game. Not known, so chosen here:
-- the figurine's respawn (15 min, one at a time), how long Ta'shkal stays (5 min) and the lantern's cooldown (none).
-- Guids 920000100 to 920000108, pool 920000100 and loot 920000100: a block of their own after the Andorov file's.
-- Nothing is added where the realm already has the row. Each added row is recorded in everlake_import_rows.
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

SET @EVERLAKE_FILE := '2026_11_18_920_world_everlake_tashkal.sql';
SET @EVERLAKE_NOTE := 'Wowhead Forever npc=268231 object=660408/660432 2026-11-18; stats from 7432';

START TRANSACTION;

-- Ta'shkal: added once, only while the realm has no template for it and this file never added one.
SET @EVERLAKE_CAT := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 268231)
                   AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 268231)
                   AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 7432);

DROP TEMPORARY TABLE IF EXISTS `everlake_tashkal_ct`;
CREATE TEMPORARY TABLE `everlake_tashkal_ct` SELECT * FROM `creature_template` WHERE `entry` = 7432 AND @EVERLAKE_CAT = 1;
UPDATE `everlake_tashkal_ct` SET `entry` = 268231, `KillCredit1` = 0, `KillCredit2` = 0, `name` = 'Ta''shkal', `femaleName` = '',
  `subname` = 'Escaped Experiment', `TitleAlt` = NULL, `IconName` = NULL, `VignetteID` = 0, `npcflag` = 0, `Classification` = 0,
  `BaseAttackTime` = 1000, `family` = 2, `type` = 1, `VehicleId` = 0, `AIName` = '', `MovementType` = 0, `movementId` = 0,
  `ScriptName` = '', `StringId` = NULL, `VerifiedBuild` = 0;
INSERT INTO `creature_template` SELECT * FROM `everlake_tashkal_ct`;
DROP TEMPORARY TABLE `everlake_tashkal_ct`;

DROP TEMPORARY TABLE IF EXISTS `everlake_tashkal_ctd`;
CREATE TEMPORARY TABLE `everlake_tashkal_ctd` SELECT * FROM `creature_template_difficulty` WHERE `Entry` = 7432 AND `DifficultyID` = 0 AND @EVERLAKE_CAT = 1;
UPDATE `everlake_tashkal_ctd` SET `Entry` = 268231, `CreatureDifficultyID` = 0, `TypeFlags` = `TypeFlags` | 1, `LootID` = 0,
  `PickPocketLootID` = 0, `SkinLootID` = 0, `GoldMin` = 0, `GoldMax` = 0, `VerifiedBuild` = 0;
INSERT INTO `creature_template_difficulty` SELECT * FROM `everlake_tashkal_ctd`;
DROP TEMPORARY TABLE `everlake_tashkal_ctd`;

INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 268231, 0, 9230, 1, 1, 0 FROM DUAL
WHERE @EVERLAKE_CAT = 1 AND NOT EXISTS (SELECT 1 FROM `creature_template_model` WHERE `CreatureID` = 268231);

INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 268231, 57, 58 FROM DUAL
WHERE @EVERLAKE_CAT = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 268231);

-- Tamed: Faster Attack VII (1.0 sec), Cower rank 6, Prowl rank 3.
INSERT INTO `classic_pet_tame_spell` (`CreatureEntry`, `SpellId`)
SELECT 268231, s.`spell` FROM (SELECT 1263110 AS `spell` UNION ALL SELECT 16697 UNION ALL SELECT 24453) s
WHERE @EVERLAKE_CAT = 1 AND NOT EXISTS (SELECT 1 FROM `classic_pet_tame_spell` t WHERE t.`CreatureEntry` = 268231 AND t.`SpellId` = s.`spell`);

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 268231, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL
WHERE @EVERLAKE_CAT = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 268231);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 268231, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL
WHERE @EVERLAKE_CAT = 1 AND EXISTS (SELECT 1 FROM `creature_template_difficulty` WHERE `Entry` = 268231 AND `DifficultyID` = 0);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 268231, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_CAT = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 268231, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_CAT = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'classic_pet_tame_spell', 268231, t.`SpellId`, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE
FROM `classic_pet_tame_spell` t WHERE @EVERLAKE_CAT = 1 AND t.`CreatureEntry` = 268231 AND t.`SpellId` IN (1263110, 16697, 24453);

-- The two objects' templates, each only while the realm has none.
SET @EVERLAKE_LANTERN := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 660408)
                       AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 660408);
SET @EVERLAKE_FIGURINE := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 660432)
                        AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 660432);

-- Lonely Lantern: goober (10), autoClose 3000 ms, spell 1301234 cast by its user (playerCast).
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`,
  `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`,
  `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`,
  `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`,
  `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 660408, 10, 438, 'Lonely Lantern', '', '', '', 1,
  0, 0, 0, 3000, 0, 0, 0, 0, 0, 0, 1301234, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_LANTERN = 1;

-- Corrupted Cat Figurine: chest (3), lock 43 (open, instant), loot 920000100.
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`,
  `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`,
  `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`,
  `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`,
  `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 660432, 3, 127148, 'Corrupted Cat Figurine', '', '', '', 1,
  43, 920000100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_FIGURINE = 1;

INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 920000100, 0, 276909, 100, 0, 1, 0, 1, 1, 'Corrupted Cat Figurine - Corrupted Cat Figurine' FROM DUAL
WHERE @EVERLAKE_FIGURINE = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = 920000100);

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 660408, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_LANTERN = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 660432, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_FIGURINE = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 920000100, 0, 276909, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_FIGURINE = 1;

-- The lantern's event: Ta'shkal appears beside it, for 5 minutes (out of combat) unless tamed or killed.
INSERT INTO `event_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `Comment`)
SELECT 104925, 0, 10, 268231, 300000, 0, 4790.43, -1843.24, 1280.42, 1.57, 'Corrupted Cat Figurine: summon Ta''shkal by the Lonely Lantern' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `event_scripts` WHERE `id` = 104925)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` WHERE `tbl` = 'event_scripts' AND `k1` = 104925);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'event_scripts', 104925, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL
WHERE EXISTS (SELECT 1 FROM `event_scripts` WHERE `id` = 104925 AND `datalong` = 268231);

-- Spawns, only while the realm has none of either object in Kalimdor: the lantern (920000100) and the eight figurines
-- (920000101 to 920000108), heights from the terrain under Wowhead's points.
SET @EVERLAKE_SPAWNS := (SELECT COUNT(*) = 0 FROM `gameobject` WHERE `id` IN (660408, 660432) AND `map` = 1)
                      AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject' AND `k1` BETWEEN 920000100 AND 920000108);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `PhaseId`, `PhaseGroup`,
  `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`,
  `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, 1, 616, 0, '0', 0, 0, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, s.`respawn`, 255, 1, '', NULL, 0
FROM (
  SELECT 920000100 AS `guid`, 660408 AS `id`, 4802.00 AS `x`, -1843.24 AS `y`, 1280.46 AS `z`, 300 AS `respawn` -- 26.5 64.9
  UNION ALL SELECT 920000101, 660432, 4563.60, -2423.22, 1097.99, 900  -- 43.2 75.2
  UNION ALL SELECT 920000102, 660432, 4568.23, -2433.64, 1099.30, 900  -- 43.5 75.0
  UNION ALL SELECT 920000103, 660432, 4376.12, -2444.05, 1065.89, 900  -- 43.8 83.3
  UNION ALL SELECT 920000104, 660432, 4406.21, -2451.00, 1060.82, 900  -- 44.0 82.0
  UNION ALL SELECT 920000105, 660432, 4558.97, -2468.36, 1100.20, 900  -- 44.5 75.4
  UNION ALL SELECT 920000106, 660432, 4586.75, -2576.02, 1094.83, 900  -- 47.6 74.2
  UNION ALL SELECT 920000107, 660432, 4519.62, -2576.02, 1094.74, 900  -- 47.6 77.1
  UNION ALL SELECT 920000108, 660432, 4496.48, -2596.86, 1094.75, 900  -- 48.2 78.1
) s
WHERE @EVERLAKE_SPAWNS = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);

-- One figurine out at a time.
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
SELECT 920000100, 1, 'Corrupted Cat Figurine (Felblood Scar, Mount Hyjal): one of eight' FROM DUAL
WHERE @EVERLAKE_SPAWNS = 1 AND NOT EXISTS (SELECT 1 FROM `pool_template` WHERE `entry` = 920000100);
INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`)
SELECT 1, g.`guid`, 920000100, 0, 'Corrupted Cat Figurine' FROM `gameobject` g
WHERE @EVERLAKE_SPAWNS = 1 AND g.`guid` BETWEEN 920000101 AND 920000108 AND g.`id` = 660432
  AND NOT EXISTS (SELECT 1 FROM `pool_members` m WHERE m.`type` = 1 AND m.`spawnId` = g.`guid`);

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
WHERE @EVERLAKE_SPAWNS = 1 AND g.`guid` BETWEEN 920000100 AND 920000108;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_template', 920000100, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_SPAWNS = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pool_members', 1, m.`spawnId`, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `pool_members` m
WHERE @EVERLAKE_SPAWNS = 1 AND m.`type` = 1 AND m.`poolSpawnId` = 920000100;

COMMIT;
