-- EG Link 70862 observed four single-item drops in 12 Sprung Trap windows.
INSERT INTO gameobject_loot_template (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT t.Data1,0,269739,33.333,0,1,0,1,1,'Sprung Trap - Bloody Tuft of Fur'
FROM gameobject_template t
WHERE t.entry=640104 AND t.type=3 AND t.Data1=640104
  AND EXISTS (SELECT 1 FROM gameobject WHERE id=t.entry AND map=1)
  AND NOT EXISTS (SELECT 1 FROM gameobject_template WHERE type=3 AND Data1=t.Data1 AND entry<>t.entry)
  AND NOT EXISTS (SELECT 1 FROM gameobject_loot_template WHERE Entry=t.Data1 AND ItemType=0 AND Item=269739)
  AND NOT EXISTS (
    SELECT 1 FROM gameobject_loot_template l
    JOIN reference_loot_template r ON r.Entry=l.Item AND r.ItemType=0 AND r.Item=269739
    WHERE l.Entry=t.Data1 AND l.ItemType=1
  );
