-- Quest and script creatures that stood in the world all the time, and holiday NPCs left up outside their holiday.
-- 2026_11_23_08_world_everlake_always_up_spawns.sql: written from an audit of the test realm's world (2026-11-23,
-- everlake-reports/always-up-spawns-audit-2026-11-23.md), the ForeverTracker's Spawn audit references and its new
-- "Always up" check.
--
-- Part 1 removes spawns of creatures that a script of ours brings in when a quest or event calls them, and that none
-- of VMaNGOS, AzerothCore or TrinityCore 3.3.5 keeps spawned all the time. Standing for good, they could be killed or
-- talked to without the quest, and the script then summoned a second one beside them. The scripts stay as they are.
--
--   creature (entry)                         spawns  brought in by                                  came from
--   Enraged Foulweald (12921)                   13   Foulweald totem script 17820500                AnoCore restore
--   Chief Murgut (12918)                         1   same                                           AnoCore restore
--   Wayward Buzzard (6013)                       2   quest end script 705                           AnoCore restore
--   Enraged Silverback Gorilla (1511)           12   Witch Doctor Unbagwa's "Stranglethorn Fever"   AnoCore restore
--   Konda (1516), Mokk the Savage (1514)      1+1   same                                           AnoCore restore
--   Ishamuhale (3257)                            1   event script 2998 (quest item)                 import slices 4/5
--   Echeyakee (3475)                             1   event script 2980 (Horn of Echeyakee)          import slices 4/5
--   Corbett Schneider (1433)                     1   quest end script 333                           fork Azeroth NPC file
--   Forlorn Spirit (2044)                        1   "The Legend of Stalvan" accept/finish          fork Azeroth NPC file
--   Defias Rioter (5043)                         2   Warden Thelwater's riot script                 fork Azeroth NPC file
--   Summoned Voidwalker (5676)                   2   warlock quest event scripts                    fork Azeroth NPC file
--   Male/Female Human Captive, Captive Ghoul,
--     Zombie, Abomination (5680-5687)            6   summon group of 5661                           fork Azeroth NPC file
--   Gunther's Visage (5666)                      1   quest end script 411                           fork sniff maps
--   Jezelle's Felhunter/Felsteed/Imp             3   Jezelle's demonstration script                 fork sniff maps
--   Herald of Thrall (10719)                     1   Thrall on quest 4974 rewarded                  fork sniff maps
--   Big Will (6238)                              2   "The Affray" (core script)                     fork quest data restore
--   total                                       51
--
-- A spawn goes only while it still holds the same entry. With it go its addon, event, pool, spawn group, formation,
-- per-spawn script and linked respawn rows. Their rows in everlake_import_rows stay on purpose: the import slices put
-- a spawn back when neither the creature row nor its import record exists. The fork's files run once.
--
-- Part 2 puts holiday spawns on their event. Each creature has other spawns already on that event; these ones were
-- left up all year.
--
--   Ribbon Pole Debug Target (17066)     46888                     Midsummer Fire Festival (1), 23 others on it
--   Belfry Bat (10716)                   21200026-21200029         Hourly Bells (78), 12 others on it
--   Frostwolf Envoy (15106)              21200535-21200539         Call to Arms: Alterac Valley (18), 24 others on it
--   Orphan Matron Aria (34365)           3436500                   Children's Week (10)
--
-- Left as they are, to look at in game first: Shadowy Assassin (Southshore), Gazban, the Gravelflint group, Pilot
-- Xiggs Fuselighter, Vengeful Phantom, Field Marshal Teravaine, Sentinel Selarin, Orphan Matron Battlewail and
-- Fizzlebang Booms.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_always_up`;
CREATE TEMPORARY TABLE `everlake_always_up` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY,
  `id` int unsigned NOT NULL
);
-- Foulweald totem: Enraged Foulweald (12921) x13, Chief Murgut (12918)
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (180805, 12921), (180806, 12921), (180807, 12921), (180808, 12921), (180809, 12921), (180810, 12921), (180811, 12921), (180812, 12921), (180813, 12921), (180814, 12921), (180815, 12921), (180816, 12921), (180817, 12921), (180818, 12918);
-- Wayward Buzzard (6013)
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (180825, 6013), (180826, 6013);
-- Stranglethorn Fever: Enraged Silverback Gorilla (1511) x12, Konda (1516), Mokk the Savage (1514)
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (180831, 1511), (180832, 1511), (180833, 1511), (180834, 1516), (180835, 1511), (180836, 1511), (180837, 1511), (180838, 1511), (180839, 1514), (180840, 1511), (180841, 1511), (180842, 1511), (180843, 1511), (180844, 1511);
-- Ishamuhale (3257), Echeyakee (3475)
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (900000005, 3257), (900000008, 3475);
-- Stormwind: Corbett Schneider (1433), Forlorn Spirit (2044), Defias Rioter (5043) x2
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (43000000, 1433), (43000001, 2044), (43000002, 5043), (43000003, 5043);
-- Undercity: Summoned Voidwalker (5676) x2, captives (5680 x2, 5681, 5685, 5686, 5687)
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (43000004, 5676), (43000005, 5676), (43000006, 5680), (43000007, 5680), (43000008, 5681), (43000009, 5685), (43000010, 5686), (43000011, 5687);
-- Undercity: Gunther's Visage (5666), Jezelle's Felhunter (5726), Felsteed (5727), Imp (5730)
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (21200016, 5666), (21200017, 5726), (21200018, 5727), (21200019, 5730);
-- Herald of Thrall (10719)
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (21200522, 10719);
-- Big Will (6238) x2
INSERT IGNORE INTO `everlake_always_up` (`guid`, `id`) VALUES (623800, 6238), (623801, 6238);

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

-- Part 2: holiday spawns onto their event, while the spawn still holds that entry and is on no event yet
DROP TEMPORARY TABLE IF EXISTS `everlake_always_up_event`;
CREATE TEMPORARY TABLE `everlake_always_up_event` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY,
  `id` int unsigned NOT NULL,
  `eventEntry` tinyint NOT NULL
);
INSERT IGNORE INTO `everlake_always_up_event` (`guid`, `id`, `eventEntry`) VALUES
(46888, 17066, 1),
(21200026, 10716, 78), (21200027, 10716, 78), (21200028, 10716, 78), (21200029, 10716, 78),
(21200535, 15106, 18), (21200536, 15106, 18), (21200537, 15106, 18), (21200538, 15106, 18), (21200539, 15106, 18),
(3436500, 34365, 10);

INSERT INTO `game_event_creature` (`eventEntry`, `guid`)
SELECT t.`eventEntry`, t.`guid` FROM `everlake_always_up_event` t
JOIN `creature` c ON c.`guid` = t.`guid` AND c.`id` = t.`id`
JOIN `game_event` e ON e.`eventEntry` = t.`eventEntry`
WHERE NOT EXISTS (SELECT 1 FROM `game_event_creature` g WHERE g.`guid` = t.`guid`);

DROP TEMPORARY TABLE IF EXISTS `everlake_always_up_event`;

COMMIT;
