-- The Drowned City: Captain Dreadrise's Abyssal Bubble (260150) can no longer parry or block.
-- 2026_11_26_22_world_everlake_abyssal_bubble_no_parry_block.sql: written by hand (2026-11-26).
--
-- Blizzard's server-side note of 16 November 2026 (step 70938+1): "The Drowned City: The Abyssal Bubble summoned by
-- Captain Dreadrise can no longer block, dodge or parry." The bubble has no extra flags, AI or script on the realm.
-- It gets CREATURE_FLAG_EXTRA_NO_PARRY (0x4) and CREATURE_FLAG_EXTRA_NO_BLOCK (0x10), only while its flags are still 0.
-- Not here: dodge. The core has no flag for it (a creature's dodge chance is a flat 5% plus auras, Unit.cpp), so that
-- part needs a core change.
--
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing. Not checked in
-- game.

UPDATE `creature_template` SET `flags_extra` = 20
WHERE `entry` = 260150 AND `flags_extra` = 0;
