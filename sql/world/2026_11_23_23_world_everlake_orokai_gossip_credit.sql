-- 95006 Stolen Power ("Speak with Orokai when you are ready to see what he learned from the Faintly Glowing Branch")
-- counts credit NPC 278309 "Events Observed". Live gives it with server spell 1326044 "DNT" (client SpellEffect: effect
-- 134, credit 278309), which nothing on the realm casts. Orokai (216289, one spawn in Moonglade, no AI) gets a SmartAI row
-- that gives the credit when a player opens his gossip; the core only counts it while the quest is in the log, so a player
-- who just took the quest from him talks to him once more. Written by hand, not tried in game. Only written where Orokai
-- has no AI yet.
-- 95006 follows 96209 The Ancient, Orokai (Icy Veins "previous quests"): quest_template_addon PrevQuestID, only where the
-- quest has no addon row.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 216289, 0, 0, 0, '', 64, 0, 100, 0, 0, 0, 0, 0, 0, '', 33, 278309, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Orokai - On gossip hello - Quest credit 278309 (Stolen Power 95006)'
FROM `creature_template` c
WHERE c.`entry` = 216289 AND c.`AIName` = '' AND c.`ScriptName` = ''
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = 216289 AND d.`source_type` = 0);
UPDATE `creature_template` SET `AIName` = 'SmartAI'
WHERE `entry` = 216289 AND `AIName` = '' AND `ScriptName` = ''
  AND EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = 216289 AND d.`source_type` = 0);

INSERT INTO `quest_template_addon` (`ID`, `PrevQuestID`)
SELECT 95006, 96209 FROM `quest_template` q
WHERE q.`ID` = 95006 AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` a WHERE a.`ID` = 95006);
