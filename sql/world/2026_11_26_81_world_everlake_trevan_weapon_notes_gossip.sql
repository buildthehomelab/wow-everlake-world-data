-- 95036 A Moon-Kissed Blade (Horde paladin, Lumina Windsinger 259620 -> Trevan Rol 248840, the Sepulcher): objective 1
-- "Collect the note from Trevan" is Trevan's Weapon Notes 267454. On the realm Trevan has no gossip menu, so nothing
-- gives the note and the quest cannot be completed.
-- 2026_11_26_81_world_everlake_trevan_weapon_notes_gossip.sql: written by hand, not tried in game (2026-11-26).
--
-- How live does it (sources):
--   Client DB2: Trevan's Weapon Notes (1280553) creates 267454 on the caster (SpellEffect 0, target 1).
--   Icy Veins npc 248840 (addon gossip): option 138494 "Tell me about how to forge the weapon we need to destroy Old
--     Fire-Eye." opens a page that ends with option 138493 "<Reach out your hand and take the note from Trevan.>".
--   EG Link npcs (build 70938, CC BY 4.0): Trevan Rol has Gossip + QuestGiver and option 138494 with that text.
--   Wowhead item 267454: created by spell 1280553; objective of 95036 only.
-- The page texts have no BroadcastText on the realm (neither the client's BroadcastText.db2 nor hotfixes have them),
-- so this does not rebuild the two pages. Trevan gets one menu, 920020301, with the realm's usual greeting (npc_text 68,
-- "Greetings, $n.", used by 840 menus) and Blizzard's last option 138493 with its live text. Choosing it makes the
-- player cast Trevan's Weapon Notes on themselves, so the note comes from the client's own spell.
-- The option shows while 95036 is in the log and not complete and the player has no note (INFERRED: the live
-- conditions are not public). Only while Trevan has no menu, no script and no SmartAI rows.
-- Each added row is recorded in everlake_import_rows.
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
SET @EVERLAKE_FILE := '2026_11_26_81_world_everlake_trevan_weapon_notes_gossip.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_trevan_stage`;
CREATE TEMPORARY TABLE `everlake_trevan_stage` (`ok` tinyint NOT NULL) ENGINE=InnoDB;
INSERT INTO `everlake_trevan_stage` (`ok`)
SELECT 1 FROM `creature_template` t
WHERE t.`entry` = 248840 AND t.`ScriptName` = '' AND t.`AIName` IN ('', 'SmartAI')
  AND NOT EXISTS (SELECT 1 FROM `creature_template_gossip` g WHERE g.`CreatureID` = 248840)
  AND NOT EXISTS (SELECT 1 FROM `gossip_menu` m WHERE m.`MenuID` = 920020301)
  AND NOT EXISTS (SELECT 1 FROM `gossip_menu_option` o WHERE o.`MenuID` = 920020301 OR o.`GossipOptionID` = 138493)
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` x WHERE x.`entryorguid` = 248840 AND x.`source_type` = 0)
  AND EXISTS (SELECT 1 FROM `npc_text` n WHERE n.`ID` = 68);

INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`)
SELECT 920020301, 68, 0 FROM `everlake_trevan_stage` WHERE `ok` = 1;
INSERT INTO `creature_template_gossip` (`CreatureID`, `MenuID`, `VerifiedBuild`)
SELECT 248840, 920020301, 0 FROM `everlake_trevan_stage` WHERE `ok` = 1;
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`,
    `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`)
SELECT 920020301, 138493, 0, 0, '<Reach out your hand and take the note from Trevan.>', 0, 0, 0, 0, 0, NULL, 0, 0, '', 0, NULL, NULL, 0
FROM `everlake_trevan_stage` WHERE `ok` = 1;

-- option conditions: 95036 incomplete, no note yet
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 15, 920020301, 0, 0, 0, 47, 0, 95036, 8, 0, '', 0, 0, 0, '', 'Trevan Rol - take the note - A Moon-Kissed Blade (95036) incomplete'
FROM `everlake_trevan_stage` WHERE `ok` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 15, 920020301, 0, 0, 0, 2, 0, 267454, 1, 0, '', 1, 0, 0, '', 'Trevan Rol - take the note - not holding Trevan''s Weapon Notes 267454'
FROM `everlake_trevan_stage` WHERE `ok` = 1;

-- choosing it: close the window, the player casts Trevan's Weapon Notes (1280553, triggered) on themselves
UPDATE `creature_template` t JOIN `everlake_trevan_stage` s ON s.`ok` = 1
SET t.`AIName` = 'SmartAI' WHERE t.`entry` = 248840 AND t.`AIName` = '' AND t.`ScriptName` = '';
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 248840, 0, 0, 1, '', 62, 0, 100, 0, 920020301, 0, 0, 0, 0, '', 72, 0, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,
    'Trevan Rol - On gossip option 920020301/0 (take the note) - Close gossip'
FROM `everlake_trevan_stage` WHERE `ok` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 248840, 0, 1, 0, '', 61, 0, 100, 0, 0, 0, 0, 0, 0, '', 85, 1280553, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0,
    'Trevan Rol - Linked - Invoker casts Trevan''s Weapon Notes 1280553 on self (gives 267454)'
FROM `everlake_trevan_stage` WHERE `ok` = 1;

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gossip_menu', 920020301, 68, 0, 0, @EVERLAKE_FILE, 'realm greeting npc_text 68; live page texts have no BroadcastText'
FROM `gossip_menu` m WHERE m.`MenuID` = 920020301 AND m.`TextID` = 68;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_gossip', 248840, 920020301, 0, 0, @EVERLAKE_FILE, 'Icy Veins + EG Link: Trevan Rol has gossip'
FROM `creature_template_gossip` g WHERE g.`CreatureID` = 248840 AND g.`MenuID` = 920020301;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gossip_menu_option', 920020301, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins npc 248840 gossip option 138493 text'
FROM `gossip_menu_option` o WHERE o.`MenuID` = 920020301 AND o.`OptionID` = 0 AND o.`GossipOptionID` = 138493;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 15, 920020301, 0, c.`ConditionTypeOrReference`, @EVERLAKE_FILE, 'INFERRED option conditions'
FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 15 AND c.`SourceGroup` = 920020301 AND c.`SourceEntry` = 0 AND c.`ConditionTypeOrReference` IN (2, 47);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', 248840, 0, x.`id`, 0, @EVERLAKE_FILE, 'client SpellEffect 1280553 creates 267454'
FROM `smart_scripts` x WHERE x.`entryorguid` = 248840 AND x.`source_type` = 0 AND x.`id` IN (0, 1)
  AND (x.`event_param1` = 920020301 OR x.`action_param1` = 1280553);

DROP TEMPORARY TABLE IF EXISTS `everlake_trevan_stage`;

COMMIT;
