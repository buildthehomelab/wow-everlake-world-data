-- Tarantula Egg (673101, Alther's Mill): the template as live Forever has it, and eggs that hatch a spider.
-- 2026_11_23_05_world_everlake_tarantula_egg_template.sql: written by hand.
--
-- The core fork made this egg by hand before anyone had its record (2026_11_01_10): no lock, shown only to players
-- on the quest Alther's Mill (98386), and a script that hands out the "Tarantula Egg destroyed" credit (271912) on
-- use. EG Link has since recorded the client's own query data for it, the same on every build from 1.60.1.70888 to
-- 1.60.1.71037, and Icy Veins holds the same values:
--   * Data0 = 99: lock 99 (opened kneeling), as 50 other objects of the realm have.
--   * Data1 = 0: not tied to a quest.
--   * Data10 = 1309544, Data23 = 1: the player casts "[DNT] Tarantula Egg Quest Credit" on use. In the client that
--     spell is a kill credit for 271912 on the caster, so the egg gives the quest's credit by itself.
-- The hand-made credit script would now give a second credit for the same egg, so it goes.
--
-- STAND-IN (the realm's owner, 2026-11-23): an egg hatches the new Greater Tarantula (271898). On live the client's
-- spell "Summon Greater Tarantula" (1309513) calls 271898 for five minutes, and the second egg (673085, tied to the
-- quest) has a linked trap (673083) that most likely casts it; no source holds that trap's record and the realm
-- spawns only 673101. Until someone records it, the egg's own script does the hatching: on use it calls one 271898
-- at the egg for five minutes (gone sooner once its corpse goes) and sets it on the player. Every egg hatches: the
-- owner's choice. Live has eggs of both kinds and nothing says how many of each.
--
-- Source: EG Link (Efficient Games, CC BY 4.0), object details; Icy Veins as second witness; client SpellEffect,
-- SpellDuration and Lock. Not checked in game: finish Alther's Mill (98386) once on the test realm.
-- Changes the template only while it is still as the core's file left it, and replaces only that file's script row.
-- The added row is recorded in everlake_import_rows. Running it again changes nothing. Never edit this file once it
-- is deployed: a later fix is a new file.

SET @EVERLAKE_FILE := '2026_11_23_05_world_everlake_tarantula_egg_template.sql';

START TRANSACTION;

SET @EVERLAKE_EGG := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 673101 AND `type` = 10
  AND `Data0` = 0 AND `Data1` = 98386 AND `Data10` = 0 AND `Data23` = 0 AND `AIName` = 'SmartGameObjectAI')
  AND (SELECT COUNT(*) = 1 FROM `creature_template` WHERE `entry` = 271898);

DELETE FROM `smart_scripts` WHERE @EVERLAKE_EGG = 1 AND `entryorguid` = 673101 AND `source_type` = 1 AND `id` = 0
  AND `event_type` = 64 AND `action_type` = 33 AND `action_param1` = 271912;

SET @EVERLAKE_EGG_SCRIPT := @EVERLAKE_EGG = 1
  AND (SELECT COUNT(*) = 0 FROM `smart_scripts` WHERE `entryorguid` = 673101 AND `source_type` = 1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`,
  `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`,
  `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`,
  `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 673101, 1, 0, 0, 64, 0, 100, 0, 1, 0, 0, 0, 0, 12, 271898, 2, 300000, 0, 4, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0,
  'Tarantula Egg - On Use - Summon Greater Tarantula on the player (stand-in for trap 673083)'
FROM DUAL WHERE @EVERLAKE_EGG_SCRIPT = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'smart_scripts', 673101, 1, 0, 0, @EVERLAKE_FILE, 'STAND-IN for trap 673083: client spell 1309513 summons 271898 for 300 s; every egg hatches (owner)'
FROM DUAL WHERE @EVERLAKE_EGG_SCRIPT = 1;

UPDATE `gameobject_template` SET `Data0` = 99, `Data1` = 0, `Data10` = 1309544, `Data23` = 1
WHERE @EVERLAKE_EGG = 1 AND `entry` = 673101;

COMMIT;
