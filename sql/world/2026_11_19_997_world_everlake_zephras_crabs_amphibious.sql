-- Zephras Isle's crabs walk into the sea: they are amphibious, as on live.
-- 2026_11_19_997_world_everlake_zephras_crabs_amphibious.sql: written by hand.
--
-- PTR report 2026-11-19: the crabs on Zephras Isle (map 2991) hop in the shallows. Their creature_template_difficulty rows
-- (from the Forever TDB, 2026-10-14) have StaticFlags1 = 0: no AMPHIBIOUS (0x00080000), so the core treats them as land
-- creatures. Yet most of them stand in the sea: the TDB spawns, recorded on live, put 51 of the 61 Windsong Crawlers in water,
-- 15 of them on the sea floor 6 to 16 yd under the surface, and 7 of the 26 Gustjumpers and Docile Galestriders in the
-- shallows (heights from the server's maps and vmaps: ForeverTracker tools/height.py --floors). So on live they walk the sea
-- bed, which only an amphibious creature does.
--
-- A land creature in water gets the navmesh's water polygons only while it already stands in water (PathGenerator::
-- UpdateFilter) and never otherwise, and cannot reach a player standing in water (Unit::isInAccessiblePlaceFor). AMPHIBIOUS makes them amphibious creatures that keep to the bed without swimming
-- (PathGenerator::NormalizePath, the core's fix for the Echo Isles crabs hopping above the water, Discord 2026-11-10).
-- CAN_SWIM is not added: crabs walk the floor.
--
--   254588  Windsong Crawler      61 spawns: 10 dry, 21 under 2 yd of water, 15 at 2-6 yd, 15 deeper
--   259005  Gustjumper            18 spawns: 15 dry, 3 in the shallows
--   259175  Docile Galestrider     8 spawns:  4 dry, 4 in the shallows
-- The Musical Gustjumpers (259006, 259842, 259843) stand on dry land and are left alone.
-- Sources: the Forever TDB TDB_full_forever_2026_10_14 (creature, creature_template_difficulty); the server's maps and vmaps
-- for map 2991; the core's PathGenerator and Unit code at the PTR pin.
-- Only rows without AMPHIBIOUS change. Never edit this file once it is deployed: a later fix is a new file. Running it again
-- changes nothing.

UPDATE `creature_template_difficulty` SET `StaticFlags1` = `StaticFlags1` | 0x00080000
WHERE `DifficultyID` = 0 AND (`StaticFlags1` & 0x00080000) = 0 AND `Entry` IN (254588, 259005, 259175);
