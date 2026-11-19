-- The druid relics open on their loot again: Relic of the Fang, the Claw and the Silent Shadow.
-- 2026_11_19_938_world_everlake_druid_relic_loot.sql: written by hand.
--
-- The core's restore file (sql/custom/world/2026_11_05_99_world_forever_restore_forever_quest_data.sql) gives these
-- three chests their loot rows under their own entry (672821 -> item 280502, 673093 -> 280679, 673094 -> 280680) but
-- leaves the chest's loot id (Data1) at 0, so opening one gives nothing. The Great Cat Spirit / Great Windborne Cat
-- Spirit quests (98342, 98396, 98404) ask for the Relic of the Claw's item. File 926 had its own loot for 673093 but
-- skipped it, since the template already existed. Data1 becomes the entry, where the loot is, only while Data1 is
-- still 0 and that loot exists. Not checked in game.
--
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

UPDATE `gameobject_template` t
SET t.`Data1` = t.`entry`
WHERE t.`entry` IN (672821, 673093, 673094) AND t.`type` = 3 AND t.`Data1` = 0
  AND EXISTS (SELECT 1 FROM `gameobject_loot_template` l WHERE l.`Entry` = t.`entry`);
