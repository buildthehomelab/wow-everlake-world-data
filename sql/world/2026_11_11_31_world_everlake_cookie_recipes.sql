-- Icy Veins Forever observed these single-item recipe drops on Cookie.
-- https://db.icy-veins.com/wow-forever/npcs/645
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 645, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 252772 AS Item, 0.779 AS Chance, 'Cookie - Pattern: Trapper''s Leather Armor' AS Comment
    UNION ALL SELECT 253906, 0.701, 'Cookie - Pattern: Filigreed Flame Gown'
    UNION ALL SELECT 253902, 0.623, 'Cookie - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 252774, 0.545, 'Cookie - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 251344, 0.545, 'Cookie - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 251341, 0.545, 'Cookie - Plans: Guard''s Chain Shirt'
    UNION ALL SELECT 251342, 0.545, 'Cookie - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 251340, 0.545, 'Cookie - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 252771, 0.389, 'Cookie - Pattern: Brawler''s Leather Armor'
    UNION ALL SELECT 252773, 0.389, 'Cookie - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 253908, 0.389, 'Cookie - Pattern: Filigreed Shadow Gown'
    UNION ALL SELECT 253904, 0.389, 'Cookie - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 252775, 0.234, 'Cookie - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 252776, 0.234, 'Cookie - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 251343, 0.156, 'Cookie - Plans: Acolyte''s Chain Shirt'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 645 AND LootID = 645
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 645 AND LootID = 645
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 645 AND ItemType = 0 AND Item = recipes.Item
);
