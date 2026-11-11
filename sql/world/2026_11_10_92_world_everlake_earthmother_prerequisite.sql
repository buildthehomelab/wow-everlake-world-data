-- Questie Forever corrections (c0ce0c97ee) and NorgannonDB (d25c1151b3) list 76156 before 76160.
UPDATE `quest_template_addon` a
JOIN `quest_template` q ON q.ID=a.ID
JOIN `quest_template` p ON p.ID=76156
SET a.PrevQuestID=p.ID
WHERE a.ID=76160 AND a.PrevQuestID=0 AND a.BreadcrumbForQuestId=0
AND BINARY q.LogTitle=BINARY 'Stalk With The Earthmother'
AND BINARY p.LogTitle=BINARY 'Stalk With The Earthmother'
AND q.AllowableRaces=162 AND p.AllowableRaces=q.AllowableRaces
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 WHERE e.quest=p.ID AND s.quest=q.ID AND e.id=205729);
