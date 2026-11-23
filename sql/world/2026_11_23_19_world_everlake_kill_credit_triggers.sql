-- Kill credit for the two quests in 2026_11_23_18_world_everlake_kill_credit_quests.sql. Their objectives name hidden
-- credit NPCs that nothing on the realm gives; live gives them from the server side. Written by hand, not tried in game.
--
-- 93429 Blood of My Blood ("Slay 10 Lost Ones in the Fallow Sanctuary") counts credit NPC 254797 "Lost One". Every
--   spawned Lost One in the Swamp of Sorrows gets it as KillCredit2 (KillCredit1 already holds 46959, the proxy credit of
--   the Cataclysm Lost One quest, on three of them). Only written where KillCredit2 is still empty.
-- 93044 A Cleansing Cry ("Go inside the cave ... and seek out Mulara") counts credit NPC 254930 "Kill Credit: Mulara
--   spoken with". Mulara (253713, one spawn) gets a gossip flag and a SmartAI row that gives the credit when a player
--   opens her gossip; the core only counts it while the quest is in the log. Only written where she has no AI yet.
-- 93044 follows 93041 Facing the Truth (Icy Veins "previous quests"): quest_template_addon PrevQuestID, only where the
--   quest has no addon row.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

UPDATE `creature_template` SET `KillCredit2` = 254797
WHERE `entry` IN (755, 757, 759, 760, 761, 762, 763, 1106) AND `KillCredit2` = 0 AND `KillCredit1` <> 254797;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 253713, 0, 0, 0, '', 64, 0, 100, 0, 0, 0, 0, 0, 0, '', 33, 254930, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Mulara - On gossip hello - Quest credit 254930 (A Cleansing Cry 93044)'
FROM `creature_template` c
WHERE c.`entry` = 253713 AND c.`AIName` = '' AND c.`ScriptName` = ''
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = 253713 AND d.`source_type` = 0);
UPDATE `creature_template` SET `AIName` = 'SmartAI', `npcflag` = `npcflag` | 1
WHERE `entry` = 253713 AND `AIName` = '' AND `ScriptName` = ''
  AND EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = 253713 AND d.`source_type` = 0);

INSERT INTO `quest_template_addon` (`ID`, `PrevQuestID`)
SELECT 93044, 93041 FROM `quest_template` q
WHERE q.`ID` = 93044 AND NOT EXISTS (SELECT 1 FROM `quest_template_addon` a WHERE a.`ID` = 93044);
