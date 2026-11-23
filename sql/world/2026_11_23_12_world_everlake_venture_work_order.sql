-- Venture Co. Work Order (210187, for Goblin Lockpicks 78270): from the pockets of three Venture Co. types, as on live.
-- 2026_11_23_12_world_everlake_venture_work_order.sql: written by hand.
--
-- On the realm only the Venture Co. Deforester (3991) has it in its pockets, at 100%. Wowhead's Forever pages show
-- it picked from three types at about the same rate: Venture Co. Operator (3988) 5.21% and 4.47% in its two
-- snapshots, Venture Co. Logger (3989) 5.79% and 5.59%, Deforester 5.78% and 5.59%. Each gets the mean of its two.
-- The rows stay quest items (QuestRequired), so only a rogue on Goblin Lockpicks finds one, as the realm's row
-- already had it. Wowhead counts over all picked pockets, those of rogues without the quest included, so the chance
-- for a rogue on the quest is likely higher than this; nothing records by how much.
-- The rare kill drops of the same creatures are left as they are: they match live.
--
-- Source: Wowhead's Forever database through the ForeverTracker's page cache (pickpocketing counts only).
-- Adds a row only where the creature's pockets have none for the item, and lowers the Deforester's only while it is
-- still 100. Each added row is recorded in everlake_import_rows. Running it again changes nothing. Never edit this
-- file once it is deployed: a later fix is a new file.

SET @EVERLAKE_FILE := '2026_11_23_12_world_everlake_venture_work_order.sql';

START TRANSACTION;

UPDATE `pickpocketing_loot_template` SET `Chance` = 5.685
WHERE `Entry` = 3991 AND `ItemType` = 0 AND `Item` = 210187 AND `Chance` = 100;

DROP TEMPORARY TABLE IF EXISTS `everlake_work_order`;
CREATE TEMPORARY TABLE `everlake_work_order` AS
SELECT s.`entry`, s.`chance`, s.`name` FROM (
  SELECT 3988 AS `entry`, 4.84 AS `chance`, 'Venture Co. Operator' AS `name` UNION ALL
  SELECT 3989, 5.69, 'Venture Co. Logger'
) s
WHERE EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`PickPocketLootID` = s.`entry`)
  AND NOT EXISTS (SELECT 1 FROM `pickpocketing_loot_template` p WHERE p.`Entry` = s.`entry` AND p.`Item` = 210187);

INSERT INTO `pickpocketing_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT w.`entry`, 0, 210187, w.`chance`, 1, 1, 0, 1, 1, CONCAT(w.`name`, ': Venture Co. Work Order (Goblin Lockpicks)') FROM `everlake_work_order` w;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pickpocketing_loot_template', w.`entry`, 0, 210187, 0, @EVERLAKE_FILE, 'wowhead forever pickpocketing, mean of two snapshots' FROM `everlake_work_order` w;

DROP TEMPORARY TABLE IF EXISTS `everlake_work_order`;

COMMIT;
