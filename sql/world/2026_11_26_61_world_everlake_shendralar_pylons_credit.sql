-- 96018 Powering the Pylons (Shen'dralas): "empower the pylons". Its objectives count credits 263435 "[DNT] Kill Credit:
-- Western pylon repaired" and 263436 "[DNT] Kill Credit: Eastern pylon repaired", which nothing on the realm gives.
-- 2026_11_26_61_world_everlake_shendralar_pylons_credit.sql: written by hand, not tried in game (2026-11-26).
--
-- How live does it (sources):
--   Client DB2: the Pile of Pylon Parts (271882) casts 1289727 Repair and Recharge Pylon: a dummy on a nearby world
--     object (TARGET_GAMEOBJECT_NEARBY_ENTRY), with two more dummies naming 263435 and 263436. The credit is given on
--     the server, so the realm needs to give it itself. The core has no script for the spell, the item or the objects.
--   EG Link item_uses + objectives (builds up to 71091, CC BY 4.0): players used the Pile at -2379.7 1133.4 (objective 2,
--     the western credit) and at -2215.6 522.9 (objective 3, the eastern credit).
--   The realm's Shen'dralar Pylons stand there: 577959 (two spawns, -2369.9 1129.6 and -2381.8 1128.3, the western one)
--     and 577960 (-2217.2 520.3, the eastern one); both from EG Link live data, both without AI.
--
-- Rows: each pylon gets a SmartGameObjectAI that gives the caster its credit when 1289727 hits it, and a spell condition
-- makes the spell's nearby-object target one of the two pylons (without one, the core takes any object near the caster).
-- Rows are only added where the pylons have no AI. Each added row is recorded in everlake_import_rows.
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';
SET @EVERLAKE_FILE := '2026_11_26_61_world_everlake_shendralar_pylons_credit.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_pylon_stage`;
CREATE TEMPORARY TABLE `everlake_pylon_stage` (`entry` int unsigned NOT NULL, `credit` int unsigned NOT NULL, `comment` varchar(255) NOT NULL, `ok` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`entry`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_pylon_stage` (`entry`, `credit`, `comment`) VALUES
(577959, 263435, 'Shen''dralar Pylon (west) - On spell hit Repair and Recharge Pylon (1289727) - Quest credit 263435 (Powering the Pylons 96018)'),
(577960, 263436, 'Shen''dralar Pylon (east) - On spell hit Repair and Recharge Pylon (1289727) - Quest credit 263436 (Powering the Pylons 96018)');
UPDATE `everlake_pylon_stage` s
JOIN `gameobject_template` g ON g.`entry` = s.`entry` AND g.`AIName` = '' AND g.`ScriptName` = ''
SET s.`ok` = 1
WHERE NOT EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = s.`entry` AND d.`source_type` = 1);

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT s.`entry`, 1, 0, 0, '', 8, 0, 100, 0, 1289727, 0, 0, 0, 0, '', 33, s.`credit`, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, s.`comment`
FROM `everlake_pylon_stage` s WHERE s.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', s.`entry`, 1, 0, 0, @EVERLAKE_FILE, 'client SpellEffect 1289727; EG Link item_uses + objectives positions'
FROM `everlake_pylon_stage` s WHERE s.`ok` = 1;
UPDATE `gameobject_template` g JOIN `everlake_pylon_stage` s ON s.`entry` = g.`entry`
SET g.`AIName` = 'SmartGameObjectAI'
WHERE s.`ok` = 1 AND g.`AIName` = '' AND g.`ScriptName` = '';

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 13, 1, 1289727, 0, t.`grp`, 31, 0, 5, t.`entry`, 0, '', 0, 0, 0, '', 'Repair and Recharge Pylon targets a Shen''dralar Pylon (Powering the Pylons 96018)'
FROM (SELECT 0 AS `grp`, 577959 AS `entry` UNION ALL SELECT 1, 577960) t
WHERE NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 13 AND c.`SourceEntry` = 1289727)
  AND EXISTS (SELECT 1 FROM `everlake_pylon_stage` s WHERE s.`ok` = 1);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 13, 1, 1289727, c.`ElseGroup`, @EVERLAKE_FILE, CONCAT('implicit target of 1289727: ', c.`ConditionValue2`)
FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 13 AND c.`SourceGroup` = 1 AND c.`SourceEntry` = 1289727 AND c.`ConditionTypeOrReference` = 31;

DROP TEMPORARY TABLE IF EXISTS `everlake_pylon_stage`;

COMMIT;
