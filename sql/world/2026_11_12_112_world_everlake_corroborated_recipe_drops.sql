-- Everloot identifies the source pairs. Rates use Icy Veins addon_drops fractions converted to percent.
INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT src.npc,0,src.item,src.chance,0,1,0,1,1,src.provenance
FROM (
    SELECT 3653 AS npc,6391 AS item,0.038 AS chance,'Kresh: Pattern: Stylish Green Shirt (Icy Veins; Everloot)' AS provenance
    UNION ALL SELECT 255964,2409,0.026,'Fallen Necromancer: Pattern: Dark Leather Tunic (Icy Veins; Everloot)'
) AS src
JOIN creature_template_difficulty d ON d.Entry=src.npc AND d.DifficultyID=0 AND d.LootID=src.npc
WHERE EXISTS (SELECT 1 FROM creature WHERE id=src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=src.npc AND Entry<>src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=src.npc AND ItemType=0 AND Item=src.item);
