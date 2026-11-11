-- More Glowing Scorpid Blood is the repeatable follow-up to Glowing Scorpid Blood.
UPDATE quest_template_addon repeatable
JOIN quest_template_addon first_turn_in
  ON first_turn_in.ID = 8222 AND first_turn_in.NextQuestID = repeatable.ID
SET repeatable.PrevQuestID = first_turn_in.ID
WHERE repeatable.ID = 8223 AND repeatable.PrevQuestID = repeatable.ID;
