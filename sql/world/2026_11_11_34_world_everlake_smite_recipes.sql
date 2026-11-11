-- Icy Veins Forever observed these single-item recipe drops on Mr. Smite.
-- https://db.icy-veins.com/wow-forever/npcs/646
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 646, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 252771 AS Item, 0.965 AS Chance, 'Mr. Smite - Pattern: Brawler''s Leather Armor' AS Comment
    UNION ALL SELECT 252773, 0.707, 'Mr. Smite - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 252774, 0.707, 'Mr. Smite - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 251342, 0.707, 'Mr. Smite - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 253906, 0.643, 'Mr. Smite - Pattern: Filigreed Flame Gown'
    UNION ALL SELECT 253912, 0.643, 'Mr. Smite - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 253904, 0.643, 'Mr. Smite - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 251340, 0.579, 'Mr. Smite - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 253908, 0.514, 'Mr. Smite - Pattern: Filigreed Shadow Gown'
    UNION ALL SELECT 253902, 0.45, 'Mr. Smite - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 252772, 0.45, 'Mr. Smite - Pattern: Trapper''s Leather Armor'
    UNION ALL SELECT 252775, 0.386, 'Mr. Smite - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 251344, 0.386, 'Mr. Smite - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 253910, 0.322, 'Mr. Smite - Pattern: Filigreed Pearly Gown'
    UNION ALL SELECT 252776, 0.322, 'Mr. Smite - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 251343, 0.322, 'Mr. Smite - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 251362, 0.064, 'Mr. Smite - Plans: Protector''s Gloves'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 646 AND LootID = 646
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 646 AND LootID = 646
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 646 AND ItemType = 0 AND Item = recipes.Item
);
