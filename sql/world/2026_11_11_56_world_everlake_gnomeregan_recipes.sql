-- Icy Veins Forever observed these single-item recipe drops.
-- https://db.icy-veins.com/wow-forever/npcs/6229
-- https://db.icy-veins.com/wow-forever/npcs/6235
-- https://db.icy-veins.com/wow-forever/npcs/7079
-- https://db.icy-veins.com/wow-forever/npcs/7800
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 6229 AS Entry, 252815 AS Item, 2.33 AS Chance, 'Crowd Pummeler 9-60 - Pattern: Trapper''s Leather Helm' AS Comment
    UNION ALL SELECT 6229, 251354, 2.33, 'Crowd Pummeler 9-60 - Plans: Crusader''s Chain Helm'
    UNION ALL SELECT 6229, 251352, 2.33, 'Crowd Pummeler 9-60 - Plans: Protector''s Chain Helm'
    UNION ALL SELECT 6235, 253986, 6.25, 'Electrocutioner 6000 - Pattern: Filigreed Shining Circlet'
    UNION ALL SELECT 6235, 251354, 4.17, 'Electrocutioner 6000 - Plans: Crusader''s Chain Helm'
    UNION ALL SELECT 6235, 251350, 4.17, 'Electrocutioner 6000 - Plans: Veteran''s Chain Helm'
    UNION ALL SELECT 6235, 252816, 2.08, 'Electrocutioner 6000 - Pattern: Defender''s Leather Helm'
    UNION ALL SELECT 6235, 253982, 2.08, 'Electrocutioner 6000 - Pattern: Filigreed Shadow Circlet'
    UNION ALL SELECT 6235, 252815, 2.08, 'Electrocutioner 6000 - Pattern: Trapper''s Leather Helm'
    UNION ALL SELECT 7079, 252814, 2.27, 'Viscous Fallout - Pattern: Brawler''s Leather Helm'
    UNION ALL SELECT 7079, 253980, 2.27, 'Viscous Fallout - Pattern: Filigreed Flame Circlet'
    UNION ALL SELECT 7079, 253982, 2.27, 'Viscous Fallout - Pattern: Filigreed Shadow Circlet'
    UNION ALL SELECT 7079, 253978, 2.27, 'Viscous Fallout - Pattern: Filigreed Silky Circlet'
    UNION ALL SELECT 7079, 252818, 2.27, 'Viscous Fallout - Pattern: Stormrider''s Leather Helm'
    UNION ALL SELECT 7079, 252817, 2.27, 'Viscous Fallout - Pattern: Totemic Leather Helm'
    UNION ALL SELECT 7800, 251351, 4.35, 'Mekgineer Thermaplugg - Plans: Guard''s Chain Helm'
    UNION ALL SELECT 7800, 253978, 2.17, 'Mekgineer Thermaplugg - Pattern: Filigreed Silky Circlet'
    UNION ALL SELECT 7800, 251350, 2.17, 'Mekgineer Thermaplugg - Plans: Veteran''s Chain Helm'
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
