-- Efficient Games 70862 quest capture, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
UPDATE `quest_template` q JOIN `quest_template` n ON n.ID=91861
SET q.RewardNextQuest=91861
WHERE q.ID=91860 AND q.RewardNextQuest=0
AND BINARY q.LogTitle=BINARY 'A Grim Fate'
AND BINARY n.LogTitle=BINARY 'Into Fenris Keep' AND n.Flags=0
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID)
AND EXISTS (SELECT 1 FROM `gameobject_questender` e JOIN `gameobject_queststarter` s ON s.id=e.id
 JOIN `gameobject` g ON g.id=e.id JOIN `gameobject_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=n.ID AND e.id=566037 AND g.map=0 AND t.type=2);
