-- Icy Veins Forever objective and reward data. QuestieDB Forever confirms both NPC relations.
START TRANSACTION;
SET @alliance := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=99193)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE ID=479594 OR QuestID=99193)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id
             WHERE c.id=276170 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0);
SET @horde := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=99198)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE ID=479601 OR QuestID=99198)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id
             WHERE c.id=276171 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0);
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,
  RewardFactionID1,RewardFactionOverride1,LogTitle,LogDescription,VerifiedBuild)
SELECT 99193,2,279,6130900294268439629,3,1,2779,15000,'A Donation of Mageweave','Donate 60 Mageweave Cloth.',70532 WHERE @alliance
UNION ALL
SELECT 99198,2,215,12261800583900083122,3,1,2778,15000,'A Donation of Mageweave','Donate 60 Mageweave Cloth.',70532 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,file,note)
SELECT 'quest_template',99193,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_template',99198,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel)
SELECT 99193,60,40,0 WHERE @alliance UNION ALL SELECT 99198,60,40,0 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',99193,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_classic_level',99198,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel)
SELECT 99193,2,60 WHERE @alliance UNION ALL SELECT 99198,2,60 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',99193,2,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_template_classic_level',99198,2,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,VerifiedBuild)
SELECT 479594,99193,1,0,0,4338,60,32,70532 WHERE @alliance
UNION ALL SELECT 479601,99198,1,0,0,4338,60,32,70532 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_objectives',479594,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_objectives',479601,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO creature_queststarter (id,quest)
SELECT 276170,99193 WHERE @alliance UNION ALL SELECT 276171,99198 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',276170,99193,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'creature_queststarter',276171,99198,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO creature_questender (id,quest)
SELECT 276170,99193 WHERE @alliance UNION ALL SELECT 276171,99198 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',276170,99193,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'creature_questender',276171,99198,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_request_items (ID,CompletionText,VerifiedBuild)
SELECT 99198,'The material known as Mageweave has curious properties of great interest to the Windshapers. If you could produce a donation of sixty pieces of mageweave cloth it would be most appreciated. Such generosity would surely be noted by our order, as well!$B$BIf you have the sixty pieces of mageweave cloth on you and are ready to donate them, I''m able to take them from you now.',70532 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_request_items',99198,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
COMMIT;

-- Icy Veins Forever objective and reward data. QuestieDB Forever confirms both NPC relations.
START TRANSACTION;
SET @alliance := (SELECT COUNT(*) FROM quest_template WHERE ID IN (99191,99192,99193))=3 AND NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=99194)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE ID=479597 OR QuestID=99194)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id
             WHERE c.id=276170 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0);
SET @horde := (SELECT COUNT(*) FROM quest_template WHERE ID IN (99196,99197,99198))=3 AND NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=99199)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE ID=479602 OR QuestID=99199)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id
             WHERE c.id=276171 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0);
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,
  RewardFactionID1,RewardFactionOverride1,LogTitle,LogDescription,VerifiedBuild)
SELECT 99194,2,279,6130900294268439629,5,1,2779,15000,'A Donation of Runecloth','Donate 60 Runecloth Cloth.',70532 WHERE @alliance
UNION ALL
SELECT 99199,2,215,12261800583900083122,5,1,2778,15000,'A Donation of Runecloth','Donate 60 Runecloth Cloth.',70532 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,file,note)
SELECT 'quest_template',99194,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_template',99199,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel)
SELECT 99194,60,50,0 WHERE @alliance UNION ALL SELECT 99199,60,50,0 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',99194,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_classic_level',99199,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel)
SELECT 99194,2,60 WHERE @alliance UNION ALL SELECT 99199,2,60 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',99194,2,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_template_classic_level',99199,2,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,VerifiedBuild)
SELECT 479597,99194,1,0,0,14047,60,32,70532 WHERE @alliance
UNION ALL SELECT 479602,99199,1,0,0,14047,60,32,70532 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_objectives',479597,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_objectives',479602,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO creature_queststarter (id,quest)
SELECT 276170,99194 WHERE @alliance UNION ALL SELECT 276171,99199 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',276170,99194,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'creature_queststarter',276171,99199,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO creature_questender (id,quest)
SELECT 276170,99194 WHERE @alliance UNION ALL SELECT 276171,99199 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',276170,99194,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'creature_questender',276171,99199,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,file,note) SELECT 'quest_template_addon',q.ID,'2026_11_12_207_world_everlake_cloth_donations.sql','QuestieDB Forever donation prerequisites' FROM quest_template q WHERE q.ID IN (99191,99192,99193) AND @alliance AND NOT EXISTS (SELECT 1 FROM quest_template_addon a WHERE a.ID=q.ID);
INSERT INTO quest_template_addon (ID,NextQuestID,ExclusiveGroup)
SELECT ID,99194,-99191 FROM quest_template WHERE ID IN (99191,99192,99193) AND @alliance
ON DUPLICATE KEY UPDATE
 ExclusiveGroup=IF(NextQuestID=0 AND ExclusiveGroup=0,VALUES(ExclusiveGroup),ExclusiveGroup),
 NextQuestID=IF(NextQuestID=0 AND ExclusiveGroup=VALUES(ExclusiveGroup),VALUES(NextQuestID),NextQuestID);
