-- Icy Veins Forever lists Arcane Mote as quest loot from Shade of the Archmage.
INSERT INTO creature_loot_template (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT d.LootID,0,251961,45,1,1,0,1,1,'Shade of the Archmage - Arcane Mote (Icy Veins Forever)'
FROM creature_template_difficulty d
WHERE d.Entry=246020 AND d.DifficultyID=0 AND d.LootID=246020
  AND EXISTS (SELECT 1 FROM creature WHERE id=d.Entry AND map=2959)
  AND EXISTS (SELECT 1 FROM quest_objectives WHERE Type=1 AND ObjectID=251961)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=d.LootID AND ItemType=0 AND Item=251961);
