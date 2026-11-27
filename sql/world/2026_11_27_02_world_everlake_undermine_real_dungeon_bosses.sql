-- 2026_11_27_02_world_everlake_undermine_real_dungeon_bosses.sql: the Tarnished Undermine Real (currency 3469) drops only
-- from dungeon bosses of level 55 and up, as on WoW Forever (forg.gg's Undermine Real guide; Wowhead's Forever pages
-- name no raid or world boss). 2026_11_27_00 added Season of Discovery's droppers, raids and world bosses included.
-- Taken away (43 creature loot tables, 2 chests):
--   Onyxia's Lair: Onyxia (10184)
--   Zul'Gurub: 11380, 11382, 14507, 14509, 14510, 14515, 14517, 14834, 15114; Edge of Madness 15082-15085
--   Blackwing Lair: 11981, 11983, 12017, 12435, 13020, 14020, 14601; Nefarian 11583
--   Ruins of Ahn'Qiraj: 15339, 15340, 15341, 15348, 15369, 15370
--   Temple of Ahn'Qiraj: 15263, 15275, 15276, 15299, 15509, 15510, 15511, 15516, 15543, 15544, 15727; Ouro 15517
--   world boss: Azuregos (6109)
--   Blackrock Depths bosses below level 55: Bael'Gar (9016, 54), Fineous Darkvire (9056, 54)
--   chests: Cache of the Firelord (loot 16719, Molten Core), Cannonball Stack (loot 13645, Stratholme: no boss)
-- Kept: 61 bosses of Blackrock Depths, Lower and Upper Blackrock Spire, Scholomance, Stratholme and Dire Maul, level 55-62.
-- Running it again changes nothing. Never edit this file once it is deployed: a later fix is a new file.

DELETE FROM `creature_loot_template` WHERE `ItemType` = 2 AND `Item` = 3469 AND `Entry` IN (
  10184,
  11380, 11382, 14507, 14509, 14510, 14515, 14517, 14834, 15114, 15082, 15083, 15084, 15085,
  11981, 11983, 12017, 12435, 13020, 14020, 14601, 11583,
  15339, 15340, 15341, 15348, 15369, 15370,
  15263, 15275, 15276, 15299, 15509, 15510, 15511, 15516, 15543, 15544, 15727, 15517,
  6109,
  9016, 9056);
DELETE FROM `everlake_import_rows` WHERE `tbl` = 'creature_loot_template' AND `k2` = 2 AND `k3` = 3469 AND `k1` IN (
  10184,
  11380, 11382, 14507, 14509, 14510, 14515, 14517, 14834, 15114, 15082, 15083, 15084, 15085,
  11981, 11983, 12017, 12435, 13020, 14020, 14601, 11583,
  15339, 15340, 15341, 15348, 15369, 15370,
  15263, 15275, 15276, 15299, 15509, 15510, 15511, 15516, 15543, 15544, 15727, 15517,
  6109,
  9016, 9056);
DELETE FROM `gameobject_loot_template` WHERE `ItemType` = 2 AND `Item` = 3469 AND `Entry` IN (13645, 16719);
DELETE FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_loot_template' AND `k2` = 2 AND `k3` = 3469 AND `k1` IN (13645, 16719);
