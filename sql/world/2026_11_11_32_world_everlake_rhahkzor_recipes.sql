-- Icy Veins Forever observed these single-item recipe drops on RhahkZor.
-- https://db.icy-veins.com/wow-forever/npcs/644
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 644, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 252774 AS Item, 0.734 AS Chance, 'Rhahk''Zor - Pattern: Totemic Leather Armor' AS Comment
    UNION ALL SELECT 251344, 0.673, 'Rhahk''Zor - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 252773, 0.612, 'Rhahk''Zor - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 253910, 0.612, 'Rhahk''Zor - Pattern: Filigreed Pearly Gown'
    UNION ALL SELECT 253902, 0.551, 'Rhahk''Zor - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 253908, 0.551, 'Rhahk''Zor - Pattern: Filigreed Shadow Gown'
    UNION ALL SELECT 252775, 0.551, 'Rhahk''Zor - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 251342, 0.551, 'Rhahk''Zor - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 253912, 0.49, 'Rhahk''Zor - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 252776, 0.49, 'Rhahk''Zor - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 251343, 0.428, 'Rhahk''Zor - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 251341, 0.367, 'Rhahk''Zor - Plans: Guard''s Chain Shirt'
    UNION ALL SELECT 251340, 0.367, 'Rhahk''Zor - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 253904, 0.245, 'Rhahk''Zor - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 252771, 0.184, 'Rhahk''Zor - Pattern: Brawler''s Leather Armor'
    UNION ALL SELECT 252772, 0.184, 'Rhahk''Zor - Pattern: Trapper''s Leather Armor'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 644 AND LootID = 644
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 644 AND LootID = 644
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 644 AND ItemType = 0 AND Item = recipes.Item
);
