-- Blasting Supplies (403041) for Stalk With The Earthmother (76156): the Venture Co. mine in Mulgore has one cart on the
-- test realm, live has thirteen.
-- 2026_11_26_42_world_everlake_blasting_supplies.sql: written by hand from the tracker's kept facts (2026-11-26).
--
-- The quest asks for 5 Seaforium Mining Charges (206157). Each comes from using a Blasting Supplies cart (goober 403041,
-- quest 76156, spell 412278 Collect Blasting Supplies creates the charge), and the test realm spawns one cart
-- (guid 21202192, near the mine mouth). Wowhead's WoW Forever object page (https://www.wowhead.com/forever/object=403041)
-- pins 13 carts inside the mine (Mulgore, UiMap 1412); Icy Veins' WoW Forever record has the same template.
-- 12 of those pins are added here; the pin at 59.2, 43.8 is left out because no floor of the mine model lies near the
-- mine's own creatures there. Map points are turned into world positions with the client's UiMapAssignment rectangles,
-- as the tracker's locator does. Heights from the server's maps and vmaps (tools/height.py): the mine is a model with
-- two or three floors on every vertical line, so each cart takes the floor nearest the height of the closest spawned
-- mine creature (Venture Co. Laborers/Supervisors, within 15 yards for most points). Respawn 120 s, as the existing cart.
--
-- Own guid block 920019500-920019599 (this file uses 920019500-920019511). Every row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
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

SET @EVERLAKE_FILE := '2026_11_26_42_world_everlake_blasting_supplies.sql';
START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_new_carts`;
CREATE TEMPORARY TABLE `everlake_new_carts` (`guid` bigint unsigned NOT NULL, `x` float NOT NULL, `y` float NOT NULL, `z` float NOT NULL, `note` varchar(255) NOT NULL, PRIMARY KEY (`guid`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_new_carts` (`guid`, `x`, `y`, `z`, `note`) VALUES
(920019500, -1735.15, -1053.32, 118.45, 'Wowhead Forever object=403041 pin 57.4, 48.8; height.py mine floor'),
(920019501, -1735.15, -1059.48, 118.56, 'Wowhead Forever object=403041 pin 57.5, 48.8; height.py mine floor'),
(920019502, -1612.09, -1071.79, 102.45, 'Wowhead Forever object=403041 pin 57.7, 45.8; height.py mine floor'),
(920019503, -1698.23, -1114.87, 121.52, 'Wowhead Forever object=403041 pin 58.4, 47.9; height.py mine floor'),
(920019504, -1579.27, -1121.02, 103.71, 'Wowhead Forever object=403041 pin 58.5, 45.0; height.py mine floor'),
(920019505, -1665.41, -1164.1, 113.35, 'Wowhead Forever object=403041 pin 59.2, 47.1; height.py mine floor'),
(920019506, -1751.56, -1176.41, 123.1, 'Wowhead Forever object=403041 pin 59.4, 49.2; height.py mine floor'),
(920019507, -1743.35, -1188.72, 123.16, 'Wowhead Forever object=403041 pin 59.6, 49.0; height.py mine floor'),
(920019508, -1624.39, -1207.18, 135.56, 'Wowhead Forever object=403041 pin 59.9, 46.1; height.py mine floor'),
(920019509, -1669.52, -1213.33, 129.03, 'Wowhead Forever object=403041 pin 60.0, 47.2; height.py mine floor'),
(920019510, -1784.38, -1219.49, 115.91, 'Wowhead Forever object=403041 pin 60.1, 50.0; height.py mine floor'),
(920019511, -1628.5, -1361.03, 132.49, 'Wowhead Forever object=403041 pin 62.4, 46.2; height.py mine floor');

INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT c.`guid`, 403041, 1, 0, 0, '0', 0, 0, 0, -1, c.`x`, c.`y`, c.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0
FROM `everlake_new_carts` c
WHERE EXISTS (SELECT 1 FROM `gameobject_template` WHERE `entry` = 403041)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = c.`guid`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', c.`guid`, 0, 0, 0, @EVERLAKE_FILE, c.`note`
FROM `everlake_new_carts` c JOIN `gameobject` g ON g.`guid` = c.`guid` AND g.`id` = 403041;
DROP TEMPORARY TABLE `everlake_new_carts`;

COMMIT;
