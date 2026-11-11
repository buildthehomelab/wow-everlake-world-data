-- Efficient Games 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

-- ObjectID -1 uses the existing quest trigger relations in the pinned core.

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385473,q.ID,10,0,0,-1,1 FROM `quest_template` q
WHERE q.ID=76 AND BINARY q.LogTitle=BINARY 'The Jasperlode Mine'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=2
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (87,342))=2
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385473 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385489,q.ID,10,0,0,-1,0 FROM `quest_template` q
WHERE q.ID=944 AND BINARY q.LogTitle=BINARY 'The Master''s Glaive'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=3
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (223,224,225))=3
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385489 OR o.QuestID=q.ID);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385496,q.ID,10,0,0,-1,1 FROM `quest_template` q
WHERE q.ID=6025 AND BINARY q.LogTitle=BINARY 'Unfinished Business'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=2
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (3366,3367))=2
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385496 OR o.QuestID=q.ID);
