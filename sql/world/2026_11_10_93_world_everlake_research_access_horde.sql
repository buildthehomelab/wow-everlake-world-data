-- Questie Forever Horde corrections (c0ce0c97ee) list Owen Thadd as starter and turn-in.
INSERT INTO `creature_queststarter` (id,quest)
SELECT e.id,e.quest
FROM `creature_questender` e
JOIN `quest_template` q ON q.ID=e.quest
JOIN `quest_template_addon` a ON a.ID=q.ID
JOIN `creature_template` t ON t.entry=e.id
WHERE e.id=211022 AND e.quest=97286 AND BINARY q.LogTitle=BINARY 'Research Access'
AND BINARY t.name=BINARY 'Owen Thadd' AND q.RewardSpell=1302696 AND a.AllowableClasses=128
AND EXISTS (SELECT 1 FROM `creature` c WHERE c.id=e.id AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.id=211033 AND s.quest=q.ID)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.id=e.id AND s.quest=e.quest);
