-- Valanaar's Peacekeeper Elites stand up: they no longer lie on the ground, even while patrolling.
-- 2026_11_20_37_world_everlake_peacekeeper_elite_stand.sql: written by hand.
--
-- Player report 2026-11-20: the Peacekeeper Elite guards in Valanaar (Zephras Isle, map 2991) lie on the floor, also while
-- walking their patrols. The core fork's sniff import (sql/custom/world/2026_10_02_00_world_forever_sniff_ai.sql) gave
-- 252477 an out of combat SmartAI self cast of 1288546 every 0.9 to 1.5 s, taken from sniffed corpses. That spell lays
-- the caster down. The fork's 2026_10_05_04_world_forever_hill_fight.sql already removed the same row from the Valanaar
-- Peacekeepers (253474) and the same aura from the Al'Aketh attackers (253782), but missed the Peacekeeper Elite.
-- The other Peacekeeper Elite entry (254287) has no script and is left alone.
-- Sources: the core fork's custom world files named above.
-- Only the 1288546 self cast row is removed; AIName is cleared only when no SmartAI row is left. Never edit this file once
-- it is deployed: a later fix is a new file. Running it again changes nothing.

DELETE FROM `smart_scripts`
WHERE `entryorguid` = 252477 AND `source_type` = 0 AND `event_type` = 1 AND `action_type` = 11 AND `action_param1` = 1288546;

UPDATE `creature_template` SET `AIName` = ''
WHERE `entry` = 252477 AND `AIName` = 'SmartAI'
  AND NOT EXISTS (SELECT 1 FROM (SELECT `entryorguid` FROM `smart_scripts` WHERE `entryorguid` = 252477 AND `source_type` = 0) AS `s`);
