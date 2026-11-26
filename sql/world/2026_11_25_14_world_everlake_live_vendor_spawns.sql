-- Live Forever vendors and creatures the test realm has templates for but never spawned, found by a check against
-- players' recordings of live WoW Forever (2026-11-25).
-- 2026_11_25_14_world_everlake_live_vendor_spawns.sql: written by hand from the tracker's kept facts (2026-11-25).
--
--   Maralus (255701), Trade Goods, in the Shen'dralar town (Forever zone 16651, UiMap 2652). Template had faction 16
--     (hostile) and no vendor flag: now faction 35 and vendor, like the town's other folk (Vindael 254717).
--   The Redridge crafting camp's four supply crates (256738 Basket of Alchemy Goods, 256739 Crate of Blacksmithing
--     Goods, 256740 Crate of Enchanting Supplies, 256741 Basket of Textile Supplies): stand-in templates (faction 7, no
--     vendor flag). They now copy the Horde camp's crates in the Barrens (256570-256575: npcflag, unit flags 768) with
--     the Redridge camp's faction 35.
--   The Horde camp's three crates (256570 alchemy, 256571 blacksmithing, 256573 enchanting) stood with a vendor flag and
--     nothing to sell: they get their lists. Their textile basket (256575) already had its 19 items.
--   Blind Screecher (255174), level 41-42 bats of the Shen'dralar hills: 26 spawns.
--
-- Where: Icy Veins' WoW Forever database (https://db.icy-veins.com/wow-forever/) records where players stood to talk to
-- each vendor and where they looted each Blind Screecher, in thousandths of the zone map; Wowhead's map pins agree for
-- Maralus. The map points are turned into world positions with the client's UiMapAssignment rectangles (wago.tools),
-- as the tracker's locator does: for the Horde crates that stand on the realm, their recorded points land 1 to 2.4 yards
-- from the real spawns. Blind Screecher: loot points within 20 yards are one spawn, and only spots more than one corpse
-- was looted at are kept (26 of 51). Heights from the server's maps and vmaps (tools/height.py): terrain,
-- except Maralus, who stands on the town's lower floor (151.33, the floor Historian Biraxas stands on 56 yards south).
-- What each sells: Icy Veins, with Wowhead, ForeverDB.net (GPL-3.0) and Forever Changes where they list the vendor too.
--
-- Own guid block 920019000-920019030. Templates change only while they still hold the stand-in values; vendor rows go in
-- only where missing. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing. Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_25_14_world_everlake_live_vendor_spawns.sql';
START TRANSACTION;

-- templates
UPDATE `creature_template` SET `faction` = 35, `npcflag` = 128 WHERE `entry` = 255701 AND `faction` = 16 AND `npcflag` = 0;
UPDATE `creature_template` SET `faction` = 35, `npcflag` = 36028797018964096, `unit_flags` = 768
WHERE `entry` IN (256738, 256739, 256740, 256741) AND `faction` = 7 AND `npcflag` = 0 AND `unit_flags` = 0;

