-- Icy Veins item and NPC observations. Rates are addon fractions converted to percent.
DROP TEMPORARY TABLE IF EXISTS everlake_recipe_drop_stage;
CREATE TEMPORARY TABLE everlake_recipe_drop_stage LIKE creature_loot_template;

INSERT INTO everlake_recipe_drop_stage
    (Entry,ItemType,Item,Chance,QuestRequired,LootMode,GroupId,MinCount,MaxCount,Comment)
SELECT src.npc,0,src.item,src.chance,0,1,0,1,1,src.provenance
FROM (
    SELECT 3204 AS npc,4409 AS item,0.09900 AS chance,'Gazz''uz: Schematic: Small Seaforium Charge (Icy Veins)' AS provenance
    UNION ALL SELECT 1660,2553,0.09300,'Scarlet Bodyguard: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 250626,4409,0.09100,'Skeletal Soldier: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 250654,2553,0.08600,'Ghostly Citizen: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 2449,3396,0.08600,'Citizen Wilkes: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 250654,4409,0.08600,'Ghostly Citizen: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 250623,4409,0.08500,'Mangled Cadaver: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 250625,4409,0.08300,'Broodling: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 3857,3396,0.08200,'Shadowfang Glutton: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 3252,3396,0.07900,'Silithid Swarmer: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 261368,3396,0.07800,'Kul Tiras Marine: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 1025,3396,0.07700,'Bluegill Puddlejumper: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 3123,4409,0.07400,'Bloodtalon Scythemaw: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 260432,4409,0.07400,'Shadowvale Mystic: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 2013,4409,0.07300,'Gnarlpine Avenger: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 1958,4409,0.0700,'Vile Fin Tidecaller: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 4067,3396,0.06800,'Twilight Runner: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 4275,3396,0.06700,'Archmage Arugal: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 3205,4409,0.06700,'Zalazane: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 1753,2553,0.06600,'Maggot Eye: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 11520,4409,0.06400,'Taragaman the Hungerer: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 2168,3396,0.06200,'Blackwood Warrior: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 253282,2553,0.05800,'Shriekling Fledgling: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 43,2553,0.05700,'Mine Spider: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 248464,4409,0.05700,'Nimsy: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 43,4409,0.05700,'Mine Spider: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 3750,3396,0.05600,'Foulweald Totemic: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 272096,4409,0.05500,'Befouled Webwood: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 3861,3396,0.05400,'Bleak Worg: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 1763,3396,0.05100,'Gilnid: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 250618,4409,0.05100,'Skeleton: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 255964,4409,0.05100,'Fallen Necromancer: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 263397,2553,0.0500,'Dark Iron Engineer: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 263438,4409,0.04900,'Dark Iron Summoner: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 327,2553,0.04800,'Goldtooth: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 263470,4409,0.04800,'Bloodhound Runt: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 5761,3396,0.04700,'Deviate Shambler: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 260428,2553,0.04600,'Shadowvale Lurcher: Recipe: Elixir of Minor Agility (Icy Veins)'
    UNION ALL SELECT 3636,3396,0.04600,'Deviate Ravager: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 641,3396,0.04600,'Goblin Woodcarver: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 3631,3396,0.04500,'Deviate Stinglash: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 259434,4409,0.04300,'Tarnished Drudge: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 260800,3396,0.04200,'Thicket Lurker: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 250735,4409,0.04200,'Venom Lurker: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 3671,4409,0.04200,'Lady Anacondra: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 3669,3396,0.04100,'Lord Cobrahn: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 11518,3396,0.04100,'Jergosh the Invoker: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 11518,4409,0.04100,'Jergosh the Invoker: Schematic: Small Seaforium Charge (Icy Veins)'
    UNION ALL SELECT 250624,3396,0.03900,'Skeletal Mage: Recipe: Elixir of Lesser Agility (Icy Veins)'
    UNION ALL SELECT 250630,4409,0.03900,'Plague Ghoul: Schematic: Small Seaforium Charge (Icy Veins)'
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
SELECT 'creature_loot_template',Entry,ItemType,Item,'2026_11_12_116_world_everlake_observed_recipe_routes.sql',Comment
FROM everlake_recipe_drop_stage
ON DUPLICATE KEY UPDATE file=VALUES(file),note=VALUES(note);

DROP TEMPORARY TABLE everlake_recipe_drop_stage;
