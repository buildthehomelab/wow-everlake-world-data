-- The last held gossip choices from the VMaNGOS script import: five conversations finished, Rabine's put in order,
-- Old Ironbark's door, and the replacement items from Raene, Rexxar and the Fallen Hero, plus Regthar's attack.
-- 2026_11_19_935_world_everlake_gossip_conversations.sql: written by hand, rows built from the sources named below.
--
-- 2026_11_19_933 fixed 132 of the 144 broken imported choices and held the rest. These are the held ones (Spirit of
-- Azuregos was fixed by 932). Source for every menu, option and condition: VMaNGOS db-70e38cd, which uses Blizzard's
-- menu ids. Each option's text is the client's BroadcastText for its id, and every npc_text a new menu needs is
-- already on the realm. GossipOptionID for new rows: -(MenuID * 256 + OptionID), the realm's rule.
--
-- 1. Conversations the realm stops partway through. The quest credit waits on the last choice.
--    Thrall (4949): menus 3668-3670 added, the end is "Of course, Warchief!" (What the Wind Carries, 6566).
--    Loramus Thalipedes (7783): 1184-1185 added, ends with "Yes." (Loramus Thalipedes, 3141).
--    Ragged John (9563): 2071-2064 added, ends with "Thanks, Ragged John..." (The True Masters, 4224).
--    Magistrate Marduke (11286): the menus were there, the choices 3368-3364 were not; the last one gives Caer Darrow
--    reputation (17681), now cast by the player on themselves.
--    Eitrigg (3144): the realm's menus 2902-2904 held an older copy of the conversation's first steps, which nothing
--    reached, and "I will take you up on that offer" (2905/0) looped back to 2906. 2902-2904 now hold the last three
--    steps, as on VMaNGOS, and 2905/0 leads to 2904. "As you wish, Eitrigg." completes Eitrigg's Wisdom (4941).
--    Those rows are not sniffed (VerifiedBuild 0, made-up GossipOptionIDs).
-- 2. Rabine Saturna (11801): menus 5767 and 5768 had their texts and choices swapped, so "What would you have me do,
--    Rabine?" sat on the wrong menu with the wrong BroadcastText id (6089). Put back as on VMaNGOS. VMaNGOS then adds
--    its own aura 33006 to unlock A Reliquary of Purity (5527). That spell is not in the client, and the realm offers
--    5527 without it, so the cast is removed and Rabine's line stays.
-- 3. Old Ironbark (11491, Dire Maul): VMaNGOS turns him into Ironbark the Redeemed (14241) only once Zevrim Thornhoof
--    is dead (instance data 4 = DONE). The import lost that condition, so he changed as soon as he spawned. It is back,
--    as a SmartAI event condition on the creature itself. As 14241 his menu is 5602 (sniffed), so his choice now waits
--    on 5602/0, the sniffed "Thank you, Ironbark. We are ready for you to open the door." The script sets instance data
--    5 to DONE, which the core's Dire Maul script answers by opening the door. The option hides once that is done.
-- 4. Raene Wolfrunner (3691): replaces Dartol's Rod of Transformation (5462). VMaNGOS offers it while Raene's
--    Cleansing (1045) is still available to take. That is written as: 1030 rewarded (1045's previous quest on the
--    realm too) and 1045 not taken or done.
-- 5. Fallen Hero of the Horde (7572), 840/2: summons Corporal Thund Splithoof. VMaNGOS: no Splithoof alive within 50,
--    and Heroes of Old (2701) available or 2702 or 2701 in the log. "Available" is again 2702 rewarded and 2701 not
--    taken or done.
-- 6. Rexxar (10182): replaces the Drakefire Amulet after Blood of the Black Dragon Champion (6602). The client's
--    BroadcastText 9014 for this option says "Rokaro, ..." (Rokaro 200654 is a template with no spawn, gossip or
--    quests). So the option has VMaNGOS's "Rexxar, ..." text and no BroadcastText id. The amulet is cast by the player.
-- 7. Regthar Deathgate (3389): "Where is Warlord Krom'zar?" starts the Kolkar attack for Counterattack! (4021).
--    VMaNGOS allows it only while that attack is not running. Here the option hides while a Kolkar Invader or
--    Stormseer is alive within 200 yards: only this attack spawns them there (60 seconds each).
--
-- Rows changed only while they are still the imported or older ones. Not checked in game.
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

