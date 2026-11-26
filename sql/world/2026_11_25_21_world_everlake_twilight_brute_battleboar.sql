-- Twilight Brute (261710): spawned, with loot; Bristleback Battleboar (2954): its own skinning.
-- 2026_11_25_21_world_everlake_twilight_brute_battleboar.sql: written by hand from the tracker's kept facts (2026-11-25).
--
-- Twilight Brute: two creatures share the name. 261208 (level 36-37) is the one players talk to, and it stands on the
-- realm. 261710 (level 39-40) is the hostile one players kill on live (Icy Veins' WoW Forever database,
-- https://db.icy-veins.com/wow-forever/: 24 places it was looted; EG Link: 16 world positions), and the realm neither
-- spawns it nor gives it loot (LootID 0). Spawns: EG Link's world positions, those within 10 yards merged (11),
-- heights from the realm's maps and vmaps (tools/height.py: terrain, where the camp's other mobs stand at 24-29),
-- wandering 5 yards, respawn 300 s like the camp's Empowered Brutes. Loot: the Empowered Brute's table (261711) beside it,
-- whose drops match what Icy Veins records for 261710 (Silk Cloth 28 vs 31%, Mageweave 5 vs 5%, the same grey items at
-- 2-4%). LootID changes only while it is 0.
--
-- Bristleback Battleboar: its skinning table is 100007, a VMaNGOS table shared with riding mounts and pets (Light
-- Leather, Light Hide). Wowhead's WoW Forever database (100%, through the ForeverTracker's page cache) and Icy Veins (99.8%)
-- record Ruined Leather Scraps from skinning it on live. It gets a skinning table of its own (2954) with that item, and
-- SkinLootID moves to it only while it is still 100007 and no table 2954 exists. 100007 is left for the others.
--
-- Own guid block 920019200-920019210. Every added row is recorded in everlake_import_rows. Never edit this file once it is
-- deployed: a later fix is a new file. Running it again changes nothing. Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_25_21_world_everlake_twilight_brute_battleboar.sql';
START TRANSACTION;

-- Twilight Brute: loot
UPDATE `creature_template_difficulty` SET `LootID` = 261711
WHERE `Entry` = 261710 AND `DifficultyID` = 0 AND `LootID` = 0 AND EXISTS (SELECT 1 FROM `creature_loot_template` l WHERE l.`Entry` = 261711);

-- Twilight Brute: spawns (own block: put back as written)
DELETE FROM `creature` WHERE `guid` BETWEEN 920019200 AND 920019210;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnDifficulties`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`MovementType`,`VerifiedBuild`) VALUES
(920019200,261710,0,'0',-8064.1,-4240.1,25.41,0,300,5,1,0),
(920019201,261710,0,'0',-8056.9,-4303.5,28.81,0,300,5,1,0),
(920019202,261710,0,'0',-7986.23,-4309.97,25.95,0,300,5,1,0),
(920019203,261710,0,'0',-7982.7,-4263.7,25.49,0,300,5,1,0),
(920019204,261710,0,'0',-8085.5,-4231.25,24.25,0,300,5,1,0),
(920019205,261710,0,'0',-8053.1,-4331.5,35.51,0,300,5,1,0),
(920019206,261710,0,'0',-8019.45,-4305.7,29.95,0,300,5,1,0),
(920019207,261710,0,'0',-7984.5,-4281.2,24.55,0,300,5,1,0),
(920019208,261710,0,'0',-8073.5,-4234.4,24.36,0,300,5,1,0),
(920019209,261710,0,'0',-7999.5,-4273.2,25.24,0,300,5,1,0),
(920019210,261710,0,'0',-7983.4,-4251.2,24.25,0,300,5,1,0);

-- Bristleback Battleboar: own skinning table
SET @EVERLAKE_BB := (SELECT COUNT(*) = 1 FROM `creature_template_difficulty` WHERE `Entry` = 2954 AND `DifficultyID` = 0 AND `SkinLootID` = 100007)
  AND (SELECT COUNT(*) = 0 FROM `skinning_loot_template` WHERE `Entry` = 2954);
INSERT INTO `skinning_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 2954, 0, 2934, 100, 0, 1, 0, 1, 1, 'Bristleback Battleboar (skinning): Ruined Leather Scraps' FROM DUAL WHERE @EVERLAKE_BB = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'skinning_loot_template', 2954, 0, 2934, 0, @EVERLAKE_FILE, 'Wowhead 100% + Icy Veins 99.8%: 2954 skinned for 2934' FROM DUAL WHERE @EVERLAKE_BB = 1;
UPDATE `creature_template_difficulty` SET `SkinLootID` = 2954 WHERE `Entry` = 2954 AND `DifficultyID` = 0 AND `SkinLootID` = 100007 AND @EVERLAKE_BB = 1;

COMMIT;
