-- Icy Veins Forever observed these single-item recipe drops on Kresh.
-- https://db.icy-veins.com/wow-forever/npcs/3653
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 3653, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 253906 AS Item, 0.461 AS Chance, 'Kresh - Pattern: Filigreed Flame Gown' AS Comment
    UNION ALL SELECT 252776, 0.461, 'Kresh - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 251340, 0.461, 'Kresh - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 253904, 0.369, 'Kresh - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 251341, 0.277, 'Kresh - Plans: Guard''s Chain Shirt'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 3653 AND LootID = 3653
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 3653 AND LootID = 3653
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 3653 AND ItemType = 0 AND Item = recipes.Item
);
