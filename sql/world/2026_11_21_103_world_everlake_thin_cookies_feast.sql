-- Fewer Cookie's Feasts in Wetlands: 6 of the 16 spawns stay.
-- 2026_11_21_103_world_everlake_thin_cookies_feast.sql: written by hand.
--
-- 2026_11_19_937_world_everlake_quest_item_objects.sql spawned Cookie's Feast (612073, holds Expiring Crab Cake) on all
-- 16 of the points Wowhead's Forever map gives for it, 10 of them across Menethil Harbor. Wowhead's points are where
-- players saw it over time, not how many stand at once (NorgannonDB records one Wetlands point), and a player saw a
-- town full of feasts. Kept: two in Menethil Harbor (the docks 920007130, the inn side 920007133) and one at each of
-- the four spots east of the town (920007137, 920007139, 920007140, 920007142). Removed: the other 8 in Menethil and
-- the second of two pairs that stand about 30 yards apart (920007138, 920007141).
--
-- A spawn goes only while it still holds Cookie's Feast and was added by file 937 (everlake_import_rows). With it go
-- its addon, event, pool and spawn group rows, and its rows in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_thin_feast`;
CREATE TEMPORARY TABLE `everlake_thin_feast` (`guid` bigint unsigned NOT NULL PRIMARY KEY);
INSERT INTO `everlake_thin_feast` (`guid`)
SELECT g.`guid` FROM `gameobject` g
WHERE g.`id` = 612073 AND g.`guid` IN (920007127, 920007128, 920007129, 920007131, 920007132, 920007134, 920007135, 920007136, 920007138, 920007141)
  AND EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject' AND r.`k1` = g.`guid`
              AND r.`file` = '2026_11_19_937_world_everlake_quest_item_objects.sql');

DELETE e FROM `game_event_gameobject` e JOIN `everlake_thin_feast` t ON t.`guid` = e.`guid`;
DELETE a FROM `gameobject_addon` a JOIN `everlake_thin_feast` t ON t.`guid` = a.`guid`;
DELETE p FROM `pool_members` p JOIN `everlake_thin_feast` t ON t.`guid` = p.`spawnId` WHERE p.`type` = 1;
DELETE s FROM `spawn_group` s JOIN `everlake_thin_feast` t ON t.`guid` = s.`spawnId` WHERE s.`spawnType` = 1;
DELETE r FROM `everlake_import_rows` r JOIN `everlake_thin_feast` t ON t.`guid` = r.`k1` WHERE r.`tbl` IN ('gameobject', 'gameobject_addon', 'game_event_gameobject');
DELETE g FROM `gameobject` g JOIN `everlake_thin_feast` t ON t.`guid` = g.`guid`;

DROP TEMPORARY TABLE IF EXISTS `everlake_thin_feast`;

COMMIT;
