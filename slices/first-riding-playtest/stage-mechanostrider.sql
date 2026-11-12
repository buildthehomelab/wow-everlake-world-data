-- Disposable playtest with terrain-derived heights and provisional facing.
SET @add_riding_97046 := (NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=97046) AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=97046 OR ID IN (474891,474892,474893,474896)) AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=97046) AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=97046));
INSERT INTO quest_template (ID,QuestType,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,RewardChoiceItemID1,RewardChoiceItemQuantity1,RewardChoiceItemID2,RewardChoiceItemQuantity2,RewardChoiceItemID3,RewardChoiceItemQuantity3,RewardChoiceItemID4,RewardChoiceItemQuantity4,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 97046,2,1048576,64,3,1,54,2500,8563,1,8595,1,13321,1,13322,1,'Your First Mechanostrider','Inspect the riding mechanostriders to choose your first mount.','Salutations! I see today is a big day indeed; today you will synchronize your biometrics to the rider detection protocol of your first mechanostrider! This protocol will help the strider distinguish you from other possible riders.\n\nAs such, you have an important choice to make. You and your strider will traverse the world together so choose wisely! Fear not, whatever choice you make will be the correct one.\n\nGo examine the mechanostriders and return to me when you have made your choice.',0 WHERE @add_riding_97046;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 97046,40,40,0 WHERE @add_riding_97046;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 97046,2,40 WHERE @add_riding_97046;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474891,97046,3,0,0,267688,1,32,0,'Unpainted Mechanostrider',0 WHERE @add_riding_97046;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474892,97046,3,1,1,267684,1,32,0,'Green Mechanostrider',0 WHERE @add_riding_97046;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474893,97046,3,2,2,267687,1,32,0,'Blue Mechanostrider',0 WHERE @add_riding_97046;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474896,97046,3,3,3,267683,1,32,0,'Red Mechanostrider',0 WHERE @add_riding_97046;
INSERT INTO creature_queststarter (id,quest,VerifiedBuild) SELECT 7955,97046,0 WHERE @add_riding_97046;
INSERT INTO creature_questender (id,quest,VerifiedBuild) SELECT 7955,97046,0 WHERE @add_riding_97046;
INSERT INTO conditions
    (SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,ConditionTypeOrReference,
     ConditionTarget,ConditionValue1,ConditionValue2,Comment)
SELECT 19,0,q.ID,0,7,0,762,75,'First mount quest requires Apprentice Riding'
FROM quest_template q
WHERE q.ID=97046
  AND NOT EXISTS (
      SELECT 1 FROM conditions c
      WHERE c.SourceTypeOrReferenceId=19 AND c.SourceGroup=0 AND c.SourceEntry=q.ID
  );

INSERT INTO creature
    (guid,id,map,position_x,position_y,position_z,orientation,npcflag)
SELECT s.guid,s.id,0,s.x,s.y,s.z,0,t.npcflag | 1
FROM (
    SELECT 26768800 AS guid,267688 AS id,-5453 AS x,-611 AS y,394.33 AS z
    UNION ALL SELECT 26768700,267687,-5459.5,-592,394.95
    UNION ALL SELECT 26768300,267683,-5459.5,-621,393.67
) s
JOIN creature_template t ON t.entry=s.id
WHERE NOT EXISTS (SELECT 1 FROM creature WHERE id=s.id OR guid=s.guid);

UPDATE creature c JOIN creature_template t ON t.entry=c.id SET c.npcflag=COALESCE(c.npcflag,t.npcflag) | 1 WHERE c.map=0 AND c.id=267684 AND (COALESCE(c.npcflag,t.npcflag) & 1)=0;
