-- Icy Veins item and NPC observations. Rates are addon fractions converted to percent.
INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT src.npc,0,src.item,src.chance,0,1,0,1,1,src.provenance
FROM (
    SELECT 79 AS npc,2553 AS item,1.01 AS chance,'Narg the Taskmaster: Recipe: Elixir of Minor Agility (Icy Veins)' AS provenance
    UNION ALL SELECT 4512,3396,0.465,'Rotting Agam''ar: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 250619,4409,0.265,'Broodwidow: Schematic: Small Seaforium Charge (Icy Veins)'
) AS src
JOIN creature_template_difficulty d ON d.Entry=src.npc AND d.DifficultyID=0 AND d.LootID=src.npc
WHERE EXISTS (SELECT 1 FROM creature WHERE id=src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=src.npc AND Entry<>src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=src.npc AND ItemType=0 AND Item=src.item);
