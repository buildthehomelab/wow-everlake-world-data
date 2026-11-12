-- Efficient Games build 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- Keep the existing item objective ID and storage index for active quests.
SET SESSION autocommit = 0;

INSERT INTO `quest_objectives` (ID, QuestID, Type, `Order`, StorageIndex, ObjectID, Amount)
SELECT 381762, q.ID, 6, 1, -1, 93, 3000
FROM `quest_template` q
WHERE q.ID=1371 AND BINARY q.LogTitle=BINARY 'Gizmo for Warug'
AND q.RewardChoiceItemID1=0 AND q.RewardChoiceItemID2=0
AND EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=90013714 AND o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=4392 AND o.Amount=1)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=381762 OR (o.QuestID=q.ID AND o.ID<>90013714))
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature_questender` e ON e.id=s.id AND e.quest=s.quest
 JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=5398 AND c.map=1);

UPDATE `quest_template` q
SET q.RewardChoiceItemID1=269903, q.RewardChoiceItemQuantity1=1,
    q.RewardChoiceItemID2=269901, q.RewardChoiceItemQuantity2=1,
    q.RewardFactionID1=93, q.RewardFactionOverride1=100000,
    q.RewardFactionID2=92, q.RewardFactionOverride2=-500000
WHERE q.ID=1371 AND BINARY q.LogTitle=BINARY 'Gizmo for Warug'
AND q.RewardChoiceItemID1=0 AND q.RewardChoiceItemID2=0 AND q.RewardChoiceItemID3=0
AND q.RewardChoiceItemID4=0 AND q.RewardChoiceItemID5=0 AND q.RewardChoiceItemID6=0
AND q.RewardFactionID1=0 AND q.RewardFactionOverride1=0 AND q.RewardFactionValue1=0
AND q.RewardFactionID2=0 AND q.RewardFactionOverride2=0 AND q.RewardFactionValue2=0
AND EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=381762 AND o.QuestID=q.ID AND o.Type=6 AND o.ObjectID=93 AND o.Amount=3000);

SET SESSION autocommit = 1;
