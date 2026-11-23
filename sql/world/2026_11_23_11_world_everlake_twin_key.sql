-- Shadowfang Keep: the Twin Key can be had again, and the Ornamented Chest needs it, as on live Forever.
-- 2026_11_23_11_world_everlake_twin_key.sql: written by hand.
--
-- The rogue quest The Horn of Xelthos (78261): pick the pockets of the rare twins Gefell (211764) and Gemela
-- (211765) for the Brother's and Sister's Half-Keys, combine them into the Twin Key (client spell 425094, the two
-- halves as reagents) and open the Ornamented Chest (410528) for the Horn.
--   * the realm has both twins spawned and pickpocket rows giving each half at 100%, but the twins' PickPocketLootID
--     is 0, so the rows are never read and picking their pockets gives nothing. Icy Veins and QuestieDB record each
--     half from its twin; the loot id is set to the creature's own entry, where the rows already stand.
--   * the chest has no lock on the realm. Icy Veins' record of the live object gives lock 3671, which the client's
--     Lock table opens with item 210209, the Twin Key.
--
-- Sources: Icy Veins' WoW Forever database and QuestieDB (GPL-3.0); client SpellEffect, SpellReagents and Lock. Not
-- checked in game.
-- Changes a row only while it is as described above. Running it again changes nothing. Never edit this file once it
-- is deployed: a later fix is a new file.

UPDATE `creature_template_difficulty` d SET d.`PickPocketLootID` = d.`Entry`
WHERE d.`Entry` IN (211764, 211765) AND d.`PickPocketLootID` = 0
  AND EXISTS (SELECT 1 FROM `pickpocketing_loot_template` p WHERE p.`Entry` = d.`Entry` AND p.`Item` IN (210212, 210213));

UPDATE `gameobject_template` SET `Data0` = 3671
WHERE `entry` = 410528 AND `type` = 3 AND `Data0` = 0
  AND (SELECT COUNT(*) FROM `creature_template_difficulty` d WHERE d.`Entry` IN (211764, 211765) AND d.`PickPocketLootID` = d.`Entry`) = 2;
