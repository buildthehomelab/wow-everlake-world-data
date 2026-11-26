-- Holiday vendors listed 44 later-expansion items that this game does not have.
-- 2026_11_26_93_world_everlake_holiday_vendor_strays.sql: written from the test realm's world (2026-11-26, tracker
-- Query page) after the Darkmoon Faire vendors (2026_11_26_92) were cleaned the same way.
--
-- Checked: every vendor a game event spawns or restocks (29 vendors, 330 rows). None of the items below is in the
-- client's ItemSparse, in the live hotfixes or in hotfixes.item_sparse, so no player can see them. The rows come from
-- the base world database, not from the core's SQL or from this repository.
--   Feast of Winter Veil  the ten Copperpinch and Jinglepocket goblins: 34410, 34412 or 34413, 70923, 188680
--   Scourge Invasion      Argent Quartermaster 16786: 13 Wrath items
--   Lunar Festival        Fariel Starsong 15909: 44916-44919
--   Harvest Festival      Wagner Hammerstrike 15011, Javnir Nashak 15012: 34850
-- Fariel keeps the rocket recipe bundles 21740-21743: the hotfixes carry them from a live build (70685).
--
-- Running it again changes nothing.

DELETE FROM `npc_vendor` WHERE `entry` IN (13418, 13430, 13431, 13434, 13436) AND `item` IN (34410, 34412);
DELETE FROM `npc_vendor` WHERE `entry` IN (13420, 13429, 13432, 13433, 13435) AND `item` IN (34413, 70923, 188680);
DELETE FROM `npc_vendor` WHERE `entry` = 16786 AND `item` IN
  (40492, 40593, 40601, 43068, 43070, 43073, 43074, 43077, 43078, 43081, 43082, 43530, 43531);
DELETE FROM `npc_vendor` WHERE `entry` = 15909 AND `item` IN (44916, 44917, 44918, 44919);
DELETE FROM `npc_vendor` WHERE `entry` IN (15011, 15012) AND `item` = 34850;
