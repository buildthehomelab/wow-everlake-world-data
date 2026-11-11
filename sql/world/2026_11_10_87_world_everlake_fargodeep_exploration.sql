-- Efficient Games build 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- The pinned core's classic area-trigger hotfix registers legacy triggers 88 and 197.
-- Use relation-based exploration credit while the captured trigger 44590 lacks geometry.
INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385474,q.ID,10,0,0,-1,1 FROM `quest_template` q
WHERE q.ID=62 AND BINARY q.LogTitle=BINARY 'The Fargodeep Mine'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=2
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (88,197))=2
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385474 OR o.QuestID=q.ID);
