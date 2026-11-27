-- 2026_11_27_03_world_everlake_undermine_real_daily.sql: every dungeon boss that drops the Tarnished Undermine Real (currency 3469) gives it every time, once a day per
-- character, as on WoW Forever (forg.gg's Undermine Real guide: each boss of a level 55+ dungeon, once a day).
-- How: each of the 61 bosses' loot tables (2026_11_27_02 left them) gets a hidden daily tracking quest (QUEST_FLAGS_TRACKING_EVENT
-- 0x400 | QUEST_FLAGS_DAILY 0x1000, ids 9346901-9346961, given by a loot row of ItemType 3), and the coin row a condition: only
-- while that daily quest is not done (CONDITION_DAILY_QUEST_DONE 43, negated). The core weighs a looter's free-for-all rows
-- (the coin, the tracking quest) when the loot is made and completes the tracking quests only after the looter opened it
-- (Loot::AutoStoreTrackingQuests), so the first kill of the day pays and the next ones do not. The daily reset clears it
-- (Player::DailyReset). The coin's chance goes to 100.
-- Grand Crusader Dathrohan and Balnazzar share loot table 10813: one boss, one quest.
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

-- the coin: every kill
UPDATE `creature_loot_template` SET `Chance` = 100 WHERE `ItemType` = 2 AND `Item` = 3469 AND `Chance` <> 100 AND `Entry` IN (1853, 8983, 9017, 9019, 9033, 9156, 9196, 9236, 9237, 9502, 9537, 9568, 9816, 9938, 10220, 10268, 10363, 10429, 10430, 10432, 10433, 10435, 10436, 10437, 10438, 10439, 10440, 10502, 10503, 10504, 10505, 10506, 10507, 10508, 10516, 10584, 10596, 10808, 10811, 10813, 10901, 10997, 11032, 11058, 11143, 11261, 11486, 11487, 11488, 11489, 11490, 11492, 11496, 11501, 11622, 13280, 14327, 14354, 14684, 14690, 14695);

