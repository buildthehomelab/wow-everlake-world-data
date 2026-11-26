-- Feralas: Perfect Yeti Hide (18972) no longer drops while you are on the quest it starts, "Perfect Yeti Hide" (7738).
-- 2026_11_26_14_world_everlake_perfect_yeti_hide_on_quest.sql: written by hand (2026-11-26).
--
-- Blizzard's server-side note of 20 November 2026 (step 71037+1): "Feralas - Fixed an issue where Perfect Yeti Hide
-- could drop again while you're already on the quest it starts, "Perfect Yeti Hide."" The item's client record starts
-- quest 7738 (StartQuestID). It drops from Rage Scar Yeti 5296, Elder Rage Scar 5297, Ferocious Rage Scar 5299 and
-- Lurking Feral Scar 7848 (VMaNGOS rates), each with a Horde-only condition. Each loot row gets a second condition in the
-- same group: the looter's quest 7738 is not taken or complete (CONDITION_QUESTSTATE 47, states incomplete 8 + complete
-- 2, negated).
--
-- Every added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing. Not checked in game.

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
DROP TEMPORARY TABLE IF EXISTS `everlake_yeti`;
CREATE TEMPORARY TABLE `everlake_yeti` (`Entry` int unsigned NOT NULL PRIMARY KEY, `missing` tinyint NOT NULL DEFAULT 0);
INSERT INTO `everlake_yeti` (`Entry`) VALUES (5296), (5297), (5299), (7848);
UPDATE `everlake_yeti` s SET s.`missing` = 1
WHERE EXISTS (SELECT 1 FROM `creature_loot_template` l WHERE l.`Entry` = s.`Entry` AND l.`ItemType` = 0 AND l.`Item` = 18972)
  AND NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 1 AND c.`SourceGroup` = s.`Entry` AND c.`SourceEntry` = 18972
                  AND c.`ConditionTypeOrReference` = 47 AND c.`ConditionValue1` = 7738);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
    `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 1, s.`Entry`, 18972, 0, 0, 47, 0, 7738, 10, 0, '', 1, 0, 0, '', 'Perfect Yeti Hide - not while quest 7738 is taken or complete (note 71037+1)'
FROM `everlake_yeti` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 1, s.`Entry`, 18972, 47, '2026_11_26_14_world_everlake_perfect_yeti_hide_on_quest.sql', 'note 71037+1 2026-11-20; quest 7738 from item 18972 StartQuestID' FROM `everlake_yeti` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_yeti`;
COMMIT;