INSERT INTO everlake_import_rows (tbl,k1,file,note) SELECT 'quest_template_addon',q.ID,'2026_11_12_207_world_everlake_cloth_donations.sql','QuestieDB Forever donation prerequisites' FROM quest_template q WHERE q.ID IN (99196,99197,99198) AND @horde AND NOT EXISTS (SELECT 1 FROM quest_template_addon a WHERE a.ID=q.ID);
INSERT INTO quest_template_addon (ID,NextQuestID,ExclusiveGroup)
SELECT ID,99199,-99196 FROM quest_template WHERE ID IN (99196,99197,99198) AND @horde
ON DUPLICATE KEY UPDATE
 ExclusiveGroup=IF(NextQuestID=0 AND ExclusiveGroup=0,VALUES(ExclusiveGroup),ExclusiveGroup),
 NextQuestID=IF(NextQuestID=0 AND ExclusiveGroup=VALUES(ExclusiveGroup),VALUES(NextQuestID),NextQuestID);
COMMIT;

-- Icy Veins Forever objective and reward data. QuestieDB Forever confirms both NPC relations.
START TRANSACTION;
SET @alliance := EXISTS (SELECT 1 FROM quest_template WHERE ID=99194) AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=99195) AND NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=99195)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE ID=479598 OR QuestID=99195)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id
             WHERE c.id=276170 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0);
SET @horde := EXISTS (SELECT 1 FROM quest_template WHERE ID=99199) AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=99200) AND NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=99200)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE ID=479603 OR QuestID=99200)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id
             WHERE c.id=276171 AND (COALESCE(c.npcflag,t.npcflag)&2)<>0);
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,
  RewardFactionID1,RewardFactionOverride1,LogTitle,LogDescription,VerifiedBuild)
SELECT 99195,2,279,6130900294268439629,0,1,2779,5000,'Additional Runecloth','Donate 20 Runecloth.',70532 WHERE @alliance
UNION ALL
SELECT 99200,2,215,12261800583900083122,0,1,2778,5000,'Additional Runecloth','Donate 20 Runecloth.',70532 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,file,note)
SELECT 'quest_template',99195,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_template',99200,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel)
SELECT 99195,60,50,0 WHERE @alliance UNION ALL SELECT 99200,60,50,0 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',99195,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_classic_level',99200,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel)
SELECT 99195,2,60 WHERE @alliance UNION ALL SELECT 99200,2,60 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',99195,2,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_template_classic_level',99200,2,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,VerifiedBuild)
SELECT 479598,99195,1,0,0,14047,20,32,70532 WHERE @alliance
UNION ALL SELECT 479603,99200,1,0,0,14047,20,32,70532 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_objectives',479598,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_objectives',479603,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO creature_queststarter (id,quest)
SELECT 276170,99195 WHERE @alliance UNION ALL SELECT 276171,99200 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',276170,99195,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'creature_queststarter',276171,99200,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO creature_questender (id,quest)
SELECT 276170,99195 WHERE @alliance UNION ALL SELECT 276171,99200 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',276170,99195,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'creature_questender',276171,99200,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
INSERT INTO quest_template_addon (ID,PrevQuestID,SpecialFlags)
SELECT 99195,99194,1 WHERE @alliance UNION ALL SELECT 99200,99199,1 WHERE @horde;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_addon',99195,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @alliance
UNION ALL SELECT 'quest_template_addon',99200,0,'2026_11_12_207_world_everlake_cloth_donations.sql','Icy Veins Forever and QuestieDB Forever' WHERE @horde;
COMMIT;
