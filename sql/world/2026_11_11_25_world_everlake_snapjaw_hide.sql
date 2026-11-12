-- Efficient Games Forever 70862 recorded 3 drops in 107 Snapjaw skinning windows.
-- The 70862 drops averaged two hides; a 70338 group capture observed three.
-- Model the stack as 1-3 to preserve the observed mean and allow the recorded stack.
INSERT INTO skinning_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT 2408,0,249428,2.8,0,1,0,1,3,'Snapjaw - Pristine Hide'
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty d JOIN creature c ON c.id=d.Entry
    WHERE d.Entry=2408 AND d.DifficultyID=0 AND d.SkinLootID=2408
)
AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE SkinLootID=2408 AND Entry<>2408)
AND NOT EXISTS (SELECT 1 FROM skinning_loot_template WHERE Entry=2408 AND ItemType=0 AND Item=249428);
