-- Icy Veins Forever observed these single-item recipe drops on Lady Sarevess.
-- https://db.icy-veins.com/wow-forever/npcs/4831
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 4831, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 253938 AS Item, 1.49 AS Chance, 'Lady Sarevess - Pattern: Filigreed Pristine Leggings' AS Comment
    UNION ALL SELECT 253946, 1.12, 'Lady Sarevess - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 251346, 1.12, 'Lady Sarevess - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 251345, 1.12, 'Lady Sarevess - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 252792, 0.743, 'Lady Sarevess - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 252794, 0.743, 'Lady Sarevess - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 253942, 0.743, 'Lady Sarevess - Pattern: Filigreed Flame Leggings'
    UNION ALL SELECT 253940, 0.743, 'Lady Sarevess - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 252793, 0.743, 'Lady Sarevess - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 251349, 0.743, 'Lady Sarevess - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 251347, 0.743, 'Lady Sarevess - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 252796, 0.372, 'Lady Sarevess - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 252795, 0.372, 'Lady Sarevess - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 252797, 0.372, 'Lady Sarevess - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 251348, 0.372, 'Lady Sarevess - Plans: Acolyte''s Chain Leggings'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 4831 AND LootID = 4831
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 4831 AND LootID = 4831
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 4831 AND ItemType = 0 AND Item = recipes.Item
);
