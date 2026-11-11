-- Icy Veins item and NPC observations. Rates are addon fractions converted to percent.
INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT src.npc,0,src.item,src.chance,0,1,0,1,1,src.provenance
FROM (
    SELECT 3435 AS npc,3396 AS item,0.18500 AS chance,'Lok Orcbane: Recipe: Elixir of Lesser Agility (Icy Veins)' AS provenance
    UNION ALL SELECT 1896,4409,0.14700,'Moonrage Elder: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 248474,2553,0.13800,'Geosculptor Yip: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 248278,4409,0.13600,'Croaky: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 3864,3396,0.13500,'Fel Steed: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 473,4409,0.12700,'Morgan the Collector: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 263466,2553,0.12200,'Lesser Stone Golem: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 276009,2553,0.12200,'Avala: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 255534,2553,0.10900,'Badwind Bennic: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 260801,3396,0.10600,'Thicket Hunter: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 3944,3396,0.10500,'Wrathtail Priestess: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 256040,4409,0.10300,'Deep Widow: Schematic: Small Seaforium Charge (Icy Veins)'
) AS src
JOIN creature_template_difficulty d ON d.Entry=src.npc AND d.DifficultyID=0 AND d.LootID=src.npc
WHERE EXISTS (SELECT 1 FROM creature WHERE id=src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=src.npc AND Entry<>src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=src.npc AND ItemType=0 AND Item=src.item);
