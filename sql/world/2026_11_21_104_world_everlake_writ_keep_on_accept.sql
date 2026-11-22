-- Craftsman's Writs: keep the writ when its quest is accepted.
-- 2026_11_21_104_world_everlake_writ_keep_on_accept.sql: written by hand.
--
-- A player reported the writ for Crafted Solid Shot (item 264037, quest 94237) vanished the moment they accepted the
-- quest, so the quest could never be finished: every writ quest needs the writ itself as its first item objective
-- ("This writ must be in your possession to complete the transaction").
--
-- Cause: on accept the core destroys the item that started the quest unless that item is the quest's StartItem, or
-- is an item objective AND unique (Player::AddQuestAndCheckCompletion). Writs are not unique, and the writ quests the
-- tracker exported (2026_11_19_981, 984 and 989, 99 quests) carry StartItem 0, so the writ was destroyed. The writs
-- written by hand on 11-12 (94004, 94212, 94214, ...) set StartItem to the writ and were never affected.
--
-- Fix: StartItem = the writ, read from the quest's own first item objective (Type 1 item, Order 0, Amount 1, flag 0x20
-- as every writ record has it). With StartItem set the core keeps the writ on accept, does not hand out a second one
-- (Player::GiveQuestSourceItem skips it while the player holds it), keeps it on abandon, and still takes it on
-- turn-in as an objective item. Writ quests are not sharable (no flag 0x8), so no writ can be copied by sharing.
--
-- Only quests titled "Craftsman's Writ:" with StartItem 0 and exactly one such objective change. Running it again
-- changes nothing. Not tried in game.

START TRANSACTION;

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

COMMIT;
