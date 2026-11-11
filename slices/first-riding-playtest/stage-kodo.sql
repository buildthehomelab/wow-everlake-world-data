-- Disposable playtest. The brown Kodo uses the converted interaction point and terrain Z.
SET @add_riding_96982 := (NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=96982) AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=96982 OR ID IN (474645,474646,474647)) AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=96982) AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=96982));
INSERT INTO quest_template (ID,QuestType,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,RewardChoiceItemID1,RewardChoiceItemQuantity1,RewardChoiceItemID2,RewardChoiceItemQuantity2,RewardChoiceItemID3,RewardChoiceItemQuantity3,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 96982,2,1048576,32,0,1,81,2500,275993,1,15290,1,15277,1,'Your First Riding Kodo','Inspect the riding kodos to choose your first mount.','Ah, I''ve been expecting you, $c. It would seem the winds have brought you to me this day. You have come seeking a kodo, correct?\n\nThe kodo is a noble beast that is slow to anger, and you would be hard pressed to find a more dependable companion.\n\nToday you have an important choice to make. You and your kodo will travel the world together, so find which one speaks to you. Fear not, whatever choice you make will be the right one.\n\nGo examine the kodos and return to me when you have made your choice.',0 WHERE @add_riding_96982;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 96982,40,40,0 WHERE @add_riding_96982;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 96982,2,40 WHERE @add_riding_96982;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474645,96982,3,0,4,267226,1,32,0,'Grey Riding Kodo',0 WHERE @add_riding_96982;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474646,96982,3,1,5,267227,1,32,0,'Brown Riding Kodo',0 WHERE @add_riding_96982;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474647,96982,3,2,6,267216,1,32,0,'White Riding Kodo',0 WHERE @add_riding_96982;
INSERT INTO creature_queststarter (id,quest,VerifiedBuild) SELECT 3685,96982,0 WHERE @add_riding_96982;
INSERT INTO creature_questender (id,quest,VerifiedBuild) SELECT 3685,96982,0 WHERE @add_riding_96982;
INSERT INTO conditions
    (SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,ConditionTypeOrReference,
     ConditionTarget,ConditionValue1,ConditionValue2,Comment)
SELECT 19,0,q.ID,0,7,0,762,75,'First mount quest requires Apprentice Riding'
FROM quest_template q
WHERE q.ID=96982
  AND NOT EXISTS (
      SELECT 1 FROM conditions c
      WHERE c.SourceTypeOrReferenceId=19 AND c.SourceGroup=0 AND c.SourceEntry=q.ID
  );

INSERT INTO creature (guid,id,map,position_x,position_y,position_z,orientation,npcflag)
SELECT 26722700,267227,1,-2279.09,-402.21,-9.22,0,npcflag | 1
FROM creature_template WHERE entry=267227
  AND NOT EXISTS (SELECT 1 FROM creature WHERE id=267227 OR guid=26722700);
UPDATE creature c JOIN creature_template t ON t.entry=c.id
SET c.npcflag=COALESCE(c.npcflag,t.npcflag) | 1
WHERE c.map=1 AND c.id IN (267216,267226) AND (COALESCE(c.npcflag,t.npcflag)&1)=0;
