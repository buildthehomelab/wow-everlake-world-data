-- Quest objects in dungeons that the realm has templates and loot for but never spawned (tracker quest gaps, 2026-11-26).
-- 2026_11_26_51_world_everlake_dungeon_quest_objects.sql: written by hand, not tried in game.
--
-- No source the tracker has gives a position for these objects (Wowhead Forever shows them only as "in a dungeon",
-- Icy Veins and EG Link have no spawn points). Every spot below is INFERRED from the Wowhead Forever comments quoted,
-- placed next to the realm's own spawn of the boss the comment names, with the height of the server's maps and
-- vmaps (ForeverTracker tools/height.py). Orientation 0, rotation 0 and a 30 s respawn (60 s for the Root Caps, which
-- each player needs 10 of) are INFERRED. A look in game should move them where live has them.
--
--   660624 The Coldbringer's Eye (96773, 97196), Razorfen Downs (129): "on the left of the last boss. you click it to
--     pick it up" (Wowhead quest 96773). 5 yards to the left of Amnennar the Coldbringer (7358) as one faces him.
--   650929 The Lost Magic of the Runemasters (96800), Scarlet Monastery Library (189): "in the last boss room of
--     Arcanist Doan ... On a table on the right side. Red colour book." (Wowhead quest 96800). On the desk on the right
--     as one walks into Doan's room, beside the realm's Civil War in the Plaguelands book (175761), height of the desk top.
--   660652 Shard of Pure Light (96776, item An'she's Radiance), Maraudon (349): "its behind the Mountain Giant Boss"
--     (Wowhead item 277140), read as Landslide (12203): 8 yards behind his spawn.
--   612179 Earth Song Splash (93404, Vial of Earth Song Water), Maraudon (349): "Interactable object below a rock bridge
--     near the crocolisk boss ... the bridge to final boss (Princess). Once you kill the boss, you jump down and swim to
--     the cave opposite ... in the water." (Wowhead object 612179). On the water floor at Rotgrip's (13596) spawn.
--   570888 Totem of Ursol (92066), Blackmaw Hold (2974): "Located in the room of Elder Shaman Bloodmane, on the opposite
--     side on a pedestal." (Wowhead item 249693). 13 yards west of Elder Shaman Bloodmane (247209), across from his
--     Devotees.
--   570890 Totem of Ursoc (92066), Blackmaw Hold (2974): "outside the room of Blackmaw Behemoth and Clawbert" (Wowhead
--     item 249694). 12 yards in front of Blackmaw Behemoth (247207), the way it faces.
--   571511 Nordrassil Root Cap x14 (92343, 92344, 10 each), Blackmaw Hold (2974): "collected from the walls inside the
--     big cave ... after killing the first three bosses ... Level 3 and the levels below it" (Wowhead item 250773).
--     A few yards from the realm's creature groups below the first three bosses (z 145-231).
--   648579 Drained Crystal Fragment (95926), Shaper's Terrace (3001): "On the floor, next to the achromatic Crystal in
--     the Tar Pits" (Wowhead quest 95926); "The Achromatic Crystal is in the middle of the tar pit to the east of the
--     entrance towards Thunderhoof" (Wowhead quest 95925). Between Venomridge (261813) and the tar pit's Archival Panel.
--
-- Own guid block 920019600-920019799 (920019600-920019620 used). Each spawn is added only while its guid is free and
-- the object has no spawn yet, and recorded in everlake_import_rows. Never edit this file once it is deployed: a later
-- fix is a new file. Running it again changes nothing.

