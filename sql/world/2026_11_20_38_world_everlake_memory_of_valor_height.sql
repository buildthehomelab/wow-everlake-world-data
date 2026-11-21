-- Memory of Valor (object 673515, the Raven Hill Tome for The Valor Family 96139) rises out of the floor onto the table.
-- 2026_11_20_38_world_everlake_memory_of_valor_height.sql: written by hand.
--
-- Player report 2026-11-20: the book for The Valor Family is not on its table at Raven Hill, Duskwood. The core fork's
-- sql/custom/world/2026_11_05_99_world_forever_restore_forever_quest_data.sql spawns it (guid 67351500) at
-- -10717.5, 263.633, z 40.05. x/y match Wowhead Forever's points (Duskwood 21.1, 55.4-55.6), but the server's own maps
-- and vmaps (tracker tools/height.py --floors) put the terrain at 43.09 and the house floor at 43.91 there, so the book
-- sat about 4 yards under the floor, out of sight and out of reach.
-- The table has no collision in the vmaps, so its top is not measured: 44.95 is the floor plus about a table's height
-- (the nearby furniture models top out at 44.9-45.3). Check it in game; a later fix is a new file.
-- Only this one spawn row moves, and only while it still has the old height. Running it again changes nothing.

UPDATE `gameobject` SET `position_z` = 44.95
WHERE `guid` = 67351500 AND `id` = 673515 AND `map` = 0 AND `position_z` BETWEEN 40.0 AND 40.1;
