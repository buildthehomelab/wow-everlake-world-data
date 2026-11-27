-- Craftsman's Writs and the Commerce Authority / Supply & Logistics camps: gaps found against live.
-- 2026_11_27_40_world_everlake_writs_commerce_fixes.sql: written by hand.
--
-- Checked on 2026-11-27 against Wowhead's Forever guides "Craftsman's Writs: Recipes, Rewards & Routes" and
-- "Azeroth Commerce Authority Guide" (both updated 2026-11-26) and their player comments, and the client's
-- ItemSparse / ItemExtendedCost tables. What this file changes:
--
-- 1. Writ kept on accept. 17 Artisan writ quests added after 2026_11_21_104 (94321, 94325, 94330-94332, 94337-94339,
--    94342-94345, 94349, 94351, 94352, 94357, 94359) still have StartItem 0, so the core destroys the writ the moment
--    the quest is accepted (see 2026_11_21_104 for the cause). Same rule as that file: StartItem = the quest's own
--    first item objective.
-- 2. Coin Pouch reward. Every writ pays a Coin Pouch on live (guide: "These reward reputation ... and a Coin Pouch";
--    players report a pouch from Artisan writs such as Runic Leather Headband). 26 Artisan writ quests reward
--    nothing: Wowhead's quest rows list no reward for them, so the export wrote none. They get the Artisan pouch
--    284586 like the other 19 Artisan writs; by tier the pouch is 284584 (75 rep), 284585 (125), 284586 (200).
-- 3. Coin Pouch money. The three pouches (ItemSparse flag HAS_LOOT) had no money and no loot rows, so they opened
--    empty. Money from player reports (INFERRED range around them): Journeyman 30s 1c, about 35s on average;
--    Expert 50s 29c, 51s 82c, 54s 70c, 81s 38c, 84s 94c, 85s 45c, about 88s, about 75s on average; Artisan 1g 44s 80c,
--    about 1g 88s, about 1g 52s on average. Ranges: 25s-45s, 50s-90s, 1g 40s-1g 90s.
-- 4. Writ drops. 2026_11_19_982 made the three tier drop lists (9500001-9500003) from the 94 writ quests of that day;
--    writs added before and after it never joined them, so 43 writs could not drop. Every writ quest that has a
--    turn-in NPC or object joins its tier's list (75 / 125 / 200 reputation). The 9 writs that nobody records a
--    turn-in for (live included) stay out: a writ that cannot be handed in should not drop.
-- 5. Archmage Xylem (8379) offered the Potion of Demonslaying writ quest 94316 himself; writ quests start only from
--    their writ (live quest pages give no starter). His starter row goes.
-- 6. Camp vendor prices (ItemExtendedCost from the client, every one is "this much Merchant's Favor", currency 3402):
--    the Forged Delivery Receipt 262902 cost nothing at Kurvelk Shadowhoof (256672) and Dianne Softstep (256742);
--    live: 15 Favor (11047 / 11048). Gishah (256384), the Horde side of Tamelyn Aldridge, sold the tabard 262764,
--    the Advertising License 270887 and the Packmule Treat 284664 for nothing; live and Tamelyn: 200 (11041),
--    1,200 (11517) and 1,500 (11879).
-- 7. Recipe: Disorienting Smog Potion 250996 (skill 180, 120 Favor) was missing from both Alchemy camp vendors, Nina
--    Surefire (256729) and Apothecary Durelle (248196). Added as their other 120-Favor recipes are (11841, condition
--    163380).
--
-- Not here: the Forged Delivery Receipt's +50 reputation (spell 1269600 is a dummy effect: core work), the rare and
-- Elite sealed crates' hand-ins and the 9 writs' turn-in NPCs (no source records them).
--
-- Corrections change a row only while it is as written against; added rows go in the ledger. Never edit this file
-- once it is deployed: a later fix is a new file. Running it again changes nothing. Not tried in game.

