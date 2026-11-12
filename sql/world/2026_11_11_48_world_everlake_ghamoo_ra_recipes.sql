-- Icy Veins Forever observed these single-item recipe drops on Ghamoo-ra.
-- https://db.icy-veins.com/wow-forever/npcs/4887
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 4887, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 251346 AS Item, 1.1 AS Chance, 'Ghamoo-ra - Plans: Guard''s Chain Leggings' AS Comment
    UNION ALL SELECT 253944, 0.73, 'Ghamoo-ra - Pattern: Filigreed Shadow Leggings'
    UNION ALL SELECT 253948, 0.73, 'Ghamoo-ra - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 252795, 0.73, 'Ghamoo-ra - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 251349, 0.73, 'Ghamoo-ra - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 252794, 0.547, 'Ghamoo-ra - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 253938, 0.547, 'Ghamoo-ra - Pattern: Filigreed Pristine Leggings'
    UNION ALL SELECT 252796, 0.547, 'Ghamoo-ra - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 252797, 0.547, 'Ghamoo-ra - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 251348, 0.547, 'Ghamoo-ra - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 251347, 0.547, 'Ghamoo-ra - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 251345, 0.547, 'Ghamoo-ra - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 252792, 0.365, 'Ghamoo-ra - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 253946, 0.182, 'Ghamoo-ra - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 252793, 0.182, 'Ghamoo-ra - Pattern: Trapper''s Leather Pants'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 4887 AND LootID = 4887
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 4887 AND LootID = 4887
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 4887 AND ItemType = 0 AND Item = recipes.Item
);
