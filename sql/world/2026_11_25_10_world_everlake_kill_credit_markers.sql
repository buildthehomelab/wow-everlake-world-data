-- Quest credit for Forever quests whose objectives are hidden "Kill Credit" creatures that nothing on the realm gives.
-- 2026_11_25_10_world_everlake_kill_credit_markers.sql: written by hand, not tried in game.
--
-- Live gives these credits from the server side, mostly with a spell whose client SpellEffect is a kill credit
-- (effect 90 or 134, EffectMiscValue1 = the credit creature, target the caster). The core has no script for any of
-- the NPCs, objects, spells or quests below (checked in the fork's src/ and sql/custom/).
--
-- 1. Talking to an NPC. Icy Veins (npc relations.addon_gossip) and EG Link (npcs.json "options") record the option
--    that delivers or decides, but no source records the gossip menu ids, so the realm cannot offer the option itself.
--    As for Orokai and Mulara (2026_11_23_23, 2026_11_23_19), the credit comes when the player opens the NPC's gossip
--    while the quest is in the log: the player casts the client's credit spell on themselves (SELF_CAST on the
--    invoker, triggered), with a SmartAI condition that the quest is incomplete. A player who just took the quest
--    from the same NPC talks to them once more.
--      93016 A Brief History Lesson: Mordent Evenshade (253471), "Tell me about the crystals I repaired." (option
--        136621) -> 1259496 Kill Credit (DNT), credit 253623 "Speak with Mordent Evenshade".
--      96322 A Revenge Now Bitter: Felflick (263757), "<Give Felflick the iron key.>" / "<Don't give Felflick the
--        key.>" (139703 / 139702), either one decides -> 1292773 Kill Credit (DNT), credit 264707.
--      96622 A Rest Without Pain: Enho Runehoof (265862), "I have brought a poultice from Ortak for you." (139999)
--        -> 1295887, credit 265899; Maruke (265895), the same line (139998) -> 1295888, credit 265900. Neither has a
--        gossip flag on the realm; live has their gossip, so they get one.
-- 2. 95432 Rise Up! ("Recruit 5 Ogre Miners") counts credit 260417 "[DNT] Kill Credit: Ogre Miner". The client's
--    creature record for the Ogre Miner (260995) names 260417 as its proxy creature (EG Link creature_details,
--    proxyCreatureIds, builds 70338 to 71037), so 260417 is its KillCredit1, as on live. Cragrog's completion text
--    ("We kill weak, coward ogres") fits. The miner's gossip option 138957 "Clugfist says to join him in Bolder'ok."
--    is not scripted: no source says what it does.
-- 3. 95108 Mystic Mix ("destroy two Deadwood Cauldrons") counts credits 260373 and 260374. The cauldrons' templates
--    were missing. Both come from Icy Veins' gameobject records (type 10, model 122577, size 3.5, Data0-34 as
--    recorded): Data1 = 95108 (usable only on the quest), Data10 = the spell, Data23 = 1 (the player casts it).
--    In the client, 630780's 1283593 Destroy force-casts 1283583, a kill credit for 260373 ("First Cauldron
--    Destroyed"), and 630760's 1283601 force-casts 1283523, a kill credit for 260374 ("Second Cauldron Destroyed"),
--    so the core gives the credit by itself. One spawn each, at Wowhead's map point (Mount Hyjal 31.1 56.8 and
--    30.3 58.1, uiMap 2482), turned into a world position with the client's UiMapAssignment and the height of the
--    realm's terrain (ForeverTracker tools/height.py), next to the realm's Deadwood Den spawns. Orientation 0,
--    rotation 0 and respawn 120 s are INFERRED, as in 2026_11_22_02.
--
-- Guids: objects 920018000-920018001, a block of their own (920018000-920018099).
-- Rows are only added where none exist, and AI only where the NPC has none. Each added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again
-- changes nothing.

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
SET @EVERLAKE_FILE := '2026_11_25_10_world_everlake_kill_credit_markers.sql';

START TRANSACTION;

