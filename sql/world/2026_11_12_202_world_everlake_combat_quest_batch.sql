-- Icy Veins Forever quests 93788 and 93976, item 263972, and QuestieDB Forever endpoints.
START TRANSACTION;
SET @add_chain := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID IN (93788,93976))
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID IN (93788,93976) OR ID IN (467479,468026))
 AND EXISTS (SELECT 1 FROM creature WHERE id=256434)
 AND EXISTS (SELECT 1 FROM creature WHERE id=256657 AND npcflag IS NULL)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id WHERE c.id=255897 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)
 AND EXISTS (SELECT 1 FROM creature_template_difficulty WHERE Entry=256434 AND DifficultyID=0 AND LootID IN (0,256434))
 AND NOT EXISTS (SELECT 1 FROM creature_template_difficulty WHERE LootID=256434 AND Entry<>256434)
 AND NOT EXISTS (SELECT 1 FROM creature_loot_template WHERE Entry=256434 AND Item=263972);
UPDATE creature_template SET npcflag=npcflag|2 WHERE entry=256657 AND @add_chain;
UPDATE creature_template_difficulty SET LootID=256434 WHERE Entry=256434 AND DifficultyID=0 AND LootID=0 AND @add_chain;
INSERT INTO creature_loot_template (Entry,Item,Chance,QuestRequired,Comment)
SELECT 256434,263972,37.866,1,'Woodworker''s Axe - Borrowed Blades' WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_loot_template',256434,0,263972,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,RewardXPDifficulty,RewardXPMultiplier,
  RewardNextQuest,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 93788,2,16591,36700168,12261800583900083122,0,5,1,
 93976,'Borrowed Blades','Retrieve 10 Woodworker''s Axe from the lumberjacks at Turner''s Logging Camp for Kreza Darkthorn in Rog''mar.','With the human presence to the south and Twilight to the west, the battle for resources has become difficult. But why gather resources amongst our enemies when their blades will suffice?\r\n\r\nFollow the river south to the mill. When you hear the whistling of woodworkers among the trees, tread lightly. When the opportunity presents itself, strike hard and fast.\r\n\r\nI''ll stay behind to keep the forge running hot. Gur''dok will break down the blades while I fashion weaponry forged of their own materials.',70532 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_template',93788,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_template_addon (ID,PrevQuestID,ProvidedItemCount) SELECT 93788,0,0 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_template_addon',93788,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 93788,38,36,0 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_classic_level',93788,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 93788,2,38 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_template_classic_level',93788,2,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild)
SELECT 467479,93788,1,0,0,263972,10,32,1,70532 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_objectives',467479,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 93788,'The blood on these blades is still fresh. Impressive.$B$BHow long do you think it will take for the humans to realize we''ve been using their own weapons against them?',70532 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_offer_reward',93788,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_request_items (ID,CompletionText,VerifiedBuild) SELECT 93788,'Have you retrieved what we discussed?',70532 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_request_items',93788,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO creature_queststarter (id,quest) SELECT 256657,93788 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_queststarter',256657,93788,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO creature_questender (id,quest) SELECT 256657,93788 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_questender',256657,93788,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,RewardXPDifficulty,RewardXPMultiplier,
  RewardNextQuest,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 93976,2,16591,36700160,12261800583900083122,263973,1,1,
 0,'The Goblin Trader','Deliver the blade to Kreza Darkthorn''s acquaintance at the docks east of Rog''mar.','While Gur''dok and I continue our work, we did fashion a particular blade for a friend--perhaps friend is too strong a word--for an acquaintance down at the docks. This particular individual is well known and connected all across the Kingdoms and beyond.\r\n\r\nTake this. When you deliver it, let her know I sent you. And tell her we''re even.',70532 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_template',93976,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_template_addon (ID,PrevQuestID,ProvidedItemCount) SELECT 93976,93788,1 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_template_addon',93976,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 93976,36,36,0 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_classic_level',93976,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 93976,2,36 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_template_classic_level',93976,2,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild)
