-- Icy Veins and Wowhead list Kaylaena Springwhisper as an Artisan Engineering trainer.
-- Reuse the local neutral Artisan Engineering trainer and its generic Train me option.
INSERT INTO `creature_trainer` (`CreatureID`, `TrainerID`, `MenuID`, `OptionID`)
SELECT c.`entry`, b.`TrainerID`, b.`MenuID`, b.`OptionID`
FROM `creature_template` c
JOIN `creature_trainer` b ON b.`CreatureID` = 8736 AND b.`MenuID` = 4152 AND b.`OptionID` = 0
JOIN `trainer_spell` s ON s.`TrainerId` = b.`TrainerID`
    AND s.`SpellId` = 12656 AND s.`ReqSkillLine` = 202 AND s.`ReqSkillRank` = 200
JOIN `gossip_menu_option` g ON g.`MenuID` = b.`MenuID` AND g.`OptionID` = b.`OptionID` AND g.`OptionNpc` = 3
WHERE c.`entry` = 249235 AND c.`name` = 'Kaylaena Springwhisper'
  AND c.`npcflag` = 1 AND c.`ScriptName` = ''
  AND NOT EXISTS (SELECT 1 FROM `creature_trainer` WHERE `CreatureID` = c.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `creature_template_gossip` WHERE `CreatureID` = c.`entry`);

INSERT INTO `creature_template_gossip` (`CreatureID`, `MenuID`, `VerifiedBuild`)
SELECT c.`entry`, t.`MenuID`, 0
FROM `creature_template` c
JOIN `creature_trainer` t ON t.`CreatureID` = c.`entry`
    AND t.`TrainerID` = 1008736 AND t.`MenuID` = 4152 AND t.`OptionID` = 0
WHERE c.`entry` = 249235 AND c.`name` = 'Kaylaena Springwhisper' AND c.`npcflag` = 1
  AND NOT EXISTS (SELECT 1 FROM `creature_template_gossip` WHERE `CreatureID` = c.`entry`);

UPDATE `creature_template` c
JOIN `creature_template_gossip` g ON g.`CreatureID` = c.`entry` AND g.`MenuID` = 4152
JOIN `creature_trainer` t ON t.`CreatureID` = c.`entry`
    AND t.`TrainerID` = 1008736 AND t.`MenuID` = g.`MenuID` AND t.`OptionID` = 0
SET c.`npcflag` = c.`npcflag` | 16
WHERE c.`entry` = 249235 AND c.`name` = 'Kaylaena Springwhisper'
  AND c.`npcflag` = 1 AND c.`ScriptName` = '';
