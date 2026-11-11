-- Icy Veins Forever observed these single-item recipe drops.
-- https://db.icy-veins.com/wow-forever/npcs/4420
-- https://db.icy-veins.com/wow-forever/npcs/4421
-- https://db.icy-veins.com/wow-forever/npcs/4422
-- https://db.icy-veins.com/wow-forever/npcs/4424
-- https://db.icy-veins.com/wow-forever/npcs/4428
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT recipes.Entry, 0, recipes.Item, recipes.Chance, 0, 1, 0, 1, 1, recipes.Comment
FROM (
    SELECT 4420 AS Entry, 252814 AS Item, 2.38 AS Chance, 'Overlord Ramtusk - Pattern: Brawler''s Leather Helm' AS Comment
    UNION ALL SELECT 4420, 251353, 2.38, 'Overlord Ramtusk - Plans: Acolyte''s Chain Helm'
    UNION ALL SELECT 4421, 252816, 1, 'Charlga Razorflank - Pattern: Defender''s Leather Helm'
    UNION ALL SELECT 4421, 252815, 1, 'Charlga Razorflank - Pattern: Trapper''s Leather Helm'
    UNION ALL SELECT 4421, 251353, 1, 'Charlga Razorflank - Plans: Acolyte''s Chain Helm'
    UNION ALL SELECT 4421, 251352, 1, 'Charlga Razorflank - Plans: Protector''s Chain Helm'
    UNION ALL SELECT 4421, 251350, 1, 'Charlga Razorflank - Plans: Veteran''s Chain Helm'
    UNION ALL SELECT 4422, 253986, 2.27, 'Agathelos the Raging - Pattern: Filigreed Shining Circlet'
    UNION ALL SELECT 4424, 252814, 2.56, 'Aggem Thorncurse - Pattern: Brawler''s Leather Helm'
    UNION ALL SELECT 4424, 252816, 2.56, 'Aggem Thorncurse - Pattern: Defender''s Leather Helm'
    UNION ALL SELECT 4424, 252815, 2.56, 'Aggem Thorncurse - Pattern: Trapper''s Leather Helm'
    UNION ALL SELECT 4424, 251350, 2.56, 'Aggem Thorncurse - Plans: Veteran''s Chain Helm'
    UNION ALL SELECT 4428, 252814, 4.88, 'Death Speaker Jargba - Pattern: Brawler''s Leather Helm'
    UNION ALL SELECT 4428, 253976, 2.44, 'Death Speaker Jargba - Pattern: Filigreed Pristine Circlet'
    UNION ALL SELECT 4428, 251351, 2.44, 'Death Speaker Jargba - Plans: Guard''s Chain Helm'
    UNION ALL SELECT 4428, 251352, 2.44, 'Death Speaker Jargba - Plans: Protector''s Chain Helm'
    UNION ALL SELECT 4428, 251350, 2.44, 'Death Speaker Jargba - Plans: Veteran''s Chain Helm'
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
