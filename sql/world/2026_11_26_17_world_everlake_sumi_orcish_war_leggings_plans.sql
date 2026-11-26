-- Blacksmithing: Sumi (3356) sells Plans: Orcish War Leggings (7994) to players who finished "The Old Ways" (2756).
-- 2026_11_26_17_world_everlake_sumi_orcish_war_leggings_plans.sql: written by hand (2026-11-26).
--
-- Blizzard's server-side note of 17 November 2026 (step 70959+1): "Blacksmithing: The quest "The Old Ways" now grants
-- the Orcish War Leggings recipe via an item. Players who did not receive their recipe, or lose it, can acquire a
-- replacement from Sumi inside the nearby blacksmithing hut once the quest is completed." The realm's quest already
-- rewards the plans (RewardItem1 7994), but Sumi did not sell them. One vendor row (next free slot, the item's own buy
-- price) shown only to players who have quest 2756 rewarded (vendor condition, source type 23). Icy Veins' record of
-- Sumi's wares (seven items) does not list it: players who have not done the quest do not see it.
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
SET @MISSING := (SELECT COUNT(*) = 0 FROM `npc_vendor` WHERE `entry` = 3356 AND `item` = 7994 AND `type` = 1)
    AND (SELECT COUNT(*) FROM `creature_template` WHERE `entry` = 3356 AND (`npcflag` & 128) = 128) = 1;
SET @SLOT := (SELECT COALESCE(MAX(`slot`) + 1, 0) FROM `npc_vendor` WHERE `entry` = 3356);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`)
SELECT 3356, @SLOT, 7994, 0, 0, 0, 1, NULL, 0, 0, 0 FROM DUAL WHERE @MISSING;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`,
    `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 23, 3356, 7994, 0, 0, 8, 0, 2756, 0, 0, '', 0, 0, 0, '', 'Sumi - Plans: Orcish War Leggings only after The Old Ways (note 70959+1)'
FROM DUAL WHERE @MISSING AND NOT EXISTS (SELECT 1 FROM `conditions` WHERE `SourceTypeOrReferenceId` = 23 AND `SourceGroup` = 3356 AND `SourceEntry` = 7994 AND `ConditionTypeOrReference` = 8 AND `ConditionValue1` = 2756);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'npc_vendor', 3356, 7994, 1, 0, '2026_11_26_17_world_everlake_sumi_orcish_war_leggings_plans.sql', 'note 70959+1 2026-11-17 (Sumi sells the plans after the quest)' FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 23, 3356, 7994, 8, '2026_11_26_17_world_everlake_sumi_orcish_war_leggings_plans.sql', 'note 70959+1 2026-11-17 (Sumi sells the plans after the quest)' FROM DUAL WHERE @MISSING;
COMMIT;
