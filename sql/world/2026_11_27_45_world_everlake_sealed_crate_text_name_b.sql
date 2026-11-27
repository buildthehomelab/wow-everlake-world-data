-- A Sealed Crate (91905): the turn-in text greeted every player as "Big", another player's name recorded with the text
-- (2026_11_27_42 fixed the "Ana" ones). The live text has $N there.
-- Running it again changes nothing.
UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(`RewardText`, 'Thank you for your hard work, Big.', 'Thank you for your hard work, $N.')
WHERE `ID` = 91905 AND `RewardText` LIKE 'Thank you for your hard work, Big.%';
