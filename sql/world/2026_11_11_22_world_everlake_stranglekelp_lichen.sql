-- Icy Veins item 249399 lists Stranglekelp 2045 at 7.85%, stack 1.
-- Efficient Games Forever 70862 corroborates the source in a four-window capture.
INSERT INTO gameobject_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT 1733,0,249399,7.85,0,1,0,1,1,'Stranglekelp - Frilled Lichen'
WHERE EXISTS (
    SELECT 1 FROM gameobject_template t JOIN gameobject g ON g.id=t.entry
    WHERE t.entry=2045 AND t.type=3 AND t.Data1=1733
)
AND NOT EXISTS (SELECT 1 FROM gameobject_template WHERE type=3 AND Data1=1733 AND (entry NOT IN (2045,9702045) OR name<>'Stranglekelp' OR displayId<>700))
AND EXISTS (SELECT 1 FROM gameobject_loot_template WHERE Entry=1733 AND ItemType=0 AND Item=3820)
AND NOT EXISTS (SELECT 1 FROM gameobject_loot_template WHERE Entry=1733 AND ItemType=0 AND Item=249399);
