-- Icy Veins Forever observed these single-item recipe drops on Verdan.
-- https://db.icy-veins.com/wow-forever/npcs/5775
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 5775, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 253944 AS Item, 0.727 AS Chance, 'Verdan - Pattern: Filigreed Shadow Leggings' AS Comment
    UNION ALL SELECT 253948, 0.727, 'Verdan - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 251345, 0.671, 'Verdan - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 252792, 0.503, 'Verdan - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 253940, 0.503, 'Verdan - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 251349, 0.503, 'Verdan - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 252793, 0.447, 'Verdan - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 253938, 0.391, 'Verdan - Pattern: Filigreed Pristine Leggings'
    UNION ALL SELECT 252795, 0.391, 'Verdan - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 251348, 0.391, 'Verdan - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 251346, 0.391, 'Verdan - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 251347, 0.391, 'Verdan - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 252796, 0.335, 'Verdan - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 253942, 0.168, 'Verdan - Pattern: Filigreed Flame Leggings'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 5775 AND LootID = 5775
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 5775 AND LootID = 5775
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 5775 AND ItemType = 0 AND Item = recipes.Item
);
