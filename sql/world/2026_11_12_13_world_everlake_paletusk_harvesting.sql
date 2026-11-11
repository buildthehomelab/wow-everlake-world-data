-- EG Link 9fcae73cc7, Forever build 70862, quest 95162.
-- Starter corroborated by https://ahledger.com/wow-forever/quests/95162-paletusk-harvesting
START TRANSACTION;
SET @add_paletusk := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95162)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE ID=470094 OR QuestID=95162)
    AND EXISTS (SELECT 1 FROM creature WHERE id=256728 AND map=0)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,
     RewardItem1,RewardAmount1,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95162,2,16591,3145736,0xaa2aaaaa4e0ab3b2+0,5,1,274977,1,
       'Paletusk Harvesting','Gather $1oa Chunks of Boar Meat for Na''zok near Bolder''ok.','With so little land not claimed by the humans or Twilight''s Hammer, this ranch is one of our very few sources of food. Ogres aren''t much in the way of farmers, but they love a good paletusk roast, and have agreed to let me stay so long as the meat keeps coming.\r\n\r\nAs our war advances, the demand for food is only ever increasing. Now I hardly have enough food to keep these ogres from looking at me like I''m their next meal.\r\n\r\nIf we want to have enough meat for Rog''mar, I''ll need your help with the harvest.',70862
WHERE @add_paletusk;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 470094,95162,1,0,0,769,10,70862 WHERE @add_paletusk;
INSERT INTO creature_queststarter (id,quest)
SELECT 256728,95162 WHERE @add_paletusk
AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE id=256728 AND quest=95162);
INSERT INTO creature_questender (id,quest)
SELECT 256728,95162 WHERE @add_paletusk
AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE id=256728 AND quest=95162);
COMMIT;
