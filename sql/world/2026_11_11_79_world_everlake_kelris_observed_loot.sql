-- Icy Veins Forever NPC 4832 lists each item at 1.22%, with average stack 1.
INSERT INTO creature_loot_template (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT d.LootID,0,drops.Item,1.22,0,1,0,1,1,'Twilight Lord Kelris - Icy Veins Forever observation'
FROM creature_template t
JOIN creature_template_difficulty d ON d.Entry=t.entry AND d.DifficultyID=0 AND d.LootID=4832
CROSS JOIN (
    SELECT 929 AS Item UNION ALL SELECT 1757 UNION ALL SELECT 1761
    UNION ALL SELECT 15118 UNION ALL SELECT 14378 UNION ALL SELECT 14177
) drops
WHERE t.entry=4832 AND t.name='Twilight Lord Kelris'
  AND EXISTS (SELECT 1 FROM creature WHERE id=t.entry AND map=48)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template l WHERE l.Entry=d.LootID AND l.ItemType=0 AND l.Item=drops.Item)
  AND NOT EXISTS (
      SELECT 1 FROM creature_loot_template l JOIN reference_loot_template r ON r.Entry=l.Item
      WHERE l.Entry=d.LootID AND l.ItemType=1 AND r.ItemType=0 AND r.Item=drops.Item
  );
