-- Tarantula Egg (673101, Alther's Mill): the template as live Forever has it.
-- 2026_11_23_05_world_everlake_tarantula_egg_template.sql: written by hand.
--
-- The core fork made this egg by hand before anyone had its record (2026_11_01_10): no lock, shown only to players
-- on the quest Alther's Mill (98386), and a script that hands out the "Tarantula Egg destroyed" credit (271912) on
-- use. EG Link has since recorded the client's own query data for it, the same on every build from 1.60.1.70888 to
-- 1.60.1.71037, and Icy Veins holds the same values:
--   * Data0 = 99: lock 99 (opened kneeling), as 50 other objects of the realm have.
--   * Data1 = 0: not tied to a quest. (The other Tarantula Egg, 673085, is the one tied to 98386; the realm has its
--     template as live and no spawn of it.)
--   * Data10 = 1309544, Data23 = 1: the player casts "[DNT] Tarantula Egg Quest Credit" on use. In the client that
--     spell is a kill credit for 271912 on the caster, so the egg gives the quest's credit by itself.
-- The hand-made script would now give a second credit for the same egg, so it goes, with the template's AIName.
--
-- Source: EG Link (Efficient Games, CC BY 4.0), object details; Icy Veins as second witness; client SpellEffect and
-- Lock. Not checked in game: finish Alther's Mill (98386) once on the test realm.
-- Changes the template only while it is still as the core's file left it, and removes only that file's script.
-- Running it again changes nothing. Never edit this file once it is deployed: a later fix is a new file.

START TRANSACTION;

SET @EVERLAKE_EGG := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 673101 AND `type` = 10
  AND `Data0` = 0 AND `Data1` = 98386 AND `Data10` = 0 AND `Data23` = 0 AND `AIName` = 'SmartGameObjectAI');

DELETE FROM `smart_scripts` WHERE @EVERLAKE_EGG = 1 AND `entryorguid` = 673101 AND `source_type` = 1 AND `id` = 0
  AND `event_type` = 64 AND `action_type` = 33 AND `action_param1` = 271912;

UPDATE `gameobject_template` SET `Data0` = 99, `Data1` = 0, `Data10` = 1309544, `Data23` = 1, `AIName` = ''
WHERE @EVERLAKE_EGG = 1 AND `entry` = 673101
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` s WHERE s.`entryorguid` = 673101 AND s.`source_type` = 1);

COMMIT;
