-- Questie Forever trace c0ce0c97ee records Danitha Morr and Leonid as turn-ins.
INSERT INTO `creature_questender` (id,quest)
SELECT 246378,q.ID FROM `quest_template` q
WHERE q.ID=96896 AND BINARY q.LogTitle=BINARY 'A Righteous Cause'
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=267008)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=246378 AND c.map=0 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=246378);
