-- Ruined Kegs (8409) starts from its Keg again.
-- 2026_11_19_940_world_everlake_ruined_kegs_starter.sql: written by hand.
--
-- The realm spawns the Keg (gameobject 180570) east of Southshore and Darkcaller Yanka (15197) ends the quest, but
-- nothing starts it: gameobject_queststarter has no row for 8409. VMaNGOS starts it from that Keg
-- (gameobject_questrelation 180570 -> 8409, db-70e38cd). Added only while the quest has no starter of any kind.
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

SET @EVERLAKE_RK := (SELECT COUNT(*) = 0 FROM `gameobject_queststarter` WHERE `quest` = 8409)
  AND (SELECT COUNT(*) = 0 FROM `creature_queststarter` WHERE `quest` = 8409)
  AND (SELECT COUNT(*) > 0 FROM `gameobject_template` WHERE `entry` = 180570);
INSERT INTO `gameobject_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT 180570, 8409, 0 FROM DUAL WHERE @EVERLAKE_RK = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_queststarter', 180570, 8409, 0, 0, '2026_11_19_940_world_everlake_ruined_kegs_starter.sql', 'vmangos@70e38cd gameobject_questrelation' FROM DUAL WHERE @EVERLAKE_RK = 1;

COMMIT;