-- spawns (own block: put back as written)
DELETE FROM `creature` WHERE `guid` BETWEEN 920019000 AND 920019030;
INSERT INTO `creature` (`guid`,`id`,`map`,`spawnDifficulties`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`MovementType`,`VerifiedBuild`) VALUES
(920019000,255701,1,'0',-2975.98,1144.53,151.33,1.769,300,0,0,0),
(920019001,256738,0,'0',-9623.29,-1916.57,60.55,2.136,300,0,0,0),
(920019002,256739,0,'0',-9659.34,-1905.71,56.45,6.273,300,0,0,0),
(920019003,256740,0,'0',-9612.72,-1923.08,62.20,2.362,300,0,0,0),
(920019004,256741,0,'0',-9632.27,-1899.85,58.51,5.066,300,0,0,0),
(920019005,255174,1,'0',-2529.97,1310.37,152.81,0.000,300,5,1,0),
(920019006,255174,1,'0',-2581.56,1227.45,97.04,0.000,300,5,1,0),
(920019007,255174,1,'0',-2547.98,1182.31,107.39,0.000,300,5,1,0),
(920019008,255174,1,'0',-2568.16,1164.31,96.44,0.000,300,5,1,0),
(920019009,255174,1,'0',-2611.42,1169.74,87.71,0.000,300,5,1,0),
(920019010,255174,1,'0',-2606.8,1146.03,88.24,0.000,300,5,1,0),
(920019011,255174,1,'0',-2543.29,1129.28,111.82,0.000,300,5,1,0),
(920019012,255174,1,'0',-2622.89,1130.99,89.77,0.000,300,5,1,0),
(920019013,255174,1,'0',-2649.51,1100.45,96.21,0.000,300,5,1,0),
(920019014,255174,1,'0',-2624.29,1102.16,96.18,0.000,300,5,1,0),
(920019015,255174,1,'0',-2566.32,1102.09,109.28,0.000,300,5,1,0),
(920019016,255174,1,'0',-2667.29,1079.61,96.75,0.000,300,5,1,0),
(920019017,255174,1,'0',-2549.64,1068.73,117.84,0.000,300,5,1,0),
(920019018,255174,1,'0',-2647.84,1064.85,98.26,0.000,300,5,1,0),
(920019019,255174,1,'0',-2694.34,1061.09,95.28,0.000,300,5,1,0),
(920019020,255174,1,'0',-2733.8,1061.57,101.63,0.000,300,5,1,0),
(920019021,255174,1,'0',-2762.43,1061.3,116.45,0.000,300,5,1,0),
(920019022,255174,1,'0',-2682.14,1008.3,87.92,0.000,300,5,1,0),
(920019023,255174,1,'0',-2722.09,1000.75,95.44,0.000,300,5,1,0),
(920019024,255174,1,'0',-2625.84,999.38,99.49,0.000,300,5,1,0),
(920019025,255174,1,'0',-2657.27,988.32,89.07,0.000,300,5,1,0),
(920019026,255174,1,'0',-2679.69,972.53,84.42,0.000,300,5,1,0),
(920019027,255174,1,'0',-2636.63,962.69,91.91,0.000,300,5,1,0),
(920019028,255174,1,'0',-2612.38,966.89,104.67,0.000,300,5,1,0),
(920019029,255174,1,'0',-2609.85,934.67,96.37,0.000,300,5,1,0),
(920019030,255174,1,'0',-2721.43,910.92,82.13,0.000,300,5,1,0);

