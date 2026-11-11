-- My Forever Recipe Book 0.18.1-beta reports 2 drops in 19420 Doan loot records.
-- https://www.curseforge.com/wow/addons/my-forever-recipe-book/files/9488332
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 6487, 0, 252847, 0.0103, 0, 1, 0, 1, 1, 'Arcanist Doan - Pattern: Mender''s Leather Shoes'
WHERE EXISTS (SELECT 1 FROM creature_template_difficulty WHERE Entry=6487 AND LootID=6487)
AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE Entry<>6487 AND LootID=6487)
AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=6487 AND ItemType=0 AND Item=252847);
