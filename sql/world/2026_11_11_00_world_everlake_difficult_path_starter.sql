-- Questie Forever trace c0ce0c97ee lists Novice Elreth as an alternate starter.
INSERT INTO `creature_queststarter` (id,quest)
SELECT 1661,q.ID FROM `quest_template` q
JOIN `quest_template_addon` a ON a.ID=q.ID
WHERE q.ID=98601 AND BINARY q.LogTitle=BINARY 'A Difficult Path'
AND q.AllowableRaces=16 AND a.AllowableClasses=2 AND a.PrevQuestID=364
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=1569)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=244808)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=1661 AND c.map=0 AND BINARY t.name=BINARY 'Novice Elreth'
 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=1661);
