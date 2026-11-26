-- Engineering: learning Goblin Mortar (12716) also teaches "The Mortar: Reloaded" (13240).
-- 2026_11_26_15_world_everlake_mortar_reloaded_with_goblin_mortar.sql: written by hand from the tracker's kept facts (2026-11-26).
--
-- Blizzard's server-side note of 23 November 2026 (step 71037+1): "Engineering: Fixed a bug that prevented "The
-- Mortar: Reloaded" recipe from being learned upon learning the "Goblin Mortar" recipe." The tracker's recipe list has
-- Goblin Mortar as spell 12716 and The Mortar: Reloaded as spell 13240 (both create Goblin Mortar 10577). One
-- spell_learn_spell row: whoever learns 12716 learns 13240 with it; players who know 12716 already get 13240 when their
-- spells load at the next login.
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
SET @MISSING := (SELECT COUNT(*) = 0 FROM `spell_learn_spell` WHERE `entry` = 12716 AND `SpellID` = 13240);
INSERT INTO `spell_learn_spell` (`entry`, `SpellID`, `Active`) SELECT 12716, 13240, 1 FROM DUAL WHERE @MISSING;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `file`, `note`)
SELECT 'spell_learn_spell', 12716, 13240, '2026_11_26_15_world_everlake_mortar_reloaded_with_goblin_mortar.sql', 'note 71037+1 2026-11-23; recipe ids from the tracker' FROM DUAL WHERE @MISSING;
COMMIT;
