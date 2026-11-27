-- 2026_11_27_04_world_everlake_undermine_real_last_bosses.sql: the last boss of each level 55+ dungeon gives 3 Tarnished
-- Undermine Reals (currency 3469) instead of 1, as Wowhead's Forever guide has it (forg.gg's Undermine Real guide quotes
-- it). Still once a day per character (2026_11_27_03).
--   Blackrock Depths       Emperor Dagran Thaurissan (9019)
--   Lower Blackrock Spire  Overlord Wyrmthalak (9568)
--   Upper Blackrock Spire  General Drakkisath (10363)
--   Scholomance            Darkmaster Gandling (1853)
--   Stratholme (Live)      Balnazzar (loot 10813, shared with Grand Crusader Dathrohan)
--   Stratholme (Dead)      Baron Rivendare (10440)
--   Dire Maul East         Alzzin the Wildshaper (11492)
--   Dire Maul West         Prince Tortheldrin (11486)
--   Dire Maul North        King Gordok (11501)
-- Running it again changes nothing. Never edit this file once it is deployed: a later fix is a new file.

UPDATE `creature_loot_template` SET `MinCount` = 3, `MaxCount` = 3
 WHERE `ItemType` = 2 AND `Item` = 3469 AND `Entry` IN (9019, 9568, 10363, 1853, 10813, 10440, 11492, 11486, 11501);
