-- Three live WoW Forever rares the test realm has templates for but never spawned (2026-11-25).
-- 2026_11_25_28_world_everlake_rare_spawns.sql: written by hand from the tracker's kept facts (2026-11-25).
--
--   Old Rusthowl (263935, rare elite wolf, Forever zone 616 / UiMap 2482): drops Rusthowl's Worn Collar (281598, QuestieDB),
--     which its loot table lacked. 4 spots from Wowhead Forever's 5 map pins and Icy Veins' 2 loot points. Level 58
--     (Icy Veins), the template had none.
--   Soul of Tanaris (8206, rare elite, Tanaris): its table already has Winds of Tanaris (286556, Wowhead 23%). 13 spots
--     from Wowhead Forever's 12 map pins and Icy Veins' loot point.
--   Duke Ragereaver (10820, rare elite, Eastern Plaguelands): drops Blade of Senseless Slaughter (284101, QuestieDB),
--     which its loot table lacked. 4 spots from Icy Veins' 6 sightings (builds 70959-71037). Level 60 as
--     Icy Veins and Wowhead Forever give (the realm had 45).
--
-- New drops at 35%, the rate the realm owner chose for new Forever items on rares (2026_11_25_26); no source has a
-- kill sample for these two. Map points are turned into world positions with the client's UiMapAssignment rectangles,
-- as the tracker's locator does, and points within 20 yards are one spot. Heights from the server's maps and vmaps
-- (tools/height.py), terrain everywhere (Duke Ragereaver's spot beside a ruin on the ground, not on its walls).
-- Each rare is one pool, one up at a time, 5 h respawn and a 5-yard wander, as Baron Bloodbane (2026_11_24_01).
-- Wowhead's Classic-branch pins are not used, only its Forever ones.
--
-- Own guid block 920019400-920019420, pools 920000202-920000204. Loot and level rows are recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.
-- Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_25_28_world_everlake_rare_spawns.sql';
START TRANSACTION;

-- levels: Duke Ragereaver only while it still holds the old 45; Old Rusthowl where it has none
UPDATE `creature_classic_level` SET `level_min` = 60, `level_max` = 60 WHERE `entry` = 10820 AND `level_min` = 45 AND `level_max` = 45;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 263935, 58, 58 FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 263935);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 263935, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins (live WoW Forever): level 58'
FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 263935 AND `level_min` = 58);

