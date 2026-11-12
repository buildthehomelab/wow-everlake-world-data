-- Icy Veins Forever observed these single-item recipe drops on Lord Pythas.
-- https://db.icy-veins.com/wow-forever/npcs/3670
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 3670, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 252793 AS Item, 0.68 AS Chance, 'Lord Pythas - Pattern: Trapper''s Leather Pants' AS Comment
    UNION ALL SELECT 251346, 0.623, 'Lord Pythas - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 251345, 0.623, 'Lord Pythas - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 251347, 0.567, 'Lord Pythas - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 253946, 0.51, 'Lord Pythas - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 252796, 0.51, 'Lord Pythas - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 253948, 0.453, 'Lord Pythas - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 251348, 0.397, 'Lord Pythas - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 252794, 0.34, 'Lord Pythas - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 251349, 0.34, 'Lord Pythas - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 252797, 0.227, 'Lord Pythas - Pattern: Wisdom''s Leather Pants'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 3670 AND LootID = 3670
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 3670 AND LootID = 3670
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 3670 AND ItemType = 0 AND Item = recipes.Item
);
