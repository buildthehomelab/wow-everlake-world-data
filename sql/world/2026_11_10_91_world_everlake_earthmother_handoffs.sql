-- Questie Forever corrections, pin c0ce0c97ee, report both follow-ups at Boarton Shadetotem.
-- Preserve each quest's current acceptance rules while restoring the turn-in handoff.
UPDATE `quest_template` q JOIN `quest_template` n
 ON (q.ID=76156 AND n.ID=76160) OR (q.ID=76160 AND n.ID=76240)
SET q.RewardNextQuest=n.ID
WHERE q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Stalk With The Earthmother'
AND BINARY n.LogTitle=BINARY 'Stalk With The Earthmother'
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=n.ID AND e.id=205729 AND c.map=1 AND (COALESCE(c.npcflag,t.npcflag)&2)=2);
