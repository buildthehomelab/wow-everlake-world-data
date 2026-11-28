-- Gossip NPCs whose trainer, vendor, flight or bank window could not be opened: no menu, or no option for the service.
-- 2026_11_28_99_world_everlake_service_npc_gossip.sql: written by hand, not tried in game (2026-11-28).
--
-- A creature with the gossip flag opens only its gossip menu (WorldSession::HandleGossipHelloOpcode), and its options
-- come only from gossip_menu_option (Player::PrepareGossipMenu). With no menu it shows an empty window, so a trainer,
-- vendor, flight master or banker with the gossip flag and no option for it cannot be used at all.
-- Checked: every spawned creature with the gossip flag and a service flag (959): 61 lack an option for a service.
-- Fixed here, 49 creatures:
--   40 get a menu of their own (2998001-2998040): Gorg, Gur'dok, Krix, Pa'zula, Melanie Sable, High Priestess Mims,
--   Garen Largo, Farseer Maret Firetend and 15 more trainers, 13 vendors (Deliana, Nina Surefire, Stondry Darkhammer,
--   Alynsia, Mivin Shadowweave, Lieutenant General Andorov, the Argent Quartermaster and others), the flight masters
--   Sulhasa, Grakna, Gretchen Mayberry and Bluebell, and the banker Teller Gee. The text is the realm's npc_text for the
--   NPC's live line where Icy Veins' recording matches exactly one (Abra Cadabra, Gur'dok, Mivin Shadowweave, Garen
--   Largo), else the realm's usual greeting 68. Alanndarian Nightsong leaves menu 361, which an NPC without a trainer
--   shares, for her own copy of it.
--   10 menus get the missing option: browse goods at Nadyia Maneweaver, Vance Undergloom, Duke Hydraxis, Anachronos,
--   Darkcaller Yanka, Aurel Goldleaf, Mokvar and Kurvelk Shadowhoof (the core hides it from a creature that sells
--   nothing, so menus shared with other NPCs stay as they were for them); train me at Hilda the Breaker and on the menu
--   Windshaper Boro and Aarnor Galestrike share (both trainers).
-- Options are the realm's usual ones (Train me. 3266, I want to browse your goods. 3370, Show me where I can fly. 12271,
-- I would like to check my deposit box. 3398). A "Train me." option opens the creature's own trainer list
-- (Player::OnGossipSelect). New options' GossipOptionID: MenuID * 100 + OptionID (as 2026_11_26_80); added ones:
-- -(MenuID * 256 + OptionID), the realm's rule.
-- Only where the realm has something to offer (vendor items, a trainer list) and live agrees: Icy Veins' recorded
-- gossip shows the option, or records none. Left out: Myizz Luckycatch (nothing to sell), Edward and Patricia Egan
-- 246792/246793 (no trainer list), Chromie and Jang (their live options are scripted, not a vendor window), Doctors
-- Gregory Victor and Gustaf VanHowzen and Henry Stern (their scripted lessons are their training), Gritta Chumwater's
-- and Walton's trainer option (live offers none), Ortak Lomgok (an innkeeper menu 16 NPCs share).
-- Rows only go in while the creature has no menu, or the menu has no option of that kind. Every added row is recorded
-- in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing.

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
SET @EVERLAKE_FILE := '2026_11_28_99_world_everlake_service_npc_gossip.sql';

START TRANSACTION;

