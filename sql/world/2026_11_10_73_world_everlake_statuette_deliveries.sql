-- Efficient Games 70862 quest capture, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

SET SESSION autocommit = 0;

INSERT INTO `quest_objectives` (ID, QuestID, Type, `Order`, StorageIndex, ObjectID, Amount)
SELECT 476964, q.ID, 1, 0, 0, 279589, 1
FROM `quest_template` q
WHERE q.ID=98189 AND BINARY q.LogTitle=BINARY 'Return the Statuette' AND q.StartItem=0 AND q.RewardNextQuest=0
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=476964 OR o.QuestID=q.ID)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=1242 AND c.map=0)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=2104 AND c.map=0)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=98190 AND s.id=2104);

UPDATE `quest_template` q
SET q.StartItem=279589, q.RewardNextQuest=98190
WHERE q.ID=98189 AND BINARY q.LogTitle=BINARY 'Return the Statuette' AND q.StartItem=0 AND q.RewardNextQuest=0
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=476964 AND o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=279589 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=1242 AND c.map=0)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=2104 AND c.map=0)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=98190 AND s.id=2104);

INSERT INTO `quest_objectives` (ID, QuestID, Type, `Order`, StorageIndex, ObjectID, Amount)
SELECT 476966, q.ID, 1, 0, 0, 279595, 1
FROM `quest_template` q
WHERE q.ID=98190 AND BINARY q.LogTitle=BINARY 'A Friend of the Family' AND q.StartItem=0 AND q.RewardNextQuest=0
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=476966 OR o.QuestID=q.ID)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=2104 AND c.map=0)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=1748 AND c.map=0)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=98191 AND s.id=1748);

UPDATE `quest_template` q
SET q.StartItem=279595, q.RewardNextQuest=98191
WHERE q.ID=98190 AND BINARY q.LogTitle=BINARY 'A Friend of the Family' AND q.StartItem=0 AND q.RewardNextQuest=0
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=476966 AND o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=279595 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=2104 AND c.map=0)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=1748 AND c.map=0)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=98191 AND s.id=1748);

INSERT INTO `quest_objectives` (ID, QuestID, Type, `Order`, StorageIndex, ObjectID, Amount)
SELECT 476967, q.ID, 1, 0, 0, 279598, 1
FROM `quest_template` q
WHERE q.ID=98191 AND BINARY q.LogTitle=BINARY 'A Friend of the Family' AND q.StartItem=0 AND q.RewardNextQuest=0
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=476967 OR o.QuestID=q.ID)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=1748 AND c.map=0)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=928 AND c.map=0);

UPDATE `quest_template` q
SET q.StartItem=279598, q.RewardNextQuest=0
WHERE q.ID=98191 AND BINARY q.LogTitle=BINARY 'A Friend of the Family' AND q.StartItem=0 AND q.RewardNextQuest=0
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=476967 AND o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=279598 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=1748 AND c.map=0)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=928 AND c.map=0);

SET SESSION autocommit = 1;
