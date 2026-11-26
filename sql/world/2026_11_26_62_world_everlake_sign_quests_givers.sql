-- Givers and takers for the crafting-sign quests at the Great Forge and in Orgrimmar (2026-11-26):
--   95817 Rotgath Stonebeard ("Meet Rotgath Stonebeard near the Great Forge in Ironforge"),
--   95818 A Quick Craft ("Bring the requested materials to Rotgath Stonebeard near the Great Forge in Ironforge"),
--   95821 A Quick Craft ("Bring the requested materials to Karolek in the Kodohide Leatherworkers shop in Orgrimmar").
-- 2026_11_26_62_world_everlake_sign_quests_givers.sql: written by hand, not tried in game.
--
-- Sources: the quests' own texts (Icy Veins / NorgannonDB objectives above) and the realm's quest chain on the PTR:
--   Alliance: 95816 Sign Me Up! is taken by Elaine Compton (256391, Contract Coordinator) and names 95817 as its
--     RewardNextQuest; 95817 names 95818 as its RewardNextQuest; quest_template_addon has 95817 after 95816 and 95818
--     after 95817.
--   Horde, the same chain: Jornah (256388) takes 95819 and gives 95820 (RewardNextQuest 95820), Karolek (3365) takes
--     95820 and 95821; 95820 names 95821 as its RewardNextQuest, but nobody gave 95821.
-- So, as the Horde chain already does, the NPC who takes a quest gives the next one:
--   Elaine Compton (256391) gives 95817; Rotgath Stonebeard (10276, Expert Blacksmith, Ironforge) takes 95817, gives
--   95818 and takes it; Karolek (3365) gives 95821. INFERRED from the chain: no source records the givers (Icy Veins
--   and Forever Changes have no giver rows for these quests). The core offers RewardNextQuest only from an NPC that
--   starts it, hence the starter rows. Rotgath gets the quest-giver flag.
-- Rows are only added where missing. Never edit this file once it is deployed: a later fix is a new file. Running it
-- again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_26_62_world_everlake_sign_quests_givers.sql';

START TRANSACTION;

INSERT INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`)
SELECT s.`id`, s.`quest`, 0 FROM (
  SELECT 256391 AS `id`, 95817 AS `quest`
  UNION ALL SELECT 10276, 95818
  UNION ALL SELECT 3365, 95821
) s
WHERE EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`)
  AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`)
  AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` x WHERE x.`quest` = s.`quest`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_queststarter', x.`id`, x.`quest`, 0, 0, @EVERLAKE_FILE, 'INFERRED from RewardNextQuest chain 95816-95818 / 95819-95821'
FROM `creature_queststarter` x WHERE (x.`id`, x.`quest`) IN ((256391, 95817), (10276, 95818), (3365, 95821));

INSERT INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`)
SELECT s.`id`, s.`quest`, 0 FROM (
  SELECT 10276 AS `id`, 95817 AS `quest`
  UNION ALL SELECT 10276, 95818
) s
WHERE EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = s.`id`)
  AND EXISTS (SELECT 1 FROM `quest_template` q WHERE q.`ID` = s.`quest`)
  AND NOT EXISTS (SELECT 1 FROM `creature_questender` x WHERE x.`quest` = s.`quest`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_questender', x.`id`, x.`quest`, 0, 0, @EVERLAKE_FILE, 'quest text: Rotgath Stonebeard near the Great Forge'
FROM `creature_questender` x WHERE (x.`id`, x.`quest`) IN ((10276, 95817), (10276, 95818));

UPDATE `creature_template` SET `npcflag` = `npcflag` | 2
WHERE `entry` = 10276 AND (`npcflag` & 2) = 0
  AND EXISTS (SELECT 1 FROM `creature_queststarter` x WHERE x.`id` = 10276);

COMMIT;
