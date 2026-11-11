-- Icy Veins Forever observed these single-item recipe drops on Sneed's Shredder.
-- https://db.icy-veins.com/wow-forever/npcs/642
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 642, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 10316 AS Item, 0.12 AS Chance, 'Shredder - Pattern: Colorful Kilt' AS Comment
    UNION ALL SELECT 4348, 0.12, 'Shredder - Pattern: Phoenix Gloves'
    UNION ALL SELECT 6391, 0.12, 'Shredder - Pattern: Stylish Green Shirt'
    UNION ALL SELECT 4292, 0.06, 'Shredder - Pattern: Green Woolen Bag'
    UNION ALL SELECT 4350, 0.06, 'Shredder - Pattern: Spider Silk Slippers'
    UNION ALL SELECT 3611, 0.06, 'Shredder - Plans: Green Iron Boots'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 642 AND LootID = 642
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 642 AND LootID = 642
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 642 AND ItemType = 0 AND Item = recipes.Item
);
