-- WoW Forever's tier 1 sets in Molten Core: each Classic tier 1 piece in the realm's loot is swapped for its Forever copy.
-- 2026_11_20_35_world_everlake_forever_tier1_molten_core.sql: written by a script, checked by hand.
--
-- Forever's client (ItemSet.db2, sets 2138-2146) has its own copies of the nine Classic tier 1 sets, items 288823-288894,
-- one for one with Classic 16795-16868: the same name, slot and class in the same set. Forever's client blanks the
-- Classic pieces ("Item #16802"), so the realm's Molten Core loot gives items the client cannot show.
-- INFERRED, a project decision (2026-11-20): live has no recorded drop of the Forever pieces yet (the only sightings,
-- Mulgore mobs on build 70532, are beta test loot), so each one drops where its Classic piece drops on the realm: same
-- loot row, same chance, same group (bosses through their reference tables 30338-30368 and 30488, bracers and belts from
-- Molten Core trash). When live's real drops are known, a later file corrects the rows this one records.
-- Each swapped row is recorded in everlake_import_rows (k3 = the Forever item, note = the Classic item it replaced).
-- A row is swapped only where its loot table has no row of the Forever piece yet. Never edit this file once it is
-- deployed: a later fix is a new file. Running it again changes nothing. Not tried in game.
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
SET @EVERLAKE_FILE := '2026_11_20_35_world_everlake_forever_tier1_molten_core.sql';
START TRANSACTION;
CREATE TEMPORARY TABLE `everlake_tier1` (`classic` INT UNSIGNED NOT NULL PRIMARY KEY, `forever` INT UNSIGNED NOT NULL, `name` VARCHAR(64) NOT NULL);
INSERT INTO `everlake_tier1` (`classic`, `forever`, `name`) VALUES
(16795, 288823, 'Arcanist Crown'),
(16796, 288824, 'Arcanist Leggings'),
(16797, 288825, 'Arcanist Mantle'),
(16798, 288826, 'Arcanist Robes'),
(16799, 288827, 'Arcanist Bindings'),
(16800, 288828, 'Arcanist Boots'),
(16801, 288829, 'Arcanist Gloves'),
(16802, 288830, 'Arcanist Belt'),
(16803, 288831, 'Felheart Slippers'),
(16804, 288832, 'Felheart Bracers'),
(16805, 288833, 'Felheart Gloves'),
(16806, 288834, 'Felheart Belt'),
(16807, 288835, 'Felheart Shoulder Pads'),
(16808, 288836, 'Felheart Horns'),
(16809, 288837, 'Felheart Robes'),
(16810, 288838, 'Felheart Pants'),
(16811, 288839, 'Boots of Prophecy'),
(16812, 288840, 'Gloves of Prophecy'),
(16813, 288841, 'Circlet of Prophecy'),
(16814, 288842, 'Pants of Prophecy'),
(16815, 288843, 'Robes of Prophecy'),
(16816, 288844, 'Mantle of Prophecy'),
(16817, 288845, 'Girdle of Prophecy'),
(16819, 288846, 'Vambraces of Prophecy'),
(16820, 288847, 'Nightslayer Chestpiece'),
(16821, 288848, 'Nightslayer Cover'),
(16822, 288849, 'Nightslayer Pants'),
(16823, 288850, 'Nightslayer Shoulder Pads'),
(16824, 288851, 'Nightslayer Boots'),
(16825, 288852, 'Nightslayer Bracelets'),
(16826, 288853, 'Nightslayer Gloves'),
(16827, 288854, 'Nightslayer Belt'),
(16828, 288855, 'Cenarion Belt'),
(16829, 288856, 'Cenarion Boots'),
(16830, 288857, 'Cenarion Bracers'),
(16831, 288858, 'Cenarion Gloves'),
(16833, 288859, 'Cenarion Vestments'),
(16834, 288860, 'Cenarion Helm'),
(16835, 288861, 'Cenarion Leggings'),
(16836, 288862, 'Cenarion Spaulders'),
(16837, 288863, 'Earthfury Boots'),
(16838, 288864, 'Earthfury Belt'),
(16839, 288865, 'Earthfury Gauntlets'),
(16840, 288866, 'Earthfury Bracers'),
(16841, 288867, 'Earthfury Vestments'),
(16842, 288868, 'Earthfury Helmet'),
(16843, 288869, 'Earthfury Legguards'),
(16844, 288870, 'Earthfury Epaulets'),
(16845, 288871, 'Giantstalker''s Breastplate'),
(16846, 288872, 'Giantstalker''s Helmet'),
(16847, 288873, 'Giantstalker''s Leggings'),
(16848, 288874, 'Giantstalker''s Epaulets'),
(16849, 288875, 'Giantstalker''s Boots'),
(16850, 288876, 'Giantstalker''s Bracers'),
(16851, 288877, 'Giantstalker''s Belt'),
(16852, 288878, 'Giantstalker''s Gloves'),
(16853, 288879, 'Lawbringer Chestguard'),
(16854, 288880, 'Lawbringer Helm'),
(16855, 288881, 'Lawbringer Legplates'),
(16856, 288882, 'Lawbringer Spaulders'),
(16857, 288883, 'Lawbringer Bracers'),
(16858, 288884, 'Lawbringer Belt'),
(16859, 288885, 'Lawbringer Boots'),
(16860, 288886, 'Lawbringer Gauntlets'),
(16861, 288887, 'Bracers of Might'),
(16862, 288888, 'Sabatons of Might'),
(16863, 288889, 'Gauntlets of Might'),
(16864, 288890, 'Belt of Might'),
(16865, 288891, 'Breastplate of Might'),
(16866, 288892, 'Helm of Might'),
(16867, 288893, 'Legplates of Might'),
(16868, 288894, 'Pauldrons of Might');
-- creature_loot_template.
CREATE TEMPORARY TABLE `everlake_tier1_rows` SELECT l.`Entry`, l.`ItemType`, l.`Item` AS `classic`, m.`forever` FROM `creature_loot_template` l JOIN `everlake_tier1` m ON m.`classic` = l.`Item`
  WHERE l.`ItemType` = 0 AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` x WHERE x.`Entry` = l.`Entry` AND x.`ItemType` = 0 AND x.`Item` = m.`forever`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', s.`Entry`, s.`ItemType`, s.`forever`, 0, @EVERLAKE_FILE, CONCAT('INFERRED: replaced Classic item ', s.`classic`, ' (same chance and group)') FROM `everlake_tier1_rows` s;
UPDATE `creature_loot_template` l JOIN `everlake_tier1_rows` s ON s.`Entry` = l.`Entry` AND s.`ItemType` = l.`ItemType` AND s.`classic` = l.`Item` JOIN `everlake_tier1` m ON m.`classic` = s.`classic`
  SET l.`Item` = s.`forever`, l.`Comment` = CONCAT(m.`name`, ' (Forever tier 1, INFERRED source)');
DROP TEMPORARY TABLE `everlake_tier1_rows`;
-- reference_loot_template.
CREATE TEMPORARY TABLE `everlake_tier1_rows` SELECT l.`Entry`, l.`ItemType`, l.`Item` AS `classic`, m.`forever` FROM `reference_loot_template` l JOIN `everlake_tier1` m ON m.`classic` = l.`Item`
  WHERE l.`ItemType` = 0 AND NOT EXISTS (SELECT 1 FROM `reference_loot_template` x WHERE x.`Entry` = l.`Entry` AND x.`ItemType` = 0 AND x.`Item` = m.`forever`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'reference_loot_template', s.`Entry`, s.`ItemType`, s.`forever`, 0, @EVERLAKE_FILE, CONCAT('INFERRED: replaced Classic item ', s.`classic`, ' (same chance and group)') FROM `everlake_tier1_rows` s;
UPDATE `reference_loot_template` l JOIN `everlake_tier1_rows` s ON s.`Entry` = l.`Entry` AND s.`ItemType` = l.`ItemType` AND s.`classic` = l.`Item` JOIN `everlake_tier1` m ON m.`classic` = s.`classic`
  SET l.`Item` = s.`forever`, l.`Comment` = CONCAT(m.`name`, ' (Forever tier 1, INFERRED source)');
DROP TEMPORARY TABLE `everlake_tier1_rows`;
DROP TEMPORARY TABLE `everlake_tier1`;
COMMIT;
