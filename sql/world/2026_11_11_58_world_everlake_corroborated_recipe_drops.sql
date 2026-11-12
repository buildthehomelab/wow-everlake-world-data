-- Efficient Games capture 9fcae73cc7 confirms both drops. Observed rates from Icy Veins Forever.
-- https://db.icy-veins.com/wow-forever/npcs/3864
-- https://db.icy-veins.com/wow-forever/npcs/3875
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 3864 AS Entry, 252775 AS Item, 0.951 AS Chance, 'Fel Steed - Pattern: Stormrider''s Leather Armor' AS Comment
    UNION ALL SELECT 3875, 4352, 0.027, 'Haunted Servitor - Pattern: Boots of the Enchanter'
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
