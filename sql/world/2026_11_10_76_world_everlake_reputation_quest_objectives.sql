-- Efficient Games 70862 quest capture, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 381144,q.ID,6,0,0,93,3000 FROM `quest_template` q
WHERE q.ID=1367 AND BINARY q.LogTitle=BINARY 'Magram Alliance'
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=5412)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=5398)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=381144 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 381185,q.ID,6,0,0,92,3000 FROM `quest_template` q
WHERE q.ID=1368 AND BINARY q.LogTitle=BINARY 'Gelkis Alliance'
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=5412)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=5397)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=381185 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 381571,q.ID,6,0,0,92,3000 FROM `quest_template` q
WHERE q.ID=1382 AND BINARY q.LogTitle=BINARY 'Strange Alliance'
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=5396)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=5397)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=381571 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 381398,q.ID,6,0,0,93,3000 FROM `quest_template` q
WHERE q.ID=1385 AND BINARY q.LogTitle=BINARY 'Brutal Politics'
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=5396)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=5398)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=381398 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 384263,q.ID,6,0,0,509,3000 FROM `quest_template` q
WHERE q.ID=8260 AND BINARY q.LogTitle=BINARY 'Arathor Basic Care Package'
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=15127)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=15127)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=384263 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 383722,q.ID,6,0,0,510,3000 FROM `quest_template` q
WHERE q.ID=8263 AND BINARY q.LogTitle=BINARY 'Defiler''s Basic Care Package'
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=15126)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id WHERE e.quest=q.ID AND e.id=15126)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=383722 OR o.QuestID=q.ID);
