-- Players who finished their class mount quest before it taught Journeyman Riding can learn it for free by gossip.
-- 2026_11_26_13_world_everlake_free_journeyman_riding_gossip.sql: written by hand from the tracker's kept facts (2026-11-26).
--
-- Blizzard's server-side note of 25 November 2026 (step 71139+1): "Any player who has already completed these quests can
-- speak with the following NPCs to get a special gossip option to allow them to learn Journeyman Riding for free.":
-- Danitha Morr (Forsaken paladins), Lord Grayson Shadowbreaker (Alliance paladins), Zevrost and Ursula Deline
-- (warlocks). The same day's hotfix (the core's 2026_11_26_00 hotfix file) gave each quest's reward spell a second
-- effect that teaches Journeyman Riding 33391: 1296537 (Justice and Retribution 97185), 23215 (Judgment and Redemption
-- 7647) and 23160 (Dreadsteed of Xoroth 7631). So the option makes the player cast their quest's reward spell again
-- (SmartAI action 134, triggered: free), which teaches 33391 and the mount they already know.
--
--   Danitha Morr 246378, menu 39689, quest 97185, spell 1296537
--   Lord Grayson Shadowbreaker 928, menu 4471, quest 7647, spell 23215
--   Zevrost 3326, menu 2384, quest 7631, spell 23160
--   Ursula Deline 5495, menu 4505, quest 7631, spell 23160
--
-- The option shows only when the quest is rewarded and 33391 is not known. No source records live's option text, so
-- the text here is Everlake's own wording. GossipOptionID 98000000 + menu id (a new block); OptionID is the menu's next
-- free one; SmartAI ids 90/91 on each creature (928 already has SmartAI; the other three had no AI or script).
-- The core has no script for these four creatures (checked: no ScriptName, no C++ by entry).
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
(98039689, 246378, 39689, 'I have earned my mount. Please teach me Journeyman Riding.', 0, 97185, 1296537),
(98004471, 928, 4471, 'I have earned my mount. Please teach me Journeyman Riding.', 0, 7647, 23215),
(98002384, 3326, 2384, 'I have earned my mount. Please teach me Journeyman Riding.', 0, 7631, 23160),
(98004505, 5495, 4505, 'I have earned my mount. Please teach me Journeyman Riding.', 0, 7631, 23160);
-- only where the option is not there yet, the creature uses this menu and has no C++ script
UPDATE `everlake_gossip_add` s SET s.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu_option` o WHERE o.`GossipOptionID` = s.`GossipOptionID`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gossip_menu_option' AND r.`k1` = s.`MenuID` AND r.`k3` = s.`GossipOptionID`)
  AND EXISTS (SELECT 1 FROM `creature_template_gossip` g WHERE g.`CreatureID` = s.`CreatureID` AND g.`MenuID` = s.`MenuID`)
  AND EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = s.`CreatureID` AND t.`ScriptName` = '' AND t.`AIName` IN ('', 'SmartAI'))
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` x WHERE x.`entryorguid` = s.`CreatureID` AND x.`source_type` = 0 AND x.`id` IN (90, 91));
UPDATE `everlake_gossip_add` s
SET s.`OptionID` = (SELECT COALESCE(MAX(o.`OptionID`) + 1, 0) FROM `gossip_menu_option` o WHERE o.`MenuID` = s.`MenuID`)
WHERE s.`missing` = 1;
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`,
    `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`)
SELECT s.`MenuID`, s.`GossipOptionID`, s.`OptionID`, 0, s.`OptionText`, s.`BroadcastTextID`, 0, 0, 0, 0, NULL, 0, 0, '', 0, NULL, NULL, 0
FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 15, s.`MenuID`, s.`OptionID`, 0, 0, 8, 0, s.`Quest`, 0, 0, '', 0, 0, 0, '', CONCAT('Journeyman Riding option - quest ', s.`Quest`, ' rewarded') FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 15, s.`MenuID`, s.`OptionID`, 0, 0, 25, 0, 33391, 0, 0, '', 1, 0, 0, '', 'Journeyman Riding option - Journeyman Riding 33391 not known' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 15, s.`MenuID`, s.`OptionID`, 8, '2026_11_26_13_world_everlake_free_journeyman_riding_gossip.sql', 'note 71139+1 2026-11-25 (free Journeyman Riding gossip); option text Everlake wording' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 15, s.`MenuID`, s.`OptionID`, 25, '2026_11_26_13_world_everlake_free_journeyman_riding_gossip.sql', 'note 71139+1 2026-11-25 (free Journeyman Riding gossip); option text Everlake wording' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
UPDATE `creature_template` t JOIN `everlake_gossip_add` s ON s.`CreatureID` = t.`entry`
SET t.`AIName` = 'SmartAI' WHERE s.`missing` = 1 AND t.`AIName` = '' AND t.`ScriptName` = '';
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT s.`CreatureID`, 0, 90, 91, '', 62, 0, 100, 0, s.`MenuID`, s.`OptionID`, 0, 0, 0, '', 72, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,
    CONCAT('On gossip option ', s.`MenuID`, '/', s.`OptionID`, ' (Journeyman Riding) - Close gossip') FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT s.`CreatureID`, 0, 91, 0, '', 61, 0, 100, 0, 0, 0, 0, 0, 0, '', 134, s.`Spell`, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,
    CONCAT('Linked - Invoker casts ', s.`Spell`, ' (quest ', s.`Quest`, ' reward spell, teaches Journeyman Riding 33391 since the 71139 hotfix)') FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'gossip_menu_option', s.`MenuID`, s.`OptionID`, s.`GossipOptionID`, '2026_11_26_13_world_everlake_free_journeyman_riding_gossip.sql', 'note 71139+1 2026-11-25 (free Journeyman Riding gossip); option text Everlake wording' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'smart_scripts', s.`CreatureID`, 0, 90, '2026_11_26_13_world_everlake_free_journeyman_riding_gossip.sql', 'note 71139+1 2026-11-25 (free Journeyman Riding gossip); option text Everlake wording' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'smart_scripts', s.`CreatureID`, 0, 91, '2026_11_26_13_world_everlake_free_journeyman_riding_gossip.sql', 'note 71139+1 2026-11-25 (free Journeyman Riding gossip); option text Everlake wording' FROM `everlake_gossip_add` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_gossip_add`;
COMMIT;
