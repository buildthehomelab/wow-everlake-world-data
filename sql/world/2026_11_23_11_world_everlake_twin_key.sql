-- Shadowfang Keep: the twins Gefell (211764) and Gemela (211765) get the script and pockets the core meant them to have.
-- 2026_11_23_11_world_everlake_twin_key.sql: written by hand.
--
-- The rogue quest The Horn of Xelthos (78261): pick the twins' pockets for the Brother's and Sister's Half-Keys,
-- combine them into the Twin Key and open the Ornamented Chest. The core fork's file 2026_11_21_86 scripts all of it:
-- classic_npc_xelthos_twin shows the twins only to a player alone in the keep, the half-keys are pickpocket rows of
-- the twins, and classic_go_dead_drop_keyed_chest makes the chest want the key (and uses it up).
-- That file sets the twins' ScriptName and PickPocketLootID with UPDATEs, but it sorts before the Karrz file that
-- adds the twins' templates (2026_11_22_60), so on a fresh world the UPDATEs found no row: on the PTR the twins have
-- no script (they stand for groups too) and PickPocketLootID 0 (their half-key rows are never read). Both are set
-- here, as file 2026_11_21_86 wrote them.
-- The chests keep no client lock: the core's chest script already wants the key, and a lock that also takes the
-- key would leave the script nothing to find.
--
-- Sources: the core fork's 2026_11_21_86 (the intended values); Icy Veins and QuestieDB (GPL-3.0) for the half-keys
-- from the twins. Not checked in game.
-- Changes a row only while it is still as the Karrz file left it. Running it again changes nothing. Never edit this
-- file once it is deployed: a later fix is a new file.

UPDATE `creature_template` SET `ScriptName` = 'classic_npc_xelthos_twin'
WHERE `entry` IN (211764, 211765) AND `ScriptName` = '';

UPDATE `creature_template_difficulty` d SET d.`PickPocketLootID` = d.`Entry`
WHERE d.`Entry` IN (211764, 211765) AND d.`PickPocketLootID` = 0
  AND EXISTS (SELECT 1 FROM `pickpocketing_loot_template` p WHERE p.`Entry` = d.`Entry` AND p.`Item` IN (210212, 210213));
