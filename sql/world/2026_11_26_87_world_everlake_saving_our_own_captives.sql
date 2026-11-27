-- 93058 Saving Our Own (Nerlokh 253177, Shen'dralas): "rescue 5 Gelkis Captives within the Valley of Bones". Its
-- objective counts credit 254825 "Gelkis Captive", which nothing on the realm gives: the captives cannot be freed.
-- 2026_11_26_87_world_everlake_saving_our_own_captives.sql: written by hand, not tried in game (2026-11-26).
--
-- How live does it (sources):
--   Client DB2: 1263364 Break Chain (2 s cast, any range) is a dummy on its target (TARGET_UNIT_TARGET_ANY) with
--     KILL_CREDIT2 254825 on the caster: the player who breaks a captive's chain gets the credit from the spell itself.
--     No item, object or other spell casts it, so live casts it from the captive (a click). The core has no script.
--   Icy Veins (wowf npc 253431): the Gelkis Captive 253431 stands in the Valley of Bones (map 2652 points) and is the
--     objective of 92893 No Mercy for the Weak, the Magram side of the same captives (slay 5). 254825 has the same
--     models but no points: it is only the credit. The realm has 253431 spawned (3 spawns), without AI or click.
--
-- Rows: the captive 253431 gets the spell click flag and a click that makes the player cast Break Chain on it
-- (npc_spellclick_spells, cast_flags 1: the clicker casts on the captive), only while 93058 is in the player's log
-- (condition source 18); when Break Chain hits it, the captive loses its click and despawns after 3 s (it respawns as
-- spawned). INFERRED: live's click is not in any source; Break Chain is the only spell that gives 254825.
-- Rows are only added where the captive has no AI, script or click. Each added row is recorded in everlake_import_rows.
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
SET @EVERLAKE_FILE := '2026_11_26_87_world_everlake_saving_our_own_captives.sql';
SET @EVERLAKE_NOTE := 'client SpellEffect 1263364 (KILL_CREDIT2 254825); Icy Veins npc 253431';

START TRANSACTION;

SET @EVERLAKE_OK := (SELECT COUNT(*) = 1 FROM `creature_template` t WHERE t.`entry` = 253431 AND t.`ScriptName` = '' AND t.`AIName` IN ('', 'SmartAI'))
  AND (SELECT COUNT(*) = 0 FROM `smart_scripts` s WHERE s.`entryorguid` = 253431 AND s.`source_type` = 0)
  AND (SELECT COUNT(*) = 0 FROM `npc_spellclick_spells` k WHERE k.`npc_entry` = 253431);

-- clicking a captive makes the player cast Break Chain on it
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`)
SELECT 253431, 1263364, 1, 0 FROM DUAL WHERE @EVERLAKE_OK = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'npc_spellclick_spells', 253431, 1263364, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE
FROM `npc_spellclick_spells` k WHERE @EVERLAKE_OK = 1 AND k.`npc_entry` = 253431 AND k.`spell_id` = 1263364;

-- only for players with Saving Our Own in their log (not yet complete)
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 18, 253431, 1263364, 0, 0, 9, 0, 93058, 0, 0, '', 0, 0, 0, '', 'Gelkis Captive: Break Chain click only while Saving Our Own (93058) is taken'
FROM DUAL
WHERE @EVERLAKE_OK = 1
  AND NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 18 AND c.`SourceGroup` = 253431 AND c.`SourceEntry` = 1263364);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 18, 253431, 1263364, 0, @EVERLAKE_FILE, 'click condition: quest 93058 taken'
FROM `conditions` c WHERE @EVERLAKE_OK = 1 AND c.`SourceTypeOrReferenceId` = 18 AND c.`SourceGroup` = 253431 AND c.`SourceEntry` = 1263364 AND c.`ConditionValue1` = 93058;

-- freed: no more click, gone after 3 s (respawns as spawned)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 253431, 0, 0, 0, '', 8, 0, 100, 0, 1263364, 0, 0, 0, 0, '', 83, 16777216, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gelkis Captive - On spell hit Break Chain (1263364) - Remove npc flag spellclick (Saving Our Own 93058)'
FROM DUAL WHERE @EVERLAKE_OK = 1
UNION ALL
SELECT 253431, 0, 1, 0, '', 8, 0, 100, 0, 1263364, 0, 0, 0, 0, '', 41, 3000, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gelkis Captive - On spell hit Break Chain (1263364) - Despawn in 3 s (Saving Our Own 93058)'
FROM DUAL WHERE @EVERLAKE_OK = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', 253431, 0, s.`id`, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE
FROM `smart_scripts` s WHERE @EVERLAKE_OK = 1 AND s.`entryorguid` = 253431 AND s.`source_type` = 0 AND s.`event_param1` = 1263364;

UPDATE `creature_template` t
SET t.`AIName` = 'SmartAI', t.`npcflag` = t.`npcflag` | 16777216
WHERE @EVERLAKE_OK = 1 AND t.`entry` = 253431 AND t.`ScriptName` = '';
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 253431, 0, 0, 0, @EVERLAKE_FILE, 'AIName SmartAI + npcflag spellclick (16777216) added'
FROM DUAL WHERE @EVERLAKE_OK = 1;

COMMIT;
