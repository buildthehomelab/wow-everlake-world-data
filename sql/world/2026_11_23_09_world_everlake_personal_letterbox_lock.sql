-- Personal Letterbox (412759, Scarlet Monastery): locked, opened with the Scryer's Key, as on live Forever.
-- 2026_11_23_09_world_everlake_personal_letterbox_lock.sql: written by hand.
--
-- On the realm the chest has no lock and opens for anyone. Icy Veins' record of the live object gives it lock 3680,
-- and the client's Lock table says what 3680 is: opened with item 210963, the Scryer's Key. The realm has the key
-- (Scarlet Scryers carry it), so the chest stays within reach.
-- Left open on purpose: the Padlocked Reliquary (412261, lock 3679, Reliquary Key) and the Ornamented Chest (410528,
-- Shadowfang Keep, lock 3671, Twin Key). Nothing on the realm gives those keys yet.
--
-- Source: Icy Veins' WoW Forever database (the lock id); client Lock. Not checked in game.
-- Changes the template only while it is a chest with no lock. Running it again changes nothing. Never edit this file
-- once it is deployed: a later fix is a new file.

UPDATE `gameobject_template` SET `Data0` = 3680 WHERE `entry` = 412759 AND `type` = 3 AND `Data0` = 0;
