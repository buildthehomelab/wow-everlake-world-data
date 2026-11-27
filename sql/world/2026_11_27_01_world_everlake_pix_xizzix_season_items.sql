-- 2026_11_27_01_world_everlake_pix_xizzix_season_items.sql: Pix Xizzix (227853, Booty Bay) stops selling 10 Season of
-- Discovery items WoW Forever's Pix does not sell.
-- The core's restore file 2026_11_05_99_world_forever_restore_forever_quest_data.sql stocked her with Season of
-- Discovery's list. Forever's own lists (Wowhead Forever's npc page, ForeverDB) name 43 items and forg.gg names Core
-- Leather (17012) too: those 44 stay. No source of Forever's lists these 10:
--   226405, 236414  Damaged Undermine Supply Crate (Forever sells 272151)
--   228121          Pattern: Leather-Reinforced Runecloth Bag
--   228175          Libram of Holy Alacrity
--   228176          Totem of Thunder
--   228189          Gift of Gob
--   232454-232457   Emblem of the Wild Gods, of Dishonor, of the Violet Eye, of the Worldcore
-- A correction: a row goes only while it is still the row the core's file wrote (same price). Running it again changes
-- nothing. Never edit this file once it is deployed: a later fix is a new file.

DELETE FROM `npc_vendor` WHERE `entry` = 227853 AND `type` = 1 AND (`item`, `ExtendedCost`) IN (
  (226405, 9083), (236414, 9077), (228121, 9084), (228175, 9078), (228176, 9078), (228189, 9080),
  (232454, 9083), (232455, 9083), (232456, 9083), (232457, 9083));
