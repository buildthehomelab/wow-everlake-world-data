-- Master Mathias Shaw (332, SI:7 in Stormwind) gives rogues the letter for "The Manor, Ravenholdt" (6681).
-- 2026_11_26_19_world_everlake_mathias_shaw_ravenholdt_letter.sql: written by hand (2026-11-26).
--
-- Blizzard's server-side note of 17 November 2026 (step 70959+1): "A bin of mail has been discovered in SI:7 quarters
-- and Mathias Shaw can now give rogues the letter that they've been expecting for "The Manor, Ravenholdt"." On the
-- realm the rogue trainers (Osborne the Night Man 918, Anishar 4215, Hulfdan Blackbeard 5165 and others) already offer
-- "<Take the letter>" (broadcast text 8548, VMaNGOS): shown to rogues of level 24 or more who have not taken quest 6681
-- and do not hold the Elegant Letter 17126; choosing it runs action list 950000320, which casts Conjure Elegant Letter
-- 21100 on the player. Mathias Shaw's menu 4941 had no options. This gives his menu the same option, conditions and
-- script. The bin of mail itself is not spawned (no source places it).
-- GossipOptionID 98004941; OptionID is the menu's next free one; SmartAI ids 90/91 (332 already has SmartAI, ids 0-4).
--
-- Every added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing. Not checked in game.

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

START TRANSACTION;
DROP TEMPORARY TABLE IF EXISTS `everlake_gossip_add`;
CREATE TEMPORARY TABLE `everlake_gossip_add` (`GossipOptionID` int NOT NULL PRIMARY KEY, `CreatureID` int unsigned NOT NULL, `MenuID` int unsigned NOT NULL, `OptionID` int unsigned NOT NULL DEFAULT 0, `OptionText` text NOT NULL, `BroadcastTextID` int NOT NULL, `Quest` int unsigned NOT NULL, `Spell` int unsigned NOT NULL, `missing` tinyint NOT NULL DEFAULT 0) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_gossip_add` (`GossipOptionID`, `CreatureID`, `MenuID`, `OptionText`, `BroadcastTextID`, `Quest`, `Spell`) VALUES
(98004941, 332, 4941, '<Take the letter>', 8548, 6681, 21100);
-- only where the option is not there yet, the creature uses this menu and has no C++ script
UPDATE `everlake_gossip_add` s SET s.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu_option` o WHERE o.`GossipOptionID` = s.`GossipOptionID`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gossip_menu_option' AND r.`k1` = s.`MenuID` AND r.`k3` = s.`GossipOptionID`)
  AND EXISTS (SELECT 1 FROM `creature_template_gossip` g WHERE g.`CreatureID` = s.`CreatureID` AND g.`MenuID` = s.`MenuID`)
  AND EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = s.`CreatureID` AND t.`ScriptName` = '' AND t.`AIName` IN ('', 'SmartAI'))
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` x WHERE x.`entryorguid` = s.`CreatureID` AND x.`source_type` = 0 AND x.`id` IN (90, 91))
  AND EXISTS (SELECT 1 FROM `smart_scripts` x WHERE x.`entryorguid` = 950000320 AND x.`source_type` = 9);
UPDATE `everlake_gossip_add` s
SET s.`OptionID` = (SELECT COALESCE(MAX(o.`OptionID`) + 1, 0) FROM `gossip_menu_option` o WHERE o.`MenuID` = s.`MenuID`)
WHERE s.`missing` = 1;
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`,
    `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`)
SELECT s.`MenuID`, s.`GossipOptionID`, s.`OptionID`, 0, s.`OptionText`, s.`BroadcastTextID`, 0, 0, 0, 0, NULL, 0, 0, '', 0, NULL, NULL, 0
FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 15, s.`MenuID`, s.`OptionID`, 0, 0, 2,0,17126,1,0,'',1, 0, 0, '', 'Mathias Shaw letter option - not holding Elegant Letter 17126' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 15, s.`MenuID`, s.`OptionID`, 0, 0, 14,0,6681,0,0,'',0, 0, 0, '', 'Mathias Shaw letter option - quest 6681 not taken' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 15, s.`MenuID`, s.`OptionID`, 0, 0, 15,0,8,0,0,'',0, 0, 0, '', 'Mathias Shaw letter option - rogue' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 15, s.`MenuID`, s.`OptionID`, 0, 0, 27,0,24,3,0,'',0, 0, 0, '', 'Mathias Shaw letter option - level 24 or higher' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 15, s.`MenuID`, s.`OptionID`, 2, '2026_11_26_19_world_everlake_mathias_shaw_ravenholdt_letter.sql', 'note 70959+1 2026-11-17 (Mathias Shaw gives the letter); copy of the rogue trainers option 4' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 15, s.`MenuID`, s.`OptionID`, 14, '2026_11_26_19_world_everlake_mathias_shaw_ravenholdt_letter.sql', 'note 70959+1 2026-11-17 (Mathias Shaw gives the letter); copy of the rogue trainers option 4' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 15, s.`MenuID`, s.`OptionID`, 15, '2026_11_26_19_world_everlake_mathias_shaw_ravenholdt_letter.sql', 'note 70959+1 2026-11-17 (Mathias Shaw gives the letter); copy of the rogue trainers option 4' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 15, s.`MenuID`, s.`OptionID`, 27, '2026_11_26_19_world_everlake_mathias_shaw_ravenholdt_letter.sql', 'note 70959+1 2026-11-17 (Mathias Shaw gives the letter); copy of the rogue trainers option 4' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
UPDATE `creature_template` t JOIN `everlake_gossip_add` s ON s.`CreatureID` = t.`entry`
SET t.`AIName` = 'SmartAI' WHERE s.`missing` = 1 AND t.`AIName` = '' AND t.`ScriptName` = '';
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT s.`CreatureID`, 0, 90, 91, '', 62, 0, 100, 0, s.`MenuID`, s.`OptionID`, 0, 0, 0, '', 72, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,
    CONCAT('On gossip option ', s.`MenuID`, '/', s.`OptionID`, ' (Take the letter) - Close gossip') FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT s.`CreatureID`, 0, 91, 0, '', 61, 0, 100, 0, 0, 0, 0, 0, 0, '', 80, 950000320, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0,
    'Linked - Run action list 950000320 (Conjure Elegant Letter 21100 on the invoker, as the rogue trainers)' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'gossip_menu_option', s.`MenuID`, s.`OptionID`, s.`GossipOptionID`, '2026_11_26_19_world_everlake_mathias_shaw_ravenholdt_letter.sql', 'note 70959+1 2026-11-17 (Mathias Shaw gives the letter); copy of the rogue trainers option 4' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'smart_scripts', s.`CreatureID`, 0, 90, '2026_11_26_19_world_everlake_mathias_shaw_ravenholdt_letter.sql', 'note 70959+1 2026-11-17 (Mathias Shaw gives the letter); copy of the rogue trainers option 4' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'smart_scripts', s.`CreatureID`, 0, 91, '2026_11_26_19_world_everlake_mathias_shaw_ravenholdt_letter.sql', 'note 70959+1 2026-11-17 (Mathias Shaw gives the letter); copy of the rogue trainers option 4' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_gossip_add`;
COMMIT;
