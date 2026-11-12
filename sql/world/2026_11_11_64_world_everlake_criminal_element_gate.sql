-- Both faction versions of Welcome to Shen'dar Village lead to The Criminal Element.
-- https://forever-xp.com/quests/92517/
INSERT IGNORE INTO conditions
    (SourceTypeOrReferenceId, SourceEntry, ElseGroup, ConditionTypeOrReference, ConditionTarget, ConditionValue1, Comment)
SELECT 19, 92517, previous.ID = 93461, 8, 0, previous.ID, 'The Criminal Element requires either village introduction'
FROM quest_template AS previous
JOIN quest_template AS followup ON followup.ID = previous.RewardNextQuest
JOIN creature_questender AS turn_in ON turn_in.quest = previous.ID AND turn_in.id = 251523
JOIN creature_queststarter AS pickup ON pickup.quest = followup.ID AND pickup.id = turn_in.id
WHERE followup.ID = 92517 AND previous.ID IN (92514, 93461)
AND NOT EXISTS (
    SELECT 1 FROM conditions WHERE SourceTypeOrReferenceId = 19 AND SourceEntry = 92517
)
AND (
    SELECT COUNT(*) FROM quest_template WHERE ID IN (92514, 93461) AND RewardNextQuest = 92517
) = 2;
