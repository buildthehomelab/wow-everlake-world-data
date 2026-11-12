-- Icy Veins Forever observed these single-item recipe drops on Lady Anacondra.
-- https://db.icy-veins.com/wow-forever/npcs/3671
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 3671, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 252774 AS Item, 0.666 AS Chance, 'Lady Anacondra - Pattern: Totemic Leather Armor' AS Comment
    UNION ALL SELECT 251343, 0.615, 'Lady Anacondra - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 252775, 0.564, 'Lady Anacondra - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 253910, 0.513, 'Lady Anacondra - Pattern: Filigreed Pearly Gown'
    UNION ALL SELECT 252776, 0.513, 'Lady Anacondra - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 252773, 0.461, 'Lady Anacondra - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 253908, 0.41, 'Lady Anacondra - Pattern: Filigreed Shadow Gown'
    UNION ALL SELECT 252772, 0.41, 'Lady Anacondra - Pattern: Trapper''s Leather Armor'
    UNION ALL SELECT 252771, 0.359, 'Lady Anacondra - Pattern: Brawler''s Leather Armor'
    UNION ALL SELECT 253902, 0.359, 'Lady Anacondra - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 251342, 0.359, 'Lady Anacondra - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 253912, 0.308, 'Lady Anacondra - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 251344, 0.308, 'Lady Anacondra - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 251341, 0.205, 'Lady Anacondra - Plans: Guard''s Chain Shirt'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 3671 AND LootID = 3671
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 3671 AND LootID = 3671
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 3671 AND ItemType = 0 AND Item = recipes.Item
);
