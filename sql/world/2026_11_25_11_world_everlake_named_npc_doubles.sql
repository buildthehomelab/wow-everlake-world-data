-- Named one-of-a-kind NPCs that stood twice, 20 to 70 yards apart.
-- 2026_11_25_11_world_everlake_named_npc_doubles.sql: written from the test realm's world (2026-11-25, tracker Query
-- page), after a player saw two Urs'anah, The Den Mother.
--
-- The fork's Azeroth NPC file (sql/custom/world/2026_10_27_70_world_azeroth_npcs_spawns_paths.sql, guids 43000000+)
-- added sniffed spawns from later beta builds and left out only those within 5 yards of the same NPC already in our
-- world. A named NPC sniffed at two moments stands in two places, so each of these got a second copy beside the one our
-- own sniff files (2026_10_01_03 / 2026_10_01_04, guids 211xxxxx and 212xxxxx) or the restore file (guid = entry*100)
-- already placed. Each creature below has exactly these two spawns on its map, no pool, no event, no path, no formation
-- and no per-spawn script; the Azeroth copy is removed and ours kept.
--
--   creature (entry)                  map   kept        removed     apart
--   Commander Belguilos (252666)     2991   21101021    43000247    22 yd
--   Malduko Cloudcrush (256935)      2991   21101584    43000367    27 yd
--   Commander Haalien (253622)       2991   21101309    43000313    27 yd
--   Vulgara the Insatiable (254589)  2991   21101473    43000426    29 yd
--   Urs'anah (251115)                2991   21100169    43000109    36 yd
--   Bruuz (209797)                      1   20979700    43000078    42 yd
--   Mogra (268685)                      1   21200633    43000080    54 yd
--   Prairie Dog (252429)                0   21200154    43000029    63 yd
--   Munchies (252428)                   0   21200153    43000028    64 yd
--   Oliver (277510)                     0   21200503    43000068    68 yd
--
-- Not touched: Azeroth rows of ordinary mobs near ours (Al'Aketh, Windshaper, Peacekeeper and the like), which are more
-- spots of a camp rather than a second copy of one NPC.
--
-- Running it again changes nothing: a row goes only while it still holds that entry and the kept twin still stands.

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_named_doubles`;
CREATE TEMPORARY TABLE `everlake_named_doubles` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY,
  `id` int unsigned NOT NULL,
  `keep` bigint unsigned NOT NULL
);
INSERT IGNORE INTO `everlake_named_doubles` (`guid`, `id`, `keep`) VALUES
(43000247, 252666, 21101021),
(43000367, 256935, 21101584),
(43000313, 253622, 21101309),
(43000426, 254589, 21101473),
(43000109, 251115, 21100169),
(43000078, 209797, 20979700),
(43000080, 268685, 21200633),
(43000029, 252429, 21200154),
(43000028, 252428, 21200153),
(43000068, 277510, 21200503);

DROP TEMPORARY TABLE IF EXISTS `everlake_named_doubles_go`;
CREATE TEMPORARY TABLE `everlake_named_doubles_go` (`guid` bigint unsigned NOT NULL PRIMARY KEY);
INSERT IGNORE INTO `everlake_named_doubles_go` (`guid`)
SELECT c.`guid` FROM `everlake_named_doubles` t
JOIN `creature` c ON c.`guid` = t.`guid` AND c.`id` = t.`id`
JOIN `creature` k ON k.`guid` = t.`keep` AND k.`id` = t.`id`;

DELETE g FROM `game_event_creature` g JOIN `everlake_named_doubles_go` t ON t.`guid` = g.`guid`;
DELETE a FROM `creature_addon` a JOIN `everlake_named_doubles_go` t ON t.`guid` = a.`guid`;
DELETE p FROM `pool_members` p JOIN `everlake_named_doubles_go` t ON t.`guid` = p.`spawnId` WHERE p.`type` = 0;
DELETE s FROM `spawn_group` s JOIN `everlake_named_doubles_go` t ON t.`guid` = s.`spawnId` WHERE s.`spawnType` = 0;
DELETE f FROM `creature_formations` f JOIN `everlake_named_doubles_go` t ON t.`guid` = f.`memberGUID`;
DELETE f FROM `creature_formations` f JOIN `everlake_named_doubles_go` t ON t.`guid` = f.`leaderGUID`;
DELETE l FROM `linked_respawn` l JOIN `everlake_named_doubles_go` t ON t.`guid` = l.`guid`;
DELETE l FROM `linked_respawn` l JOIN `everlake_named_doubles_go` t ON t.`guid` = l.`linkedGuid`;
DELETE ss FROM `smart_scripts` ss JOIN `everlake_named_doubles_go` t ON ss.`entryorguid` = -CAST(t.`guid` AS SIGNED) WHERE ss.`source_type` = 0;
DELETE c FROM `creature` c JOIN `everlake_named_doubles_go` t ON t.`guid` = c.`guid`;

DROP TEMPORARY TABLE IF EXISTS `everlake_named_doubles_go`;
DROP TEMPORARY TABLE IF EXISTS `everlake_named_doubles`;

COMMIT;
