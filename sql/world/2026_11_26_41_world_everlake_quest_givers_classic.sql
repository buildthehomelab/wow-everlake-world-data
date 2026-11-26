-- Three quests nobody can take or finish on the test realm: Ever After, Greater Friend of the Library (Horde side) and
-- A Lost Brother.
-- 2026_11_26_41_world_everlake_quest_givers_classic.sql: written by hand from the tracker's kept facts (2026-11-26).
--
-- Ever After (82062, Blackrock Depths): only taken by the Rugged Traveler (222530), nobody gives it. A Wowhead WoW Forever
--   comment (quest=82062, 2026-11-23) says you jump down to the dwarf, watch a bit of dialog, and receive and finish the
--   quest there; Icy Veins' objective is "Speak with the Rugged Traveler.". The Traveler is spawned and already a quest
--   giver (npcflag 2), so he gives it here too. Inferred: live gives it after his dialog; that conversation is not
--   scripted here.
-- Greater Friend of the Library (84394): Wowhead's WoW Forever page lists two enders, Jennea Cannon (5497) for the
--   Alliance and Oran Snakewrithe (7825) for the Horde; the test realm has only Jennea. Oran gives and takes every other
--   library book quest Jennea does (84395-84402), so he gives and takes this one too (the giving is inferred from those).
-- A Lost Brother (79940, Paladin): its one objective, "Speak with Katherine and Learn More", is a credit for creature
--   11080 ("[PH[ Combat Tester", a placeholder) that nothing gives. Icy Veins' text has Katherine the Pure (5492) tell the
--   story in the quest text itself and her progress text is empty, so the credit is given when the quest is accepted
--   from her (SmartAI on quest accept). Inferred from the texts; live's exact trigger is not recorded.
--
-- Running it again changes nothing. Not checked in game.

START TRANSACTION;

INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) VALUES (222530, 82062, 0);

INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) VALUES (7825, 84394, 0);
INSERT IGNORE INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) VALUES (7825, 84394, 0);

-- Katherine the Pure: SmartAI only while she has no other AI or script
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 5492 AND `AIName` = '' AND `ScriptName` = '';
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `Difficulties`, `event_type`, `event_phase_mask`,
  `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`,
  `event_param_string`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`,
  `action_param6`, `action_param7`, `action_param_string`, `target_type`, `target_param1`, `target_param2`, `target_param3`,
  `target_param4`, `target_param_string`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
SELECT 5492, 0, 0, 0, '', 19, 0, 100, 0, 79940, 0, 0, 0, 0, '', 33, 11080, 0, 0, 0, 0, 0, 0, NULL, 7, 0, 0, 0, 0, NULL,
  0, 0, 0, 0, 'Katherine the Pure - On Quest ''A Lost Brother'' Accepted - Quest Credit ''Speak with Katherine'''
FROM DUAL
WHERE EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 5492 AND `AIName` = 'SmartAI')
  AND NOT EXISTS (SELECT 1 FROM `smart_scripts` WHERE `entryorguid` = 5492 AND `source_type` = 0);

COMMIT;
