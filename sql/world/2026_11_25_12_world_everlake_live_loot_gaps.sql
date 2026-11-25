-- Live drops the test realm's loot tables lack: cloth on humanoids, beast parts, and skinning on four Forever beasts.
-- 2026_11_25_12_world_everlake_live_loot_gaps.sql: written by hand from the tracker's kept facts (2026-11-25).
--
-- A check of the test realm's world (tracker Query page, 2026-11-25) against what players looted on live WoW Forever
-- found mobs whose loot, with every reference table followed, never gives an item live mobs of that name drop at 10% or
-- more. Each row here is one such pair that a public source records for the same creature entry: Wowhead's WoW Forever
-- database (https://www.wowhead.com/forever/) where it has the pair, else EG Link's recordings, else Icy Veins' WoW
-- Forever database (https://db.icy-veins.com/wow-forever/); the chance is that source's (the mean where it lists the
-- pair twice). Only spawned entries are touched. Rows go into the creature's own loot id.
--
-- Skinning: Plains Coyote (259267), Wildplains Huntress (259055), Mature Paletusk (255851) and Defiling Hound
-- (249230) are skinnable on live (Wowhead's "Skinned from" lists) but have no skinning loot here (SkinLootID 0). Each
-- gets a skinning table of its own entry with the items Wowhead lists, and SkinLootID set to it while it is still 0 and
-- no skinning table of that number exists.
--
-- Left out: Bristleback Battleboar (2954, Ruined Leather Scraps by skinning: its skinning table 100007 is shared by 22
-- creatures), Twilight Brute (261208, no loot id), Noxious Slime (12221) and Blind Screecher (255174, not spawned).
--
-- Every row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file.
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added (docs/forever-import.md)';

SET @EVERLAKE_FILE := '2026_11_25_12_world_everlake_live_loot_gaps.sql';
START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_live_loot`;
CREATE TEMPORARY TABLE `everlake_live_loot` (`entry` int unsigned NOT NULL, `item` int unsigned NOT NULL, `chance` float NOT NULL, `comment` varchar(100) NOT NULL, `note` varchar(255) NOT NULL, `lid` int unsigned NOT NULL DEFAULT 0, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`, `item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_live_loot` (`entry`, `item`, `chance`, `comment`, `note`) VALUES
(1919, 2589, 25.59, 'Samuel Fipps: Linen Cloth', 'Icy Veins: 1919 drops 2589 at 25.59%'),
(1506, 2589, 27.04, 'Scarlet Convert: Linen Cloth', 'Icy Veins: 1506 drops 2589 at 27.04%'),
(1917, 2589, 29.33, 'Daniel Ulfman: Linen Cloth', 'Icy Veins: 1917 drops 2589 at 29.33%'),
(1916, 2589, 27.39, 'Stephen Bhartec: Linen Cloth', 'Icy Veins: 1916 drops 2589 at 27.39%'),
(1918, 2589, 27.21, 'Karrel Grayves: Linen Cloth', 'Icy Veins: 1918 drops 2589 at 27.21%'),
(1890, 2589, 29.11, 'Rattlecage Skeleton: Linen Cloth', 'Icy Veins: 1890 drops 2589 at 29.11%'),
(2952, 2589, 27.67, 'Bristleback Quilboar: Linen Cloth', 'Icy Veins: 2952 drops 2589 at 27.67%'),
(1507, 2589, 27.63, 'Scarlet Initiate: Linen Cloth', 'Icy Veins: 1507 drops 2589 at 27.63%'),
(3183, 2589, 23.64, 'Yarrog Baneshadow: Linen Cloth', 'Icy Veins: 3183 drops 2589 at 23.64%'),
(2953, 2589, 27.59, 'Bristleback Shaman: Linen Cloth', 'Icy Veins: 2953 drops 2589 at 27.59%'),
(1988, 2589, 28.41, 'Grell: Linen Cloth', 'Icy Veins: 1988 drops 2589 at 28.41%'),
(276020, 2589, 15.93, 'Riptear: Linen Cloth', 'Icy Veins: 276020 drops 2589 at 15.93%'),
(275663, 2589, 28.05, 'Spitelash Attendant: Linen Cloth', 'Icy Veins: 275663 drops 2589 at 28.05%'),
(257910, 4306, 8.33, 'Eastsea Musketeer: Silk Cloth', 'Icy Veins: 257910 drops 4306 at 8.33%'),
(257910, 4338, 24.74, 'Eastsea Musketeer: Mageweave Cloth', 'Icy Veins: 257910 drops 4338 at 24.74%'),
(255774, 4306, 28.68, 'Redridge Scout: Silk Cloth', 'Icy Veins: 255774 drops 4306 at 28.68%'),
(270667, 4306, 30.10, 'Farholde Priest: Silk Cloth', 'Icy Veins: 270667 drops 4306 at 30.10%'),
(256433, 4306, 28.94, 'Woodworker: Silk Cloth', 'Icy Veins + Wowhead: 256433 drops 4306 at 28.94%'),
(257901, 4338, 24.51, 'Eastsea Buccaneer: Mageweave Cloth', 'Icy Veins: 257901 drops 4338 at 24.51%'),
(257915, 4338, 24.39, 'Eastsea Raider: Mageweave Cloth', 'Icy Veins: 257915 drops 4338 at 24.39%'),
(256795, 4338, 24.96, 'Twilight Fanatic: Mageweave Cloth', 'Icy Veins: 256795 drops 4338 at 24.96%'),
(256799, 4338, 22.08, 'Twilight Champion: Mageweave Cloth', 'Icy Veins: 256799 drops 4338 at 22.08%'),
(256797, 4338, 25.36, 'Twilight Corrupter: Mageweave Cloth', 'Icy Veins: 256797 drops 4338 at 25.36%'),
(255851, 2295, 19.71, 'Mature Paletusk: Large Boar Tusk', 'Icy Veins + EG Link: 255851 drops 2295 at 19.71%'),
(255851, 3403, 31.75, 'Mature Paletusk: Ivory Boar Tusk', 'Icy Veins + Wowhead + EG Link: 255851 drops 3403 at 31.75%'),
(263348, 5829, 17.73, 'Roving Tallstrider: Razor-sharp Beak', 'Icy Veins: 263348 drops 5829 at 17.73%'),
(259055, 1688, 39.06, 'Wildplains Huntress: Long Soft Tail', 'Icy Veins: 259055 drops 1688 at 39.06%'),
(259267, 4582, 25.07, 'Plains Coyote: Soft Bushy Tail', 'Icy Veins: 259267 drops 4582 at 25.07%'),
(259267, 4583, 13.04, 'Plains Coyote: Thick Furry Mane', 'Icy Veins: 259267 drops 4583 at 13.04%'),
(259267, 12203, 47.25, 'Plains Coyote: Red Wolf Meat', 'Icy Veins: 259267 drops 12203 at 47.25%'),
(252063, 14047, 25.64, 'Deadwood Den Guardian: Runecloth', 'Icy Veins: 252063 drops 14047 at 25.64%'),
(252116, 14047, 36.00, 'Deadwood Totemic: Runecloth', 'Icy Veins: 252116 drops 14047 at 36.00%'),
(252096, 14047, 25.53, 'Deadwood Fel-Tender: Runecloth', 'Icy Veins: 252096 drops 14047 at 25.53%'),
(249228, 6530, 17.83, 'Fleshflay Ravener: Nightcrawlers', 'Icy Veins + Wowhead: 249228 drops 6530 at 17.83%'),
(249228, 14047, 29.55, 'Fleshflay Ravener: Runecloth', 'Icy Veins: 249228 drops 14047 at 29.55%'),
(249229, 14047, 15.79, 'Felguard Sentinel: Runecloth', 'Icy Veins: 249229 drops 14047 at 15.79%'),
(249551, 14047, 29.59, 'Blackthorne Cultist: Runecloth', 'Icy Veins: 249551 drops 14047 at 29.59%'),
(260422, 14047, 31.42, 'Ashen Acolyte: Runecloth', 'Icy Veins: 260422 drops 14047 at 31.42%'),
(272389, 5829, 10.53, 'Marsh Owl: Razor-sharp Beak', 'Icy Veins: 272389 drops 5829 at 10.53%'),
(272389, 11416, 12.44, 'Marsh Owl: Delicate Ribcage', 'Icy Veins: 272389 drops 11416 at 12.44%'),
(272389, 17056, 38.53, 'Marsh Owl: Light Feather', 'Icy Veins: 272389 drops 17056 at 38.53%'),
(264081, 3931, 22.24, 'Gloomrise Spinner: Poisoned Spider Fang', 'Icy Veins + Wowhead: 264081 drops 3931 at 22.24%'),
(255898, 5524, 34.86, 'Murloc Oracle: Thick-shelled Clam', 'Icy Veins: 255898 drops 5524 at 34.86%'),
(256801, 5524, 34.32, 'Murloc Warrior: Thick-shelled Clam', 'Icy Veins: 256801 drops 5524 at 34.32%'),
(268831, 4582, 25.00, 'Plains Prowler: Soft Bushy Tail', 'Icy Veins: 268831 drops 4582 at 25.00%'),
(268831, 12203, 47.99, 'Plains Prowler: Red Wolf Meat', 'Icy Veins: 268831 drops 12203 at 47.99%'),
(263307, 6444, 28.81, 'Glade Viper: Forked Tongue', 'Icy Veins: 263307 drops 6444 at 28.81%'),
(263307, 6826, 43.56, 'Glade Viper: Brilliant Scale', 'Icy Veins: 263307 drops 6826 at 43.56%'),
(249230, 4583, 27.45, 'Defiling Hound: Thick Furry Mane', 'Icy Veins: 249230 drops 4583 at 27.45%'),
(249230, 4584, 10.32, 'Defiling Hound: Large Trophy Paw', 'Icy Veins: 249230 drops 4584 at 10.32%'),
(7446, 3730, 21.67, 'Rabid Shardtooth: Big Bear Meat', 'Wowhead: 7446 drops 3730 at 21.67%'),
(249053, 11420, 7.55, 'Hyjal Owl: Elegant Writing Tool', 'Icy Veins + Wowhead: 249053 drops 11420 at 7.55%'),
(249053, 12207, 42.01, 'Hyjal Owl: Giant Egg', 'Icy Veins + Wowhead: 249053 drops 12207 at 42.01%'),
(249053, 15420, 59.19, 'Hyjal Owl: Ironfeather', 'Icy Veins + Wowhead: 249053 drops 15420 at 59.19%'),
(259054, 1688, 40.60, 'Wildplains Patriarch: Long Soft Tail', 'Icy Veins: 259054 drops 1688 at 40.60%'),
(249237, 6530, 23.19, 'Eternal Sentry: Nightcrawlers', 'Icy Veins: 249237 drops 6530 at 23.19%'),
(249237, 8766, 4.35, 'Eternal Sentry: Morning Glory Dew', 'Icy Veins: 249237 drops 8766 at 4.35%'),
(249237, 8948, 5.26, 'Eternal Sentry: Dried King Bolete', 'Icy Veins: 249237 drops 8948 at 5.26%');
-- the creature's own loot id, while the creature stands somewhere and its table lacks the item
UPDATE `everlake_live_loot` s SET s.`lid` = COALESCE((SELECT d.`LootID` FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`DifficultyID` = 0 AND d.`LootID` > 0), 0);
UPDATE `everlake_live_loot` s SET s.`missing` = 1 WHERE s.`lid` > 0
  AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = s.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l WHERE l.`Entry` = s.`lid` AND l.`ItemType` = 0 AND l.`Item` = s.`item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template' AND r.`k1` = s.`lid` AND r.`k2` = 0 AND r.`k3` = s.`item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`lid`, 0, s.`item`, s.`chance`, 0, 1, 0, 1, 1, s.`comment` FROM `everlake_live_loot` s WHERE s.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', s.`lid`, 0, s.`item`, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_live_loot` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_live_loot`;

-- skinning
DROP TEMPORARY TABLE IF EXISTS `everlake_live_skin`;
CREATE TEMPORARY TABLE `everlake_live_skin` (`entry` int unsigned NOT NULL, `item` int unsigned NOT NULL, `chance` float NOT NULL, `comment` varchar(100) NOT NULL, `note` varchar(255) NOT NULL, `ok` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`, `item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_live_skin` (`entry`, `item`, `chance`, `comment`, `note`) VALUES
(259267, 4304, 50.68, 'Plains Coyote (skinning): Thick Leather', 'Icy Veins + Wowhead: 259267 drops 4304 at 50.68%'),
(259267, 4234, 37.81, 'Plains Coyote (skinning): Heavy Leather', 'Icy Veins + Wowhead: 259267 drops 4234 at 37.81%'),
(259267, 4235, 4.31, 'Plains Coyote (skinning): Heavy Hide', 'Icy Veins + Wowhead: 259267 drops 4235 at 4.31%'),
(259267, 8169, 4.13, 'Plains Coyote (skinning): Thick Hide', 'Icy Veins + Wowhead: 259267 drops 8169 at 4.13%'),
(259267, 8368, 1.91, 'Plains Coyote (skinning): Thick Wolfhide', 'Icy Veins + Wowhead: 259267 drops 8368 at 1.91%'),
(259267, 249428, 1.17, 'Plains Coyote (skinning): Pristine Hide', 'Icy Veins + Wowhead: 259267 drops 249428 at 1.17%'),
(259055, 4234, 75.84, 'Wildplains Huntress (skinning): Heavy Leather', 'Icy Veins + Wowhead: 259055 drops 4234 at 75.84%'),
(259055, 4304, 19.58, 'Wildplains Huntress (skinning): Thick Leather', 'Icy Veins + Wowhead: 259055 drops 4304 at 19.58%'),
(259055, 4235, 3.33, 'Wildplains Huntress (skinning): Heavy Hide', 'Icy Veins + Wowhead: 259055 drops 4235 at 3.33%'),
(259055, 249428, 1.27, 'Wildplains Huntress (skinning): Pristine Hide', 'Icy Veins + Wowhead: 259055 drops 249428 at 1.27%'),
(255851, 4234, 75.50, 'Mature Paletusk (skinning): Heavy Leather', 'Icy Veins + Wowhead: 255851 drops 4234 at 75.50%'),
(255851, 4304, 20.32, 'Mature Paletusk (skinning): Thick Leather', 'Icy Veins + Wowhead: 255851 drops 4304 at 20.32%'),
(255851, 4235, 2.94, 'Mature Paletusk (skinning): Heavy Hide', 'Icy Veins + Wowhead: 255851 drops 4235 at 2.94%'),
(255851, 249428, 1.26, 'Mature Paletusk (skinning): Pristine Hide', 'Icy Veins + Wowhead: 255851 drops 249428 at 1.26%'),
(249230, 8170, 80.52, 'Defiling Hound (skinning): Rugged Leather', 'Icy Veins + Wowhead: 249230 drops 8170 at 80.52%'),
(249230, 4304, 11.99, 'Defiling Hound (skinning): Thick Leather', 'Icy Veins + Wowhead: 249230 drops 4304 at 11.99%'),
(249230, 8171, 5.44, 'Defiling Hound (skinning): Rugged Hide', 'Icy Veins + Wowhead: 249230 drops 8171 at 5.44%'),
(249230, 249428, 2.40, 'Defiling Hound (skinning): Pristine Hide', 'Icy Veins + Wowhead: 249230 drops 249428 at 2.40%');
-- a creature that stands somewhere, whose SkinLootID is still 0 and whose entry is no skinning table yet
UPDATE `everlake_live_skin` s SET s.`ok` = 1
WHERE EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = s.`entry`)
  AND EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`DifficultyID` = 0 AND d.`SkinLootID` = 0)
  AND NOT EXISTS (SELECT 1 FROM `skinning_loot_template` k WHERE k.`Entry` = s.`entry`);
INSERT INTO `skinning_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`entry`, 0, s.`item`, s.`chance`, 0, 1, 0, 1, 1, s.`comment` FROM `everlake_live_skin` s WHERE s.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'skinning_loot_template', s.`entry`, 0, s.`item`, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_live_skin` s WHERE s.`ok` = 1;
-- point the creature at its new table
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT DISTINCT 'creature_template_difficulty', s.`entry`, 0, 0, 0, @EVERLAKE_FILE, 'SkinLootID 0 -> own entry: Wowhead lists it as skinned on live'
FROM `everlake_live_skin` s WHERE s.`ok` = 1;
UPDATE `creature_template_difficulty` d SET d.`SkinLootID` = d.`Entry`
WHERE d.`DifficultyID` = 0 AND d.`SkinLootID` = 0 AND d.`Entry` IN (SELECT DISTINCT s.`entry` FROM `everlake_live_skin` s WHERE s.`ok` = 1);
DROP TEMPORARY TABLE `everlake_live_skin`;

COMMIT;
