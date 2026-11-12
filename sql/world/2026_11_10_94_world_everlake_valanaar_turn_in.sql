-- Questie Forever turn-in trace (c0ce0c97ee) lists both Valanaar NPCs.
INSERT INTO `creature_questender` (id,quest)
SELECT 252476,q.ID FROM `quest_template` q
WHERE q.ID=92579 AND BINARY q.LogTitle=BINARY 'To Valanaar'
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=253152 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=252383)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=252476 AND c.map=2991 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=252476);
