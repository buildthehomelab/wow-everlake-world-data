-- Icy Veins Forever observed these single-item recipe drops.
-- https://db.icy-veins.com/wow-forever/npcs/1663
-- https://db.icy-veins.com/wow-forever/npcs/1666
-- https://db.icy-veins.com/wow-forever/npcs/1716
-- https://db.icy-veins.com/wow-forever/npcs/1717
-- https://db.icy-veins.com/wow-forever/npcs/1720
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 1663 AS Entry, 252817 AS Item, 0.795 AS Chance, 'Dextren Ward - Pattern: Totemic Leather Helm' AS Comment
    UNION ALL SELECT 1663, 252814, 0.636, 'Dextren Ward - Pattern: Brawler''s Leather Helm'
    UNION ALL SELECT 1663, 252816, 0.636, 'Dextren Ward - Pattern: Defender''s Leather Helm'
    UNION ALL SELECT 1663, 253980, 0.636, 'Dextren Ward - Pattern: Filigreed Flame Circlet'
    UNION ALL SELECT 1663, 253978, 0.636, 'Dextren Ward - Pattern: Filigreed Silky Circlet'
    UNION ALL SELECT 1663, 252818, 0.636, 'Dextren Ward - Pattern: Stormrider''s Leather Helm'
    UNION ALL SELECT 1663, 251353, 0.636, 'Dextren Ward - Plans: Acolyte''s Chain Helm'
    UNION ALL SELECT 1663, 253984, 0.477, 'Dextren Ward - Pattern: Filigreed Pearly Circlet'
    UNION ALL SELECT 1663, 253976, 0.477, 'Dextren Ward - Pattern: Filigreed Pristine Circlet'
    UNION ALL SELECT 1663, 251352, 0.159, 'Dextren Ward - Plans: Protector''s Chain Helm'
    UNION ALL SELECT 1663, 251350, 0.159, 'Dextren Ward - Plans: Veteran''s Chain Helm'
    UNION ALL SELECT 1666, 251354, 1.02, 'Kam Deepfury - Plans: Crusader''s Chain Helm'
    UNION ALL SELECT 1666, 252814, 0.761, 'Kam Deepfury - Pattern: Brawler''s Leather Helm'
    UNION ALL SELECT 1666, 252818, 0.761, 'Kam Deepfury - Pattern: Stormrider''s Leather Helm'
    UNION ALL SELECT 1666, 251352, 0.761, 'Kam Deepfury - Plans: Protector''s Chain Helm'
    UNION ALL SELECT 1666, 251350, 0.761, 'Kam Deepfury - Plans: Veteran''s Chain Helm'
    UNION ALL SELECT 1666, 253986, 0.508, 'Kam Deepfury - Pattern: Filigreed Shining Circlet'
    UNION ALL SELECT 1666, 253978, 0.508, 'Kam Deepfury - Pattern: Filigreed Silky Circlet'
    UNION ALL SELECT 1666, 252817, 0.508, 'Kam Deepfury - Pattern: Totemic Leather Helm'
    UNION ALL SELECT 1666, 252819, 0.508, 'Kam Deepfury - Pattern: Wisdom''s Leather Helm'
    UNION ALL SELECT 1666, 251353, 0.508, 'Kam Deepfury - Plans: Acolyte''s Chain Helm'
    UNION ALL SELECT 1666, 251351, 0.508, 'Kam Deepfury - Plans: Guard''s Chain Helm'
    UNION ALL SELECT 1666, 252816, 0.254, 'Kam Deepfury - Pattern: Defender''s Leather Helm'
    UNION ALL SELECT 1666, 253984, 0.254, 'Kam Deepfury - Pattern: Filigreed Pearly Circlet'
    UNION ALL SELECT 1666, 253982, 0.254, 'Kam Deepfury - Pattern: Filigreed Shadow Circlet'
    UNION ALL SELECT 1716, 252815, 1.15, 'Bazil Thredd - Pattern: Trapper''s Leather Helm'
    UNION ALL SELECT 1716, 253984, 0.985, 'Bazil Thredd - Pattern: Filigreed Pearly Circlet'
    UNION ALL SELECT 1716, 251353, 0.985, 'Bazil Thredd - Plans: Acolyte''s Chain Helm'
    UNION ALL SELECT 1716, 252816, 0.657, 'Bazil Thredd - Pattern: Defender''s Leather Helm'
    UNION ALL SELECT 1716, 252818, 0.657, 'Bazil Thredd - Pattern: Stormrider''s Leather Helm'
    UNION ALL SELECT 1716, 252817, 0.657, 'Bazil Thredd - Pattern: Totemic Leather Helm'
    UNION ALL SELECT 1716, 251354, 0.657, 'Bazil Thredd - Plans: Crusader''s Chain Helm'
    UNION ALL SELECT 1716, 251350, 0.657, 'Bazil Thredd - Plans: Veteran''s Chain Helm'
    UNION ALL SELECT 1716, 253978, 0.493, 'Bazil Thredd - Pattern: Filigreed Silky Circlet'
    UNION ALL SELECT 1716, 252814, 0.328, 'Bazil Thredd - Pattern: Brawler''s Leather Helm'
    UNION ALL SELECT 1716, 253980, 0.328, 'Bazil Thredd - Pattern: Filigreed Flame Circlet'
    UNION ALL SELECT 1716, 253982, 0.328, 'Bazil Thredd - Pattern: Filigreed Shadow Circlet'
    UNION ALL SELECT 1716, 252819, 0.328, 'Bazil Thredd - Pattern: Wisdom''s Leather Helm'
    UNION ALL SELECT 1716, 251351, 0.328, 'Bazil Thredd - Plans: Guard''s Chain Helm'
    UNION ALL SELECT 1716, 251352, 0.328, 'Bazil Thredd - Plans: Protector''s Chain Helm'
    UNION ALL SELECT 1716, 253986, 0.164, 'Bazil Thredd - Pattern: Filigreed Shining Circlet'
    UNION ALL SELECT 1717, 252819, 1.16, 'Hamhock - Pattern: Wisdom''s Leather Helm'
    UNION ALL SELECT 1717, 253978, 0.969, 'Hamhock - Pattern: Filigreed Silky Circlet'
    UNION ALL SELECT 1717, 251354, 0.969, 'Hamhock - Plans: Crusader''s Chain Helm'
    UNION ALL SELECT 1717, 253982, 0.775, 'Hamhock - Pattern: Filigreed Shadow Circlet'
    UNION ALL SELECT 1717, 252818, 0.775, 'Hamhock - Pattern: Stormrider''s Leather Helm'
    UNION ALL SELECT 1717, 252814, 0.581, 'Hamhock - Pattern: Brawler''s Leather Helm'
    UNION ALL SELECT 1717, 253986, 0.581, 'Hamhock - Pattern: Filigreed Shining Circlet'
    UNION ALL SELECT 1717, 251351, 0.581, 'Hamhock - Plans: Guard''s Chain Helm'
    UNION ALL SELECT 1717, 251350, 0.581, 'Hamhock - Plans: Veteran''s Chain Helm'
    UNION ALL SELECT 1717, 253980, 0.388, 'Hamhock - Pattern: Filigreed Flame Circlet'
    UNION ALL SELECT 1717, 253976, 0.388, 'Hamhock - Pattern: Filigreed Pristine Circlet'
    UNION ALL SELECT 1717, 252817, 0.388, 'Hamhock - Pattern: Totemic Leather Helm'
    UNION ALL SELECT 1717, 252815, 0.388, 'Hamhock - Pattern: Trapper''s Leather Helm'
    UNION ALL SELECT 1717, 251353, 0.388, 'Hamhock - Plans: Acolyte''s Chain Helm'
    UNION ALL SELECT 1717, 251352, 0.388, 'Hamhock - Plans: Protector''s Chain Helm'
    UNION ALL SELECT 1717, 252816, 0.194, 'Hamhock - Pattern: Defender''s Leather Helm'
    UNION ALL SELECT 1720, 253984, 2.94, 'Bruegal Ironknuckle - Pattern: Filigreed Pearly Circlet'
    UNION ALL SELECT 1720, 251353, 2.94, 'Bruegal Ironknuckle - Plans: Acolyte''s Chain Helm'
    UNION ALL SELECT 1720, 253980, 1.47, 'Bruegal Ironknuckle - Pattern: Filigreed Flame Circlet'
    UNION ALL SELECT 1720, 253978, 1.47, 'Bruegal Ironknuckle - Pattern: Filigreed Silky Circlet'
    UNION ALL SELECT 1720, 251354, 1.47, 'Bruegal Ironknuckle - Plans: Crusader''s Chain Helm'
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
