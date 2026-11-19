-- WoW Forever: The Shaper's Terrace (map 3001): the four Archival Panels, the Titan Panel and the Stone Guardians.
-- 2026_11_19_966_world_everlake_shapers_terrace_panels.sql. Safe to run again: a template is added only where the realm
-- has none, a spawn only where its guid is free, every added row recorded in everlake_import_rows. Never edit this file
-- once deployed.
--
-- On Forever, Cinder, Snowtalon, Vitrix and Bolt each appear when a player feeds 15 Power Crystals of one colour into an
-- Archival Panel, and Nanaya when the Titan Panel on the Pillar of Assimilation is used after all four (Warcraft Tavern's
-- guide). 2026_11_19_963 had those five standing at their panels; this file removes those five spawns and adds the
-- panels, which the core fork's classic_instance_shapers_terrace.cpp scripts (go_shapers_archival_panel,
-- go_shapers_titan_panel). A core without those scripts leaves the panels doing nothing.
--
-- Real data: the object ids, names and models (Wowhead's Forever pages: Archival Panel 650303, 672255, 672256 and
-- 673520, model 124753, Ulduar's control unit; Titan Panel 673851, model 123362), the Stone Guardians (261777, 262032:
-- elite elementals, model 8395) and that two guard the pillar (Warcraft Tavern, lfcarry).
-- INFERRED: which panel is which colour (Wowhead gives no places), the spots (the panels stand where 963 put their
-- bosses; the Titan Panel 8 yards in front of Nanaya's spot, toward the paved road; the guardians 22 yards out on that
-- side), the guardians' level 60, health x3, faction 16 and gold.

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

SET @EVERLAKE_FILE := '2026_11_19_966_world_everlake_shapers_terrace_panels.sql';
SET @EVERLAKE_NOTE := 'wowhead forever pages (names, models); guides (what the panels do); spots, colours, levels INFERRED';
START TRANSACTION;

-- The five bosses the panels bring: only the spawns 963 added (its guids, its entries, recorded under its name).
DELETE c FROM `creature` c
  JOIN `everlake_import_rows` r ON r.`tbl` = 'creature' AND r.`k1` = c.`guid`
   AND r.`file` = '2026_11_19_963_world_everlake_shapers_terrace_creatures.sql'
 WHERE (c.`guid`, c.`id`) IN ((974002031, 261809), (974002040, 261974), (974002063, 262297), (974002069, 272561), (974002042, 262081));

