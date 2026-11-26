-- Nine quest levels and ten quest money rewards the test realm has wrong, from the quest records of the live game.
-- 2026_11_25_18_world_everlake_quest_levels_money.sql: written by hand from the tracker's kept facts (2026-11-25).
--
-- EG Link's recordings of the server's quest records (build 1.60.1.71037) and Icy Veins' WoW Forever database
-- (https://db.icy-veins.com/wow-forever/) agree on each level below; the realm holds another. The quest level sets the
-- XP (QuestXP by level and difficulty) and the colour in the quest log, so 968 paid level-20 XP on a level-18 quest and
-- 7790 (level 0) paid next to nothing. Their minimum levels already match. Checked over all 5,572 quests both the realm and
-- Icy Veins hold: these are the only quest levels that differ where EG Link agrees with Icy Veins (the Alterac Valley
-- quests' minimum level and 79365's are left: the two sources disagree there).
--
--   421    Prove Your Worth                  10 -> 11
--   615    The Captain's Cutlass             45 -> 50
--   620    The Monogrammed Sash              45 -> 50
--   968    The Powers Below                  20 -> 18
--   7790   River Ends                         0 -> 57
--   79358  Storm, Earth, and Fire            40 -> 43
--   79361  Storm, Earth, and Fire            40 -> 43
--   96261  The Broodmother                   31 -> 30
--   98156  Packaged Pristine Pelts           31 -> 29
--
-- Money: the realm's quest_classic_money (a fixed amount, in copper) differs from what Icy Veins records the quest paying
-- on live, for these quests below level 40 (so not the gold paid instead of XP at the level cap). Each changes only
-- while it still holds the old amount:
--   544     7000 -> 6500
--   556     3000 -> 3500
--   635        0 -> 1800
--   642        0 -> 4000
--   651        0 -> 4500
--   745      125 -> 225
--   86757   3000 -> 2500
--   96873    175 -> 110
--   97005   1000 -> 5000
--   98251    700 -> 800
--
-- Each row changes only while it still holds the old value. Running it again changes nothing. Not checked in game.

START TRANSACTION;

UPDATE `quest_classic_level` SET `QuestLevel` = 11 WHERE `ID` = 421 AND `QuestLevel` = 10;
UPDATE `quest_template_classic_level` SET `QuestLevel` = 11 WHERE `ID` = 421 AND `LevelType` = 2 AND `QuestLevel` = 10;
UPDATE `quest_classic_level` SET `QuestLevel` = 50 WHERE `ID` = 615 AND `QuestLevel` = 45;
UPDATE `quest_template_classic_level` SET `QuestLevel` = 50 WHERE `ID` = 615 AND `LevelType` = 2 AND `QuestLevel` = 45;
UPDATE `quest_classic_level` SET `QuestLevel` = 50 WHERE `ID` = 620 AND `QuestLevel` = 45;
UPDATE `quest_template_classic_level` SET `QuestLevel` = 50 WHERE `ID` = 620 AND `LevelType` = 2 AND `QuestLevel` = 45;
UPDATE `quest_classic_level` SET `QuestLevel` = 18 WHERE `ID` = 968 AND `QuestLevel` = 20;
UPDATE `quest_template_classic_level` SET `QuestLevel` = 18 WHERE `ID` = 968 AND `LevelType` = 2 AND `QuestLevel` = 20;
UPDATE `quest_classic_level` SET `QuestLevel` = 57 WHERE `ID` = 7790 AND `QuestLevel` = 0;
UPDATE `quest_template_classic_level` SET `QuestLevel` = 57 WHERE `ID` = 7790 AND `LevelType` = 2 AND `QuestLevel` = 0;
UPDATE `quest_classic_level` SET `QuestLevel` = 43 WHERE `ID` = 79358 AND `QuestLevel` = 40;
UPDATE `quest_template_classic_level` SET `QuestLevel` = 43 WHERE `ID` = 79358 AND `LevelType` = 2 AND `QuestLevel` = 40;
UPDATE `quest_classic_level` SET `QuestLevel` = 43 WHERE `ID` = 79361 AND `QuestLevel` = 40;
UPDATE `quest_template_classic_level` SET `QuestLevel` = 43 WHERE `ID` = 79361 AND `LevelType` = 2 AND `QuestLevel` = 40;
UPDATE `quest_classic_level` SET `QuestLevel` = 30 WHERE `ID` = 96261 AND `QuestLevel` = 31;
UPDATE `quest_template_classic_level` SET `QuestLevel` = 30 WHERE `ID` = 96261 AND `LevelType` = 2 AND `QuestLevel` = 31;
UPDATE `quest_classic_level` SET `QuestLevel` = 29 WHERE `ID` = 98156 AND `QuestLevel` = 31;
UPDATE `quest_template_classic_level` SET `QuestLevel` = 29 WHERE `ID` = 98156 AND `LevelType` = 2 AND `QuestLevel` = 31;

UPDATE `quest_classic_money` SET `RewardMoney` = 6500 WHERE `ID` = 544 AND `RewardMoney` = 7000;
UPDATE `quest_classic_money` SET `RewardMoney` = 3500 WHERE `ID` = 556 AND `RewardMoney` = 3000;
UPDATE `quest_classic_money` SET `RewardMoney` = 1800 WHERE `ID` = 635 AND `RewardMoney` = 0;
UPDATE `quest_classic_money` SET `RewardMoney` = 4000 WHERE `ID` = 642 AND `RewardMoney` = 0;
UPDATE `quest_classic_money` SET `RewardMoney` = 4500 WHERE `ID` = 651 AND `RewardMoney` = 0;
UPDATE `quest_classic_money` SET `RewardMoney` = 225 WHERE `ID` = 745 AND `RewardMoney` = 125;
UPDATE `quest_classic_money` SET `RewardMoney` = 2500 WHERE `ID` = 86757 AND `RewardMoney` = 3000;
UPDATE `quest_classic_money` SET `RewardMoney` = 110 WHERE `ID` = 96873 AND `RewardMoney` = 175;
UPDATE `quest_classic_money` SET `RewardMoney` = 5000 WHERE `ID` = 97005 AND `RewardMoney` = 1000;
UPDATE `quest_classic_money` SET `RewardMoney` = 800 WHERE `ID` = 98251 AND `RewardMoney` = 700;

COMMIT;
