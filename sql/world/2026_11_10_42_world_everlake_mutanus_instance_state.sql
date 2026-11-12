-- Wailing Caverns: Mutanus death must complete the Classic ritual state.
-- Pinned core: Karrz1/TrinityCore 343fe6fb95076e09575156c8b88d155914003b78.
-- Smart action 34: param1=field, param2=data, param3=0 SetData / 1 SetBossState.
-- Classic TYPE_MUTANUS=5; TYPE_DISCIPLE=4. Boss tracker handles boss index7 separately.
-- Correct only the exact inherited row and expected Classic instance/AI bindings.
-- No inserts, spell/loot changes, or changes to explicit overrides. Safe to replay.

UPDATE `smart_scripts` s
SET s.`action_param1` = 5,
    s.`action_param3` = 0,
    s.`comment` = 'Mutanus the Devourer - On Just Died - Set Classic Mutanus ritual state DONE'
WHERE s.`entryorguid` = 3654 AND s.`source_type` = 0 AND s.`id` = 0
  AND s.`link` = 0 AND s.`Difficulties` = '1'
  AND s.`event_type` = 6 AND s.`event_phase_mask` = 0
  AND s.`event_chance` = 100 AND s.`event_flags` = 0
  AND s.`event_param1` = 0 AND s.`event_param2` = 0
  AND s.`event_param3` = 0 AND s.`event_param4` = 0 AND s.`event_param5` = 0
  AND s.`event_param_string` = ''
  AND s.`action_type` = 34 AND s.`action_param1` = 4
  AND s.`action_param2` = 3 AND s.`action_param3` = 1
  AND s.`action_param4` = 0 AND s.`action_param5` = 0
  AND s.`action_param6` = 0 AND s.`action_param7` = 0
  AND s.`action_param_string` IS NULL
  AND s.`target_type` = 1 AND s.`target_param1` = 0
  AND s.`target_param2` = 0 AND s.`target_param3` = 0 AND s.`target_param4` = 0
  AND s.`target_param_string` IS NULL
  AND s.`target_x` = 0 AND s.`target_y` = 0 AND s.`target_z` = 0 AND s.`target_o` = 0
  AND s.`comment` = 'Mutanus the Devourer - On Just Died - Set Instance Data 9 to 3'
  AND EXISTS (SELECT 1 FROM `instance_template` i
      WHERE i.`map` = 43 AND i.`script` = 'classic_instance_wailing_caverns')
  AND EXISTS (SELECT 1 FROM `creature_template` c
      WHERE c.`entry` = 3654 AND c.`AIName` = 'SmartAI' AND c.`ScriptName` = '')
  AND EXISTS (SELECT 1 FROM `creature_template` c
      WHERE c.`entry` = 3678 AND c.`ScriptName` = 'classic_npc_disciple_of_naralex')
  AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = 3678 AND c.`map` = 43);
