-- 95163 Drive Them Back ("Return 10 Young Paletusks to Na'zok's farm") counts credit NPC 266883 "[DNT] Kill Credit Young
-- Paletusk". The quest hands out the Swineherd's Staff (268521), whose spell 1289718 Swat Paletusk (client SpellEffect:
-- dummy on the target) does nothing on the realm. Young Paletusk (258331, 11 spawns, no AI) gets a SmartAI that gives the
-- caster the credit when the swat hits it and then despawns it, so the piglet "runs home" and respawns later.
-- Written by hand, not tried in game. Only written where Young Paletusk has no AI yet.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 258331, 0, 0, 1, '', 8, 0, 100, 0, 1289718, 0, 0, 0, 0, '', 33, 266883, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 'Young Paletusk - On spell hit Swat Paletusk (1289718) - Quest credit 266883 (Drive Them Back 95163)'
FROM `creature_template` c
WHERE c.`entry` = 258331 AND c.`AIName` = '' AND c.`ScriptName` = ''
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = 258331 AND d.`source_type` = 0)
UNION ALL
SELECT 258331, 0, 1, 0, '', 61, 0, 100, 0, 0, 0, 0, 0, 0, '', 41, 1000, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Young Paletusk - Linked - Despawn in 1 s'
FROM `creature_template` c
WHERE c.`entry` = 258331 AND c.`AIName` = '' AND c.`ScriptName` = ''
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = 258331 AND d.`source_type` = 0);
UPDATE `creature_template` SET `AIName` = 'SmartAI'
WHERE `entry` = 258331 AND `AIName` = '' AND `ScriptName` = ''
  AND EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = 258331 AND d.`source_type` = 0);
