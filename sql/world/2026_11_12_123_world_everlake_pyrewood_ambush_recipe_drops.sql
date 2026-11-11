-- Icy Veins item and NPC observations. Rates are addon fractions converted to percent.
INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT src.npc,0,src.item,src.chance,0,1,0,1,1,src.provenance
FROM (
    SELECT 2068 AS npc,2553 AS item,0.366 AS chance,'Lord Mayor Morrison: Recipe: Elixir of Minor Agility (Icy Veins)' AS provenance
    UNION ALL SELECT 2068,4409,0.366,'Lord Mayor Morrison: Schematic: Small Seaforium Charge (Icy Veins)'
) AS src
JOIN creature_template_difficulty d ON d.Entry=src.npc AND d.DifficultyID=0 AND d.LootID=src.npc
WHERE EXISTS (SELECT 1 FROM creature WHERE id=2058 AND map=0)
  AND EXISTS (SELECT 1 FROM smart_scripts WHERE entryorguid=2058 AND source_type=0 AND action_type=80 AND action_param1=205802)
  AND EXISTS (SELECT 1 FROM smart_scripts WHERE entryorguid=205802 AND source_type=9 AND action_type=12 AND action_param1=2068)
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=src.npc AND Entry<>src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=src.npc AND ItemType=0 AND Item=src.item);