-- The panels: goobers whose use the core script answers (a gossip offering the crystals, or Nanaya).
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `VerifiedBuild`)
SELECT s.`entry`, 10, s.`display`, s.`name`, '', '', '', 1, 0, 0, '', s.`script`, 0 FROM (
  SELECT 650303 AS `entry`, 124753 AS `display`, 'Archival Panel' AS `name`, 'go_shapers_archival_panel' AS `script` UNION ALL
  SELECT 672255, 124753, 'Archival Panel', 'go_shapers_archival_panel' UNION ALL
  SELECT 672256, 124753, 'Archival Panel', 'go_shapers_archival_panel' UNION ALL
  SELECT 673520, 124753, 'Archival Panel', 'go_shapers_archival_panel' UNION ALL
  SELECT 673851, 123362, 'Titan Panel', 'go_shapers_titan_panel'
) s WHERE NOT EXISTS (SELECT 1 FROM `gameobject_template` t WHERE t.`entry` = s.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject_template' AND r.`k1` = s.`entry`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', t.`entry`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject_template` t
 WHERE t.`entry` IN (650303, 672255, 672256, 673520, 673851) AND t.`ScriptName` IN ('go_shapers_archival_panel', 'go_shapers_titan_panel');

-- red: Cinder's hills (Ruby Spring); blue: Snowtalon's cave (Crystalline Highlands); green: behind the gate by Watcher's
-- Overlook (Vitrix); yellow: behind Venomridge by the tar (Bolt); the Titan Panel on the Pillar of Assimilation.
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, 3001, 16667, 0, '1,201', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, s.`o`, 0, 0, SIN(s.`o` / 2), COS(s.`o` / 2), 86400, 255, 1, '', NULL, 0 FROM (
  SELECT 974002100 AS `guid`, 650303 AS `id`, -5904.2 AS `x`, -862.5 AS `y`, 112.81 AS `z`, 5.584 AS `o` UNION ALL
  SELECT 974002101, 672255, -5687.5, -604.2, 13.02, 4.002 UNION ALL
  SELECT 974002102, 672256, -5520.8, -845.8, 22.18, 5.326 UNION ALL
  SELECT 974002103, 673520, -5929.2, -1220.8, 9.11, 6.11 UNION ALL
  SELECT 974002104, 673851, -5847.6, -1582.9, 37.14, 0.608
) s WHERE EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject_template' AND r.`k1` = s.`id` AND r.`file` = '2026_11_19_966_world_everlake_shapers_terrace_panels.sql')
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `gameobject` g
 WHERE g.`guid` BETWEEN 974002100 AND 974002104 AND g.`map` = 3001 AND g.`id` IN (650303, 672255, 672256, 673520, 673851);

-- Stone Guardian (261777, 262032): elite elementals, model 8395, level 60, health x3.0 (INFERRED)
SET @EVERLAKE_SG := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` IN (261777, 262032))
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` IN (261777, 262032));
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT e.`entry`, 0, 0, 'Stone Guardian', NULL, NULL, NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 4, 0, '', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0
  FROM (SELECT 261777 AS `entry` UNION ALL SELECT 262032) e WHERE @EVERLAKE_SG = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT e.`entry`, 0, 0, 0, 0, 0, 3.0, 1, 1, 1.0, 0, 0, 0, 0, 0, 0, 0, 150, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0
  FROM (SELECT 261777 AS `entry` UNION ALL SELECT 262032) e WHERE @EVERLAKE_SG = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT e.`entry`, 0, 8395, 1, 1, 0 FROM (SELECT 261777 AS `entry` UNION ALL SELECT 262032) e WHERE @EVERLAKE_SG = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT e.`entry`, 60, 60 FROM (SELECT 261777 AS `entry` UNION ALL SELECT 262032) e
 WHERE @EVERLAKE_SG = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` l WHERE l.`entry` = e.`entry`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', e.`entry`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM (SELECT 261777 AS `entry` UNION ALL SELECT 262032) e WHERE @EVERLAKE_SG = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', e.`entry`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM (SELECT 261777 AS `entry` UNION ALL SELECT 262032) e WHERE @EVERLAKE_SG = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', e.`entry`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM (SELECT 261777 AS `entry` UNION ALL SELECT 262032) e WHERE @EVERLAKE_SG = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', e.`entry`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM (SELECT 261777 AS `entry` UNION ALL SELECT 262032) e WHERE @EVERLAKE_SG = 1;

-- the two on the pillar's road side, either side of the way to the Titan Panel
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, 3001, 16667, 0, '1,201', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, s.`o`, 86400, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0 FROM (
  SELECT 974002100 AS `guid`, 261777 AS `id`, -5839.0 AS `x`, -1570.8 AS `y`, 37.14 AS `z`, 0.608 AS `o` UNION ALL
  SELECT 974002101, 262032, -5833.2, -1579.0, 37.14, 0.608
) s WHERE EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_template' AND r.`k1` = s.`id` AND r.`file` = '2026_11_19_966_world_everlake_shapers_terrace_panels.sql')
  AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `creature` c
 WHERE c.`guid` BETWEEN 974002100 AND 974002101 AND c.`id` IN (261777, 262032);

-- Nanaya's Energize (1290506-1290509) aims at a nearby creature of one entry; the client does not say which. Her crystals
-- are Crystal Triggers (11179, summoned by her script), and spell_shapers_nanaya_energize picks the one of her colour.
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 13, 1, s.`spell`, 0, 0, 31, 0, 3, 11179, 0, '', 0, 0, 0, '', 'Nanaya - Energize - Crystal Trigger' FROM (
  SELECT 1290506 AS `spell` UNION ALL SELECT 1290507 UNION ALL SELECT 1290508 UNION ALL SELECT 1290509
) s WHERE NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 13 AND c.`SourceEntry` = s.`spell`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 13, c.`SourceEntry`, 11179, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `conditions` c
 WHERE c.`SourceTypeOrReferenceId` = 13 AND c.`SourceEntry` BETWEEN 1290506 AND 1290509 AND c.`ConditionValue2` = 11179;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
SELECT s.`spell`, 'spell_shapers_nanaya_energize' FROM (
  SELECT 1290506 AS `spell` UNION ALL SELECT 1290507 UNION ALL SELECT 1290508 UNION ALL SELECT 1290509
) s WHERE NOT EXISTS (SELECT 1 FROM `spell_script_names` n WHERE n.`spell_id` = s.`spell`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'spell_script_names', n.`spell_id`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `spell_script_names` n
 WHERE n.`spell_id` BETWEEN 1290506 AND 1290509 AND n.`ScriptName` = 'spell_shapers_nanaya_energize';

COMMIT;