-- the new drops, in each rare's own loot table, where missing
DROP TEMPORARY TABLE IF EXISTS `everlake_rare_drops`;
CREATE TEMPORARY TABLE `everlake_rare_drops` (`entry` int unsigned NOT NULL, `item` int unsigned NOT NULL, `chance` float NOT NULL, `comment` varchar(100) NOT NULL, `note` varchar(255) NOT NULL, `lid` int unsigned NOT NULL DEFAULT 0, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`, `item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_rare_drops` (`entry`, `item`, `chance`, `comment`, `note`) VALUES
(263935, 281598, 35, 'Old Rusthowl: Rusthowl''s Worn Collar', 'QuestieDB (live WoW Forever): 263935 drops 281598; rate 35% as 2026_11_25_26'),
(10820, 284101, 35, 'Duke Ragereaver: Blade of Senseless Slaughter', 'QuestieDB (live WoW Forever): 10820 drops 284101; rate 35% as 2026_11_25_26');
UPDATE `everlake_rare_drops` s SET s.`lid` = COALESCE((SELECT d.`LootID` FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`DifficultyID` = 0 AND d.`LootID` > 0), 0);
UPDATE `everlake_rare_drops` s SET s.`missing` = 1 WHERE s.`lid` > 0
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l WHERE l.`Entry` = s.`lid` AND l.`ItemType` = 0 AND l.`Item` = s.`item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template' AND r.`k1` = s.`lid` AND r.`k2` = 0 AND r.`k3` = s.`item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`lid`, 0, s.`item`, s.`chance`, 0, 1, 0, 1, 1, s.`comment` FROM `everlake_rare_drops` s WHERE s.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', s.`lid`, 0, s.`item`, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_rare_drops` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_rare_drops`;

-- spawns and pools (own block: put back as written)
DELETE FROM `pool_members` WHERE `type` = 0 AND `spawnId` BETWEEN 920019400 AND 920019420;
DELETE FROM `pool_template` WHERE `entry` BETWEEN 920000202 AND 920000204;
DELETE FROM `creature` WHERE `guid` BETWEEN 920019400 AND 920019420;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnDifficulties`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`MovementType`,`VerifiedBuild`) VALUES
(920019400,263935,1,'0',4651.55,-2749.67,1169.43,0,18000,5,1,0),
(920019401,263935,1,'0',4724.31,-2800.84,1237.77,0,18000,5,1,0),
(920019402,263935,1,'0',4741.83,-2819.13,1237.21,0,18000,5,1,0),
(920019403,263935,1,'0',4738.81,-2796.21,1239.19,0,18000,5,1,0),
(920019404,8206,1,'0',-7475.8,-3668.75,12.14,0,18000,5,1,0),
(920019405,8206,1,'0',-7273.4,-3710.15,9.4,0,18000,5,1,0),
(920019406,8206,1,'0',-8046.2,-3710.15,50.77,0,18000,5,1,0),
(920019407,8206,1,'0',-7742.6,-3737.75,32.84,0,18000,5,1,0),
(920019408,8206,1,'0',-7917.4,-3848.15,27.4,0,18000,5,1,0),
(920019409,8206,1,'0',-7972.6,-3875.75,13.57,0,18000,5,1,0),
(920019410,8206,1,'0',-8055.4,-3889.55,15.51,0,18000,5,1,0),
(920019411,8206,1,'0',-8092.2,-3930.95,9.04,0,18000,5,1,0),
(920019412,8206,1,'0',-8018.6,-3958.55,10.09,0,18000,5,1,0),
(920019413,8206,1,'0',-7761.0,-4013.75,10.13,0,18000,5,1,0),
(920019414,8206,1,'0',-7963.4,-4055.15,9.35,0,18000,5,1,0),
(920019415,8206,1,'0',-7742.6,-4068.95,9.45,0,18000,5,1,0),
(920019416,8206,1,'0',-7898.54,-4208.33,13.91,0,18000,5,1,0),
(920019417,10820,0,'0',3184.27,-3681.96,135.71,0,18000,5,1,0),
(920019418,10820,0,'0',3153.02,-3730.57,133.14,0,18000,5,1,0),
(920019419,10820,0,'0',3125.93,-3739.82,133.1,0,18000,5,1,0),
(920019420,10820,0,'0',3176.39,-3759.18,134.69,0,18000,5,1,0);

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(920000202, 1, 'Old Rusthowl (263935), Forever zone 616 (UiMap 2482): one of 4 spots'),
(920000203, 1, 'Soul of Tanaris (8206), Tanaris: one of 13 spots'),
(920000204, 1, 'Duke Ragereaver (10820), Eastern Plaguelands: one of 4 spots');
INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`) VALUES
(0, 920019400, 920000202, 0, 'Old Rusthowl, spot 1'),
(0, 920019401, 920000202, 0, 'Old Rusthowl, spot 2'),
(0, 920019402, 920000202, 0, 'Old Rusthowl, spot 3'),
(0, 920019403, 920000202, 0, 'Old Rusthowl, spot 4'),
(0, 920019404, 920000203, 0, 'Soul of Tanaris, spot 1'),
(0, 920019405, 920000203, 0, 'Soul of Tanaris, spot 2'),
(0, 920019406, 920000203, 0, 'Soul of Tanaris, spot 3'),
(0, 920019407, 920000203, 0, 'Soul of Tanaris, spot 4'),
(0, 920019408, 920000203, 0, 'Soul of Tanaris, spot 5'),
(0, 920019409, 920000203, 0, 'Soul of Tanaris, spot 6'),
(0, 920019410, 920000203, 0, 'Soul of Tanaris, spot 7'),
(0, 920019411, 920000203, 0, 'Soul of Tanaris, spot 8'),
(0, 920019412, 920000203, 0, 'Soul of Tanaris, spot 9'),
(0, 920019413, 920000203, 0, 'Soul of Tanaris, spot 10'),
(0, 920019414, 920000203, 0, 'Soul of Tanaris, spot 11'),
(0, 920019415, 920000203, 0, 'Soul of Tanaris, spot 12'),
(0, 920019416, 920000203, 0, 'Soul of Tanaris, spot 13'),
(0, 920019417, 920000204, 0, 'Duke Ragereaver, spot 1'),
(0, 920019418, 920000204, 0, 'Duke Ragereaver, spot 2'),
(0, 920019419, 920000204, 0, 'Duke Ragereaver, spot 3'),
(0, 920019420, 920000204, 0, 'Duke Ragereaver, spot 4');

COMMIT;
