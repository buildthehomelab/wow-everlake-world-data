-- Efficient Games 70862 quest capture, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
SET SESSION autocommit = 0;

INSERT INTO `quest_objectives` (ID, QuestID, Type, `Order`, StorageIndex, ObjectID, Amount)
SELECT 477066, q.ID, 1, 0, 1, 280042, 1
FROM `quest_template` q
WHERE q.ID=98223 AND BINARY q.LogTitle=BINARY 'Old Habits' AND q.StartItem=280042
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=477066 OR o.QuestID=q.ID)
AND EXISTS (SELECT 1 FROM `gameobject_queststarter` s JOIN `gameobject` g ON g.id=s.id
 WHERE s.quest=q.ID AND s.id=671518 AND g.map=0)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id
 WHERE e.quest=q.ID AND e.id=2104 AND c.map=0);

UPDATE `quest_template` q
SET q.RewardChoiceItemID1=281306, q.RewardChoiceItemQuantity1=1,
    q.RewardChoiceItemID2=281307, q.RewardChoiceItemQuantity2=1
WHERE q.ID=98223 AND BINARY q.LogTitle=BINARY 'Old Habits' AND q.StartItem=280042
AND q.RewardChoiceItemID1=0 AND q.RewardChoiceItemID2=0 AND q.RewardChoiceItemID3=0
AND q.RewardChoiceItemID4=0 AND q.RewardChoiceItemID5=0 AND q.RewardChoiceItemID6=0
AND q.RewardChoiceItemQuantity1=0 AND q.RewardChoiceItemQuantity2=0
AND EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=477066 AND o.QuestID=q.ID AND o.Type=1 AND o.StorageIndex=1 AND o.ObjectID=280042 AND o.Amount=1);

SET SESSION autocommit = 1;
