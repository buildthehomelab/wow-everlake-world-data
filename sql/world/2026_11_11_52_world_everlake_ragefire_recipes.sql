-- Icy Veins Forever observed these single-item recipe drops.
-- https://db.icy-veins.com/wow-forever/npcs/11517
-- https://db.icy-veins.com/wow-forever/npcs/11518
-- https://db.icy-veins.com/wow-forever/npcs/11519
-- https://db.icy-veins.com/wow-forever/npcs/11520
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 11517 AS Entry, 253908 AS Item, 0.748 AS Chance, 'Oggleflint - Pattern: Filigreed Shadow Gown' AS Comment
    UNION ALL SELECT 11517, 252771, 0.616, 'Oggleflint - Pattern: Brawler''s Leather Armor'
    UNION ALL SELECT 11517, 252775, 0.616, 'Oggleflint - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 11517, 251344, 0.616, 'Oggleflint - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 11517, 253912, 0.572, 'Oggleflint - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 11517, 252772, 0.572, 'Oggleflint - Pattern: Trapper''s Leather Armor'
    UNION ALL SELECT 11517, 252773, 0.528, 'Oggleflint - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 11517, 253906, 0.528, 'Oggleflint - Pattern: Filigreed Flame Gown'
    UNION ALL SELECT 11517, 253904, 0.484, 'Oggleflint - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 11517, 251343, 0.484, 'Oggleflint - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 11517, 251341, 0.484, 'Oggleflint - Plans: Guard''s Chain Shirt'
    UNION ALL SELECT 11517, 253910, 0.44, 'Oggleflint - Pattern: Filigreed Pearly Gown'
    UNION ALL SELECT 11517, 252776, 0.396, 'Oggleflint - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 11517, 252774, 0.352, 'Oggleflint - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 11517, 251342, 0.352, 'Oggleflint - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 11517, 251340, 0.352, 'Oggleflint - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 11517, 253902, 0.308, 'Oggleflint - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 11518, 253908, 0.747, 'Jergosh the Invoker - Pattern: Filigreed Shadow Gown'
    UNION ALL SELECT 11518, 252772, 0.747, 'Jergosh the Invoker - Pattern: Trapper''s Leather Armor'
    UNION ALL SELECT 11518, 252773, 0.7, 'Jergosh the Invoker - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 11518, 251342, 0.7, 'Jergosh the Invoker - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 11518, 253902, 0.654, 'Jergosh the Invoker - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 11518, 253912, 0.654, 'Jergosh the Invoker - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 11518, 252771, 0.607, 'Jergosh the Invoker - Pattern: Brawler''s Leather Armor'
    UNION ALL SELECT 11518, 251340, 0.607, 'Jergosh the Invoker - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 11518, 253906, 0.514, 'Jergosh the Invoker - Pattern: Filigreed Flame Gown'
    UNION ALL SELECT 11518, 251343, 0.467, 'Jergosh the Invoker - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 11518, 251344, 0.467, 'Jergosh the Invoker - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 11518, 253910, 0.42, 'Jergosh the Invoker - Pattern: Filigreed Pearly Gown'
    UNION ALL SELECT 11518, 251341, 0.42, 'Jergosh the Invoker - Plans: Guard''s Chain Shirt'
    UNION ALL SELECT 11518, 252774, 0.373, 'Jergosh the Invoker - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 11518, 253904, 0.327, 'Jergosh the Invoker - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 11518, 252775, 0.327, 'Jergosh the Invoker - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 11518, 252776, 0.28, 'Jergosh the Invoker - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 11519, 252774, 0.628, 'Bazzalan - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 11519, 252776, 0.586, 'Bazzalan - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 11519, 251344, 0.586, 'Bazzalan - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 11519, 253904, 0.503, 'Bazzalan - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 11519, 252775, 0.503, 'Bazzalan - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 11519, 252773, 0.461, 'Bazzalan - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 11519, 253912, 0.461, 'Bazzalan - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 11519, 252772, 0.461, 'Bazzalan - Pattern: Trapper''s Leather Armor'
    UNION ALL SELECT 11519, 251343, 0.461, 'Bazzalan - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 11519, 251341, 0.461, 'Bazzalan - Plans: Guard''s Chain Shirt'
    UNION ALL SELECT 11519, 251340, 0.419, 'Bazzalan - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 11519, 252771, 0.377, 'Bazzalan - Pattern: Brawler''s Leather Armor'
    UNION ALL SELECT 11519, 253902, 0.335, 'Bazzalan - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 11519, 251342, 0.335, 'Bazzalan - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 11519, 253906, 0.251, 'Bazzalan - Pattern: Filigreed Flame Gown'
    UNION ALL SELECT 11520, 253910, 0.695, 'Taragaman the Hungerer - Pattern: Filigreed Pearly Gown'
    UNION ALL SELECT 11520, 252771, 0.658, 'Taragaman the Hungerer - Pattern: Brawler''s Leather Armor'
    UNION ALL SELECT 11520, 252775, 0.585, 'Taragaman the Hungerer - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 11520, 251343, 0.585, 'Taragaman the Hungerer - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 11520, 253906, 0.548, 'Taragaman the Hungerer - Pattern: Filigreed Flame Gown'
    UNION ALL SELECT 11520, 252774, 0.512, 'Taragaman the Hungerer - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 11520, 252772, 0.475, 'Taragaman the Hungerer - Pattern: Trapper''s Leather Armor'
    UNION ALL SELECT 11520, 252773, 0.439, 'Taragaman the Hungerer - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 11520, 253904, 0.439, 'Taragaman the Hungerer - Pattern: Filigreed Silky Gown'
    UNION ALL SELECT 11520, 252776, 0.439, 'Taragaman the Hungerer - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 11520, 251341, 0.439, 'Taragaman the Hungerer - Plans: Guard''s Chain Shirt'
    UNION ALL SELECT 11520, 251342, 0.366, 'Taragaman the Hungerer - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 11520, 251340, 0.366, 'Taragaman the Hungerer - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 11520, 253908, 0.329, 'Taragaman the Hungerer - Pattern: Filigreed Shadow Gown'
    UNION ALL SELECT 11520, 253902, 0.293, 'Taragaman the Hungerer - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 11520, 253912, 0.293, 'Taragaman the Hungerer - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 11520, 251344, 0.219, 'Taragaman the Hungerer - Plans: Crusader''s Chain Shirt'
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
