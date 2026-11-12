-- Forever 70790 SpellEffect confirms 5396 teaches Healing Stream Totem (5394).
-- Existing Call of Water quests 96 and 9509 use this wrapper.
UPDATE quest_template q
SET q.RewardSpell=5396
WHERE q.ID=94505 AND q.LogTitle='Call of Water' AND q.RewardSpell=1277349
  AND EXISTS (SELECT 1 FROM quest_reward_display_spell d
              WHERE d.QuestID=q.ID AND d.SpellID=5394 AND d.Type=3);

-- Match the core's one-item grant in the inventory preflight as well.
UPDATE quest_template_addon a
JOIN quest_template q ON q.ID=a.ID
SET a.ProvidedItemCount=1
WHERE q.ID=94505 AND q.LogTitle='Call of Water' AND q.StartItem=7813
  AND a.ProvidedItemCount=0
  AND EXISTS (SELECT 1 FROM quest_objectives o
              WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=7813 AND o.Amount=1);
