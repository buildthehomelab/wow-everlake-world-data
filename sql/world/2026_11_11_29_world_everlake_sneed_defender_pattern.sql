-- Icy Veins Forever observed this pattern on Sneed at 1.3%, average stack one.
-- https://db.icy-veins.com/wow-forever/npcs/643
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 643, 0, 252773, 1.3, 0, 1, 0, 1, 1, 'Sneed - Pattern: Defender''s Leather Armor'
WHERE EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry = 643 AND LootID = 643
)
AND NOT EXISTS (
    SELECT 1 FROM creature_template_difficulty WHERE Entry <> 643 AND LootID = 643
)
AND NOT EXISTS (
    SELECT 1 FROM creature_loot_template WHERE Entry = 643 AND ItemType = 0 AND Item = 252773
);
