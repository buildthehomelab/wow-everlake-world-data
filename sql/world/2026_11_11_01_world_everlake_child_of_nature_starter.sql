-- Questie Forever trace c0ce0c97ee records Alaana Stormwalker as an alternate starter.
INSERT INTO `creature_queststarter` (id,quest)
SELECT 259119,q.ID FROM `quest_template` q
WHERE q.ID=94911 AND BINARY q.LogTitle=BINARY 'Child of Nature'
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=259118)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=3033)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=259119 AND c.map=1 AND BINARY t.name=BINARY 'Alaana Stormwalker'
 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=259119);