-- quest_template: 61 hidden daily tracking quests
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `ID`, `QuestType`, `Flags`, `LogTitle` FROM `quest_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`ID`, `QuestType`, `Flags`, `LogTitle`) VALUES
(9346901, 2, 5120, 'Tarnished Undermine Real: Darkmaster Gandling'),
(9346902, 2, 5120, 'Tarnished Undermine Real: Golem Lord Argelmach'),
(9346903, 2, 5120, 'Tarnished Undermine Real: Lord Incendius'),
(9346904, 2, 5120, 'Tarnished Undermine Real: Emperor Dagran Thaurissan'),
(9346905, 2, 5120, 'Tarnished Undermine Real: General Angerforge'),
(9346906, 2, 5120, 'Tarnished Undermine Real: Ambassador Flamelash'),
(9346907, 2, 5120, 'Tarnished Undermine Real: Highlord Omokk'),
(9346908, 2, 5120, 'Tarnished Undermine Real: Shadow Hunter Vosh''gajin'),
(9346909, 2, 5120, 'Tarnished Undermine Real: War Master Voone'),
(9346910, 2, 5120, 'Tarnished Undermine Real: Phalanx'),
(9346911, 2, 5120, 'Tarnished Undermine Real: Hurley Blackbreath'),
(9346912, 2, 5120, 'Tarnished Undermine Real: Overlord Wyrmthalak'),
(9346913, 2, 5120, 'Tarnished Undermine Real: Pyroguard Emberseer'),
(9346914, 2, 5120, 'Tarnished Undermine Real: Magmus'),
(9346915, 2, 5120, 'Tarnished Undermine Real: Halycon'),
(9346916, 2, 5120, 'Tarnished Undermine Real: Gizrul the Slavener'),
(9346917, 2, 5120, 'Tarnished Undermine Real: General Drakkisath'),
(9346918, 2, 5120, 'Tarnished Undermine Real: Warchief Rend Blackhand'),
(9346919, 2, 5120, 'Tarnished Undermine Real: The Beast'),
(9346920, 2, 5120, 'Tarnished Undermine Real: Vectus'),
(9346921, 2, 5120, 'Tarnished Undermine Real: Marduk Blackpool'),
(9346922, 2, 5120, 'Tarnished Undermine Real: Magistrate Barthilas'),
(9346923, 2, 5120, 'Tarnished Undermine Real: Baroness Anastari'),
(9346924, 2, 5120, 'Tarnished Undermine Real: Nerub''enkan'),
(9346925, 2, 5120, 'Tarnished Undermine Real: Maleki the Pallid'),
(9346926, 2, 5120, 'Tarnished Undermine Real: Ramstein the Gorger'),
(9346927, 2, 5120, 'Tarnished Undermine Real: Baron Rivendare'),
(9346928, 2, 5120, 'Tarnished Undermine Real: Lady Illucia Barov'),
(9346929, 2, 5120, 'Tarnished Undermine Real: Jandice Barov'),
(9346930, 2, 5120, 'Tarnished Undermine Real: Lord Alexei Barov'),
(9346931, 2, 5120, 'Tarnished Undermine Real: Instructor Malicia'),
(9346932, 2, 5120, 'Tarnished Undermine Real: Kirtonos the Herald'),
(9346933, 2, 5120, 'Tarnished Undermine Real: The Ravenian'),
(9346934, 2, 5120, 'Tarnished Undermine Real: Ras Frostwhisper'),
(9346935, 2, 5120, 'Tarnished Undermine Real: The Unforgiven'),
(9346936, 2, 5120, 'Tarnished Undermine Real: Urok Doomhowl'),
(9346937, 2, 5120, 'Tarnished Undermine Real: Mother Smolderweb'),
(9346938, 2, 5120, 'Tarnished Undermine Real: Timmy the Cruel'),
(9346939, 2, 5120, 'Tarnished Undermine Real: Archivist Galford'),
(9346940, 2, 5120, 'Tarnished Undermine Real: Balnazzar'),
(9346941, 2, 5120, 'Tarnished Undermine Real: Lorekeeper Polkelt'),
(9346942, 2, 5120, 'Tarnished Undermine Real: Cannon Master Willey'),
(9346943, 2, 5120, 'Tarnished Undermine Real: Malor the Zealous'),
(9346944, 2, 5120, 'Tarnished Undermine Real: Ezra Grimm'),
(9346945, 2, 5120, 'Tarnished Undermine Real: Postmaster Malown'),
(9346946, 2, 5120, 'Tarnished Undermine Real: Doctor Theolen Krastinov'),
(9346947, 2, 5120, 'Tarnished Undermine Real: Prince Tortheldrin'),
(9346948, 2, 5120, 'Tarnished Undermine Real: Magister Kalendris'),
(9346949, 2, 5120, 'Tarnished Undermine Real: Illyanna Ravenoak'),
(9346950, 2, 5120, 'Tarnished Undermine Real: Tendris Warpwood'),
(9346951, 2, 5120, 'Tarnished Undermine Real: Zevrim Thornhoof'),
(9346952, 2, 5120, 'Tarnished Undermine Real: Alzzin the Wildshaper'),
(9346953, 2, 5120, 'Tarnished Undermine Real: Immol''thar'),
(9346954, 2, 5120, 'Tarnished Undermine Real: King Gordok'),
(9346955, 2, 5120, 'Tarnished Undermine Real: Rattlegore'),
(9346956, 2, 5120, 'Tarnished Undermine Real: Hydrospawn'),
(9346957, 2, 5120, 'Tarnished Undermine Real: Lethtendris'),
(9346958, 2, 5120, 'Tarnished Undermine Real: Pusillin'),
(9346959, 2, 5120, 'Tarnished Undermine Real: Balzaphon'),
(9346960, 2, 5120, 'Tarnished Undermine Real: Revanchion'),
(9346961, 2, 5120, 'Tarnished Undermine Real: Lord Blackwood');
DELETE s FROM `everlake_forge_stage` s JOIN `quest_template` x ON x.`ID` = s.`ID`;
INSERT INTO `quest_template` (`ID`, `QuestType`, `Flags`, `LogTitle`) SELECT `ID`, `QuestType`, `Flags`, `LogTitle` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'quest_template', s.`ID`, 0, 0, 0, '2026_11_27_03_world_everlake_undermine_real_daily.sql', 'Undermine Real daily tracking (forg.gg)' FROM `everlake_forge_stage` s;

-- creature_loot_template: 61 tracking quest rows
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `creature_loot_template` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES
(1853, 3, 9346901, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(8983, 3, 9346902, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9017, 3, 9346903, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9019, 3, 9346904, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9033, 3, 9346905, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9156, 3, 9346906, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9196, 3, 9346907, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9236, 3, 9346908, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9237, 3, 9346909, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9502, 3, 9346910, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9537, 3, 9346911, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9568, 3, 9346912, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9816, 3, 9346913, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(9938, 3, 9346914, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10220, 3, 9346915, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10268, 3, 9346916, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10363, 3, 9346917, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10429, 3, 9346918, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10430, 3, 9346919, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10432, 3, 9346920, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10433, 3, 9346921, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10435, 3, 9346922, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10436, 3, 9346923, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10437, 3, 9346924, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10438, 3, 9346925, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10439, 3, 9346926, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10440, 3, 9346927, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10502, 3, 9346928, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10503, 3, 9346929, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10504, 3, 9346930, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10505, 3, 9346931, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10506, 3, 9346932, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10507, 3, 9346933, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10508, 3, 9346934, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10516, 3, 9346935, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10584, 3, 9346936, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10596, 3, 9346937, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10808, 3, 9346938, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10811, 3, 9346939, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10813, 3, 9346940, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10901, 3, 9346941, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(10997, 3, 9346942, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11032, 3, 9346943, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11058, 3, 9346944, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11143, 3, 9346945, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11261, 3, 9346946, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11486, 3, 9346947, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11487, 3, 9346948, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11488, 3, 9346949, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11489, 3, 9346950, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11490, 3, 9346951, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11492, 3, 9346952, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11496, 3, 9346953, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11501, 3, 9346954, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(11622, 3, 9346955, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(13280, 3, 9346956, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(14327, 3, 9346957, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(14354, 3, 9346958, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(14684, 3, 9346959, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(14690, 3, 9346960, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day'),
(14695, 3, 9346961, 100, 0, 1, 0, 1, 1, 'Undermine Real once a day');
DELETE s FROM `everlake_forge_stage` s JOIN `creature_loot_template` x ON x.`Entry` = s.`Entry` AND x.`ItemType` = s.`ItemType` AND x.`Item` = s.`Item`;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) SELECT `Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`Item`, 0, '2026_11_27_03_world_everlake_undermine_real_daily.sql', 'Undermine Real daily tracking (forg.gg)' FROM `everlake_forge_stage` s;

