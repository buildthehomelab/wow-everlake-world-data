-- Darkmoon Faire vendors listed 33 later-expansion items that this game does not have.
-- 2026_11_26_92_world_everlake_darkmoon_vendor_strays.sql: written from the test realm's world (2026-11-26, tracker
-- Query page) while checking every Darkmoon Faire item.
--
-- None of these items is in the client's ItemSparse, in the live hotfixes or in hotfixes.item_sparse, so the tracker
-- has no entry for any of them and no player can see them. The rows come from the base world database, not from the
-- core's SQL or from this repository.
--   14847 Professor Thaddeus Paleo  21 TBC/Wrath potions and scrolls (22829 Super Healing Potion, 27498-27503, ...)
--   14844 Sylannia                   3 later drinks (33234, 33236, 44941)
--   14845 Stamp Thunderhorn          4 later food and drink (33246, 33254, 44940, 73260)
--   14828 Gelvas Grimegate           5 Cata Darkmoon items (73762 balloon, 77158 tonk, 77256 sword, 78340/78341 cloaks)
-- Gelvas keeps the ten ticket prizes (19291-19298, 19426, 19491, 22729), which live sells too.
-- The other NPCs that list some of the same items (Outland and Northrend vendors) are left alone.
--
-- Running it again changes nothing.

DELETE FROM `npc_vendor` WHERE `entry` = 14847 AND `item` IN
  (22829, 22832, 27498, 27499, 27500, 27501, 27502, 27503, 33447, 33457, 33458, 33459, 33460, 33461, 33462,
   37091, 37093, 37097, 43463, 43465, 43467);
DELETE FROM `npc_vendor` WHERE `entry` = 14844 AND `item` IN (33234, 33236, 44941);
DELETE FROM `npc_vendor` WHERE `entry` = 14845 AND `item` IN (33246, 33254, 44940, 73260);
DELETE FROM `npc_vendor` WHERE `entry` = 14828 AND `item` IN (73762, 77158, 77256, 78340, 78341);
