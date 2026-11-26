-- 93045 Test Your Theory (Desolace): "dispel the necromantic curse present on the Accursed Skull". Its objective counts
-- credit 253754 "[DNT] Kill Credit: Dispel the Accursed Skull", which nothing on the realm gives.
-- 2026_11_26_60_world_everlake_test_your_theory_skull.sql: written by hand, not tried in game (2026-11-26).
--
-- How live does it (sources):
--   Wowhead Forever quest 93045, comment 6470595 (kept by the tracker): loot Uthek's Staff by the pond, combine it with
--     the crystal into Uthek's Draenethyst Staff (256061), "then use that staff on the pile with the skull on top (right
--     next to where you found Uthek's Staff)".
--   Client DB2: the staff's spell 1260031 Dispel Curse needs spell focus 2243 (SpellCastingRequirements), aims at a
--     spot (TARGET_DEST_DEST) and hits the world objects within 4 yards of it (TARGET_GAMEOBJECT_DEST_AREA, radius 26).
--     Spell 1259892 Kill Credit (DNT) holds the credit for 253754 (effect 90).
--   Icy Veins gameobject 587339 "Accursed Skull": type 8 (spell focus), focus 2243, size 3, model 114687, Data as
--     recorded below; Icy Veins 587341 "Bone Pile" (type 5, model 114714, size 0.5) is the pile under it. Neither had a
--     template or spawn on the realm. (587276, also named Accursed Skull, is the lootable skull of 93041 in the Valley of
--     Bones and is left alone.)
--
-- Rows:
--   1. Templates for 587339 and 587341, from the Icy Veins records.
--   2. One spawn of each beside the realm's only Uthek's Staff (587338, guid 974002113, -2011.00 2332.49 56.84), 3 yards
--      east of it: the comment puts the pile "right next to" the staff, no source gives its exact spot. Height from the
--      realm's maps (ForeverTracker tools/height.py, terrain 56.65). Orientation 0 and respawn 300 s (as the staff)
--      are INFERRED.
--   3. The skull gets a SmartGameObjectAI: when Dispel Curse (1260031) hits it, the caster gets the credit 253754.
--      A spell condition keeps the spell's object-area target to the skull, so no other object near the spot is hit.
--
-- Guids: objects 920019800-920019801 (this group's block 920019800-920020199).
-- Rows are only added where none exist. Each added row is recorded in everlake_import_rows. Never edit this file once
-- it is deployed: a later fix is a new file. Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_26_60_world_everlake_test_your_theory_skull.sql';

START TRANSACTION;

-- 1. Templates (Icy Veins gameobject records; Data0-34 = their props).
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 587339, 8, 114687, 'Accursed Skull', '', '', '', 3, 2243, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = 587339)
UNION ALL
SELECT 587341, 5, 114714, 'Bone Pile', '', '', '', 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5841, 0, '', '', NULL, 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = 587341);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', g.`entry`, 0, 0, 0, @EVERLAKE_FILE, CONCAT('Icy Veins gameobject=', g.`entry`)
FROM `gameobject_template` g
WHERE (g.`entry` = 587339 AND g.`type` = 8 AND g.`Data0` = 2243 OR g.`entry` = 587341 AND g.`type` = 5 AND g.`displayId` = 114714)
  AND g.`VerifiedBuild` = 0
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject_template' AND r.`k1` = g.`entry`);

-- 2. Spawns beside Uthek's Staff.
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, 1, 0, 0, '0', 0, 0, 0, -1, -2008.00, 2332.49, 56.65, 0, 0, 0, 0, 1, 300, 255, 1, '', NULL, 0 FROM (
  SELECT 920019800 AS `guid`, 587341 AS `id`
  UNION ALL SELECT 920019801, 587339
) s
WHERE EXISTS (SELECT 1 FROM `gameobject_template` t WHERE t.`entry` = s.`id`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`id` = s.`id`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead comment 6470595: next to Uthek''s Staff; height.py; spot, orientation and respawn INFERRED'
FROM `gameobject` g WHERE g.`guid` IN (920019800, 920019801) AND g.`id` IN (587339, 587341);

-- 3. Dispel Curse on the skull gives the credit.
SET @EVERLAKE_AI := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 587339 AND `AIName` = '' AND `ScriptName` = '')
  AND (SELECT COUNT(*) = 0 FROM `smart_scripts` WHERE `entryorguid` = 587339 AND `source_type` = 1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 587339, 1, 0, 0, '', 8, 0, 100, 0, 1260031, 0, 0, 0, 0, '', 33, 253754, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Accursed Skull - On spell hit Dispel Curse (1260031) - Quest credit 253754 (Test Your Theory 93045)'
FROM DUAL WHERE @EVERLAKE_AI = 1;
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI'
WHERE `entry` = 587339 AND `AIName` = '' AND `ScriptName` = '' AND @EVERLAKE_AI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', 587339, 1, 0, 0, @EVERLAKE_FILE, 'client SpellEffect 1260031 + 1259892 (credit 253754); Wowhead comment 6470595'
FROM DUAL WHERE @EVERLAKE_AI = 1;

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 13, 1, 1260031, 0, 0, 31, 0, 5, 587339, 0, '', 0, 0, 0, '', 'Dispel Curse hits only the Accursed Skull (Test Your Theory 93045)'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 13 AND c.`SourceEntry` = 1260031);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 13, 1, 1260031, 0, @EVERLAKE_FILE, 'implicit target of Dispel Curse: Accursed Skull 587339'
FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 13 AND c.`SourceGroup` = 1 AND c.`SourceEntry` = 1260031 AND c.`ConditionValue2` = 587339;

COMMIT;
