-- Camping: the Fishing Rack (612090) gives each player who uses it their own loot.
-- 2026_11_26_21_world_everlake_fishing_rack_lures_for_everyone.sql: written by hand from the tracker's kept facts (2026-11-26).
--
-- Blizzard's server-side note of 16 November 2026 (step 70938+1): "The Fishing Rack now provides lures for everyone."
-- EG Link's object records of the Fishing Rack: up to client build 70938 a shared chest (lock 93, loot 139206 in
-- Data1, restock 300000 ms, 3-3 restocks, condition 150698, chest flags 4104 = not in combat + one looter); from 70959
-- on (70959 and 71037) lock 1634, no shared loot, chest flags 2316 (leave loot, not in combat, damage immune OK,
-- personal loot security off) and the same loot 139206 as personal loot (Data30). The realm still has the old record.
-- This writes the 70959 record's values, only while the row still holds the old ones. The loot table itself (Camper's
-- Lure 291005) is unchanged.
--
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing. Not checked in
-- game.

UPDATE `gameobject_template`
SET `Data0` = 1634, `Data1` = 0, `Data2` = 0, `Data4` = 0, `Data5` = 0, `Data17` = 0, `Data20` = 2316, `Data30` = 139206
WHERE `entry` = 612090 AND `type` = 3 AND `Data0` = 93 AND `Data1` = 139206 AND `Data2` = 300000 AND `Data4` = 3 AND `Data5` = 3
  AND `Data17` = 150698 AND `Data20` = 4104 AND `Data30` = 0;
