-- Forever animal parts, leatherworking, and engineering turn-ins award
-- Darkmoon Prize Ticket currency (515) in the same quantities as the old item.
-- https://www.wowhead.com/forever/guide/darkmoon-faire-event-overview-guide
UPDATE quest_template
SET RewardCurrencyID1 = 515,
    RewardCurrencyQty1 = RewardAmount1,
    RewardItem1 = 0,
    RewardAmount1 = 0
WHERE RewardItem1 = 19182
  AND RewardCurrencyID1 = 0 AND RewardCurrencyQty1 = 0
  AND 515 NOT IN (RewardCurrencyID2, RewardCurrencyID3, RewardCurrencyID4)
  AND (ID, RewardAmount1) IN (
      (7899, 1), (7900, 4), (7901, 8), (7902, 12),
      (7903, 20), (7943, 20), (8222, 20), (8223, 20),
      (7881, 1), (7882, 4), (7883, 8), (7884, 12), (7885, 20), (7941, 20),
      (7894, 1), (7895, 4), (7896, 8), (7897, 12), (7898, 20), (7942, 20)
  );

-- These two introductions already award the current currency.
UPDATE quest_template
SET RewardItem1 = 0, RewardAmount1 = 0
WHERE ID IN (7905, 7926)
  AND RewardItem1 = 19182 AND RewardAmount1 = 5
  AND RewardCurrencyID1 = 515 AND RewardCurrencyQty1 = 5;
