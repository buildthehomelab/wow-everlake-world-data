-- Two items the realm has no source for (the tracker's "No source" items), added to the loot of things the realm already
-- spawns. Sources: QuestieDB's WoW Forever data (GPL-3.0), NorgannonDB, the Icy Veins WoW Forever catalogue
-- (https://db.icy-veins.com/wow-forever/) and Wowhead's WoW Forever NPC pages (https://www.wowhead.com/forever, read through
-- the tracker's kept pages: drop counts). Ids and numbers only.
-- 2026_11_22_03_world_everlake_whipweed_feardred_drops.sql: checked by hand.
--
-- Whipweed Heart (19911): QuestieDB, NorgannonDB (100%) and Icy Veins (the object's quest item) all give it from Whipweed
--   180216, which the realm spawns three times in Un'Goro Crater with an empty loot table (Data1 17299). Added at 100%,
--   not quest-only: no quest on the realm asks for it.
-- Feardred's Gauntlets (284285): Wowhead counts 3 drops in 27 kills (11.11%) of Master Feardred 236496, the live id of the
--   classic Master Feardred 6652 the realm spawns at the same spot in Azshara (see file 2026_11_20_33). Added to 6652's
--   loot at 11.11%. Questie lists the same drop.
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
SET @EVERLAKE_FILE := '2026_11_22_03_world_everlake_whipweed_feardred_drops.sql';
START TRANSACTION;

-- Whipweed Heart in Whipweed's loot (180216).
SET @EVERLAKE_LID := (SELECT `Data1` FROM `gameobject_template` WHERE `entry` = 180216 AND `type` = 3 AND `Data1` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `Item` = 19911);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 19911, 100, 0, 1, 0, 1, 1, 'Whipweed' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject_loot_template', @EVERLAKE_LID, 0, 19911, 0, @EVERLAKE_FILE, 'QuestieDB + NorgannonDB (100%) + Icy Veins gameobject=180216: Whipweed Heart' FROM DUAL WHERE @EVERLAKE_LI = 1;

-- Feardred's Gauntlets on Master Feardred (6652).
SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 6652 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `Item` = 284285);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 284285, 11.11, 0, 1, 0, 1, 1, 'Feardred''s Gauntlets' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 284285, 0, @EVERLAKE_FILE, 'Wowhead npc=236496 (= 6652): 3 of 27 kills; QuestieDB' FROM DUAL WHERE @EVERLAKE_LI = 1;

COMMIT;