-- a) creatures that get a menu of their own: creature, new menu, its text, the menu it leaves (0 = none)
DROP TEMPORARY TABLE IF EXISTS `everlake_gnew`;
CREATE TEMPORARY TABLE `everlake_gnew` (`entry` INT UNSIGNED NOT NULL PRIMARY KEY, `menu` INT UNSIGNED NOT NULL, `text` INT UNSIGNED NOT NULL,
  `old` INT UNSIGNED NOT NULL, `ok` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_gnew` (`entry`, `menu`, `text`, `old`) VALUES
(3702,2998001,838,361),
(14242,2998002,68,0),
(15471,2998003,68,0),
(16786,2998004,68,0),
(205729,2998005,68,0),
(230319,2998006,68,0),
(246795,2998007,68,0),
(246797,2998008,68,0),
(251981,2998009,68,0),
(252019,2998010,20298,0),
(252382,2998011,68,0),
(255891,2998012,68,0),
(255993,2998013,68,0),
(256655,2998014,68,0),
(256658,2998015,3414,0),
(256729,2998016,68,0),
(256730,2998017,68,0),
(256732,2998018,68,0),
(256735,2998019,690001,0),
(257087,2998020,68,0),
(258568,2998021,68,0),
(258785,2998022,68,0),
(259250,2998023,68,0),
(259287,2998024,68,0),
(260093,2998025,5673,0),
(260487,2998026,68,0),
(260558,2998027,68,0),
(260562,2998028,68,0),
(260626,2998029,68,0),
(262558,2998030,68,0),
(266881,2998031,68,0),
(266901,2998032,68,0),
(267000,2998033,68,0),
(267335,2998034,68,0),
(270263,2998035,68,0),
(270459,2998036,68,0),
(272045,2998037,68,0),
(275243,2998038,68,0),
(275321,2998039,68,0),
(275322,2998040,68,0);

-- only creatures still on the menu they had (none, or 361 for Alanndarian), new menus and their text free/present
UPDATE `everlake_gnew` n SET n.`ok` = 1
WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu` m WHERE m.`MenuID` = n.`menu`)
  AND NOT EXISTS (SELECT 1 FROM `gossip_menu_option` o WHERE o.`MenuID` = n.`menu`)
  AND EXISTS (SELECT 1 FROM `npc_text` t WHERE t.`ID` = n.`text`)
  AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = n.`entry`)
  AND ((n.`old` = 0 AND NOT EXISTS (SELECT 1 FROM `creature_template_gossip` g WHERE g.`CreatureID` = n.`entry`))
    OR (n.`old` > 0 AND EXISTS (SELECT 1 FROM `creature_template_gossip` g WHERE g.`CreatureID` = n.`entry` AND g.`MenuID` = n.`old`)
        AND (SELECT COUNT(*) FROM `creature_template_gossip` g WHERE g.`CreatureID` = n.`entry`) = 1));

INSERT INTO `gossip_menu` (`MenuID`, `TextID`, `VerifiedBuild`)
SELECT n.`menu`, n.`text`, 0 FROM `everlake_gnew` n WHERE n.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gossip_menu', n.`menu`, n.`text`, 0, 0, @EVERLAKE_FILE, CONCAT('own service menu for creature ', n.`entry`) FROM `everlake_gnew` n WHERE n.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_gossip', n.`entry`, n.`old`, 0, 9, @EVERLAKE_FILE, CONCAT('removed: menu ', n.`old`, ' (shared with a creature without a trainer)')
FROM `everlake_gnew` n WHERE n.`ok` = 1 AND n.`old` > 0;
DELETE g FROM `creature_template_gossip` g JOIN `everlake_gnew` n ON n.`entry` = g.`CreatureID` AND n.`old` = g.`MenuID` WHERE n.`ok` = 1 AND n.`old` > 0;
INSERT INTO `creature_template_gossip` (`CreatureID`, `MenuID`, `VerifiedBuild`)
SELECT n.`entry`, n.`menu`, 0 FROM `everlake_gnew` n WHERE n.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_gossip', n.`entry`, n.`menu`, 0, 0, @EVERLAKE_FILE, 'creature gets its own service menu' FROM `everlake_gnew` n WHERE n.`ok` = 1;

-- b) options: on the new menus (only where a) went in) and on existing menus (only while they have no option of that kind)
DROP TEMPORARY TABLE IF EXISTS `everlake_gopt`;
CREATE TEMPORARY TABLE `everlake_gopt` (`menu` INT UNSIGNED NOT NULL, `gid` INT NOT NULL, `oid` INT UNSIGNED NOT NULL, `npc` TINYINT UNSIGNED NOT NULL,
  `txt` VARCHAR(80) NOT NULL, `bt` INT UNSIGNED NOT NULL, `ok` TINYINT NOT NULL DEFAULT 0, PRIMARY KEY (`menu`, `oid`));
