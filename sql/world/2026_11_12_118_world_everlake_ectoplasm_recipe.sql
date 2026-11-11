-- Color spells are display transforms. The placed creature uses loot ID 3640.
INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT 3640,0,3396,0.018,0,1,0,1,1,'Evolving Ectoplasm: Recipe: Elixir of Lesser Agility (Icy Veins)'
WHERE EXISTS (SELECT 1 FROM creature_template_difficulty WHERE Entry=3640 AND DifficultyID=0 AND LootID=3640)
  AND NOT EXISTS (SELECT 1 FROM creature WHERE id IN (5776,5777,5778))
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=3640 AND Entry NOT IN (3640,5776,5777,5778))
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=3640 AND ItemType=0 AND Item=3396);
