-- Efficient Games 70862 quest capture and Wago AreaTrigger build 70862.
-- Captured trigger 1667 is in the same Theramore location as legacy trigger 302.
SET SESSION autocommit = 0;
INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385516,q.ID,10,0,0,1667,1 FROM `quest_template` q
WHERE q.ID=1265 AND BINARY q.LogTitle=BINARY 'The Missing Diplomat' AND q.Flags=12
AND EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id=302)
AND NOT EXISTS (SELECT 1 FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id<>302)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385516 OR o.QuestID=q.ID);

UPDATE `areatrigger_involvedrelation` a
SET a.id=1667
WHERE a.quest=1265 AND a.id=302
AND EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=385516 AND o.QuestID=a.quest AND o.Type=10 AND o.ObjectID=1667 AND o.Amount=1);
SET SESSION autocommit = 1;
