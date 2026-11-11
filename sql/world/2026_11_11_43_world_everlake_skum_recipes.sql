-- Icy Veins Forever observed these single-item recipe drops on Skum.
-- https://db.icy-veins.com/wow-forever/npcs/3674
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 3674, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 252792 AS Item, 1.2 AS Chance, 'Skum - Pattern: Brawler''s Leather Pants' AS Comment
    UNION ALL SELECT 251347, 0.7, 'Skum - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 253938, 0.6, 'Skum - Pattern: Filigreed Pristine Leggings'
    UNION ALL SELECT 253940, 0.6, 'Skum - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 252796, 0.6, 'Skum - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 253946, 0.5, 'Skum - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 252797, 0.5, 'Skum - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 253944, 0.4, 'Skum - Pattern: Filigreed Shadow Leggings'
    UNION ALL SELECT 251349, 0.4, 'Skum - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 253948, 0.3, 'Skum - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 252795, 0.3, 'Skum - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 251348, 0.3, 'Skum - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 251345, 0.3, 'Skum - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 253942, 0.2, 'Skum - Pattern: Filigreed Flame Leggings'
    UNION ALL SELECT 252794, 0.1, 'Skum - Pattern: Defender''s Leather Pants'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 3674 AND LootID = 3674
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 3674 AND LootID = 3674
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 3674 AND ItemType = 0 AND Item = recipes.Item
);
