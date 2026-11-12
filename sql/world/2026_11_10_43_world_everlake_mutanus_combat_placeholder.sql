-- PROVISIONAL historical Classic combat fallback for Mutanus; issue48 remains open.
-- Source: cmangos/classic-db c33f90b8eeb3f8bacb53d5cbfee45075c80b416c, ACID/acid_classic.sql rows365402-365404.
-- Copyright (C) 2008-2016 ACID; translated EventAI facts/behavior. GPL-2.0-or-later; see NOTICE and bundled license.
-- Target core 343fe6fb95076e09575156c8b88d155914003b78; client70862. No SoD raid-ID remapping.
-- Existing rotations and explicit overrides are preserved. Rates/targets are not live Forever certified.
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

SET SESSION autocommit = 0;
-- Three explicitly provisional casts; repeat event flags translated to SmartAI0
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`entryorguid` bigint NOT NULL, `source_type` tinyint unsigned NOT NULL, `id` smallint unsigned NOT NULL, `link` smallint unsigned NOT NULL, `Difficulties` varchar(100) NOT NULL, `event_type` tinyint unsigned NOT NULL, `event_phase_mask` smallint unsigned NOT NULL, `event_chance` tinyint unsigned NOT NULL, `event_flags` smallint unsigned NOT NULL, `event_param1` int unsigned NOT NULL, `event_param2` int unsigned NOT NULL, `event_param3` int unsigned NOT NULL, `event_param4` int unsigned NOT NULL, `event_param5` int unsigned NOT NULL, `event_param_string` varchar(255) NOT NULL, `action_type` tinyint unsigned NOT NULL, `action_param1` int unsigned NOT NULL, `action_param2` int unsigned NOT NULL, `action_param3` int unsigned NOT NULL, `action_param4` int unsigned NOT NULL, `action_param5` int unsigned NOT NULL, `action_param6` int unsigned NOT NULL, `action_param7` int unsigned NOT NULL, `target_type` tinyint unsigned NOT NULL, `target_param1` int unsigned NOT NULL, `target_param2` int unsigned NOT NULL, `target_param3` int unsigned NOT NULL, `target_param4` int unsigned NOT NULL, `target_x` float NOT NULL, `target_y` float NOT NULL, `target_z` float NOT NULL, `target_o` float NOT NULL, `comment` mediumtext NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`entryorguid`, `source_type`, `id`, `link`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`, `note`) VALUES
(3654, 0, 900, 0, '1', 0, 0, 100, 0, 0, 10000, 10000, 16000, 0, '', 11, 8150, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'PROVISIONAL Classic ACID #48: Mutanus combat spell 8150; verify Forever cadence', 'PROVISIONAL ACID c33f90b8eeb3; issue48; Forever targets/timings pending'),
(3654, 0, 901, 0, '1', 0, 0, 100, 0, 6000, 11000, 25000, 36000, 0, '', 11, 7967, 0, 0, 0, 0, 0, 0, 6, 0, 1, 0, 0, 0, 0, 0, 0, 'PROVISIONAL Classic ACID #48: Mutanus combat spell 7967; verify Forever cadence', 'PROVISIONAL ACID c33f90b8eeb3; issue48; Forever targets/timings pending'),
(3654, 0, 902, 0, '1', 0, 0, 100, 0, 15000, 21000, 18000, 24000, 0, '', 11, 7399, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'PROVISIONAL Classic ACID #48: Mutanus combat spell 7399; verify Forever cadence', 'PROVISIONAL ACID c33f90b8eeb3; issue48; Forever targets/timings pending');
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `smart_scripts` t WHERE t.`entryorguid` = s.`entryorguid` AND t.`source_type` = s.`source_type` AND t.`id` = s.`id` AND t.`link` = s.`link`) AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry`=3654 AND c.`AIName`='SmartAI' AND c.`ScriptName`='')
AND EXISTS (SELECT 1 FROM `instance_template` i WHERE i.`map`=43 AND i.`script`='classic_instance_wailing_caverns')
AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry`=3678 AND c.`ScriptName`='classic_npc_disciple_of_naralex')
AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id`=3678 AND c.`map`=43)
AND EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid`=3654 AND d.`source_type`=0 AND d.`id`=0
 AND d.`link`=0 AND d.`event_type`=6 AND d.`action_type`=34 AND d.`action_param2`=3
 AND ((d.`action_param1`=4 AND d.`action_param3`=1) OR (d.`action_param1`=5 AND d.`action_param3`=0)))
AND NOT EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid`=3654 AND d.`source_type`=0 AND d.`id`<>0)
AND NOT EXISTS (SELECT 1 FROM `smart_scripts` d JOIN `creature` c ON d.`entryorguid`=-CAST(c.`guid` AS SIGNED)
 WHERE c.`id`=3654 AND d.`source_type`=0)
AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl`='smart_scripts' AND r.`k1`=3654 AND r.`k2`=0
 AND r.`k3`=s.`id` AND r.`k4`=0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) SELECT `entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment` FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'smart_scripts', s.`entryorguid`, s.`source_type`, s.`id`, s.`link`, '2026_11_10_43_world_everlake_mutanus_combat_placeholder.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_10_43_world_everlake_mutanus_combat_placeholder.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

SET SESSION autocommit = 1;
