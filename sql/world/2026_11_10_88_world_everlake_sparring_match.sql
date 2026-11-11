-- Efficient Games build 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- Criteria tree 234591 sums player duel wins and kills of Novice Warrior (10721).
INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Description)
SELECT 479385,q.ID,14,0,0,234591,1,'Player Duels won or Novice Warriors defeated'
FROM `quest_template` q
WHERE q.ID=99108 AND BINARY q.LogTitle=BINARY 'Sparring Match'
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=3063 AND c.map=1)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=3063)
AND EXISTS (SELECT 1 FROM `creature` c WHERE c.id=10721 AND c.map=1)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=479385 OR o.QuestID=q.ID OR (o.Type=14 AND o.ObjectID=234591));
