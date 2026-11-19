-- Removes quest pools that file 970 left with fewer quests than they keep active, which crashes the worldserver at start.
-- 2026_11_19_972_world_everlake_quest_pool_assert.sql: written by hand.
--
-- 970 (post-Wrath removal) deleted Cataclysm daily quests and their quest_pool_members rows, but kept the pools in
-- quest_pool_template: Tol Barad (40007-40014) and the cooking and fishing dailies (40000-40006, 40015-40021). At start
-- QuestPoolMgr checks a pool's numActive against its member list while the gaps the deleted quests left are still in
-- it, then drops the gaps. A pool that ends up with fewer members than numActive stops the worldserver:
--   QuestPools.cpp:41 in RegeneratePool ASSERTION FAILED (numActive <= members.size())
-- Both realms crash-looped on this after 970. Removed here: every pool that still has member rows but fewer quest
-- indices with an existing quest than it keeps active. Their remaining quests are Cataclysm dailies too; out of a pool
-- they are plain daily quests. Pools without any member rows (368, 369 from TDB) are never loaded and are left alone.
--
-- Not checked in game. Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

START TRANSACTION;
DROP TEMPORARY TABLE IF EXISTS `everlake_bad_pool`;
CREATE TEMPORARY TABLE `everlake_bad_pool` (`poolId` int unsigned NOT NULL PRIMARY KEY) ENGINE=InnoDB;
INSERT INTO `everlake_bad_pool` (`poolId`)
SELECT t.`poolId` FROM `quest_pool_template` t
LEFT JOIN (SELECT m.`poolId`, m.`poolIndex` FROM `quest_pool_members` m JOIN `quest_template` q ON q.`ID` = m.`questId` GROUP BY m.`poolId`, m.`poolIndex`) i ON i.`poolId` = t.`poolId`
WHERE EXISTS (SELECT 1 FROM `quest_pool_members` x WHERE x.`poolId` = t.`poolId`)
GROUP BY t.`poolId`, t.`numActive`
HAVING COUNT(i.`poolIndex`) < t.`numActive`;
DELETE m FROM `quest_pool_members` m JOIN `everlake_bad_pool` b ON b.`poolId` = m.`poolId`;
DELETE t FROM `quest_pool_template` t JOIN `everlake_bad_pool` b ON b.`poolId` = t.`poolId`;
DROP TEMPORARY TABLE `everlake_bad_pool`;
COMMIT;
