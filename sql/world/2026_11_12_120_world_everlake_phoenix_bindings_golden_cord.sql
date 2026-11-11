-- Icy Veins item and NPC observations. Rates are addon fractions converted to percent.
INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT src.npc,0,src.item,src.chance,0,1,0,1,1,src.provenance
FROM (
    SELECT 4663 AS npc,211247 AS item,1.149 AS chance,'Burning Blade Augur: Phoenix Bindings recipe (Icy Veins)' AS provenance
    UNION ALL SELECT 3976,254046,2.083,'Scarlet Commander Mograine: Golden Cord recipe (Icy Veins)'
    UNION ALL SELECT 6487,254046,0.376,'Arcanist Doan: Golden Cord recipe (Icy Veins)'
) AS src
JOIN creature_template_difficulty d ON d.Entry=src.npc AND d.DifficultyID=0 AND d.LootID=src.npc
WHERE EXISTS (SELECT 1 FROM creature WHERE id=src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=src.npc AND Entry<>src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=src.npc AND ItemType=0 AND Item=src.item);
