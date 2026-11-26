-- Blackfathom Deeps: the Altar of the Deeps (103016) can be used again 3 seconds after use.
-- 2026_11_26_12_world_everlake_altar_of_the_deeps_reset.sql: written by hand from the tracker's kept facts (2026-11-26).
--
-- Blizzard's server-side note of 25 November 2026 (step 71139+1): "Blackfathom Deeps: The Altar of the Deeps should now
-- resume its interactability after 3 seconds and properly grant the Blessing of Blackfathom." The altar is a button
-- whose Data2 is its auto-close time in milliseconds; the realm has 65536 (over a minute). EG Link's object record of
-- the altar (client build 70338) gives 3000. Its linked trap, Shrine of Gelihast 94039, already casts Blessing of
-- Blackfathom 8733 (Data3), and the core's Blackfathom Deeps script only keeps the altar's guid, so nothing else changes.
--
-- Changes the row only while it still holds 65536. Never edit this file once it is deployed: a later fix is a new file.
-- Running it again changes nothing. Not checked in game.

UPDATE `gameobject_template` SET `Data2` = 3000
WHERE `entry` = 103016 AND `type` = 1 AND `Data2` = 65536 AND `Data3` = 94039;
