-- 2026_11_28_01_world_everlake_mor_grayhoof_formula.sql: Mor Grayhoof (16080, the Tier 0.5 druid summon in Upper
-- Blackrock Spire) drops Formula: Frozen Heart of the Mountain (249519), as Wowhead's Forever database has it (17.98%
-- of kills) and QuestieDB and the Icy Veins WoW Forever catalogue agree. The realm's loot table lacked it, so nothing
-- gave the formula. Written by hand from the tracker's kept facts (2026-11-28).
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
SET @EVERLAKE_FILE := '2026_11_28_01_world_everlake_mor_grayhoof_formula.sql';
SET @EVERLAKE_LOOT := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 16080 AND `DifficultyID` = 0 AND `LootID` > 0);
START TRANSACTION;
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LOOT, 0, 249519, 17.98, 0, 1, 0, 1, 1, 'Mor Grayhoof: Formula: Frozen Heart of the Mountain' FROM DUAL
WHERE @EVERLAKE_LOOT IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LOOT AND `ItemType` = 0 AND `Item` = 249519)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_loot_template' AND `k1` = @EVERLAKE_LOOT AND `k2` = 0 AND `k3` = 249519);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', @EVERLAKE_LOOT, 0, 249519, 0, @EVERLAKE_FILE, 'Wowhead Forever: 16080 drops 249519 at 17.98%; QuestieDB, Icy Veins agree'
FROM DUAL WHERE EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LOOT AND `ItemType` = 0 AND `Item` = 249519 AND `Comment` = 'Mor Grayhoof: Formula: Frozen Heart of the Mountain');
COMMIT;
