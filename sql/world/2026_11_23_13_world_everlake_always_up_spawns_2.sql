-- More quest and script creatures that stood in the world all the time.
-- 2026_11_23_13_world_everlake_always_up_spawns_2.sql: the second batch, written from the ForeverTracker's "Always up"
-- page after its first run on the test realm (2026-11-23). The page sees creatures that a summoning spell brings in,
-- which the first audit (file 2026_11_23_08) could not.
--
-- Each creature here is brought in by a spell or a script of ours, and none of VMaNGOS, AzerothCore or TrinityCore 3.3.5
-- keeps it spawned all the time. Standing for good, they could be fought without the quest or the boss fight, and the
-- spell or script then brought a second one in beside them. The spells and scripts stay as they are.
--
--   creature (entry)                  spawns  where                              brought in by                    came from
--   Scarlet Trooper (12352)               9   Eastern Plaguelands, one spot      a summoning spell                fork quest data restore
--   Treant Ally (5806)                    7   Kalimdor                           a summoning spell                fork quest data restore
--   Cloned Ectoplasm (5780)               5   The Barrens, by Wailing Caverns    a summoning spell                fork Azeroth NPC file
--   Serpentbloom Snake (3680)             3   The Barrens, by Wailing Caverns    summoning spell 6195            fork Azeroth NPC file
--   Exit Trigger (15800)                  1   Temple of Ahn'Qiraj                C'Thun stomach knockback (core)  fork quest data restore
--   Plague Wave (17293)                   1   Naxxramas, Heigan                  Heigan's eruptions (core)        fork quest data restore
--   total                                26
--
-- A spawn goes only while it still holds the same entry. With it go its addon, event, pool, spawn group, formation,
-- per-spawn script and linked respawn rows. Their rows in everlake_import_rows stay on purpose: the import slices put
-- a spawn back when neither the creature row nor its import record exists. The fork's files run once.
--
-- Left as it is, to look at in game first: Serpent Messenger (4068), 11 spawns around Thunder Bluff from the fork's
-- sniff maps.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_always_up`;
CREATE TEMPORARY TABLE `everlake_always_up` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY,
  `id` int unsigned NOT NULL
);
-- Scarlet Trooper (12352) x9
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (1235200, 12352), (1235201, 12352), (1235202, 12352), (1235203, 12352), (1235204, 12352), (1235205, 12352), (1235206, 12352), (1235207, 12352), (1235208, 12352);
-- Treant Ally (5806) x7
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (580600, 5806), (580601, 5806), (580602, 5806), (580603, 5806), (580604, 5806), (580605, 5806), (580606, 5806);
-- Cloned Ectoplasm (5780) x5
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (43000073, 5780), (43000074, 5780), (43000075, 5780), (43000076, 5780), (43000077, 5780);
-- Serpentbloom Snake (3680) x3
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (43000070, 3680), (43000071, 3680), (43000072, 3680);
-- Exit Trigger (15800), Plague Wave (17293)
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (1580000, 15800), (1729300, 17293);

-- keep only the rows whose spawn still holds that entry
DROP TEMPORARY TABLE IF EXISTS `everlake_always_up_go`;
CREATE TEMPORARY TABLE `everlake_always_up_go` (`guid` bigint unsigned NOT NULL PRIMARY KEY);
INSERT IGNORE INTO `everlake_always_up_go` (`guid`)
SELECT c.`guid` FROM `everlake_always_up` t JOIN `creature` c ON c.`guid` = t.`guid` AND c.`id` = t.`id`;

DELETE g FROM `game_event_creature` g JOIN `everlake_always_up_go` t ON t.`guid` = g.`guid`;
DELETE a FROM `creature_addon` a JOIN `everlake_always_up_go` t ON t.`guid` = a.`guid`;
DELETE p FROM `pool_members` p JOIN `everlake_always_up_go` t ON t.`guid` = p.`spawnId` WHERE p.`type` = 0;
DELETE s FROM `spawn_group` s JOIN `everlake_always_up_go` t ON t.`guid` = s.`spawnId` WHERE s.`spawnType` = 0;
DELETE f FROM `creature_formations` f JOIN `everlake_always_up_go` t ON t.`guid` = f.`memberGUID`;
DELETE f FROM `creature_formations` f JOIN `everlake_always_up_go` t ON t.`guid` = f.`leaderGUID`;
DELETE l FROM `linked_respawn` l JOIN `everlake_always_up_go` t ON t.`guid` = l.`guid`;
DELETE l FROM `linked_respawn` l JOIN `everlake_always_up_go` t ON t.`guid` = l.`linkedGuid`;
DELETE ss FROM `smart_scripts` ss JOIN `everlake_always_up_go` t ON ss.`entryorguid` = -CAST(t.`guid` AS SIGNED) WHERE ss.`source_type` = 0;
DELETE c FROM `creature` c JOIN `everlake_always_up_go` t ON t.`guid` = c.`guid`;

DROP TEMPORARY TABLE IF EXISTS `everlake_always_up_go`;
DROP TEMPORARY TABLE IF EXISTS `everlake_always_up`;

COMMIT;
