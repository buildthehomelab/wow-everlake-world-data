-- The Forever quest record requires Lost in Battle before Her Name Is Olgra.
-- https://questing.wiki/wow-forever/quests/95774/
INSERT INTO quest_template_addon (ID, PrevQuestID)
SELECT followup.ID, previous.ID
FROM quest_template AS previous
JOIN quest_template AS followup ON followup.ID = previous.RewardNextQuest
JOIN creature_questender AS turn_in ON turn_in.quest = previous.ID AND turn_in.id = 3432
JOIN creature_queststarter AS pickup ON pickup.quest = followup.ID AND pickup.id = turn_in.id
WHERE previous.ID = 4921 AND followup.ID = 95774
AND NOT EXISTS (
    SELECT 1 FROM conditions WHERE SourceTypeOrReferenceId = 19 AND SourceEntry = followup.ID
)
ON DUPLICATE KEY UPDATE PrevQuestID = IF(quest_template_addon.PrevQuestID = 0, 4921, quest_template_addon.PrevQuestID);
