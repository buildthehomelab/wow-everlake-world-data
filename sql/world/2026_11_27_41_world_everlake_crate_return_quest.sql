-- Crate Return (93862): the hand-in of the Forged Delivery Receipt (262902). The receipt (spell 1269600, core script
-- classic_spell_item_forge_delivery_receipt) turns an empty labeled Waylaid Crate into a Notarized Shipping Container (262917); Marcy
-- Baker (256390) and Dokimi (256386) take one for +50 reputation with Azeroth Commerce Authority (2586) / Durotar Supply and
-- Logistics (2587). From the Icy Veins WoW Forever catalogue (live quest row: objective 467615 = 1 x 262917, reputation 50 + 50,
-- flags as A Sealed Crate; both camp NPCs give and take it) and its recorded texts. The quest was missing on our realm.
-- The row is A Sealed Crate (91899) with Crate Return's title, objective and rewards: same flags, races, repeatable addon row.
-- Game names and text belong to Blizzard Entertainment.
-- Each row is recorded in `everlake_import_rows`. Running it again changes nothing.
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

-- quest_template: a copy of 91899
CREATE TEMPORARY TABLE `everlake_crate_return` SELECT * FROM `quest_template` WHERE `ID` = 91899;
UPDATE `everlake_crate_return` SET `ID` = 93862, `LogTitle` = 'Crate Return', `RewardCurrencyID1` = 0, `RewardCurrencyQty1` = 0,
  `RewardFactionID1` = 2586, `RewardFactionValue1` = 0, `RewardFactionOverride1` = 5000,
  `RewardFactionID2` = 2587, `RewardFactionValue2` = 0, `RewardFactionOverride2` = 5000, `VerifiedBuild` = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`)
SELECT 'quest_template', 93862, '2026_11_27_41_world_everlake_crate_return_quest.sql', 'seen-live: icyveins:catalog'
FROM `everlake_crate_return` WHERE NOT EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 93862)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` WHERE `tbl` = 'quest_template' AND `k1` = 93862);
INSERT INTO `quest_template` SELECT * FROM `everlake_crate_return` WHERE NOT EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 93862);
DROP TEMPORARY TABLE `everlake_crate_return`;

-- quest_template_addon: repeatable, like 91899
INSERT INTO `quest_template_addon` (`ID`, `SpecialFlags`, `ScriptName`)
SELECT 93862, 1, '' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 93862);

-- objective: 1 Notarized Shipping Container
INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `ConditionalAmount`, `Flags`, `Flags2`, `ProgressBarWeight`, `ParentObjectiveID`, `Visible`, `Description`, `VerifiedBuild`)
SELECT 467615, 93862, 1, 0, 0, 262917, 1, 0, 0, 0, 0, 0, 1, '', 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 467615 OR `QuestID` = 93862);

-- texts (Icy Veins recordings)
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`)
SELECT 93862, 0, 0, 0, 0, 'Picking up or dropping off?', 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_request_items` WHERE `ID` = 93862);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`)
SELECT 93862, 0, 0, 0, 0, 0, 0, 0, 0, 'Another successful delivery, I see. Everything looks to be in order, and the recipient even signed and dated the label!$B$BFantastic work, $N. Though you should have already been properly compensated for with your initial delivery, here''s a tip as my personal thanks. Sturdy shipping containers can be expensive, so I am happy to share some of the savings with someone diligent enough to return them in good shape.', 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_offer_reward` WHERE `ID` = 93862);

-- givers and enders: both camp quartermasters, like the Sealed Crate quests
INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) VALUES (256386, 93862, 0), (256390, 93862, 0);
INSERT IGNORE INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) VALUES (256386, 93862, 0), (256390, 93862, 0);

COMMIT;
