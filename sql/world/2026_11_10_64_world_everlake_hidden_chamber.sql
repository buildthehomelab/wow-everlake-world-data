-- Efficient Games 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- Guardian Staff is supplied by the pinned core ItemSparse hotfixes.
SET SESSION autocommit = 0;
INSERT INTO `quest_objectives` (ID, QuestID, Type, `Order`, StorageIndex, ObjectID, Amount)
SELECT 385513, q.ID, 10, 0, 0, 822, 1
FROM `quest_template` q
WHERE q.ID=2240 AND BINARY q.LogTitle=BINARY 'The Hidden Chamber' AND q.Flags=12
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.id=822 AND a.quest=q.ID)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385513 OR o.QuestID=q.ID);

UPDATE `quest_template` q
SET q.RewardChoiceItemID3=270078, q.RewardChoiceItemQuantity3=1
WHERE q.ID=2240 AND BINARY q.LogTitle=BINARY 'The Hidden Chamber' AND q.Flags=12
AND q.RewardChoiceItemID1=9626 AND q.RewardChoiceItemQuantity1=1
AND q.RewardChoiceItemID2=9627 AND q.RewardChoiceItemQuantity2=1
AND q.RewardChoiceItemID3=0 AND q.RewardChoiceItemQuantity3=0 AND q.RewardChoiceItemDisplayID3=0
AND q.RewardChoiceItemID4=0 AND q.RewardChoiceItemID5=0 AND q.RewardChoiceItemID6=0
AND EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=385513 AND o.QuestID=q.ID AND o.Type=10 AND o.StorageIndex=0 AND o.ObjectID=822 AND o.Amount=1);
SET SESSION autocommit = 1;
