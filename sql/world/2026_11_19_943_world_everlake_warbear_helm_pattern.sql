-- Eldreth Seether drops Pattern: Warbear Helm again.
-- 2026_11_19_943_world_everlake_warbear_helm_pattern.sql: written by hand.
--
-- Pattern: Warbear Helm (252894) is new in WoW Forever and teaches Warbear Helm (spell 1255013, item 252485). Nothing
-- on the realm gives it, so neither the pattern nor the helm can be had. Wowhead Forever's item page names one source:
-- Eldreth Seether (11469, Dire Maul), 3 drops in 29 kills (2026-11-19). The chance is that count, 10.34%. The creature
-- is spawned and already has a loot table (loot id 11469); the row is added only while it is missing. Not checked in
-- game.
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added (docs/forever-import.md)';

START TRANSACTION;

SET @EVERLAKE_WBH := (SELECT COUNT(*) > 0 FROM `creature_template_difficulty` WHERE `Entry` = 11469 AND `LootID` = 11469)
  AND (SELECT COUNT(*) = 0 FROM `creature_loot_template` WHERE `Entry` = 11469 AND `ItemType` = 0 AND `Item` = 252894);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 11469, 0, 252894, 10.34, 0, 1, 0, 1, 1, 'Eldreth Seether: wowhead 3/29' FROM DUAL WHERE @EVERLAKE_WBH = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', 11469, 0, 252894, 0, '2026_11_19_943_world_everlake_warbear_helm_pattern.sql', 'wowhead item=252894 dropped-by 3/29 (2026-11-19)' FROM DUAL WHERE @EVERLAKE_WBH = 1;

COMMIT;
