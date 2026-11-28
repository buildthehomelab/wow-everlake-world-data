-- The Unfinished Masterwork Sword chest (613223, map 1) opens on its sword.
-- 2026_11_29_30_world_everlake_unfinished_masterwork_sword.sql: written by hand, not tried in game.
--
-- The realm spawns the chest (type 3) but its loot id (Data1) is 0 and it has no loot, so opening it gives nothing.
-- What the sources give:
--   - Wowhead Forever: object 613223 contains item 258734 Unfinished Masterwork Sword; the item's page shows it
--     contained in 613223 in 237 of 237 opens.
--   - Icy Veins: players' addons record the sword gathered from object 613223 on live; it is the quest item of
--     "Phantasmal Problems" (93450, Vindael 254717).
-- The chest gets loot 613223 -> 258734 at 100% (quest item: QuestRequired 1), and Data1 becomes the entry, only while
-- Data1 is still 0 and the loot is this file's. The quest's objective, 258735, is a second item nothing in the
-- client creates: that step is not in here.
--
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_29_30_world_everlake_unfinished_masterwork_sword.sql';

START TRANSACTION;

-- the loot row goes in while the chest exists with no loot of its own and the row is not there yet
SET @add := (SELECT COUNT(*) FROM `gameobject_template` t WHERE t.`entry` = 613223 AND t.`type` = 3 AND t.`Data1` = 0)
  AND NOT EXISTS (SELECT 1 FROM `gameobject_loot_template` l WHERE l.`Entry` = 613223);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 613223, 0, 258734, 100, 1, 1, 0, 1, 1, 'Unfinished Masterwork Sword (Wowhead Forever 237/237)' FROM DUAL WHERE @add;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 613223, 0, 258734, 0, @EVERLAKE_FILE, 'Wowhead Forever contains 237/237; Icy Veins addons gathered from 613223' FROM DUAL WHERE @add;

UPDATE `gameobject_template` t
SET t.`Data1` = t.`entry`
WHERE t.`entry` = 613223 AND t.`type` = 3 AND t.`Data1` = 0
  AND EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject_loot_template' AND r.`k1` = 613223 AND r.`k2` = 0 AND r.`k3` = 258734);

COMMIT;
