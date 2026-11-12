-- Icy Veins Forever training observations for Walton and pinned 70790 teaching effects.
START TRANSACTION;
SET @add_walton := NOT EXISTS (SELECT 1 FROM trainer WHERE Id=261366)
 AND NOT EXISTS (SELECT 1 FROM trainer_spell WHERE TrainerId=261366)
 AND NOT EXISTS (SELECT 1 FROM creature_trainer WHERE CreatureID=261366 OR TrainerID=261366)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id
             WHERE c.id=261366 AND t.name='Walton' AND (COALESCE(c.npcflag,t.npcflag)&16)<>0);
INSERT INTO trainer (Id,Type,Greeting,VerifiedBuild)
SELECT 261366,3,'',70790 WHERE @add_walton;
INSERT INTO trainer_spell (TrainerId,SpellId,MoneyCost,ReqLevel,VerifiedBuild)
SELECT 261366,17254,0,1,70790 WHERE @add_walton
UNION ALL SELECT 261366,7370,0,1,70790 WHERE @add_walton
UNION ALL SELECT 261366,2980,0,1,70790 WHERE @add_walton
UNION ALL SELECT 261366,4195,5,1,70790 WHERE @add_walton
UNION ALL SELECT 261366,1853,0,1,70790 WHERE @add_walton
UNION ALL SELECT 261366,24547,1,1,70790 WHERE @add_walton
UNION ALL SELECT 261366,1747,0,5,70790 WHERE @add_walton
UNION ALL SELECT 261366,17262,0,8,70790 WHERE @add_walton
UNION ALL SELECT 261366,2981,0,8,70790 WHERE @add_walton
UNION ALL SELECT 261366,24609,0,10,70790 WHERE @add_walton
UNION ALL SELECT 261366,14922,0,10,70790 WHERE @add_walton
UNION ALL SELECT 261366,4196,0,12,70790 WHERE @add_walton
UNION ALL SELECT 261366,24556,0,12,70790 WHERE @add_walton
UNION ALL SELECT 261366,1264727,0,12,70790 WHERE @add_walton
UNION ALL SELECT 261366,4197,0,18,70790 WHERE @add_walton
UNION ALL SELECT 261366,24557,0,18,70790 WHERE @add_walton
UNION ALL SELECT 261366,24495,0,20,70790 WHERE @add_walton
UNION ALL SELECT 261366,24440,0,20,70790 WHERE @add_walton
UNION ALL SELECT 261366,24475,0,20,70790 WHERE @add_walton
UNION ALL SELECT 261366,14923,0,20,70790 WHERE @add_walton
UNION ALL SELECT 261366,24494,0,20,70790 WHERE @add_walton
UNION ALL SELECT 261366,24490,0,20,70790 WHERE @add_walton
UNION ALL SELECT 261366,1750,0,35,70790 WHERE @add_walton;
INSERT INTO creature_trainer (CreatureID,TrainerID,MenuID,OptionID)
SELECT 261366,261366,0,0 WHERE @add_walton;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'trainer',261366,0,'2026_11_12_211_world_everlake_walton_pet_trainer.sql','Icy Veins Forever trainer capture' WHERE @add_walton
UNION ALL SELECT 'creature_trainer',261366,0,'2026_11_12_211_world_everlake_walton_pet_trainer.sql','Icy Veins Forever trainer capture' WHERE @add_walton
UNION ALL SELECT 'trainer_spell',TrainerId,SpellId,'2026_11_12_211_world_everlake_walton_pet_trainer.sql','Icy Veins Forever and pinned SpellEffect 70790'
 FROM trainer_spell WHERE TrainerId=261366 AND @add_walton;
COMMIT;
