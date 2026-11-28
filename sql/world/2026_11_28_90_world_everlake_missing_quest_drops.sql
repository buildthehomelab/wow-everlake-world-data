-- Creatures that drop a quest item on live but not on the realm.
-- 2026_11_28_90_world_everlake_missing_quest_drops.sql: written by hand, not tried in game (2026-11-28).
--
-- Checked: every quest item (Questie's Forever item data, class 12 or a realm quest objective) and every quest-class
-- item on Wowhead Forever's drop tabs, for each spawned creature, against that creature's loot on the PTR (its LootID
-- table and the reference tables it points to). Questie's droppers are all in place but Nethergarde's, which
-- 2026_11_28_60 links. Wowhead lists 821 more pairs; most are strays (a Tough Wolf Meat in 10,000 boar kills),
-- pickpocketed Heavy Junkboxes, Darkmoon cards, world drops on dungeon bosses, items the realm gives from an object,
-- pickpocketing or skinning (Patch of Tainted Skin, Rocket Car Parts, Silixiz's Tower Key, Of Love and Family) and Alterac
-- Valley's commander drops, whose two sides Wowhead mixes. Left: 13 creatures that clearly drop the item on live.
--   Forever creatures without the drop their kin have: Eastgrotto Gorilla 262299 and Silverback 262301 (Gorilla Fang;
--   262300 has it), Sootfur 258522 (Soft Bushy Tail), Mountain Squallclimber 249491 (Vibrant Plume; 249220-249223 have
--   it), Brinescale Skirmisher 262397 (none of the 15 Green Hills of Stranglethorn pages Stranglethorn's other mobs drop) and
--   Mazzogore 252457 (Scrap of Horde Heraldry; its table comes from 2026_11_28_60, so this row waits for that file).
--   Classic creatures: Simone the Inconspicuous 14527 (Un'Goro Soil), Akubar the Seer 8298 (Imperfect Draenethyst
--   Fragment, 8 of 8 kills), Primal Ooze 6557 (Merged Ooze Sample), Southsea Kidnapper 15685, Chief Ukorz Sandscalp 7267,
--   Witch Doctor Zum'rah 7271 and Antu'sul 8127 (OOX-17/TN Distress Beacon), Ysondre 14887 (A Torn Letter, which starts
--   Letter from the Front and has no source at all on the realm).
-- Chance = Wowhead Forever drops / kills, which is what the realm's other rows for these items show (Gorilla Fang 40.55
-- on 1557, live 41.8%). QuestRequired follows the item's other rows. Items seen once, and creatures with three kills or
-- fewer, are left out.
-- Rows only go into a creature's own table (LootID = its entry, used by no other creature) and only while the item is not
-- there. Every added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a
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
SET @EVERLAKE_FILE := '2026_11_28_90_world_everlake_missing_quest_drops.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_qdrop`;
CREATE TEMPORARY TABLE `everlake_qdrop` (`entry` INT UNSIGNED NOT NULL, `item` INT UNSIGNED NOT NULL, `chance` FLOAT NOT NULL,
  `quest` TINYINT NOT NULL, `note` VARCHAR(120) NOT NULL, PRIMARY KEY (`entry`, `item`));
INSERT INTO `everlake_qdrop` VALUES
(262299,2799,13.983,1,'Gorilla Fang: Wowhead Forever 33/236'),
(262301,2799,11.765,1,'Gorilla Fang: Wowhead Forever 18/153'),
(258522,4582,16.147,0,'Soft Bushy Tail: Wowhead Forever 88/545'),
(249491,5117,5.576,1,'Vibrant Plume: Wowhead Forever 31/556'),
(14527,11018,39.195,0,'Un''Goro Soil: Wowhead Forever 185/472'),
(8298,10593,100,0,'Imperfect Draenethyst Fragment: Wowhead Forever 8/8'),
(15685,8623,0.606,0,'OOX-17/TN Distress Beacon: Wowhead Forever 21/3463'),
(7267,8623,0.258,0,'OOX-17/TN Distress Beacon: Wowhead Forever 3/1162'),
(7271,8623,0.416,0,'OOX-17/TN Distress Beacon: Wowhead Forever 4/962'),
(8127,8623,0.305,0,'OOX-17/TN Distress Beacon: Wowhead Forever 3/984'),
(6557,12291,2.041,1,'Merged Ooze Sample: Wowhead Forever 36/1764'),
(14887,22932,2.558,0,'A Torn Letter: Wowhead Forever 11/430'),
(252457,274949,1.376,1,'Scrap of Horde Heraldry: Wowhead Forever 3/218'),
(262397,2725,0.601,0,'Green Hills of Stranglethorn - Page 1: Wowhead Forever 91/15148'),
(262397,2728,0.687,0,'Green Hills of Stranglethorn - Page 4: Wowhead Forever 104/15148'),
(262397,2730,0.673,0,'Green Hills of Stranglethorn - Page 6: Wowhead Forever 102/15148'),
(262397,2732,0.726,0,'Green Hills of Stranglethorn - Page 8: Wowhead Forever 110/15148'),
(262397,2734,0.66,0,'Green Hills of Stranglethorn - Page 10: Wowhead Forever 100/15148'),
(262397,2735,0.528,0,'Green Hills of Stranglethorn - Page 11: Wowhead Forever 80/15148'),
(262397,2738,0.733,0,'Green Hills of Stranglethorn - Page 14: Wowhead Forever 111/15148'),
(262397,2740,0.588,0,'Green Hills of Stranglethorn - Page 16: Wowhead Forever 89/15148'),
(262397,2742,0.607,0,'Green Hills of Stranglethorn - Page 18: Wowhead Forever 92/15148'),
(262397,2744,0.687,0,'Green Hills of Stranglethorn - Page 20: Wowhead Forever 104/15148'),
(262397,2745,0.766,0,'Green Hills of Stranglethorn - Page 21: Wowhead Forever 116/15148'),
(262397,2748,0.654,0,'Green Hills of Stranglethorn - Page 24: Wowhead Forever 99/15148'),
(262397,2749,0.667,0,'Green Hills of Stranglethorn - Page 25: Wowhead Forever 101/15148'),
(262397,2750,0.739,0,'Green Hills of Stranglethorn - Page 26: Wowhead Forever 112/15148'),
(262397,2751,0.594,0,'Green Hills of Stranglethorn - Page 27: Wowhead Forever 90/15148');

-- only into the creature's own table, used by no other creature, while the item is not in it
DROP TEMPORARY TABLE IF EXISTS `everlake_qdrop_ok`;
CREATE TEMPORARY TABLE `everlake_qdrop_ok` (`entry` INT UNSIGNED NOT NULL, `item` INT UNSIGNED NOT NULL, PRIMARY KEY (`entry`, `item`));
INSERT INTO `everlake_qdrop_ok` (`entry`, `item`)
SELECT q.`entry`, q.`item` FROM `everlake_qdrop` q
WHERE EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`Entry` = q.`entry` AND d.`DifficultyID` = 0 AND d.`LootID` = q.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`LootID` = q.`entry` AND d.`Entry` <> q.`entry`)
  AND EXISTS (SELECT 1 FROM `creature_loot_template` l WHERE l.`Entry` = q.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` l WHERE l.`Entry` = q.`entry` AND l.`ItemType` = 0 AND l.`Item` = q.`item`);

INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT q.`entry`, 0, q.`item`, q.`chance`, q.`quest`, 1, 0, 1, 1, LEFT(q.`note`, 100)
FROM `everlake_qdrop` q JOIN `everlake_qdrop_ok` o ON o.`entry` = q.`entry` AND o.`item` = q.`item`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', q.`entry`, 0, q.`item`, 0, @EVERLAKE_FILE, q.`note`
FROM `everlake_qdrop` q JOIN `everlake_qdrop_ok` o ON o.`entry` = q.`entry` AND o.`item` = q.`item`;

DROP TEMPORARY TABLE `everlake_qdrop_ok`;
DROP TEMPORARY TABLE `everlake_qdrop`;

COMMIT;
