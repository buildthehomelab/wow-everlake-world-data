-- Correct Nina Surefire's 28 placeholder alchemy recipe costs and reputation gates.
-- Client/core pins: 1.60.1.70862 / 343fe6fb95076e09575156c8b88d155914003b78.
-- GearInsight lists the same Merchant's Favor price for Nina and Apothecary Durelle.
-- https://gearinsight.app/wow/en/forever/professions
-- Individual Wowhead Forever item tooltips corroborate the reputation ranks.
-- Existing Horde rows supply the exact pinned ExtendedCost and PlayerCondition IDs.
-- Update only untouched Alliance placeholder rows with a matching Horde counterpart.
-- Never edit after deployment; use a later correction file. Reapplication changes nothing.

CREATE TEMPORARY TABLE `everlake_alchemy_prices` (
 `item` int unsigned NOT NULL PRIMARY KEY,
 `cost` int unsigned NOT NULL,
 `condition_id` int unsigned NOT NULL
);
INSERT INTO `everlake_alchemy_prices` (`item`,`cost`,`condition_id`) VALUES
(250364,11842,163433),
(250365,11842,163433),
(250367,11840,0),
(250369,11841,163380),
(250371,11841,163380),
(250372,11842,163433),
(250373,11842,163433),
(250374,11842,163433),
(250376,11840,0),
(250377,11841,163380),
(250378,11840,0),
(250379,11842,163433),
(250381,11839,0),
(250383,11841,163380),
(250384,11842,163433),
(250386,11842,163433),
(250387,11843,163433),
(250388,11840,0),
(250978,11840,0),
(250981,11842,163433),
(250984,11840,0),
(250987,11843,163433),
(250990,11840,0),
(250993,11842,163433),
(250994,11842,163433),
(250995,11842,163433),
(250997,11841,163380),
(250998,11842,163433);
UPDATE `npc_vendor` a
JOIN `everlake_alchemy_prices` s ON s.`item` = a.`item`
JOIN `npc_vendor` h ON h.`entry` = 248196 AND h.`item` = a.`item` AND h.`type` = 1
 AND h.`ExtendedCost` = s.`cost` AND h.`PlayerConditionID` = s.`condition_id`
SET a.`ExtendedCost` = s.`cost`, a.`PlayerConditionID` = s.`condition_id`
WHERE a.`entry` = 256729 AND a.`type` = 1 AND a.`slot` = 0
 AND a.`ExtendedCost` = 0 AND a.`PlayerConditionID` = 0
 AND a.`maxcount` = 0 AND a.`incrtime` = 0 AND a.`VerifiedBuild` = 0
 AND a.`IgnoreFiltering` = 0 AND a.`BonusListIDs` IS NULL
 AND EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = 256729 AND t.`name` = 'Nina Surefire' AND (t.`npcflag` & 128) <> 0)
 AND EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = 248196 AND t.`name` = 'Apothecary Durelle' AND (t.`npcflag` & 128) <> 0)
 AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = 256729 AND c.`map` = 0)
 AND EXISTS (SELECT 1 FROM `creature` c WHERE c.`id` = 248196 AND c.`map` = 1);
DROP TEMPORARY TABLE `everlake_alchemy_prices`;
