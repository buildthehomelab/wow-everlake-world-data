-- Vendor wares that cost honor, marks or tokens on live but only gold on the realm.
-- 2026_11_28_97_world_everlake_vendor_costs_on_live.sql: written by hand, not tried in game (2026-11-28).
--
-- Checked: every realm npc_vendor row with ExtendedCost 0 against Wowhead Forever's price for that vendor and item.
-- 139 rows at 12 NPCs cost more than gold on live, so the realm hands them out for their gold price:
--   Aisarra Nightmeadow 264797 (72 pieces, 6 or 8 of item 274030 each), Captain Dirgehammer 12777 (32 Premier PvP
--   pieces), Blazik Fireclaw 30885 (14), Lady Palanseer 12792 (12) (honor plus Warsong Gulch, Arathi Basin or Alterac
--   Valley marks, or item 274895), Fizzlefuse 240654 (2, a 100-for-100 swap), the three Argent quartermasters (Plans:
--   Dawnbringer Shoulders for 15 Necrotic Runes), Warug 5398, Chromie 10667, Kurvelk Shadowhoof 256672 and Dianne
--   Softstep 256742 (15 of currency 3402).
-- Each gets the client's ItemExtendedCost id with exactly that price (ItemExtendedCost.db2: same items, counts and
-- currencies, nothing else); where the client has two identical ids, the one the realm already uses (11583, 11047) or the
-- lower one (10390, 10420). The 60 Premier rows match the ids the realm's other Premier rows use.
-- Also: 46 Premier pieces 2026_11_28_96 left out at Dirgehammer and Blazik Fireclaw (their only realm price was gold)
-- are added here at their live price, as each sells them on live.
-- Rows only change while they still cost gold only and the vendor has no row for the item at that cost; rows only go in
-- while the vendor does not sell the item. Every changed or added row is recorded in everlake_import_rows. Never edit
-- this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_28_97_world_everlake_vendor_costs_on_live.sql';

START TRANSACTION;

-- a) gold-only rows get their live price
DROP TEMPORARY TABLE IF EXISTS `everlake_vcost`;
CREATE TEMPORARY TABLE `everlake_vcost` (`entry` INT UNSIGNED NOT NULL, `item` INT NOT NULL, `ext` INT UNSIGNED NOT NULL, PRIMARY KEY (`entry`, `item`));
INSERT INTO `everlake_vcost` VALUES
(5398,254840,10807),
(10667,184937,10132),
(10856,12844,10123),
(10857,12844,10123),
(11536,12844,10123),
(12777,272716,11583),
(12777,272717,11580),
(12777,272738,11575),
(12777,272739,11578),
(12777,272740,11582),
(12777,272741,11576),
(12777,272828,11579),
(12777,273325,11581),
(12777,274176,11583),
(12777,274177,11580),
(12777,274178,11575),
(12777,274179,11578),
(12777,274180,11582),
(12777,274181,11576),
(12777,274182,11579),
(12777,274192,11583),
(12777,274193,11580),
(12777,274194,11578),
(12777,274195,11582),
(12777,274196,11575),
(12777,274197,11576),
(12777,274214,11581),
(12777,274215,11579),
(12777,274217,11583),
(12777,274218,11575),
(12777,274219,11578),
(12777,274220,11580),
(12777,274221,11582),
(12777,274222,11576),
(12777,274223,11579),
(12777,274224,11581),
(12777,274225,11581),
(12792,272465,11579),
(12792,272467,11580),
(12792,272468,11581),
(12792,272473,11578),
(12792,272474,11575),
(12792,272475,11576),
(12792,272476,11582),
(12792,272608,11583),
(12792,274226,11583),
(12792,274231,11575),
(12792,274246,11575),
(12792,274258,11583),
(30885,272656,11582),
(30885,272669,11575),
(30885,272707,11579),
(30885,272709,11580),
(30885,272731,11582),
(30885,272733,11575),
(30885,272743,11575),
(30885,272834,11579),
(30885,272835,11579),
(30885,272854,11575),
(30885,273368,11580),
(30885,273373,11582),
(30885,273374,11575),
(30885,273377,11580),
(240654,15997,10420),
(240654,18042,10390),
(256672,262896,11047),
(256742,262896,11047),
(264797,273952,11548),
(264797,273953,11549),
(264797,273954,11549),
(264797,273955,11549),
(264797,273956,11548),
(264797,273957,11549),
(264797,273958,11549),
(264797,273959,11549),
(264797,273960,11548),
(264797,273961,11549),
(264797,273962,11549),
(264797,273963,11549),
(264797,273964,11548),
(264797,273965,11549),
(264797,273966,11549),
(264797,273967,11549),
(264797,273968,11548),
(264797,273969,11549),
(264797,273970,11549),
(264797,273971,11549),
(264797,273972,11548),
(264797,273973,11549),
(264797,273974,11549),
(264797,273975,11549),
(264797,273976,11548),
(264797,273977,11549),
(264797,273978,11549),
(264797,273979,11549),
(264797,273980,11548),
(264797,273981,11549),
(264797,273982,11549),
(264797,273983,11549),
(264797,273984,11548),
(264797,273985,11549),
(264797,273986,11549),
(264797,273987,11549),
(264797,273988,11548),
(264797,273989,11549),
(264797,273990,11549),
(264797,273991,11549),
(264797,273992,11548),
(264797,273993,11549),
(264797,273994,11549),
(264797,273995,11549),
(264797,273996,11548),
(264797,273997,11549),
(264797,273998,11549),
(264797,273999,11549),
(264797,274000,11548),
(264797,274001,11549),
(264797,274002,11549),
(264797,274003,11549),
(264797,274004,11548),
(264797,274005,11549),
(264797,274006,11549),
(264797,274007,11549),
(264797,274008,11548),
(264797,274009,11549),
(264797,274010,11549),
(264797,274011,11549),
(264797,274012,11548),
(264797,274013,11549),
(264797,274014,11549),
(264797,274015,11549),
(264797,274016,11548),
(264797,274017,11549),
(264797,274018,11549),
(264797,274019,11549),
(264797,276542,11548),
(264797,276543,11549),
(264797,276544,11549),
(264797,276545,11549);

