-- Two Azshara drops live gives from new ids of NPCs the realm still runs under their classic ids, added to the classic
-- NPCs' loot, as file 2026_11_20_33 did for Master Feardred. Drop counts from Wowhead's WoW Forever NPC pages
-- (https://www.wowhead.com/forever, read through the tracker's kept pages), backed by the Icy Veins WoW Forever catalogue
-- (https://db.icy-veins.com/wow-forever/). Ids and numbers only. The user chose this over adding the new ids (2026-11-22).
-- 2026_11_22_05_world_everlake_sesspira_hawkhelm_drops.sql: checked by hand.
--
-- Lady Sesspira's Key (238345): Wowhead counts 39 drops in 70 kills (55.71%) of Lady Sesspira 239942. The realm spawns
--   the classic Lady Sesspira 6649 at 3458 -5072; live's points spread around 3516-3577 -5082 to -5153 (height.py), the
--   same camp. Added to 6649's loot at 55.71%, not quest-only: no quest on the realm asks for the key.
-- Seal of the Warrior (246721): Wowhead counts 44 drops in 64 kills (68.75%) of Magister Hawkhelm 246991; Icy Veins gives
--   it as a quest drop (60%). The realm spawns the classic Magister Hawkhelm 6647 at 4297 -6241; live's points are about
--   140 yards north-east (4412 -6157). Added to 6647's loot at 68.75%, quest-only (quest 91497 Seals of the Sin'dorei).
-- Each added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing. Not tried in game.
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
SET @EVERLAKE_FILE := '2026_11_22_05_world_everlake_sesspira_hawkhelm_drops.sql';
START TRANSACTION;

-- Lady Sesspira's Key on Lady Sesspira (6649).
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 6649 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `Item` = 238345);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 238345, 55.71, 0, 1, 0, 1, 1, 'Lady Sesspira''s Key' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 238345, 0, @EVERLAKE_FILE, 'Wowhead npc=239942 (= 6649): 39 of 70 kills; Icy Veins' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- Seal of the Warrior on Magister Hawkhelm (6647).
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 6647 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `Item` = 246721);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 246721, 68.75, 1, 1, 0, 1, 1, 'Seal of the Warrior' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 246721, 0, @EVERLAKE_FILE, 'Wowhead npc=246991 (= 6647): 44 of 64 kills; Icy Veins quest drop' FROM DUAL WHERE @EVERLAKE_LI = 1;

COMMIT;
