-- Disposable playtest. Verify mounted reward eligibility and NPC interaction in-game.
SET @add_riding_97017 := (NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=97017) AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=97017 OR ID IN (474758,474759,474760)) AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=97017) AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=97017));
INSERT INTO quest_template (ID,QuestType,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,RewardChoiceItemID1,RewardChoiceItemQuantity1,RewardChoiceItemID2,RewardChoiceItemQuantity2,RewardChoiceItemID3,RewardChoiceItemQuantity3,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 97017,2,1048576,4,3,1,47,2500,5872,1,5864,1,5873,1,'Your First Riding Ram','Inspect the riding rams to choose your first mount.','Ah, it''s a big day fer ya I see; here for yer first ram are ye?\n\nThese rams are the most steadfast and sturdy in all of Azeroth. They''re fiercely protective of their rider. Aye, you''ll have a hard time finding a more stalwart companion for yer journeys.\n\nSo, you have an important choice to make. You and yer ram will traverse the world together so choose wisely! Not to worry lad, whatever choice you make will be the right one.\n\nGo see the rams and return to me when you''ve made yer choice.',0 WHERE @add_riding_97017;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 97017,40,40,0 WHERE @add_riding_97017;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 97017,2,40 WHERE @add_riding_97017;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474758,97017,3,0,4,267474,1,32,0,'White Ram',0 WHERE @add_riding_97017;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474759,97017,3,1,5,267473,1,32,0,'Brown Ram',0 WHERE @add_riding_97017;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474760,97017,3,2,6,267475,1,32,0,'Gray Ram',0 WHERE @add_riding_97017;
INSERT INTO creature_queststarter (id,quest,VerifiedBuild) SELECT 1261,97017,0 WHERE @add_riding_97017;
INSERT INTO creature_questender (id,quest,VerifiedBuild) SELECT 1261,97017,0 WHERE @add_riding_97017;
SET @add_riding_97045 := (NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=97045) AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=97045 OR ID IN (474885,474886,474887)) AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=97045) AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=97045));
INSERT INTO quest_template (ID,QuestType,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,RewardChoiceItemID1,RewardChoiceItemQuantity1,RewardChoiceItemID2,RewardChoiceItemQuantity2,RewardChoiceItemID3,RewardChoiceItemQuantity3,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 97045,2,1048576,1,0,1,72,2500,5656,1,5655,1,2414,1,'Your First Horse','Inspect the riding horses to choose your first mount.','Greetings! Are you here to examine our horses?\n\nThese steeds are descendants from both the historical Lordaeron stock and our own local horses. You won''t find a more steadfast companion for your journeys.\n\nChoosing one may be difficult as they are all excellent and trained to be steady even when in danger. Don''t forget, you and your horse will traverse the world together. I''m sure whatever choice you make will suit you best.\n\nGo examine the horses and return to me when you have made your choice.',0 WHERE @add_riding_97045;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 97045,40,40,0 WHERE @add_riding_97045;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 97045,2,40 WHERE @add_riding_97045;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474885,97045,3,0,0,267678,1,32,0,'Pinto Horse',0 WHERE @add_riding_97045;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474886,97045,3,1,1,267674,1,32,0,'Brown Horse',0 WHERE @add_riding_97045;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Flags,Flags2,Description,VerifiedBuild) SELECT 474887,97045,3,2,2,267677,1,32,0,'Chestnut Mare',0 WHERE @add_riding_97045;
INSERT INTO creature_queststarter (id,quest,VerifiedBuild) SELECT 384,97045,0 WHERE @add_riding_97045;
INSERT INTO creature_questender (id,quest,VerifiedBuild) SELECT 384,97045,0 WHERE @add_riding_97045;
UPDATE creature c JOIN creature_template t ON t.entry=c.id SET c.npcflag=COALESCE(c.npcflag,t.npcflag) | 1 WHERE c.map=0 AND c.id IN (267674,267678) AND (COALESCE(c.npcflag,t.npcflag) & 1)=0;

-- Match the existing first-mount quests and the documented Apprentice Riding prerequisite.
INSERT INTO conditions
    (SourceTypeOrReferenceId,SourceGroup,SourceEntry,ElseGroup,ConditionTypeOrReference,
     ConditionTarget,ConditionValue1,ConditionValue2,Comment)
SELECT 19,0,q.ID,0,7,0,762,75,'First mount quest requires Apprentice Riding'
FROM quest_template q
WHERE q.ID IN (97017,97045)
  AND NOT EXISTS (
      SELECT 1 FROM conditions c
      WHERE c.SourceTypeOrReferenceId=19 AND c.SourceGroup=0 AND c.SourceEntry=q.ID
  );
