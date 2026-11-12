-- Efficient Games build 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- Keep the existing item objective ID and storage index for active quests.
SET SESSION autocommit = 0;

INSERT INTO `quest_objectives` (ID, QuestID, Type, `Order`, StorageIndex, ObjectID, Amount)
SELECT 381629, q.ID, 6, 1, 1, 92, 3000
FROM `quest_template` q
WHERE q.ID=1370 AND BINARY q.LogTitle=BINARY 'Stealing Supplies'
AND q.RewardChoiceItemID1=3463 AND q.RewardChoiceItemQuantity1=200
AND EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=90013704 AND o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=6069 AND o.Amount=6)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=381629 OR (o.QuestID=q.ID AND o.ID<>90013704))
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature_questender` e ON e.id=s.id AND e.quest=s.quest
 JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=5397 AND c.map=1);

UPDATE `quest_template` q
SET q.RewardChoiceItemQuantity1=1
WHERE q.ID=1370 AND BINARY q.LogTitle=BINARY 'Stealing Supplies'
AND q.RewardChoiceItemID1=3463 AND q.RewardChoiceItemQuantity1=200
AND q.RewardChoiceItemID2=3464 AND q.RewardChoiceItemQuantity2=200
AND q.RewardChoiceItemID3=3465 AND q.RewardChoiceItemQuantity3=200
AND EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=381629 AND o.QuestID=q.ID AND o.Type=6 AND o.StorageIndex=1 AND o.ObjectID=92 AND o.Amount=3000);

SET SESSION autocommit = 1;