-- gossip_menu: the conversation steps the realm lacks (their npc_text rows are on the realm)
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`MenuID` int unsigned NOT NULL, `TextID` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`MenuID`, `TextID`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`MenuID`, `TextID`, `note`) VALUES
(3668, 5736, 'vmangos-70e38cd'), -- Thrall
(3669, 5737, 'vmangos-70e38cd'), -- Thrall
(3670, 5738, 'vmangos-70e38cd'), -- Thrall
(1184, 1816, 'vmangos-70e38cd'), -- Loramus Thalipedes
(1185, 1817, 'vmangos-70e38cd'), -- Loramus Thalipedes
(2071, 2717, 'vmangos-70e38cd'), -- Ragged John
(2070, 2718, 'vmangos-70e38cd'), -- Ragged John
(2069, 2719, 'vmangos-70e38cd'), -- Ragged John
(2068, 2720, 'vmangos-70e38cd'), -- Ragged John
(2067, 2721, 'vmangos-70e38cd'), -- Ragged John
(2066, 2722, 'vmangos-70e38cd'), -- Ragged John
(2065, 2723, 'vmangos-70e38cd'), -- Ragged John
(2064, 2725, 'vmangos-70e38cd'); -- Ragged John
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu` t WHERE t.`MenuID` = s.`MenuID`);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`) SELECT `MenuID`, `TextID`, 0 FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'gossip_menu', s.`MenuID`, s.`TextID`, '2026_11_19_935_world_everlake_gossip_conversations.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_19_935_world_everlake_gossip_conversations.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

-- gossip_menu_option: the missing choices
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`MenuID` int unsigned NOT NULL, `GossipOptionID` int NOT NULL, `OptionID` int unsigned NOT NULL, `OptionText` mediumtext, `OptionBroadcastTextID` int unsigned NOT NULL, `ActionMenuID` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`MenuID`, `OptionID`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionText`, `OptionBroadcastTextID`, `ActionMenuID`, `note`) VALUES
(3668, -939008, 0, 'I... I did not think of it that way, Warchief.', 8316, 3669, 'vmangos-70e38cd+broadcast_text'), -- Thrall
(3669, -939264, 0, 'I live only to serve, Warchief! My life is empty and meaningless without your guidance.', 8318, 3670, 'vmangos-70e38cd+broadcast_text'), -- Thrall
(3670, -939520, 0, 'Of course, Warchief!', 8320, 0, 'vmangos-70e38cd+broadcast_text'), -- Thrall
(1184, -303104, 0, 'I will do this with or without your help, Loramus.\n', 4254, 1185, 'vmangos-70e38cd+broadcast_text'), -- Loramus Thalipedes
(1185, -303360, 0, 'Yes.\n', 4256, 0, 'vmangos-70e38cd+broadcast_text'), -- Loramus Thalipedes
(2071, -530176, 0, 'Interesting... continue, John.', 5017, 2070, 'vmangos-70e38cd+broadcast_text'), -- Ragged John
(2070, -529920, 0, 'So that''s how Windsor died...', 5019, 2069, 'vmangos-70e38cd+broadcast_text'), -- Ragged John
(2069, -529664, 0, 'So how did he die?', 5021, 2068, 'vmangos-70e38cd+broadcast_text'), -- Ragged John
(2068, -529408, 0, 'Ok, so where the hell is he? Wait a minute! Are you drunk?', 5024, 2067, 'vmangos-70e38cd+broadcast_text'), -- Ragged John
(2067, -529152, 0, 'WHY is he in Blackrock Depths?', 5027, 2066, 'vmangos-70e38cd+broadcast_text'), -- Ragged John
(2066, -528896, 0, '300? So the Dark Irons killed him and dragged him into the Depths?', 5030, 2065, 'vmangos-70e38cd+broadcast_text'), -- Ragged John
(2065, -528640, 0, 'Ahhh... Ironfoe.\n', 5034, 2064, 'vmangos-70e38cd+broadcast_text'), -- Ragged John
(2064, -528384, 0, 'Thanks, Ragged John. Your story was very uplifting and informative. ', 5038, 0, 'vmangos-70e38cd+broadcast_text'), -- Ragged John
(3368, -862208, 0, 'What is this plan?', 6850, 3367, 'vmangos-70e38cd+broadcast_text'), -- Magistrate Marduke
(3367, -861952, 0, 'Ras Frostwhat? Who is that?', 6852, 3366, 'vmangos-70e38cd+broadcast_text'), -- Magistrate Marduke
(3366, -861696, 0, 'Continue, please.\n', 6854, 3365, 'vmangos-70e38cd+broadcast_text'), -- Magistrate Marduke
(3365, -861440, 0, 'Yes I do.', 6856, 3364, 'vmangos-70e38cd+broadcast_text'), -- Magistrate Marduke
(3364, -861184, 0, 'Yes I am.', 6858, 0, 'vmangos-70e38cd+broadcast_text'), -- Magistrate Marduke
(5502, -1408512, 0, 'Raene, I lost Dartol''s Rod of Transformation.', 9025, 5501, 'vmangos-70e38cd+broadcast_text'), -- Raene Wolfrunner
(840, -215042, 2, 'Hero, I have urgent business with Corporal Splithoof.', 3763, 0, 'vmangos-70e38cd+broadcast_text'), -- Fallen Hero of the Horde
(1882, -481792, 0, 'Where is Warlord Krom''zar?', 4793, 1883, 'vmangos-70e38cd+broadcast_text'), -- Regthar Deathgate
(5481, -1403136, 0, 'Rexxar, I have lost the Drakefire Amulet. Could another be created?', 0, 0, 'vmangos-70e38cd'); -- Rexxar
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu_option` t WHERE t.`MenuID` = s.`MenuID` AND t.`OptionID` = s.`OptionID`);
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`, `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`)
SELECT `MenuID`, `GossipOptionID`, `OptionID`, 0, `OptionText`, `OptionBroadcastTextID`, 0, 0, `ActionMenuID`, 0, NULL, 0, 0, '', 0, NULL, NULL, 0 FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`) SELECT 'gossip_menu_option', s.`MenuID`, s.`OptionID`, '2026_11_19_935_world_everlake_gossip_conversations.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_19_935_world_everlake_gossip_conversations.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

