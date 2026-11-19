-- WoW Forever: Alcaz Prison (map 2994): the scripts of its fights. 2026_11_19_964_world_everlake_alcaz_prison_scripts.sql.
-- The fights are C++ in the core fork (wow-trinitycore-everlake, classic_instance_alcaz_prison.cpp): this names them on the
-- instance and on the bosses 2026_11_19_962 added. A core without them only logs that the names
-- are unknown. Only rows that still have no script are changed, so a later fix in either repository is not
-- overwritten. Safe to run again.

UPDATE `instance_template` SET `script` = 'classic_instance_alcaz_prison' WHERE `map` = 2994 AND `script` = '';

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_alcaz_prison' WHERE `entry` = 255391 AND `ScriptName` = '' AND `AIName` = '';   -- Overseer Wrex
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_alcaz_prison' WHERE `entry` = 255702 AND `ScriptName` = '' AND `AIName` = '';   -- Blazeroar
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_alcaz_prison' WHERE `entry` = 255997 AND `ScriptName` = '' AND `AIName` = '';   -- Tidemistress Ca'zass
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_alcaz_prison' WHERE `entry` = 256236 AND `ScriptName` = '' AND `AIName` = '';   -- The Questioner
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'classic_boss_alcaz_prison' WHERE `entry` = 257016 AND `ScriptName` = '' AND `AIName` = '';   -- Katerina the Cleaner
