-- Icy Veins Forever quests 95327 and 95330, with QuestieDB NPC corroboration.
START TRANSACTION;
SET @add_report := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95327)
 AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=95327)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=95327)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=95327)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=95327)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95327 OR ID=470258)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=95327)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=95327)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (3945,255897) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,ItemDrop1,ItemDropQuantity1,
  RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,
  LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95327,2,16591,36700160,18446744073709551615,268810,0,0,5,1,2827,10000,
 'All''s Well That Ends Well','Return to Friz Frazzlespark at Powderfuse Port in the Riverglades.','Looks like a deal''s a deal. The Venture Co. got their comeuppance, Friz gets her loot, and everybody''s happy. Overall a pretty smooth transaction if I do say so myself.\r\n\r\nNow scram, I got another shipment comin'' in soon from some Southsea Pirates.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template',95327,0,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_addon (ID,ProvidedItemCount) SELECT 95327,1 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template_addon',95327,0,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95327,40,36,0 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_classic_level',95327,0,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95327,2,40 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template_classic_level',95327,2,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 95327,'Glad you finally made it back. Took you awhile. I once tried to set up a trade route with Booty Bay but they weren''t interested. Guess they didn''t wanna do business with a place called ''Powderfuse Port.'' Go figure.$B$BAnyways, nice job, kid.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_offer_reward',95327,0,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_queststarter (id,quest) SELECT 3945,95327 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_queststarter',3945,95327,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_questender (id,quest) SELECT 255897,95327 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_questender',255897,95327,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 470258,95327,1,0,0,268810,1,32,1,70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_objectives',470258,0,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
COMMIT;

START TRANSACTION;
SET @add_report := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95330)
 AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=95330)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=95330)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=95330)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=95330)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95330 OR ID=470277)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=95330)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=95330)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (259863,256438) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,ItemDrop1,ItemDropQuantity1,
  RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,
  LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95330,2,16591,3145728,6130900294268439629,268816,0,0,1,1,2826,1000,
 'Love Thy Neighbor','Deliver Cassandra''s surplus farm goods to Halligan Turner at Turner''s Logging Camp.','My husband and I have a farm north of here. I come to Farholde after each harvest to sell what we grow. In good seasons, I like to set aside whatever we don''t sell to give to folks who need a little pick-me-up. Gotta take care of your neighbors, I say.\r\n\r\nThere''s a logging camp north of our farm, right on the river. I''m sure those boys could use some fruits and vegetables to give ''em some variety in their diet.\r\n\r\nIf you''re heading that way, could you give this to the foreman there? Name''s Halligan Turner.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template',95330,0,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_addon (ID,ProvidedItemCount) SELECT 95330,1 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template_addon',95330,0,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95330,37,36,0 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_classic_level',95330,0,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95330,2,37 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template_classic_level',95330,2,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 95330,'The Wheelers are too kind!$B$BCassandra''s right, we don''t eat much besides meat and bread out here. I''ll make sure everyone gets a share of these.$B$BThank you for the gift. I''ll have to repay her kindness some time.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_offer_reward',95330,0,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_queststarter (id,quest) SELECT 259863,95330 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_queststarter',259863,95330,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_questender (id,quest) SELECT 256438,95330 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_questender',256438,95330,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 470277,95330,1,0,0,268816,1,0,1,70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_objectives',470277,0,'2026_11_12_203_world_everlake_riverglades_item_handoffs.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
COMMIT;
