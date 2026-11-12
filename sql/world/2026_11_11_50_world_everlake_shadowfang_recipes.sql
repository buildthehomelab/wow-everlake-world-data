-- Icy Veins Forever observed these single-item recipe drops.
-- https://db.icy-veins.com/wow-forever/npcs/3886
-- https://db.icy-veins.com/wow-forever/npcs/3887
-- https://db.icy-veins.com/wow-forever/npcs/4279
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 3886 AS Entry, 252796 AS Item, 1.18 AS Chance, 'Razorclaw the Butcher - Pattern: Stormrider''s Leather Pants' AS Comment
    UNION ALL SELECT 3886, 252793, 1.18, 'Razorclaw the Butcher - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 3886, 253942, 0.941, 'Razorclaw the Butcher - Pattern: Filigreed Flame Leggings'
    UNION ALL SELECT 3886, 253946, 0.941, 'Razorclaw the Butcher - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 3886, 253948, 0.941, 'Razorclaw the Butcher - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 3886, 252795, 0.941, 'Razorclaw the Butcher - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 3886, 251345, 0.941, 'Razorclaw the Butcher - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 3886, 252792, 0.706, 'Razorclaw the Butcher - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 3886, 253940, 0.471, 'Razorclaw the Butcher - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 3886, 251348, 0.471, 'Razorclaw the Butcher - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 3886, 251346, 0.471, 'Razorclaw the Butcher - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 3886, 251347, 0.471, 'Razorclaw the Butcher - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 3886, 252794, 0.235, 'Razorclaw the Butcher - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 3886, 253938, 0.235, 'Razorclaw the Butcher - Pattern: Filigreed Pristine Leggings'
    UNION ALL SELECT 3886, 252797, 0.235, 'Razorclaw the Butcher - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 3886, 251349, 0.235, 'Razorclaw the Butcher - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 3887, 252796, 0.907, 'Baron Silverlaine - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 3887, 251347, 0.907, 'Baron Silverlaine - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 3887, 253948, 0.68, 'Baron Silverlaine - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 3887, 252795, 0.68, 'Baron Silverlaine - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 3887, 252797, 0.68, 'Baron Silverlaine - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 3887, 251346, 0.68, 'Baron Silverlaine - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 3887, 252794, 0.454, 'Baron Silverlaine - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 3887, 253944, 0.454, 'Baron Silverlaine - Pattern: Filigreed Shadow Leggings'
    UNION ALL SELECT 3887, 251349, 0.454, 'Baron Silverlaine - Plans: Crusader''s Chain Leggings'
    UNION ALL SELECT 3887, 253942, 0.227, 'Baron Silverlaine - Pattern: Filigreed Flame Leggings'
    UNION ALL SELECT 3887, 253946, 0.227, 'Baron Silverlaine - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 3887, 252793, 0.227, 'Baron Silverlaine - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 3887, 251345, 0.227, 'Baron Silverlaine - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 4279, 252793, 1.16, 'Odo the Blindwatcher - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 4279, 252792, 0.698, 'Odo the Blindwatcher - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 4279, 252796, 0.698, 'Odo the Blindwatcher - Pattern: Stormrider''s Leather Pants'
    UNION ALL SELECT 4279, 252797, 0.698, 'Odo the Blindwatcher - Pattern: Wisdom''s Leather Pants'
    UNION ALL SELECT 4279, 251346, 0.698, 'Odo the Blindwatcher - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 4279, 251345, 0.698, 'Odo the Blindwatcher - Plans: Veteran''s Chain Leggings'
    UNION ALL SELECT 4279, 252794, 0.465, 'Odo the Blindwatcher - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 4279, 253946, 0.465, 'Odo the Blindwatcher - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 4279, 253938, 0.465, 'Odo the Blindwatcher - Pattern: Filigreed Pristine Leggings'
    UNION ALL SELECT 4279, 253944, 0.465, 'Odo the Blindwatcher - Pattern: Filigreed Shadow Leggings'
    UNION ALL SELECT 4279, 251347, 0.465, 'Odo the Blindwatcher - Plans: Protector''s Chain Leggings'
    UNION ALL SELECT 4279, 253942, 0.233, 'Odo the Blindwatcher - Pattern: Filigreed Flame Leggings'
    UNION ALL SELECT 4279, 253948, 0.233, 'Odo the Blindwatcher - Pattern: Filigreed Shining Leggings'
    UNION ALL SELECT 4279, 252795, 0.233, 'Odo the Blindwatcher - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 4279, 251348, 0.233, 'Odo the Blindwatcher - Plans: Acolyte''s Chain Leggings'
    UNION ALL SELECT 4279, 251349, 0.233, 'Odo the Blindwatcher - Plans: Crusader''s Chain Leggings'
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
