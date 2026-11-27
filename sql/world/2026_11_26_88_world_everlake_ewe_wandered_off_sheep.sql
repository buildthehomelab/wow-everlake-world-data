-- 96674 Ewe Wandered Off (Mirt 248419, Elderwild): "Capture and return 6 Escaped Sheep." Its objective counts credit
-- 265988 "[DNT] Kill Credit: Escaped Sheep", which nothing on the realm gives: the sheep cannot be caught.
-- 2026_11_26_88_world_everlake_ewe_wandered_off_sheep.sql: written by hand, not tried in game (2026-11-26).
--
-- How live does it (sources):
--   Client DB2: 1296141 Kill Credit (DNT) gives 265988 (KILL_CREDIT2 on its caster); it is a triggered-only spell that
--     nothing in the client casts. 1296140 Sheep Caught! is an aura on its caster; 1296072 / 1296076 Caught Sheep are
--     auras on the sheep. No item uses any of them, so live gives the credit from a server script.
--   Icy Veins (wowf npc 265962): the Escaped Sheep has cursor "questinteract" (it is clicked). The realm has it spawned
--     (4 spawns, 5105-5189 / -1291..-1409, map 1) without AI or click; Mirt stands at 5091.3 -1464.7.
--   Quest text (Icy Veins quest 96674): "Capture and return 6 Escaped Sheep"; they wandered off from Mirt.
--
-- Rows: the sheep gets the spell click flag and a click on which the player casts Sheep Caught! (1296140) on himself
-- (cast_flags 3), only while 96674 is in the player's log (condition source 18). On the click the sheep loses its click
-- and follows the player (SMART_ACTION_FOLLOW); when it comes within interaction range of Mirt 248419 the core gives
-- the player (and group) credit 265988 and despawns the sheep (it respawns as spawned).
-- INFERRED: live's script is not in any source; the click, the follow and the return to Mirt follow the quest text.
-- Rows are only added where the sheep has no AI, script or click. Each added row is recorded in everlake_import_rows.
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
SET @EVERLAKE_FILE := '2026_11_26_88_world_everlake_ewe_wandered_off_sheep.sql';
SET @EVERLAKE_NOTE := 'client SpellEffect 1296141 (KILL_CREDIT2 265988) / 1296140; Icy Veins npc 265962 questinteract';

START TRANSACTION;

SET @EVERLAKE_OK := (SELECT COUNT(*) = 1 FROM `creature_template` t WHERE t.`entry` = 265962 AND t.`ScriptName` = '' AND t.`AIName` IN ('', 'SmartAI'))
  AND (SELECT COUNT(*) = 0 FROM `smart_scripts` s WHERE s.`entryorguid` = 265962 AND s.`source_type` = 0)
  AND (SELECT COUNT(*) = 0 FROM `npc_spellclick_spells` k WHERE k.`npc_entry` = 265962);

-- clicking a sheep: the player casts Sheep Caught! on himself
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`)
SELECT 265962, 1296140, 3, 0 FROM DUAL WHERE @EVERLAKE_OK = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'npc_spellclick_spells', 265962, 1296140, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE
FROM `npc_spellclick_spells` k WHERE @EVERLAKE_OK = 1 AND k.`npc_entry` = 265962 AND k.`spell_id` = 1296140;

-- only for players with Ewe Wandered Off in their log (not yet complete)
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 18, 265962, 1296140, 0, 0, 9, 0, 96674, 0, 0, '', 0, 0, 0, '', 'Escaped Sheep: click only while Ewe Wandered Off (96674) is taken'
FROM DUAL
WHERE @EVERLAKE_OK = 1
  AND NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 18 AND c.`SourceGroup` = 265962 AND c.`SourceEntry` = 1296140);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 18, 265962, 1296140, 0, @EVERLAKE_FILE, 'click condition: quest 96674 taken'
FROM `conditions` c WHERE @EVERLAKE_OK = 1 AND c.`SourceTypeOrReferenceId` = 18 AND c.`SourceGroup` = 265962 AND c.`SourceEntry` = 1296140 AND c.`ConditionValue1` = 96674;

-- caught: no more click, follow the clicker; at Mirt (248419) the core gives credit 265988 and despawns the sheep
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 265962, 0, 0, 0, '', 73, 0, 100, 0, 0, 0, 0, 0, 0, '', 83, 16777216, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Escaped Sheep - On spellclick - Remove npc flag spellclick (Ewe Wandered Off 96674)'
FROM DUAL WHERE @EVERLAKE_OK = 1
UNION ALL
SELECT 265962, 0, 1, 0, '', 73, 0, 100, 0, 0, 0, 0, 0, 0, '', 29, 0, 0, 248419, 265988, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Escaped Sheep - On spellclick - Follow clicker, credit 265988 at Mirt 248419 (Ewe Wandered Off 96674)'
FROM DUAL WHERE @EVERLAKE_OK = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', 265962, 0, s.`id`, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE
FROM `smart_scripts` s WHERE @EVERLAKE_OK = 1 AND s.`entryorguid` = 265962 AND s.`source_type` = 0 AND s.`event_type` = 73;

UPDATE `creature_template` t
SET t.`AIName` = 'SmartAI', t.`npcflag` = t.`npcflag` | 16777216
WHERE @EVERLAKE_OK = 1 AND t.`entry` = 265962 AND t.`ScriptName` = '';
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 265962, 0, 0, 0, @EVERLAKE_FILE, 'AIName SmartAI + npcflag spellclick (16777216) added'
FROM DUAL WHERE @EVERLAKE_OK = 1;

COMMIT;
