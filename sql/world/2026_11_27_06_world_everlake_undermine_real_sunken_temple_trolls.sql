-- 2026_11_27_06_world_everlake_undermine_real_sunken_temple_trolls.sql: the six troll minibosses of the Sunken Temple (Zolo, Gasher, Loro, Hukku, Zul'Lor, Mijan) drop the
-- Tarnished Undermine Real (currency 3469) too, like the dungeon's bosses (2026_11_27_05): every kill, once a day per
-- character through a hidden daily tracking quest (ids 9346971-9346976), 1 each.
-- Running it again changes nothing: a row is added only where none exists, and each added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file.

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

-- quest_template: 6 hidden daily tracking quests
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `QuestType`, `Flags`, `LogTitle` FROM `quest_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `QuestType`, `Flags`, `LogTitle`) VALUES
(9346971, 2, 5120, 'Tarnished Undermine Real: Zolo'),
(9346972, 2, 5120, 'Tarnished Undermine Real: Gasher'),
(9346973, 2, 5120, 'Tarnished Undermine Real: Loro'),
(9346974, 2, 5120, 'Tarnished Undermine Real: Hukku'),
(9346975, 2, 5120, 'Tarnished Undermine Real: Zul''Lor'),
(9346976, 2, 5120, 'Tarnished Undermine Real: Mijan');
DELETE s FROM `everlake_forge_stage` s JOIN `quest_template` x ON x.`ID` = s.`ID`;
INSERT INTO `quest_template` (`ID`, `QuestType`, `Flags`, `LogTitle`) SELECT `ID`, `QuestType`, `Flags`, `LogTitle` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_template', s.`ID`, 0, 0, 0, '2026_11_27_06_world_everlake_undermine_real_sunken_temple_trolls.sql', 'Undermine Real Sunken Temple minibosses (forg.gg)' FROM `everlake_forge_stage` s;

-- creature_loot_template: the coin and the tracking quest for each boss
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5712, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple miniboss (forg.gg)'),
(5712, 3, 9346971, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5713, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple miniboss (forg.gg)'),
(5713, 3, 9346972, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5714, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple miniboss (forg.gg)'),
(5714, 3, 9346973, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5715, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple miniboss (forg.gg)'),
(5715, 3, 9346974, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5716, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple miniboss (forg.gg)'),
(5716, 3, 9346975, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5717, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple miniboss (forg.gg)'),
(5717, 3, 9346976, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` = s.`Entry` AND x.`ItemType` = s.`ItemType` AND x.`Item` = s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_27_06_world_everlake_undermine_real_sunken_temple_trolls.sql', 'Undermine Real Sunken Temple minibosses (forg.gg)' FROM `everlake_forge_stage` s;

-- conditions: the coin only while the boss's daily quest is not done
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment` FROM `conditions` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 5712, 3469, 0, 0, 43, 0, 9346971, 0, 0, '', 1, 0, 0, '', 'Zolo: Undermine Real only if not looted today'),
(1, 5713, 3469, 0, 0, 43, 0, 9346972, 0, 0, '', 1, 0, 0, '', 'Gasher: Undermine Real only if not looted today'),
(1, 5714, 3469, 0, 0, 43, 0, 9346973, 0, 0, '', 1, 0, 0, '', 'Loro: Undermine Real only if not looted today'),
(1, 5715, 3469, 0, 0, 43, 0, 9346974, 0, 0, '', 1, 0, 0, '', 'Hukku: Undermine Real only if not looted today'),
(1, 5716, 3469, 0, 0, 43, 0, 9346975, 0, 0, '', 1, 0, 0, '', 'Zul''Lor: Undermine Real only if not looted today'),
(1, 5717, 3469, 0, 0, 43, 0, 9346976, 0, 0, '', 1, 0, 0, '', 'Mijan: Undermine Real only if not looted today');
DELETE s FROM `everlake_forge_stage` s JOIN `conditions` x ON x.`SourceTypeOrReferenceId` = s.`SourceTypeOrReferenceId` AND x.`SourceGroup` = s.`SourceGroup` AND x.`SourceEntry` = s.`SourceEntry` AND x.`SourceId` = s.`SourceId` AND x.`ElseGroup` = s.`ElseGroup` AND x.`ConditionTypeOrReference` = s.`ConditionTypeOrReference` AND x.`ConditionTarget` = s.`ConditionTarget` AND x.`ConditionValue1` = s.`ConditionValue1` AND x.`ConditionValue2` = s.`ConditionValue2` AND x.`ConditionValue3` = s.`ConditionValue3` AND x.`ConditionStringValue1` = s.`ConditionStringValue1`;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) SELECT `SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'conditions', s.`SourceTypeOrReferenceId`, s.`SourceGroup`, s.`SourceEntry`, s.`ConditionValue1`, '2026_11_27_06_world_everlake_undermine_real_sunken_temple_trolls.sql', 'Undermine Real Sunken Temple minibosses (forg.gg)' FROM `everlake_forge_stage` s;
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
