-- Valennia Stormfist stood twice at the Peacekeeper camp on map 2991, 12 yards apart.
-- 2026_11_26_90_world_everlake_valennia_double.sql: written from the test realm's world (2026-11-26, tracker Query
-- page), after a player saw two of her.
--
-- Our sniff file placed two Valennia entries side by side, neither phased:
--   252383  guid 21100970  kept: core script classic_npc_valennia_stormfist, starts and ends her quest chain
--                                (Desperate Times, To Valanaar, In Service of Zephras, Prepare for Battle, ...),
--                                stands beside Talaanis Shadowsong
--   260628  guid 21101717  removed: no script, no text, ends only the placeholder quest 93949 "Bugged"
-- The removed spawn has no addon, pool, spawn group, formation, event or per-spawn script. Her other two spawns
-- (253590 elsewhere on the island, 253844 the muster in phase 29805) are other story moments and stay.
--
-- Running it again changes nothing: the row goes only while it still holds 260628 and the kept spawn still stands.

DELETE c FROM `creature` c
JOIN `creature` k ON k.`guid` = 21100970 AND k.`id` = 252383
WHERE c.`guid` = 21101717 AND c.`id` = 260628;
