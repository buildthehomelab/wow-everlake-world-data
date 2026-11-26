-- Galestrider (251661) and Ornery Galestrider (251707), Zephras Isle: loot at live rates, and skinning of their own.
-- 2026_11_25_23_world_everlake_galestrider_loot.sql: written by hand from the tracker's kept facts (2026-11-25), after a player reported their loot looked wrong.
--
-- Two earlier sources set the rates far above what the live game gives:
--   - rows marked 'QuestieDB v1.1.2' (the core fork's QuestieDB import): grey armour on the level 5-6 Galestrider at
--     3.3-5.2% each where the live game gives 0.5-0.8%, and level-20 greens and greys on the level 8-9 Ornery Galestrider
--     at 0.5-6% where it gives 0.02-0.18% (15007 6.01% against 0.10%, 14095 4.05% against 0.03%);
--   - rows marked 'Forever live drop 2026-11-15' (the core fork's sniff of 23 and 27 kills): every item seen once, at a
--     flat 3%, four of them as a second row beside the QuestieDB one for the same item.
-- Icy Veins' WoW Forever database (https://db.icy-veins.com/wow-forever/: players' addons on live) records both creatures
-- from many kills (its Strider Meat rate, 55.8%, matches Wowhead's 56.1%). Here:
--   - 64 rows at three times or more Icy Veins' rate take Icy Veins' rate (3287, which Icy Veins records at under
--     0.01%, gets 0.01%); each changes only while it still holds the old chance;
--   - the four second rows from the sniff go, the item keeping its other row;
--   - quest items are untouched: Strider Meat 55.8% and Small Egg 18.8% (Restocking the Larders, Easy Strider Living)
--     and the quest-only Lowlands Galestrider Tenderloin 26.8% (Ornery Ornery Galestriders) already match the live game.
--
-- Skinning: both use table 118, shared with other creatures (Light Leather 50% and Ruined Leather Scraps 100% in one
-- group). Wowhead's WoW Forever database (through the ForeverTracker's page cache) records the Galestrider giving Ruined
-- Leather Scraps (100%), and the Ornery Galestrider Ruined Leather Scraps (59.9%) or Light Leather (40.1%). Each gets a
-- table of its own with that, and SkinLootID moves to it only while it is still 118 and no table of its number exists.
--
-- Running it again changes nothing. Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_25_23_world_everlake_galestrider_loot.sql';
START TRANSACTION;

-- the sniff's second rows (the same item already has its QuestieDB row)
DELETE a FROM `creature_loot_template` a
JOIN `creature_loot_template` b ON b.`Entry` = a.`Entry` AND b.`ItemType` = a.`ItemType` AND b.`Item` = a.`Item` AND b.`Comment` LIKE 'QuestieDB%'
WHERE a.`Entry` IN (251661, 251707) AND a.`ItemType` = 0 AND a.`Item` IN (1378, 2656, 3363, 3189) AND a.`Comment` LIKE 'Forever live drop 2026-11-15 %';

-- live rates

UPDATE `creature_loot_template` SET `Chance` = 0.77 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 1364 AND `QuestRequired` = 0 AND ABS(`Chance` - 4.55) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.66 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 1366 AND `QuestRequired` = 0 AND ABS(`Chance` - 3.9) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.64 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 1367 AND `QuestRequired` = 0 AND ABS(`Chance` - 3.85) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.68 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 1368 AND `QuestRequired` = 0 AND ABS(`Chance` - 3.98) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.62 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 1369 AND `QuestRequired` = 0 AND ABS(`Chance` - 3.9) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.74 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 1372 AND `QuestRequired` = 0 AND ABS(`Chance` - 4.13) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.78 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 1374 AND `QuestRequired` = 0 AND ABS(`Chance` - 5.24) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.83 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 1377 AND `QuestRequired` = 0 AND ABS(`Chance` - 4.82) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.75 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 1378 AND `QuestRequired` = 0 AND ABS(`Chance` - 4.39) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.76 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 1380 AND `QuestRequired` = 0 AND ABS(`Chance` - 5.2) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.69 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 2210 AND `QuestRequired` = 0 AND ABS(`Chance` - 4.28) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.49 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 2650 AND `QuestRequired` = 0 AND ABS(`Chance` - 3.33) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.56 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 2652 AND `QuestRequired` = 0 AND ABS(`Chance` - 3.97) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.5 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 2653 AND `QuestRequired` = 0 AND ABS(`Chance` - 3.33) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.52 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 2654 AND `QuestRequired` = 0 AND ABS(`Chance` - 3.37) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.51 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 2656 AND `QuestRequired` = 0 AND ABS(`Chance` - 3.43) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.67 WHERE `Entry` = 251661 AND `ItemType` = 0 AND `Item` = 3363 AND `QuestRequired` = 0 AND ABS(`Chance` - 5.24) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.18 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 767 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.54) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.18 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3189 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.96) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.13 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3190 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.2) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3279 AND `QuestRequired` = 0 AND ABS(`Chance` - 2.88) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.1 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3280 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.8) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3281 AND `QuestRequired` = 0 AND ABS(`Chance` - 2.06) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3284 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.43) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.03 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3285 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.18) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3286 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.31) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.03 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3289 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.8) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.03 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3290 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.6) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.13 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3642 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.1) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3644 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.88) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3649 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.8) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.09 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 4668 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.7) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.05 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 4669 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.05) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.13 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 4671 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.82) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.03 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 4672 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.18) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.11 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 4674 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.2) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.03 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 4675 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.82) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 4692 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.88) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.07 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 8177 AND `QuestRequired` = 0 AND ABS(`Chance` - 2.44) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.08 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 8182 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.1) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.11 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 14087 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.6) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.14 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 14088 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.59) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.03 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 14089 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.18) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.14 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 14093 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.5) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.03 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 14095 AND `QuestRequired` = 0 AND ABS(`Chance` - 4.05) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.04 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 14098 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.93) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.12 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15003 AND `QuestRequired` = 0 AND ABS(`Chance` - 5.28) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.09 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15004 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.52) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.11 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15005 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.84) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.04 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15006 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.49) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.1 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15007 AND `QuestRequired` = 0 AND ABS(`Chance` - 6.01) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15008 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.43) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15297 AND `QuestRequired` = 0 AND ABS(`Chance` - 1) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.05 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15299 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.74) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15302 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.83) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.1 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15472 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.83) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.04 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15473 AND `QuestRequired` = 0 AND ABS(`Chance` - 1.82) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.08 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15474 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.6) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.07 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15475 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.92) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.03 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15476 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.62) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.07 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15478 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.72) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.04 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15482 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.51) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.02 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 15483 AND `QuestRequired` = 0 AND ABS(`Chance` - 0.95) < 0.005;
UPDATE `creature_loot_template` SET `Chance` = 0.01 WHERE `Entry` = 251707 AND `ItemType` = 0 AND `Item` = 3287 AND `QuestRequired` = 0 AND ABS(`Chance` - 3) < 0.005;

