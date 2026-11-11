-- Persist the pinned quest loader's one-item fallback for these five quests.
INSERT INTO quest_template_addon (ID, ProvidedItemCount)
SELECT q.ID, 1
FROM quest_template q
LEFT JOIN quest_template_addon a ON a.ID = q.ID
WHERE (q.ID, q.StartItem) IN (
    (95189, 268579), (95204, 275521), (97288, 280438), (98423, 281030), (98823, 287958)
)
  AND COALESCE(a.ProvidedItemCount, 0) = 0
  AND EXISTS (
      SELECT 1 FROM quest_objectives o
      WHERE o.QuestID = q.ID AND o.Type = 1 AND o.ObjectID = q.StartItem AND o.Amount = 1
  )
ON DUPLICATE KEY UPDATE ProvidedItemCount = IF(quest_template_addon.ProvidedItemCount = 0, 1, quest_template_addon.ProvidedItemCount);
