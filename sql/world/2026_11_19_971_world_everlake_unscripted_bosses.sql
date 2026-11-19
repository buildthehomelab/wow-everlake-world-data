-- Kresh (Wailing Caverns), Old Serra'kis (Blackfathom Deeps) and Mana Wraith (City of Dalaran) fought with melee only:
-- they had no ScriptName and no SmartAI, and the tracker listed their encounters (587, 2765, 3312) as incomplete.
-- 2026_11_19_971_world_everlake_unscripted_bosses.sql: written by hand.
--
-- Abilities from their Wowhead Forever pages (2026-11-19), spells checked in the 70862 client:
--   Kresh (3653): Bite 17256 at the tank, Shell Shield 26064 (damage taken -50%, 12 s, 3 min cooldown) below 50% health.
--     Wowhead lists his hunter-pet skills (a tame learns them from him); a comment on the page names Bite (Rank 3) and
--     Shell Shield as his special attacks. Growl is left out.
--   Old Serra'kis (4830): Leech Pulse 8433 (health drain around him). The Dazed entries are every creature's melee daze.
--   Mana Wraith (246931): Reflection Field 1303458 ("reflects 100% of harmful spells against nearby allies until
--     canceled") when the fight starts. Tortured 1293451 is a dummy aura with no tooltip text: left out. Mana Wraith is
--     elite trash with five spawns; the client's encounter 3312 carries its name.
-- Every timer and the 50% threshold are INFERRED. Not tried in game.
--
-- Only written where the creature still has no AI of its own (AIName and ScriptName empty, no SmartAI rows for the entry
-- or its spawns) and the instance has its script; the creature then gets AIName SmartAI. A creature that already has
-- an AI is left alone. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing.

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
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`entryorguid` bigint NOT NULL, `source_type` tinyint unsigned NOT NULL, `id` smallint unsigned NOT NULL, `link` smallint unsigned NOT NULL, `Difficulties` varchar(100) NOT NULL, `event_type` tinyint unsigned NOT NULL, `event_phase_mask` smallint unsigned NOT NULL, `event_chance` tinyint unsigned NOT NULL, `event_flags` smallint unsigned NOT NULL, `event_param1` int unsigned NOT NULL, `event_param2` int unsigned NOT NULL, `event_param3` int unsigned NOT NULL, `event_param4` int unsigned NOT NULL, `event_param5` int unsigned NOT NULL, `event_param_string` varchar(255) NOT NULL, `action_type` tinyint unsigned NOT NULL, `action_param1` int unsigned NOT NULL, `action_param2` int unsigned NOT NULL, `action_param3` int unsigned NOT NULL, `action_param4` int unsigned NOT NULL, `action_param5` int unsigned NOT NULL, `action_param6` int unsigned NOT NULL, `action_param7` int unsigned NOT NULL, `target_type` tinyint unsigned NOT NULL, `target_param1` int unsigned NOT NULL, `target_param2` int unsigned NOT NULL, `target_param3` int unsigned NOT NULL, `target_param4` int unsigned NOT NULL, `target_x` float NOT NULL, `target_y` float NOT NULL, `target_z` float NOT NULL, `target_o` float NOT NULL, `comment` mediumtext NOT NULL, `note` varchar(255) NOT NULL, `map` int unsigned NOT NULL, `script` varchar(64) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`entryorguid`, `source_type`, `id`, `link`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `everlake_import_stage` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`, `note`, `map`, `script`) VALUES
(3653, 0, 0, 0, '', 0, 0, 100, 0, 5000, 8000, 10000, 12000, 0, '', 11, 17256, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Kresh - In combat - Cast Bite (17256) on victim', 'Wowhead Forever npc=3653 (comment: special attacks Bite Rank 3, Shell Shield); timers INFERRED', 43, 'classic_instance_wailing_caverns'),
(3653, 0, 1, 0, '', 2, 0, 100, 0, 0, 50, 180000, 180000, 0, '', 11, 26064, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kresh - Below 50% health - Cast Shell Shield (26064) on self', 'Wowhead Forever npc=3653; 3 min cooldown from the spell; 50% INFERRED', 43, 'classic_instance_wailing_caverns'),
(4830, 0, 0, 0, '', 0, 0, 100, 0, 8000, 12000, 15000, 20000, 0, '', 11, 8433, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Old Serra''kis - In combat - Cast Leech Pulse (8433)', 'Wowhead Forever npc=4830 abilities; timers INFERRED', 48, 'classic_instance_blackfathom_deeps'),
(246931, 0, 0, 0, '', 4, 0, 100, 0, 0, 0, 0, 0, 0, '', 11, 1303458, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mana Wraith - On aggro - Cast Reflection Field (1303458) on self', 'Wowhead Forever npc=246931 abilities; on aggro INFERRED', 2959, 'classic_instance_city_of_dalaran');

-- a creature with no AI of its own, in an instance with its script, whose rows this file has not written yet
UPDATE `everlake_import_stage` s SET s.`missing` = 1
WHERE EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`entryorguid` AND c.`AIName` = '' AND c.`ScriptName` = '')
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = s.`entryorguid` AND d.`source_type` = 0)
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` d JOIN `creature` c ON d.`entryorguid` = -CAST(c.`guid` AS SIGNED) WHERE c.`id` = s.`entryorguid` AND d.`source_type` = 0)
  AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = s.`entryorguid` AND c.`map` = s.`map`)
  AND EXISTS (SELECT 1 FROM `instance_template` i WHERE i.`map` = s.`map` AND i.`script` = s.`script`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'smart_scripts' AND r.`k1` = s.`entryorguid` AND r.`k2` = 0 AND r.`k3` = s.`id` AND r.`k4` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) SELECT `entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment` FROM `everlake_import_stage` WHERE `missing` = 1;
UPDATE `creature_template` c JOIN (SELECT DISTINCT `entryorguid` FROM `everlake_import_stage` WHERE `missing` = 1) s ON s.`entryorguid` = c.`entry`
SET c.`AIName` = 'SmartAI' WHERE c.`AIName` = '' AND c.`ScriptName` = '';
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'smart_scripts', s.`entryorguid`, s.`source_type`, s.`id`, s.`link`, '2026_11_19_971_world_everlake_unscripted_bosses.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_19_971_world_everlake_unscripted_bosses.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;
COMMIT;
SET SESSION autocommit = 1;
