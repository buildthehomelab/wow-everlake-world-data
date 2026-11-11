-- Efficient Games 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

-- Relation-based ObjectID -1 preserves alternate exploration triggers.

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385521,q.ID,10,1,1,2926,1 FROM `quest_template` q
WHERE q.ID=25 AND BINARY q.LogTitle=BINARY 'Stonetalon Standstill'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=1
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (2926))=1
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385521 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=3917 AND o.Amount=12);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385475,q.ID,10,1,1,-1,1 FROM `quest_template` q
WHERE q.ID=287 AND BINARY q.LogTitle=BINARY 'Frostmane Hold'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=2
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (97,169))=2
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385475 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=1123 AND o.Amount=5);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385479,q.ID,10,1,1,173,1 FROM `quest_template` q
WHERE q.ID=437 AND BINARY q.LogTitle=BINARY 'The Dead Fields'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=1
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (173))=1
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385479 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3622 AND o.Amount=1);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385480,q.ID,10,2,2,175,1 FROM `quest_template` q
WHERE q.ID=455 AND BINARY q.LogTitle=BINARY 'The Algaz Gauntlet'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=1
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (175))=1
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385480 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=2)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=2
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=2103 AND o.Amount=8)
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=2102 AND o.Amount=6);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385481,q.ID,10,1,1,178,1 FROM `quest_template` q
WHERE q.ID=503 AND BINARY q.LogTitle=BINARY 'Gol''dir'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=1
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (178))=1
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385481 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3704 AND o.Amount=1);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385495,q.ID,10,1,1,522,1 FROM `quest_template` q
WHERE q.ID=1719 AND BINARY q.LogTitle=BINARY 'The Affray'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=1
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (522))=1
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385495 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=6238 AND o.Amount=1);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385517,q.ID,10,2,2,-1,1 FROM `quest_template` q
WHERE q.ID=5156 AND BINARY q.LogTitle=BINARY 'Verifying the Corruption'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=3
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (2206,2207,2208))=3
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385517 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=2)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=2
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=9878 AND o.Amount=2)
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=9879 AND o.Amount=2);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385520,q.ID,10,3,3,2726,1 FROM `quest_template` q
WHERE q.ID=6185 AND BINARY q.LogTitle=BINARY 'The Eastern Plagues'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=1
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (2726))=1
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385520 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=3)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=3
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=16003 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=16001 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=16002 AND o.Amount=1);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385522,q.ID,10,1,1,2946,1 FROM `quest_template` q
WHERE q.ID=6421 AND BINARY q.LogTitle=BINARY 'Boulderslide Ravine'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=1
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (2946))=1
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385522 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=16581 AND o.Amount=10);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385506,q.ID,10,1,1,-1,1 FROM `quest_template` q
WHERE q.ID=9261 AND BINARY q.LogTitle=BINARY 'Investigate the Scourge of Ironforge'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=2
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (4098,4099))=2
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385506 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=22892 AND o.Amount=3);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385510,q.ID,10,1,1,-1,1 FROM `quest_template` q
WHERE q.ID=9262 AND BINARY q.LogTitle=BINARY 'Investigate the Scourge of Darnassus'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=2
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (4104,4105))=2
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385510 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=22892 AND o.Amount=3);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385508,q.ID,10,1,1,-1,1 FROM `quest_template` q
WHERE q.ID=9263 AND BINARY q.LogTitle=BINARY 'Investigate the Scourge of Orgrimmar'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=2
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (4101,4102))=2
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385508 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=22892 AND o.Amount=3);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385509,q.ID,10,1,1,4103,1 FROM `quest_template` q
WHERE q.ID=9264 AND BINARY q.LogTitle=BINARY 'Investigate the Scourge of Thunder Bluff'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=1
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (4103))=1
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385509 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=22892 AND o.Amount=3);

INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 385507,q.ID,10,1,1,4100,1 FROM `quest_template` q
WHERE q.ID=9265 AND BINARY q.LogTitle=BINARY 'Investigate the Scourge of the Undercity'
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID)=1
AND (SELECT COUNT(*) FROM `areatrigger_involvedrelation` a WHERE a.quest=q.ID AND a.id IN (4100))=1
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=385507 OR (o.QuestID=q.ID AND (o.Type=10 OR o.StorageIndex=1)))
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=22892 AND o.Amount=3);
