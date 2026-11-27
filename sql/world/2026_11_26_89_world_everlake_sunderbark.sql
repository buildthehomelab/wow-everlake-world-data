-- Sunderbark (248709), "Ancient of Corruption", the elite ancient of 92959 The Dying Ancients (Fraxinus 248366, Mount
-- Hyjal): "Hunt down and destroy the corrupted ancient Sunderbark, then plant a seed in his remains." The realm had no
-- Sunderbark, and nothing gave the objective's credit 268220 "DNT Sunderbark kill credit".
-- 2026_11_26_89_world_everlake_sunderbark.sql: written by hand, not tried in game (2026-11-26).
--
-- Sources:
--   Icy Veins (wowf npc 248709) and EG Link creature_details (71091, CC BY 4.0): name, title, type 10, elite
--     (classification 1), unit class 1, health multiplier 4, display 131637 at scale 1.5, creature difficulty 328270,
--     type flags 128 (CREATURE_TYPE_FLAG_INTERACT_WHILE_DEAD: his corpse can be clicked). Level 56: Icy Veins
--     addon_levels, EG Link creatures (71037) and Wowhead's kept page. Hostile: Wowhead "React" red for both sides,
--     EG Link reactions Horde 2. Abilities on Wowhead's kept page: War Stomp (45), Entangling Roots (11922), Dazed.
--   Position: EG Link creatures (71037) saw him at map 1 4412.1 -3087.3; Wowhead's kept page puts him at Mount Hyjal
--     60-65 / 72-83. ForeverTracker tools/height.py there: terrain 1043.04.
--   Client DB2, how the seed is planted: 1246989 Planting Seed (2 s cast, 20 yd) uses the quest's start item Seed of
--     the Ancients 248975 as its reagent (SpellReagents 38968), may target the dead (SpellMisc Attributes2 0x1
--     ALLOW_DEAD_TARGET), puts a dummy aura on its target, summons the Young Tree 659886 (effect 50) and gives its
--     caster credit 268220 (KILL_CREDIT2). The seed has no use spell, so the player casts it on the corpse he can
--     click. Young Tree 659886: EG Link object_details 71037 and Icy Veins gameobject 659886 (type 5, display 126957,
--     size 0.1). The core has no script for any of these ids.
--   EG Link objectives (71037): the 92959 credit was gained at 4402.0 -3075.5, 15 yd from the point above.
--
-- Rows: Sunderbark's template, difficulty, model and level; one spawn, guid 920086700; the Young Tree template; a
-- spell click on Sunderbark that makes the clicker cast Planting Seed on him (cast_flags 1), only while 92959 is in the
-- player's log (condition source 18); a SmartAI that puts the spell click flag back on his corpse when he dies (the core
-- clears all npc flags at death) and casts his two abilities in combat.
-- INFERRED (no source gives them): faction 16, speeds, attack time, respawn 300 s, wander 10 yd, the ability timers,
--   and the click itself (live's corpse interaction is not in any source; this is how the realm can cast the spell).
--   No loot: no source lists any, and a lootable corpse would take the right click before the spell click.
--   Not done: the quest text says "strike the corrupted tree and he will come"; no source names that tree, so he
--   stands spawned.
-- No row is added where the realm already has one. Each added row is recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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

SET @EVERLAKE_FILE := '2026_11_26_89_world_everlake_sunderbark.sql';

START TRANSACTION;

-- Young Tree (659886), the object Planting Seed summons
SET @EVERLAKE_G659886 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 659886);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 659886, 5, 126957, 'Young Tree', '', '', '', 0.1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 0 FROM DUAL WHERE @EVERLAKE_G659886 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 659886, 0, 0, 0, @EVERLAKE_FILE, 'Icy Veins gameobject=659886; EG Link object_details 71037' FROM DUAL WHERE @EVERLAKE_G659886 = 1;

-- Sunderbark (248709)
SET @EVERLAKE_NOTE := 'Icy Veins npc=248709 + EG Link creature_details 71091 / creatures 71037; faction 16 INFERRED (hostile, none named)';
SET @EVERLAKE_C248709 := (SELECT COUNT(*) = 0 FROM `creature_template` WHERE `entry` = 248709)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 248709);
INSERT INTO `creature_template` (`entry`, `KillCredit1`, `KillCredit2`, `name`, `femaleName`, `subname`, `TitleAlt`, `IconName`, `RequiredExpansion`, `VignetteID`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `Classification`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `unit_flags3`, `family`, `trainer_class`, `type`, `VehicleId`, `AIName`, `MovementType`, `ExperienceModifier`, `RacialLeader`, `movementId`, `WidgetSetID`, `WidgetSetUnitConditionID`, `RegenHealth`, `CreatureImmunitiesId`, `flags_extra`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 248709, 0, 0, 'Sunderbark', NULL, 'Ancient of Corruption', NULL, NULL, 0, 0, 16, 0, 1, 1.14286, 1, 1, 0, 2000, 2000, 1, 1, 1, 0, 2048, 0, 0, 0, 10, 0, 'SmartAI', 0, 1, 0, 0, 0, 0, 1, 0, 0, '', NULL, 0 FROM DUAL WHERE @EVERLAKE_C248709 = 1;
INSERT INTO `creature_template_difficulty` (`Entry`, `DifficultyID`, `LevelScalingDeltaMin`, `LevelScalingDeltaMax`, `ContentTuningID`, `HealthScalingExpansion`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `CreatureDifficultyID`, `TypeFlags`, `TypeFlags2`, `TypeFlags3`, `LootID`, `PickPocketLootID`, `SkinLootID`, `GoldMin`, `GoldMax`, `StaticFlags1`, `StaticFlags2`, `StaticFlags3`, `StaticFlags4`, `StaticFlags5`, `StaticFlags6`, `StaticFlags7`, `StaticFlags8`, `VerifiedBuild`)
SELECT 248709, 0, 0, 0, 0, 0, 4, 1, 1, 1, 328270, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 FROM DUAL WHERE @EVERLAKE_C248709 = 1;
INSERT INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
SELECT 248709, 0, 131637, 1.5, 1, 0 FROM DUAL WHERE @EVERLAKE_C248709 = 1;
INSERT INTO `creature_classic_level` (`entry`, `level_min`, `level_max`)
SELECT 248709, 56, 56 FROM DUAL
WHERE @EVERLAKE_C248709 = 1 AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 248709);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 248709, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C248709 = 1 AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 248709);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 248709, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C248709 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 248709, 0, 0, 0, @EVERLAKE_FILE, @EVERLAKE_NOTE FROM DUAL WHERE @EVERLAKE_C248709 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_classic_level', 248709, 0, 0, 0, @EVERLAKE_FILE, 'level 56: Icy Veins addon_levels, EG Link creatures 71037, Wowhead' FROM DUAL WHERE @EVERLAKE_C248709 = 1;

