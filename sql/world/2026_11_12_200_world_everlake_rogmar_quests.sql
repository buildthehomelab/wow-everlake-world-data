-- Icy Veins Forever and QuestieDB Forever quest 94480.
-- The pinned client defines the provided report with no StartQuestID.
-- ItemDrop removes the report at turn-in without adding a visible objective.

START TRANSACTION;
SET @add_report := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94480)
 AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=94480)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=94480)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=94480)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=94480)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94480)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=94480)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94480)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (256418,256655) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,ItemDrop1,ItemDropQuantity1,
  RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,
  LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 94480,2,16591,36700160,12261800583900083122,265065,265065,1,1,1,0,0,
 'A Gift From Our Enemies','Deliver the Stolen Feed to Gorg in Rog''mar.','The humans of these lands are only one of many threats. With the encroaching Twilight and snarls of gnolls echoing from the hills nearby, battle may call at a moment''s notice. Maintaining the strength of our allies may be the difference between Rog''mar''s success or our removal from these lands.\r\n\r\nDeliver the goods you''ve gathered to Gorg. He''ll make sure our allies are well fed.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',94480,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_addon (ID,ProvidedItemCount) SELECT 94480,1 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_addon',94480,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 94480,36,36,0 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',94480,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 94480,2,36 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',94480,2,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild)
SELECT 94480,'Pungent. Earthy. And something a bit unpleasant. It appears you''ve been ransacking the farmstead, $N.$B$BThis will make for a hearty stew in no time.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',94480,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_queststarter (id,quest) SELECT 256418,94480 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',256418,94480,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_questender (id,quest) SELECT 256655,94480 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',256655,94480,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
COMMIT;

-- Icy Veins Forever and QuestieDB Forever quest 95062.
-- The pinned client defines the provided report with no StartQuestID.
-- ItemDrop removes the report at turn-in without adding a visible objective.

START TRANSACTION;
SET @add_report := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95062)
 AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=95062)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=95062)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=95062)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=95062)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95062)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=95062)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=95062)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (255897,256418) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,ItemDrop1,ItemDropQuantity1,
  RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,
  LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95062,2,16591,36700160,12261800583900083122,276066,276066,1,1,1,76,1000,
 'Frazzlespark''s Crate','Deliver Frazzlespark''s Crate to Krom''rosh at Rog''mar.','Time for a special delivery.\r\n\r\nOld Krom''rosh is waiting for this package over at Rog''mar just west of here.\r\n\r\nI suggest you get it to him quickly, but carefully. Why, you might ask? It''s better to not ask questions.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',95062,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_addon (ID,ProvidedItemCount) SELECT 95062,1 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_addon',95062,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95062,36,36,0 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',95062,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95062,2,36 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',95062,2,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild)
SELECT 95062,'We''ve forged many relationships out of respect, others out of necessity.$B$BThese dealings help us accomplish our goals.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',95062,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_queststarter (id,quest) SELECT 255897,95062 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',255897,95062,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_questender (id,quest) SELECT 256418,95062 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',256418,95062,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
COMMIT;
-- Icy Veins Forever quests 94532 and 94672, corroborated by QuestieDB Forever.
START TRANSACTION;

SET @add_quest := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94532)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94532 OR ID IN (468849,468850,468851))
 AND EXISTS (SELECT 1 FROM creature WHERE id=258031 AND npcflag IS NULL)
 AND (SELECT COUNT(DISTINCT id) FROM creature WHERE id IN (255770,255772,255769))=3;
UPDATE creature_template SET npcflag=npcflag|2 WHERE entry=258031 AND @add_quest;
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 94532,2,16591,36700168,12261800583900083122,5,1,
 'Gnoll Infestation','Kill 8 Redridge Mystics, 8 Redridge Trappers, and 6 Redridge Brutes for Neza Bloodsnout at Rog''mar.','Though the gnoll presence has dwindled with the Twilight''s encroachment, the threat remains.\r\n\r\nThe hills to the southwest are infested with their kind, disrupting trades and travelers alike.\r\n\r\nClear a path for our allies by removing the threat.',70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',94532,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 94532,38,36,0 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',94532,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 94532,2,38 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',94532,2,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 94532,'The scent of gnolls is not one that washes away easily.',70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',94532,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO creature_queststarter (id,quest) SELECT 258031,94532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',258031,94532,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO creature_questender (id,quest) SELECT 258031,94532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',258031,94532,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 468849,94532,0,0,0,255770,8,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_objectives',468849,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 468850,94532,0,1,1,255772,8,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_objectives',468850,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 468851,94532,0,2,2,255769,6,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_objectives',468851,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;

