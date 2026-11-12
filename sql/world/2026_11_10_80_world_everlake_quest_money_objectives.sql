-- Efficient Games 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

-- The pinned core charges quest_classic_money once at turn-in. These objectives check funds.

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 390870,q.ID,8,1,1,0,300 FROM `quest_template` q
JOIN `quest_classic_money` m ON m.ID=q.ID AND m.RewardMoney=-300
WHERE q.ID=2945 AND BINARY q.LogTitle=BINARY 'Grime-Encrusted Ring'
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=390870 OR (o.QuestID=q.ID AND (o.Type=8 OR o.StorageIndex=1)));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 390880,q.ID,8,3,3,0,3000 FROM `quest_template` q
JOIN `quest_classic_money` m ON m.ID=q.ID AND m.RewardMoney=-3000
WHERE q.ID=2948 AND BINARY q.LogTitle=BINARY 'Gnome Improvement'
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=390880 OR (o.QuestID=q.ID AND (o.Type=8 OR o.StorageIndex=3)));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 390883,q.ID,8,3,3,0,3000 FROM `quest_template` q
JOIN `quest_classic_money` m ON m.ID=q.ID AND m.RewardMoney=-3000
WHERE q.ID=2950 AND BINARY q.LogTitle=BINARY 'Nogg''s Ring Redo'
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=390883 OR (o.QuestID=q.ID AND (o.Type=8 OR o.StorageIndex=3)));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 390877,q.ID,8,1,1,0,300 FROM `quest_template` q
JOIN `quest_classic_money` m ON m.ID=q.ID AND m.RewardMoney=-300
WHERE q.ID=2951 AND BINARY q.LogTitle=BINARY 'The Sparklematic 5200!'
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=390877 OR (o.QuestID=q.ID AND (o.Type=8 OR o.StorageIndex=1)));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 390916,q.ID,8,1,1,0,300 FROM `quest_template` q
JOIN `quest_classic_money` m ON m.ID=q.ID AND m.RewardMoney=-300
WHERE q.ID=4601 AND BINARY q.LogTitle=BINARY 'The Sparklematic 5200!'
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=390916 OR (o.QuestID=q.ID AND (o.Type=8 OR o.StorageIndex=1)));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 390913,q.ID,8,1,1,0,300 FROM `quest_template` q
JOIN `quest_classic_money` m ON m.ID=q.ID AND m.RewardMoney=-300
WHERE q.ID=4602 AND BINARY q.LogTitle=BINARY 'The Sparklematic 5200!'
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=390913 OR (o.QuestID=q.ID AND (o.Type=8 OR o.StorageIndex=1)));

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 390907,q.ID,8,1,1,0,150000 FROM `quest_template` q
JOIN `quest_classic_money` m ON m.ID=q.ID AND m.RewardMoney=-150000
WHERE q.ID=5538 AND BINARY q.LogTitle=BINARY 'Mold Rhymes With...'
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o
 WHERE o.ID=390907 OR (o.QuestID=q.ID AND (o.Type=8 OR o.StorageIndex=1)));
