-- Wowhead's Forever Alchemy guide lists Linzy Blackbolt as an Expert trainer.
-- The Forever Guides beta catalog names Linzy in the group for eight advanced recipes.
-- Reuse Ainethil’s local fees and requirements for the additional lessons.
INSERT INTO trainer (Id, Type, Greeting, VerifiedBuild)
SELECT 10246795, base.Type, base.Greeting, 0
FROM creature_trainer binding
JOIN creature_template npc ON npc.entry = binding.CreatureID
JOIN trainer base ON base.Id = binding.TrainerID
WHERE binding.CreatureID = 246795 AND binding.TrainerID = 353
  AND binding.MenuID = 0 AND binding.OptionID = 0
  AND npc.name = 'Linzy Blackbolt' AND (npc.npcflag & 16) <> 0
  AND EXISTS (SELECT 1 FROM trainer_spell WHERE TrainerId = 1004160 AND SpellId = 3101 AND ReqSkillLine = 171 AND ReqSkillRank = 50)
  AND EXISTS (SELECT 1 FROM trainer_spell WHERE TrainerId = 1004160 AND SpellId = 3464 AND ReqSkillLine = 171 AND ReqSkillRank = 125);

INSERT INTO trainer_spell
    (TrainerId, SpellId, MoneyCost, ReqSkillLine, ReqSkillRank, ReqAbility1, ReqAbility2, ReqAbility3, ReqLevel, VerifiedBuild)
SELECT destination.Id, lesson.SpellId, lesson.MoneyCost, lesson.ReqSkillLine, lesson.ReqSkillRank,
    lesson.ReqAbility1, lesson.ReqAbility2, lesson.ReqAbility3, lesson.ReqLevel, lesson.VerifiedBuild
FROM creature_trainer binding
JOIN trainer destination ON destination.Id = 10246795
JOIN trainer_spell lesson ON
    (lesson.TrainerId = 353 AND lesson.SpellId NOT IN (3101, 3448, 3452, 3464, 11448, 11449, 11450, 11451, 12609, 22808))
    OR (lesson.TrainerId = 1004160 AND lesson.SpellId IN (3101, 3448, 3452, 3464, 11448, 11449, 11450, 11451, 12609, 22808))
WHERE binding.CreatureID = 246795 AND binding.TrainerID = 353
  AND binding.MenuID = 0 AND binding.OptionID = 0;

-- Questing.wiki names Linzy as a source for both dyes and lists their fees.
INSERT INTO trainer_spell
    (TrainerId, SpellId, MoneyCost, ReqSkillLine, ReqSkillRank, ReqAbility1, ReqAbility2, ReqAbility3, ReqLevel, VerifiedBuild)
SELECT destination.Id, dye.SpellId, dye.MoneyCost, 171, dye.SkillRank, 0, 0, 0, 0, 0
FROM creature_trainer binding
JOIN trainer destination ON destination.Id = 10246795
CROSS JOIN (
    SELECT 1249631 AS SpellId, 1500 AS MoneyCost, 120 AS SkillRank
    UNION ALL SELECT 1249632, 10000, 220
) dye
WHERE binding.CreatureID = 246795 AND binding.TrainerID = 353
  AND binding.MenuID = 0 AND binding.OptionID = 0;

UPDATE creature_trainer binding
JOIN trainer_spell journeyman ON journeyman.TrainerId = 10246795 AND journeyman.SpellId = 3101
JOIN trainer_spell expert ON expert.TrainerId = 10246795 AND expert.SpellId = 3464
SET binding.TrainerID = 10246795
WHERE binding.CreatureID = 246795 AND binding.TrainerID = 353
  AND binding.MenuID = 0 AND binding.OptionID = 0;
