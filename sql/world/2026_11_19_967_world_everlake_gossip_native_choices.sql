-- Broken gossip choices (SmartAI event 62) that came with TrinityCore's own world data, not the VMaNGOS import.
-- 2026_11_19_967_world_everlake_gossip_native_choices.sql: written by hand, rows built from the sources named below.
--
-- 933-935 fixed the imported choices. The same audit found 118 TrinityCore rows on 42 creatures whose menu or option
-- is missing or never shown. Only 12 of those creatures are spawned and run SmartAI; the rest are left alone:
--   - 24 have no spawn. They live in Outland, Northrend or Cataclysm zones, and the client has no maps for those.
--   - Lady Jaina Proudmoore, "Plucky" Johnson, The Threshwackonator 4100 and Keeper Remulos run C++ scripts that do
--     their own gossip, so their SmartAI rows never run.
--   - Lyesa Steelbrow, Garyl, Thrumn, Merill Pleasance and Shalumon replace TBC and Wrath tabards. Those spells are
--     not in the client, so the choices stay off.
-- Sources: VMaNGOS db-70e38cd and AzerothCore's public world data (gossip_menu_option, conditions, smart_scripts).
-- Each option's text is the client's BroadcastText for its id. GossipOptionID for new rows: -(MenuID * 256 + OptionID).
-- Item spells are cast by the player on themselves (SELF_CAST, triggered), since a creature cannot create an item for
-- someone else.
--
-- 1. Beaten Corpse (10668), Lost in Battle (4921): the quest credit waited on menu 2871. The corpse's menu is 2881
--    ("I inspect the body further."), which VMaNGOS also credits.
-- 2. Mux Manascrambler (16014): the Extra-Dimensional Ghost Revealer waited on option 0. The realm's ghost revealer
--    choice is 7083/2, as on VMaNGOS.
-- 3. Itharius (5353): his line about the oathstone waited on menu 1364. The realm's conversation ends on 16035/0
--    ("I will consider what you have told me."), VMaNGOS's id for the same step, which VMaNGOS and AzerothCore answer
--    by giving the Oathstone of Ysera's Dragonflight (spell 12578, item 10589). The line now follows that choice and
--    the player gets the oathstone.
-- 4. Orphan Matrons Nightingale (14450) and Battlewail (14451): "Children's Week is not yet over... may I have another
--    Orphan Whistle?" (BroadcastText 9672) added as option 1 of their menus, shown while Children's Week (game event
--    10) runs and the player has no whistle.
-- 5. Falrin Treeshaper (16032): the Banner of Provocation (21986) for The Challenge (9015) waited on menu 7073. His
--    menu is 7084, which had no choices: "I believe I misplaced that banner you enchanted for me, Falrin."
--    (BroadcastText 11910) added, shown while 9015 is in the log and the player has no banner.
-- 6. Bodley (16033): the realm has AzerothCore's copy of his lost-item menus (57006-57019, with conditions), but
--    Bodley opens Blizzard's 7044, which only has the story. The three lost-item choices are added to 7044 as options
--    0-2 (Blizzard's order) with the same conditions, leading to the existing 57014, 57015 and 57018. The amulet waited
--    on 57006/3 (the story choice of the unused copy) and now follows 7044/0.
-- 7. Content after Wrath is not wanted on this realm. The gossip rows of Budding Artist (47707), Asaq (47930) and the
--    Darkmoon Faire Greeter (54345), all Cataclysm and unspawned, are removed. So are the Cenarion Emissaries' (15187,
--    15188) Cataclysm teleports to Moonglade (86565, 86587; not in the client), on menus they never show.
--
-- Rows changed only while they are still the TrinityCore ones. Not checked in game.
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

START TRANSACTION;

