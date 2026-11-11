-- Efficient Games 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 381562,q.ID,6,1,1,93,3000 FROM `quest_template` q
WHERE q.ID=1369 AND BINARY q.LogTitle=BINARY 'Broken Tears'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=6083 AND o.Amount=3)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=381562 OR (o.QuestID=q.ID AND (o.Type=6 OR (o.StorageIndex=1 AND 1>=0))));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 381230,q.ID,6,1,-1,92,3000 FROM `quest_template` q
WHERE q.ID=1373 AND BINARY q.LogTitle=BINARY 'Ongeku'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=6190 AND o.Amount=1)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=381230 OR (o.QuestID=q.ID AND (o.Type=6 OR (o.StorageIndex=-1 AND -1>=0))));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 381348,q.ID,6,1,1,92,3000 FROM `quest_template` q
WHERE q.ID=1384 AND BINARY q.LogTitle=BINARY 'Raid on the Kolkar'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=6079 AND o.Amount=10)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=381348 OR (o.QuestID=q.ID AND (o.Type=6 OR (o.StorageIndex=1 AND 1>=0))));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 381577,q.ID,6,3,3,93,3000 FROM `quest_template` q
WHERE q.ID=1386 AND BINARY q.LogTitle=BINARY 'Assault on the Kolkar'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=3
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=4632 AND o.Amount=12)
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=4633 AND o.Amount=12)
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=4634 AND o.Amount=6)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=381577 OR (o.QuestID=q.ID AND (o.Type=6 OR (o.StorageIndex=3 AND 3>=0))));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 465591,q.ID,6,1,-1,93,3000 FROM `quest_template` q
WHERE q.ID=92818 AND BINARY q.LogTitle=BINARY 'Big, No, MASSIVE Iron Axes'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3855 AND o.Amount=2)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=465591 OR (o.QuestID=q.ID AND (o.Type=6 OR (o.StorageIndex=-1 AND -1>=0))));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 466025,q.ID,6,1,-1,92,9000 FROM `quest_template` q
WHERE q.ID=93062 AND BINARY q.LogTitle=BINARY 'Bone Burying'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=253446 AND o.Amount=8)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=466025 OR (o.QuestID=q.ID AND (o.Type=6 OR (o.StorageIndex=-1 AND -1>=0))));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 466189,q.ID,6,1,-1,92,9000 FROM `quest_template` q
WHERE q.ID=93128 AND BINARY q.LogTitle=BINARY 'Khan Jehn'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=5601 AND o.Amount=1)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=466189 OR (o.QuestID=q.ID AND (o.Type=6 OR (o.StorageIndex=-1 AND -1>=0))));
