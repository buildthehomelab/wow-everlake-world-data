-- Gelvas sells these prizes for currency 515 in Forever. Stop offering
-- the old item-ticket quests once the matching currency listing exists.
DELETE starter
FROM creature_queststarter starter
JOIN quest_template quest ON quest.ID = starter.quest
JOIN quest_objectives objective ON objective.QuestID = quest.ID
JOIN npc_vendor vendor ON vendor.entry = starter.id
    AND vendor.item = quest.RewardItem1 AND vendor.type = 1
WHERE starter.id = 14828
  AND starter.quest IN (7930,7931,7932,7933,7934,7935,7936,7940,7981)
  AND objective.Type = 1 AND objective.ObjectID = 19182
  AND (vendor.ExtendedCost, objective.Amount) IN (
      (11744,5), (11745,10), (11746,12), (11747,40), (11748,50), (11749,1200)
  );
