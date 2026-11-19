-- WoW Forever: Blackmaw Hold (map 2974): the scripts of its fights. 2026_11_18_963_world_everlake_blackmaw_hold_scripts.sql.
-- The fights are C++ in the core fork (wow-trinitycore-everlake, classic_instance_blackmaw_hold.cpp): this names them on
-- the instance and on the creatures 2026_11_18_961 added. A core without them only logs that the names are unknown.
-- Only rows that still have no script are changed, so a later fix in either repository is not overwritten. Safe to run
-- again.

UPDATE `instance_template` SET `script` = 'classic_instance_blackmaw_hold' WHERE `map` = 2974 AND `script` = '';

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_bmh_withermaw'      WHERE `entry` = 247195 AND `ScriptName` = '' AND `AIName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_bmh_bonesnout'      WHERE `entry` = 247198 AND `ScriptName` = '' AND `AIName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_bmh_impaan'         WHERE `entry` = 247206 AND `ScriptName` = '' AND `AIName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_bmh_behemoth'       WHERE `entry` = 247207 AND `ScriptName` = '' AND `AIName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_bmh_bloodmane'      WHERE `entry` = 247209 AND `ScriptName` = '' AND `AIName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_bmh_unbound_spirit' WHERE `entry` = 247231 AND `ScriptName` = '' AND `AIName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_bmh_varrox'         WHERE `entry` = 247234 AND `ScriptName` = '' AND `AIName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_npc_bmh_clawbert'        WHERE `entry` = 247996 AND `ScriptName` = '' AND `AIName` = '';
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_npc_bmh_bramblesnap'     WHERE `entry` = 248765 AND `ScriptName` = '' AND `AIName` = '';
