-- Disposable playtest with terrain-derived heights and provisional facing.
SET @add_riding_95511 := (NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95511) AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95511 OR ID IN (470820,470842,470844,473469)) AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=95511) AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=95511));
INSERT INTO quest_template (ID,QuestType,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,RewardChoiceItemID1,RewardChoiceItemQuantity1,RewardChoiceItemID2,RewardChoiceItemQuantity2,RewardChoiceItemID3,RewardChoiceItemQuantity3,RewardChoiceItemID4,RewardChoiceItemQuantity4,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95511,2,1048576,8,3,1,69,2500,8629,1,8631,1,8632,1,274706,1,'Your First Feline Friend','Inspect the riding sabers to choose your first mount.','Greetings, friend! I see today is a big day indeed; today you will bond with your first saber.\n\nAs you may or may not know these sabers are fiercely intelligent and extremely loyal to their bonded rider. You won''t find a more noble and steadfast companion. As such, you have an important choice to make. You and your saber will traverse the world together, so choose wisely! Fear not, whatever choice you make will be the correct one.\n\nGo, examine the sabers and return to me when you have made your choice.',0 WHERE @add_riding_95511;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95511,40,40,0 WHERE @add_riding_95511;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95511,2,40 WHERE @add_riding_95511;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 470820,95511,3,0,0,261529,1,0,0,'Inspect the Striped Frostsaber',0 WHERE @add_riding_95511;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 470842,95511,3,1,1,261578,1,0,0,'Inspect the Striped Nightsaber',0 WHERE @add_riding_95511;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 470844,95511,3,2,2,261579,1,0,0,'Inspect the Spotted Frostsaber',0 WHERE @add_riding_95511;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 473469,95511,3,3,3,265472,1,0,0,'Inspect the Striped Dawnsaber',0 WHERE @add_riding_95511;
INSERT INTO creature_queststarter (id,quest,VerifiedBuild) SELECT 4730,95511,0 WHERE @add_riding_95511;
INSERT INTO creature_questender (id,quest,VerifiedBuild) SELECT 4730,95511,0 WHERE @add_riding_95511;
INSERT INTO conditions
    (SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,ConditionTypeOrReference,
     ConditionTarget,ConditionValue1,ConditionValue2,Comment)
SELECT 19,0,q.ID,0,7,0,762,75,'First mount quest requires Apprentice Riding'
FROM quest_template q
WHERE q.ID=95511
  AND NOT EXISTS (
      SELECT 1 FROM conditions c
      WHERE c.SourceTypeOrReferenceId=19 AND c.SourceGroup=0 AND c.SourceEntry=q.ID
  );

INSERT INTO creature
    (guid,id,map,position_x,position_y,position_z,orientation,npcflag)
SELECT s.guid,s.id,1,s.x,s.y,s.z,0,t.npcflag | 1
FROM (
    SELECT 26152900 AS guid,261529 AS id,10133.23 AS x,2531.33 AS y,1324.34 AS z
    UNION ALL SELECT 26157800,261578,10127.87,2528.47,1323.94
    UNION ALL SELECT 26157900,261579,10122.65,2522.97,1324.51
) s
JOIN creature_template t ON t.entry=s.id
WHERE NOT EXISTS (SELECT 1 FROM creature WHERE id=s.id OR guid=s.guid);

UPDATE creature c JOIN creature_template t ON t.entry=c.id SET c.npcflag=COALESCE(c.npcflag,t.npcflag) | 1 WHERE c.map=1 AND c.id=265472 AND (COALESCE(c.npcflag,t.npcflag) & 1)=0;
