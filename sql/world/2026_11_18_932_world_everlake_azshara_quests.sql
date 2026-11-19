-- Azshara: turn-in texts for five Forever quests, and the Spirit of Azuregos hands out the Magical Ledger again.
-- 2026_11_18_932_world_everlake_azshara_quests.sql: written by hand.
--
-- 1. Turn-in texts. Chieftain Bloodmaw (87346), both Deadliest Catch (89015, 91611), Demon Hunter's Hunter (91877) and
--    Winter Frontier Fishery (91610) had no quest_request_items or quest_offer_reward row, so their turn-in window showed
--    nothing. Texts from their Wowhead Forever pages (Progress / Completion), 2026-11-18; <race> and <class> written as
--    $r and $c. Wowhead has no progress text for 91877, so it gets the completion text only. A row is only added
--    where the world has none.
--
-- 2. Azuregos's Magical Ledger (8575) starts from item 20949, which spell 25600 creates. The VMaNGOS script import
--    (core sql/custom/world/2026_09_28_15_world_vanilla_smartai.sql) gave the Spirit of Azuregos (15481) a choice
--    on gossip menu 15012, VMaNGOS's id. On this realm the spirit opens menu 6627, and its conversation runs
--    6627 -> 15002 -> 15003 -> 15004 -> 15005; menu 15012 does not exist. The choice never fired, so nobody could get
--    the ledger. It now fires when the player picks the last option ("Fish? You gave a piece of ... to a fish?",
--    menu 15004 option 0), and the player casts 25600 on themselves (SELF_CAST on the invoker, triggered). An item
--    made by a spell the creature casts would not reach the player's bags. The conversation still opens 15005. The
--    existing conditions on option 6627/0 keep the conversation to players who did The Charge of the Dragonflights
--    (8555), have not done 8575 and hold no ledger. The old close-gossip row and its link row are replaced. Only
--    changed while the rows are still the imported ones. Not checked in game.
--
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

-- quest_request_items: progress texts for quests the world has no row for
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`ID` int unsigned NOT NULL, `CompletionText` mediumtext, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`ID`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`ID`, `CompletionText`, `note`) VALUES
(87346, 'My conditions are firm. Help in our plight, and we will help in yours.', 'wowhead-forever@2026-11-18'), -- Chieftain Bloodmaw
(89015, 'Gettin'' cold feet about the shark? I wouldn''t blame ye.', 'wowhead-forever@2026-11-18'), -- Deadliest Catch
(91610, 'Any luck with your fishing? I sense the others are beginning to tire of my mosshoof stew.', 'wowhead-forever@2026-11-18'), -- Winter Frontier Fishery
(91611, 'Having doubts about the shark hunt? I can hardly blame you.', 'wowhead-forever@2026-11-18'); -- Deadliest Catch
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `quest_request_items` t WHERE t.`ID` = s.`ID`);
INSERT INTO `quest_request_items` (`ID`, `CompletionText`) SELECT `ID`, `CompletionText` FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, '2026_11_18_932_world_everlake_azshara_quests.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_18_932_world_everlake_azshara_quests.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

-- quest_offer_reward: completion texts for quests the world has no row for
DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`ID` int unsigned NOT NULL, `RewardText` mediumtext, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`ID`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`ID`, `RewardText`, `note`) VALUES
(87346, 'Impressive, $r. Without their chieftain, the remaining Deadwood should be scrambling.\r\n\r\nAs promised, the warriors freed up by your efforts will fight with you against the Legashi.', 'wowhead-forever@2026-11-18'), -- Chieftain Bloodmaw
(89015, 'Look at you! A bonafide frontier fisherman! Hats off to ye, friend.', 'wowhead-forever@2026-11-18'), -- Deadliest Catch
(91610, 'A worthy haul! These will cook nicely.', 'wowhead-forever@2026-11-18'), -- Winter Frontier Fishery
(91611, 'By the spirits, what a catch! My hat goes off to you, $c. You are truly a master of the sea.', 'wowhead-forever@2026-11-18'), -- Deadliest Catch
(91877, 'Loramus is quite correct. Though Archimonde was destroyed, some of his troops survived. After the war, the Alliance and the Horde had too many other problems to deal with. Nobody bothered to check and realize that these creatures of malice were slithering back out of the shadows.', 'wowhead-forever@2026-11-18'); -- Demon Hunter's Hunter
UPDATE `everlake_import_stage` s SET s.`missing` = 1 WHERE NOT EXISTS (SELECT 1 FROM `quest_offer_reward` t WHERE t.`ID` = s.`ID`);
INSERT INTO `quest_offer_reward` (`ID`, `RewardText`) SELECT `ID`, `RewardText` FROM `everlake_import_stage` WHERE `missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, '2026_11_18_932_world_everlake_azshara_quests.sql', s.`note` FROM `everlake_import_stage` s WHERE s.`missing` = 1 ON DUPLICATE KEY UPDATE `file` = '2026_11_18_932_world_everlake_azshara_quests.sql', `note` = s.`note`;
DROP TEMPORARY TABLE `everlake_import_stage`;

-- Spirit of Azuregos: the ledger on the conversation's last choice (menu 15004 option 0), cast by the player
UPDATE `smart_scripts`
SET `event_param1` = 15004, `event_param2` = 0, `link` = 0,
    `action_type` = 85, `action_param1` = 25600, `action_param2` = 2, `action_param3` = 0,
    `target_type` = 7, `comment` = 'Spirit of Azuregos - On gossip 15004/0 - Invoker casts Idol of Neptulon DND (Magical Ledger 20949)'
WHERE `entryorguid` = 15481 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `event_param1` = 15012 AND `action_type` = 72;

DELETE FROM `smart_scripts`
WHERE `entryorguid` = 15481 AND `source_type` = 0 AND `id` = 1 AND `event_type` = 61 AND `action_type` = 80 AND `action_param1` = 950000539;

COMMIT;
