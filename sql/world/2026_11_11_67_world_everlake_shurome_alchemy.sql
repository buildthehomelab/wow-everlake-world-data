-- Icy Veins and Wowhead list Master Mycologist Shurome as an Artisan Alchemy trainer.
-- Copy the local Artisan Alchemy lessons and reuse the generic Train me option.
-- Questing.wiki lists Shurome for both dyes. Use the general Forever skill requirements.
INSERT INTO trainer (Id, Type, Greeting, VerifiedBuild)
SELECT 10259585, base.Type, base.Greeting, 0
FROM trainer base
JOIN creature_template c ON c.entry = 259585 AND c.name = 'Master Mycologist Shurome'
WHERE base.Id = 1007948 AND c.npcflag = 3 AND c.ScriptName = ''
  AND NOT EXISTS (SELECT 1 FROM creature_trainer WHERE CreatureID = c.entry)
  AND NOT EXISTS (SELECT 1 FROM creature_template_gossip WHERE CreatureID = c.entry);

INSERT INTO trainer_spell
    (TrainerId, SpellId, MoneyCost, ReqSkillLine, ReqSkillRank, ReqAbility1, ReqAbility2, ReqAbility3, ReqLevel, VerifiedBuild)
SELECT d.Id, s.SpellId, s.MoneyCost, s.ReqSkillLine, s.ReqSkillRank,
    s.ReqAbility1, s.ReqAbility2, s.ReqAbility3, s.ReqLevel, s.VerifiedBuild
FROM trainer d
JOIN trainer_spell s ON s.TrainerId = 1007948 AND s.SpellId NOT IN (1249631, 1249632)
WHERE d.Id = 10259585
  AND NOT EXISTS (SELECT 1 FROM creature_trainer WHERE CreatureID = 259585);

INSERT INTO trainer_spell
    (TrainerId, SpellId, MoneyCost, ReqSkillLine, ReqSkillRank, ReqAbility1, ReqAbility2, ReqAbility3, ReqLevel, VerifiedBuild)
SELECT d.Id, dye.SpellId, dye.MoneyCost, 171, dye.SkillRank, 0, 0, 0, 0, 0
FROM trainer d
CROSS JOIN (
    SELECT 1249631 AS SpellId, 1500 AS MoneyCost, 120 AS SkillRank
    UNION ALL SELECT 1249632, 10000, 220
) dye
WHERE d.Id = 10259585
  AND NOT EXISTS (SELECT 1 FROM creature_trainer WHERE CreatureID = 259585);

INSERT INTO `creature_trainer` (`CreatureID`, `TrainerID`, `MenuID`, `OptionID`)
SELECT c.`entry`, d.Id, b.`MenuID`, b.`OptionID`
FROM `creature_template` c
JOIN `creature_trainer` b ON b.`CreatureID` = 7948 AND b.`MenuID` = 4133 AND b.`OptionID` = 0
JOIN trainer d ON d.Id = 10259585
JOIN `trainer_spell` s ON s.`TrainerId` = d.Id
    AND s.`SpellId` = 11611 AND s.`ReqSkillLine` = 171 AND s.`ReqSkillRank` = 200
JOIN `gossip_menu_option` g ON g.`MenuID` = b.`MenuID` AND g.`OptionID` = b.`OptionID` AND g.`OptionNpc` = 3
WHERE c.`entry` = 259585 AND c.`name` = 'Master Mycologist Shurome'
  AND c.`npcflag` = 3 AND c.`ScriptName` = ''
  AND NOT EXISTS (SELECT 1 FROM `creature_trainer` WHERE `CreatureID` = c.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `creature_template_gossip` WHERE `CreatureID` = c.`entry`);

INSERT INTO `creature_template_gossip` (`CreatureID`, `MenuID`, `VerifiedBuild`)
SELECT c.`entry`, t.`MenuID`, 0
FROM `creature_template` c
JOIN `creature_trainer` t ON t.`CreatureID` = c.`entry`
    AND t.`TrainerID` = 10259585 AND t.`MenuID` = 4133 AND t.`OptionID` = 0
WHERE c.`entry` = 259585 AND c.`name` = 'Master Mycologist Shurome' AND c.`npcflag` = 3
  AND NOT EXISTS (SELECT 1 FROM `creature_template_gossip` WHERE `CreatureID` = c.`entry`);

UPDATE `creature_template` c
JOIN `creature_template_gossip` g ON g.`CreatureID` = c.`entry` AND g.`MenuID` = 4133
JOIN `creature_trainer` t ON t.`CreatureID` = c.`entry`
    AND t.`TrainerID` = 10259585 AND t.`MenuID` = g.`MenuID` AND t.`OptionID` = 0
SET c.`npcflag` = c.`npcflag` | 16
WHERE c.`entry` = 259585 AND c.`name` = 'Master Mycologist Shurome'
  AND c.`npcflag` = 3 AND c.`ScriptName` = '';