-- what each sells, where the vendor has no row for the item yet
DROP TEMPORARY TABLE IF EXISTS `everlake_live_vendor`;
CREATE TEMPORARY TABLE `everlake_live_vendor` (`entry` int unsigned NOT NULL, `slot` smallint NOT NULL, `item` int NOT NULL,
  `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`, `item`))
  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_live_vendor` (`entry`, `slot`, `item`, `note`) VALUES
(255701, 1, 2320, 'Icy Veins: 255701 sells 2320'),
(255701, 2, 2678, 'Icy Veins: 255701 sells 2678'),
(255701, 3, 2901, 'Icy Veins: 255701 sells 2901'),
(255701, 4, 7005, 'Icy Veins: 255701 sells 7005'),
(255701, 5, 2928, 'Icy Veins: 255701 sells 2928'),
(255701, 6, 3371, 'Icy Veins: 255701 sells 3371'),
(255701, 7, 6256, 'Icy Veins: 255701 sells 6256'),
(255701, 8, 2692, 'Icy Veins: 255701 sells 2692'),
(255701, 9, 2604, 'Icy Veins: 255701 sells 2604'),
(255701, 10, 4289, 'Icy Veins: 255701 sells 4289'),
(255701, 11, 2321, 'Icy Veins: 255701 sells 2321'),
(255701, 12, 2880, 'Icy Veins: 255701 sells 2880'),
(255701, 13, 6530, 'Icy Veins: 255701 sells 6530'),
(255701, 14, 6217, 'Icy Veins: 255701 sells 6217'),
(255701, 15, 3713, 'Icy Veins: 255701 sells 3713'),
(255701, 16, 3372, 'Icy Veins: 255701 sells 3372'),
(255701, 17, 4399, 'Icy Veins: 255701 sells 4399'),
(255701, 18, 6532, 'Icy Veins: 255701 sells 6532'),
(255701, 19, 4340, 'Icy Veins: 255701 sells 4340'),
(255701, 20, 3857, 'Icy Veins: 255701 sells 3857'),
(255701, 21, 4291, 'Icy Veins: 255701 sells 4291'),
(255701, 22, 4341, 'Icy Veins: 255701 sells 4341'),
(255701, 23, 2325, 'Icy Veins: 255701 sells 2325'),
(255701, 24, 3466, 'Icy Veins: 255701 sells 3466'),
(255701, 25, 4400, 'Icy Veins: 255701 sells 4400'),
(255701, 26, 8343, 'Icy Veins: 255701 sells 8343'),
(255701, 27, 4342, 'Icy Veins: 255701 sells 4342'),
(255701, 28, 8925, 'Icy Veins: 255701 sells 8925'),
(256570, 1, 3371, 'Icy Veins: 256570 sells 3371'),
(256570, 2, 3372, 'Icy Veins: 256570 sells 3372'),
(256570, 3, 8925, 'Icy Veins: 256570 sells 8925'),
(256570, 4, 18256, 'Icy Veins: 256570 sells 18256'),
(256571, 1, 2901, 'Icy Veins: 256571 sells 2901'),
(256571, 2, 4357, 'Icy Veins: 256571 sells 4357'),
(256571, 3, 5956, 'Icy Veins: 256571 sells 5956'),
(256571, 4, 4364, 'Icy Veins: 256571 sells 4364'),
(256571, 5, 2880, 'Icy Veins: 256571 sells 2880'),
(256571, 6, 4404, 'Icy Veins: 256571 sells 4404'),
(256571, 7, 4399, 'Icy Veins: 256571 sells 4399'),
(256571, 8, 3857, 'Icy Veins: 256571 sells 3857'),
(256571, 9, 10648, 'Icy Veins: 256571 sells 10648'),
(256571, 10, 3466, 'Icy Veins: 256571 sells 3466'),
(256571, 11, 4400, 'Icy Veins: 256571 sells 4400'),
(256571, 12, 10647, 'Icy Veins: 256571 sells 10647'),
(256571, 13, 18567, 'Icy Veins: 256571 sells 18567'),
(256573, 1, 247786, 'Icy Veins: 256573 sells 247786'),
(256573, 2, 4470, 'Icy Veins: 256573 sells 4470'),
(256573, 3, 6217, 'Icy Veins: 256573 sells 6217'),
(256573, 4, 6342, 'Icy Veins: 256573 sells 6342'),
(256573, 5, 20758, 'Icy Veins: 256573 sells 20758'),
(256573, 6, 10938, 'Icy Veins: 256573 sells 10938'),
(256573, 7, 10940, 'Icy Veins: 256573 sells 10940'),
(256573, 8, 20752, 'Icy Veins: 256573 sells 20752'),
(256573, 9, 20753, 'Icy Veins: 256573 sells 20753'),
(256573, 10, 11291, 'Icy Veins: 256573 sells 11291'),
(256573, 11, 22307, 'Icy Veins: 256573 sells 22307'),
(256738, 1, 3371, 'Icy Veins: 256738 sells 3371'),
(256738, 2, 3372, 'Icy Veins: 256738 sells 3372'),
(256738, 3, 8925, 'Icy Veins: 256738 sells 8925'),
(256738, 4, 18256, 'Icy Veins: 256738 sells 18256'),
(256739, 1, 2901, 'Icy Veins: 256739 sells 2901'),
(256739, 2, 4357, 'Icy Veins: 256739 sells 4357'),
(256739, 3, 5956, 'Icy Veins: 256739 sells 5956'),
(256739, 4, 4364, 'Icy Veins: 256739 sells 4364'),
(256739, 5, 2880, 'Icy Veins: 256739 sells 2880'),
(256739, 6, 4363, 'Icy Veins: 256739 sells 4363'),
(256739, 7, 4399, 'Icy Veins: 256739 sells 4399'),
(256739, 8, 3857, 'Icy Veins: 256739 sells 3857'),
(256739, 9, 10648, 'Icy Veins: 256739 sells 10648'),
(256739, 10, 3466, 'Icy Veins: 256739 sells 3466'),
(256739, 11, 4400, 'Icy Veins: 256739 sells 4400'),
(256739, 12, 10647, 'Icy Veins: 256739 sells 10647'),
(256739, 13, 4382, 'Icy Veins: 256739 sells 4382'),
(256739, 14, 18567, 'Icy Veins: 256739 sells 18567'),
(256739, 15, 4371, 'Icy Veins: 256739 sells 4371'),
(256740, 1, 6217, 'Icy Veins: 256740 sells 6217'),
(256740, 2, 11291, 'Icy Veins: 256740 sells 11291'),
(256740, 3, 6342, 'Icy Veins: 256740 sells 6342'),
(256740, 4, 10940, 'Icy Veins: 256740 sells 10940'),
(256740, 5, 20752, 'Icy Veins: 256740 sells 20752'),
(256740, 6, 20753, 'Icy Veins: 256740 sells 20753'),
(256740, 7, 20758, 'Icy Veins: 256740 sells 20758'),
(256740, 8, 22307, 'Icy Veins: 256740 sells 22307'),
(256740, 9, 247786, 'Icy Veins: 256740 sells 247786'),
(256740, 10, 10938, 'Icy Veins: 256740 sells 10938'),
(256740, 11, 4470, 'Icy Veins: 256740 sells 4470'),
(256741, 1, 2320, 'Icy Veins: 256741 sells 2320'),
(256741, 2, 7005, 'Icy Veins: 256741 sells 7005'),
(256741, 3, 2324, 'Icy Veins: 256741 sells 2324'),
(256741, 4, 2604, 'Icy Veins: 256741 sells 2604'),
(256741, 5, 4289, 'Icy Veins: 256741 sells 4289'),
(256741, 6, 6260, 'Icy Veins: 256741 sells 6260'),
(256741, 7, 2321, 'Icy Veins: 256741 sells 2321'),
(256741, 8, 2605, 'Icy Veins: 256741 sells 2605'),
(256741, 9, 253665, 'Icy Veins: 256741 sells 253665'),
(256741, 10, 253668, 'Icy Veins: 256741 sells 253668'),
(256741, 11, 4340, 'Icy Veins: 256741 sells 4340'),
(256741, 12, 4291, 'Icy Veins: 256741 sells 4291'),
(256741, 13, 4341, 'Icy Veins: 256741 sells 4341'),
(256741, 14, 2325, 'Icy Veins: 256741 sells 2325'),
(256741, 15, 6261, 'Icy Veins: 256741 sells 6261'),
(256741, 16, 8343, 'Icy Veins: 256741 sells 8343'),
(256741, 17, 4342, 'Icy Veins: 256741 sells 4342'),
(256741, 18, 10290, 'Icy Veins: 256741 sells 10290'),
(256741, 19, 14341, 'Icy Veins: 256741 sells 14341');
UPDATE `everlake_live_vendor` s SET s.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `npc_vendor` v WHERE v.`entry` = s.`entry` AND v.`item` = s.`item` AND v.`ExtendedCost` = 0 AND v.`type` = 1)
  AND EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = s.`entry` AND (t.`npcflag` & 128) <> 0);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`)
SELECT s.`entry`, s.`slot`, s.`item`, 0, 0, 0, 1, NULL, 0, 0, 0 FROM `everlake_live_vendor` s WHERE s.`missing` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'npc_vendor', s.`entry`, s.`item`, 0, 1, @EVERLAKE_FILE, s.`note` FROM `everlake_live_vendor` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_live_vendor`;

COMMIT;
