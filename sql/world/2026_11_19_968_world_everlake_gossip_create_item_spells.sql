-- Mux Manascrambler and Falrin Treeshaper hand back their lost items with the item's own create spell.
-- 2026_11_19_968_world_everlake_gossip_create_item_spells.sql: written by hand.
--
-- 967 put their gossip choices on the menus players see. Both still add the item directly (SmartAI action 56), and the
-- worldserver warns at startup that a create-item spell exists for each item. They now work like the other
-- replacements: the player casts the spell on themselves (SELF_CAST, triggered).
--   Mux Manascrambler (16014), 7083/2: Create Extra-Dimensional Ghost Revealer (27754, item 22115).
--   Falrin Treeshaper (16032), 7084/0: Create Banner of Provocation (27755, item 21986).
-- Both spells are in the client and create those items. The option conditions (967 and earlier) are unchanged.
--
-- Rows changed only while they still add the item. Not checked in game.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

START TRANSACTION;

UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 27754, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Mux Manascrambler - On gossip 7083/2 - Invoker casts Create Extra-Dimensional Ghost Revealer' WHERE `entryorguid` = 16014 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `event_param1` = 7083 AND `event_param2` = 2 AND `action_type` = 56 AND `action_param1` = 22115;
UPDATE `smart_scripts` SET `action_type` = 85, `action_param1` = 27755, `action_param2` = 2, `action_param3` = 0, `target_type` = 7, `comment` = 'Falrin Treeshaper - On gossip 7084/0 - Invoker casts Create Banner of Provocation' WHERE `entryorguid` = 16032 AND `source_type` = 0 AND `id` = 0 AND `event_type` = 62 AND `event_param1` = 7084 AND `event_param2` = 0 AND `action_type` = 56 AND `action_param1` = 21986;

COMMIT;
