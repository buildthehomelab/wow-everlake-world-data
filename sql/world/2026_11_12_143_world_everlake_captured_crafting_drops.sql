-- Player loot captures corroborated by Icy Veins Forever NPC addon_drops.
-- Icy Veins reports fractions; the world loot table uses percentages.
INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
WITH RECURSIVE drops(npc, item, chance, label) AS (
    SELECT 2271, 3866, 0.027, 'Dalaran Shield Guard - Plans: Jade Serpentblade'
    UNION ALL SELECT 3637, 3611, 0.017, 'Deviate Guardian - Plans: Green Iron Boots'
    UNION ALL SELECT 3887, 7364, 0.134, 'Baron Silverlaine - Pattern: Heavy Earthen Gloves'
    UNION ALL SELECT 5761, 4297, 0.008, 'Deviate Shambler - Pattern: Barbaric Gloves'
), refs(npc, reference_id) AS (
    SELECT d.npc, l.Item FROM drops d JOIN creature_loot_template l ON l.Entry = d.npc AND l.ItemType = 1
    UNION DISTINCT
    SELECT r.npc, l.Item FROM refs r JOIN reference_loot_template l ON l.Entry = r.reference_id AND l.ItemType = 1
)
SELECT d.npc, 0, d.item, d.chance, 0, 1, 0, 1, 1, d.label
FROM drops d
JOIN creature_template_difficulty t ON t.Entry = d.npc AND t.DifficultyID = 0 AND t.LootID = d.npc
WHERE EXISTS (SELECT 1 FROM creature WHERE id = d.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID = d.npc AND Entry <> d.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry = d.npc AND ItemType = 0 AND Item = d.item)
  AND NOT EXISTS (
      SELECT 1 FROM refs r JOIN reference_loot_template l ON l.Entry = r.reference_id
      WHERE r.npc = d.npc AND l.ItemType = 0 AND l.Item = d.item
  );
