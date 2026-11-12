-- Efficient Games 70862 (CC BY 4.0) captures objective 445448.
-- Questie Forever c0ce0c97ee lists Owen Thadd and the Mural of Ta'zo.
INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT 445448,q.ID,1,0,1,207972,1 FROM `quest_template` q
WHERE q.ID=79094 AND BINARY q.LogTitle=BINARY 'The Lessons of Ta''zo' AND q.AllowableRaces=8589934770
AND EXISTS (SELECT 1 FROM `gameobject_template` t JOIN `gameobject` g ON g.id=t.entry
 WHERE t.entry=405149 AND t.Type=10 AND t.Data10=417293 AND g.map=1)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=211022)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=445448 OR o.QuestID=q.ID);

INSERT INTO `creature_queststarter` (id,quest)
SELECT e.id,e.quest FROM `creature_questender` e
JOIN `quest_template` q ON q.ID=e.quest
WHERE e.quest=79094 AND e.id=211022 AND BINARY q.LogTitle=BINARY 'The Lessons of Ta''zo'
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID=445448 AND o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=207972 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=e.id AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.id=e.id AND s.quest=e.quest);
