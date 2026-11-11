-- Color spells are display transforms. The placed creature uses loot ID 3640.
DROP TEMPORARY TABLE IF EXISTS everlake_recipe_drop_stage;
CREATE TEMPORARY TABLE everlake_recipe_drop_stage LIKE creature_loot_template;

INSERT INTO everlake_recipe_drop_stage
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT 3640,0,3396,0.018,0,1,0,1,1,'Evolving Ectoplasm: Recipe: Elixir of Lesser Agility (Icy Veins)'
WHERE EXISTS (SELECT 1 FROM creature_template_difficulty WHERE Entry=3640 AND DifficultyID=0 AND LootID=3640)
  AND NOT EXISTS (SELECT 1 FROM creature WHERE id IN (5776,5777,5778))
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=3640 AND Entry NOT IN (3640,5776,5777,5778))
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=3640 AND ItemType=0 AND Item=3396);

INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment
FROM everlake_recipe_drop_stage;

INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_loot_template',Entry,ItemType,Item,'2026_11_12_118_world_everlake_ectoplasm_recipe.sql',Comment
FROM everlake_recipe_drop_stage
ON DUPLICATE KEY UPDATE file=VALUES(file),note=VALUES(note);

DROP TEMPORARY TABLE everlake_recipe_drop_stage;
