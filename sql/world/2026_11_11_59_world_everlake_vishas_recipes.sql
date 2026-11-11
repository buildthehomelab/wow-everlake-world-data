-- Icy Veins Forever observed these single-item recipe drops.
-- https://db.icy-veins.com/wow-forever/npcs/3983
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 3983 AS Entry, 253980 AS Item, 1.39 AS Chance, 'Interrogator Vishas - Pattern: Filigreed Flame Circlet' AS Comment
    UNION ALL SELECT 3983, 252815, 1.39, 'Interrogator Vishas - Pattern: Trapper''s Leather Helm'
    UNION ALL SELECT 3983, 252814, 0.694, 'Interrogator Vishas - Pattern: Brawler''s Leather Helm'
    UNION ALL SELECT 3983, 253984, 0.694, 'Interrogator Vishas - Pattern: Filigreed Pearly Circlet'
    UNION ALL SELECT 3983, 252817, 0.694, 'Interrogator Vishas - Pattern: Totemic Leather Helm'
    UNION ALL SELECT 3983, 251353, 0.694, 'Interrogator Vishas - Plans: Acolyte''s Chain Helm'
    UNION ALL SELECT 3983, 251350, 0.694, 'Interrogator Vishas - Plans: Veteran''s Chain Helm'
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
