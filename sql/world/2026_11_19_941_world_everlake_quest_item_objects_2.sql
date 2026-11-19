-- Quest items: spawns for six of the objects file 939 added, where the official game has them.
-- 2026_11_19_941_world_everlake_quest_item_objects_2.sql: the ForeverTracker Forge's spawn script for its 6 Ready objects (2026-11-19 12:08), renumbered.
--
-- File 939 gave the realm these objects' templates and loot; the tracker's locator could then place them. Positions
-- are converted from Wowhead Forever's map coordinates; heights come from the realm's maps and vmaps. Respawn 300 s.
--
--   580100  Conqueror's Helm (1): Conqueror's Helm, Badlands (92743 A Conqueror's Crown)
--   620424  Freshly Picked Berries (7): Sweetberry, Riverglades (94734 A Boar's Delight)
--   629451  Powder Keg (12): Eastsea Powder Keg, Riverglades (95123 A Blast Ye Scurvy Dogs!)
--   667674  Explorers' League Supplies (1): Explorers' League Mining Helmet, Badlands (97617 Safety Checks)
--   668515  Diplomatic Satchel (1): Diplomatic Satchel, The Hinterlands (86615 Treaty Obligations)
--   669115  Lost Gryphon Egg (22): Lost Gryphon Egg, The Hinterlands (86620 Fledgling Rescue)
--
-- Not here: the four Tablets of I'lalai, The Lost Magic of the Runemasters and The Coldbringer's Eye. Wowhead has no
-- position for them.
-- Guids: objects 920007400 to 920007443, after file 937's (920007000 to 920007343).
-- A spawn is only added while its guid is free, its template exists and that object has no spawn at all yet.
-- Not checked in game.
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

DROP TEMPORARY TABLE IF EXISTS `everlake_import_stage`;
CREATE TEMPORARY TABLE `everlake_import_stage` (`guid` bigint unsigned NOT NULL, `id` int unsigned NOT NULL, `map` smallint unsigned NOT NULL,
  `x` float NOT NULL, `y` float NOT NULL, `z` float NOT NULL, `o` float NOT NULL, `r2` float NOT NULL, `r3` float NOT NULL, `respawn` int NOT NULL,
  `add` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`guid`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_import_stage` (`guid`, `id`, `map`, `x`, `y`, `z`, `o`, `r2`, `r3`, `respawn`) VALUES
(920007400, 580100, 0, -6554.57, -3499.53, 293.82, 1.293, 0.602396, 0.798197, 300),
(920007401, 620424, 0, -7663, -5694.07, 58.51, 0.983, 0.471949, 0.881626, 300),
(920007402, 620424, 0, -7666.23, -5703.77, 58.52, 3.784, 0.948856, -0.315709, 300),
(920007403, 620424, 0, -7469, -5708.62, 58.65, 1.346, 0.623335, 0.781955, 300),
(920007404, 620424, 0, -7643.6, -5718.32, 58.97, 4.547, 0.763098, -0.646283, 300),
(920007405, 620424, 0, -7698.57, -5728.02, 58.46, 4.125, 0.88153, -0.472128, 300),
(920007406, 620424, 0, -7672.7, -5771.67, 60.89, 0.754, 0.368133, 0.929773, 300),
(920007407, 620424, 0, -7679.17, -5771.67, 60.84, 0.262, 0.130626, 0.991432, 300),
(920007408, 629451, 0, -7556.3, -5660.12, 51.41, 3.374, 0.993256, -0.115942, 300),
(920007409, 629451, 0, -7494.87, -5664.97, 57.85, 0.54, 0.266731, 0.963771, 300),
(920007410, 629451, 0, -7672.7, -5684.37, 60.27, 5.924, 0.178629, -0.983917, 300),
(920007411, 629451, 0, -7679.17, -5684.37, 60.43, 4.125, 0.88153, -0.472128, 300),
(920007412, 629451, 0, -7591.87, -5689.22, 61.63, 3.605, 0.973277, -0.229636, 300),
(920007413, 629451, 0, -7630.67, -5698.92, 62, 0.785, 0.382499, 0.923956, 300),
(920007414, 629451, 0, -7494.87, -5703.77, 58.23, 5.212, 0.510351, -0.859966, 300),
(920007415, 629451, 0, -7465.77, -5742.57, 59.58, 5.312, 0.466733, -0.884398, 300),
(920007416, 629451, 0, -7679.17, -5742.57, 58.65, 5.607, 0.331688, -0.943389, 300),
(920007417, 629451, 0, -7643.6, -5747.42, 61.12, 1.892, 0.811082, 0.584932, 300),
(920007418, 629451, 0, -7462.53, -5752.27, 59.41, 5.76, 0.258619, -0.965979, 300),
(920007419, 629451, 0, -7533.67, -5791.07, 87.02, 0, 0, 1, 300),
(920007420, 667674, 0, -6460.05, -3400.03, 241.67, 0.705, 0.345245, 0.938513, 300),
(920007421, 668515, 0, 373.27, -2094.75, 121.84, 6.229, 0.027089, -0.999633, 300),
(920007422, 669115, 0, 147.4, -2044.7, 118.76, 0, 0, 1, 300),
(920007423, 669115, 0, 106.33, -2052.4, 113.49, 2.335, 0.919772, 0.392452, 300),
(920007424, 669115, 0, 147.4, -2117.85, 101.66, 0, 0, 1, 300),
(920007425, 669115, 0, 196.17, -2129.4, 103.27, 0, 0, 1, 300),
(920007426, 669115, 0, 170.5, -2152.5, 99.63, 0, 0, 1, 300),
(920007427, 669115, 0, 62.7, -2160.2, 106.13, 4.177, 0.868958, -0.494886, 300),
(920007428, 669115, 0, 206.43, -2164.05, 108.16, 4.263, 0.846881, -0.531782, 300),
(920007429, 669115, 0, 191.03, -2187.15, 101.4, 1.295, 0.603194, 0.797594, 300),
(920007430, 669115, 0, 47.3, -2214.1, 107.74, 0.524, 0.259013, 0.965874, 300),
(920007431, 669115, 0, 72.97, -2217.95, 102.3, 2.246, 0.901403, 0.43298, 300),
(920007432, 669115, 0, 152.53, -2225.65, 98.27, 0.726, 0.35508, 0.934836, 300),
(920007433, 669115, 0, 124.3, -2237.2, 99.59, 0, 0, 1, 300),
(920007434, 669115, 0, 19.07, -2237.2, 113.11, 0, 0, 1, 300),
(920007435, 669115, 0, 119.17, -2241.05, 100.02, 0, 0, 1, 300),
(920007436, 669115, 0, 252.63, -2275.7, 109.83, 0, 0, 1, 300),
(920007437, 669115, 0, 203.87, -2283.4, 103.71, 4.495, 0.779641, -0.626226, 300),
(920007438, 669115, 0, 255.2, -2306.5, 112.53, 4.38, 0.814341, -0.580387, 300),
(920007439, 669115, 0, 244.93, -2379.65, 121.49, 3.757, 0.953032, -0.302871, 300),
(920007440, 669115, 0, 90.93, -2398.9, 124.95, 5.822, 0.228555, -0.973531, 300),
(920007441, 669115, 0, 142.27, -2414.3, 121.24, 4.455, 0.792009, -0.610509, 300),
(920007442, 669115, 0, 257.77, -2433.55, 137.95, 2.03, 0.849481, 0.52762, 300),
(920007443, 669115, 0, 229.53, -2433.55, 138.75, 0.983, 0.471949, 0.881626, 300);

UPDATE `everlake_import_stage` s SET s.`add` = 1
WHERE EXISTS (SELECT 1 FROM `gameobject_template` t WHERE t.`entry` = s.`id`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`id` = s.`id`);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnDifficulties`, `position_x`, `position_y`, `position_z`, `orientation`,
  `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`)
SELECT `guid`, `id`, `map`, '0', `x`, `y`, `z`, `o`, 0, 0, `r2`, `r3`, `respawn`, 255, 1, 0 FROM `everlake_import_stage` WHERE `add` = 1;

INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`)
SELECT 'gameobject', s.`guid`, '2026_11_19_941_world_everlake_quest_item_objects_2.sql', 'forge-locator@2026-11-19 (wowhead-forever map + realm maps/vmaps)'
FROM `everlake_import_stage` s WHERE s.`add` = 1
ON DUPLICATE KEY UPDATE `file` = '2026_11_19_941_world_everlake_quest_item_objects_2.sql', `note` = 'forge-locator@2026-11-19 (wowhead-forever map + realm maps/vmaps)';

DROP TEMPORARY TABLE `everlake_import_stage`;

COMMIT;
