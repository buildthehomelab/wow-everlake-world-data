-- Icy Veins Forever observed these single-item recipe drops on Lord Cobrahn.
-- https://db.icy-veins.com/wow-forever/npcs/3669
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 3669, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 253904 AS Item, 0.875 AS Chance, 'Lord Cobrahn - Pattern: Filigreed Silky Gown' AS Comment
    UNION ALL SELECT 252773, 0.721, 'Lord Cobrahn - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 252774, 0.721, 'Lord Cobrahn - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 253908, 0.618, 'Lord Cobrahn - Pattern: Filigreed Shadow Gown'
    UNION ALL SELECT 251344, 0.618, 'Lord Cobrahn - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 251341, 0.618, 'Lord Cobrahn - Plans: Guard''s Chain Shirt'
    UNION ALL SELECT 252775, 0.566, 'Lord Cobrahn - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 252772, 0.515, 'Lord Cobrahn - Pattern: Trapper''s Leather Armor'
    UNION ALL SELECT 251343, 0.515, 'Lord Cobrahn - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 251340, 0.463, 'Lord Cobrahn - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 253906, 0.412, 'Lord Cobrahn - Pattern: Filigreed Flame Gown'
    UNION ALL SELECT 251342, 0.412, 'Lord Cobrahn - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 253902, 0.36, 'Lord Cobrahn - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 253912, 0.36, 'Lord Cobrahn - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 252771, 0.257, 'Lord Cobrahn - Pattern: Brawler''s Leather Armor'
    UNION ALL SELECT 253910, 0.257, 'Lord Cobrahn - Pattern: Filigreed Pearly Gown'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 3669 AND LootID = 3669
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 3669 AND LootID = 3669
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 3669 AND ItemType = 0 AND Item = recipes.Item
);
