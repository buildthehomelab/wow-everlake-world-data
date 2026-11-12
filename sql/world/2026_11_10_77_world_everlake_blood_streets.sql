-- Efficient Games 70862 quest capture, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- Area entry objective 476994 requires a separate trigger capture.
SET SESSION autocommit = 0;
INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 477032,q.ID,1,1,1,279469,1 FROM `quest_template` q
WHERE q.ID=92434 AND BINARY q.LogTitle=BINARY 'Blood in the Streets'
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=477032 OR o.QuestID=q.ID)
AND EXISTS (SELECT 1 FROM `gameobject_template` t JOIN `gameobject` g ON g.id=t.entry
 JOIN `gameobject_loot_template` l ON l.Entry=t.Data1
 WHERE t.entry=670427 AND t.type=3 AND g.map=0 AND l.ItemType=0 AND l.Item=279469 AND l.Chance=100);

UPDATE `quest_template` q JOIN `quest_template` n ON n.ID=96984
SET q.RewardNextQuest=96984
WHERE q.ID=92434 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Blood in the Streets'
AND BINARY n.LogTitle=BINARY 'Heart of Disruption' AND n.Flags=0
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=477032 AND o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=279469 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=n.ID AND e.id=269127 AND c.map=0 AND (COALESCE(c.npcflag,t.npcflag)&2)=2);
SET SESSION autocommit = 1;