-- Eitrigg: the realm's 2902-2904 hold an older copy of the first steps; they become the last steps, as on VMaNGOS
UPDATE `gossip_menu` SET `TextID` = 3580 WHERE `MenuID` = 2902 AND `TextID` = 3574 AND NOT EXISTS (SELECT 1 FROM (SELECT `MenuID` FROM `gossip_menu` WHERE `MenuID` = 2902 AND `TextID` = 3580) x);
UPDATE `gossip_menu` SET `TextID` = 3579 WHERE `MenuID` = 2903 AND `TextID` = 3575 AND NOT EXISTS (SELECT 1 FROM (SELECT `MenuID` FROM `gossip_menu` WHERE `MenuID` = 2903 AND `TextID` = 3579) x);
UPDATE `gossip_menu` SET `TextID` = 3578 WHERE `MenuID` = 2904 AND `TextID` = 3576 AND NOT EXISTS (SELECT 1 FROM (SELECT `MenuID` FROM `gossip_menu` WHERE `MenuID` = 2904 AND `TextID` = 3578) x);
UPDATE `gossip_menu_option` SET `OptionText` = 'I will take you up on that offer, Eitrigg.', `OptionBroadcastTextID` = 5998, `ActionMenuID` = 2904 WHERE `MenuID` = 2905 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 5998 AND `ActionMenuID` = 2906; -- Eitrigg: "I will take you up on that offer" leads on to 2904
UPDATE `gossip_menu_option` SET `OptionText` = 'Ah, so that is how they pushed the Dark Iron to the lower parts of the Spire.', `OptionBroadcastTextID` = 6000, `ActionMenuID` = 2903 WHERE `MenuID` = 2904 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 5996 AND `ActionMenuID` = 2905; -- Eitrigg
UPDATE `gossip_menu_option` SET `OptionText` = 'Perhaps there exists a way?', `OptionBroadcastTextID` = 6002, `ActionMenuID` = 2902 WHERE `MenuID` = 2903 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 5994 AND `ActionMenuID` = 2904; -- Eitrigg
UPDATE `gossip_menu_option` SET `OptionText` = 'As you wish, Eitrigg.', `OptionBroadcastTextID` = 6004, `ActionMenuID` = 0 WHERE `MenuID` = 2902 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 5992 AND `ActionMenuID` = 2903; -- Eitrigg: "As you wish, Eitrigg." completes Eitrigg's Wisdom (4941)