-- gossip_menu_option: the missing choices
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`MenuID` int unsigned NOT NULL, `GossipOptionID` int NOT NULL, `OptionID` int unsigned NOT NULL, `OptionText` mediumtext, `OptionBroadcastTextID` int unsigned NOT NULL, `ActionMenuID` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`MenuID`, `OptionID`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionText`, `OptionBroadcastTextID`, `ActionMenuID`, `note`) VALUES
(5849, -1497345, 1, 'Children''s Week is not yet over... may I have another Orphan Whistle?', 9672, 0, 'azerothcore+broadcast_text'), -- Orphan Matron Nightingale
(5848, -1497089, 1, 'Children''s Week is not yet over... may I have another Orphan Whistle?', 9672, 0, 'azerothcore+broadcast_text'), -- Orphan Matron Battlewail
(7084, -1813504, 0, 'I believe I misplaced that banner you enchanted for me, Falrin.', 11910, 0, 'broadcast_text'), -- Falrin Treeshaper
(7044, -1803264, 0, 'I lost Lord Valthalak''s Amulet!', 11773, 57014, 'azerothcore+broadcast_text'), -- Bodley
(7044, -1803265, 1, 'I lost a piece of Lord Valthalak''s Amulet!', 11776, 57015, 'azerothcore+broadcast_text'), -- Bodley
(7044, -1803266, 2, 'I''ve misplaced the Brazier of Beckoning!', 11784, 57018, 'azerothcore+broadcast_text'); -- Bodley
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu_option` t WHERE t.`MenuID` = s.`MenuID` AND t.`OptionID` = s.`OptionID`);
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`, `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`)
SELECT `MenuID`, `GossipOptionID`, `OptionID`, 0, `OptionText`, `OptionBroadcastTextID`, 0, 0, `ActionMenuID`, 0, NULL, 0, 0, '', 0, NULL, NULL, 0 FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'gossip_menu_option', s.`MenuID`, s.`OptionID`, '2026_11_19_967_world_everlake_gossip_native_choices.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_19_967_world_everlake_gossip_native_choices.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

-- conditions (source type 15 = gossip option; ElseGroup = one way in). Bodley's are the realm's 57006 ones on 7044.
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`SourceTypeOrReferenceId` int NOT NULL, `SourceGroup` int unsigned NOT NULL, `SourceEntry` int NOT NULL, `SourceId` int NOT NULL, `ElseGroup` int unsigned NOT NULL, `ConditionTypeOrReference` int NOT NULL, `ConditionTarget` tinyint unsigned NOT NULL, `ConditionValue1` int unsigned NOT NULL, `ConditionValue2` int unsigned NOT NULL, `ConditionValue3` int unsigned NOT NULL, `NegativeCondition` tinyint unsigned NOT NULL, `Comment` varchar(255) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(15, 5849, 1, 0, 0, 12, 0, 10, 0, 0, 0, 'Orphan Matron Nightingale - option 5849/1 - Children''s Week running'),
(15, 5849, 1, 0, 0, 2, 0, 18598, 1, 1, 1, 'Orphan Matron Nightingale - option 5849/1 - not has item 18598'),
(15, 5848, 1, 0, 0, 12, 0, 10, 0, 0, 0, 'Orphan Matron Battlewail - option 5848/1 - Children''s Week running'),
(15, 5848, 1, 0, 0, 2, 0, 18597, 1, 1, 1, 'Orphan Matron Battlewail - option 5848/1 - not has item 18597'),
(15, 7084, 0, 0, 0, 9, 0, 9015, 0, 0, 0, 'Falrin Treeshaper - option 7084/0 - quest taken 9015'),
(15, 7084, 0, 0, 0, 2, 0, 21986, 1, 1, 1, 'Falrin Treeshaper - option 7084/0 - not has item 21986'),
(15, 7044, 0, 0, 0, 2, 0, 22048, 1, 0, 1, 'Bodley - option 7044/0 - not has item 22048'),
(15, 7044, 0, 0, 0, 8, 0, 8994, 0, 0, 0, 'Bodley - option 7044/0 - quest rewarded 8994'),
(15, 7044, 0, 0, 0, 8, 0, 8995, 0, 0, 1, 'Bodley - option 7044/0 - quest not rewarded 8995'),
(15, 7044, 1, 0, 0, 2, 0, 21984, 1, 0, 1, 'Bodley - option 7044/1 - not has item 21984'),
(15, 7044, 1, 0, 0, 8, 0, 8966, 0, 0, 0, 'Bodley - option 7044/1 - quest rewarded 8966'),
(15, 7044, 1, 0, 0, 8, 0, 8995, 0, 0, 1, 'Bodley - option 7044/1 - quest not rewarded 8995'),
(15, 7044, 1, 0, 1, 2, 0, 21984, 1, 0, 1, 'Bodley - option 7044/1 - not has item 21984'),
(15, 7044, 1, 0, 1, 8, 0, 8967, 0, 0, 0, 'Bodley - option 7044/1 - quest rewarded 8967'),
(15, 7044, 1, 0, 1, 8, 0, 8995, 0, 0, 1, 'Bodley - option 7044/1 - quest not rewarded 8995'),
(15, 7044, 1, 0, 2, 2, 0, 21984, 1, 0, 1, 'Bodley - option 7044/1 - not has item 21984'),
(15, 7044, 1, 0, 2, 8, 0, 8968, 0, 0, 0, 'Bodley - option 7044/1 - quest rewarded 8968'),
(15, 7044, 1, 0, 2, 8, 0, 8995, 0, 0, 1, 'Bodley - option 7044/1 - quest not rewarded 8995'),
(15, 7044, 1, 0, 3, 2, 0, 21984, 1, 0, 1, 'Bodley - option 7044/1 - not has item 21984'),
(15, 7044, 1, 0, 3, 8, 0, 8969, 0, 0, 0, 'Bodley - option 7044/1 - quest rewarded 8969'),
(15, 7044, 1, 0, 3, 8, 0, 8995, 0, 0, 1, 'Bodley - option 7044/1 - quest not rewarded 8995'),
(15, 7044, 1, 0, 4, 2, 0, 22047, 1, 0, 1, 'Bodley - option 7044/1 - not has item 22047'),
(15, 7044, 1, 0, 4, 8, 0, 8995, 0, 0, 1, 'Bodley - option 7044/1 - quest not rewarded 8995'),
(15, 7044, 1, 0, 4, 8, 0, 9015, 0, 0, 0, 'Bodley - option 7044/1 - quest rewarded 9015'),
(15, 7044, 2, 0, 0, 2, 0, 22056, 1, 0, 1, 'Bodley - option 7044/2 - not has item 22056'),
(15, 7044, 2, 0, 0, 8, 0, 8995, 0, 0, 0, 'Bodley - option 7044/2 - quest rewarded 8995'),
(15, 7044, 2, 0, 0, 8, 0, 8996, 0, 0, 1, 'Bodley - option 7044/2 - quest not rewarded 8996');
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT s.`SourceTypeOrReferenceId`, s.`SourceGroup`, s.`SourceEntry`, s.`SourceId`, s.`ElseGroup`, s.`ConditionTypeOrReference`, s.`ConditionTarget`, s.`ConditionValue1`, s.`ConditionValue2`, s.`ConditionValue3`, '', s.`NegativeCondition`, 0, 0, '', s.`Comment` FROM `everlake_import_stage` s
WHERE NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = s.`SourceTypeOrReferenceId` AND c.`SourceGroup` = s.`SourceGroup` AND c.`SourceEntry` = s.`SourceEntry` AND c.`SourceId` = s.`SourceId` AND c.`ElseGroup` = s.`ElseGroup` AND c.`ConditionTypeOrReference` = s.`ConditionTypeOrReference` AND c.`ConditionTarget` = s.`ConditionTarget` AND c.`ConditionValue1` = s.`ConditionValue1` AND c.`ConditionValue2` = s.`ConditionValue2` AND c.`ConditionValue3` = s.`ConditionValue3`);
DROP TEMPORARY TABLE `everlake_import_stage`;

-- smart_scripts
UPDATE `smart_scripts` SET `event_param1` = 2881, `comment` = 'Beaten Corpse - On gossip 2881/0 - Quest credit Lost in Battle' WHERE `entryorguid` = 10668 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `event_param1` = 2871 AND `event_param2` = 0;
UPDATE `smart_scripts` SET `event_param2` = 2, `comment` = 'Mux Manascrambler - On gossip 7083/2 - Add item Extra-Dimensional Ghost Revealer' WHERE `entryorguid` = 16014 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `event_param1` = 7083 AND `event_param2` = 0 AND `action_type` = 56 AND `action_param1` = 22115;
UPDATE `smart_scripts` SET `event_param1` = 7084, `comment` = 'Falrin Treeshaper - On gossip 7084/0 - Add item Banner of Provocation' WHERE `entryorguid` = 16032 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `event_param1` = 7073 AND `event_param2` = 0 AND `action_type` = 56 AND `action_param1` = 21986;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Orphan Matron Nightingale - On gossip 5849/1 - Invoker casts Human Orphan Whistle' WHERE `entryorguid` = 14450 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 62 AND `event_param1` = 5849 AND `event_param2` = 1 AND `action_type` = 11 AND `action_param1` = 23124;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Orphan Matron Battlewail - On gossip 5848/1 - Invoker casts Orcish Orphan Whistle' WHERE `entryorguid` = 14451 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 62 AND `event_param1` = 5848 AND `event_param2` = 1 AND `action_type` = 11 AND `action_param1` = 23125;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Bodley - On gossip 57015/0 - Invoker casts Create Replacement Top Piece of Lord Valthalak''s Amulet' WHERE `entryorguid` = 16033 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `event_param1` = 57015 AND `event_param2` = 0 AND `action_type` = 11 AND `action_param1` = 27542;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Bodley - On gossip 57015/1 - Invoker casts Create Replacement Left Piece of Lord Valthalak''s Amulet' WHERE `entryorguid` = 16033 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 62 AND `event_param1` = 57015 AND `event_param2` = 1 AND `action_type` = 11 AND `action_param1` = 27544;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Bodley - On gossip 57018/0 - Invoker casts Create Replacement Brazier of Beckoning' WHERE `entryorguid` = 16033 AND `source_type` = 0 AND `id` = 2 AND `event_type` = 62 AND `event_param1` = 57018 AND `event_param2` = 0 AND `action_type` = 11 AND `action_param1` = 27566;
UPDATE `smart_scripts` SET `event_param1` = 7044, `event_param2` = 0, `action_type` = 85, `action_param2` = 2, `target_type` = 7, `comment` = 'Bodley - On gossip 7044/0 - Invoker casts Create Replacement Lord Valthalak''s Amulet' WHERE `entryorguid` = 16033 AND `source_type` = 0 AND `id` = 3 AND `event_type` = 62 AND `event_param1` = 57006 AND `event_param2` = 3 AND `action_type` = 11 AND `action_param1` = 27537;

-- Itharius: his line follows the end of the conversation (16035/0) and links to the oathstone, cast by the player
UPDATE `smart_scripts` SET `link` = 3, `event_param1` = 16035, `target_type` = 7, `comment` = 'Itharius - On gossip 16035/0 - Say line 0' WHERE `entryorguid` = 5353 AND `source_type` = 0 AND `id` = 2 AND `event_type` = 62 AND `event_param1` = 1364 AND `event_param2` = 0 AND `action_type` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `action_param_string`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_param_string`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 5353, 0, 3, 0, '', 61, 0, 100, 0, 0, 0, 0, 0, 0, '', 85, 12578, 2, 0, 0, 0, 0, 0, '', 7, 0, 0, 0, 0, '', 0, 0, 0, 0, 'Itharius - Linked - Invoker casts Create Oathstone of Ysera''s Dragonflight'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `smart_scripts` WHERE `entryorguid` = 5353 AND `source_type` = 0 AND `id` = 3)
AND EXISTS (SELECT 1 FROM `smart_scripts` WHERE `entryorguid` = 5353 AND `source_type` = 0 AND `id` = 2 AND `link` = 3);
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'smart_scripts', 5353, 0, 3, 0, '2026_11_19_967_world_everlake_gossip_native_choices.sql', 'vmangos-70e38cd+azerothcore' FROM DUAL
WHERE EXISTS (SELECT 1 FROM `smart_scripts` WHERE `entryorguid` = 5353 AND `source_type` = 0 AND `id` = 3 AND `action_param1` = 12578)
ON DUPLICATE KEY UPDATE `file` = '2026_11_19_967_world_everlake_gossip_native_choices.sql';

-- Cataclysm gossip rows: unspawned NPCs, and the emissaries' teleports to Moonglade (not in the client)
DELETE FROM `smart_scripts` WHERE `entryorguid` = 47707 AND `source_type` = 0 AND `id` IN (0, 1) AND `event_type` IN (61, 62) AND `action_type` IN (72, 85);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 47930 AND `source_type` = 0 AND `id` IN (0, 1) AND `event_type` IN (61, 62) AND `action_type` IN (72, 134);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 54345 AND `source_type` = 0 AND `id` IN (0, 1) AND `event_type` = 62 AND `event_param1` = 13113;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15187 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `action_type` = 86 AND `action_param1` = 86587;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 15188 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `action_type` = 86 AND `action_param1` = 86565;

COMMIT;
