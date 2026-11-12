-- Icy Veins Forever NPC 4830 lists Plans: Green Iron Gauntlets at 0.166%.
INSERT INTO creature_loot_template (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT d.LootID,0,3612,0.166,0,1,0,1,1,'Old Serra''kis - Plans: Green Iron Gauntlets'
FROM creature_template_difficulty d
WHERE d.Entry=4830 AND d.DifficultyID=0 AND d.LootID=4830
  AND EXISTS (SELECT 1 FROM creature WHERE id=d.Entry AND map=48)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=d.LootID AND ItemType=0 AND Item=3612)
  AND NOT EXISTS (
      SELECT 1 FROM creature_loot_template l JOIN reference_loot_template r ON r.Entry=l.Item
      WHERE l.Entry=d.LootID AND l.ItemType=1 AND r.ItemType=0 AND r.Item=3612
  );
