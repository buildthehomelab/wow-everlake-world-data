-- 95316 The Experimental Method (Curious Crow 257753, Mount Hyjal): "Use the pinecones to destroy the Ashen Reign
-- workstations." Its objectives count the credits 263806 Vessel, 263808 Disease, 263807 Alchemy and 264352 Slime
-- "[DNT] Kill Credit: Work Stations Disrupted", which nothing on the realm gives: the pinecone hits nothing.
-- 2026_11_26_86_world_everlake_experimental_method_workstations.sql: written by hand, not tried in game (2026-11-26).
--
-- How live does it (sources):
--   Client DB2: the quest's start item, Slimy Pinecone 273323 (ItemXItemEffect 165300 -> ItemEffect 233123), casts
--     1292139 Slimy Pinecone: a dummy aura on a nearby creature (TARGET_UNIT_NEARBY_ENTRY, 20 yd, 1.3 s cast). The
--     credit is given on the server: no client spell gives 263806 or 264352, and 1290709/1290710 (KILL_CREDIT2 for
--     263807/263808) are triggered-only spells nothing in the client casts. The core has no script for any of them.
--   EG Link item_uses + objectives (build 71037, CC BY 4.0): the pinecone (spellId 1292139) was used four times, each
--     giving one objective: objective 1 (Vessel) at 4691.1 -2639.5, 2 (Disease) at 4739.7 -2533.6, 3 (Alchemy) at
--     4724.2 -2470.4 and 4 (Slime) at 4621.0 -2415.0 (map 1). Objective n is quest_objectives StorageIndex n.
--   The realm has no workstation creature or object at those points (world_ptr, 25 yd around each), so the
--     workstations themselves are not known to any source the tracker holds.
--   ForeverTracker tools/height.py: ground at the four points 1152.58, 1157.51, 1157.47, 1165.01.
--
-- Rows: one spawn of each credit creature (they are invisible [DNT] triggers, flags_extra 128) at EG Link's point,
-- guids 920086600-920086603; each gets a SmartAI that gives the caster its own credit when 1292139 hits it, and a spell
-- condition makes the pinecone's nearby-creature target one of the four (without one, the core takes any creature).
-- INFERRED: live hits a workstation, not a credit trigger; the trigger at the same spot gives the same credit.
-- Rows are only added where missing (no spawn, no AI). Each added row is recorded in everlake_import_rows.
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
SET @EVERLAKE_FILE := '2026_11_26_86_world_everlake_experimental_method_workstations.sql';
SET @EVERLAKE_NOTE := 'client ItemEffect 233123 / SpellEffect 1292139; EG Link item_uses + objectives 71037';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_workstation_stage`;
CREATE TEMPORARY TABLE `everlake_workstation_stage` (
  `entry` int unsigned NOT NULL, `guid` bigint unsigned NOT NULL, `x` float NOT NULL, `y` float NOT NULL, `z` float NOT NULL,
  `grp` int unsigned NOT NULL, `comment` varchar(255) NOT NULL, `ok` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`entry`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_workstation_stage` (`entry`, `guid`, `x`, `y`, `z`, `grp`, `comment`) VALUES
(263806, 920086600, 4691.1, -2639.5, 1152.58, 0, 'Kill Credit: Vessel Workstation - On spell hit Slimy Pinecone (1292139) - Quest credit 263806 (The Experimental Method 95316)'),
(263808, 920086601, 4739.7, -2533.6, 1157.51, 1, 'Kill Credit: Disease Workstation - On spell hit Slimy Pinecone (1292139) - Quest credit 263808 (The Experimental Method 95316)'),
(263807, 920086602, 4724.2, -2470.4, 1157.47, 2, 'Kill Credit: Alchemy Workstation - On spell hit Slimy Pinecone (1292139) - Quest credit 263807 (The Experimental Method 95316)'),
(264352, 920086603, 4621.0, -2415.0, 1165.01, 3, 'Kill Credit: Slime Workstation - On spell hit Slimy Pinecone (1292139) - Quest credit 264352 (The Experimental Method 95316)');
UPDATE `everlake_workstation_stage` s
JOIN `creature_template` t ON t.`entry` = s.`entry` AND t.`ScriptName` = '' AND t.`AIName` IN ('', 'SmartAI')
SET s.`ok` = 1
WHERE NOT EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = s.`entry` AND d.`source_type` = 0)
  AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = s.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = s.`guid`);

-- the credit triggers, one at each spot where live gave that objective
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`entry`, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, s.`x`, s.`y`, s.`z`, 0, 300, 0, 0, 100, 0, NULL, NULL, NULL, NULL, '', NULL, 0
FROM `everlake_workstation_stage` s WHERE s.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', s.`guid`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `everlake_workstation_stage` s WHERE s.`ok` = 1;

-- the pinecone hitting a trigger gives the caster that trigger's credit
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT s.`entry`, 0, 0, 0, '', 8, 0, 100, 0, 1292139, 0, 0, 0, 0, '', 33, s.`entry`, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, s.`comment`
FROM `everlake_workstation_stage` s WHERE s.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', s.`entry`, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM `everlake_workstation_stage` s WHERE s.`ok` = 1;
UPDATE `creature_template` t JOIN `everlake_workstation_stage` s ON s.`entry` = t.`entry`
SET t.`AIName` = 'SmartAI'
WHERE s.`ok` = 1 AND t.`AIName` = '' AND t.`ScriptName` = '';

-- the pinecone's nearby-creature target is one of the four triggers (only when all four were placed here)
SET @EVERLAKE_ALL4 := (SELECT COUNT(*) = 4 FROM `everlake_workstation_stage` o WHERE o.`ok` = 1);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 13, 1, 1292139, 0, s.`grp`, 31, 0, 3, s.`entry`, 0, '', 0, 0, 0, '', 'Slimy Pinecone targets an Ashen Reign workstation credit trigger (The Experimental Method 95316)'
FROM `everlake_workstation_stage` s
WHERE NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 13 AND c.`SourceEntry` = 1292139)
  AND @EVERLAKE_ALL4 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 13, 1, 1292139, c.`ElseGroup`, @EVERLAKE_FILE, CONCAT('implicit target of 1292139: ', c.`ConditionValue2`)
FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 13 AND c.`SourceGroup` = 1 AND c.`SourceEntry` = 1292139 AND c.`ConditionTypeOrReference` = 31
  AND @EVERLAKE_ALL4 = 1;

DROP TEMPORARY TABLE IF EXISTS `everlake_workstation_stage`;

COMMIT;
