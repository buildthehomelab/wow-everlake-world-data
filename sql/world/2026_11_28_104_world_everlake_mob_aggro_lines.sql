-- Creatures that call out when attacked on live ("Guards! Help me!", "Intruders! Attack the intruders!") but say nothing
-- on the realm.
-- 2026_11_28_104_world_everlake_mob_aggro_lines.sql: written by hand, not tried in game (2026-11-28).
--
-- Checked: Wowhead Forever's Quotes for every spawned creature (877 have some) against creature_text: 405 have none. Of
-- their 1,972 lines, 229 are said by other creatures on the realm too; those creatures' SmartAI says when. Here, the
-- lines they say as combat starts (event 4, or a link from it), for 125 creatures with no script of their own:
--   "Guards! Help me!" / "Guards!" (townsfolk, Marshal Dughan, Remy "Two Times", innkeepers, the Barrens and Crossroads
--   folk), "Sentinels, come to my defense!" (Kaldorei), "Intruders! Attack the intruders!" (Scarlet, Syndicate, Dark
--   Iron and others, 30% of fights), "I'll crush you!" / "Me smash! You die!" (ogres, 10%), the Booty Bay and goblin
--   bruisers' neutral-ground lines, "For the Horde!", "Enough!", "Argh!".
-- Each line copies the realm's other creature_text row for it (text, type, broadcast text, sound, emote) with Language 0,
-- so a dwarf does not shout in Orcish where the source was a Horde NPC. A creature's lines share group 0 (one is picked).
-- The SmartAI row is a Talk on aggro, with the source's chance and once-per-fight flag; the flight masters' summoning
-- of their guard birds that goes with "Guards! Help me!" is not copied.
-- Left out: lines said only by scripts (the Scourge invasion criers, the Stormwind children, bosses), lines with no
-- realm counterpart (the other 1,743: no BroadcastText id to give them), the lost-dog child, creatures with a C++ script
-- (Gordok Brute, the Alterac warmasters), and creatures whose SmartAI already talks.
-- Rows only go in while the creature has no creature_text rows, no ScriptName, an AIName of '' or SmartAI and no Talk
-- in its SmartAI; the new row takes the creature's next free SmartAI id. Every added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing.

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
SET @EVERLAKE_FILE := '2026_11_28_104_world_everlake_mob_aggro_lines.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_say`;
CREATE TEMPORARY TABLE `everlake_say` (`entry` INT UNSIGNED NOT NULL, `grp` TINYINT UNSIGNED NOT NULL, `idx` TINYINT UNSIGNED NOT NULL,
  `txt` TEXT NOT NULL, `type` TINYINT UNSIGNED NOT NULL, `lang` TINYINT UNSIGNED NOT NULL, `prob` FLOAT NOT NULL, `emote` INT UNSIGNED NOT NULL,
  `dur` INT UNSIGNED NOT NULL, `sound` INT UNSIGNED NOT NULL, `bt` INT NOT NULL, `range` TINYINT UNSIGNED NOT NULL, PRIMARY KEY (`entry`, `grp`, `idx`));
