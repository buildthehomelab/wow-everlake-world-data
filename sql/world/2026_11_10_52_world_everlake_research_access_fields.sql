-- Align Research Access activation fields with captured Forever 70862 data.
-- EG Link 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae, CC BY 4.0.
-- Source: data/wowf/1.60.1.70862/quests.enUS.json quest97286.
-- Preserve the Mage class restriction and all 40 existing OR book prerequisites.
-- Flags35651840=0x02200100: NO_MONEY_FOR_XP, PLAYER_CAST_COMPLETE,
-- REMOVE_SURPLUS_ITEMS. Do not interpret them as a hidden-quest marker.
-- Requires the captured Study reward already restored by the teaching-reward slice.
-- Change only the exact local baseline. Explicit overrides and upstream fixes remain.
-- Never edit after deployment; use a later correction file. Safe to replay.
SET SESSION autocommit = 0;
CREATE TEMPORARY TABLE `everlake_research_access_ready` (`ok` int NOT NULL PRIMARY KEY);
INSERT INTO `everlake_research_access_ready` (`ok`) SELECT 1
WHERE EXISTS (SELECT 1 FROM `quest_template` WHERE `ID`=97286 AND `LogTitle`='Research Access'
 AND `QuestType`=2 AND `Flags`=0 AND `AllowableRaces`=12884902143 AND `RewardSpell`=1302696)
AND EXISTS (SELECT 1 FROM `quest_template_addon` WHERE `ID`=97286 AND `AllowableClasses`=128)
AND EXISTS (SELECT 1 FROM `quest_classic_level` WHERE `ID`=97286 AND `QuestLevel`=20 AND `MinLevel`=20 AND `MaxLevel`=0)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` WHERE `QuestID`=97286)
AND (SELECT COUNT(*) FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry`=97286)=40
AND (SELECT COUNT(DISTINCT `ElseGroup`) FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry`=97286
 AND `ConditionTypeOrReference`=8 AND `NegativeCondition`=0)=40
AND EXISTS (SELECT 1 FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry`=97286
 AND `ConditionTypeOrReference`=8 AND `ConditionValue1`=79096 AND `NegativeCondition`=0)
AND EXISTS (SELECT 1 FROM `conditions` WHERE `SourceTypeOrReferenceId`=19 AND `SourceEntry`=97286
 AND `ConditionTypeOrReference`=8 AND `ConditionValue1`=78143 AND `NegativeCondition`=0);
UPDATE `quest_template` SET `QuestType`=0,`Flags`=35651840,`AllowableRaces`=18446744073709551615
WHERE `ID`=97286 AND EXISTS (SELECT 1 FROM `everlake_research_access_ready` WHERE `ok`=1);
UPDATE `quest_classic_level` SET `MinLevel`=1
WHERE `ID`=97286 AND EXISTS (SELECT 1 FROM `everlake_research_access_ready` WHERE `ok`=1);
DROP TEMPORARY TABLE `everlake_research_access_ready`;
SET SESSION autocommit = 1;
