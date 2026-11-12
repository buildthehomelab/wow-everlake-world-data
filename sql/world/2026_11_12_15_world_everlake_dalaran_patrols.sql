-- EG Link 3067c691: ten captured builds agree on eight Elemental Slaves for quest 545.
UPDATE quest_objectives
SET Amount = 8
WHERE ID = 90005451 AND QuestID = 545 AND Type = 0
  AND StorageIndex = 1 AND ObjectID = 2359 AND Amount = 12;
