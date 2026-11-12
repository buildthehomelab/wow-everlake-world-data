-- Efficient Games build 70862 quest capture, CC BY 4.0.
-- Source pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
INSERT INTO `quest_objectives` (ID, QuestID, Type, `Order`, StorageIndex, ObjectID, Amount)
SELECT 478265, q.ID, 1, 0, 0, 282416, 1
FROM `quest_template` q
WHERE q.ID=92481 AND BINARY q.LogTitle=BINARY 'A Student of the Arcane' AND q.StartItem=282416
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=478265 OR o.QuestID=q.ID)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id
 WHERE s.quest=q.ID AND s.id=251361 AND c.map=2991)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id
 WHERE e.quest=q.ID AND e.id=251379 AND c.map=2991);
