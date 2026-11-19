-- WoW Forever: The Shaper's Terrace (map 3001): the scripts of its fights. 2026_11_19_965_world_everlake_shapers_terrace_scripts.sql.
-- The fights are C++ in the core fork (wow-trinitycore-everlake, classic_instance_shapers_terrace.cpp): this names them on the
-- instance and on the bosses 2026_11_19_963 added. A core without them only logs that the names
-- are unknown. Only rows that still have no script are changed, so a later fix in either repository is not
-- overwritten. Safe to run again.

UPDATE `instance_template` SET `script` = 'classic_instance_shapers_terrace' WHERE `map` = 3001 AND `script` = '';

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 253201 AND `ScriptName` = '' AND `AIName` = '';   -- Titanosaur
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 253218 AND `ScriptName` = '' AND `AIName` = '';   -- Izha'Rel
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 261809 AND `ScriptName` = '' AND `AIName` = '';   -- Nanaya
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 261811 AND `ScriptName` = '' AND `AIName` = '';   -- Tor'Rel
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 261812 AND `ScriptName` = '' AND `AIName` = '';   -- Thunderhoof
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 261813 AND `ScriptName` = '' AND `AIName` = '';   -- Venomridge
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 261974 AND `ScriptName` = '' AND `AIName` = '';   -- Cinder
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 261993 AND `ScriptName` = '' AND `AIName` = '';   -- King Op
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 262081 AND `ScriptName` = '' AND `AIName` = '';   -- Bolt
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 262127 AND `ScriptName` = '' AND `AIName` = '';   -- Direhorn Matriarch
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 262297 AND `ScriptName` = '' AND `AIName` = '';   -- Snowtalon
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_shapers_terrace' WHERE `entry` = 272561 AND `ScriptName` = '' AND `AIName` = '';   -- Vitrix
