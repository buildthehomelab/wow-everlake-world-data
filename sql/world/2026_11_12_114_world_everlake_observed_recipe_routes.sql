-- Icy Veins item and NPC observations. Rates are addon fractions converted to percent.
DROP TEMPORARY TABLE IF EXISTS everlake_recipe_drop_stage;
CREATE TEMPORARY TABLE everlake_recipe_drop_stage LIKE creature_loot_template;

INSERT INTO everlake_recipe_drop_stage
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT src.npc,0,src.item,src.chance,0,1,0,1,1,src.provenance
FROM (
    SELECT 79 AS npc,2553 AS item,1.01 AS chance,'Narg the Taskmaster: Recipe: Elixir of Minor Agility (Icy Veins)' AS provenance
    UNION ALL SELECT 4512,3396,0.465,'Rotting Agam''ar: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 250619,4409,0.265,'Broodwidow: Schematic: Small Seaforium Charge (Icy Veins)'
) AS src
JOIN creature_template_difficulty d ON d.Entry=src.npc AND d.DifficultyID=0 AND d.LootID=src.npc
WHERE EXISTS (SELECT 1 FROM creature WHERE id=src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=src.npc AND Entry<>src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=src.npc AND ItemType=0 AND Item=src.item);

INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment
FROM everlake_recipe_drop_stage;

INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_loot_template',Entry,ItemType,Item,'2026_11_12_114_world_everlake_observed_recipe_routes.sql',Comment
FROM everlake_recipe_drop_stage
ON DUPLICATE KEY UPDATE file=VALUES(file),note=VALUES(note);

DROP TEMPORARY TABLE everlake_recipe_drop_stage;
