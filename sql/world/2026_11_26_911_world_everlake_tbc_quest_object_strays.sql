-- Four TBC quest objects stood on the old continents and opened to nothing: 21 spawns.
-- 2026_11_26_911_world_everlake_tbc_quest_object_strays.sql: written from the test realm's world (2026-11-26, tracker
-- Query page) while checking every spawned object.
--
-- Each one's loot table has no rows, and the quest item it is meant to give is in neither the client's ItemSparse, the
-- live hotfixes nor hotfixes.item_sparse; nobody gives the quests:
--   181687 Warsong Lumber Pile   18 spawns, Ashenvale            item 23776, no quest asks for it
--   181620 Unopened Crate         1 spawn                         item 23646, quest 9435 "[DEPRECATED] Missing Crystals"
--   181627 Weapon Rack            1 spawn                         item 23660, quest 9439 "Unclaimed Baggage"
--   182063 Basin of Holy Water    1 spawn, Eastern Plaguelands    item 24284, quest 9735 "True Masters of the Light"
-- The spawns come from the base world database (guid = entry * 100 + n), not from the core's SQL or this repository.
-- No addon, pool, game event, spawn group, override or SmartAI row refers to them. The templates stay.
--
-- Running it again changes nothing.

DELETE FROM `gameobject` WHERE `id` IN (181687, 181620, 181627, 182063) AND `guid` IN
  (18162000, 18162700, 18168700, 18168701, 18168702, 18168703, 18168704, 18168705, 18168706, 18168707, 18168708,
   18168709, 18168710, 18168711, 18168712, 18168713, 18168714, 18168715, 18168716, 18168717, 18206300);
