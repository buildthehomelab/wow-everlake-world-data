-- ForeverDungeonJournal 2.0.2 and Icy Veins agree on these Lorgus Jett drops.
-- https://db.icy-veins.com/api/catalog/wowf/npc/12902
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT 12902, 0, drops.item, drops.chance, 0, 1, 0, 1, 1, drops.comment
FROM (
    SELECT 253978 AS item, 0.227 AS chance, 'Lorgus Jett - Pattern: Filigreed Silky Circlet' AS comment
    UNION ALL SELECT 253982, 0.340, 'Lorgus Jett - Pattern: Filigreed Shadow Circlet'
) drops
WHERE EXISTS (SELECT 1 FROM creature WHERE id=12902 AND map=48)
  AND EXISTS (SELECT 1 FROM creature_template_difficulty WHERE Entry=12902 AND DifficultyID=0 AND LootID=12902)
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE Entry<>12902 AND LootID=12902)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template l WHERE l.Entry=12902 AND l.ItemType=0 AND l.Item=drops.item);
