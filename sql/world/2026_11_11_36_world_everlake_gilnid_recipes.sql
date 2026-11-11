-- Icy Veins Forever observed these single-item recipe drops on Gilnid.
-- https://db.icy-veins.com/wow-forever/npcs/1763
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 1763, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 253908 AS Item, 0.759 AS Chance, 'Gilnid - Pattern: Filigreed Shadow Gown' AS Comment
    UNION ALL SELECT 251344, 0.759, 'Gilnid - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 253910, 0.696, 'Gilnid - Pattern: Filigreed Pearly Gown'
    UNION ALL SELECT 251342, 0.696, 'Gilnid - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 252775, 0.633, 'Gilnid - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 252776, 0.57, 'Gilnid - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 252772, 0.506, 'Gilnid - Pattern: Trapper''s Leather Armor'
    UNION ALL SELECT 253902, 0.443, 'Gilnid - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 253912, 0.443, 'Gilnid - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 251341, 0.443, 'Gilnid - Plans: Guard''s Chain Shirt'
    UNION ALL SELECT 251340, 0.443, 'Gilnid - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 252771, 0.38, 'Gilnid - Pattern: Brawler''s Leather Armor'
    UNION ALL SELECT 252773, 0.38, 'Gilnid - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 252774, 0.38, 'Gilnid - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 251343, 0.063, 'Gilnid - Plans: Acolyte''s Chain Shirt'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 1763 AND LootID = 1763
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 1763 AND LootID = 1763
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 1763 AND ItemType = 0 AND Item = recipes.Item
);
