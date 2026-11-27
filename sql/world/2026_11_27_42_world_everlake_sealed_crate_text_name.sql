-- A Sealed Crate (91899, 91901, 91902, 91906, 91907): the turn-in text greeted every player as "Ana", a player's name recorded with
-- the text. The live text (Icy Veins and Forever change recordings) has $N there.
-- Running it again changes nothing.
UPDATE `quest_offer_reward` SET `RewardText` = REPLACE(`RewardText`, 'Thank you for your hard work, Ana.', 'Thank you for your hard work, $N.')
WHERE `ID` IN (91899, 91900, 91901, 91902, 91904, 91905, 91906, 91907) AND `RewardText` LIKE 'Thank you for your hard work, Ana.%';
