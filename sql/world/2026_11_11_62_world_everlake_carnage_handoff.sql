-- Efficient Games Forever 70862 quest capture, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae (CC BY 4.0).
UPDATE quest_template AS previous
JOIN quest_template AS followup ON followup.ID = 98283 AND followup.LogTitle = 'Carnage'
JOIN quest_template_addon AS gate ON gate.ID = followup.ID AND gate.PrevQuestID = previous.ID
JOIN creature_questender AS turn_in ON turn_in.quest = previous.ID AND turn_in.id = 1244
JOIN creature_queststarter AS pickup ON pickup.quest = followup.ID AND pickup.id = turn_in.id
SET previous.RewardNextQuest = followup.ID
WHERE previous.ID = 275 AND previous.RewardNextQuest = 0;
