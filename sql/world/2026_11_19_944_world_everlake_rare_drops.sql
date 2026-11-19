-- Forever's new loot on creatures the realm already spawns: classic rares and a few others.
-- 2026_11_19_944_world_everlake_rare_drops.sql: written by a script from Wowhead's WoW Forever item pages (2026-11-19).
--
-- Each item below is new in WoW Forever, nothing on the realm gives it, and Wowhead Forever's item page names one
-- dropper, a creature the realm spawns whose loot table lacks the item. Most are classic rares (Kurmokk, Rippa, Jade,
-- Mojo the Twisted, King Mosh, Deathmaw, Lord Maldazzar ...): a rare has one spawn, so Wowhead counts few kills (1 to 13).
-- The user decided on 2026-11-19 to take these drops although they are under the tracker's 10-kill bar. The chance
-- is Wowhead's drops over kills, capped at 100. Executor Asharell (270451), Ceruleos (221651) and Cavalry Scout Alturin
-- (257079) have no loot table at all: they get loot id = their entry, only while it is 0 and no rows use that id.
-- Each row is added only while it is missing. Not checked in game.
--
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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

-- loot ids for the three creatures without a loot table
UPDATE `creature_template_difficulty` SET `LootID` = 221651 WHERE `Entry` = 221651 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 221651) = 0;
UPDATE `creature_template_difficulty` SET `LootID` = 257079 WHERE `Entry` = 257079 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 257079) = 0;
UPDATE `creature_template_difficulty` SET `LootID` = 270451 WHERE `Entry` = 270451 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 270451) = 0;

