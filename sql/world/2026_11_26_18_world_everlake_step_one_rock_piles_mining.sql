-- Riverglades: the Rock Piles of "Step One: Rock" (649094, quest 95183) are found with Find Minerals and only count as
-- quest objects.
-- 2026_11_26_18_world_everlake_step_one_rock_piles_mining.sql: written by hand from the tracker's kept facts (2026-11-26).
--
-- Blizzard's server-side note of 17 November 2026 (step 70959+1): "Quest "Step One: Rock" rockpiles will now be
-- tracked via Find Minerals (was Find Treasure) while on the quest." EG Link's object records of Rock Pile 649094: lock
-- 57 at client build 70938, lock 43 from 70959 on (70959 and 71037), and from 70959 the record lists the quest item
-- 271892 (the quest's objective). The realm still has lock 57 and no gameobject_questitem row. Here:
--   - Data0 (the chest's lock) 57 -> 43, only while it is still 57;
--   - gameobject_questitem 649094 / 0 / 271892, so the core treats the pile as a quest object (it lights up only for
--     players who need the rock).
--
-- The added row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing. Not checked in game.

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
UPDATE `gameobject_template` SET `Data0` = 43 WHERE `entry` = 649094 AND `type` = 3 AND `Data0` = 57;
SET @MISSING := (SELECT COUNT(*) = 0 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 649094)
    AND (SELECT COUNT(*) FROM `gameobject_template` WHERE `entry` = 649094) = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`) SELECT 649094, 0, 271892, 70959 FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`)
SELECT 'gameobject_questitem', 649094, 0, '2026_11_26_18_world_everlake_step_one_rock_piles_mining.sql', 'EG Link object record 70959/71037 (questItems); note 70959+1 2026-11-17' FROM DUAL WHERE @MISSING;
COMMIT;