-- 1. Gossip hello -> the player casts the credit spell, while the quest is incomplete.
DROP TEMPORARY TABLE IF EXISTS `everlake_kc_stage`;
CREATE TEMPORARY TABLE `everlake_kc_stage` (`entry` int unsigned NOT NULL, `quest` int unsigned NOT NULL, `spell` int unsigned NOT NULL, `gossip_flag` tinyint NOT NULL, `comment` varchar(255) NOT NULL, `ok` tinyint NOT NULL DEFAULT '0', PRIMARY KEY (`entry`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_kc_stage` (`entry`, `quest`, `spell`, `gossip_flag`, `comment`) VALUES
(253471, 93016, 1259496, 0, 'Mordent Evenshade - On gossip hello - Player casts 1259496 credit 253623 (A Brief History Lesson 93016)'),
(263757, 96322, 1292773, 0, 'Felflick - On gossip hello - Player casts 1292773 credit 264707 (A Revenge Now Bitter 96322)'),
(265862, 96622, 1295887, 1, 'Enho Runehoof - On gossip hello - Player casts 1295887 credit 265899 (A Rest Without Pain 96622)'),
(265895, 96622, 1295888, 1, 'Maruke - On gossip hello - Player casts 1295888 credit 265900 (A Rest Without Pain 96622)');
UPDATE `everlake_kc_stage` s
JOIN `creature_template` c ON c.`entry` = s.`entry` AND c.`AIName` = '' AND c.`ScriptName` = ''
JOIN `quest_template` q ON q.`ID` = s.`quest`
SET s.`ok` = 1
WHERE NOT EXISTS (SELECT 1 FROM `smart_scripts` d WHERE d.`entryorguid` = s.`entry` AND d.`source_type` = 0);

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT s.`entry`, 0, 0, 0, '', 64, 0, 100, 0, 0, 0, 0, 0, 0, '', 85, s.`spell`, 2, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, s.`comment`
FROM `everlake_kc_stage` s WHERE s.`ok` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', s.`entry`, 0, 0, 0, @EVERLAKE_FILE, CONCAT('Icy Veins+EG Link gossip options; client SpellEffect ', s.`spell`)
FROM `everlake_kc_stage` s WHERE s.`ok` = 1;

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 22, 1, s.`entry`, 0, 0, 47, 0, s.`quest`, 8, 0, '', 0, 0, 0, '', CONCAT('Credit on gossip hello only while quest ', s.`quest`, ' is incomplete')
FROM `everlake_kc_stage` s WHERE s.`ok` = 1
  AND NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 22 AND c.`SourceGroup` = 1 AND c.`SourceEntry` = s.`entry` AND c.`SourceId` = 0 AND c.`ElseGroup` = 0 AND c.`ConditionTypeOrReference` = 47 AND c.`ConditionTarget` = 0 AND c.`ConditionValue1` = s.`quest` AND c.`ConditionValue2` = 8 AND c.`ConditionValue3` = 0);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 22, 1, s.`entry`, 0, @EVERLAKE_FILE, CONCAT('quest ', s.`quest`, ' incomplete')
FROM `everlake_kc_stage` s WHERE s.`ok` = 1;

UPDATE `creature_template` c JOIN `everlake_kc_stage` s ON s.`entry` = c.`entry`
SET c.`AIName` = 'SmartAI', c.`npcflag` = c.`npcflag` | s.`gossip_flag`
WHERE s.`ok` = 1 AND c.`AIName` = '' AND c.`ScriptName` = '';
DROP TEMPORARY TABLE IF EXISTS `everlake_kc_stage`;

-- 2. Ogre Miner (260995): the client's proxy creature 260417 as KillCredit1.
UPDATE `creature_template` SET `KillCredit1` = 260417
WHERE `entry` = 260995 AND `KillCredit1` = 0 AND `KillCredit2` <> 260417;

-- 3. Deadwood Cauldrons (630760, 630780): templates and one spawn each.
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT t.`entry`, 10, 122577, 'Deadwood Cauldron', '', '', '', 3.5, 0, 95108, 0, 3000, 0, 0, 0, 0, 0, 0, t.`spell`, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, t.`cond`, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0
FROM (SELECT 630760 AS `entry`, 1283601 AS `spell`, 152692 AS `cond` UNION ALL SELECT 630780, 1283593, 152697) t
WHERE NOT EXISTS (SELECT 1 FROM `gameobject_template` g WHERE g.`entry` = t.`entry`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', g.`entry`, 0, 0, 0, @EVERLAKE_FILE, CONCAT('Icy Veins gameobject=', g.`entry`)
FROM `gameobject_template` g WHERE g.`entry` IN (630760, 630780) AND g.`type` = 10 AND g.`Data1` = 95108
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'gameobject_template' AND r.`k1` = g.`entry`);

INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT s.`guid`, s.`id`, 1, 0, 0, '0', 0, 0, 0, -1, s.`x`, s.`y`, s.`z`, 0, 0, 0, 0, 1, 120, 255, 1, '', NULL, 0 FROM (
  SELECT 920018000 AS `guid`, 630760 AS `id`, 4989.48 AS `x`, -2002.99 AS `y`, 1375.39 AS `z`
  UNION ALL SELECT 920018001, 630780, 4959.39, -1975.21, 1426.32
) s
WHERE EXISTS (SELECT 1 FROM `gameobject_template` t WHERE t.`entry` = s.`id`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`guid` = s.`guid`)
  AND NOT EXISTS (SELECT 1 FROM `gameobject` g WHERE g.`id` = s.`id`);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject', g.`guid`, 0, 0, 0, @EVERLAKE_FILE, 'Wowhead object map point; height.py; orientation and respawn INFERRED'
FROM `gameobject` g WHERE g.`guid` IN (920018000, 920018001) AND g.`id` IN (630760, 630780);

COMMIT;
