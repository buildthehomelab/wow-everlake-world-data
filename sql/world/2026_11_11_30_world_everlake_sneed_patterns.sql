-- Icy Veins Forever observed these single-item recipe drops on Sneed.
-- https://db.icy-veins.com/wow-forever/npcs/643
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 643, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 253910 AS Item, 0.87 AS Chance, 'Sneed - Pattern: Filigreed Pearly Gown' AS Comment
    UNION ALL SELECT 253904, 0.87, 'Sneed - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 253908, 0.435, 'Sneed - Pattern: Filigreed Shadow Gown'
    UNION ALL SELECT 253912, 0.435, 'Sneed - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 252774, 0.435, 'Sneed - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 252772, 0.435, 'Sneed - Pattern: Trapper''s Leather Armor'
    UNION ALL SELECT 252776, 0.435, 'Sneed - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 251342, 0.435, 'Sneed - Plans: Protector''s Chain Shirt'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 643 AND LootID = 643
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 643 AND LootID = 643
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 643 AND ItemType = 0 AND Item = recipes.Item
);
