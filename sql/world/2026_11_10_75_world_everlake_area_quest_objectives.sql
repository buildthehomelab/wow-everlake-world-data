-- Efficient Games 70862 quest capture, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385476,q.ID,10,0,0,98,1 FROM `quest_template` q
WHERE q.ID=201 AND BINARY q.LogTitle=BINARY 'Investigate the Camp'
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id=98)
AND NOT EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id<>98)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385476 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385482,q.ID,10,0,0,196,1 FROM `quest_template` q
WHERE q.ID=578 AND BINARY q.LogTitle=BINARY 'The Stone of the Tides'
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id=196)
AND NOT EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id<>196)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385482 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385484,q.ID,10,0,0,216,1 FROM `quest_template` q
WHERE q.ID=870 AND BINARY q.LogTitle=BINARY 'The Forgotten Pools'
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id=216)
AND NOT EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id<>216)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385484 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385491,q.ID,10,0,0,246,1 FROM `quest_template` q
WHERE q.ID=1149 AND BINARY q.LogTitle=BINARY 'Test of Faith'
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id=246)
AND NOT EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id<>246)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385491 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385492,q.ID,10,0,0,362,1 FROM `quest_template` q
WHERE q.ID=1448 AND BINARY q.LogTitle=BINARY 'In Search of The Temple'
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id=362)
AND NOT EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id<>362)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385492 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385504,q.ID,10,0,0,3991,1 FROM `quest_template` q
WHERE q.ID=1658 AND BINARY q.LogTitle=BINARY 'Crashing the Wickerman Festival'
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id=3991)
AND NOT EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id<>3991)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385504 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385494,q.ID,10,0,0,482,1 FROM `quest_template` q
WHERE q.ID=1699 AND BINARY q.LogTitle=BINARY 'The Rethban Gauntlet'
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id=482)
AND NOT EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id<>482)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385494 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385519,q.ID,10,0,0,2486,1 FROM `quest_template` q
WHERE q.ID=4811 AND BINARY q.LogTitle=BINARY 'The Red Crystal'
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id=2486)
AND NOT EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id<>2486)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385519 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385518,q.ID,10,0,0,2327,1 FROM `quest_template` q
WHERE q.ID=4842 AND BINARY q.LogTitle=BINARY 'Strange Sources'
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id=2327)
AND NOT EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id<>2327)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385518 OR o.QuestID=q.ID);
