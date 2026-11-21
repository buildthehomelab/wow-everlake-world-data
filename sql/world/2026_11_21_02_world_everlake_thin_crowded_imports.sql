-- Thin the Forever-only creatures that imports spawned far more often than live shows them.
-- 2026_11_21_02_world_everlake_thin_crowded_imports.sql: written from the ForeverTracker's Extras > Crowded list.
--
-- These 20 creatures exist only in Forever. Their spawns came from imports (the quest-drop and NPC batches, and the
-- fork's sniffs on map 2991). Those imports placed a spawn per cell around every point any source recorded, so a
-- creature stood 2 to 10 times as often as Wowhead's Forever map marks. For Classic creatures, which QuestieDB's
-- Classic list confirms, the realm holds about twice Wowhead's marks (Wowhead merges spots that stand close), so
-- that is the target here too.
--
-- How each creature was thinned (test realm world, 2026-11-21). Wowhead's points were moved onto the world with the
-- client's UiMapAssignment rects. Only spawns within 150 yards of the box around them were judged; spawns elsewhere
-- stay. Pooled, event and formation spawns were kept (none of these had any). The nearest spawn to each Wowhead
-- point was kept, then more nearest-first up to twice Wowhead's marks. The rest go.
--
--   creature (entry)                     spawns  Wowhead  removed
--   Al'Aketh Convert (251160)                20        7        6
--   Ancient Fire Elemental (217305)          18        3       12
--   Blackthorne Adept (264570)               74       16       40
--   Converted Farmer (259258)                 9        2        5
--   Doomguard (249236)                       29        5        4
--   Eastsea Bombardier (257916)              86       34       18
--   Fireflies (251437)                       53       14       25
--   Hoarder (251428)                         32        3       26
--   Juvenile Vuldren (250873)                55       22       11
--   Minor Ice Elemental (276003)             63       21       21
--   Mountain Squallclimber (249491)         110       40       29
--   Nascent Pylon Protector (276401)         48        9       23
--   Nightveiled Rotheap (270589)             57       12       26
--   Outcast Scout (254283)                   82       10       38
--   Razormane Raider (268624)                44       19        6
--   Ridgeshade Lurker (266849)               58       22       14
--   Scourge Reanimator (260148)              15        5        5
--   Skyhopper (251314)                       57       23       11
--   Spectral Frostwyrm (255691)              11        2        5
--   Twilight Mauler (260968)                 70       25       20
--   total                                                     345
--
-- A spawn goes only while it still holds the same entry. With it go its addon, event, pool, spawn group and
-- formation rows. Its rows in everlake_import_rows stay on purpose: the import slices put a spawn back when neither
-- the creature row nor its import record exists, so the record is what keeps a re-run from bringing it back. The
-- quest-drop imports add spawns only while the creature has none; the fork's files run once.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_thin_crowded`;
CREATE TEMPORARY TABLE `everlake_thin_crowded` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY,
  `id` int unsigned NOT NULL
);
-- Al'Aketh Convert (251160): 6
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (21100199, 251160), (21100201, 251160), (21100207, 251160), (21100208, 251160), (43000118, 251160), (43000119, 251160);
-- Ancient Fire Elemental (217305): 12
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920006001, 217305), (920006003, 217305), (920006004, 217305), (920006005, 217305), (920006006, 217305), (920006007, 217305), (920006009, 217305), (920006010, 217305), (920006012, 217305), (920006015, 217305), (920006016, 217305), (920006017, 217305);
-- Blackthorne Adept (264570): 40
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920003193, 264570), (920003194, 264570), (920003195, 264570), (920003197, 264570), (920003204, 264570), (920003208, 264570), (920003210, 264570), (920003213, 264570), (920003214, 264570), (920003215, 264570), (920003218, 264570), (920003222, 264570), (920003223, 264570), (920003227, 264570), (920003231, 264570), (920003236, 264570), (920003240, 264570), (920003241, 264570), (920003242, 264570), (920003244, 264570), (920003245, 264570), (920003246, 264570), (920003247, 264570), (920003248, 264570), (920003249, 264570), (920003250, 264570), (920003251, 264570), (920003253, 264570), (920003254, 264570), (920003255, 264570), (920003256, 264570), (920003257, 264570), (920003259, 264570), (920003260, 264570), (920003261, 264570), (920003262, 264570), (920003263, 264570), (920003264, 264570), (920003265, 264570), (920003266, 264570);
-- Converted Farmer (259258): 5
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920002073, 259258), (920002074, 259258), (920002077, 259258), (920002078, 259258), (920002079, 259258);
-- Doomguard (249236): 4
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920003020, 249236), (920003021, 249236), (920003022, 249236), (920003026, 249236);
-- Eastsea Bombardier (257916): 18
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920004804, 257916), (920004805, 257916), (920004807, 257916), (920004808, 257916), (920004817, 257916), (920004818, 257916), (920004822, 257916), (920004833, 257916), (920004835, 257916), (920004839, 257916), (920004842, 257916), (920004851, 257916), (920004852, 257916), (920004854, 257916), (920004858, 257916), (920004864, 257916), (920004865, 257916), (920004868, 257916);
-- Fireflies (251437): 25
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (21100489, 251437), (21100493, 251437), (21100497, 251437), (21100498, 251437), (21100500, 251437), (21100501, 251437), (21100510, 251437), (21100511, 251437), (21100512, 251437), (21100513, 251437), (21100516, 251437), (21100517, 251437), (21100520, 251437), (21100524, 251437), (21100525, 251437), (21100526, 251437), (21100527, 251437), (21100530, 251437), (21100531, 251437), (21100532, 251437), (21100533, 251437), (21100535, 251437), (21100536, 251437), (21100538, 251437), (43000175, 251437);
-- Hoarder (251428): 26
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (21100467, 251428), (21100468, 251428), (21100469, 251428), (21100470, 251428), (21100471, 251428), (21100472, 251428), (21100473, 251428), (21100474, 251428), (21100475, 251428), (21100476, 251428), (21100477, 251428), (21100478, 251428), (21100479, 251428), (21100481, 251428), (21100482, 251428), (21100483, 251428), (21100484, 251428), (21100485, 251428), (21100487, 251428), (21100488, 251428), (43000167, 251428), (43000170, 251428), (43000171, 251428), (43000172, 251428), (43000173, 251428), (43000174, 251428);
-- Juvenile Vuldren (250873): 11
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (21100039, 250873), (21100062, 250873), (21100068, 250873), (21100071, 250873), (21100072, 250873), (21100080, 250873), (21100081, 250873), (21100083, 250873), (21100086, 250873), (21100087, 250873), (43000091, 250873);
-- Minor Ice Elemental (276003): 21
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (26300004, 276003), (26300008, 276003), (27600300, 276003), (27600301, 276003), (27600302, 276003), (27600303, 276003), (27600306, 276003), (27600307, 276003), (27600311, 276003), (27600312, 276003), (27600313, 276003), (27600315, 276003), (27600319, 276003), (27600320, 276003), (27600327, 276003), (27600332, 276003), (27600333, 276003), (27600335, 276003), (27600339, 276003), (27600340, 276003), (27600341, 276003);
-- Mountain Squallclimber (249491): 29
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920001336, 249491), (920001338, 249491), (920001347, 249491), (920001348, 249491), (920001349, 249491), (920001350, 249491), (920001351, 249491), (920001355, 249491), (920001357, 249491), (920001358, 249491), (920001359, 249491), (920001360, 249491), (920001361, 249491), (920001362, 249491), (920001365, 249491), (920001369, 249491), (920001372, 249491), (920001385, 249491), (920001387, 249491), (920001391, 249491), (920001408, 249491), (920001412, 249491), (920001414, 249491), (920001416, 249491), (920001417, 249491), (920001418, 249491), (920001422, 249491), (920001424, 249491), (920001429, 249491);
-- Nascent Pylon Protector (276401): 23
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920005001, 276401), (920005004, 276401), (920005007, 276401), (920005009, 276401), (920005012, 276401), (920005014, 276401), (920005017, 276401), (920005018, 276401), (920005019, 276401), (920005020, 276401), (920005022, 276401), (920005023, 276401), (920005024, 276401), (920005025, 276401), (920005026, 276401), (920005027, 276401), (920005028, 276401), (920005029, 276401), (920005031, 276401), (920005033, 276401), (920005034, 276401), (920005035, 276401), (920005036, 276401);
-- Nightveiled Rotheap (270589): 26
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (27058904, 270589), (27058908, 270589), (27058922, 270589), (27058924, 270589), (27058925, 270589), (27058926, 270589), (27058927, 270589), (27058928, 270589), (27058929, 270589), (27058930, 270589), (27058931, 270589), (27058932, 270589), (27058933, 270589), (27058934, 270589), (27058936, 270589), (27058937, 270589), (27058938, 270589), (27058939, 270589), (27058940, 270589), (27058941, 270589), (27058942, 270589), (27058951, 270589), (27058953, 270589), (27058954, 270589), (27058955, 270589), (27058956, 270589);
-- Outcast Scout (254283): 38
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920004730, 254283), (920004731, 254283), (920004732, 254283), (920004733, 254283), (920004734, 254283), (920004735, 254283), (920004736, 254283), (920004737, 254283), (920004738, 254283), (920004739, 254283), (920004740, 254283), (920004741, 254283), (920004742, 254283), (920004743, 254283), (920004745, 254283), (920004747, 254283), (920004749, 254283), (920004750, 254283), (920004752, 254283), (920004753, 254283), (920004754, 254283), (920004755, 254283), (920004757, 254283), (920004758, 254283), (920004759, 254283), (920004760, 254283), (920004761, 254283), (920004762, 254283), (920004763, 254283), (920004764, 254283), (920004766, 254283), (920004767, 254283), (920004769, 254283), (920004770, 254283), (920004772, 254283), (920004776, 254283), (920004780, 254283), (920004781, 254283);
-- Razormane Raider (268624): 6
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (26862413, 268624), (26862416, 268624), (26862419, 268624), (26862436, 268624), (26862440, 268624), (26862441, 268624);
-- Ridgeshade Lurker (266849): 14
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (26684918, 266849), (26684922, 266849), (26684923, 266849), (26684926, 266849), (26684927, 266849), (26684935, 266849), (26684936, 266849), (26684937, 266849), (26684940, 266849), (26684941, 266849), (900000015, 266849), (900000019, 266849), (900000026, 266849), (900000029, 266849);
-- Scourge Reanimator (260148): 5
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920001450, 260148), (920001453, 260148), (920001455, 260148), (920001457, 260148), (920001459, 260148);
-- Skyhopper (251314): 11
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (21100399, 251314), (21100403, 251314), (21100404, 251314), (21100414, 251314), (21100415, 251314), (21100427, 251314), (21100428, 251314), (21100431, 251314), (21100440, 251314), (21100441, 251314), (43000161, 251314);
-- Spectral Frostwyrm (255691): 5
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920003091, 255691), (920003094, 255691), (920003097, 255691), (920003099, 255691), (920003100, 255691);
-- Twilight Mauler (260968): 20
INSERT IGNORE INTO `everlake_thin_crowded` (`guid`, `id`) VALUES (920004872, 260968), (920004874, 260968), (920004876, 260968), (920004879, 260968), (920004882, 260968), (920004889, 260968), (920004891, 260968), (920004895, 260968), (920004900, 260968), (920004906, 260968), (920004909, 260968), (920004912, 260968), (920004914, 260968), (920004920, 260968), (920004921, 260968), (920004923, 260968), (920004927, 260968), (920004933, 260968), (920004934, 260968), (920004936, 260968);

