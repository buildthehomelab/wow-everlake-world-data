-- A Sealed Crate (91903): the hand-in for the Sealed Elite Crate 248769, missing on our realm. Live quest from the Icy Veins WoW
-- Forever catalogue (added in build 70959, objective 463655 = 1 x 248769, flags as the other Sealed Crate quests); Questie gives
-- Marcy Baker (256390) and Dokimi (256386) as givers and enders, like 91899-91902.
-- The row is the Artisan one (91902) with the Elite crate. Reward: 25 Merchant's Favor (3402), INFERRED: no source records it;
-- it continues the 5/10/15/20 steps of 91899-91902 (user's choice, 2026-11-27). Reputation factions as 91902 (amount 0, as live).
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

CREATE TEMPORARY TABLE `everlake_elite_crate` SELECT * FROM `quest_template` WHERE `ID` = 91902;
UPDATE `everlake_elite_crate` SET `ID` = 91903, `RewardCurrencyID1` = 3402, `RewardCurrencyQty1` = 25, `VerifiedBuild` = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`)
SELECT 'quest_template', 91903, '2026_11_27_43_world_everlake_sealed_elite_crate_quest.sql', 'seen-live: icyveins:catalog, questie; Favor inferred'
FROM `everlake_elite_crate` WHERE NOT EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 91903)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` WHERE `tbl` = 'quest_template' AND `k1` = 91903);
INSERT INTO `quest_template` SELECT * FROM `everlake_elite_crate` WHERE NOT EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 91903);
DROP TEMPORARY TABLE `everlake_elite_crate`;

INSERT INTO `quest_template_addon` (`ID`, `SpecialFlags`, `ScriptName`)
SELECT 91903, 1, '' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 91903);

INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `ConditionalAmount`, `Flags`, `Flags2`, `ProgressBarWeight`, `ParentObjectiveID`, `Visible`, `Description`, `VerifiedBuild`)
SELECT 463655, 91903, 1, 0, 0, 248769, 1, 0, 0, 0, 0, 0, 1, '', 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 463655 OR `QuestID` = 91903);

INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`)
SELECT 91903, 0, 0, 0, 0, 'Another delivery! Fantastic. Set it over by the pile and we can discuss your compensation.', 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_request_items` WHERE `ID` = 91903);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`)
SELECT 91903, 0, 0, 0, 0, 0, 0, 0, 0, 'Thank you for your hard work, $N. There has been an uprising in bandits and thieves intercepting trade routes as of late. If you find other crates lying around, please bring them here and we''ll handle the rest.$B$BHere is your payment.', 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_offer_reward` WHERE `ID` = 91903);

INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) VALUES (256386, 91903, 0), (256390, 91903, 0);
INSERT IGNORE INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) VALUES (256386, 91903, 0), (256390, 91903, 0);

COMMIT;
