-- Quest race masks: Silvia's Sword back to the Horde shaman quest live gives, and 41 Alliance quests whose mask was
-- stored as a rounded number that leaves out Humans, Dwarves and Night Elves.
-- 2026_11_26_40_world_everlake_quest_races.sql: written by hand from the tracker's kept facts (2026-11-26).
--
-- Silvia's Sword (79363). Wowhead's WoW Forever page (https://www.wowhead.com/forever/quest=79363) gives it to Orc,
-- Tauren and Troll Shamans, started by Bath'rah the Windwatcher (6176, Alterac Mountains) and ended by Sirra Von'Indi
-- (268, Darkshire) or Bath'rah. QuestieDB agrees (races 162, classes 64, starters npc 6176 and item 281145, finishers
-- 268 and 6176), and the tracker's live sightings have it taken by the Horde. 2026_11_25_13 had moved it to the Alliance
-- mask from Icy Veins' record alone; Wowhead ranks above Icy Veins, so this puts back 162, adds the Shaman class and
-- lets Bath'rah give and take it. The sword item (281145) still starts it too.
--
-- 41 quests (Paladin quests such as A Newly Discovered Purpose... 81944, Just Compensation, Anthion's Parting Words,
-- Saving the Best for Last, and others) hold AllowableRaces 6130900294268440000: the Alliance mask 6130900294268439629
-- after a trip through a floating-point number. Its low bits read Gnome, Troll and Goblin instead of Human, Dwarf and
-- Night Elf, so Humans and Dwarves cannot take these quests. Icy Veins' WoW Forever database
-- (https://db.icy-veins.com/wow-forever/) records 6130900294268439629 for every one of the 41.
--
-- Each change applies only while the row still holds the old value. Running it again changes nothing. Not checked in game.

START TRANSACTION;

UPDATE `quest_template` SET `AllowableRaces` = 162 WHERE `ID` = 79363 AND `AllowableRaces` = 6130900294268439629;
UPDATE `quest_template_addon` SET `AllowableClasses` = 64 WHERE `ID` = 79363 AND `AllowableClasses` = 0;
INSERT IGNORE INTO `creature_queststarter` (`id`, `quest`, `VerifiedBuild`) VALUES (6176, 79363, 0);
INSERT IGNORE INTO `creature_questender` (`id`, `quest`, `VerifiedBuild`) VALUES (6176, 79363, 0);

UPDATE `quest_template` SET `AllowableRaces` = 6130900294268439629
WHERE `AllowableRaces` = 6130900294268440000 AND `ID` IN (78093, 81944, 82135, 84163, 84164, 84165, 84166, 84167, 84168,
  84169, 84170, 84179, 84180, 84181, 84182, 84183, 84184, 84186, 84195, 84196, 84200, 84202, 86611, 88757, 88813, 88884,
  88917, 89038, 89470, 94829, 94843, 94885, 94926, 94980, 95198, 96377, 96771, 97420, 97448, 97449, 97450);

COMMIT;
