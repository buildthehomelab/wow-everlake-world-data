-- Slaghide Gauntlets (13258) on Urok Doomhowl (10584), Upper Blackrock Spire. The tracker lists the gauntlets as
-- Incomplete ("No source"): Urok's loot table on the realm lacks them.
-- 2026_11_21_97_world_everlake_urok_slaghide_gauntlets.sql: written by hand from the tracker's kept facts (2026-11-21).
--
-- ForeverDB.net (players' addon recordings of live WoW Forever, GPL-3.0, "Data from ForeverDB.net"; snapshot
-- 2026-11-21.a7dd88fb) records Urok dropping them at 25%; Urok dropped them in the original game too. Urok is summoned by
-- the Challenge to Urok script (classic_go_urok_challenge), not spawned. Added to his own loot id only while missing and
-- recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it
-- again changes nothing. Not checked in game.

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
SET @EVERLAKE_FILE := '2026_11_21_97_world_everlake_urok_slaghide_gauntlets.sql';
START TRANSACTION;

SET @EVERLAKE_LID := (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 10584 AND `DifficultyID` = 0 AND `LootID` > 0);
SET @EVERLAKE_LI := @EVERLAKE_LID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `creature_loot_template` WHERE `Entry` = @EVERLAKE_LID AND `ItemType` = 0 AND `Item` = 13258);
INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT @EVERLAKE_LID, 0, 13258, 25, 0, 1, 0, 1, 1, 'Urok Doomhowl: Slaghide Gauntlets (foreverdb)' FROM DUAL WHERE @EVERLAKE_LI = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature_loot_template', @EVERLAKE_LID, 0, 13258, 0, @EVERLAKE_FILE, 'foreverdb 2026-11-21: 10584 drops 13258 at 25%' FROM DUAL WHERE @EVERLAKE_LI = 1;

COMMIT;