CREATE TABLE IF NOT EXISTS `everlake_import_rows` (
  `tbl` varchar(64) NOT NULL COMMENT 'world table of the row',
  `k1` bigint NOT NULL COMMENT 'the row''s key, in the table''s primary key order',
  `k2` bigint NOT NULL DEFAULT '0',
  `k3` bigint NOT NULL DEFAULT '0',
  `k4` bigint NOT NULL DEFAULT '0',
  `file` varchar(200) NOT NULL COMMENT 'the update file that added the row',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT 'the sources that gave it',
  PRIMARY KEY (`tbl`, `k1`, `k2`, `k3`, `k4`),
  KEY `file` (`file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added (docs/forever-import.md)';

START TRANSACTION;

-- 1. the writ is the quest's StartItem
UPDATE `quest_template` q
JOIN (
    SELECT o.`QuestID`, MIN(o.`ObjectID`) AS `writ`
    FROM `quest_objectives` o
    WHERE o.`Type` = 1 AND o.`Order` = 0 AND o.`Amount` = 1 AND (o.`Flags` & 0x20) <> 0
    GROUP BY o.`QuestID`
    HAVING COUNT(*) = 1
) w ON w.`QuestID` = q.`ID`
SET q.`StartItem` = w.`writ`
WHERE q.`StartItem` = 0
  AND q.`LogTitle` LIKE 'Craftsman''s Writ:%'
  AND (q.`Flags` & 0x8) = 0;

-- 2. the tier's Coin Pouch, where a writ quest rewards no item at all
UPDATE `quest_template` q
SET q.`RewardItem1` = CASE q.`RewardFactionOverride1` WHEN 7500 THEN 284584 WHEN 12500 THEN 284585 ELSE 284586 END,
    q.`RewardAmount1` = 1
WHERE q.`LogTitle` LIKE 'Craftsman''s Writ:%'
  AND q.`RewardFactionID1` IN (2586, 2587)
  AND q.`RewardFactionOverride1` IN (7500, 12500, 20000)
  AND q.`RewardItem1` = 0 AND q.`RewardItem2` = 0 AND q.`RewardItem3` = 0 AND q.`RewardItem4` = 0
  AND q.`RewardChoiceItemID1` = 0;

-- 3. money in the Coin Pouches (copper)
DROP TEMPORARY TABLE IF EXISTS `everlake_pouch`;
CREATE TEMPORARY TABLE `everlake_pouch` (`Id` int unsigned NOT NULL, `lo` int unsigned NOT NULL, `hi` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`Id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_pouch` (`Id`, `lo`, `hi`, `note`) VALUES
(284584, 2500, 4500, 'Coin Pouch (Journeyman writ): player reports ~30-35s, range INFERRED'),
(284585, 5000, 9000, 'Coin Pouch (Expert writ): player reports 50s-88s, range INFERRED'),
(284586, 14000, 19000, 'Coin Pouch (Artisan writ): player reports 1g44s-1g88s, range INFERRED');
UPDATE `everlake_pouch` s SET s.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `item_template_addon` a WHERE a.`Id` = s.`Id`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'item_template_addon' AND r.`k1` = s.`Id`);
INSERT INTO `item_template_addon` (`Id`, `FlagsCu`, `FoodType`, `MinMoneyLoot`, `MaxMoneyLoot`, `SpellPPMChance`, `RandomBonusListTemplateId`, `QuestLogItemId`)
SELECT s.`Id`, 0, 0, s.`lo`, s.`hi`, 0, 0, 0 FROM `everlake_pouch` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `file`, `note`)
SELECT 'item_template_addon', s.`Id`, '2026_11_27_40_world_everlake_writs_commerce_fixes.sql', LEFT(s.`note`, 255) FROM `everlake_pouch` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_pouch`;

-- 4. every writ that can be handed in drops from its tier's list
DROP TEMPORARY TABLE IF EXISTS `everlake_writ_ref`;
CREATE TEMPORARY TABLE `everlake_writ_ref` (`Entry` int unsigned NOT NULL, `Item` int unsigned NOT NULL, `note` varchar(255) NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`Entry`, `Item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT IGNORE INTO `everlake_writ_ref` (`Entry`, `Item`, `note`)
SELECT CASE q.`RewardFactionOverride1` WHEN 7500 THEN 9500001 WHEN 12500 THEN 9500002 ELSE 9500003 END,
       q.`StartItem`,
       CONCAT(CASE q.`RewardFactionOverride1` WHEN 7500 THEN 'Journeyman' WHEN 12500 THEN 'Expert' ELSE 'Artisan' END, ': ', q.`LogTitle`, ' (quest ', q.`ID`, ')')
FROM `quest_template` q
WHERE q.`LogTitle` LIKE 'Craftsman''s Writ:%'
  AND q.`StartItem` > 0
  AND q.`RewardFactionOverride1` IN (7500, 12500, 20000)
  AND (EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.`quest` = q.`ID`)
       OR EXISTS (SELECT 1 FROM `gameobject_questender` e WHERE e.`quest` = q.`ID`))
  AND EXISTS (SELECT 1 FROM `reference_loot_template` r WHERE r.`Entry` IN (9500001, 9500002, 9500003));
UPDATE `everlake_writ_ref` s SET s.`missing` = 1
WHERE NOT EXISTS (SELECT 1 FROM `reference_loot_template` t WHERE t.`Entry` IN (9500001, 9500002, 9500003) AND t.`ItemType` = 0 AND t.`Item` = s.`Item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'reference_loot_template' AND r.`k1` = s.`Entry` AND r.`k2` = 0 AND r.`k3` = s.`Item`);
INSERT INTO `reference_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`Entry`, 0, s.`Item`, 0, 0, 1, 1, 1, 1, LEFT(s.`note`, 255) FROM `everlake_writ_ref` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'reference_loot_template', s.`Entry`, 0, s.`Item`, '2026_11_27_40_world_everlake_writs_commerce_fixes.sql', 'Wowhead Forever writ guide (tier); drop list INFERRED as 2026_11_19_982' FROM `everlake_writ_ref` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_writ_ref`;

-- 5. writ quests start from their writ only
DELETE FROM `creature_queststarter` WHERE `id` = 8379 AND `quest` = 94316;

-- 6. camp vendor prices in Merchant's Favor
UPDATE `npc_vendor` SET `ExtendedCost` = 11047 WHERE `entry` = 256742 AND `item` = 262902 AND `type` = 1 AND `ExtendedCost` = 0;
UPDATE `npc_vendor` SET `ExtendedCost` = 11048 WHERE `entry` = 256672 AND `item` = 262902 AND `type` = 1 AND `ExtendedCost` = 0;
UPDATE `npc_vendor` SET `ExtendedCost` = 11041 WHERE `entry` = 256384 AND `item` = 262764 AND `type` = 1 AND `ExtendedCost` = 0;
UPDATE `npc_vendor` SET `ExtendedCost` = 11517 WHERE `entry` = 256384 AND `item` = 270887 AND `type` = 1 AND `ExtendedCost` = 0;
UPDATE `npc_vendor` SET `ExtendedCost` = 11879 WHERE `entry` = 256384 AND `item` = 284664 AND `type` = 1 AND `ExtendedCost` = 0;

-- 7. Recipe: Disorienting Smog Potion at both Alchemy camp vendors
DROP TEMPORARY TABLE IF EXISTS `everlake_vendor_add`;
CREATE TEMPORARY TABLE `everlake_vendor_add` (`entry` int unsigned NOT NULL, `item` int NOT NULL, `missing` tinyint NOT NULL DEFAULT 0, PRIMARY KEY (`entry`, `item`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `everlake_vendor_add` (`entry`, `item`) VALUES (256729, 250996), (248196, 250996);
UPDATE `everlake_vendor_add` s SET s.`missing` = 1
WHERE EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = s.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `npc_vendor` v WHERE v.`entry` = s.`entry` AND v.`item` = s.`item`)
  AND NOT EXISTS (SELECT 1 FROM `everlake_import_rows` r WHERE r.`tbl` = 'npc_vendor' AND r.`k1` = s.`entry` AND r.`k2` = s.`item`);
INSERT INTO `npc_vendor` (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `BonusListIDs`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`)
SELECT s.`entry`, 0, s.`item`, 0, 0, 11841, 1, '', 163380, 0, 0 FROM `everlake_vendor_add` s WHERE s.`missing` = 1;
INSERT INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `file`, `note`)
SELECT 'npc_vendor', s.`entry`, s.`item`, 11841, '2026_11_27_40_world_everlake_writs_commerce_fixes.sql', 'Wowhead Forever ACA guide (sold, 120 Favor); cost + condition as the vendor''s other 120-Favor recipes' FROM `everlake_vendor_add` s WHERE s.`missing` = 1;
DROP TEMPORARY TABLE `everlake_vendor_add`;

COMMIT;
