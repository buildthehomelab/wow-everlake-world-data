-- 2026_11_27_05_world_everlake_undermine_real_sunken_temple.sql: the Sunken Temple bosses drop the Tarnished Undermine Real (currency 3469) too, as forg.gg's Undermine Real
-- guide lists the dungeon. Same rules as the level 55+ dungeons (2026_11_27_03, 2026_11_27_04): every kill, once a day per
-- character through a hidden daily tracking quest (ids 9346962-9346970), and 3 from the last boss, Shade of Eranikus.
-- Bosses: Atal'alarion, Dreamscythe, Weaver, Avatar of Hakkar, Jammal'an the Prophet, Ogom the Wretched, Morphaz, Hazzas,
-- Shade of Eranikus. The six troll minibosses (Gasher, Loro, Hukku, Zolo, Mijan, Zul'Lor) are left out.
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

-- quest_template: 9 hidden daily tracking quests
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `QuestType`, `Flags`, `LogTitle` FROM `quest_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `QuestType`, `Flags`, `LogTitle`) VALUES
(9346962, 2, 5120, 'Tarnished Undermine Real: Shade of Eranikus'),
(9346963, 2, 5120, 'Tarnished Undermine Real: Jammal''an the Prophet'),
(9346964, 2, 5120, 'Tarnished Undermine Real: Ogom the Wretched'),
(9346965, 2, 5120, 'Tarnished Undermine Real: Morphaz'),
(9346966, 2, 5120, 'Tarnished Undermine Real: Weaver'),
(9346967, 2, 5120, 'Tarnished Undermine Real: Dreamscythe'),
(9346968, 2, 5120, 'Tarnished Undermine Real: Hazzas'),
(9346969, 2, 5120, 'Tarnished Undermine Real: Avatar of Hakkar'),
(9346970, 2, 5120, 'Tarnished Undermine Real: Atal''alarion');
DELETE s FROM `everlake_forge_stage` s JOIN `quest_template` x ON x.`ID` = s.`ID`;
INSERT INTO `quest_template` (`ID`, `QuestType`, `Flags`, `LogTitle`) SELECT `ID`, `QuestType`, `Flags`, `LogTitle` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_template', s.`ID`, 0, 0, 0, '2026_11_27_05_world_everlake_undermine_real_sunken_temple.sql', 'Undermine Real Sunken Temple (forg.gg)' FROM `everlake_forge_stage` s;

-- creature_loot_template: the coin (3 from Shade of Eranikus) and the tracking quest for each boss
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(5709, 2, 3469, 100, 0, 1, 0, 3, 3, 'Undermine Real, Sunken Temple (forg.gg)'),
(5709, 3, 9346962, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5710, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple (forg.gg)'),
(5710, 3, 9346963, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5711, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple (forg.gg)'),
(5711, 3, 9346964, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5719, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple (forg.gg)'),
(5719, 3, 9346965, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5720, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple (forg.gg)'),
(5720, 3, 9346966, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5721, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple (forg.gg)'),
(5721, 3, 9346967, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(5722, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple (forg.gg)'),
(5722, 3, 9346968, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(8443, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple (forg.gg)'),
(8443, 3, 9346969, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(8580, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real, Sunken Temple (forg.gg)'),
(8580, 3, 9346970, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` = s.`Entry` AND x.`ItemType` = s.`ItemType` AND x.`Item` = s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_27_05_world_everlake_undermine_real_sunken_temple.sql', 'Undermine Real Sunken Temple (forg.gg)' FROM `everlake_forge_stage` s;

-- conditions: the coin only while the boss's daily quest is not done
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment` FROM `conditions` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 5709, 3469, 0, 0, 43, 0, 9346962, 0, 0, '', 1, 0, 0, '', 'Shade of Eranikus: Undermine Real only if not looted today'),
(1, 5710, 3469, 0, 0, 43, 0, 9346963, 0, 0, '', 1, 0, 0, '', 'Jammal''an the Prophet: Undermine Real only if not looted today'),
(1, 5711, 3469, 0, 0, 43, 0, 9346964, 0, 0, '', 1, 0, 0, '', 'Ogom the Wretched: Undermine Real only if not looted today'),
(1, 5719, 3469, 0, 0, 43, 0, 9346965, 0, 0, '', 1, 0, 0, '', 'Morphaz: Undermine Real only if not looted today'),
(1, 5720, 3469, 0, 0, 43, 0, 9346966, 0, 0, '', 1, 0, 0, '', 'Weaver: Undermine Real only if not looted today'),
(1, 5721, 3469, 0, 0, 43, 0, 9346967, 0, 0, '', 1, 0, 0, '', 'Dreamscythe: Undermine Real only if not looted today'),
(1, 5722, 3469, 0, 0, 43, 0, 9346968, 0, 0, '', 1, 0, 0, '', 'Hazzas: Undermine Real only if not looted today'),
(1, 8443, 3469, 0, 0, 43, 0, 9346969, 0, 0, '', 1, 0, 0, '', 'Avatar of Hakkar: Undermine Real only if not looted today'),
(1, 8580, 3469, 0, 0, 43, 0, 9346970, 0, 0, '', 1, 0, 0, '', 'Atal''alarion: Undermine Real only if not looted today');
DELETE s FROM `everlake_forge_stage` s JOIN `conditions` x ON x.`SourceTypeOrReferenceId` = s.`SourceTypeOrReferenceId` AND x.`SourceGroup` = s.`SourceGroup` AND x.`SourceEntry` = s.`SourceEntry` AND x.`SourceId` = s.`SourceId` AND x.`ElseGroup` = s.`ElseGroup` AND x.`ConditionTypeOrReference` = s.`ConditionTypeOrReference` AND x.`ConditionTarget` = s.`ConditionTarget` AND x.`ConditionValue1` = s.`ConditionValue1` AND x.`ConditionValue2` = s.`ConditionValue2` AND x.`ConditionValue3` = s.`ConditionValue3` AND x.`ConditionStringValue1` = s.`ConditionStringValue1`;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) SELECT `SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'conditions', s.`SourceTypeOrReferenceId`, s.`SourceGroup`, s.`SourceEntry`, s.`ConditionValue1`, '2026_11_27_05_world_everlake_undermine_real_sunken_temple.sql', 'Undermine Real Sunken Temple (forg.gg)' FROM `everlake_forge_stage` s;
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
