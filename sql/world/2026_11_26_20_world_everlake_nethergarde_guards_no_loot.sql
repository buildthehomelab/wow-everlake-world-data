-- Blasted Lands: the Nethergarde Keep guards drop no loot and are flagged as guards.
-- 2026_11_26_20_world_everlake_nethergarde_guards_no_loot.sql: written by hand (2026-11-26).
--
-- Blizzard's server-side note of 13 November 2026 (step 70938+1): "Blasted Lands - Nethergarde Keep guards no longer
-- drop loot and should have behavior consistent with other guards." The guards are Nethergarde Soldier 5999, Nethergarde
-- Officer 6003 and Nethergarde Elite 7851 (the keep's other people, miners, engineers, foremen, clerics, analysts and
-- riftwatchers, are not guards and keep their loot). Each loses its loot id (its own entry) and gets the guard and
-- no-experience extra flags (0x8000 | 0x40 = 32832), as the Ironforge Mountaineer and Stormwind City Patroller have.
-- Their pickpocket loot (the Soldier's) stays. Their loot rows stay (nothing else uses them).
-- Each changes only while it still holds the old values.
--
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing. Not checked in
-- game.

UPDATE `creature_template_difficulty` SET `LootID` = 0
WHERE `Entry` IN (5999, 6003, 7851) AND `LootID` = `Entry`;
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 32832
WHERE `entry` IN (5999, 6003, 7851) AND `flags_extra` = 0;
