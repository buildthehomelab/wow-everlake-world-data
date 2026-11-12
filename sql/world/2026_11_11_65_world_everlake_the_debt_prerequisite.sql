-- Pinned Forever capture links The Windshaperx27s Wrath to The Debt.
-- https://bindonforever.com/quest/95034
INSERT INTO quest_template_addon (ID, PrevQuestID)
SELECT followup.ID, previous.ID
FROM quest_template AS previous
JOIN quest_template AS followup ON followup.ID = previous.RewardNextQuest
JOIN creature_questender AS turn_in ON turn_in.quest = previous.ID AND turn_in.id = 259620
JOIN creature_queststarter AS pickup ON pickup.quest = followup.ID AND pickup.id = turn_in.id
WHERE previous.ID = 96204 AND followup.ID = 95034
AND NOT EXISTS (
    SELECT 1 FROM conditions WHERE SourceTypeOrReferenceId = 19 AND SourceEntry = followup.ID
)
ON DUPLICATE KEY UPDATE PrevQuestID = IF(quest_template_addon.PrevQuestID = 0, 96204, quest_template_addon.PrevQuestID);
