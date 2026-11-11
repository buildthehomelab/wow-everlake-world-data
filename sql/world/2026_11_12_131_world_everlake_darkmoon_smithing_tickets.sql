-- Forever awards Darkmoon Prize Ticket currency (515) for the smithing turn-ins.
-- https://www.icy-veins.com/wow-forever/news/damage-buff-and-14-slot-bag-the-forever-darkmoon-faire-is-in-town/
-- Preserve the existing quest requirements and the verified ticket counts.
UPDATE quest_template
SET RewardCurrencyID1 = 515,
    RewardCurrencyQty1 = RewardAmount1,
    RewardItem1 = 0,
    RewardAmount1 = 0
WHERE RewardItem1 = 19182
  AND RewardCurrencyID1 = 0 AND RewardCurrencyQty1 = 0
  AND 515 NOT IN (RewardCurrencyID2, RewardCurrencyID3, RewardCurrencyID4)
  AND (ID, RewardAmount1) IN ((7889, 1), (7890, 4), (7891, 8),
                             (7892, 12), (7893, 20), (7939, 20));
