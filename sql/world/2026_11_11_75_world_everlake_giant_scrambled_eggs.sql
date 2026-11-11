-- ForeverChanges records one drop in one kill. wow.gg lists the same 100% estimate.
INSERT INTO creature_loot_template (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT d.LootID,0,250186,100,0,1,0,1,1,'Lost One Cook - Recipe: Giant Scrambled Eggs'
FROM creature_template c
JOIN creature_template_difficulty d ON d.Entry=c.entry AND d.DifficultyID=0 AND d.LootID=1106
WHERE c.entry=1106 AND c.name='Lost One Cook'
  AND EXISTS (SELECT 1 FROM creature WHERE id=c.entry AND map=0)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=d.LootID AND ItemType=0 AND Item=250186);
