-- Icy Veins Forever observed single-item recipe drops on these bosses.
-- https://db.icy-veins.com/wow-forever/npcs/4829
-- https://db.icy-veins.com/wow-forever/npcs/4830
-- https://db.icy-veins.com/wow-forever/npcs/4832
-- https://db.icy-veins.com/wow-forever/npcs/6243
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 4829 AS Entry, 251351 AS Item, 1.23 AS Chance, 'Aku''mai - Plans: Guard''s Chain Helm' AS Comment
    UNION ALL SELECT 4829, 252816, 0.821, 'Aku''mai - Pattern: Defender''s Leather Helm'
    UNION ALL SELECT 4829, 251354, 0.821, 'Aku''mai - Plans: Crusader''s Chain Helm'
    UNION ALL SELECT 4829, 253976, 0.547, 'Aku''mai - Pattern: Filigreed Pristine Circlet'
    UNION ALL SELECT 4829, 253982, 0.547, 'Aku''mai - Pattern: Filigreed Shadow Circlet'
    UNION ALL SELECT 4829, 253978, 0.41, 'Aku''mai - Pattern: Filigreed Silky Circlet'
    UNION ALL SELECT 4829, 252818, 0.41, 'Aku''mai - Pattern: Stormrider''s Leather Helm'
    UNION ALL SELECT 4829, 252814, 0.137, 'Aku''mai - Pattern: Brawler''s Leather Helm'
    UNION ALL SELECT 4829, 252819, 0.137, 'Aku''mai - Pattern: Wisdom''s Leather Helm'
    UNION ALL SELECT 4830, 253976, 0.831, 'Old Serra''kis - Pattern: Filigreed Pristine Circlet'
    UNION ALL SELECT 4830, 252818, 0.831, 'Old Serra''kis - Pattern: Stormrider''s Leather Helm'
    UNION ALL SELECT 4830, 251351, 0.831, 'Old Serra''kis - Plans: Guard''s Chain Helm'
    UNION ALL SELECT 4830, 253986, 0.664, 'Old Serra''kis - Pattern: Filigreed Shining Circlet'
    UNION ALL SELECT 4830, 252819, 0.664, 'Old Serra''kis - Pattern: Wisdom''s Leather Helm'
    UNION ALL SELECT 4830, 251354, 0.498, 'Old Serra''kis - Plans: Crusader''s Chain Helm'
    UNION ALL SELECT 4830, 253980, 0.332, 'Old Serra''kis - Pattern: Filigreed Flame Circlet'
    UNION ALL SELECT 4830, 253984, 0.332, 'Old Serra''kis - Pattern: Filigreed Pearly Circlet'
    UNION ALL SELECT 4832, 252818, 1.73, 'Twilight Lord Kelris - Pattern: Stormrider''s Leather Helm'
    UNION ALL SELECT 4832, 252817, 1.04, 'Twilight Lord Kelris - Pattern: Totemic Leather Helm'
    UNION ALL SELECT 4832, 252816, 0.692, 'Twilight Lord Kelris - Pattern: Defender''s Leather Helm'
    UNION ALL SELECT 4832, 253984, 0.346, 'Twilight Lord Kelris - Pattern: Filigreed Pearly Circlet'
    UNION ALL SELECT 4832, 252823, 0.346, 'Twilight Lord Kelris - Pattern: Totemic Leather Leggings'
    UNION ALL SELECT 4832, 252815, 0.346, 'Twilight Lord Kelris - Pattern: Trapper''s Leather Helm'
    UNION ALL SELECT 4832, 251353, 0.346, 'Twilight Lord Kelris - Plans: Acolyte''s Chain Helm'
    UNION ALL SELECT 4832, 251354, 0.346, 'Twilight Lord Kelris - Plans: Crusader''s Chain Helm'
    UNION ALL SELECT 6243, 252814, 0.769, 'Gelihast - Pattern: Brawler''s Leather Helm'
    UNION ALL SELECT 6243, 253984, 0.769, 'Gelihast - Pattern: Filigreed Pearly Circlet'
    UNION ALL SELECT 6243, 251351, 0.769, 'Gelihast - Plans: Guard''s Chain Helm'
    UNION ALL SELECT 6243, 253986, 0.385, 'Gelihast - Pattern: Filigreed Shining Circlet'
    UNION ALL SELECT 6243, 252819, 0.385, 'Gelihast - Pattern: Wisdom''s Leather Helm'
    UNION ALL SELECT 6243, 251354, 0.385, 'Gelihast - Plans: Crusader''s Chain Helm'
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
