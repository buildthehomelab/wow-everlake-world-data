-- 2026_11_28_05_world_everlake_jerris_bindings.sql: Foreman Jerris (1843, the Western Plaguelands rare) drops Scarlet
-- Forgemaster's Bindings (284091) on live WoW Forever: Wowhead's Forever database saw it in 2 of 7 kills. The realm's loot
-- table lacked it, so nothing gave the item. 35%, the rate the realm owner chose for new Forever items on Classic rares
-- (2026_11_25_26), close to Wowhead's small sample. Written by hand from the tracker's kept Wowhead page (2026-11-28).
-- The row is recorded in everlake_import_rows. Running it again changes nothing. Never edit this file once it is
-- deployed: a later fix is a new file. Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_28_05_world_everlake_jerris_bindings.sql';
SET @EVERLAKE_LOOT := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 1843 AND `DifficultyID` = 0 AND `LootID` > 0);
START TRANSACTION;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LOOT, 0, 284091, 35, 0, 1, 0, 1, 1, 'Foreman Jerris: Scarlet Forgemaster''s Bindings' FROM DUAL
WHERE @EVERLAKE_LOOT IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LOOT AND `ItemType` = 0 AND `Item` = 284091)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_loot_template' AND `k1` = @EVERLAKE_LOOT AND `k2` = 0 AND `k3` = 284091);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', @EVERLAKE_LOOT, 0, 284091, 0, @EVERLAKE_FILE, 'Wowhead Forever: 1843 drops 284091 (2 of 7 kills); rate 35% as 2026_11_25_26'
FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LOOT AND `ItemType` = 0 AND `Item` = 284091 AND `Comment` = 'Foreman Jerris: Scarlet Forgemaster''s Bindings');
COMMIT;
