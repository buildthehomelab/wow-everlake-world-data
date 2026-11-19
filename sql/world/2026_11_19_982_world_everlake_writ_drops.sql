-- Craftsman's Writs drop in the open world: the writ items that start the 94 writ quests of
-- 2026_11_19_981_world_everlake_build.sql had no source on the realm.
-- 2026_11_19_982_world_everlake_writ_drops.sql: written by hand.
--
-- What is known: Wowhead's Forever guide "Craftsman's Writs: Recipes, Rewards & Routes" (2026-11-15) says a writ is a
-- world drop, "not completely random": players find writs suited to their zone and level. It lists each writ's tier
-- (Journeyman, Expert, Artisan); the quest records agree (treasure picker 4817 / 4818 / 4819, 75 / 125 / 200
-- reputation). No public recording names the creatures or the chance (EG Link's loot recordings hold no writ).
--
-- What is INFERRED here: one drop list per tier, every writ of the tier equally likely (one loot group), on every
-- creature that already has loot, is not a critter and stands in the open world (maps 0, 1 and 2991 Zephras Isle),
-- by its highest level: Journeyman 20-34, Expert 35-51, Artisan 52-63. Chance 0.5% per kill for the tier's list.
-- Writs per list: Journeyman 21, Expert 56, Artisan 17.
-- Reference loot ids 9500001-9500003 are new.
--
-- Only rows the world lacks are added; every row goes in the ledger. Never edit this file once it is deployed: a
-- later fix is a new file. Running it again changes nothing. Not tried in game.

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

-- the three drop lists
DROP TEMPORARY TABLE IF EXISTS `everlake_writ_ref`;
CREATE TEMPORARY TABLE `everlake_writ_ref` (`Entry` int unsigned NOT NULL, `Item` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`Entry`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_writ_ref` (`Entry`, `Item`, `note`) VALUES
(9500001, 264020, 'Journeyman: Craftsman''s Writ: Pearl-Handled Dagger (quest 94220)'),
(9500001, 264024, 'Journeyman: Craftsman''s Writ: Heavy Bronze Mace (quest 94224)'),
(9500001, 264025, 'Journeyman: Craftsman''s Writ: Rough Bronze Leggings (quest 94225)'),
(9500001, 264026, 'Journeyman: Craftsman''s Writ: Green Iron Gauntlets (quest 94226)'),
(9500001, 264028, 'Journeyman: Craftsman''s Writ: Green Iron Boots (quest 94228)'),
(9500001, 264032, 'Journeyman: Craftsman''s Writ: Minor Recombobulator (quest 94232)'),
(9500001, 264034, 'Journeyman: Craftsman''s Writ: Shadow Goggles (quest 94234)'),
(9500001, 264036, 'Journeyman: Craftsman''s Writ: Big Bronze Bomb (quest 94236)'),
(9500001, 264037, 'Journeyman: Craftsman''s Writ: Crafted Solid Shot (quest 94237)'),
(9500001, 264038, 'Journeyman: Craftsman''s Writ: Heavy Leather Ball (quest 94238)'),
(9500001, 264039, 'Journeyman: Craftsman''s Writ: Fine Leather Pants (quest 94239)'),
(9500001, 264040, 'Journeyman: Craftsman''s Writ: Herbalist''s Gloves (quest 94240)'),
(9500001, 264042, 'Journeyman: Craftsman''s Writ: Pilferer''s Gloves (quest 94242)'),
(9500001, 264044, 'Journeyman: Craftsman''s Writ: Dark Leather Shoulders (quest 94244)'),
(9500001, 264045, 'Journeyman: Craftsman''s Writ: Barbaric Gloves (quest 94245)'),
(9500001, 264046, 'Journeyman: Craftsman''s Writ: Red Whelp Gloves (quest 94246)'),
(9500001, 264050, 'Journeyman: Craftsman''s Writ: Small Silk Pack (quest 94250)'),
(9500001, 264051, 'Journeyman: Craftsman''s Writ: Phoenix Pants (quest 94251)'),
(9500001, 264052, 'Journeyman: Craftsman''s Writ: Red Woolen Boots (quest 94252)'),
(9500001, 264053, 'Journeyman: Craftsman''s Writ: Colorful Kilt (quest 94253)'),
(9500001, 264054, 'Journeyman: Craftsman''s Writ: Greater Adept''s Robe (quest 94254)'),
(9500002, 264057, 'Expert: Craftsman''s Writ: Lesser Invisibility Potion (quest 94257)'),
(9500002, 264058, 'Expert: Craftsman''s Writ: Lesser Stoneshield Potion (quest 94258)'),
(9500002, 264059, 'Expert: Craftsman''s Writ: Nature Protection Potion (quest 94259)'),
(9500002, 264060, 'Expert: Craftsman''s Writ: Catseye Draught (quest 94260)'),
(9500002, 264061, 'Expert: Craftsman''s Writ: Great Rage Potion (quest 94261)'),
(9500002, 264062, 'Expert: Craftsman''s Writ: Mana Potion (quest 94262)'),
(9500002, 264064, 'Expert: Craftsman''s Writ: Shadow Oil (quest 94264)'),
(9500002, 264065, 'Expert: Craftsman''s Writ: Goblin Rocket Fuel (quest 94265)'),
(9500002, 264066, 'Expert: Craftsman''s Writ: Elixir of Agility (quest 94266)'),
(9500002, 264067, 'Expert: Craftsman''s Writ: Wildvine Potion (quest 94267)'),
(9500002, 264068, 'Expert: Craftsman''s Writ: Steel Plate Helm (quest 94268)'),
(9500002, 264069, 'Expert: Craftsman''s Writ: Inlaid Mithril Cylinder (quest 94269)'),
(9500002, 264070, 'Expert: Craftsman''s Writ: Steel Weapon Chain (quest 94270)'),
(9500002, 264071, 'Expert: Craftsman''s Writ: Ornate Mithril Shoulders (quest 94271)'),
(9500002, 264072, 'Expert: Craftsman''s Writ: Blue Glittering Axe (quest 94272)'),
(9500002, 264073, 'Expert: Craftsman''s Writ: Moonsteel Broadsword (quest 94273)'),
(9500002, 264074, 'Expert: Craftsman''s Writ: Golden Scale Coif (quest 94274)'),
(9500002, 264075, 'Expert: Craftsman''s Writ: Solid Sharpening Stone (quest 94275)'),
(9500002, 264076, 'Expert: Craftsman''s Writ: Wicked Mithril Blade (quest 94276)'),
(9500002, 264077, 'Expert: Craftsman''s Writ: Truesilver Rod (quest 94277)'),
(9500002, 264078, 'Expert: Craftsman''s Writ: Golden Scale Gauntlets (quest 94278)'),
(9500002, 264079, 'Expert: Craftsman''s Writ: Heavy Mithril Axe (quest 94279)'),
(9500002, 264080, 'Expert: Craftsman''s Writ: Mechanical Dragonling (quest 94280)'),
(9500002, 264081, 'Expert: Craftsman''s Writ: Advanced Target Dummy (quest 94281)'),
(9500002, 264082, 'Expert: Craftsman''s Writ: Craftsman''s Monocle (quest 94282)'),
(9500002, 264083, 'Expert: Craftsman''s Writ: Goblin Land Mine (quest 94283)'),
(9500002, 264084, 'Expert: Craftsman''s Writ: Catseye Ultra Goggles (quest 94284)'),
(9500002, 264085, 'Expert: Craftsman''s Writ: Unstable Trigger (quest 94285)'),
(9500002, 264086, 'Expert: Craftsman''s Writ: Flash Bomb (quest 94286)'),
(9500002, 264088, 'Expert: Craftsman''s Writ: Mithril Frag Bomb (quest 94288)'),
(9500002, 264089, 'Expert: Craftsman''s Writ: Gyromatic Micro-Adjuster (quest 94289)'),
(9500002, 264090, 'Expert: Craftsman''s Writ: Mechanical Repair Kit (quest 94290)'),
(9500002, 264092, 'Expert: Craftsman''s Writ: Comfortable Leather Hat (quest 94292)'),
(9500002, 264093, 'Expert: Craftsman''s Writ: Guardian Cloak (quest 94293)'),
(9500002, 264094, 'Expert: Craftsman''s Writ: Dusky Bracers (quest 94294)'),
(9500002, 264095, 'Expert: Craftsman''s Writ: Wild Leather Helmet (quest 94295)'),
(9500002, 264096, 'Expert: Craftsman''s Writ: Wild Leather Shoulders (quest 94296)'),
(9500002, 264097, 'Expert: Craftsman''s Writ: Quickdraw Quiver (quest 94297)'),
(9500002, 264098, 'Expert: Craftsman''s Writ: Swift Boots (quest 94298)'),
(9500002, 264099, 'Expert: Craftsman''s Writ: Nightscape Shoulders (quest 94299)'),
(9500002, 264100, 'Expert: Craftsman''s Writ: Big Voodoo Mask (quest 94300)'),
(9500002, 264101, 'Expert: Craftsman''s Writ: Big Voodoo Robe (quest 94301)'),
(9500002, 264102, 'Expert: Craftsman''s Writ: Turtle Scale Breastplate (quest 94302)'),
(9500002, 264103, 'Expert: Craftsman''s Writ: Thick Leather Ammo Pouch (quest 94303)'),
(9500002, 264104, 'Expert: Craftsman''s Writ: Mageweave Bag (quest 94304)'),
(9500002, 264105, 'Expert: Craftsman''s Writ: Shadoweave Gloves (quest 94305)'),
(9500002, 264106, 'Expert: Craftsman''s Writ: Crimson Silk Robe (quest 94306)'),
(9500002, 264107, 'Expert: Craftsman''s Writ: Shadoweave Robe (quest 94307)'),
(9500002, 264108, 'Expert: Craftsman''s Writ: Enchanted Mageweave Pouch (quest 94308)'),
(9500002, 264109, 'Expert: Craftsman''s Writ: Star Belt (quest 94309)'),
(9500002, 264110, 'Expert: Craftsman''s Writ: Black Mageweave Vest (quest 94310)'),
(9500002, 264111, 'Expert: Craftsman''s Writ: Red Mageweave Pants (quest 94311)'),
(9500002, 264112, 'Expert: Craftsman''s Writ: Orange Martial Shirt (quest 94312)'),
(9500002, 264113, 'Expert: Craftsman''s Writ: White Bandit Mask (quest 94313)'),
(9500002, 264114, 'Expert: Craftsman''s Writ: Cindercloth Robe (quest 94314)'),
(9500002, 264115, 'Expert: Craftsman''s Writ: Earthen Silk Belt (quest 94315)'),
(9500003, 264116, 'Artisan: Craftsman''s Writ: Potion of Demonslaying (quest 94316)'),
(9500003, 264117, 'Artisan: Craftsman''s Writ: Dreamless Sleep Potion (quest 94317)'),
(9500003, 264118, 'Artisan: Craftsman''s Writ: Greater Fire Protection Potion (quest 94318)'),
(9500003, 264119, 'Artisan: Craftsman''s Writ: Draught of Detect Demon (quest 94319)'),
(9500003, 264120, 'Artisan: Craftsman''s Writ: Gift of Arthas (quest 94320)'),
(9500003, 264122, 'Artisan: Craftsman''s Writ: Limited Invulnerability Potion (quest 94322)'),
(9500003, 264123, 'Artisan: Craftsman''s Writ: Major Rejuvenation Potion (quest 94323)'),
(9500003, 264128, 'Artisan: Craftsman''s Writ: Mithril Spurs (quest 94328)'),
(9500003, 264135, 'Artisan: Craftsman''s Writ: Green Lens (quest 94335)'),
(9500003, 264140, 'Artisan: Craftsman''s Writ: Truesilver Transformer (quest 94340)'),
(9500003, 264141, 'Artisan: Craftsman''s Writ: Sniper Scope (quest 94341)'),
(9500003, 264146, 'Artisan: Craftsman''s Writ: Runic Leather Headband (quest 94346)'),
(9500003, 264147, 'Artisan: Craftsman''s Writ: Wicked Leather Bracers (quest 94347)'),
(9500003, 264150, 'Artisan: Craftsman''s Writ: Runic Leather Bracers (quest 94350)'),
(9500003, 264153, 'Artisan: Craftsman''s Writ: Runecloth Bag (quest 94353)'),
(9500003, 264155, 'Artisan: Craftsman''s Writ: Tuxedo Jacket (quest 94355)'),
(9500003, 264158, 'Artisan: Craftsman''s Writ: Shadoweave Mask (quest 94358)');
UPDATE `everlake_writ_ref` s SET s.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `reference_loot_template` t WHERE t.`Entry` = s.`Entry` AND t.`ItemType` = 0 AND t.`Item` = s.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'reference_loot_template' AND r.`k1` = s.`Entry` AND r.`k2` = 0 AND r.`k3` = s.`Item`);
INSERT INTO `reference_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`Entry`, 0, s.`Item`, 0, 0, 1, 1, 1, 1, LEFT(s.`note`, 255) FROM `everlake_writ_ref` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'reference_loot_template', s.`Entry`, 0, s.`Item`, '2026_11_19_982_world_everlake_writ_drops.sql', 'Wowhead Forever writ guide (tier); drop list INFERRED' FROM `everlake_writ_ref` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_writ_ref`;

-- every open-world creature with loot, by its highest level, gets its tier's list
DROP TEMPORARY TABLE IF EXISTS `everlake_writ_loot`;
CREATE TEMPORARY TABLE `everlake_writ_loot` (`Entry` int unsigned NOT NULL, `Item` int unsigned NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`Entry`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT IGNORE INTO `everlake_writ_loot` (`Entry`, `Item`)
SELECT d.`LootID`, CASE WHEN l.`level_max` BETWEEN 20 AND 34 THEN 9500001 WHEN l.`level_max` BETWEEN 35 AND 51 THEN 9500002 ELSE 9500003 END
FROM `creature_template_difficulty` d
JOIN `creature_template` t ON t.`entry` = d.`Entry`
JOIN `creature_classic_level` l ON l.`entry` = d.`Entry`
WHERE d.`DifficultyID` = 0 AND d.`LootID` > 0 AND t.`type` <> 8 AND l.`level_max` BETWEEN 20 AND 63
  AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = d.`Entry` AND c.`map` IN (0, 1, 2991))
  AND EXISTS (SELECT 1 FROM `reference_loot_template` r WHERE r.`Entry` IN (9500001, 9500002, 9500003));
UPDATE `everlake_writ_loot` s SET s.`missing` = 1
WHERE EXISTS (SELECT 1 FROM `reference_loot_template` r WHERE r.`Entry` = s.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` t WHERE t.`Entry` = s.`Entry` AND t.`ItemType` = 1 AND t.`Item` = s.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_loot_template' AND r.`k1` = s.`Entry` AND r.`k2` = 1 AND r.`k3` = s.`Item`);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`Entry`, 1, s.`Item`, 0.5, 0, 1, 0, 1, 1, 'Craftsman''s Writ world drop (INFERRED)' FROM `everlake_writ_loot` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'creature_loot_template', s.`Entry`, 1, s.`Item`, '2026_11_19_982_world_everlake_writ_drops.sql', 'writ world drop: tier by level, 0.5% INFERRED' FROM `everlake_writ_loot` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_writ_loot`;

COMMIT;
