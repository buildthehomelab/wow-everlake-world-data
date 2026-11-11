-- Icy Veins Forever observed these single-item recipe drops.
-- https://db.icy-veins.com/wow-forever/npcs/1696
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 1696 AS Entry, 252793 AS Item, 1.98 AS Chance, 'Targorr - Pattern: Trapper''s Leather Pants' AS Comment
    UNION ALL SELECT 1696, 252794, 1.59, 'Targorr - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 1696, 252797, 0.794, 'Targorr - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 1696, 251349, 0.794, 'Targorr - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 1696, 251347, 0.794, 'Targorr - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 1696, 251346, 0.397, 'Targorr - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 1696, 251345, 0.397, 'Targorr - Plans: Veteran''s Chain Leggings'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = recipes.Entry AND LootID = recipes.Entry
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> recipes.Entry AND LootID = recipes.Entry
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template
    WHERE Entry = recipes.Entry AND ItemType = 0 AND Item = recipes.Item
);
