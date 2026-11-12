-- Icy Veins Forever NPC addon_drops. Fractions converted to percentages.
-- https://db.icy-veins.com/api/catalog/wowf/npc/{2271,3637,3887,5761,12902}
-- ForeverDungeonJournal 2.0.2 also lists both Lorgus Jett patterns.
CREATE TEMPORARY TABLE everlake_crafting_drop_stage LIKE creature_loot_template;

START TRANSACTION;

INSERT INTO everlake_crafting_drop_stage
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
WITH RECURSIVE drops(npc, item, chance, provenance) AS (
    SELECT 2271, 3866, 0.027, 'Dalaran Shield Guard - Jade Serpentblade (Icy Veins)'
    UNION ALL SELECT 3637, 3611, 0.017, 'Deviate Guardian - Green Iron Boots (Icy Veins)'
    UNION ALL SELECT 3887, 7364, 0.134, 'Baron Silverlaine - Heavy Earthen Gloves (Icy Veins)'
    UNION ALL SELECT 5761, 4297, 0.008, 'Deviate Shambler - Barbaric Gloves (Icy Veins)'
    UNION ALL SELECT 12902, 253978, 0.227, 'Lorgus Jett - Filigreed Silky Circlet (Icy Veins, ForeverDungeonJournal)'
    UNION ALL SELECT 12902, 253982, 0.340, 'Lorgus Jett - Filigreed Shadow Circlet (Icy Veins, ForeverDungeonJournal)'
), refs(npc, reference_id) AS (
    SELECT DISTINCT d.npc, l.Item
    FROM drops d JOIN creature_loot_template l ON l.Entry = d.npc AND l.ItemType = 1
    UNION DISTINCT
    SELECT r.npc, l.Item
    FROM refs r JOIN reference_loot_template l ON l.Entry = r.reference_id AND l.ItemType = 1
)
SELECT d.npc, 0, d.item, d.chance, 0, 1, 0, 1, 1, d.provenance
FROM drops d
JOIN creature_template_difficulty t ON t.Entry = d.npc AND t.DifficultyID = 0 AND t.LootID = d.npc
WHERE EXISTS (SELECT 1 FROM creature c WHERE c.id = d.npc AND (d.npc <> 12902 OR c.map = 48))
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID = d.npc AND Entry <> d.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry = d.npc AND ItemType = 0 AND Item = d.item)
  AND NOT EXISTS (
      SELECT 1 FROM refs r JOIN reference_loot_template l ON l.Entry = r.reference_id
      WHERE r.npc = d.npc AND l.ItemType = 0 AND l.Item = d.item
  );

INSERT INTO creature_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment
FROM everlake_crafting_drop_stage;

INSERT INTO everlake_import_rows (tbl, k1, k2, k3, file, note)
SELECT 'creature_loot_template', Entry, ItemType, Item,
       '2026_11_12_150_world_everlake_corroborated_crafting_drops.sql', Comment
FROM everlake_crafting_drop_stage;

COMMIT;

DROP TEMPORARY TABLE everlake_crafting_drop_stage;