-- the rest only while the template is this file's
SET @EVERLAKE_CS248709 := (SELECT COUNT(*) = 1 FROM `everlake_import_rows` WHERE `tbl` = 'creature_template' AND `k1` = 248709 AND `file` = @EVERLAKE_FILE)
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 248709 AND `VerifiedBuild` = 0 AND `ScriptName` = '');

-- one spawn at EG Link's point (wander INFERRED)
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`,
  `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`,
  `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`,
  `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 920086700, 248709, 1, 0, 0, '0', 0, 0, 0, -1, 0, 0, 4412.1, -3087.3, 1043.04, 0, 300, 10, 0, 100, 1, NULL, NULL, NULL, NULL, '', NULL, 0
FROM DUAL
WHERE @EVERLAKE_CS248709 = 1 AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `id` = 248709)
  AND NOT EXISTS (SELECT 1 FROM `creature` WHERE `guid` = 920086700);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', 920086700, 0, 0, 0, @EVERLAKE_FILE, 'EG Link creatures 71037 position; height.py terrain 1043.04'
FROM `creature` c WHERE @EVERLAKE_CS248709 = 1 AND c.`guid` = 920086700 AND c.`id` = 248709;

-- clicking his corpse makes the player cast Planting Seed on it (the seed is its reagent; the spell gives 268220)
SET @EVERLAKE_K248709 := @EVERLAKE_CS248709 = 1
  AND (SELECT COUNT(*) = 0 FROM `npc_spellclick_spells` WHERE `npc_entry` = 248709)
  AND (SELECT COUNT(*) = 0 FROM `smart_scripts` WHERE `entryorguid` = 248709 AND `source_type` = 0);
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`)
SELECT 248709, 1246989, 1, 0 FROM DUAL WHERE @EVERLAKE_K248709 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'npc_spellclick_spells', 248709, 1246989, 0, 0, @EVERLAKE_FILE, 'client SpellEffect/SpellReagents/SpellMisc 1246989; type flag 128 (interact while dead)'
FROM `npc_spellclick_spells` k WHERE @EVERLAKE_K248709 = 1 AND k.`npc_entry` = 248709 AND k.`spell_id` = 1246989;

INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 18, 248709, 1246989, 0, 0, 9, 0, 92959, 0, 0, '', 0, 0, 0, '', 'Sunderbark: Planting Seed click only while The Dying Ancients (92959) is taken'
FROM DUAL
WHERE @EVERLAKE_K248709 = 1
  AND NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 18 AND c.`SourceGroup` = 248709 AND c.`SourceEntry` = 1246989);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 18, 248709, 1246989, 0, @EVERLAKE_FILE, 'click condition: quest 92959 taken'
FROM `conditions` c WHERE @EVERLAKE_K248709 = 1 AND c.`SourceTypeOrReferenceId` = 18 AND c.`SourceGroup` = 248709 AND c.`SourceEntry` = 1246989 AND c.`ConditionValue1` = 92959;

-- SmartAI: spell click flag back on the corpse at death; War Stomp and Entangling Roots in combat (timers INFERRED)
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `action_param7`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 248709, 0, 0, 0, '', 6, 0, 100, 0, 0, 0, 0, 0, 0, '', 81, 16777216, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunderbark - On death - Set npc flag spellclick (Planting Seed, The Dying Ancients 92959)'
FROM DUAL WHERE @EVERLAKE_K248709 = 1
UNION ALL
SELECT 248709, 0, 1, 0, '', 0, 0, 100, 0, 6000, 9000, 14000, 18000, 0, '', 11, 45, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunderbark - In combat - Cast War Stomp'
FROM DUAL WHERE @EVERLAKE_K248709 = 1
UNION ALL
SELECT 248709, 0, 2, 0, '', 0, 0, 100, 0, 3000, 5000, 12000, 16000, 0, '', 11, 11922, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 'Sunderbark - In combat - Cast Entangling Roots on victim'
FROM DUAL WHERE @EVERLAKE_K248709 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', 248709, 0, s.`id`, 0, @EVERLAKE_FILE, 'abilities: Wowhead kept page; death click: type flag 128 + Planting Seed; timers INFERRED'
FROM `smart_scripts` s WHERE @EVERLAKE_K248709 = 1 AND s.`entryorguid` = 248709 AND s.`source_type` = 0;

COMMIT;
