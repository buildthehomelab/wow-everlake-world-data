-- Questie Forever trace c0ce0c97ee lists all three Valennia Stormfist quest starters.
INSERT INTO `creature_queststarter` (id,quest)
SELECT t.entry,q.ID FROM `quest_template` q
CROSS JOIN `creature_template` t
WHERE q.ID=93949 AND BINARY q.LogTitle=BINARY 'Bugged'
AND t.entry IN (253590,253844) AND BINARY t.name=BINARY 'Valennia Stormfist'
AND EXISTS (SELECT 1 FROM `creature` c WHERE c.id=t.entry AND c.map=2991 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=251727 AND o.Amount=8)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=252383)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=t.entry);