CREATE TABLE IF NOT EXISTS `everlake_import_rows` (
  `tbl` varchar(64) NOT NULL COMMENT 'world table of the row',
  `k1` bigint NOT NULL COMMENT 'the row''s key, in the table''s primary key order',
  `k2` bigint NOT NULL DEFAULT '0',
  `k3` bigint NOT NULL DEFAULT '0',
  `k4` bigint NOT NULL DEFAULT '0',
  `file` varchar(200) NOT NULL COMMENT 'the update file that added the row',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT 'the sources that gave it',
  PRIMARY KEY (`tbl`, `k1`, `k2`, `k3`, `k4`),
  KEY `file` (`file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';
SET @EVERLAKE_FILE := '2026_11_26_51_world_everlake_dungeon_quest_objects.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_dqo_stage`;
CREATE TEMPORARY TABLE `everlake_dqo_stage` (
  `guid` bigint unsigned NOT NULL PRIMARY KEY, `id` int unsigned NOT NULL, `map` smallint unsigned NOT NULL,
  `diff` varchar(100) NOT NULL, `x` float NOT NULL, `y` float NOT NULL, `z` float NOT NULL, `respawn` int NOT NULL,
  `note` varchar(255) NOT NULL, `ok` tinyint NOT NULL DEFAULT 0);
INSERT INTO `everlake_dqo_stage` (`guid`, `id`, `map`, `diff`, `x`, `y`, `z`, `respawn`, `note`) VALUES
(920019600, 660624, 129, '1', 2407.0, 964.4, 55.24, 30, 'INFERRED: left of Amnennar (Wowhead quest 96773 comment); height.py'),
(920019601, 650929, 189, '1', 148.8, -412.2, 19.84, 30, 'INFERRED: table on the right in Doan''s room (Wowhead quest 96800 comments); height.py'),
(920019602, 660652, 349, '1', 364.3, -183.0, -59.90, 30, 'INFERRED: behind Landslide (Wowhead item 277140 comment); height.py'),
(920019603, 612179, 349, '1', 42.1, -66.0, -206.28, 30, 'INFERRED: in the water at Rotgrip (Wowhead object 612179 comment); height.py'),
(920019604, 570888, 2974, '1,201', 3482.0, 3168.0, 125.65, 30, 'INFERRED: Bloodmane''s room, opposite side (Wowhead item 249693 comment); height.py'),
(920019605, 570890, 2974, '1,201', 3659.1, 2915.4, 247.92, 30, 'INFERRED: outside Behemoth and Clawbert''s room (Wowhead item 249694 comment); height.py'),
(920019606, 571511, 2974, '1,201', 3554.0, 2981.0, 144.98, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019607, 571511, 2974, '1,201', 3496.0, 3036.0, 145.38, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019608, 571511, 2974, '1,201', 3469.0, 3056.0, 164.07, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019609, 571511, 2974, '1,201', 3556.0, 3116.0, 184.88, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019610, 571511, 2974, '1,201', 3309.0, 2926.0, 203.56, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019611, 571511, 2974, '1,201', 3436.0, 2854.0, 204.02, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019612, 571511, 2974, '1,201', 3414.0, 2836.0, 209.71, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019613, 571511, 2974, '1,201', 3331.0, 2881.0, 208.14, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019614, 571511, 2974, '1,201', 3404.0, 2889.0, 213.28, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019615, 571511, 2974, '1,201', 3524.0, 2829.0, 223.26, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019616, 571511, 2974, '1,201', 3349.0, 2981.0, 230.35, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019617, 571511, 2974, '1,201', 3686.0, 2941.0, 191.01, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019618, 571511, 2974, '1,201', 3589.0, 2946.0, 172.15, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019619, 571511, 2974, '1,201', 3651.0, 2874.0, 172.07, 60, 'INFERRED: big cave below the first three bosses (Wowhead item 250773 comment); height.py'),
(920019620, 648579, 3001, '1,201', -5921.0, -1217.0, 9.27, 30, 'INFERRED: by the Achromatic Crystal in the tar pit (Wowhead quests 95925/95926 comments); height.py');
-- a spawn goes in while its guid is free, the template exists and the object has no spawn but this file's own
UPDATE `everlake_dqo_stage` s SET s.`ok` = 1
WHERE EXISTS (SELECT 1 FROM `gameobject_template` t WHERE t.`entry` = s.`id`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`id` = s.`id` AND (g.`guid` < 920019600 OR g.`guid` > 920019799));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, s.`map`, 0, 0, s.`diff`, 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, s.`respawn`, 255, 1, '', NULL, 0
FROM `everlake_dqo_stage` s WHERE s.`ok` = 1 ORDER BY s.`guid`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', s.`guid`, 0, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_dqo_stage` s WHERE s.`ok` = 1;
DROP TEMPORARY TABLE `everlake_dqo_stage`;

COMMIT;