SET @add_quest := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94672)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94672 OR ID IN (469068,471359,469069))
 AND EXISTS (SELECT 1 FROM creature WHERE id=256710 AND npcflag IS NULL)
 AND (SELECT COUNT(DISTINCT id) FROM creature WHERE id IN (256952,254560,256798))=3;
UPDATE creature_template SET npcflag=npcflag|2 WHERE entry=256710 AND @add_quest;
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 94672,2,16591,36700168,12261800583900083122,5,1,
 'Encroaching Twilight','Defeat 8 Twilight Raiders and 8 Twilight Neophytes within Sunnyglade for Tran''gul in Rog''mar.','Humans are not our only adversary within the Riverglades, $n, nor are they our most dire.\r\n\r\nA cult known as the Twilight''s Hammer has begun a campaign against those they deem heretics in the eyes of their twisted gods. The ravaged remains of a human settlement to the west are but the first to fall to their conquest. No doubt Rog''mar will be next.\r\n\r\nWe cannot afford to let them establish a foothold so close to our doorstep. Go to this so-called Sunnyglade and thin their numbers.',70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',94672,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 94672,41,36,0 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',94672,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 94672,2,41 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',94672,2,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 94672,'Excellent work, $N. With their numbers diminished, we can seek the source of the Twilight Hammer''s unprecedented expansion.',70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',94672,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO creature_queststarter (id,quest) SELECT 256710,94672 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',256710,94672,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO creature_questender (id,quest) SELECT 256710,94672 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',256710,94672,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 469068,94672,0,0,0,256952,8,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_objectives',469068,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 471359,94672,0,1,2,254560,8,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_objectives',471359,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild) SELECT 469069,94672,0,2,1,256798,8,32,0,70532 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_objectives',469069,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
INSERT INTO quest_classic_money (ID,RewardMoney) SELECT 94672,5500 WHERE @add_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_money',94672,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_quest;
COMMIT;
-- Icy Veins and QuestieDB Forever NPC handoffs.
START TRANSACTION;
SET @add_handoff := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94668)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94668)
 AND (SELECT COUNT(DISTINCT id) FROM creature WHERE id IN (255829,257062) AND npcflag IS NULL)=2;
UPDATE creature_template SET npcflag=npcflag|2 WHERE entry IN (255829,257062) AND @add_handoff;
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,
  RewardFactionID1,RewardFactionOverride1,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 94668,2,16591,3145736,12261800583900083122,1,1,
 2782,1000,'Bloodmaster''s Ring','Report to Jezap at the Bloodmaster''s Ring.','You smashed weak Twilight ogres. But they weak.\r\n\r\nToday you show Bloodmaster and little goblin friend you belong.\r\n\r\nTomorrow, maybe we meet again if you still breathing.',70532 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',94668,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 94668,41,36,0 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',94668,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 94668,2,41 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',94668,2,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
INSERT INTO creature_queststarter (id,quest) SELECT 255829,94668 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',255829,94668,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
INSERT INTO creature_questender (id,quest) SELECT 257062,94668 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',257062,94668,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 94668,'Hey, hey! Look what we got here. Another victim...er entrant lookin'' to prove themselves at the precipice of power!$B$BWell step right up, bub. Today''s your lucky day... or not.',70532 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',94668,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
SET @add_handoff := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95428)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95428)
 AND (SELECT COUNT(DISTINCT id) FROM creature WHERE id IN (255829,256418) AND npcflag IS NULL)=2;
UPDATE creature_template SET npcflag=npcflag|2 WHERE entry IN (255829,256418) AND @add_handoff;
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,
  RewardFactionID1,RewardFactionOverride1,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95428,2,16591,36700168,12261800583900083122,1,1,
 0,0,'Clugfist''s Decree','Report to Krom''rosh in Rog''mar.','Little $r smash Twilight good. Maybe your Horde stronger than Clugfist think.\r\n\r\nYou free to stay in Bolder''ok. For now.\r\n\r\nTell other tinies we spill blood again soon.',70532 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',95428,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95428,41,36,0 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',95428,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95428,2,41 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',95428,2,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
INSERT INTO creature_queststarter (id,quest) SELECT 255829,95428 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',255829,95428,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
INSERT INTO creature_questender (id,quest) SELECT 256418,95428 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',256418,95428,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 95428,'An ogre uprising? And so soon after their own battle for freedom from the Twilight''s Hammer? These warriors have nearly as bloody a history as our own. They will make for powerful allies if we can continue to gain their trust.$B$BYou''ve done well, $N. I suspect this is only the beginning of our dealings with the Bolder''ok clan.',70532 WHERE @add_handoff;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',95428,0,'2026_11_12_200_world_everlake_rogmar_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_handoff;
COMMIT;
