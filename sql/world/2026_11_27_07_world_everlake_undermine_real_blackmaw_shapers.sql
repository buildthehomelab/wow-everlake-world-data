-- 2026_11_27_07_world_everlake_undermine_real_blackmaw_shapers.sql: the bosses of Blackmaw Hold (map 2974) and The Shaper's Terrace (map 3001) drop the Tarnished
-- Undermine Real (currency 3469), as forg.gg's Undermine Real guide lists both dungeons. Same rules as the other dungeons
-- (2026_11_27_03, 2026_11_27_04): every kill, once a day per character through a hidden daily tracking quest (ids
-- 9346977-9346994), and 3 from each dungeon's last boss (and King Op).
--   Blackmaw Hold: Withermaw, Impaan the Imprisoner, Elder Shaman Bloodmane, Bonesnout the Unbroken, Varrox Bleakhoof,
--     Blackmaw Behemoth, Unbound Spirit (last: highest DungeonEncounter OrderIndex, 6000).
--   The Shaper's Terrace: Titanosaur, Ravasaur Hunters (on Tor'Rel 261811, who carries the encounter's loot), Thunderhoof,
--     Venomridge, Direhorn Matriarch, Cinder, King Op, Snowtalon, Bolt, Nanaya, Vitrix (last). King Op gives 3 as well.
-- Bosses from the tracker's encounter list (DungeonEncounter.db2, enUS client).
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

-- quest_template: 18 hidden daily tracking quests
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `QuestType`, `Flags`, `LogTitle` FROM `quest_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `QuestType`, `Flags`, `LogTitle`) VALUES
(9346977, 2, 5120, 'Tarnished Undermine Real: Withermaw'),
(9346978, 2, 5120, 'Tarnished Undermine Real: Impaan the Imprisoner'),
(9346979, 2, 5120, 'Tarnished Undermine Real: Elder Shaman Bloodmane'),
(9346980, 2, 5120, 'Tarnished Undermine Real: Bonesnout the Unbroken'),
(9346981, 2, 5120, 'Tarnished Undermine Real: Varrox Bleakhoof'),
(9346982, 2, 5120, 'Tarnished Undermine Real: Blackmaw Behemoth'),
(9346983, 2, 5120, 'Tarnished Undermine Real: Unbound Spirit'),
(9346984, 2, 5120, 'Tarnished Undermine Real: Titanosaur'),
(9346985, 2, 5120, 'Tarnished Undermine Real: Tor''Rel'),
(9346986, 2, 5120, 'Tarnished Undermine Real: Thunderhoof'),
(9346987, 2, 5120, 'Tarnished Undermine Real: Venomridge'),
(9346988, 2, 5120, 'Tarnished Undermine Real: Direhorn Matriarch'),
(9346989, 2, 5120, 'Tarnished Undermine Real: Cinder'),
(9346990, 2, 5120, 'Tarnished Undermine Real: King Op'),
(9346991, 2, 5120, 'Tarnished Undermine Real: Snowtalon'),
(9346992, 2, 5120, 'Tarnished Undermine Real: Bolt'),
(9346993, 2, 5120, 'Tarnished Undermine Real: Vitrix'),
(9346994, 2, 5120, 'Tarnished Undermine Real: Nanaya');
DELETE s FROM `everlake_forge_stage` s JOIN `quest_template` x ON x.`ID` = s.`ID`;
INSERT INTO `quest_template` (`ID`, `QuestType`, `Flags`, `LogTitle`) SELECT `ID`, `QuestType`, `Flags`, `LogTitle` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_template', s.`ID`, 0, 0, 0, '2026_11_27_07_world_everlake_undermine_real_blackmaw_shapers.sql', 'Undermine Real Blackmaw Hold + Shaper''s Terrace (forg.gg)' FROM `everlake_forge_stage` s;

-- creature_loot_template: the coin (3 from each last boss) and the tracking quest for each boss
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(247195, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(247195, 3, 9346977, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(247206, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(247206, 3, 9346978, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(247209, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(247209, 3, 9346979, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(247198, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(247198, 3, 9346980, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(247234, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(247234, 3, 9346981, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(247207, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(247207, 3, 9346982, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(247231, 2, 3469, 100, 0, 1, 0, 3, 3, 'Undermine Real (forg.gg)'),
(247231, 3, 9346983, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(253201, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(253201, 3, 9346984, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(261811, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(261811, 3, 9346985, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(261812, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(261812, 3, 9346986, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(261813, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(261813, 3, 9346987, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(262127, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(262127, 3, 9346988, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(261974, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(261974, 3, 9346989, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(261993, 2, 3469, 100, 0, 1, 0, 3, 3, 'Undermine Real (forg.gg)'),
(261993, 3, 9346990, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(262297, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(262297, 3, 9346991, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(262081, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(262081, 3, 9346992, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(272561, 2, 3469, 100, 0, 1, 0, 3, 3, 'Undermine Real (forg.gg)'),
(272561, 3, 9346993, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(261809, 2, 3469, 100, 0, 1, 0, 1, 1, 'Undermine Real (forg.gg)'),
(261809, 3, 9346994, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` = s.`Entry` AND x.`ItemType` = s.`ItemType` AND x.`Item` = s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_27_07_world_everlake_undermine_real_blackmaw_shapers.sql', 'Undermine Real Blackmaw Hold + Shaper''s Terrace (forg.gg)' FROM `everlake_forge_stage` s;

