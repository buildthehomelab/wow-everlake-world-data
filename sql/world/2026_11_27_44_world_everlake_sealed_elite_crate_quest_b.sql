-- A Sealed Crate (91908): a hand-in for the Sealed Elite Crate 248774, the second set's Elite crate (91904-91907 take 248770-248773).
-- NO SOURCE has a live quest for it, so the id and reward are OURS (user's request, 2026-11-27): 91908 is the next id of the set
-- and unused in every source and on the PTR; objective id 9190800 follows our quest*100 objective ids. The row is the set's Artisan
-- quest (91907) with the Elite crate. Reward: 50 Merchant's Favor (3402), INFERRED: it continues the 10/20/30/40 steps of
-- 91904-91907, the rule chosen for 91903. Givers and enders as the set: Marcy Baker (256390) and Dokimi (256386).
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

CREATE TEMPORARY TABLE `everlake_elite_crate_b` SELECT * FROM `quest_template` WHERE `ID` = 91907;
UPDATE `everlake_elite_crate_b` SET `ID` = 91908, `RewardCurrencyID1` = 3402, `RewardCurrencyQty1` = 50, `VerifiedBuild` = 0;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`)
SELECT 'quest_template', 91908, '2026_11_27_44_world_everlake_sealed_elite_crate_quest_b.sql', 'our quest: no live source; Favor inferred'
FROM `everlake_elite_crate_b` WHERE NOT EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 91908)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` WHERE `tbl` = 'quest_template' AND `k1` = 91908);
INSERT INTO `quest_template` SELECT * FROM `everlake_elite_crate_b` WHERE NOT EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 91908);
DROP TEMPORARY TABLE `everlake_elite_crate_b`;

INSERT INTO `quest_template_addon` (`ID`, `SpecialFlags`, `ScriptName`)
SELECT 91908, 1, '' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 91908);

INSERT INTO `quest_objectives` (`ID`, `QuestID`, `Type`, `Order`, `StorageIndex`, `ObjectID`, `Amount`, `ConditionalAmount`, `Flags`, `Flags2`, `ProgressBarWeight`, `ParentObjectiveID`, `Visible`, `Description`, `VerifiedBuild`)
SELECT 9190800, 91908, 1, 0, 0, 248774, 1, 0, 0, 0, 0, 0, 1, '', 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `ID` = 9190800 OR `QuestID` = 91908);

INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`)
SELECT 91908, 0, 0, 0, 0, 'Another delivery! Fantastic. Set it over by the pile and we can discuss your compensation.', 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_request_items` WHERE `ID` = 91908);
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`)
SELECT 91908, 0, 0, 0, 0, 0, 0, 0, 0, 'Thank you for your hard work, $N. There has been an uprising in bandits and thieves intercepting trade routes as of late. If you find other crates lying around, please bring them here and we''ll handle the rest.$B$BHere is your payment.', 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `quest_offer_reward` WHERE `ID` = 91908);

INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) VALUES (256386, 91908, 0), (256390, 91908, 0);
INSERT IGNORE INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) VALUES (256386, 91908, 0), (256390, 91908, 0);

COMMIT;
