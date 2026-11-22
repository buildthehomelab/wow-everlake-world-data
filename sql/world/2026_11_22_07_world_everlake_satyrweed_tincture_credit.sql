-- Transmuted Tincture (86812): using the Satyrweed Tincture on a Mosshoof Courser or a Thunderhead Skystormer now counts.
-- 2026_11_22_07_world_everlake_satyrweed_tincture_credit.sql: written by hand.
--
-- The quest asks for 3 "Satyrweed Tincture tested" (credit marker 236987). The Satyrweed Tincture (item 235509) casts
-- 1217130, which removes Satyr Corruption (1217128) from its target and does nothing else. The credit comes from spell
-- 1217127 ([DNT] Satyrweed Tincture Quest Dummy: kill credit 236987 on its caster), which no item, object or spell in
-- the client data casts: on live a server script does it. Here the two creatures' SmartAI does: when the Tincture hits
-- them (SPELLHIT 1217130), the player who used it casts 1217127 on themselves (SELF_CAST, triggered).
-- Sources: the client's SpellEffect and ItemEffect (spells 1217127, 1217128, 1217130; item 235509), the quest's own text
-- ("Use the Satyrweed Tincture on Mosshoof Coursers or Thunderhead Skystormers after weakening them"). The "after
-- weakening them" health condition is not scripted (INFERRED: the quest text only).
-- Both creatures already use SmartAI (VMaNGOS EventAI rows 0 and 1); the new rows are id 20. Each added row is recorded
-- in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing. Not tried in game.
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
SET @EVERLAKE_FILE := '2026_11_22_07_world_everlake_satyrweed_tincture_credit.sql';
START TRANSACTION;
CREATE TEMPORARY TABLE `everlake_tincture` (`entry` INT UNSIGNED NOT NULL PRIMARY KEY, `name` VARCHAR(64) NOT NULL);
INSERT INTO `everlake_tincture` (`entry`, `name`) VALUES (8761, 'Mosshoof Courser'), (6378, 'Thunderhead Skystormer');
DELETE t FROM `everlake_tincture` t WHERE NOT EXISTS (SELECT 1 FROM `creature_template` c WHERE c.`entry` = t.`entry`)
  OR EXISTS (SELECT 1 FROM `smart_scripts` s WHERE s.`entryorguid` = t.`entry` AND s.`source_type` = 0 AND s.`id` = 20);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`,
  `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`,
  `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`,
  `action_param_string`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_param_string`,
  `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT t.`entry`, 0, 20, 0, '', 8, 0, 100, 0, 1217130, 0, 0, 0, 0, '', 85, 1217127, 2, 0, 0, 0, 0, 0, NULL, 7, 0, 0, 0, 0, NULL,
  0, 0, 0, 0, CONCAT(t.`name`, ' - On Spellhit Satyrweed Tincture - Invoker casts 1217127 (Transmuted Tincture credit)')
FROM `everlake_tincture` t;
UPDATE `creature_template` c JOIN `everlake_tincture` t ON t.`entry` = c.`entry` SET c.`AIName` = 'SmartAI' WHERE c.`AIName` = '';
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', t.`entry`, 0, 20, 0, @EVERLAKE_FILE, 'client SpellEffect 1217127/1217130 + quest 86812 text' FROM `everlake_tincture` t;
DROP TEMPORARY TABLE `everlake_tincture`;
COMMIT;
