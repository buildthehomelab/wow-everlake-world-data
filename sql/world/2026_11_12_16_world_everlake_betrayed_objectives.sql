-- EG Link 3067c691, build 70888, quest 3505.
UPDATE quest_objectives
SET Amount = 6
WHERE QuestID = 3505 AND Type = 0 AND Amount = 10
  AND ((StorageIndex = 0 AND ObjectID = 6199)
    OR (StorageIndex = 1 AND ObjectID = 6198));
