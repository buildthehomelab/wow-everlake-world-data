-- Givers and takers for live WoW Forever dungeon quests the realm had none for (tracker quest gaps, 2026-11-26).
-- 2026_11_26_50_world_everlake_dungeon_quest_givers.sql: written by hand, not tried in game.
--
--   96087 In Demand - Plague Records: Pix Xizzix (227853, Booty Bay) starts and ends it. Icy Veins' objective text
--     names him ("bring them to Pix Xizzix in Booty Bay"); its three siblings 96075, 96076 and 96088 ("In Demand - ...")
--     already start and end at 227853 on the realm. The three records already drop from Gandling, Rivendare and
--     Balnazzar on the realm.
--   96337 More Valuable Than Gold: Mason Connery (264770, inside Alcaz Prison) starts it. Its text is his ("I told you
--     that I'd make it worth your while to free me ... Take this"), Icy Veins and Wowhead say Mason's Note (274077) is
--     the provided item, and the quest's end, Connery's Trunk (611086), and the Loose Floorboard (653847) are already
--     spawned in Moonbrook. This makes the Document Box (274041) obtainable, so 96376, 96377 and 96379 (State Secrets,
--     which ask for it) can be done again.
--   95454 The Honor of the Kor'kron: Commander Folkar (260386, inside Alcaz Prison) starts it. Its text is his (Icy
--     Veins: "My good axe arm is broken ... I will wait for you here while you search for him."). INFERRED from that
--     text: no source lists a giver.
--   96369 Bad News for Folkar: Commander Folkar (260386) ends it. Objective "Report back to Commander Folkar." and Icy
--     Veins' completion text "So Wrynn is dead then..." name him.
--   98830 The Broken Glaive: the Shen'dralar Ancient (14358, Dire Maul) ends it: "Deliver Tortheldrin's Broken Glaive
--     to the Shen'dralar Ancient in Dire Maul." (Icy Veins, Wowhead). Who starts it is not in any source: its text is
--     read at Prince Tortheldrin's corpse, so it needs the core (not done here).
--
-- Not done here (no source has the object): 95262 and 95454 end at, and 95263 and 96369 start from, a note that live
-- puts on the ground when Blazeroar (255702, C++ script classic_boss_alcaz_prison) dies; its gameobject id is not in
-- any source the tracker has, nor on the realm.
--
-- Rows are only added where none exist, each recorded in everlake_import_rows. Never edit this file once it is
-- deployed: a later fix is a new file. Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_26_50_world_everlake_dungeon_quest_givers.sql';

START TRANSACTION;

-- quest givers
DROP TEMPORARY TABLE IF EXISTS `everlake_qg_stage`;
CREATE TEMPORARY TABLE `everlake_qg_stage` (`n` int NOT NULL PRIMARY KEY, `id` int unsigned NOT NULL, `quest` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT 0);
INSERT INTO `everlake_qg_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 227853, 96087, 'Icy Veins objective text names Pix Xizzix; siblings 96075/96076/96088 start at 227853'),
(2, 264770, 96337, 'quest text is Mason Connery''s; Icy Veins + Wowhead: Mason''s Note 274077 provided'),
(3, 260386, 95454, 'INFERRED: Icy Veins quest text is Commander Folkar''s');
UPDATE `everlake_qg_stage` s SET s.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `creature_queststarter` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`)
  AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`)
  AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_qg_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_qg_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_queststarter', s.`id`, s.`quest`, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_qg_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_qg_stage`;

-- quest takers
DROP TEMPORARY TABLE IF EXISTS `everlake_qe_stage`;
CREATE TEMPORARY TABLE `everlake_qe_stage` (`n` int NOT NULL PRIMARY KEY, `id` int unsigned NOT NULL, `quest` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT 0);
INSERT INTO `everlake_qe_stage` (`n`, `id`, `quest`, `note`) VALUES
(1, 227853, 96087, 'Icy Veins objective text names Pix Xizzix; siblings 96075/96076/96088 end at 227853'),
(2, 260386, 96369, 'objective "Report back to Commander Folkar."; Icy Veins completion text'),
(3, 14358, 98830, 'objective "Deliver ... to the Shen''dralar Ancient in Dire Maul." (Icy Veins, Wowhead)');
UPDATE `everlake_qe_stage` s SET s.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `creature_questender` t WHERE t.`id` = s.`id` AND t.`quest` = s.`quest`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'creature_questender' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`)
  AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`)
  AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`);
INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) SELECT s.`id`, s.`quest`, 0 FROM `everlake_qe_stage` s WHERE s.`missing` = 1 ORDER BY s.`n`;
UPDATE `creature_template` c JOIN `everlake_qe_stage` s ON s.`id` = c.`entry` SET c.`npcflag` = c.`npcflag` | 2 WHERE s.`missing` = 1 AND (c.`npcflag` & 2) = 0;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questender', s.`id`, s.`quest`, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_qe_stage` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_qe_stage`;

COMMIT;
