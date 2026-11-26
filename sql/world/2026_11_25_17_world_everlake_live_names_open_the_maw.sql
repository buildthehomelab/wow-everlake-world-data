-- Six creature names the live game has changed, and Open the Maw's prerequisite.
-- 2026_11_25_17_world_everlake_live_names_open_the_maw.sql: written by hand from the tracker's kept facts (2026-11-25).
--
-- Names: the realm still holds the old names. EG Link's recordings, Icy Veins' WoW Forever database
-- (https://db.icy-veins.com/wow-forever/) and Wowhead's WoW Forever pages all give the live one:
--   5683   Comar Villard     -> Corma Villard
--   11498  Skarr the Broken  -> Skarr the Unbreakable
--   14990  Defilers Envoy    -> Defilers Emissary
--   15105  Warsong Envoy     -> Warsong Emissary
--   15106  Frostwolf Envoy   -> Frostwolf Emissary
--   277055 Axle Smoothslice  -> Edine Sharphorn (the Barber; EG Link recorded both names, the newer is Edine)
-- English only: the locale rows are left as they are. Each name changes only while it still holds the old one.
--
-- Open the Maw (95682) follows Dragonmaw Rumors (95663): Icy Veins lists 95663 as the quest before it. The realm has
-- no quest_template_addon row for 95682, so it is offered without Dragonmaw Rumors done.
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
START TRANSACTION;

UPDATE `creature_template` SET `name` = 'Corma Villard' WHERE `entry` = 5683 AND `name` = 'Comar Villard';
UPDATE `creature_template` SET `name` = 'Skarr the Unbreakable' WHERE `entry` = 11498 AND `name` = 'Skarr the Broken';
UPDATE `creature_template` SET `name` = 'Defilers Emissary' WHERE `entry` = 14990 AND `name` = 'Defilers Envoy';
UPDATE `creature_template` SET `name` = 'Warsong Emissary' WHERE `entry` = 15105 AND `name` = 'Warsong Envoy';
UPDATE `creature_template` SET `name` = 'Frostwolf Emissary' WHERE `entry` = 15106 AND `name` = 'Frostwolf Envoy';
UPDATE `creature_template` SET `name` = 'Edine Sharphorn' WHERE `entry` = 277055 AND `name` = 'Axle Smoothslice';

INSERT INTO `quest_template_addon` (`ID`, `PrevQuestID`)
SELECT 95682, 95663 FROM DUAL
WHERE EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 95682) AND EXISTS (SELECT 1 FROM `quest_template` WHERE `ID` = 95663)
  AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID` = 95682);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`)
SELECT 'quest_template_addon', 95682, '2026_11_25_17_world_everlake_live_names_open_the_maw.sql', 'icyveins: previous quest 95663'
FROM `quest_template_addon` WHERE `ID` = 95682 AND `PrevQuestID` = 95663;

COMMIT;
