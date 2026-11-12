-- Pinned client item StartQuestID, Icy Veins quest data, and QuestieDB Forever turn-ins.
START TRANSACTION;
SET @add_item_quest := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=78823)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=78823 OR ID=477006)
 AND EXISTS (SELECT 1 FROM creature WHERE id=715 AND npcflag IS NULL)
 AND EXISTS (SELECT 1 FROM creature_loot_template l
             JOIN creature_template_difficulty d ON d.LootID=l.Entry AND d.DifficultyID=0
             JOIN creature c ON c.id=d.Entry WHERE l.Item=211269 AND l.ItemType=0 AND l.QuestRequired=0);
UPDATE creature_template SET npcflag=npcflag|2 WHERE entry=715 AND @add_item_quest;
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 78823,2,3,33554432,18446744073709551615,3,1,0,0,
 'Terror of the Desert Skies','Bring the Primitive Drawing to Hemet Nesingwary in Stranglethorn Vale.','The drawing is composed of rough, broad, strokes and seems to depict a large bird of prey. Despite the simple composition, the artist clearly viewed this creature with fear and awe. An expert on big game could likely tell you more.',70532 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template',78823,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 78823,40,26,0 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_classic_level',78823,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 78823,2,40 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template_classic_level',78823,2,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild)
SELECT 477006,78823,1,0,0,211269,1,32,0,70532 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_objectives',477006,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO creature_questender (id,quest) SELECT 715,78823 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_questender',715,78823,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO quest_request_items (ID,CompletionText,VerifiedBuild) SELECT 78823,'Got something for me, <Class>?',70532 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_request_items',78823,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 78823,'Well now. This is certainly interesting...',70532 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_offer_reward',78823,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
SET @add_item_quest := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=93644)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=93644 OR ID=467059)
 AND EXISTS (SELECT 1 FROM creature WHERE id=253471 AND npcflag IS NULL)
 AND EXISTS (SELECT 1 FROM creature_loot_template l
             JOIN creature_template_difficulty d ON d.LootID=l.Entry AND d.DifficultyID=0
             JOIN creature c ON c.id=d.Entry WHERE l.Item=260347 AND l.ItemType=0 AND l.QuestRequired=0);
UPDATE creature_template SET npcflag=npcflag|2 WHERE entry=253471 AND @add_item_quest;
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 93644,2,16651,36700160,18446744073709551615,5,1,0,0,
 'Tattered Journal','The text suggests the author of this journal may be somewhere in Shen''dralas.','<Found near Shen''dralas, this dirty old tome no longer holds most of its knowledge.\r\n\r\nOf the text that remains, individual letters are difficult to distinguish from words. It may prove challenging to read at first, but one of them appears to be a surname.\r\n\r\nPerhaps its author, "Evenshade", may be found nearby.>',70532 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template',93644,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 93644,45,35,0 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_classic_level',93644,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 93644,2,45 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template_classic_level',93644,2,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild)
SELECT 467059,93644,1,0,0,260347,1,32,0,70532 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_objectives',467059,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO creature_questender (id,quest) SELECT 253471,93644 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_questender',253471,93644,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO quest_request_items (ID,CompletionText,VerifiedBuild) SELECT 93644,'Is there something you need?',70532 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_request_items',93644,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild) SELECT 93644,'My journal? Certainly not, it was lost centuries ago.$B$B<Mordent reclaims the dirty tome and examines the cover. His brow lifts in surprise, but it falls after he opens the covers.>$B$BYou have indeed found my journal, but alas, all that I had written is gone. I have not forgotten what was within, but I do not wish to speak any of it aloud.$B$BShould its pages have also survived somehow, you have my permission to attempt to restore it.',70532 WHERE @add_item_quest;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_offer_reward',93644,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_item_quest;
COMMIT;

-- Icy Veins Forever quest 84377 and pinned client item 227911.
START TRANSACTION;
SET @add_rend := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=84377)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=84377 OR ID=452467)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id
             WHERE c.id=332 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)
 AND EXISTS (SELECT 1 FROM creature_loot_template l JOIN creature_template_difficulty d
             ON d.LootID=l.Entry AND d.DifficultyID=0 JOIN creature c ON c.id=d.Entry
             WHERE c.id=10429 AND l.Item=227911 AND l.ItemType=0 AND l.QuestRequired=0);
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,
  RewardFactionID1,RewardFactionOverride1,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 84377,2,1519,268435456,6130900294268439629,7,1,72,20000,'End of the Dark Horde',
 'Take the Head of Rend Blackhand to Master Mathias Shaw in Stormwind.',
 'The deed is done. Dal''rend Blackhand, Warchief of the Dark Horde, lies dead at your feet.\r\n\r\nTake his head and present it to Master Shaw.',70532 WHERE @add_rend;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template',84377,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_rend;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 84377,60,60,0 WHERE @add_rend;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_classic_level',84377,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_rend;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 84377,2,60 WHERE @add_rend;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_template_classic_level',84377,2,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_rend;
INSERT INTO quest_classic_money (ID,RewardMoney) SELECT 84377,27000 WHERE @add_rend;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_classic_money',84377,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_rend;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,VerifiedBuild)
SELECT 452467,84377,1,0,1,227911,1,32,0,70532 WHERE @add_rend;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'quest_objectives',452467,0,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_rend;
INSERT INTO creature_questender (id,quest) SELECT 332,84377 WHERE @add_rend;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_questender',332,84377,'2026_11_12_204_world_everlake_dropped_starter_quests.sql','Pinned client item data and Icy Veins Forever' WHERE @add_rend;
COMMIT;
