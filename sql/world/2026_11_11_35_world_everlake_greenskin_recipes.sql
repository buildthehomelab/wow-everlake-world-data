-- Icy Veins Forever observed these single-item recipe drops on Captain Greenskin.
-- https://db.icy-veins.com/wow-forever/npcs/647
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 647, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 252771 AS Item, 0.867 AS Chance, 'Captain Greenskin - Pattern: Brawler''s Leather Armor' AS Comment
    UNION ALL SELECT 253908, 0.867, 'Captain Greenskin - Pattern: Filigreed Shadow Gown'
    UNION ALL SELECT 253902, 0.795, 'Captain Greenskin - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 252773, 0.723, 'Captain Greenskin - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 251343, 0.723, 'Captain Greenskin - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 252775, 0.65, 'Captain Greenskin - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 253910, 0.578, 'Captain Greenskin - Pattern: Filigreed Pearly Gown'
    UNION ALL SELECT 251342, 0.578, 'Captain Greenskin - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 252774, 0.506, 'Captain Greenskin - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 251344, 0.506, 'Captain Greenskin - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 253906, 0.434, 'Captain Greenskin - Pattern: Filigreed Flame Gown'
    UNION ALL SELECT 253904, 0.434, 'Captain Greenskin - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 253912, 0.361, 'Captain Greenskin - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 251341, 0.361, 'Captain Greenskin - Plans: Guard''s Chain Shirt'
    UNION ALL SELECT 251340, 0.361, 'Captain Greenskin - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 252776, 0.289, 'Captain Greenskin - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 252772, 0.145, 'Captain Greenskin - Pattern: Trapper''s Leather Armor'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 647 AND LootID = 647
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 647 AND LootID = 647
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 647 AND ItemType = 0 AND Item = recipes.Item
);