-- Rabine Saturna: menus 5767 and 5768 had their texts and choices the wrong way round
UPDATE `gossip_menu` SET `TextID` = 6953 WHERE `MenuID` = 5767 AND `TextID` = 6952 AND NOT EXISTS (SELECT 1 FROM (SELECT `MenuID` FROM `gossip_menu` WHERE `MenuID` = 5767 AND `TextID` = 6953) x);
UPDATE `gossip_menu` SET `TextID` = 6952 WHERE `MenuID` = 5768 AND `TextID` = 6953 AND NOT EXISTS (SELECT 1 FROM (SELECT `MenuID` FROM `gossip_menu` WHERE `MenuID` = 5768 AND `TextID` = 6952) x);
UPDATE `gossip_menu_option` SET `OptionText` = 'What would happen if the Fruit of Fertility - or the Felvine - was allowed to be fully corrupted?', `OptionBroadcastTextID` = 9542, `ActionMenuID` = 5767 WHERE `MenuID` = 5768 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 6089 AND `ActionMenuID` = 0; -- Rabine Saturna
UPDATE `gossip_menu_option` SET `OptionText` = 'What would you have me do, Rabine?', `OptionBroadcastTextID` = 9544, `ActionMenuID` = 0 WHERE `MenuID` = 5767 AND `OptionID` = 0 AND `OptionBroadcastTextID` = 9542 AND `ActionMenuID` = 5768; -- Rabine Saturna: "What would you have me do, Rabine?"

