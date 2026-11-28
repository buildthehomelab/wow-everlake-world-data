-- Quests that a creature gives or takes on live but not on the realm.
-- 2026_11_28_100_world_everlake_missing_quest_givers.sql: written by hand, not tried in game (2026-11-28).
--
-- Checked: every quest on the realm against Wowhead Forever's quest pages (Start / End) and Icy Veins' recorded NPC quest
-- lists (starts / ends), for spawned creatures, against creature_queststarter, game_event_creature_quest and
-- creature_questender. 44 starter and 34 ender pairs are missing. Added here, 32 starters and 7 enders:
--   No starter at all on the realm: Anthion Harmon 16016's thirteen "Anthion's Parting Words" (Dungeon Set 2's last
--   step, one per class), Bath'rah the Windwatcher 6176 (Grant's Shield 79362), Theocritus 313 (Looking Further 248),
--   Captain Stoutfist 2104 (Defeat Nek'rosh 474). No ender: the Sin'dorei Tome of Summoning 247449 (Betrayed 3505).
--   Also given on live by another creature than the realm's: class trainers' quests (Terenthis, Mathrengyl Bearwalker,
--   Turak Runetotem, Alodan the Hopeful, High Priestess Laurena, Austil de Mon, Krang Stonehoof, Tarshaw Jaggedscar,
--   Torm Ragetotem, Baltus Fowler), Frostwolf Quartermaster (Capture a Mine), Rau Cliffrunner, Melithar Staghelm,
--   Sentinel Shayla Nightbreeze, Garion Wendell, Breton Samuels; enders Dunston Willis, Archmage Celindra, Syriel
--   Nightrain and High Priest Rohan (Desperate Prayer). The realm's own giver stays.
-- Left out: the commendation and officer quests 8811-8841 (Wowhead names one of the realm's two givers each), Praise
-- from the Emerald Circle 7741 (disabled, never finished), Goblin Engineering 3629/4181 (live has the two swapped
-- between Lilliam Sparkspindle and Springspindle Fizzlegear; adding both would give each NPC two copies), the
-- Craftsman's Writ 94316 (starts from its item), Nyoma 4265 (no quest-giver flag), Squire Rowe for Stormwind
-- Rendezvous 6402 (his C++ gossip shows no quest list; the realm ends it at Marshal Windsor).
-- Rows only go in while the creature exists and the quest is on the realm. Every added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
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
SET @EVERLAKE_FILE := '2026_11_28_100_world_everlake_missing_quest_givers.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_qgive`;
CREATE TEMPORARY TABLE `everlake_qgive` (`kind` CHAR(1) NOT NULL, `npc` INT UNSIGNED NOT NULL, `quest` INT UNSIGNED NOT NULL,
  `src` VARCHAR(20) NOT NULL, `ok` TINYINT NOT NULL DEFAULT 0, PRIMARY KEY (`kind`, `npc`, `quest`));
INSERT INTO `everlake_qgive` (`kind`, `npc`, `quest`, `src`) VALUES
('s',3693,6072,'Wowhead'),('s',4217,6121,'Wowhead, Icy Veins'),('s',3033,6126,'Wowhead, Icy Veins'),
('s',12097,7124,'Wowhead'),('s',16016,8951,'Wowhead'),('s',16016,8953,'Wowhead'),('s',16016,8954,'Wowhead'),
('s',16016,8956,'Wowhead'),('s',16016,8957,'Wowhead'),('s',16016,8958,'Wowhead'),('s',16016,8959,'Wowhead'),
('s',16016,9016,'Wowhead'),('s',16016,9017,'Wowhead'),('s',16016,9018,'Wowhead'),('s',16016,9019,'Wowhead'),
('s',16016,9020,'Wowhead'),('s',16016,9022,'Wowhead'),('s',4722,79360,'Wowhead'),('s',6176,79362,'Wowhead'),
('s',246344,97174,'Wowhead, Icy Veins'),('s',313,248,'Icy Veins'),('s',376,5631,'Icy Veins'),('s',2077,920,'Icy Veins'),
('s',2104,474,'Icy Veins'),('s',2131,1823,'Icy Veins'),('s',2155,489,'Icy Veins'),('s',3041,1505,'Icy Veins'),
('s',3063,1823,'Icy Veins'),('s',3169,1823,'Icy Veins'),('s',4595,1818,'Icy Veins'),('s',211033,79094,'Icy Veins'),
('s',246349,91282,'Icy Veins'),
('e',247449,3505,'Wowhead, Icy Veins'),('e',259057,96125,'Wowhead, Icy Veins'),('e',252085,97287,'Wowhead'),
('e',254345,97968,'Wowhead, Icy Veins'),('e',11406,5634,'Icy Veins'),('e',11406,5637,'Icy Veins'),('e',11406,5639,'Icy Veins');

UPDATE `everlake_qgive` g SET g.`ok` = 1
WHERE EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = g.`npc`)
  AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = g.`quest`)
  AND ((g.`kind` = 's' AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.`id` = g.`npc` AND s.`quest` = g.`quest`))
    OR (g.`kind` = 'e' AND NOT EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.`id` = g.`npc` AND e.`quest` = g.`quest`)));

INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`)
SELECT g.`npc`, g.`quest`, 0 FROM `everlake_qgive` g WHERE g.`ok` = 1 AND g.`kind` = 's';
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`)
SELECT g.`npc`, g.`quest`, 0 FROM `everlake_qgive` g WHERE g.`ok` = 1 AND g.`kind` = 'e';
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT IF(g.`kind` = 's', 'creature_queststarter', 'creature_questender'), g.`npc`, g.`quest`, 0, 0, @EVERLAKE_FILE,
       CONCAT('live ', IF(g.`kind` = 's', 'giver', 'ender'), ': ', g.`src`)
FROM `everlake_qgive` g WHERE g.`ok` = 1;
DROP TEMPORARY TABLE `everlake_qgive`;

COMMIT;
