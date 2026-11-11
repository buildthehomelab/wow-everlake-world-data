-- Icy Veins Forever observed these single-item recipe drops on Lord Serpentis.
-- https://db.icy-veins.com/wow-forever/npcs/3673
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 3673, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 253942 AS Item, 0.715 AS Chance, 'Lord Serpentis - Pattern: Filigreed Flame Leggings' AS Comment
    UNION ALL SELECT 253940, 0.715, 'Lord Serpentis - Pattern: Filigreed Silky Leggings'
    UNION ALL SELECT 252794, 0.656, 'Lord Serpentis - Pattern: Defender''s Leather Pants'
    UNION ALL SELECT 252795, 0.596, 'Lord Serpentis - Pattern: Totemic Leather Pants'
    UNION ALL SELECT 252792, 0.536, 'Lord Serpentis - Pattern: Brawler''s Leather Pants'
    UNION ALL SELECT 253944, 0.536, 'Lord Serpentis - Pattern: Filigreed Shadow Leggings'
    UNION ALL SELECT 252793, 0.417, 'Lord Serpentis - Pattern: Trapper''s Leather Pants'
    UNION ALL SELECT 251346, 0.358, 'Lord Serpentis - Plans: Guard''s Chain Leggings'
    UNION ALL SELECT 253938, 0.298, 'Lord Serpentis - Pattern: Filigreed Pristine Leggings'
    UNION ALL SELECT 253946, 0.238, 'Lord Serpentis - Pattern: Filigreed Pearly Leggings'
    UNION ALL SELECT 252797, 0.238, 'Lord Serpentis - Pattern: Wisdom''s Leather Pants'
) AS recipes
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 3673 AND LootID = 3673
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 3673 AND LootID = 3673
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 3673 AND ItemType = 0 AND Item = recipes.Item
);
