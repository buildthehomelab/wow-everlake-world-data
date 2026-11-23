-- Scarlet Scryer (4293, Scarlet Monastery graveyard): the pockets live Forever's rogues pick.
-- 2026_11_23_07_world_everlake_scarlet_scryer_pickpocket.sql: written from public data by a script, checked by hand.
--
-- On the realm a Scarlet Scryer's pockets hold only the Scryer's Key. On live they hold what the Scarlet Torturer
-- beside it holds: Wowhead's Forever page counts a Battered Junkbox in 318 of 534 picked pockets, then a Small Pocket
-- Watch, food, drink, a potion and two gems. Icy Veins' players recorded the same eight items on it.
--   * items: the eight Wowhead lists, the rare two included (the owner's rule of 2026-11-19 for rare drops).
--   * chances: Wowhead counts over pockets that held something, which runs higher than the realm's chances per
--     attempt: for the Scarlet Torturer (4306) Wowhead has the junkbox in 908 of 1,643 (55.26%) where the realm has
--     19.8218%. Each Scryer count is brought to the realm's measure by that same ratio (0.3587), so both
--     creatures of the room give alike.
-- The other graveyard humanoids already give the Battered Junkbox (Scarlet Torturer, Scarlet Sentry, Suffering
-- Victim) and Interrogator Vishas the Worn one, as on live: nothing changes for them.
--
-- Sources: Wowhead's Forever database through the ForeverTracker's page cache (items and counts only); Icy Veins as
-- second witness.
-- Adds a row only where the Scryer's pockets have none for that item. Each added row is recorded in
-- everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file. Running it again changes
-- nothing.

SET @EVERLAKE_FILE := '2026_11_23_07_world_everlake_scarlet_scryer_pickpocket.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_scryer_pockets`;
CREATE TEMPORARY TABLE `everlake_scryer_pockets` AS
SELECT s.`item`, s.`chance` FROM (
  SELECT 16882 AS `item`, 21.359 AS `chance`  -- Battered Junkbox: 318 of 534 UNION ALL
  SELECT 5374 AS `item`, 9.269 AS `chance`  -- Small Pocket Watch: 138 of 534 UNION ALL
  SELECT 929 AS `item`, 3.1568 AS `chance`  -- Healing Potion: 47 of 534 UNION ALL
  SELECT 4542 AS `item`, 2.3508 AS `chance`  -- Moist Cornbread: 35 of 534 UNION ALL
  SELECT 4538 AS `item`, 2.2837 AS `chance`  -- Snapvine Watermelon: 34 of 534 UNION ALL
  SELECT 422 AS `item`, 2.0822 AS `chance`  -- Dwarven Mild: 31 of 534 UNION ALL
  SELECT 1705 AS `item`, 0.403 AS `chance`  -- Lesser Moonstone: 6 of 534 UNION ALL
  SELECT 1206 AS `item`, 0.2015 AS `chance`  -- Moss Agate: 3 of 534
) s
WHERE (SELECT COUNT(*) FROM `creature_template_difficulty` d WHERE d.`Entry` = 4293 AND d.`PickPocketLootID` = 4293) > 0
  AND NOT EXISTS (SELECT 1 FROM `pickpocketing_loot_template` p WHERE p.`Entry` = 4293 AND p.`Item` = s.`item`);

INSERT INTO `pickpocketing_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 4293, 0, t.`item`, t.`chance`, 0, 1, 0, 1, 1, 'Wowhead Forever counts, at the realm''s measure' FROM `everlake_scryer_pockets` t;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pickpocketing_loot_template', 4293, 0, t.`item`, 0, @EVERLAKE_FILE, 'wowhead pick counts scaled as Scarlet Torturer 4306; icyveins witness' FROM `everlake_scryer_pockets` t;

DROP TEMPORARY TABLE IF EXISTS `everlake_scryer_pockets`;

COMMIT;
