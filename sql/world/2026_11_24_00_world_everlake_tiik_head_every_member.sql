-- Witch Doctor Ti'ik (270772) drops Ti'ik's Head (279913) for every party member on the quest, as Blizzard's WoW Forever hotfix
-- of 2026-11-20 says (forever-bugs #564, closed with that hotfix). The item already carries the multi-drop flag (live record,
-- core hotfix 2026_11_22_70: Flags1 0x800), so the server gives each member with the quest their own copy whenever it drops
-- (LootItem: freeforall + needs_quest). What kept groups short was the drop row: 2026_11_18_926 set it to 40%, QuestieDB's
-- per-player rate, most likely low because before the hotfix one kill gave one head to the whole group. With one head per member
-- the quest target drops it every kill: Chance 100.
-- Only while the row is still the 40% the 926 file wrote. Written by hand, not tried in game. Never edit this file once it is deployed: a later fix is a new file. Running it again
-- changes nothing.
UPDATE `creature_loot_template` SET `Chance` = 100, `Comment` = 'Witch Doctor Ti''ik: every member on the quest (Blizzard hotfix 2026-11-20, forever-bugs #564)'
WHERE `ItemType` = 0 AND `Item` = 279913 AND `Chance` = 40
  AND `Entry` IN (SELECT `LootID` FROM (SELECT `LootID` FROM `creature_template_difficulty` WHERE `Entry` = 270772 AND `LootID` <> 0) AS `d`);
