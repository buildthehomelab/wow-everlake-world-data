-- Skeleton keys: the Blacksmithing skill and price ten trainers ask, as on live Forever.
-- 2026_11_23_10_world_everlake_skeleton_key_training.sql: written by hand.
--
-- Forever teaches the four skeleton keys 25 points earlier than Classic did. Ten of the realm's blacksmithing
-- trainers (Snarl, Brikk Keencraft, Karn Stonehoof, Clarise Gnarltree, Saru Steelfury, Traugh, Bengus Deepforge, James
-- Van Brunt, Therum Deepforge, Rotgath Stonebeard) still ask Classic's skill; the realm's other trainers already
-- have the live values for the Silver and Golden keys.
--                               realm            live
--   Silver Skeleton Key      100,   6s         75,   1s
--   Golden Skeleton Key      150,  2s 25c     125,  2s 50c
--   Truesilver Skeleton Key  200, 22s 50c     175, 25s
--   Arcanite Skeleton Key    275,  1g         250,  1g
-- The live values are what players' trainer windows showed at these same NPCs: EG Link (Snarl, Karn Stonehoof, Saru
-- Steelfury) and Icy Veins (all ten) for Silver and Golden; EG Link and Icy Veins for Truesilver; Icy Veins alone
-- for Arcanite (Brikk Keencraft, the only one who teaches it). The client agrees on all four: its recipes turn
-- yellow at 75, 125, 175 and 250, which a recipe learnt later could not.
-- What the keys open is in the client and needs nothing: locks up to 25, 125, 200 and 300.
--
-- Sources: EG Link (Efficient Games, CC BY 4.0), trainer windows; Icy Veins; client SkillLineAbility.
-- Changes a row only while it still holds the Classic skill and price. Running it again changes nothing. Never edit
-- this file once it is deployed: a later fix is a new file.

UPDATE `trainer_spell` SET `ReqSkillRank` = 75, `MoneyCost` = 100
WHERE `SpellId` = 19666 AND `ReqSkillLine` = 164 AND `ReqSkillRank` = 100 AND `MoneyCost` = 600
  AND `TrainerId` IN (1001383, 1002836, 1002998, 1003136, 1003355, 1003478, 1004258, 1004596, 1005511, 1010276);

UPDATE `trainer_spell` SET `ReqSkillRank` = 125, `MoneyCost` = 250
WHERE `SpellId` = 19667 AND `ReqSkillLine` = 164 AND `ReqSkillRank` = 150 AND `MoneyCost` = 225
  AND `TrainerId` IN (1001383, 1002836, 1002998, 1003136, 1003355, 1003478, 1004258, 1004596, 1005511, 1010276);

UPDATE `trainer_spell` SET `ReqSkillRank` = 175, `MoneyCost` = 2500
WHERE `SpellId` = 19668 AND `ReqSkillLine` = 164 AND `ReqSkillRank` = 200 AND `MoneyCost` = 2250
  AND `TrainerId` IN (1002836, 1003355, 1004258);

UPDATE `trainer_spell` SET `ReqSkillRank` = 250
WHERE `SpellId` = 19669 AND `ReqSkillLine` = 164 AND `ReqSkillRank` = 275 AND `MoneyCost` = 10000
  AND `TrainerId` = 1002836;
