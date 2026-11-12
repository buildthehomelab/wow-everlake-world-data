-- Wowhead Forever lists Engineering 120 and a fee displayed as 5.
-- https://www.wowhead.com/forever/spell=1249634/sandpaper
-- The structured tooltip omits the fee. Use 500 copper as an estimate based on
-- neighboring trainer lessons at ranks 120–130 (270–495 copper for recipes).
INSERT INTO trainer_spell (TrainerId,SpellId,MoneyCost,ReqSkillLine,ReqSkillRank,ReqLevel)
SELECT DISTINCT t.TrainerID,1249634,500,202,120,0
FROM creature_trainer t
JOIN trainer_spell anchor ON anchor.TrainerId=t.TrainerID
  AND anchor.SpellId=3941 AND anchor.ReqSkillLine=202 AND anchor.ReqSkillRank=120
WHERE (t.CreatureID,t.TrainerID) IN ((5174,1005174),(8736,1008736),(11017,1011017),(249235,1008736))
  AND EXISTS (SELECT 1 FROM creature WHERE id=t.CreatureID)
  AND NOT EXISTS (SELECT 1 FROM trainer_spell WHERE TrainerId=t.TrainerID AND SpellId=1249634);