SELECT 468026,93976,1,0,1,263973,1,32,0,70532 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_objectives',468026,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 93976,'Hey there! Nice to meet ya!$B$BDid Kreza really say we''re even? That''s cute.',70532 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_offer_reward',93976,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO quest_request_items (ID,CompletionText,VerifiedBuild) SELECT 93976,'A delivery on behalf of the horde, eh? You must be with Kreza.',70532 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_request_items',93976,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO creature_queststarter (id,quest) SELECT 256657,93976 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_queststarter',256657,93976,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
INSERT INTO creature_questender (id,quest) SELECT 255897,93976 WHERE @add_chain;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_questender',255897,93976,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_chain;
COMMIT;

-- Icy Veins Forever quest catalog and QuestieDB Forever NPC endpoints.
START TRANSACTION;
SET @add_quest := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94483)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94483 OR ID IN (476938,468778))
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id WHERE c.id=256418 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)
 AND (SELECT COUNT(DISTINCT id) FROM creature WHERE id IN (270667,257926))=2;
INSERT INTO quest_template (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 94483,2,16591,36700168,12261800583900083122,5,1,'Show Them How It''s Done','Slay 8 Farholde Priests and 12 Farholde Scouts south of the river.','Our scouts have reported training camps by the river to the south. If I''d received word sooner, it would have saved us both the hassle of locating and removing the human filth in a timely manner.\r\n\r\nContinue your efforts, $n. Holding back the humans to their precious little keep will buy us time to focus on other matters at hand.\r\n\r\nBe swift about it.',70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_template',94483,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 476938,94483,0,0,0,270667,8,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_objectives',476938,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 468778,94483,0,1,1,257926,12,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_objectives',468778,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 94483,39,36,0 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_classic_level',94483,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 94483,2,39 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_template_classic_level',94483,2,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO creature_queststarter (id,quest) SELECT 256418,94483 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_queststarter',256418,94483,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO creature_questender (id,quest) SELECT 256418,94483 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_questender',256418,94483,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_classic_money (ID,RewardMoney) SELECT 94483,3500 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_classic_money',94483,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 94483,'Swift work. Now let''s continue our momentum elsewhere.',70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_offer_reward',94483,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_request_items (ID,CompletionText,VerifiedBuild) SELECT 94483,'Once the threat of our friends downstream has been stemmed we''ll focus our attention elsewhere.',70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_request_items',94483,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
SET @add_quest := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=97386)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=97386 OR ID IN (475855,475856,475857,475858))
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id WHERE c.id=2464 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)
 AND (SELECT COUNT(DISTINCT id) FROM creature WHERE id IN (710,709,678,679))=4;
INSERT INTO quest_template (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,RewardChoiceItemID1,RewardChoiceItemQuantity1,RewardChoiceItemID2,RewardChoiceItemQuantity2,RewardChoiceItemID3,RewardChoiceItemQuantity3,RewardFactionID1,RewardFactionOverride1,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 97386,2,33,8,12261800583900083122,6,1,277979,1,277980,1,277981,1,76,10000,'The Offense of Grom''gol','Commander Aggro''gosh of the Grom''gol base camp wants you to kill ogres at the Mosh''Ogg Ogre Mount.','$n! Your arrival is timely, as always.\r\n\r\nYou have provided valuable assistance to the defense of Grom''gol, and we are grateful. After your recent push against the ogres nearby, we sent out a scout to see if there are more out there that may try to enact vengeance against us. As it turns out, there is a cave far to the east that they have claimed as their hovel.\r\n\r\nGather a friend or two and make it very clear that we will not tolerate another threat to our settlement, now or ever!',70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_template',97386,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 475855,97386,0,0,2,710,3,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_objectives',475855,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 475856,97386,0,1,3,709,3,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_objectives',475856,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 475857,97386,0,2,4,678,3,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_objectives',475857,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 475858,97386,0,3,5,679,3,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_objectives',475858,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 97386,44,38,0 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_classic_level',97386,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 97386,2,44 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_template_classic_level',97386,2,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO creature_queststarter (id,quest) SELECT 2464,97386 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_queststarter',2464,97386,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO creature_questender (id,quest) SELECT 2464,97386 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'creature_questender',2464,97386,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_request_items (ID,CompletionText,VerifiedBuild) SELECT 97386,'Are you having second thoughts, $N?',70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,k3,file,note)
SELECT 'quest_request_items',97386,0,0,'2026_11_12_202_world_everlake_combat_quest_batch.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
COMMIT;
