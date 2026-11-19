-- Crown of the Earth (934) hands over the Amethyst Phial (5623) again.
-- 2026_11_19_942_world_everlake_crown_of_the_earth_phial.sql: written by hand.
--
-- The quest asks for the Filled Amethyst Phial (5646), which players make by filling the Amethyst Phial at the
-- moonwell, but nothing gives the empty phial: quest_template.StartItem is 0 and no loot, vendor or quest has it.
-- Wowhead Forever names quest 934 as the phial's only source (item list page, 2026-11-19), and VMaNGOS hands it over
-- when the quest is accepted (quest_template.SrcItemId 5623, SrcItemCount 1, db-70e38cd). Changed only while the
-- quest still hands over nothing. Not checked in game.
--
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

START TRANSACTION;

UPDATE `quest_template` SET `StartItem` = 5623
WHERE `ID` = 934 AND `StartItem` = 0
  AND (SELECT COUNT(*) FROM `quest_objectives` WHERE `QuestID` = 934 AND `Type` = 1 AND `ObjectID` = 5646) > 0;

UPDATE `quest_template_addon` SET `ProvidedItemCount` = 1
WHERE `ID` = 934 AND `ProvidedItemCount` = 0
  AND (SELECT `StartItem` FROM `quest_template` WHERE `ID` = 934) = 5623;

COMMIT;