-- conditions: 61 rows, the coin only while the boss's daily quest is not done
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment` FROM `conditions` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(1, 1853, 3469, 0, 0, 43, 0, 9346901, 0, 0, '', 1, 0, 0, '', 'Darkmaster Gandling: Undermine Real only if not looted today'),
(1, 8983, 3469, 0, 0, 43, 0, 9346902, 0, 0, '', 1, 0, 0, '', 'Golem Lord Argelmach: Undermine Real only if not looted today'),
(1, 9017, 3469, 0, 0, 43, 0, 9346903, 0, 0, '', 1, 0, 0, '', 'Lord Incendius: Undermine Real only if not looted today'),
(1, 9019, 3469, 0, 0, 43, 0, 9346904, 0, 0, '', 1, 0, 0, '', 'Emperor Dagran Thaurissan: Undermine Real only if not looted today'),
(1, 9033, 3469, 0, 0, 43, 0, 9346905, 0, 0, '', 1, 0, 0, '', 'General Angerforge: Undermine Real only if not looted today'),
(1, 9156, 3469, 0, 0, 43, 0, 9346906, 0, 0, '', 1, 0, 0, '', 'Ambassador Flamelash: Undermine Real only if not looted today'),
(1, 9196, 3469, 0, 0, 43, 0, 9346907, 0, 0, '', 1, 0, 0, '', 'Highlord Omokk: Undermine Real only if not looted today'),
(1, 9236, 3469, 0, 0, 43, 0, 9346908, 0, 0, '', 1, 0, 0, '', 'Shadow Hunter Vosh''gajin: Undermine Real only if not looted today'),
(1, 9237, 3469, 0, 0, 43, 0, 9346909, 0, 0, '', 1, 0, 0, '', 'War Master Voone: Undermine Real only if not looted today'),
(1, 9502, 3469, 0, 0, 43, 0, 9346910, 0, 0, '', 1, 0, 0, '', 'Phalanx: Undermine Real only if not looted today'),
(1, 9537, 3469, 0, 0, 43, 0, 9346911, 0, 0, '', 1, 0, 0, '', 'Hurley Blackbreath: Undermine Real only if not looted today'),
(1, 9568, 3469, 0, 0, 43, 0, 9346912, 0, 0, '', 1, 0, 0, '', 'Overlord Wyrmthalak: Undermine Real only if not looted today'),
(1, 9816, 3469, 0, 0, 43, 0, 9346913, 0, 0, '', 1, 0, 0, '', 'Pyroguard Emberseer: Undermine Real only if not looted today'),
(1, 9938, 3469, 0, 0, 43, 0, 9346914, 0, 0, '', 1, 0, 0, '', 'Magmus: Undermine Real only if not looted today'),
(1, 10220, 3469, 0, 0, 43, 0, 9346915, 0, 0, '', 1, 0, 0, '', 'Halycon: Undermine Real only if not looted today'),
(1, 10268, 3469, 0, 0, 43, 0, 9346916, 0, 0, '', 1, 0, 0, '', 'Gizrul the Slavener: Undermine Real only if not looted today'),
(1, 10363, 3469, 0, 0, 43, 0, 9346917, 0, 0, '', 1, 0, 0, '', 'General Drakkisath: Undermine Real only if not looted today'),
(1, 10429, 3469, 0, 0, 43, 0, 9346918, 0, 0, '', 1, 0, 0, '', 'Warchief Rend Blackhand: Undermine Real only if not looted today'),
(1, 10430, 3469, 0, 0, 43, 0, 9346919, 0, 0, '', 1, 0, 0, '', 'The Beast: Undermine Real only if not looted today'),
(1, 10432, 3469, 0, 0, 43, 0, 9346920, 0, 0, '', 1, 0, 0, '', 'Vectus: Undermine Real only if not looted today'),
(1, 10433, 3469, 0, 0, 43, 0, 9346921, 0, 0, '', 1, 0, 0, '', 'Marduk Blackpool: Undermine Real only if not looted today'),
(1, 10435, 3469, 0, 0, 43, 0, 9346922, 0, 0, '', 1, 0, 0, '', 'Magistrate Barthilas: Undermine Real only if not looted today'),
(1, 10436, 3469, 0, 0, 43, 0, 9346923, 0, 0, '', 1, 0, 0, '', 'Baroness Anastari: Undermine Real only if not looted today'),
(1, 10437, 3469, 0, 0, 43, 0, 9346924, 0, 0, '', 1, 0, 0, '', 'Nerub''enkan: Undermine Real only if not looted today'),
(1, 10438, 3469, 0, 0, 43, 0, 9346925, 0, 0, '', 1, 0, 0, '', 'Maleki the Pallid: Undermine Real only if not looted today'),
(1, 10439, 3469, 0, 0, 43, 0, 9346926, 0, 0, '', 1, 0, 0, '', 'Ramstein the Gorger: Undermine Real only if not looted today'),
(1, 10440, 3469, 0, 0, 43, 0, 9346927, 0, 0, '', 1, 0, 0, '', 'Baron Rivendare: Undermine Real only if not looted today'),
(1, 10502, 3469, 0, 0, 43, 0, 9346928, 0, 0, '', 1, 0, 0, '', 'Lady Illucia Barov: Undermine Real only if not looted today'),
(1, 10503, 3469, 0, 0, 43, 0, 9346929, 0, 0, '', 1, 0, 0, '', 'Jandice Barov: Undermine Real only if not looted today'),
(1, 10504, 3469, 0, 0, 43, 0, 9346930, 0, 0, '', 1, 0, 0, '', 'Lord Alexei Barov: Undermine Real only if not looted today'),
(1, 10505, 3469, 0, 0, 43, 0, 9346931, 0, 0, '', 1, 0, 0, '', 'Instructor Malicia: Undermine Real only if not looted today'),
(1, 10506, 3469, 0, 0, 43, 0, 9346932, 0, 0, '', 1, 0, 0, '', 'Kirtonos the Herald: Undermine Real only if not looted today'),
(1, 10507, 3469, 0, 0, 43, 0, 9346933, 0, 0, '', 1, 0, 0, '', 'The Ravenian: Undermine Real only if not looted today'),
(1, 10508, 3469, 0, 0, 43, 0, 9346934, 0, 0, '', 1, 0, 0, '', 'Ras Frostwhisper: Undermine Real only if not looted today'),
(1, 10516, 3469, 0, 0, 43, 0, 9346935, 0, 0, '', 1, 0, 0, '', 'The Unforgiven: Undermine Real only if not looted today'),
(1, 10584, 3469, 0, 0, 43, 0, 9346936, 0, 0, '', 1, 0, 0, '', 'Urok Doomhowl: Undermine Real only if not looted today'),
(1, 10596, 3469, 0, 0, 43, 0, 9346937, 0, 0, '', 1, 0, 0, '', 'Mother Smolderweb: Undermine Real only if not looted today'),
(1, 10808, 3469, 0, 0, 43, 0, 9346938, 0, 0, '', 1, 0, 0, '', 'Timmy the Cruel: Undermine Real only if not looted today'),
(1, 10811, 3469, 0, 0, 43, 0, 9346939, 0, 0, '', 1, 0, 0, '', 'Archivist Galford: Undermine Real only if not looted today'),
(1, 10813, 3469, 0, 0, 43, 0, 9346940, 0, 0, '', 1, 0, 0, '', 'Balnazzar: Undermine Real only if not looted today'),
(1, 10901, 3469, 0, 0, 43, 0, 9346941, 0, 0, '', 1, 0, 0, '', 'Lorekeeper Polkelt: Undermine Real only if not looted today'),
(1, 10997, 3469, 0, 0, 43, 0, 9346942, 0, 0, '', 1, 0, 0, '', 'Cannon Master Willey: Undermine Real only if not looted today'),
(1, 11032, 3469, 0, 0, 43, 0, 9346943, 0, 0, '', 1, 0, 0, '', 'Malor the Zealous: Undermine Real only if not looted today'),
(1, 11058, 3469, 0, 0, 43, 0, 9346944, 0, 0, '', 1, 0, 0, '', 'Ezra Grimm: Undermine Real only if not looted today'),
(1, 11143, 3469, 0, 0, 43, 0, 9346945, 0, 0, '', 1, 0, 0, '', 'Postmaster Malown: Undermine Real only if not looted today'),
(1, 11261, 3469, 0, 0, 43, 0, 9346946, 0, 0, '', 1, 0, 0, '', 'Doctor Theolen Krastinov: Undermine Real only if not looted today'),
(1, 11486, 3469, 0, 0, 43, 0, 9346947, 0, 0, '', 1, 0, 0, '', 'Prince Tortheldrin: Undermine Real only if not looted today'),
(1, 11487, 3469, 0, 0, 43, 0, 9346948, 0, 0, '', 1, 0, 0, '', 'Magister Kalendris: Undermine Real only if not looted today'),
(1, 11488, 3469, 0, 0, 43, 0, 9346949, 0, 0, '', 1, 0, 0, '', 'Illyanna Ravenoak: Undermine Real only if not looted today'),
(1, 11489, 3469, 0, 0, 43, 0, 9346950, 0, 0, '', 1, 0, 0, '', 'Tendris Warpwood: Undermine Real only if not looted today'),
(1, 11490, 3469, 0, 0, 43, 0, 9346951, 0, 0, '', 1, 0, 0, '', 'Zevrim Thornhoof: Undermine Real only if not looted today'),
(1, 11492, 3469, 0, 0, 43, 0, 9346952, 0, 0, '', 1, 0, 0, '', 'Alzzin the Wildshaper: Undermine Real only if not looted today'),
(1, 11496, 3469, 0, 0, 43, 0, 9346953, 0, 0, '', 1, 0, 0, '', 'Immol''thar: Undermine Real only if not looted today'),
(1, 11501, 3469, 0, 0, 43, 0, 9346954, 0, 0, '', 1, 0, 0, '', 'King Gordok: Undermine Real only if not looted today'),
(1, 11622, 3469, 0, 0, 43, 0, 9346955, 0, 0, '', 1, 0, 0, '', 'Rattlegore: Undermine Real only if not looted today'),
(1, 13280, 3469, 0, 0, 43, 0, 9346956, 0, 0, '', 1, 0, 0, '', 'Hydrospawn: Undermine Real only if not looted today'),
(1, 14327, 3469, 0, 0, 43, 0, 9346957, 0, 0, '', 1, 0, 0, '', 'Lethtendris: Undermine Real only if not looted today'),
(1, 14354, 3469, 0, 0, 43, 0, 9346958, 0, 0, '', 1, 0, 0, '', 'Pusillin: Undermine Real only if not looted today'),
(1, 14684, 3469, 0, 0, 43, 0, 9346959, 0, 0, '', 1, 0, 0, '', 'Balzaphon: Undermine Real only if not looted today'),
(1, 14690, 3469, 0, 0, 43, 0, 9346960, 0, 0, '', 1, 0, 0, '', 'Revanchion: Undermine Real only if not looted today'),
(1, 14695, 3469, 0, 0, 43, 0, 9346961, 0, 0, '', 1, 0, 0, '', 'Lord Blackwood: Undermine Real only if not looted today');
DELETE s FROM `everlake_forge_stage` s JOIN `conditions` x ON x.`SourceTypeOrReferenceId` = s.`SourceTypeOrReferenceId` AND x.`SourceGroup` = s.`SourceGroup`
  AND x.`SourceEntry` = s.`SourceEntry` AND x.`SourceId` = s.`SourceId` AND x.`ElseGroup` = s.`ElseGroup` AND x.`ConditionTypeOrReference` = s.`ConditionTypeOrReference`
  AND x.`ConditionTarget` = s.`ConditionTarget` AND x.`ConditionValue1` = s.`ConditionValue1` AND x.`ConditionValue2` = s.`ConditionValue2`
  AND x.`ConditionValue3` = s.`ConditionValue3` AND x.`ConditionStringValue1` = s.`ConditionStringValue1`;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) SELECT `SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'conditions', s.`SourceTypeOrReferenceId`, s.`SourceGroup`, s.`SourceEntry`, s.`ConditionValue1`, '2026_11_27_03_world_everlake_undermine_real_daily.sql', 'Undermine Real daily tracking (forg.gg)' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
