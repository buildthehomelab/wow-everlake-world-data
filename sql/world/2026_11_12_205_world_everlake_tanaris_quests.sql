-- Icy Veins quest records and QuestieDB Forever NPC endpoints.
START TRANSACTION;
SET @add_collection := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=96775)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=96775 OR ID=475479)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id WHERE c.id=264074 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)
 AND EXISTS (SELECT 1 FROM creature_loot_template l JOIN creature_template_difficulty d ON d.LootID=l.Entry
             JOIN creature c ON c.id=d.Entry WHERE l.Item=277112 AND l.ItemType=0 AND d.DifficultyID=0);
INSERT INTO quest_template (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 96775,2,1176,8,12261800583900083122,6,2,2787,30000,530,15000,'Zum''rah''s Head','Slay Witch Doctor Zum''rah and bring Zum''rah''s Head to Mazu''kon in Mulgore.','Ol'' Mazu''kon got a bone to pick with a Witch Doctor that go by the name of Zum''rah and I be thinkin'' you can help me out with that. \r\n\r\nZum''rah practice all his bad voodoo in the Sandfury city of Zul''Farrak, far to the south in the deserts of Tanaris. Go there. Kill Zum''rah, and bring me his head.\r\n\r\nTrust me mon, the world be a better place with his head stuck on pike outside my hut than it be sittin'' on his shoulders.',70532 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template',96775,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 96775,46,42,0 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_classic_level',96775,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 96775,2,46 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template_classic_level',96775,2,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO creature_queststarter (id,quest) SELECT 264074,96775 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_queststarter',264074,96775,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO creature_questender (id,quest) SELECT 264074,96775 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_questender',264074,96775,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild)
SELECT 475479,96775,1,0,0,277112,1,32,1,70532 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_objectives',475479,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_classic_money (ID,RewardMoney) SELECT 96775,6500 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_classic_money',96775,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_request_items (ID,CompletionText,VerifiedBuild) SELECT 96775,'Bad voodoo is bad for ya. Remember that, mon.',70532 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_request_items',96775,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 96775,'I be thankin'' you, <Class>. This a good thing you done for Ol'' Maz.$B$B<Mazu''kon holds up the severed head and starts talking to it.>$B$BOh Zum''rah, my old friend. I be tellin'' you this was comin''. No more voodoo for you, mon.',70532 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_offer_reward',96775,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
SET @add_collection := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=97530)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=97530 OR ID=476052)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id WHERE c.id=7882 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)
 AND EXISTS (SELECT 1 FROM creature_loot_template l JOIN creature_template_difficulty d ON d.LootID=l.Entry
             JOIN creature c ON c.id=d.Entry WHERE l.Item=278186 AND l.ItemType=0 AND d.DifficultyID=0);
INSERT INTO quest_template (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,RewardItem1,RewardAmount1,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 97530,2,440,8,18446744073709551615,5,1,369,10000,281282,1,'Dunemaul Dues','Security Chief Bilgewhizzle of Steamwheedle Port in Tanaris wants you to recover a particularly shiny bangle bracelet lost near the Dunemaul ogre compound.','A merchant caravan took a wrong turn through the desert and got jumped by the Dunemaul ogres. Only reason they made it out alive is ''cause they tossed some cargo overboard to distract the brutes.\r\n\r\nMust be this merchant''s got friends with the nobs runnin'' ships and zeppelins, ''cause now they want ME pickin'' up what got lost.\r\n\r\nI''m stuck here working. But if YOU see a nice shiny bangle while you''re beatin'' on ogres, I''ll make it worth ya while.',70532 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template',97530,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 97530,47,40,0 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_classic_level',97530,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 97530,2,47 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template_classic_level',97530,2,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO creature_queststarter (id,quest) SELECT 7882,97530 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_queststarter',7882,97530,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO creature_questender (id,quest) SELECT 7882,97530 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_questender',7882,97530,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild)
SELECT 476052,97530,1,0,4,278186,1,32,1,70532 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_objectives',476052,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_classic_money (ID,RewardMoney) SELECT 97530,3500 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_classic_money',97530,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_request_items (ID,CompletionText,VerifiedBuild) SELECT 97530,'I can understand why some flashy metal might work to distract one of those oafs, everything they craft is mediogre.',70532 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_request_items',97530,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 97530,'Hey, yea, that looks like what had them all rattled. Doesn''t look much worse for the wear. Maybe those stiffs will stop breathin'' down my neck about lost profits now.$B$BHere, have a little somethin'' for the trouble.',70532 WHERE @add_collection;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_offer_reward',97530,0,'2026_11_12_205_world_everlake_tanaris_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_collection;
COMMIT;
