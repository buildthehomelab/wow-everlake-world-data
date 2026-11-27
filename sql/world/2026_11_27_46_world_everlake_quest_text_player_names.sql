-- Two more quest texts with a player's name recorded in place of $N. Found by matching every PTR quest text against
-- the texts that use $N: these two are the same text as their sibling quests with one word swapped for a name.
--   94822 Confounding Flash, turn-in text: "Cub" (94817, 94821 and 94823 have $n there).
--   8708 Mace of Unending Life, progress text: "Bueno" (8558, 8705 and 8706 have $N there).
-- Running it again changes nothing.
UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(`RewardText`, 'You took your time arriving, Cub.', 'You took your time arriving, $n.')
WHERE `ID` = 94822 AND `RewardText` LIKE 'You took your time arriving, Cub.%';
UPDATE `quest_request_items` SET `CompletionText` = 'Did you bring me the components I require, $N?'
WHERE `ID` = 8708 AND `CompletionText` = 'Did you bring me the components I require, Bueno?';
