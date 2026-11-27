-- Nine Lunar Festival elders showed 12 gossip options from other expansions' NPCs.
-- 2026_11_26_912_world_everlake_lunar_elder_foreign_options.sql: written from the test realm's world (2026-11-26,
-- tracker Query page) while checking every spawned NPC's gossip menu.
--
-- The elders' menus (creature_template_gossip, build 48676) share their ids with Legion-era menus in the base world
-- database, so their option lists also held those NPCs' options (builds 27101-27980, one pair 62748), for example:
--   21059 Elder Starweave    "Why is an ethereal traveling on a ship full of draenei?", "... Locus-Walker?", a shop
--   21071 Elder Windrun      "I need a cache key [100 Nethershards]", "I have Nethershards, are you willing to trade?"
--   21043 Elder Primestone   "I want to transmogrify my gear.", "I would like to buy from you."
--   21063 Elder Stormbrow    "I would like to buy from you." (no stock)
--   21004 Bladesing, 21013 Dawnstrider, 21017 Goldwell, 21058 Starsong: one stray line each
-- Their four conditions (quest-not-taken checks on the elders' coin quests) go with them; no locale row or SmartAI
-- script refers to them. The elders' "Where is Elder ...?" options and their quests stay.
--
-- Running it again changes nothing.

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND (`SourceGroup`, `SourceEntry`) IN
  ((21043, 1), (21059, 1), (21059, 2), (21071, 1));
DELETE FROM `gossip_menu_option` WHERE (`MenuID`, `OptionID`) IN
  ((21004, 0), (21013, 0), (21017, 0), (21043, 0), (21043, 1), (21058, 0), (21059, 0), (21059, 1), (21059, 2),
   (21063, 0), (21071, 0), (21071, 1));
