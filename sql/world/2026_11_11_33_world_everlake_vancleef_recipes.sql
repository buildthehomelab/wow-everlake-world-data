-- Icy Veins Forever observed these single-item recipe drops on VanCleef.
-- https://db.icy-veins.com/wow-forever/npcs/639
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 639, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 252794 AS Item, 0.625 AS Chance, 'VanCleef - Pattern: Defender''s Leather Pants' AS Comment
    UNION ALL SELECT 253946, 0.563, 'VanCleef - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 253940, 0.563, 'VanCleef - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 251349, 0.563, 'VanCleef - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 251346, 0.563, 'VanCleef - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 252792, 0.5, 'VanCleef - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 251347, 0.5, 'VanCleef - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 252795, 0.438, 'VanCleef - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 253942, 0.375, 'VanCleef - Pattern: Filigreed Flame Leggings'
    UNION ALL SELECT 252793, 0.375, 'VanCleef - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 251348, 0.375, 'VanCleef - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 251345, 0.375, 'VanCleef - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 253944, 0.188, 'VanCleef - Pattern: Filigreed Shadow Leggings'
    UNION ALL SELECT 252797, 0.125, 'VanCleef - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 252796, 0.063, 'VanCleef - Pattern: Stormrider''s Leather Pants'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 639 AND LootID = 639
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 639 AND LootID = 639
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 639 AND ItemType = 0 AND Item = recipes.Item
);
