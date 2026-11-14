-- Efficient Games build 70862, CC BY 4.0 (https://efficient.games).
-- Quest 95428 names Krom'rosh and points to 94744. Icy Veins NPC 258570 lists the turn-in.
START TRANSACTION;
SET @add_wayward := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94744)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=94744)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=94744)
 AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=94744)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=94744)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94744)
 AND EXISTS (SELECT 1 FROM quest_template WHERE ID=95428 AND RewardNextQuest IN (0,94744))
 AND EXISTS (SELECT 1 FROM creature_questender WHERE quest=95428 AND id=256418)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (256418,258570) AND c.map=0 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)=2;
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,
     LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 94744,2,16591,36700168,12261800583900083122,1,1,
    'The Wayward Warrior','Find Da''grosh in the hills west of Rog''mar.','You did well slowing the Twilight''s Hammer. Their foothold in Sunnyglade has weakened and you''ve turned their ogre warriors against them. Now we take the fight to them.

My brother, Dag''rosh, has already gone ahead with a scouting party. I would have preferred he waited for you, but he is impulsive and overeager--like a true warrior. I''d be honored if you joined him in battle at their stronghold to the west.',70862
WHERE @add_wayward;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel)
SELECT 94744,43,38,0 WHERE @add_wayward;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel)
SELECT 94744,2,43 WHERE @add_wayward;
INSERT INTO quest_template_addon (ID,PrevQuestID)
SELECT 94744,95428 WHERE @add_wayward;
INSERT INTO creature_queststarter (id,quest) SELECT 256418,94744 WHERE @add_wayward;
INSERT INTO creature_questender (id,quest) SELECT 258570,94744 WHERE @add_wayward;
UPDATE quest_template SET RewardNextQuest=94744
WHERE ID=95428 AND RewardNextQuest=0 AND @add_wayward;
COMMIT;