SET @EVERLAKE_R281746 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 14491 AND `DifficultyID` = 0 AND `LootID` = 14491)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 14491 AND `ItemType` = 0 AND `Item` = 281746);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 14491, 0, 281746, 14.29, 0, 1, 0, 1, 1, 'wowhead 1/7' FROM DUAL WHERE @EVERLAKE_R281746 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 14491, 0, 281746, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=281746 dropped-by 1/7 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R281746 = 1;
SET @EVERLAKE_R281891 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 14490 AND `DifficultyID` = 0 AND `LootID` = 14490)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 14490 AND `ItemType` = 0 AND `Item` = 281891);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 14490, 0, 281891, 16.67, 0, 1, 0, 1, 1, 'wowhead 1/6' FROM DUAL WHERE @EVERLAKE_R281891 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 14490, 0, 281891, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=281891 dropped-by 1/6 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R281891 = 1;
SET @EVERLAKE_R282004 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 14447 AND `DifficultyID` = 0 AND `LootID` = 14447)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 14447 AND `ItemType` = 0 AND `Item` = 282004);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 14447, 0, 282004, 12.5, 0, 1, 0, 1, 1, 'wowhead 1/8' FROM DUAL WHERE @EVERLAKE_R282004 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 14447, 0, 282004, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282004 dropped-by 1/8 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282004 = 1;
SET @EVERLAKE_R282007 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 1063 AND `DifficultyID` = 0 AND `LootID` = 1063)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 1063 AND `ItemType` = 0 AND `Item` = 282007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 1063, 0, 282007, 33.33, 0, 1, 0, 1, 1, 'wowhead 2/6' FROM DUAL WHERE @EVERLAKE_R282007 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 1063, 0, 282007, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282007 dropped-by 2/6 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282007 = 1;
SET @EVERLAKE_R282014 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 8296 AND `DifficultyID` = 0 AND `LootID` = 8296)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 8296 AND `ItemType` = 0 AND `Item` = 282014);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 8296, 0, 282014, 20, 0, 1, 0, 1, 1, 'wowhead 1/5' FROM DUAL WHERE @EVERLAKE_R282014 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 8296, 0, 282014, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282014 dropped-by 1/5 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282014 = 1;
SET @EVERLAKE_R286613 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 6584 AND `DifficultyID` = 0 AND `LootID` = 6584)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 6584 AND `ItemType` = 0 AND `Item` = 286613);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 6584, 0, 286613, 50, 0, 1, 0, 1, 1, 'wowhead 3/6' FROM DUAL WHERE @EVERLAKE_R286613 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 6584, 0, 286613, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=286613 dropped-by 3/6 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R286613 = 1;
SET @EVERLAKE_R277558 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 11447 AND `DifficultyID` = 0 AND `LootID` = 11447)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 11447 AND `ItemType` = 0 AND `Item` = 277558);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 11447, 0, 277558, 100, 0, 1, 0, 1, 1, 'wowhead 1/1' FROM DUAL WHERE @EVERLAKE_R277558 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 11447, 0, 277558, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=277558 dropped-by 1/1 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R277558 = 1;
SET @EVERLAKE_R280081 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 247412 AND `DifficultyID` = 0 AND `LootID` = 247412)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 247412 AND `ItemType` = 0 AND `Item` = 280081);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 247412, 0, 280081, 60, 0, 1, 0, 1, 1, 'wowhead 3/5' FROM DUAL WHERE @EVERLAKE_R280081 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 247412, 0, 280081, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=280081 dropped-by 3/5 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R280081 = 1;
SET @EVERLAKE_R280082 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 247412 AND `DifficultyID` = 0 AND `LootID` = 247412)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 247412 AND `ItemType` = 0 AND `Item` = 280082);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 247412, 0, 280082, 40, 0, 1, 0, 1, 1, 'wowhead 2/5' FROM DUAL WHERE @EVERLAKE_R280082 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 247412, 0, 280082, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=280082 dropped-by 2/5 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R280082 = 1;
SET @EVERLAKE_R282048 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 8978 AND `DifficultyID` = 0 AND `LootID` = 8978)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 8978 AND `ItemType` = 0 AND `Item` = 282048);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 8978, 0, 282048, 28.57, 0, 1, 0, 1, 1, 'wowhead 2/7' FROM DUAL WHERE @EVERLAKE_R282048 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 8978, 0, 282048, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282048 dropped-by 2/7 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282048 = 1;
SET @EVERLAKE_R282049 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 10077 AND `DifficultyID` = 0 AND `LootID` = 10077)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 10077 AND `ItemType` = 0 AND `Item` = 282049);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 10077, 0, 282049, 23.08, 0, 1, 0, 1, 1, 'wowhead 3/13' FROM DUAL WHERE @EVERLAKE_R282049 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 10077, 0, 282049, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282049 dropped-by 3/13 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282049 = 1;
SET @EVERLAKE_R282080 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 10078 AND `DifficultyID` = 0 AND `LootID` = 10078)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 10078 AND `ItemType` = 0 AND `Item` = 282080);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 10078, 0, 282080, 16.67, 0, 1, 0, 1, 1, 'wowhead 1/6' FROM DUAL WHERE @EVERLAKE_R282080 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 10078, 0, 282080, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282080 dropped-by 1/6 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282080 = 1;
SET @EVERLAKE_R282097 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 8279 AND `DifficultyID` = 0 AND `LootID` = 8279)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 8279 AND `ItemType` = 0 AND `Item` = 282097);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 8279, 0, 282097, 33.33, 0, 1, 0, 1, 1, 'wowhead 1/3' FROM DUAL WHERE @EVERLAKE_R282097 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 8279, 0, 282097, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282097 dropped-by 1/3 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282097 = 1;
SET @EVERLAKE_R282631 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 8280 AND `DifficultyID` = 0 AND `LootID` = 8280)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 8280 AND `ItemType` = 0 AND `Item` = 282631);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 8280, 0, 282631, 33.33, 0, 1, 0, 1, 1, 'wowhead 1/3' FROM DUAL WHERE @EVERLAKE_R282631 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 8280, 0, 282631, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282631 dropped-by 1/3 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282631 = 1;
SET @EVERLAKE_R282633 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 8282 AND `DifficultyID` = 0 AND `LootID` = 8282)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 8282 AND `ItemType` = 0 AND `Item` = 282633);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 8282, 0, 282633, 50, 0, 1, 0, 1, 1, 'wowhead 5/10' FROM DUAL WHERE @EVERLAKE_R282633 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 8282, 0, 282633, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282633 dropped-by 5/10 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282633 = 1;
SET @EVERLAKE_R282702 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 2604 AND `DifficultyID` = 0 AND `LootID` = 2604)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 2604 AND `ItemType` = 0 AND `Item` = 282702);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 2604, 0, 282702, 25, 0, 1, 0, 1, 1, 'wowhead 2/8' FROM DUAL WHERE @EVERLAKE_R282702 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 2604, 0, 282702, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282702 dropped-by 2/8 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282702 = 1;
SET @EVERLAKE_R282704 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 2598 AND `DifficultyID` = 0 AND `LootID` = 2598)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 2598 AND `ItemType` = 0 AND `Item` = 282704);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 2598, 0, 282704, 50, 0, 1, 0, 1, 1, 'wowhead 2/4' FROM DUAL WHERE @EVERLAKE_R282704 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 2598, 0, 282704, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=282704 dropped-by 2/4 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R282704 = 1;
SET @EVERLAKE_R284041 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 8213 AND `DifficultyID` = 0 AND `LootID` = 8213)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 8213 AND `ItemType` = 0 AND `Item` = 284041);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 8213, 0, 284041, 20, 0, 1, 0, 1, 1, 'wowhead 1/5' FROM DUAL WHERE @EVERLAKE_R284041 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 8213, 0, 284041, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284041 dropped-by 1/5 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284041 = 1;
SET @EVERLAKE_R284064 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 8215 AND `DifficultyID` = 0 AND `LootID` = 8215)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 8215 AND `ItemType` = 0 AND `Item` = 284064);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 8215, 0, 284064, 33.33, 0, 1, 0, 1, 1, 'wowhead 2/6' FROM DUAL WHERE @EVERLAKE_R284064 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 8215, 0, 284064, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284064 dropped-by 2/6 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284064 = 1;
SET @EVERLAKE_R284065 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 1848 AND `DifficultyID` = 0 AND `LootID` = 1848)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 1848 AND `ItemType` = 0 AND `Item` = 284065);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 1848, 0, 284065, 20, 0, 1, 0, 1, 1, 'wowhead 1/5' FROM DUAL WHERE @EVERLAKE_R284065 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 1848, 0, 284065, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284065 dropped-by 1/5 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284065 = 1;
SET @EVERLAKE_R284079 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 1839 AND `DifficultyID` = 0 AND `LootID` = 1839)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 1839 AND `ItemType` = 0 AND `Item` = 284079);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 1839, 0, 284079, 50, 0, 1, 0, 1, 1, 'wowhead 4/8' FROM DUAL WHERE @EVERLAKE_R284079 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 1839, 0, 284079, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284079 dropped-by 4/8 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284079 = 1;
SET @EVERLAKE_R284086 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 1841 AND `DifficultyID` = 0 AND `LootID` = 1841)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 1841 AND `ItemType` = 0 AND `Item` = 284086);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 1841, 0, 284086, 14.29, 0, 1, 0, 1, 1, 'wowhead 1/7' FROM DUAL WHERE @EVERLAKE_R284086 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 1841, 0, 284086, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284086 dropped-by 1/7 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284086 = 1;
SET @EVERLAKE_R284105 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 10817 AND `DifficultyID` = 0 AND `LootID` = 10817)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 10817 AND `ItemType` = 0 AND `Item` = 284105);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 10817, 0, 284105, 33.33, 0, 1, 0, 1, 1, 'wowhead 1/3' FROM DUAL WHERE @EVERLAKE_R284105 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 10817, 0, 284105, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284105 dropped-by 1/3 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284105 = 1;
SET @EVERLAKE_R284154 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 10825 AND `DifficultyID` = 0 AND `LootID` = 10825)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 10825 AND `ItemType` = 0 AND `Item` = 284154);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 10825, 0, 284154, 20, 0, 1, 0, 1, 1, 'wowhead 2/10' FROM DUAL WHERE @EVERLAKE_R284154 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 10825, 0, 284154, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284154 dropped-by 2/10 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284154 = 1;
SET @EVERLAKE_R284161 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 10821 AND `DifficultyID` = 0 AND `LootID` = 10821)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 10821 AND `ItemType` = 0 AND `Item` = 284161);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 10821, 0, 284161, 100, 0, 1, 0, 1, 1, 'wowhead 1/1' FROM DUAL WHERE @EVERLAKE_R284161 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 10821, 0, 284161, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284161 dropped-by 1/1 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284161 = 1;
SET @EVERLAKE_R284199 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 14339 AND `DifficultyID` = 0 AND `LootID` = 14339)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 14339 AND `ItemType` = 0 AND `Item` = 284199);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 14339, 0, 284199, 50, 0, 1, 0, 1, 1, 'wowhead 2/4' FROM DUAL WHERE @EVERLAKE_R284199 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 14339, 0, 284199, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284199 dropped-by 2/4 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284199 = 1;
SET @EVERLAKE_R284231 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 10201 AND `DifficultyID` = 0 AND `LootID` = 10201)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 10201 AND `ItemType` = 0 AND `Item` = 284231);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 10201, 0, 284231, 100, 0, 1, 0, 1, 1, 'wowhead 2/2' FROM DUAL WHERE @EVERLAKE_R284231 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 10201, 0, 284231, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284231 dropped-by 2/2 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284231 = 1;
SET @EVERLAKE_R284253 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 10198 AND `DifficultyID` = 0 AND `LootID` = 10198)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 10198 AND `ItemType` = 0 AND `Item` = 284253);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 10198, 0, 284253, 55.56, 0, 1, 0, 1, 1, 'wowhead 5/9' FROM DUAL WHERE @EVERLAKE_R284253 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 10198, 0, 284253, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284253 dropped-by 5/9 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284253 = 1;
SET @EVERLAKE_R284262 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 10197 AND `DifficultyID` = 0 AND `LootID` = 10197)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 10197 AND `ItemType` = 0 AND `Item` = 284262);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 10197, 0, 284262, 10, 0, 1, 0, 1, 1, 'wowhead 1/10' FROM DUAL WHERE @EVERLAKE_R284262 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 10197, 0, 284262, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284262 dropped-by 1/10 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284262 = 1;
SET @EVERLAKE_R285284 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 10197 AND `DifficultyID` = 0 AND `LootID` = 10197)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 10197 AND `ItemType` = 0 AND `Item` = 285284);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 10197, 0, 285284, 10, 0, 1, 0, 1, 1, 'wowhead 1/10' FROM DUAL WHERE @EVERLAKE_R285284 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 10197, 0, 285284, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=285284 dropped-by 1/10 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R285284 = 1;
SET @EVERLAKE_R284707 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 14227 AND `DifficultyID` = 0 AND `LootID` = 14227)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 14227 AND `ItemType` = 0 AND `Item` = 284707);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 14227, 0, 284707, 16.67, 0, 1, 0, 1, 1, 'wowhead 1/6' FROM DUAL WHERE @EVERLAKE_R284707 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 14227, 0, 284707, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284707 dropped-by 1/6 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284707 = 1;
SET @EVERLAKE_R284708 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 14226 AND `DifficultyID` = 0 AND `LootID` = 14226)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 14226 AND `ItemType` = 0 AND `Item` = 284708);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 14226, 0, 284708, 16.67, 0, 1, 0, 1, 1, 'wowhead 1/6' FROM DUAL WHERE @EVERLAKE_R284708 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 14226, 0, 284708, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284708 dropped-by 1/6 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284708 = 1;
SET @EVERLAKE_R284843 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 5352 AND `DifficultyID` = 0 AND `LootID` = 5352)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 5352 AND `ItemType` = 0 AND `Item` = 284843);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 5352, 0, 284843, 20, 0, 1, 0, 1, 1, 'wowhead 1/5' FROM DUAL WHERE @EVERLAKE_R284843 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 5352, 0, 284843, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284843 dropped-by 1/5 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284843 = 1;
SET @EVERLAKE_R284850 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 5343 AND `DifficultyID` = 0 AND `LootID` = 5343)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 5343 AND `ItemType` = 0 AND `Item` = 284850);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 5343, 0, 284850, 18.18, 0, 1, 0, 1, 1, 'wowhead 2/11' FROM DUAL WHERE @EVERLAKE_R284850 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 5343, 0, 284850, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=284850 dropped-by 2/11 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R284850 = 1;
SET @EVERLAKE_R285063 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 4339 AND `DifficultyID` = 0 AND `LootID` = 4339)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 4339 AND `ItemType` = 0 AND `Item` = 285063);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 4339, 0, 285063, 50, 0, 1, 0, 1, 1, 'wowhead 1/2' FROM DUAL WHERE @EVERLAKE_R285063 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 4339, 0, 285063, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=285063 dropped-by 1/2 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R285063 = 1;
SET @EVERLAKE_R285177 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 5937 AND `DifficultyID` = 0 AND `LootID` = 5937)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 5937 AND `ItemType` = 0 AND `Item` = 285177);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 5937, 0, 285177, 11.11, 0, 1, 0, 1, 1, 'wowhead 1/9' FROM DUAL WHERE @EVERLAKE_R285177 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 5937, 0, 285177, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=285177 dropped-by 1/9 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R285177 = 1;
SET @EVERLAKE_R286554 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 8199 AND `DifficultyID` = 0 AND `LootID` = 8199)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 8199 AND `ItemType` = 0 AND `Item` = 286554);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 8199, 0, 286554, 50, 0, 1, 0, 1, 1, 'wowhead 1/2' FROM DUAL WHERE @EVERLAKE_R286554 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 8199, 0, 286554, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=286554 dropped-by 1/2 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R286554 = 1;
SET @EVERLAKE_R286571 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 8204 AND `DifficultyID` = 0 AND `LootID` = 8204)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 8204 AND `ItemType` = 0 AND `Item` = 286571);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 8204, 0, 286571, 12.5, 0, 1, 0, 1, 1, 'wowhead 1/8' FROM DUAL WHERE @EVERLAKE_R286571 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 8204, 0, 286571, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=286571 dropped-by 1/8 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R286571 = 1;
SET @EVERLAKE_R286572 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 8202 AND `DifficultyID` = 0 AND `LootID` = 8202)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 8202 AND `ItemType` = 0 AND `Item` = 286572);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 8202, 0, 286572, 50, 0, 1, 0, 1, 1, 'wowhead 3/6' FROM DUAL WHERE @EVERLAKE_R286572 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 8202, 0, 286572, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=286572 dropped-by 3/6 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R286572 = 1;
SET @EVERLAKE_R286619 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 6585 AND `DifficultyID` = 0 AND `LootID` = 6585)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 6585 AND `ItemType` = 0 AND `Item` = 286619);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 6585, 0, 286619, 20, 0, 1, 0, 1, 1, 'wowhead 2/10' FROM DUAL WHERE @EVERLAKE_R286619 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 6585, 0, 286619, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=286619 dropped-by 2/10 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R286619 = 1;
SET @EVERLAKE_R279415 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 270451 AND `DifficultyID` = 0 AND `LootID` = 270451)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 270451 AND `ItemType` = 0 AND `Item` = 279415);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 270451, 0, 279415, 100, 0, 1, 0, 1, 1, 'wowhead 1/1' FROM DUAL WHERE @EVERLAKE_R279415 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 270451, 0, 279415, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=279415 dropped-by 1/1 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R279415 = 1;
SET @EVERLAKE_R219935 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 221651 AND `DifficultyID` = 0 AND `LootID` = 221651)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 221651 AND `ItemType` = 0 AND `Item` = 219935);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 221651, 0, 219935, 10, 0, 1, 0, 1, 1, 'wowhead 1/10' FROM DUAL WHERE @EVERLAKE_R219935 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 221651, 0, 219935, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=219935 dropped-by 1/10 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R219935 = 1;
SET @EVERLAKE_R263930 := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 257079 AND `DifficultyID` = 0 AND `LootID` = 257079)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 257079 AND `ItemType` = 0 AND `Item` = 263930);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 257079, 0, 263930, 66.67, 0, 1, 0, 1, 1, 'wowhead 2/3' FROM DUAL WHERE @EVERLAKE_R263930 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 257079, 0, 263930, 0, '2026_11_19_944_world_everlake_rare_drops.sql', 'wowhead item=263930 dropped-by 2/3 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_R263930 = 1;

COMMIT;
