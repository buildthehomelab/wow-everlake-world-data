-- Efficient Games build 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
SET SESSION autocommit = 0;

INSERT INTO `quest_objectives` (ID, QuestID, Type, `Order`, StorageIndex, ObjectID, Amount)
SELECT 480569, q.ID, 1, 1, 1, 16603, 1
FROM `quest_template` q
WHERE q.ID=6481 AND BINARY q.LogTitle=BINARY 'Earthen Arise' AND q.StartItem=16603
AND EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=90064810 AND o.QuestID=q.ID AND o.Type=0 AND o.StorageIndex=0 AND o.ObjectID=11920 AND o.Amount=1)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=480569 OR (o.QuestID=q.ID AND o.ID<>90064810))
AND EXISTS (SELECT 1 FROM `gameobject_template` t JOIN `gameobject` g ON g.id=t.entry
 WHERE t.entry=178145 AND t.ScriptName='go_resonite_cask' AND g.map=1)
AND EXISTS (SELECT 1 FROM `creature_template` t WHERE t.entry=11920);

UPDATE `quest_template` q
SET q.RewardChoiceItemID3=270010, q.RewardChoiceItemQuantity3=1
WHERE q.ID=6481 AND BINARY q.LogTitle=BINARY 'Earthen Arise' AND q.StartItem=16603
AND q.RewardChoiceItemID1=16981 AND q.RewardChoiceItemQuantity1=1
AND q.RewardChoiceItemID2=1306 AND q.RewardChoiceItemQuantity2=1
AND q.RewardChoiceItemID3=0 AND q.RewardChoiceItemQuantity3=0 AND q.RewardChoiceItemDisplayID3=0
AND q.RewardChoiceItemID4=0 AND q.RewardChoiceItemID5=0 AND q.RewardChoiceItemID6=0
AND EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=480569 AND o.QuestID=q.ID AND o.Type=1 AND o.StorageIndex=1 AND o.ObjectID=16603 AND o.Amount=1);

SET SESSION autocommit = 1;