-- conditions
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`SourceTypeOrReferenceId` int NOT NULL, `SourceGroup` int unsigned NOT NULL, `SourceEntry` int NOT NULL, `SourceId` int NOT NULL, `ElseGroup` int unsigned NOT NULL, `ConditionTypeOrReference` int NOT NULL, `ConditionTarget` tinyint unsigned NOT NULL, `ConditionValue1` int unsigned NOT NULL, `ConditionValue2` int unsigned NOT NULL, `ConditionValue3` int unsigned NOT NULL, `NegativeCondition` tinyint unsigned NOT NULL, `Comment` varchar(255) NOT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `Comment`) VALUES
(15, 5502, 0, 0, 0, 8, 0, 1030, 0, 0, 0, 'Raene Wolfrunner - option 5502/0 - quest rewarded 1030'),
(15, 5502, 0, 0, 0, 14, 0, 1045, 0, 0, 0, 'Raene Wolfrunner - option 5502/0 - quest not taken or done 1045'),
(15, 5502, 0, 0, 0, 2, 0, 5462, 1, 1, 1, 'Raene Wolfrunner - option 5502/0 - not has item 5462'),
(15, 840, 2, 0, 0, 29, 0, 7750, 50, 0, 1, 'Fallen Hero of the Horde - option 840/2 - not creature near 7750'),
(15, 840, 2, 0, 0, 14, 0, 2701, 0, 0, 0, 'Fallen Hero of the Horde - option 840/2 - quest not taken or done 2701'),
(15, 840, 2, 0, 0, 8, 0, 2702, 0, 0, 0, 'Fallen Hero of the Horde - option 840/2 - quest rewarded 2702'),
(15, 840, 2, 0, 1, 29, 0, 7750, 50, 0, 1, 'Fallen Hero of the Horde - option 840/2 - not creature near 7750'),
(15, 840, 2, 0, 1, 9, 0, 2702, 0, 0, 0, 'Fallen Hero of the Horde - option 840/2 - quest taken 2702'),
(15, 840, 2, 0, 2, 29, 0, 7750, 50, 0, 1, 'Fallen Hero of the Horde - option 840/2 - not creature near 7750'),
(15, 840, 2, 0, 2, 9, 0, 2701, 0, 0, 0, 'Fallen Hero of the Horde - option 840/2 - quest taken 2701'),
(15, 1882, 0, 0, 0, 9, 0, 4021, 0, 0, 0, 'Regthar Deathgate - option 1882/0 - quest taken 4021'),
(15, 1882, 0, 0, 0, 2, 0, 11227, 1, 1, 1, 'Regthar Deathgate - option 1882/0 - not has item 11227'),
(15, 1882, 0, 0, 0, 29, 0, 9524, 200, 0, 1, 'Regthar Deathgate - option 1882/0 - no Kolkar Invader alive within 200'),
(15, 1882, 0, 0, 0, 29, 0, 9523, 200, 0, 1, 'Regthar Deathgate - option 1882/0 - no Kolkar Stormseer alive within 200'),
(15, 5481, 0, 0, 0, 8, 0, 6602, 0, 0, 0, 'Rexxar - option 5481/0 - quest rewarded 6602'),
(15, 5481, 0, 0, 0, 2, 0, 16309, 1, 1, 1, 'Rexxar - option 5481/0 - not has item 16309'),
(22, 1, 11491, 0, 0, 13, 1, 4, 3, 0, 0, 'Old Ironbark - update entry - only when Zevrim Thornhoof is dead (instance data 4 = 3)'),
(15, 5602, 0, 0, 0, 13, 0, 5, 3, 0, 1, 'Ironbark the Redeemed - option 5602/0 - door not opened yet (instance data 5 <> 3)');
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT s.`SourceTypeOrReferenceId`, s.`SourceGroup`, s.`SourceEntry`, s.`SourceId`, s.`ElseGroup`, s.`ConditionTypeOrReference`, s.`ConditionTarget`, s.`ConditionValue1`, s.`ConditionValue2`, s.`ConditionValue3`, '', s.`NegativeCondition`, 0, 0, '', s.`Comment` FROM `everlake_import_stage` s
WHERE NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = s.`SourceTypeOrReferenceId` AND c.`SourceGroup` = s.`SourceGroup` AND c.`SourceEntry` = s.`SourceEntry` AND c.`SourceId` = s.`SourceId` AND c.`ElseGroup` = s.`ElseGroup` AND c.`ConditionTypeOrReference` = s.`ConditionTypeOrReference` AND c.`ConditionTarget` = s.`ConditionTarget` AND c.`ConditionValue1` = s.`ConditionValue1` AND c.`ConditionValue2` = s.`ConditionValue2` AND c.`ConditionValue3` = s.`ConditionValue3`);
DROP TEMPORARY TABLE `everlake_import_stage`;

-- smart_scripts
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22227, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Raene Wolfrunner - On gossip 5502/0 - Invoker casts Create Dartol''s Rod' WHERE `entryorguid` = 3691 AND `source_type` = 0 AND `id` = 7 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000304;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 22207, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Rexxar - On gossip 5481/0 - Invoker casts Create Drakefire Amulet' WHERE `entryorguid` = 10182 AND `source_type` = 0 AND `id` = 6 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000400;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 17681, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Magistrate Marduke - On gossip 3364/0 - Invoker casts Reputation - Caer Darrow' WHERE `entryorguid` = 11286 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000426;
-- Old Ironbark keeps his SmartAI after he becomes Ironbark the Redeemed (14241), whose menu is 5602
UPDATE `smart_scripts` SET `event_param1` = 5602, `comment` = 'Old Ironbark - On gossip 5602/0 (as Ironbark the Redeemed) - Close gossip' WHERE `entryorguid` = 11491 AND `source_type` = 0 AND `id` = 2 AND `event_type` = 62 AND `event_param1` = 5601 AND `event_param2` = 0;
-- Rabine Saturna: VMaNGOS adds its own aura 33006 to unlock A Reliquary of Purity (5527); the spell is not in the client
-- and the realm offers 5527 without it, so only his line is kept
DELETE FROM `smart_scripts` WHERE `entryorguid` = 950000429 AND `source_type` = 9 AND `id` = 0 AND `action_type` = 11 AND `action_param1` = 33006;

COMMIT;
