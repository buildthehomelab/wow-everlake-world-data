-- Warcraft Wiki identifies the Captain drop. The Forever Leatherworking guide lists a provisional 1.2%.
INSERT INTO creature_loot_template (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT d.LootID,0,227903,1.2,0,1,0,1,1,'Anvilrage Captain - Hardened Black Dragonscale Leggings pattern'
FROM creature_template t
JOIN creature_template_difficulty d ON d.Entry=t.entry AND d.DifficultyID=0 AND d.LootID=8903
WHERE t.entry=8903 AND t.name='Anvilrage Captain'
  AND EXISTS (SELECT 1 FROM creature WHERE id=t.entry AND map=230)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=d.LootID AND ItemType=0 AND Item=227903);
