-- Efficient Games 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- Keep the existing completed-form objective in storage slot 0.

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 471440,q.ID,1,1,1,270888,1 FROM `quest_template` q
WHERE q.ID=95816 AND BINARY q.LogTitle=BINARY 'Sign Me Up!' AND q.StartItem=270896
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.`Order`=0 AND o.StorageIndex=0 AND o.ObjectID=270897 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `npc_vendor` v WHERE v.entry=256389 AND v.item=270888)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.id=256391 AND e.quest=q.ID)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=471440);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 471448,q.ID,1,1,2,270887,1 FROM `quest_template` q
WHERE q.ID=95819 AND BINARY q.LogTitle=BINARY 'Sign Me Up!' AND q.StartItem=270896
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.`Order`=0 AND o.StorageIndex=0 AND o.ObjectID=270897 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `npc_vendor` v WHERE v.entry=256384 AND v.item=270887)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.id=256388 AND e.quest=q.ID)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=471448);