INSERT INTO `everlake_gopt` (`menu`, `gid`, `oid`, `npc`, `txt`, `bt`) VALUES
(2998001,299800100,0,3,'Train me.',3266),
(2998002,299800200,0,2,'Show me where I can fly.',12271),
(2998003,299800300,0,1,'I want to browse your goods.',3370),
(2998004,299800400,0,1,'I want to browse your goods.',3370),
(2998005,299800500,0,3,'Train me.',3266),
(2998006,299800600,0,1,'I want to browse your goods.',3370),
(2998007,299800700,0,3,'Train me.',3266),
(2998008,299800800,0,3,'Train me.',3266),
(2998009,299800900,0,1,'I want to browse your goods.',3370),
(2998010,299801000,0,1,'I want to browse your goods.',3370),
(2998011,299801100,0,3,'Train me.',3266),
(2998012,299801200,0,3,'Train me.',3266),
(2998013,299801300,0,2,'Show me where I can fly.',12271),
(2998014,299801400,0,3,'Train me.',3266),
(2998015,299801500,0,3,'Train me.',3266),
(2998016,299801600,0,1,'I want to browse your goods.',3370),
(2998017,299801700,0,1,'I want to browse your goods.',3370),
(2998018,299801800,0,1,'I want to browse your goods.',3370),
(2998019,299801900,0,1,'I want to browse your goods.',3370),
(2998020,299802000,0,2,'Show me where I can fly.',12271),
(2998021,299802100,0,1,'I want to browse your goods.',3370),
(2998022,299802200,0,3,'Train me.',3266),
(2998023,299802300,0,3,'Train me.',3266),
(2998024,299802400,0,3,'Train me.',3266),
(2998025,299802500,0,3,'Train me.',3266),
(2998026,299802600,0,1,'I want to browse your goods.',3370),
(2998027,299802700,0,3,'Train me.',3266),
(2998028,299802800,0,3,'Train me.',3266),
(2998029,299802900,0,2,'Show me where I can fly.',12271),
(2998030,299803000,0,3,'Train me.',3266),
(2998031,299803100,0,3,'Train me.',3266),
(2998032,299803200,0,1,'I want to browse your goods.',3370),
(2998033,299803300,0,3,'Train me.',3266),
(2998033,299803301,1,1,'I want to browse your goods.',3370),
(2998034,299803400,0,3,'Train me.',3266),
(2998035,299803500,0,3,'Train me.',3266),
(2998036,299803600,0,3,'Train me.',3266),
(2998037,299803700,0,1,'I want to browse your goods.',3370),
(2998038,299803800,0,6,'I would like to check my deposit box.',3398),
(2998039,299803900,0,3,'Train me.',3266),
(2998040,299804000,0,3,'Train me.',3266),
(4174,-1068545,1,1,'I want to browse your goods.',3370),
(4202,-1075713,1,1,'I want to browse your goods.',3370),
(5065,-1296642,2,1,'I want to browse your goods.',3370),
(6539,-1673999,15,1,'I want to browse your goods.',3370),
(6537,-1673472,0,1,'I want to browse your goods.',3370),
(6567,-1681152,0,1,'I want to browse your goods.',3370),
(7070,-1809920,0,1,'I want to browse your goods.',3370),
(39691,-10160897,1,3,'Train me.',3266),
(41125,-10528000,0,3,'Train me.',3266),
(44771,-11461376,0,1,'I want to browse your goods.',3370);

UPDATE `everlake_gopt` p SET p.`ok` = 1
WHERE EXISTS (SELECT 1 FROM `gossip_menu` m WHERE m.`MenuID` = p.`menu`)
  AND NOT EXISTS (SELECT 1 FROM `gossip_menu_option` o WHERE o.`MenuID` = p.`menu` AND (o.`OptionID` = p.`oid` OR o.`OptionNpc` = p.`npc`))
  AND NOT EXISTS (SELECT 1 FROM `gossip_menu_option` o WHERE o.`GossipOptionID` = p.`gid`);

INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`,
    `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`)
SELECT p.`menu`, p.`gid`, p.`oid`, p.`npc`, p.`txt`, p.`bt`, 0, 0, 0, 0, NULL, 0, 0, '', 0, NULL, NULL, 0 FROM `everlake_gopt` p WHERE p.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gossip_menu_option', p.`menu`, p.`oid`, p.`gid`, 0, @EVERLAKE_FILE, CONCAT('service option (OptionNpc ', p.`npc`, ', broadcast text ', p.`bt`, ')')
FROM `everlake_gopt` p WHERE p.`ok` = 1;

DROP TEMPORARY TABLE `everlake_gopt`;
DROP TEMPORARY TABLE `everlake_gnew`;

COMMIT;
