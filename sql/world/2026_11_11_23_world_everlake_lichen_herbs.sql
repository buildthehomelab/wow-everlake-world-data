-- Icy Veins Forever item 249399: Wild Steelbloom and Grave Moss, stack 1.
INSERT INTO gameobject_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT h.loot,0,249399,h.chance,0,1,0,1,1,CONCAT(h.name,' - Frilled Lichen')
FROM (
    SELECT 1623 AS object_id,1420 AS loot,7.61 AS chance,'Wild Steelbloom' AS name,3355 AS herb
    UNION ALL SELECT 1628,1424,6.84,'Grave Moss',3369
) h
WHERE EXISTS (
    SELECT 1 FROM gameobject_template t JOIN gameobject g ON g.id=t.entry
    WHERE t.entry=h.object_id AND t.type=3 AND t.Data1=h.loot AND t.name=h.name
)
AND NOT EXISTS (SELECT 1 FROM gameobject_template t WHERE t.type=3 AND t.Data1=h.loot AND t.name<>h.name)
AND EXISTS (SELECT 1 FROM gameobject_loot_template l WHERE l.Entry=h.loot AND l.ItemType=0 AND l.Item=h.herb)
AND NOT EXISTS (SELECT 1 FROM gameobject_loot_template l WHERE l.Entry=h.loot AND l.ItemType=0 AND l.Item=249399);
