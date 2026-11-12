-- Efficient Games build 70862 quest capture, CC BY 4.0.
-- Source pin: 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae
-- Restore the guaranteed rewards on the captured quest variants.
UPDATE `quest_template` q
JOIN (
    SELECT 531 AS QuestID, 'Vyrin''s Revenge' AS Title, 270017 AS ItemID
    UNION ALL SELECT 549, 'WANTED: Syndicate Personnel', 276720
    UNION ALL SELECT 940, 'Teldrassil', 281250
) captured ON captured.QuestID = q.ID
SET q.RewardItem1 = captured.ItemID, q.RewardAmount1 = 1
WHERE BINARY q.LogTitle = BINARY captured.Title
  AND q.RewardSpell = 0
  AND q.RewardItem1 = 0 AND q.RewardAmount1 = 0
  AND q.RewardItem2 = 0 AND q.RewardAmount2 = 0
  AND q.RewardItem3 = 0 AND q.RewardAmount3 = 0
  AND q.RewardItem4 = 0 AND q.RewardAmount4 = 0
  AND (
      (q.ID = 531 AND EXISTS (
          SELECT 1 FROM `quest_objectives` o
          WHERE o.QuestID = q.ID AND o.Type = 1 AND o.ObjectID = 2713 AND o.Amount = 1
      ))
      OR (q.ID = 549 AND 2 = (
          SELECT COUNT(DISTINCT o.ObjectID) FROM `quest_objectives` o
          WHERE o.QuestID = q.ID AND o.Type = 0 AND o.ObjectID IN (2260, 2261) AND o.Amount = 10
      ))
      OR (q.ID = 940 AND EXISTS (
          SELECT 1 FROM `quest_objectives` o
          WHERE o.QuestID = q.ID AND o.Type = 1 AND o.ObjectID = 5219 AND o.Amount = 1
      ))
  );
