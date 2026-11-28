-- 2434 Shadowy Assassin (Syndicate, 37-38, Southshore): stealthed on live, visible on the realm, so Marshal Redpath
-- 2263 and the Southshore guards see them and kill them over and over.
-- 2026_11_27_80_world_everlake_shadowy_assassin_stealth.sql: written by hand, not tried in game (2026-11-27).
--
-- How live does it (sources, the tracker's tables):
--   Wowhead WoW Forever npc 2434 abilities: 1785 Stealth, 744 Poison, 1604 Dazed.
--   Wowhead map + EG Link live recording + NorgannonDB: they stand in and around Southshore (zone 267, ~50,57), which is
--   where the realm's six spawns are (91524001-91524006, AnoCore restore). VMaNGOS, AzerothCore and TrinityCore place
--   none, so these six are the only ones.
-- The realm: creature_template_addon 2434 auras '3616' (Poison Proc), no stealth, no stealth in its SmartAI.
--
-- Rows: Stealth 1785 added to the template addon auras beside Poison Proc, so it is on at spawn and again after
-- evading. Only changed while the auras are still '3616'. The change is recorded in everlake_import_rows.
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';
SET @EVERLAKE_FILE := '2026_11_27_80_world_everlake_shadowy_assassin_stealth.sql';

START TRANSACTION;

UPDATE `creature_template_addon` a
SET a.`auras` = '3616 1785'
WHERE a.`entry` = 2434 AND a.`auras` = '3616';

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_addon', 2434, 0, 0, 0, @EVERLAKE_FILE, 'auras 3616 -> 3616 1785 (Stealth); Wowhead Forever npc 2434 ability 1785'
FROM `creature_template_addon` a WHERE a.`entry` = 2434 AND a.`auras` = '3616 1785';

COMMIT;
