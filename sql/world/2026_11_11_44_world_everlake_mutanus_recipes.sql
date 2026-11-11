-- Icy Veins Forever observed these single-item recipe drops on Mutanus.
-- https://db.icy-veins.com/wow-forever/npcs/3654
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 3654, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 253944 AS Item, 0.819 AS Chance, 'Mutanus - Pattern: Filigreed Shadow Leggings' AS Comment
    UNION ALL SELECT 252793, 0.75, 'Mutanus - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 252794, 0.614, 'Mutanus - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 253938, 0.614, 'Mutanus - Pattern: Filigreed Pristine Leggings'
    UNION ALL SELECT 252795, 0.614, 'Mutanus - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 251345, 0.614, 'Mutanus - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 253942, 0.546, 'Mutanus - Pattern: Filigreed Flame Leggings'
    UNION ALL SELECT 252796, 0.546, 'Mutanus - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 252792, 0.477, 'Mutanus - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 253946, 0.477, 'Mutanus - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 253940, 0.477, 'Mutanus - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 253948, 0.409, 'Mutanus - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 251348, 0.409, 'Mutanus - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 251346, 0.409, 'Mutanus - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 251349, 0.341, 'Mutanus - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 251347, 0.341, 'Mutanus - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 252797, 0.136, 'Mutanus - Pattern: Wisdom''s Leather Pants'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 3654 AND LootID = 3654
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 3654 AND LootID = 3654
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 3654 AND ItemType = 0 AND Item = recipes.Item
);
