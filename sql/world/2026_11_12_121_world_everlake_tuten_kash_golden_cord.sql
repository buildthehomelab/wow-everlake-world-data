-- The Razorfen Downs gong event summons Tuten'kash (7355).
DROP TEMPORARY TABLE IF EXISTS everlake_recipe_drop_stage;
CREATE TEMPORARY TABLE everlake_recipe_drop_stage LIKE creature_loot_template;

INSERT INTO everlake_recipe_drop_stage
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT 7355,0,254046,1.667,0,1,0,1,1,'Tuten''kash: Golden Cord recipe (Icy Veins)'
WHERE EXISTS (SELECT 1 FROM instance_template WHERE map=129 AND script='classic_instance_razorfen_downs')
  AND EXISTS (SELECT 1 FROM gameobject WHERE id=148917 AND map=129)
  AND EXISTS (SELECT 1 FROM creature_template_difficulty WHERE Entry=7355 AND DifficultyID=0 AND LootID=7355)
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=7355 AND Entry<>7355)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=7355 AND ItemType=0 AND Item=254046);

INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment
FROM everlake_recipe_drop_stage;

INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_loot_template',Entry,ItemType,Item,'2026_11_12_121_world_everlake_tuten_kash_golden_cord.sql',Comment
FROM everlake_recipe_drop_stage
ON DUPLICATE KEY UPDATE file=VALUES(file),note=VALUES(note);

DROP TEMPORARY TABLE everlake_recipe_drop_stage;
