-- Everlake Forge #311: Import, 1 resource(s), 8 row(s)
-- 2026_11_24_900_world_everlake_forge_00311_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 71091) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Wowhead 2026-11-24 (NOTICE.md, Forge exports).
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing: a row is added only
-- where none exists, spawns only where the same creature or object is not already within 5 yards, and each added row is recorded in everlake_import_rows.

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
-- quest_offer_reward: 4 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `quest_offer_reward` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) VALUES
(80241, 0, 0, 0, 0, 0, 0, 0, 0, 'Very good, $n! Listen and learn.$B$BBlacksmithing never comes from here!$B$BBlacksmithing never comes from here!$B$BBlacksmithing only comes from here!$B$BAnd now you know the origin of blacksmithing.', 0),
(94352, 0, 0, 0, 0, 0, 0, 0, 0, 'Is this some sort of practical joke? I requested no such thing--I am more than capable of handling my own wardrobe.$B$B<You present the letter to Joy. She reads through it before elbowing Rayan with enough force to send the man stumbling a step to the side.>$B$BI recognized that handwriting immediately. Very well, I will play along. \"Thank you so much, $r! My turban has finally arrived, at long last.\"$B$BNow, stop impersonating me, Rayan. It is creepy, and you\'re terrible at it.', 0),
(97270, 0, 0, 0, 0, 0, 0, 0, 0, 'You won!$B$BBut one victory ain\'t enough to be Grandmaster of the Maul!$B$BYou\'ll needa defeat ALL the monsters that call the Maul home.', 0),
(99234, 0, 0, 0, 0, 0, 0, 0, 0, 'You won!$B$BBut one victory ain\'t enough to be Grandmaster of the Maul!$B$BYou\'ll needa defeat ALL the monsters that call the Maul home.', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_offer_reward` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_offer_reward` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild`) SELECT `ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `RewardText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_offer_reward', s.`ID`, 0, 0, 0, '2026_11_24_900_world_everlake_forge_00311_import.sql', 'Forge #311: Wowhead 2026-11-24' FROM `everlake_forge_stage` s;

-- quest_request_items: 2 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `quest_request_items` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) VALUES
(80241, 0, 0, 0, 0, 'Could you be the next Galvan protege?', 0),
(94352, 0, 0, 0, 0, 'To what do I blame the displeasure of our meeting?', 0);
DELETE s FROM `everlake_forge_stage` s JOIN `quest_request_items` x ON x.`ID` <=> s.`ID`;
INSERT INTO `quest_request_items` (`ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild`) SELECT `ID`, `EmoteOnComplete`, `EmoteOnIncomplete`, `EmoteOnCompleteDelay`, `EmoteOnIncompleteDelay`, `CompletionText`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_request_items', s.`ID`, 0, 0, 0, '2026_11_24_900_world_everlake_forge_00311_import.sql', 'Forge #311: Wowhead 2026-11-24' FROM `everlake_forge_stage` s;

-- gameobject_loot_template: 1 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `gameobject_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(123805, 0, 220345, 100, 0, 1, 0, 1, 1, 'Wowhead 2026-11-24');
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject_loot_template` x ON x.`Entry` <=> s.`Entry` AND x.`ItemType` <=> s.`ItemType` AND x.`Item` <=> s.`Item`;
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_24_900_world_everlake_forge_00311_import.sql', 'Forge #311: Wowhead 2026-11-24' FROM `everlake_forge_stage` s;

-- values a source measured again: each statement names the value it replaces, so it changes nothing where the
-- row moved on, and nothing more when it runs again
UPDATE `creature_loot_template` SET `Chance` = 8.86 WHERE `Entry` = 16080 AND `ItemType` = 0 AND `Item` = 22046 AND ABS(`Chance` - 4.53) < 0.005 /* refresh */;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
