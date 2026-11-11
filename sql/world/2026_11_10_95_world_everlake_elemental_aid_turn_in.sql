-- Questie Forever trace c0ce0c97ee records Rau Cliffrunner as a turn-in.
INSERT INTO `creature_questender` (id,quest)
SELECT s.id,s.quest FROM `creature_queststarter` s
JOIN `quest_template` q ON q.ID=s.quest
WHERE s.quest=79360 AND s.id=4722 AND BINARY q.LogTitle=BINARY 'Elemental Aid'
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=s.id AND c.map=1 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=274463 AND o.Amount=1)
AND NOT EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=s.quest AND e.id=s.id);
