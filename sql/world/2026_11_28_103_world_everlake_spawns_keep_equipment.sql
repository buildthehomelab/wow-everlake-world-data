-- Spawns left unarmed while every other spawn of their creature carries its equipment.
-- 2026_11_28_103_world_everlake_spawns_keep_equipment.sql: written by hand, not tried in game (2026-11-28).
--
-- No source in the tracker records what an NPC holds on live (Wowhead's outfit tab is armour appearance, EG Link and
-- Icy Veins give only display models), so this goes by the realm's own data, as 2026_11_28_30 did for auras.
-- Checked: every creature with a creature_equip_template row: 13 have some spawns with equipment_id 0 (nothing in their
-- hands) beside spawns with equipment_id 1. The empty ones come from imports: the 9200xxx Forever block (Dark Neophyte
-- 11 of 16, Dark Enforcer 9 of 21, Dalaran Wizard 8 of 13, Earthen Ring Shaman 7 of 16, the Shadowvale Mystics 260430 and
-- 260432, Vile Fin Seer 3 of 29, Tarnished Zealot 1 of 24), 2026_11_26_80's Darkspear Islands Spirit Guides (5 + 5),
-- the Booty Bay Revelers 900000176-181 (6 of 25) and Temple Highguard 27475700 (1 of 23). They get equipment 1, as the
-- rest of their creature has.
-- Left alone: the Darkmoon Faire Carnie 14849, whose empty spawns are Blizzard's own sniffed rows (some carnies carry
-- nothing). Spawns pointing at an equipment id their creature has no row for (236 creatures, mostly the default 1)
-- change nothing in game and are left as they are.
-- Every changed spawn is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a
-- new file. Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_28_103_world_everlake_spawns_keep_equipment.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_equip`;
CREATE TEMPORARY TABLE `everlake_equip` (`guid` BIGINT UNSIGNED NOT NULL PRIMARY KEY, `id` INT UNSIGNED NOT NULL);
INSERT INTO `everlake_equip` (`guid`, `id`)
SELECT c.`guid`, c.`id` FROM `creature` c
WHERE c.`id` IN (267006, 275437, 256359, 262504, 15723, 260432, 13116, 13117, 260430, 250282, 259433, 274757)
  AND c.`equipment_id` = 0
  AND EXISTS (SELECT 1 FROM `creature_equip_template` e WHERE e.`CreatureID` = c.`id` AND e.`ID` = 1);

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', x.`guid`, 0, 0, 103, @EVERLAKE_FILE, CONCAT('equipment_id 0 -> 1, as the other spawns of creature ', x.`id`)
FROM `everlake_equip` x;
UPDATE `creature` c JOIN `everlake_equip` x ON x.`guid` = c.`guid` SET c.`equipment_id` = 1 WHERE c.`equipment_id` = 0;
DROP TEMPORARY TABLE `everlake_equip`;

COMMIT;
