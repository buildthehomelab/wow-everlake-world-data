-- Icy Veins item and NPC observations. Rates are addon fractions converted to percent.
INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT src.npc,0,src.item,src.chance,0,1,0,1,1,src.provenance
FROM (
    SELECT 5762 AS npc,3396 AS item,0.048 AS chance,'Deviate Moccasin: Recipe: Elixir of Lesser Agility (Icy Veins)' AS provenance
    UNION ALL SELECT 3654,3396,0.043,'Mutanus the Devourer: Recipe: Elixir of Lesser Agility (Icy Veins)'
) AS src
JOIN creature_template_difficulty d ON d.Entry=src.npc AND d.DifficultyID=0 AND d.LootID=src.npc
WHERE EXISTS (SELECT 1 FROM creature WHERE id=3678 AND map=43)
  AND EXISTS (SELECT 1 FROM creature_template WHERE entry=3678 AND ScriptName='classic_npc_disciple_of_naralex')
  AND EXISTS (SELECT 1 FROM instance_template WHERE map=43 AND script='classic_instance_wailing_caverns')
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=src.npc AND Entry<>src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=src.npc AND ItemType=0 AND Item=src.item);
