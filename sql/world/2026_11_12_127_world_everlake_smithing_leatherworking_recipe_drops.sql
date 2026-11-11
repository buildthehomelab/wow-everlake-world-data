-- Icy Veins item and NPC observations. Rates are addon fractions converted to percent.
DROP TEMPORARY TABLE IF EXISTS everlake_recipe_drop_stage;
CREATE TEMPORARY TABLE everlake_recipe_drop_stage LIKE creature_loot_template;

INSERT INTO everlake_recipe_drop_stage
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT src.npc,0,src.item,src.chance,0,1,0,1,1,src.provenance
FROM (
    SELECT 7291 AS npc,252843 AS item,5.00000 AS chance,'Galgann Firehammer: Pattern: Prowler''s Leather Shoes (Icy Veins)' AS provenance
    UNION ALL SELECT 5249,251462,2.70300,'Woodpaw Mongrel: Plans: Mithril Claymore (Icy Veins)'
    UNION ALL SELECT 3976,251400,2.08300,'Scarlet Commander Mograine: Plans: Warder''s Boots (Icy Veins)'
    UNION ALL SELECT 1907,251395,1.77800,'Naga Explorer: Plans: Shining Mithril Helm (Icy Veins)'
    UNION ALL SELECT 7357,251400,1.61300,'Mordresh Fire Eye: Plans: Warder''s Boots (Icy Veins)'
    UNION ALL SELECT 8567,252843,1.61300,'Glutton: Pattern: Prowler''s Leather Shoes (Icy Veins)'
    UNION ALL SELECT 7357,252843,1.61300,'Mordresh Fire Eye: Pattern: Prowler''s Leather Shoes (Icy Veins)'
    UNION ALL SELECT 4542,252843,0.97100,'High Inquisitor Fairbanks: Pattern: Prowler''s Leather Shoes (Icy Veins)'
    UNION ALL SELECT 7855,251397,0.87000,'Southsea Pirate: Plans: Shining Mithril Gauntlet (Icy Veins)'
    UNION ALL SELECT 3975,251398,0.52100,'Herod: Plans: Officer''s Boots (Icy Veins)'
    UNION ALL SELECT 6487,251400,0.37600,'Arcanist Doan: Plans: Warder''s Boots (Icy Veins)'
    UNION ALL SELECT 6487,252843,0.37600,'Arcanist Doan: Pattern: Prowler''s Leather Shoes (Icy Veins)'
    UNION ALL SELECT 6487,251398,0.37600,'Arcanist Doan: Plans: Officer''s Boots (Icy Veins)'
    UNION ALL SELECT 7355,251398,1.66700,'Tuten''kash: Plans: Officer''s Boots (Icy Veins)'
) AS src
JOIN creature_template_difficulty d ON d.Entry=src.npc AND d.DifficultyID=0 AND d.LootID=src.npc
WHERE (EXISTS (SELECT 1 FROM creature WHERE id=src.npc)
    OR (src.npc=7355
        AND EXISTS (SELECT 1 FROM instance_template WHERE map=129 AND script='classic_instance_razorfen_downs')
        AND EXISTS (SELECT 1 FROM gameobject WHERE id=148917 AND map=129)))
  AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=src.npc AND Entry<>src.npc)
  AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=src.npc AND ItemType=0 AND Item=src.item);
INSERT INTO creature_loot_template
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment
FROM everlake_recipe_drop_stage;

INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_loot_template',Entry,ItemType,Item,'2026_11_12_127_world_everlake_smithing_leatherworking_recipe_drops.sql',Comment
FROM everlake_recipe_drop_stage
ON DUPLICATE KEY UPDATE file=VALUES(file),note=VALUES(note);

DROP TEMPORARY TABLE everlake_recipe_drop_stage;
