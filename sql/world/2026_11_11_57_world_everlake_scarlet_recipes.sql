-- Icy Veins Forever observed these single-item recipe drops.
-- https://db.icy-veins.com/wow-forever/npcs/3974
-- https://db.icy-veins.com/wow-forever/npcs/3975
-- https://db.icy-veins.com/wow-forever/npcs/6487
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 3974 AS Entry, 252816 AS Item, 1.55 AS Chance, 'Houndmaster Loksey - Pattern: Defender''s Leather Helm' AS Comment
    UNION ALL SELECT 3974, 253976, 1.55, 'Houndmaster Loksey - Pattern: Filigreed Pristine Circlet'
    UNION ALL SELECT 3974, 252819, 1.55, 'Houndmaster Loksey - Pattern: Wisdom''s Leather Helm'
    UNION ALL SELECT 3974, 251352, 1.55, 'Houndmaster Loksey - Plans: Protector''s Chain Helm'
    UNION ALL SELECT 3974, 253986, 0.775, 'Houndmaster Loksey - Pattern: Filigreed Shining Circlet'
    UNION ALL SELECT 3974, 252815, 0.775, 'Houndmaster Loksey - Pattern: Trapper''s Leather Helm'
    UNION ALL SELECT 3974, 251354, 0.775, 'Houndmaster Loksey - Plans: Crusader''s Chain Helm'
    UNION ALL SELECT 3974, 251350, 0.775, 'Houndmaster Loksey - Plans: Veteran''s Chain Helm'
    UNION ALL SELECT 3975, 254044, 1.45, 'Herod - Pattern: Black Cord'
    UNION ALL SELECT 3975, 252897, 1.45, 'Herod - Pattern: Skycaller''s Mail Boots'
    UNION ALL SELECT 3975, 252896, 1.45, 'Herod - Pattern: Stalker''s Mail Boots'
    UNION ALL SELECT 3975, 252845, 1.45, 'Herod - Pattern: Warden''s Leather Shoes'
    UNION ALL SELECT 6487, 252845, 2.5, 'Arcanist Doan - Pattern: Warden''s Leather Shoes'
    UNION ALL SELECT 6487, 252898, 0.833, 'Arcanist Doan - Pattern: Skirmisher''s Mail Boots'
    UNION ALL SELECT 6487, 251401, 0.833, 'Arcanist Doan - Plans: Prefect''s Boots'
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
