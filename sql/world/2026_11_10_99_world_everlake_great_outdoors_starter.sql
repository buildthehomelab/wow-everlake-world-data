-- Questie Forever trace c0ce0c97ee records Senir Whitebeard as an alternate starter.
INSERT INTO `creature_queststarter` (id,quest)
SELECT 1252,q.ID FROM `quest_template` q
WHERE q.ID=96608 AND BINARY q.LogTitle=BINARY 'The Great Outdoors'
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=265813)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=265813)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=1252 AND c.map=0 AND BINARY t.name=BINARY 'Senir Whitebeard'
 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=1252);
