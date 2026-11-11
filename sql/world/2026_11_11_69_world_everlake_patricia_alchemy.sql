-- Wowhead lists two higher ranks and ten additional recipes for open-world Patricia Egan.
-- Preserve the baseline lessons and reuse Ainethil's requirements and fees for the legacy lessons.
-- WowSeer lists the dye fees. Use the skill requirements from Patricia's NPC listing.
INSERT INTO trainer (Id, Type, Greeting, VerifiedBuild)
SELECT 10275322, base.Type, base.Greeting, 0
FROM creature_trainer binding
JOIN creature_template npc ON npc.entry = binding.CreatureID
JOIN trainer base ON base.Id = binding.TrainerID
WHERE binding.CreatureID = 275322 AND binding.TrainerID = 353
  AND binding.MenuID = 0 AND binding.OptionID = 0
  AND EXISTS (SELECT 1 FROM creature WHERE id = npc.entry AND map = 0)
  AND npc.name = 'Patricia Egan' AND (npc.npcflag & 16) <> 0
  AND EXISTS (SELECT 1 FROM trainer_spell WHERE TrainerId = 1004160 AND SpellId = 3101 AND ReqSkillLine = 171 AND ReqSkillRank = 50)
  AND EXISTS (SELECT 1 FROM trainer_spell WHERE TrainerId = 1004160 AND SpellId = 3464 AND ReqSkillLine = 171 AND ReqSkillRank = 125);

INSERT INTO trainer_spell
    (TrainerId, SpellId, MoneyCost, ReqSkillLine, ReqSkillRank, ReqAbility1, ReqAbility2, ReqAbility3, ReqLevel, VerifiedBuild)
SELECT destination.Id, lesson.SpellId, lesson.MoneyCost, lesson.ReqSkillLine, lesson.ReqSkillRank,
    lesson.ReqAbility1, lesson.ReqAbility2, lesson.ReqAbility3, lesson.ReqLevel, lesson.VerifiedBuild
FROM creature_trainer binding
JOIN trainer destination ON destination.Id = 10275322
JOIN trainer_spell lesson ON
    (lesson.TrainerId = 353 AND lesson.SpellId NOT IN (3101, 3448, 3452, 3464, 11448, 11449, 11450, 11451, 12609, 22808))
    OR (lesson.TrainerId = 1004160 AND lesson.SpellId IN (3101, 3448, 3452, 3464, 11448, 11449, 11450, 11451, 12609, 22808))
WHERE binding.CreatureID = 275322 AND binding.TrainerID = 353
  AND binding.MenuID = 0 AND binding.OptionID = 0;

INSERT INTO trainer_spell
    (TrainerId, SpellId, MoneyCost, ReqSkillLine, ReqSkillRank, ReqAbility1, ReqAbility2, ReqAbility3, ReqLevel, VerifiedBuild)
SELECT destination.Id, dye.SpellId, dye.MoneyCost, 171, dye.SkillRank, 0, 0, 0, 0, 0
FROM creature_trainer binding
JOIN trainer destination ON destination.Id = 10275322
CROSS JOIN (
    SELECT 1249631 AS SpellId, 1500 AS MoneyCost, 120 AS SkillRank
    UNION ALL SELECT 1249632, 10000, 215
) dye
WHERE binding.CreatureID = 275322 AND binding.TrainerID = 353
  AND binding.MenuID = 0 AND binding.OptionID = 0;

UPDATE creature_trainer binding
JOIN trainer_spell journeyman ON journeyman.TrainerId = 10275322 AND journeyman.SpellId = 3101
JOIN trainer_spell expert ON expert.TrainerId = 10275322 AND expert.SpellId = 3464
SET binding.TrainerID = 10275322
WHERE binding.CreatureID = 275322 AND binding.TrainerID = 353
  AND binding.MenuID = 0 AND binding.OptionID = 0;
