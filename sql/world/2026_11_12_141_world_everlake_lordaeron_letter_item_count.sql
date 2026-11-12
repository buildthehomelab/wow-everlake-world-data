-- Both stages provide the letter required by their single-item objective.
-- https://db.icy-veins.com/api/catalog/wowf/quest/92415
-- https://db.icy-veins.com/api/catalog/wowf/quest/95161
UPDATE quest_template_addon a
JOIN quest_template q ON q.ID = a.ID
SET a.ProvidedItemCount = 1
WHERE a.ID IN (92415, 95161)
  AND a.ProvidedItemCount = 0
  AND q.StartItem = 251522
  AND EXISTS (
      SELECT 1 FROM quest_objectives o
      WHERE o.QuestID = q.ID AND o.Type = 1 AND o.ObjectID = 251522 AND o.Amount = 1
  );