-- conditions: the coin only while the boss's daily quest is not done
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment` FROM `conditions` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 247195, 3469, 0, 0, 43, 0, 9346977, 0, 0, '', 1, 0, 0, '', 'Withermaw: Undermine Real only if not looted today'),
(1, 247206, 3469, 0, 0, 43, 0, 9346978, 0, 0, '', 1, 0, 0, '', 'Impaan the Imprisoner: Undermine Real only if not looted today'),
(1, 247209, 3469, 0, 0, 43, 0, 9346979, 0, 0, '', 1, 0, 0, '', 'Elder Shaman Bloodmane: Undermine Real only if not looted today'),
(1, 247198, 3469, 0, 0, 43, 0, 9346980, 0, 0, '', 1, 0, 0, '', 'Bonesnout the Unbroken: Undermine Real only if not looted today'),
(1, 247234, 3469, 0, 0, 43, 0, 9346981, 0, 0, '', 1, 0, 0, '', 'Varrox Bleakhoof: Undermine Real only if not looted today'),
(1, 247207, 3469, 0, 0, 43, 0, 9346982, 0, 0, '', 1, 0, 0, '', 'Blackmaw Behemoth: Undermine Real only if not looted today'),
(1, 247231, 3469, 0, 0, 43, 0, 9346983, 0, 0, '', 1, 0, 0, '', 'Unbound Spirit: Undermine Real only if not looted today'),
(1, 253201, 3469, 0, 0, 43, 0, 9346984, 0, 0, '', 1, 0, 0, '', 'Titanosaur: Undermine Real only if not looted today'),
(1, 261811, 3469, 0, 0, 43, 0, 9346985, 0, 0, '', 1, 0, 0, '', 'Tor''Rel: Undermine Real only if not looted today'),
(1, 261812, 3469, 0, 0, 43, 0, 9346986, 0, 0, '', 1, 0, 0, '', 'Thunderhoof: Undermine Real only if not looted today'),
(1, 261813, 3469, 0, 0, 43, 0, 9346987, 0, 0, '', 1, 0, 0, '', 'Venomridge: Undermine Real only if not looted today'),
(1, 262127, 3469, 0, 0, 43, 0, 9346988, 0, 0, '', 1, 0, 0, '', 'Direhorn Matriarch: Undermine Real only if not looted today'),
(1, 261974, 3469, 0, 0, 43, 0, 9346989, 0, 0, '', 1, 0, 0, '', 'Cinder: Undermine Real only if not looted today'),
(1, 261993, 3469, 0, 0, 43, 0, 9346990, 0, 0, '', 1, 0, 0, '', 'King Op: Undermine Real only if not looted today'),
(1, 262297, 3469, 0, 0, 43, 0, 9346991, 0, 0, '', 1, 0, 0, '', 'Snowtalon: Undermine Real only if not looted today'),
(1, 262081, 3469, 0, 0, 43, 0, 9346992, 0, 0, '', 1, 0, 0, '', 'Bolt: Undermine Real only if not looted today'),
(1, 272561, 3469, 0, 0, 43, 0, 9346993, 0, 0, '', 1, 0, 0, '', 'Vitrix: Undermine Real only if not looted today'),
(1, 261809, 3469, 0, 0, 43, 0, 9346994, 0, 0, '', 1, 0, 0, '', 'Nanaya: Undermine Real only if not looted today');
DELETE s FROM `everlake_forge_stage` s JOIN `conditions` x ON x.`SourceTypeOrReferenceId` = s.`SourceTypeOrReferenceId` AND x.`SourceGroup` = s.`SourceGroup` AND x.`SourceEntry` = s.`SourceEntry` AND x.`SourceId` = s.`SourceId` AND x.`ElseGroup` = s.`ElseGroup` AND x.`ConditionTypeOrReference` = s.`ConditionTypeOrReference` AND x.`ConditionTarget` = s.`ConditionTarget` AND x.`ConditionValue1` = s.`ConditionValue1` AND x.`ConditionValue2` = s.`ConditionValue2` AND x.`ConditionValue3` = s.`ConditionValue3` AND x.`ConditionStringValue1` = s.`ConditionStringValue1`;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) SELECT `SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'conditions', s.`SourceTypeOrReferenceId`, s.`SourceGroup`, s.`SourceEntry`, s.`ConditionValue1`, '2026_11_27_07_world_everlake_undermine_real_blackmaw_shapers.sql', 'Undermine Real Blackmaw Hold + Shaper''s Terrace (forg.gg)' FROM `everlake_forge_stage` s;
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
