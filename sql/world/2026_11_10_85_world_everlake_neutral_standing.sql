-- Efficient Games 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- Standing of zero is the Neutral threshold for minimum-reputation objectives.

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 384186,q.ID,6,1,1,576,0 FROM `quest_template` q
WHERE q.ID=8470 AND BINARY q.LogTitle=BINARY 'Deadwood Ritual Totem'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=20741 AND o.Amount=1)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=384186);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 472288,q.ID,6,1,-1,92,0 FROM `quest_template` q
WHERE q.ID=93227 AND BINARY q.LogTitle=BINARY 'Buying Friendship: Gelkis'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=257685 AND o.Amount=1)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=472288);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 472291,q.ID,6,1,-1,93,0 FROM `quest_template` q
WHERE q.ID=94872 AND BINARY q.LogTitle=BINARY 'Buying Friendship: Magram'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=257685 AND o.Amount=1)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=472291);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 472289,q.ID,6,1,-1,92,0 FROM `quest_template` q
WHERE q.ID=94873 AND BINARY q.LogTitle=BINARY 'Buying Friendship: Gelkis'
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=257685 AND o.Amount=1)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=472289);
