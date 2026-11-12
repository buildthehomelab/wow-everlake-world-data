-- Wowhead Forever records 205 drops in 4514 Anvilrage Marshal kills for item 227904.
INSERT INTO creature_loot_template (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT d.LootID,0,227904,100.0*205/4514,0,1,0,1,1,'Anvilrage Marshal - Hardened Black Dragonscale Shoulders pattern'
FROM creature_template t
JOIN creature_template_difficulty d ON d.Entry=t.entry AND d.DifficultyID=0 AND d.LootID=8898
WHERE t.entry=8898 AND t.name='Anvilrage Marshal'
  AND EXISTS (SELECT 1 FROM creature WHERE id=t.entry AND map=230)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=d.LootID AND ItemType=0 AND Item=227904);