DROP TEMPORARY TABLE IF EXISTS `everlake_vcost_ok`;
CREATE TEMPORARY TABLE `everlake_vcost_ok` (`entry` INT UNSIGNED NOT NULL, `item` INT NOT NULL, PRIMARY KEY (`entry`, `item`));
INSERT INTO `everlake_vcost_ok` (`entry`, `item`)
SELECT v.`entry`, v.`item` FROM `everlake_vcost` v
WHERE EXISTS (SELECT 1 FROM `npc_vendor` n WHERE n.`entry` = v.`entry` AND n.`item` = v.`item` AND n.`type` = 1 AND n.`ExtendedCost` = 0)
  AND NOT EXISTS (SELECT 1 FROM `npc_vendor` n WHERE n.`entry` = v.`entry` AND n.`item` = v.`item` AND n.`type` = 1 AND n.`ExtendedCost` = v.`ext`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'npc_vendor', v.`entry`, v.`item`, v.`ext`, 1, @EVERLAKE_FILE, 'ExtendedCost 0 -> live price (Wowhead Forever, ItemExtendedCost.db2)'
FROM `everlake_vcost` v JOIN `everlake_vcost_ok` o ON o.`entry` = v.`entry` AND o.`item` = v.`item`;
UPDATE `npc_vendor` n
JOIN `everlake_vcost` v ON v.`entry` = n.`entry` AND v.`item` = n.`item`
JOIN `everlake_vcost_ok` o ON o.`entry` = v.`entry` AND o.`item` = v.`item`
SET n.`ExtendedCost` = v.`ext`
WHERE n.`type` = 1 AND n.`ExtendedCost` = 0;
DROP TEMPORARY TABLE `everlake_vcost_ok`;
DROP TEMPORARY TABLE `everlake_vcost`;

-- b) Premier pieces Dirgehammer and Blazik Fireclaw sell on live, at their live price
DROP TEMPORARY TABLE IF EXISTS `everlake_vadd`;
CREATE TEMPORARY TABLE `everlake_vadd` (`entry` INT UNSIGNED NOT NULL, `slot` SMALLINT NOT NULL, `item` INT NOT NULL, `ext` INT UNSIGNED NOT NULL, PRIMARY KEY (`entry`, `item`));
INSERT INTO `everlake_vadd` VALUES
(12777,356,272656,11582),
(12777,357,272669,11575),
(12777,358,272707,11579),
(12777,359,272709,11580),
(12777,360,272731,11582),
(12777,361,272733,11575),
(12777,362,272743,11575),
(12777,363,272834,11579),
(12777,364,272835,11579),
(12777,365,272854,11575),
(12777,366,273368,11580),
(12777,367,273373,11582),
(12777,368,273374,11575),
(12777,369,273377,11580),
(30885,17,272716,11583),
(30885,18,272717,11580),
(30885,19,272738,11575),
(30885,20,272739,11578),
(30885,21,272740,11582),
(30885,22,272741,11576),
(30885,23,272828,11579),
(30885,24,273325,11581),
(30885,25,274176,11583),
(30885,26,274177,11580),
(30885,27,274178,11575),
(30885,28,274179,11578),
(30885,29,274180,11582),
(30885,30,274181,11576),
(30885,31,274182,11579),
(30885,32,274192,11583),
(30885,33,274193,11580),
(30885,34,274194,11578),
(30885,35,274195,11582),
(30885,36,274196,11575),
(30885,37,274197,11576),
(30885,38,274214,11581),
(30885,39,274215,11579),
(30885,40,274217,11583),
(30885,41,274218,11575),
(30885,42,274219,11578),
(30885,43,274220,11580),
(30885,44,274221,11582),
(30885,45,274222,11576),
(30885,46,274223,11579),
(30885,47,274224,11581),
(30885,48,274225,11581);

DROP TEMPORARY TABLE IF EXISTS `everlake_vadd_ok`;
CREATE TEMPORARY TABLE `everlake_vadd_ok` (`entry` INT UNSIGNED NOT NULL, `item` INT NOT NULL, PRIMARY KEY (`entry`, `item`));
INSERT INTO `everlake_vadd_ok` (`entry`, `item`)
SELECT v.`entry`, v.`item` FROM `everlake_vadd` v
WHERE NOT EXISTS (SELECT 1 FROM `npc_vendor` n WHERE n.`entry` = v.`entry` AND n.`item` = v.`item` AND n.`type` = 1);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`)
SELECT v.`entry`, v.`slot`, v.`item`, 0, 0, v.`ext`, 1, '', 0, 0, 0
FROM `everlake_vadd` v JOIN `everlake_vadd_ok` o ON o.`entry` = v.`entry` AND o.`item` = v.`item`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'npc_vendor', v.`entry`, v.`item`, v.`ext`, 1, @EVERLAKE_FILE, 'Wowhead Forever: sold on live at this price'
FROM `everlake_vadd` v JOIN `everlake_vadd_ok` o ON o.`entry` = v.`entry` AND o.`item` = v.`item`;
DROP TEMPORARY TABLE `everlake_vadd_ok`;
DROP TEMPORARY TABLE `everlake_vadd`;

COMMIT;
