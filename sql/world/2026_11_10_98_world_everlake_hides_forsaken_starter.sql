-- Questie Forever trace c0ce0c97ee records Deathguard Linnea as an alternate starter.
INSERT INTO `creature_queststarter` (id,quest)
SELECT 1495,q.ID FROM `quest_template` q
WHERE q.ID=97558 AND BINARY q.LogTitle=BINARY 'Hides for the Forsaken'
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=3549)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=3549)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=1495 AND c.map=0 AND BINARY t.name=BINARY 'Deathguard Linnea'
 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=1495);
