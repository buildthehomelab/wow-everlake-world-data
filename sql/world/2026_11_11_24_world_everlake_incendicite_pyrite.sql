-- Icy Veins Forever item 249391 lists Pyrite at 2.4% for 1610 and 1.24% for 1667.
START TRANSACTION;
SET @split_incendicite := (
    (SELECT COUNT(*) FROM gameobject_template WHERE type=3 AND Data1=1409 AND entry IN (1610,1667))=2
    AND NOT EXISTS (SELECT 1 FROM gameobject_template WHERE type=3 AND (Data1=900001667 OR (Data1=1409 AND entry NOT IN (1610,1667))))
    AND NOT EXISTS (SELECT 1 FROM gameobject_loot_template WHERE Entry=900001667 OR (Entry=1409 AND Item=249391))
    AND EXISTS (SELECT 1 FROM gameobject_loot_template WHERE Entry=1409 AND ItemType=0 AND Item=3340)
);
INSERT INTO gameobject_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT 900001667,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment
FROM gameobject_loot_template WHERE Entry=1409 AND @split_incendicite;
INSERT INTO gameobject_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT source.loot,0,249391,source.chance,0,1,0,1,1,'Incendicite Mineral Vein - Pyrite'
FROM (SELECT 1409 AS loot,2.4 AS chance UNION ALL SELECT 900001667,1.24) source
WHERE @split_incendicite;
UPDATE gameobject_template SET Data1=900001667 WHERE entry=1667 AND Data1=1409 AND @split_incendicite;
COMMIT;
