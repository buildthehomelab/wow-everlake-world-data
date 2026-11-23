-- Eight turn-in texts that call the player by one fixed class or race, in quests open to any: the class or race token
-- ($c, $r) in its place.
-- 2026_11_23_04_world_everlake_turnin_text_class_tokens.sql: checked by hand.
--
-- These texts came from recordings of the live game (players' addons, sniffs). A recording shows what one player's
-- client printed, so where the game's text holds $c or $r it kept that player's own class or race: every player was
-- greeted as a paladin in Pay Dirt!, a quest any Horde class can do. Found by reading every turn-in text of the realm
-- for a class or race set off as an address, in a quest not kept to that class (its sort, AllowableClasses) or that
-- race (AllowableRaces). INFERRED: no recording shows the token itself; the wording around it is untouched.
--   quest_offer_reward:  94279 Craftsman's Writ: Heavy Mithril Axe (shaman), 94877 Saving Sunnyglade (gnome),
--                        95603 Bats in the Belfry (warrior), 95792 Clear 'em Out (warrior), 99204 Swift as the Wind (hunter)
--   quest_request_items: 91607 Pay Dirt! (paladin), 94336 Craftsman's Writ: Lifelike Mechanical Toad (orc),
--                        94340 Craftsman's Writ: Truesilver Transformer (paladin)
-- Swift as the Wind 99201 (rogue) is corrected in 2026_11_23_03. A Newly Discovered Purpose... (81944, "human") is left
-- as it is: the speaker may mean it.
-- Each row changes only while it still holds the recorded phrase. Never edit this file once it is deployed: a later fix
-- is a new file. Running it again changes nothing. Not read in game.
START TRANSACTION;

UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(`RewardText`, 'Thank you, shaman.', 'Thank you, $c.')
WHERE `ID` = 94279 AND INSTR(`RewardText`, 'Thank you, shaman.') > 0;
UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(`RewardText`, 'You do your Alliance proud, gnome.', 'You do your Alliance proud, $r.')
WHERE `ID` = 94877 AND INSTR(`RewardText`, 'You do your Alliance proud, gnome.') > 0;
UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(`RewardText`, 'You are a good soul, warrior.', 'You are a good soul, $c.')
WHERE `ID` = 95603 AND INSTR(`RewardText`, 'You are a good soul, warrior.') > 0;
UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(`RewardText`, 'Terrific work, warrior.', 'Terrific work, $c.')
WHERE `ID` = 95792 AND INSTR(`RewardText`, 'Terrific work, warrior.') > 0;
UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(`RewardText`, 'Throm''ka, hunter.', 'Throm''ka, $c.')
WHERE `ID` = 99204 AND INSTR(`RewardText`, 'Throm''ka, hunter.') > 0;

UPDATE `quest_request_items` SET `CompletionText` = REPLACE(`CompletionText`, 'What''s new, paladin?', 'What''s new, $c?')
WHERE `ID` = 91607 AND INSTR(`CompletionText`, 'What''s new, paladin?') > 0;
UPDATE `quest_request_items` SET `CompletionText` = REPLACE(`CompletionText`, 'swim in lava, orc?', 'swim in lava, $r?')
WHERE `ID` = 94336 AND INSTR(`CompletionText`, 'swim in lava, orc?') > 0;
UPDATE `quest_request_items` SET `CompletionText` = REPLACE(`CompletionText`, 'Need reagents, paladin?', 'Need reagents, $c?')
WHERE `ID` = 94340 AND INSTR(`CompletionText`, 'Need reagents, paladin?') > 0;

COMMIT;
