-- Efficient Games 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

UPDATE `quest_template` q JOIN `quest_template` n ON n.ID=7877
SET q.RewardNextQuest=n.ID
WHERE q.ID=7461 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'The Madness Within'
AND BINARY n.LogTitle=BINARY 'The Treasure of the Shen''dralar'
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=n.ID AND e.id=14358 AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` n ON n.ID=95034
SET q.RewardNextQuest=n.ID
WHERE q.ID=96204 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'The Windshaper''s Wrath'
AND BINARY n.LogTitle=BINARY 'The Debt'
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=n.ID AND e.id=259620 AND (COALESCE(c.npcflag,t.npcflag)&2)=2);
