-- Krol'dok Stronghold's own trash drops (287007-287015), which nothing on the realm gives (the tracker's Incomplete items,
-- "No source: loot, vendor, quest, craft or shop").
-- 2026_11_21_95_world_everlake_kroldok_trash_drops.sql: written by a script from the tracker's kept source facts (2026-11-21), checked by hand.
--
-- On live WoW Forever the stronghold's trash drops eight items of its own: Stretched Footpads 287007, Ogre Magi's Mantle
-- 287008, Twilight Enforcer's Legs 287009, Outrider's Gloves 287010, Guise of Battle 287011, Krol'dok Warplate Gauntlets
-- 287012, Krol'dok Warplate Legplates 287013, Supreme Smasher 287015. Wowhead's WoW Forever item pages, Icy Veins' WoW
-- Forever catalogue (players' addons on live) and QuestieDB all name the same 13 creatures. The realm spawns the dungeon's
-- live entries since core 2026_11_21_80/82/83, but those give no loot (loot id 0) or only the quest items 267091/267234.
--
-- Chance = Wowhead's drops over kills for that creature; where Wowhead does not list the creature, Icy Veins' rate
-- (Shadowhide Bully, Curseweaver, Twilight Lieutenant, Riding Wolf, Twilight Peon: marked 'icyveins' in the comment).
-- Questie-only droppers (268423) and creatures the realm lacks (262716) are left out. Creatures with loot id 0 get loot
-- id = their entry, only while it is 0 and no rows use that id. Each row is added only while it is missing and recorded
-- in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing. Numbered 95 so it sorts after the core's 2026_11_21_83, which sets these loot ids to 0. Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_21_95_world_everlake_kroldok_trash_drops.sql';
START TRANSACTION;

-- 257885
UPDATE `creature_template_difficulty` SET `LootID` = 257885 WHERE `Entry` = 257885 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 257885) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 257885 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287007, 0.17, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287007, 0, @EVERLAKE_FILE, 'wowhead rate for 257885' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287008);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287008, 0.29, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287008, 0, @EVERLAKE_FILE, 'wowhead rate for 257885' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.11, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'wowhead rate for 257885' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 1.14, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 257885' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 0.8, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 257885' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287015);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287015, 0.11, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287015, 0, @EVERLAKE_FILE, 'wowhead rate for 257885' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 257888
UPDATE `creature_template_difficulty` SET `LootID` = 257888 WHERE `Entry` = 257888 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 257888) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 257888 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287007, 0.28, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287007, 0, @EVERLAKE_FILE, 'wowhead rate for 257888' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287009);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287009, 0.19, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287009, 0, @EVERLAKE_FILE, 'wowhead rate for 257888' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 0.75, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 257888' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 1.22, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 257888' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 257900
UPDATE `creature_template_difficulty` SET `LootID` = 257900 WHERE `Entry` = 257900 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 257900) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 257900 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287007, 0.36, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287007, 0, @EVERLAKE_FILE, 'wowhead rate for 257900' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287008);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287008, 0.3, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287008, 0, @EVERLAKE_FILE, 'wowhead rate for 257900' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287009);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287009, 0.18, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287009, 0, @EVERLAKE_FILE, 'wowhead rate for 257900' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.12, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'wowhead rate for 257900' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 1.21, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 257900' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 1.57, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 257900' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 258038
UPDATE `creature_template_difficulty` SET `LootID` = 258038 WHERE `Entry` = 258038 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 258038) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 258038 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287007, 0.24, 0, 1, 0, 1, 1, 'Krol''dok trash drop (icyveins)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287007, 0, @EVERLAKE_FILE, 'icyveins rate for 258038' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287008);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287008, 0.33, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287008, 0, @EVERLAKE_FILE, 'wowhead rate for 258038' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287009);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287009, 0.41, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287009, 0, @EVERLAKE_FILE, 'wowhead rate for 258038' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.33, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'wowhead rate for 258038' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 0.49, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 258038' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 1.48, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 258038' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 258040
UPDATE `creature_template_difficulty` SET `LootID` = 258040 WHERE `Entry` = 258040 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 258040) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 258040 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287007, 0.45, 0, 1, 0, 1, 1, 'Krol''dok trash drop (icyveins)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287007, 0, @EVERLAKE_FILE, 'icyveins rate for 258040' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.45, 0, 1, 0, 1, 1, 'Krol''dok trash drop (icyveins)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'icyveins rate for 258040' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 2.22, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 258040' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 0.74, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 258040' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 258042
UPDATE `creature_template_difficulty` SET `LootID` = 258042 WHERE `Entry` = 258042 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 258042) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 258042 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287007, 0.23, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287007, 0, @EVERLAKE_FILE, 'wowhead rate for 258042' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287008);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287008, 0.1, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287008, 0, @EVERLAKE_FILE, 'wowhead rate for 258042' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287009);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287009, 0.23, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287009, 0, @EVERLAKE_FILE, 'wowhead rate for 258042' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.1, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'wowhead rate for 258042' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 0.93, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 258042' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 0.85, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 258042' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287015);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287015, 0.08, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287015, 0, @EVERLAKE_FILE, 'wowhead rate for 258042' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 258100
UPDATE `creature_template_difficulty` SET `LootID` = 258100 WHERE `Entry` = 258100 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 258100) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 258100 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287007, 0.41, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287007, 0, @EVERLAKE_FILE, 'wowhead rate for 258100' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287009);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287009, 0.24, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287009, 0, @EVERLAKE_FILE, 'wowhead rate for 258100' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.24, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'wowhead rate for 258100' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 0.97, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 258100' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 1.22, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 258100' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287015);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287015, 0.16, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287015, 0, @EVERLAKE_FILE, 'wowhead rate for 258100' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 258102
UPDATE `creature_template_difficulty` SET `LootID` = 258102 WHERE `Entry` = 258102 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 258102) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 258102 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287008);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287008, 0.18, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287008, 0, @EVERLAKE_FILE, 'wowhead rate for 258102' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287009);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287009, 0.14, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287009, 0, @EVERLAKE_FILE, 'wowhead rate for 258102' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287010);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287010, 5.44, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287010, 0, @EVERLAKE_FILE, 'wowhead rate for 258102' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.09, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'wowhead rate for 258102' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 0.88, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 258102' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 1.11, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 258102' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 258104
UPDATE `creature_template_difficulty` SET `LootID` = 258104 WHERE `Entry` = 258104 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 258104) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 258104 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287007, 0.23, 0, 1, 0, 1, 1, 'Krol''dok trash drop (icyveins)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287007, 0, @EVERLAKE_FILE, 'icyveins rate for 258104' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287009);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287009, 0.08, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287009, 0, @EVERLAKE_FILE, 'wowhead rate for 258104' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.23, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'wowhead rate for 258104' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 1.03, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 258104' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 0.84, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 258104' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287015);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287015, 0.15, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287015, 0, @EVERLAKE_FILE, 'wowhead rate for 258104' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 258687
UPDATE `creature_template_difficulty` SET `LootID` = 258687 WHERE `Entry` = 258687 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 258687) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 258687 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287007, 0.27, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287007, 0, @EVERLAKE_FILE, 'wowhead rate for 258687' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287008);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287008, 0.26, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287008, 0, @EVERLAKE_FILE, 'wowhead rate for 258687' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287009);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287009, 0.15, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287009, 0, @EVERLAKE_FILE, 'wowhead rate for 258687' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.18, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'wowhead rate for 258687' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 1.35, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 258687' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 1.57, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 258687' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287015);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287015, 0.22, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287015, 0, @EVERLAKE_FILE, 'wowhead rate for 258687' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 262065
UPDATE `creature_template_difficulty` SET `LootID` = 262065 WHERE `Entry` = 262065 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 262065) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 262065 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.82, 0, 1, 0, 1, 1, 'Krol''dok trash drop (icyveins)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'icyveins rate for 262065' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 0.68, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 262065' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 0.82, 0, 1, 0, 1, 1, 'Krol''dok trash drop (icyveins)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'icyveins rate for 262065' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287015);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287015, 0.82, 0, 1, 0, 1, 1, 'Krol''dok trash drop (icyveins)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287015, 0, @EVERLAKE_FILE, 'icyveins rate for 262065' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- 262067
UPDATE `creature_template_difficulty` SET `LootID` = 262067 WHERE `Entry` = 262067 AND `DifficultyID` = 0 AND `LootID` = 0
  AND (SELECT COUNT(*) FROM `creature_loot_template` WHERE `Entry` = 262067) = 0;
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 262067 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287007);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287007, 0.34, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287007, 0, @EVERLAKE_FILE, 'wowhead rate for 262067' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287009);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287009, 0.31, 0, 1, 0, 1, 1, 'Krol''dok trash drop (icyveins)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287009, 0, @EVERLAKE_FILE, 'icyveins rate for 262067' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287011);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287011, 0.57, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287011, 0, @EVERLAKE_FILE, 'wowhead rate for 262067' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287012);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287012, 0.57, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287012, 0, @EVERLAKE_FILE, 'wowhead rate for 262067' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287013);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287013, 0.68, 0, 1, 0, 1, 1, 'Krol''dok trash drop (wowhead)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287013, 0, @EVERLAKE_FILE, 'wowhead rate for 262067' FROM DUAL WHERE @EVERLAKE_LI = 1;
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 287015);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 287015, 0.31, 0, 1, 0, 1, 1, 'Krol''dok trash drop (icyveins)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 287015, 0, @EVERLAKE_FILE, 'icyveins rate for 262067' FROM DUAL WHERE @EVERLAKE_LI = 1;

COMMIT;
