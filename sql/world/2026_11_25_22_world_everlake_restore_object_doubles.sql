-- World objects that stand twice: a copy from the classic restore on top of the live game's own.
-- 2026_11_25_22_world_everlake_restore_object_doubles.sql: written by hand from the test realm's world (2026-11-25,
-- tracker Query page), after a check against players' recordings of live WoW Forever found every chair in the Tower of
-- Althalaxx standing twice.
--
-- The realm's objects come from two places among others: the classic restore (guids 30000000-30999999) and the sniffs of
-- the live Forever game (guids 21000000-21999999). Where Forever kept a classic object under a new entry, both now stand,
-- one inside the other: on the test realm 1,040 restore objects on the Eastern Kingdoms and Kalimdor share their spot
-- (within 0.05 yards in x, y and z) with a sniffed object of the same model (404 chairs and benches, city district
-- markers, Mighty Blaze fires and bonfires, anvils and forges, two mailboxes; no chest or other lootable object).
--
-- The restore copy is removed and the live game's copy kept, where:
--   - the sniffed object of the same model still stands within 0.05 yards of it (so nothing is left empty), and
--   - the restore copy belongs to no world event, pool, spawn group or script. The 33 that do (hourly bells, Call to
--     Arms signposts, night bonfires) are left: their sniffed twins were recorded while the event ran.
-- On the test realm that is 1,007 objects. None of them has an addon row, a pool, a spawn group or a script, and none
-- differs from its twin in phase or difficulty.
--
-- Running it again changes nothing: a row goes only while its twin still stands. Not checked in game.

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_object_doubles`;
CREATE TEMPORARY TABLE `everlake_object_doubles` (`guid` bigint unsigned NOT NULL PRIMARY KEY, `keep` bigint unsigned NOT NULL);
INSERT IGNORE INTO `everlake_object_doubles` (`guid`, `keep`)
SELECT a.`guid`, MIN(b.`guid`)
FROM `gameobject` a
JOIN `gameobject_template` ta ON ta.`entry` = a.`id`
JOIN `gameobject` b ON b.`map` = a.`map` AND b.`guid` BETWEEN 21000000 AND 21999999
  AND b.`position_x` BETWEEN a.`position_x` - 0.05 AND a.`position_x` + 0.05
  AND ABS(a.`position_y` - b.`position_y`) < 0.05 AND ABS(a.`position_z` - b.`position_z`) < 0.05
JOIN `gameobject_template` tb ON tb.`entry` = b.`id` AND tb.`displayId` = ta.`displayId`
WHERE a.`map` IN (0, 1) AND a.`guid` BETWEEN 30000000 AND 30999999
  AND NOT EXISTS (SELECT 1 FROM `game_event_gameobject` e WHERE e.`guid` = a.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `pool_members` p WHERE p.`type` = 1 AND p.`spawnId` = a.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `spawn_group` s WHERE s.`spawnType` = 1 AND s.`spawnId` = a.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` ss WHERE ss.`source_type` = 1 AND ss.`entryorguid` = -CAST(a.`guid` AS SIGNED))
GROUP BY a.`guid`;

DELETE x FROM `gameobject_addon` x JOIN `everlake_object_doubles` t ON t.`guid` = x.`guid`;
DELETE g FROM `gameobject` g JOIN `everlake_object_doubles` t ON t.`guid` = g.`guid`;

DROP TEMPORARY TABLE IF EXISTS `everlake_object_doubles`;

COMMIT;
