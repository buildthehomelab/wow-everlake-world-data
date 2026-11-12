-- Efficient Games 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- Apply after the captured Ongeku standing objective.
UPDATE `quest_template` q JOIN `quest_template` n ON n.ID=93034
SET q.RewardNextQuest=93034
WHERE q.ID=1373 AND q.RewardNextQuest=1374 AND BINARY q.LogTitle=BINARY 'Ongeku'
AND BINARY n.LogTitle=BINARY 'Valley of Bones' AND n.Flags=8 AND n.RewardNextQuest=93035
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=6 AND o.ObjectID=92 AND o.Amount=3000)
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=n.ID AND o.Type=6 AND o.ObjectID=92 AND o.Amount=9000)
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=n.ID AND e.id=5397 AND c.map=1 AND (COALESCE(c.npcflag,t.npcflag)&2)=2);
