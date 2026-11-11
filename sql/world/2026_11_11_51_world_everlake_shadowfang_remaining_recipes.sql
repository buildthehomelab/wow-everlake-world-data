-- Icy Veins Forever observed these single-item recipe drops.
-- https://db.icy-veins.com/wow-forever/npcs/3914
-- https://db.icy-veins.com/wow-forever/npcs/4274
-- https://db.icy-veins.com/wow-forever/npcs/4275
-- https://db.icy-veins.com/wow-forever/npcs/4278
-- https://db.icy-veins.com/wow-forever/npcs/3872
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 3872 AS Entry, 251349 AS Item, 1.43 AS Chance, 'Deathsworn Captain - Plans: Crusader''s Chain Leggings' AS Comment
    UNION ALL SELECT 3872, 253940, 0.952, 'Deathsworn Captain - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 3872, 252795, 0.952, 'Deathsworn Captain - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 3872, 251348, 0.952, 'Deathsworn Captain - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 3872, 252794, 0.476, 'Deathsworn Captain - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 3872, 253938, 0.476, 'Deathsworn Captain - Pattern: Filigreed Pristine Leggings'
    UNION ALL SELECT 3872, 253944, 0.476, 'Deathsworn Captain - Pattern: Filigreed Shadow Leggings'
    UNION ALL SELECT 3872, 252793, 0.476, 'Deathsworn Captain - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 3872, 252797, 0.476, 'Deathsworn Captain - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 3914, 252776, 1.55, 'Rethilgore - Pattern: Wisdom''s Leather Armor'
    UNION ALL SELECT 3914, 252774, 1.29, 'Rethilgore - Pattern: Totemic Leather Armor'
    UNION ALL SELECT 3914, 251341, 1.29, 'Rethilgore - Plans: Guard''s Chain Shirt'
    UNION ALL SELECT 3914, 251344, 1.03, 'Rethilgore - Plans: Crusader''s Chain Shirt'
    UNION ALL SELECT 3914, 253912, 0.775, 'Rethilgore - Pattern: Filigreed Shining Gown'
    UNION ALL SELECT 3914, 252773, 0.517, 'Rethilgore - Pattern: Defender''s Leather Armor'
    UNION ALL SELECT 3914, 253906, 0.517, 'Rethilgore - Pattern: Filigreed Flame Gown'
    UNION ALL SELECT 3914, 252775, 0.517, 'Rethilgore - Pattern: Stormrider''s Leather Armor'
    UNION ALL SELECT 3914, 251340, 0.517, 'Rethilgore - Plans: Veteran''s Chain Shirt'
    UNION ALL SELECT 3914, 252771, 0.258, 'Rethilgore - Pattern: Brawler''s Leather Armor'
    UNION ALL SELECT 3914, 253910, 0.258, 'Rethilgore - Pattern: Filigreed Pearly Gown'
    UNION ALL SELECT 3914, 253902, 0.258, 'Rethilgore - Pattern: Filigreed Pristine Gown'
    UNION ALL SELECT 3914, 253908, 0.258, 'Rethilgore - Pattern: Filigreed Shadow Gown'
    UNION ALL SELECT 3914, 252772, 0.258, 'Rethilgore - Pattern: Trapper''s Leather Armor'
    UNION ALL SELECT 3914, 251343, 0.258, 'Rethilgore - Plans: Acolyte''s Chain Shirt'
    UNION ALL SELECT 3914, 251342, 0.258, 'Rethilgore - Plans: Protector''s Chain Shirt'
    UNION ALL SELECT 4274, 253946, 0.962, 'Fenrus the Devourer - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 4274, 253940, 0.962, 'Fenrus the Devourer - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 4274, 252792, 0.721, 'Fenrus the Devourer - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 4274, 252796, 0.721, 'Fenrus the Devourer - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 4274, 252793, 0.721, 'Fenrus the Devourer - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 4274, 251346, 0.721, 'Fenrus the Devourer - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 4274, 251347, 0.721, 'Fenrus the Devourer - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 4274, 253942, 0.481, 'Fenrus the Devourer - Pattern: Filigreed Flame Leggings'
    UNION ALL SELECT 4274, 253944, 0.481, 'Fenrus the Devourer - Pattern: Filigreed Shadow Leggings'
    UNION ALL SELECT 4274, 253948, 0.481, 'Fenrus the Devourer - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 4274, 251345, 0.481, 'Fenrus the Devourer - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 4274, 252794, 0.24, 'Fenrus the Devourer - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 4274, 252795, 0.24, 'Fenrus the Devourer - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 4274, 252797, 0.24, 'Fenrus the Devourer - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 4274, 251348, 0.24, 'Fenrus the Devourer - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 4274, 251349, 0.24, 'Fenrus the Devourer - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 4275, 253948, 0.824, 'Archmage Arugal - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 4275, 251345, 0.824, 'Archmage Arugal - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 4275, 252796, 0.641, 'Archmage Arugal - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 4275, 252795, 0.641, 'Archmage Arugal - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 4275, 252797, 0.641, 'Archmage Arugal - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 4275, 251349, 0.641, 'Archmage Arugal - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 4275, 253942, 0.458, 'Archmage Arugal - Pattern: Filigreed Flame Leggings'
    UNION ALL SELECT 4275, 253946, 0.458, 'Archmage Arugal - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 4275, 251347, 0.458, 'Archmage Arugal - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 4275, 253944, 0.366, 'Archmage Arugal - Pattern: Filigreed Shadow Leggings'
    UNION ALL SELECT 4275, 252792, 0.275, 'Archmage Arugal - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 4275, 253940, 0.275, 'Archmage Arugal - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 4275, 252793, 0.275, 'Archmage Arugal - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 4275, 251346, 0.275, 'Archmage Arugal - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 4275, 252794, 0.183, 'Archmage Arugal - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 4275, 253938, 0.092, 'Archmage Arugal - Pattern: Filigreed Pristine Leggings'
    UNION ALL SELECT 4275, 251348, 0.092, 'Archmage Arugal - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 4278, 251345, 1.1, 'Commander Springvale - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 4278, 253940, 0.883, 'Commander Springvale - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 4278, 253946, 0.662, 'Commander Springvale - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 4278, 253944, 0.662, 'Commander Springvale - Pattern: Filigreed Shadow Leggings'
    UNION ALL SELECT 4278, 253948, 0.662, 'Commander Springvale - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 4278, 252792, 0.442, 'Commander Springvale - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 4278, 253942, 0.442, 'Commander Springvale - Pattern: Filigreed Flame Leggings'
    UNION ALL SELECT 4278, 252796, 0.442, 'Commander Springvale - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 4278, 251348, 0.442, 'Commander Springvale - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 4278, 252794, 0.221, 'Commander Springvale - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 4278, 253938, 0.221, 'Commander Springvale - Pattern: Filigreed Pristine Leggings'
    UNION ALL SELECT 4278, 252795, 0.221, 'Commander Springvale - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 4278, 252793, 0.221, 'Commander Springvale - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 4278, 252797, 0.221, 'Commander Springvale - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 4278, 251349, 0.221, 'Commander Springvale - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 4278, 251346, 0.221, 'Commander Springvale - Plans: Guard''s Chain Leggings'
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