-- skinning of their own
SET @EVERLAKE_G1 := (SELECT COUNT(*) = 1 FROM `creature_template_difficulty` WHERE `Entry` = 251661 AND `DifficultyID` = 0 AND `SkinLootID` = 118)
  AND (SELECT COUNT(*) = 0 FROM `skinning_loot_template` WHERE `Entry` = 251661);
SET @EVERLAKE_G2 := (SELECT COUNT(*) = 1 FROM `creature_template_difficulty` WHERE `Entry` = 251707 AND `DifficultyID` = 0 AND `SkinLootID` = 118)
  AND (SELECT COUNT(*) = 0 FROM `skinning_loot_template` WHERE `Entry` = 251707);
INSERT INTO `skinning_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 251661, 0, 2934, 100, 0, 1, 0, 1, 1, 'Galestrider (skinning): Ruined Leather Scraps' FROM DUAL WHERE @EVERLAKE_G1 = 1
UNION ALL SELECT 251707, 0, 2934, 59.87, 0, 1, 1, 1, 1, 'Ornery Galestrider (skinning): Ruined Leather Scraps' FROM DUAL WHERE @EVERLAKE_G2 = 1
UNION ALL SELECT 251707, 0, 2318, 40.13, 0, 1, 1, 1, 1, 'Ornery Galestrider (skinning): Light Leather' FROM DUAL WHERE @EVERLAKE_G2 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'skinning_loot_template', 251661, 0, 2934, 0, @EVERLAKE_FILE, 'Wowhead 100%: 251661 skinned for 2934' FROM DUAL WHERE @EVERLAKE_G1 = 1
UNION ALL SELECT 'skinning_loot_template', 251707, 0, 2934, 0, @EVERLAKE_FILE, 'Wowhead 59.87%: 251707 skinned for 2934' FROM DUAL WHERE @EVERLAKE_G2 = 1
UNION ALL SELECT 'skinning_loot_template', 251707, 0, 2318, 0, @EVERLAKE_FILE, 'Wowhead 40.13%: 251707 skinned for 2318' FROM DUAL WHERE @EVERLAKE_G2 = 1;
UPDATE `creature_template_difficulty` SET `SkinLootID` = 251661 WHERE `Entry` = 251661 AND `DifficultyID` = 0 AND `SkinLootID` = 118 AND @EVERLAKE_G1 = 1;
UPDATE `creature_template_difficulty` SET `SkinLootID` = 251707 WHERE `Entry` = 251707 AND `DifficultyID` = 0 AND `SkinLootID` = 118 AND @EVERLAKE_G2 = 1;

COMMIT;