-- keep only the rows whose spawn still holds that entry
DROP TEMPORARY TABLE IF EXISTS `everlake_thin_crowded_go`;
CREATE TEMPORARY TABLE `everlake_thin_crowded_go` (`guid` bigint unsigned NOT NULL PRIMARY KEY);
INSERT IGNORE INTO `everlake_thin_crowded_go` (`guid`)
SELECT c.`guid` FROM `everlake_thin_crowded` t JOIN `creature` c ON c.`guid` = t.`guid` AND c.`id` = t.`id`;

DELETE g FROM `game_event_creature` g JOIN `everlake_thin_crowded_go` t ON t.`guid` = g.`guid`;
DELETE a FROM `creature_addon` a JOIN `everlake_thin_crowded_go` t ON t.`guid` = a.`guid`;
DELETE p FROM `pool_members` p JOIN `everlake_thin_crowded_go` t ON t.`guid` = p.`spawnId` WHERE p.`type` = 0;
DELETE s FROM `spawn_group` s JOIN `everlake_thin_crowded_go` t ON t.`guid` = s.`spawnId` WHERE s.`spawnType` = 0;
DELETE f FROM `creature_formations` f JOIN `everlake_thin_crowded_go` t ON t.`guid` = f.`memberGUID`;
DELETE c FROM `creature` c JOIN `everlake_thin_crowded_go` t ON t.`guid` = c.`guid`;

DROP TEMPORARY TABLE IF EXISTS `everlake_thin_crowded_go`;
DROP TEMPORARY TABLE IF EXISTS `everlake_thin_crowded`;

COMMIT;