INSERT INTO `everlake_say` VALUES
(66,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(167,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(240,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(241,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(382,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(491,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(576,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(663,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(790,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(843,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(1070,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(1231,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1252,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1254,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1256,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1267,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1356,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1668,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(1681,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1682,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1683,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1692,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1721,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(1938,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(1952,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(1963,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(1977,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(2114,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2118,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2121,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2132,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2134,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2137,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2140,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2215,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2228,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(2277,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(2278,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2330,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(2394,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2397,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2401,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2418,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2430,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(2461,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(2770,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(2788,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(2810,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(2878,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(2930,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(3135,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(3137,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(3429,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3432,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3449,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3478,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3480,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3481,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3482,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3486,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3489,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3490,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3513,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(3539,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(3544,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(3547,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(3553,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(3555,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(3556,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(3557,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(3562,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(3601,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(3649,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(3845,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(3934,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3979,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(3996,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(4189,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(4190,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(4191,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(4192,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(4200,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(4209,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(4259,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(4265,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(4731,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(5124,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(5387,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(5471,0,0,'I''ll crush you!',12,0,100,0,0,0,1925,0),
(5471,0,1,'Me smash! You die!',12,0,100,0,0,0,1926,0),
(6286,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(6294,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(6389,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(6670,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(6736,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(6737,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(6739,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(7379,0,0,'I''ll crush you!',12,0,100,0,0,0,1925,0),
(7379,0,1,'Me smash! You die!',12,0,100,0,0,0,1926,0),
(7736,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(7941,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(7946,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(8671,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(8720,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(9553,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(9859,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(9979,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(9980,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(10052,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(10055,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(10276,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(12656,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(12716,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(15616,0,0,'For the Horde!',12,0,100,0,0,0,4921,0),
(15961,0,0,'As if we don''t have enough problems, you go and create more!',12,0,100,0,0,0,10953,0),
(15961,0,1,'Taste blade, mongrel!',12,0,100,0,0,0,10950,0),
(15961,0,2,'You dare spill blood on neutral ground? OUT! OUT, I SAY!',12,0,100,0,0,0,10948,0),
(16002,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(205153,0,0,'Enough!',12,0,100,0,0,0,7381,0),
(213077,0,0,'Guards! Help me!',12,0,100,0,0,0,4566,0),
(221206,0,0,'I''ll crush you!',12,0,100,0,0,0,1925,0),
(221206,0,1,'Me smash! You die!',12,0,100,0,0,0,1926,0),
(246152,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0),
(253092,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(253279,0,0,'Sentinels, come to my defense!',12,0,100,0,0,0,4562,0),
(255849,0,0,'I''ll crush you!',12,0,100,0,0,0,1925,0),
(255849,0,1,'Me smash! You die!',12,0,100,0,0,0,1926,0),
(255850,0,0,'I''ll crush you!',12,0,100,0,0,0,1925,0),
(255850,0,1,'Me smash! You die!',12,0,100,0,0,0,1926,0),
(256418,0,0,'Guards!',12,0,100,0,0,0,4561,0),
(258935,0,0,'Argh!',12,0,100,0,0,0,989,0),
(259611,0,0,'Intruders! Attack the intruders!',12,0,100,0,0,0,4484,0);

-- the aggro Talk: creature, chance, event flags (1 = once per fight), target type
DROP TEMPORARY TABLE IF EXISTS `everlake_sayai`;
CREATE TEMPORARY TABLE `everlake_sayai` (`entry` INT UNSIGNED NOT NULL PRIMARY KEY, `chance` TINYINT UNSIGNED NOT NULL, `eflags` SMALLINT UNSIGNED NOT NULL,
  `tt` TINYINT UNSIGNED NOT NULL, `rid` SMALLINT UNSIGNED NOT NULL DEFAULT 0, `ok` TINYINT NOT NULL DEFAULT 0);
INSERT INTO `everlake_sayai` (`entry`, `chance`, `eflags`, `tt`) VALUES
(66,100,1,1),
(167,100,0,1),
(240,100,1,1),
(241,100,1,1),
(382,100,1,1),
(491,100,1,1),
(576,100,1,1),
(663,100,1,1),
(790,100,1,1),
(843,100,1,1),
(1070,100,1,1),
(1231,100,0,1),
(1252,100,0,1),
(1254,100,0,1),
(1256,100,0,1),
(1267,100,0,1),
(1356,100,0,1),
(1668,100,1,1),
(1681,100,0,1),
(1682,100,0,1),
(1683,100,0,1),
(1692,100,0,1),
(1721,100,1,1),
(1938,30,1,1),
(1952,30,1,1),
(1963,100,0,1),
(1977,100,0,1),
(2114,30,1,1),
(2118,30,1,1),
(2121,30,1,1),
(2132,30,1,1),
(2134,30,1,1),
(2137,30,1,1),
(2140,30,1,1),
(2215,30,1,1),
(2228,100,1,1),
(2277,100,1,1),
(2278,30,1,1),
(2330,100,1,1),
(2394,30,1,1),
(2397,30,1,1),
(2401,30,1,1),
(2418,30,1,1),
(2430,100,1,1),
(2461,100,0,1),
(2770,30,1,1),
(2788,100,1,1),
(2810,100,1,1),
(2878,100,0,1),
(2930,100,1,1),
(3135,100,1,1),
(3137,100,1,1),
(3429,100,0,1),
(3432,100,0,1),
(3449,100,0,1),
(3478,100,0,1),
(3480,100,0,1),
(3481,100,0,1),
(3482,100,0,1),
(3486,100,0,1),
(3489,100,0,1),
(3490,100,0,1),
(3513,100,1,1),
(3539,30,1,1),
(3544,30,1,1),
(3547,30,1,1),
(3553,30,1,1),
(3555,30,1,1),
(3556,30,1,1),
(3557,30,1,1),
(3562,100,1,1),
(3601,100,1,1),
(3649,100,1,1),
(3845,100,1,1),
(3934,100,0,1),
(3979,100,0,1),
(3996,100,1,1),
(4189,100,1,1),
(4190,100,1,1),
(4191,100,1,1),
(4192,100,1,1),
(4200,100,1,1),
(4209,100,1,1),
(4259,100,0,1),
(4265,100,1,1),
(4731,30,1,1),
(5124,100,0,1),
(5387,100,0,1),
(5471,10,1,1),
(6286,100,1,1),
(6294,100,0,1),
(6389,30,1,1),
(6670,100,1,1),
(6736,100,1,1),
(6737,100,1,1),
(6739,30,1,1),
(7379,10,1,1),
(7736,100,1,1),
(7941,100,1,1),
(7946,100,1,1),
(8671,100,0,1),
(8720,100,0,1),
(9553,30,1,1),
(9859,100,0,1),
(9979,30,1,1),
(9980,100,0,1),
(10052,100,1,1),
(10055,30,1,1),
(10276,100,0,1),
(12656,100,1,1),
(12716,100,1,1),
(15616,50,0,1),
(15961,100,0,1),
(16002,100,1,1),
(205153,100,1,1),
(213077,100,1,1),
(221206,10,1,1),
(246152,30,1,1),
(253092,100,1,1),
(253279,100,1,1),
(255849,10,1,1),
(255850,10,1,1),
(256418,100,0,1),
(258935,100,1,1),
(259611,30,1,1);

UPDATE `everlake_sayai` a JOIN `creature_template` c ON c.`entry` = a.`entry`
SET a.`ok` = 1,
    a.`rid` = IFNULL((SELECT MAX(s.`id`) + 1 FROM `smart_scripts` s WHERE s.`entryorguid` = a.`entry` AND s.`source_type` = 0), 0)
WHERE IFNULL(c.`ScriptName`, '') = '' AND IFNULL(c.`AIName`, '') IN ('', 'SmartAI')
  AND NOT EXISTS (SELECT 1 FROM `creature_text` t WHERE t.`CreatureID` = a.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` s WHERE s.`entryorguid` = a.`entry` AND s.`source_type` = 0 AND s.`action_type` = 1);

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`,
    `SoundPlayType`, `BroadcastTextId`, `TextRange`, `comment`)
SELECT x.`entry`, x.`grp`, x.`idx`, x.`txt`, x.`type`, x.`lang`, x.`prob`, x.`emote`, x.`dur`, x.`sound`, 0, x.`bt`, x.`range`,
       'Everlake: aggro line (Wowhead Forever quotes)'
FROM `everlake_say` x JOIN `everlake_sayai` a ON a.`entry` = x.`entry` WHERE a.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_text', x.`entry`, x.`grp`, x.`idx`, 0, @EVERLAKE_FILE, CONCAT('aggro line, broadcast text ', x.`bt`)
FROM `everlake_say` x JOIN `everlake_sayai` a ON a.`entry` = x.`entry` WHERE a.`ok` = 1;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`,
    `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`,
    `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`,
    `action_param_string`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_param_string`,
    `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT a.`entry`, 0, a.`rid`, 0, '', 4, 0, a.`chance`, a.`eflags`, 0, 0, 0, 0, 0, '', 1, 0, 0, 0, 0, 0, 0, 0, '', a.`tt`, 0, 0, 0, 0, '',
       0, 0, 0, 0, 'Everlake: on aggro - say line (Wowhead Forever quotes)'
FROM `everlake_sayai` a WHERE a.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', a.`entry`, 0, a.`rid`, 0, @EVERLAKE_FILE, 'on aggro: say group 0' FROM `everlake_sayai` a WHERE a.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', c.`entry`, 0, 0, 104, @EVERLAKE_FILE, 'AIName '''' -> SmartAI (aggro line)'
FROM `everlake_sayai` a JOIN `creature_template` c ON c.`entry` = a.`entry` WHERE a.`ok` = 1 AND IFNULL(c.`AIName`, '') = '';
UPDATE `creature_template` c JOIN `everlake_sayai` a ON a.`entry` = c.`entry` SET c.`AIName` = 'SmartAI'
WHERE a.`ok` = 1 AND IFNULL(c.`AIName`, '') = '';

DROP TEMPORARY TABLE `everlake_sayai`;
DROP TEMPORARY TABLE `everlake_say`;

COMMIT;
