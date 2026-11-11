-- Questing.wiki names these trainers and lists the dye fees.
-- Skill requirements follow the Forever Alchemy guide.
INSERT INTO trainer_spell
    (TrainerId, SpellId, MoneyCost, ReqSkillLine, ReqSkillRank, ReqAbility1, ReqAbility2, ReqAbility3, ReqLevel, VerifiedBuild)
SELECT b.TrainerID, dye.SpellId, dye.MoneyCost, 171, dye.SkillRank, 0, 0, 0, 0, 0
FROM creature_trainer b
JOIN trainer t ON t.Id = b.TrainerID AND t.Type = 2
CROSS JOIN (
    SELECT 1249631 AS SpellId, 1500 AS MoneyCost, 120 AS SkillRank
    UNION ALL SELECT 1249632, 10000, 220
) dye
WHERE b.CreatureID IN (4160, 3009, 4611, 4609, 2837, 3964, 5499, 2391, 11042, 5177, 3347)
  AND b.TrainerID = 1000000 + b.CreatureID
  AND (dye.SpellId = 1249631 OR b.CreatureID IN (4160, 4611))
  AND NOT EXISTS (SELECT 1 FROM creature_trainer other WHERE other.TrainerID = b.TrainerID AND other.CreatureID <> b.CreatureID)
  AND NOT EXISTS (SELECT 1 FROM trainer_spell existing WHERE existing.TrainerId = b.TrainerID AND existing.SpellId = dye.SpellId);
