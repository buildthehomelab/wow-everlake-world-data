-- Icy Veins Forever observed these single-item recipe drops on Deviate Faerie Dragon.
-- https://db.icy-veins.com/wow-forever/npcs/5912
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 5912, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 252774 AS Item, 1.77 AS Chance, 'Deviate Faerie Dragon - Pattern: Totemic Leather Armor' AS Comment
    UNION ALL SELECT 252773, 0.885, 'Deviate Faerie Dragon - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 253904, 0.885, 'Deviate Faerie Dragon - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 251343, 0.885, 'Deviate Faerie Dragon - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 251342, 0.885, 'Deviate Faerie Dragon - Plans: Protector''s Chain Shirt'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 5912 AND LootID = 5912
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 5912 AND LootID = 5912
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 5912 AND ItemType = 0 AND Item = recipes.Item
);
