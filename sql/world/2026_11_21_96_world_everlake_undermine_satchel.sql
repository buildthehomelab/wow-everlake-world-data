-- Undermine Satchel (271994), the reward of the Trading Post quests 96075 In Demand - Blackrock Legal Records and 96076
-- In Demand - Ancient Elven Curiosities, opens (client item flag 0x4) but has no item_loot_template rows on the realm. Six
-- items it holds on live are on the tracker's Incomplete items list ("No source: loot, vendor, quest, craft or shop").
-- 2026_11_21_96_world_everlake_undermine_satchel.sql: written by a script from the tracker's kept Wowhead facts (2026-11-21), checked by hand.
--
-- Contents and chances: Wowhead's WoW Forever item page of the satchel ("contains", about 67 openings). The chances add up
-- to 92%, so the satchel gives one of them (GroupId 1, INFERRED from the sum). Each row is added only while missing and
-- recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again
-- changes nothing. Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_21_96_world_everlake_undermine_satchel.sql';
START TRANSACTION;

SET @EVERLAKE_LI := NOT EXISTS (SELECT 1 FROM `item_loot_template` WHERE `Entry` = 271994 AND `ItemType` = 0 AND `Item` = 272016);
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 271994, 0, 272016, 53.73, 0, 1, 1, 1, 1, 'Undermine Satchel: Gold Nugget (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'item_loot_template', 271994, 0, 272016, 0, @EVERLAKE_FILE, 'wowhead item=271994 contains' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := NOT EXISTS (SELECT 1 FROM `item_loot_template` WHERE `Entry` = 271994 AND `ItemType` = 0 AND `Item` = 272015);
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 271994, 0, 272015, 20.9, 0, 1, 1, 1, 1, 'Undermine Satchel: Huge Quartz Gem (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'item_loot_template', 271994, 0, 272015, 0, @EVERLAKE_FILE, 'wowhead item=271994 contains' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := NOT EXISTS (SELECT 1 FROM `item_loot_template` WHERE `Entry` = 271994 AND `ItemType` = 0 AND `Item` = 272014);
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 271994, 0, 272014, 5.97, 0, 1, 1, 1, 1, 'Undermine Satchel: Silver Necklace (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'item_loot_template', 271994, 0, 272014, 0, @EVERLAKE_FILE, 'wowhead item=271994 contains' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := NOT EXISTS (SELECT 1 FROM `item_loot_template` WHERE `Entry` = 271994 AND `ItemType` = 0 AND `Item` = 272001);
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 271994, 0, 272001, 4.48, 0, 1, 1, 1, 1, 'Undermine Satchel: Gold Ring (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'item_loot_template', 271994, 0, 272001, 0, @EVERLAKE_FILE, 'wowhead item=271994 contains' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := NOT EXISTS (SELECT 1 FROM `item_loot_template` WHERE `Entry` = 271994 AND `ItemType` = 0 AND `Item` = 248823);
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 271994, 0, 248823, 4.48, 0, 1, 1, 1, 1, 'Undermine Satchel: Marefoil (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'item_loot_template', 271994, 0, 248823, 0, @EVERLAKE_FILE, 'wowhead item=271994 contains' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := NOT EXISTS (SELECT 1 FROM `item_loot_template` WHERE `Entry` = 271994 AND `ItemType` = 0 AND `Item` = 248821);
INSERT INTO `item_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 271994, 0, 248821, 2.99, 0, 1, 1, 1, 1, 'Undermine Satchel: Demonsage (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'item_loot_template', 271994, 0, 248821, 0, @EVERLAKE_FILE, 'wowhead item=271994 contains' FROM DUAL WHERE @EVERLAKE_LI = 1;

COMMIT;
