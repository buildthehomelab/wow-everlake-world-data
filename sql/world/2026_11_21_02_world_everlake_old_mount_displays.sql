-- Vendor display mounts on their live entries: seven Classic mount displays the realm spawns where live uses Forever's
-- copy and the realm does not spawn it.
-- 2026_11_21_02_world_everlake_old_mount_displays.sql: written by hand from the ForeverTracker's Extras > Old twin list.
--
-- The live server sent records of Forever's display mounts (EG Link) and never of these Classic entries. Each spawn
-- below stands in a mount vendor's pen beside other Forever display mounts the realm already spawns (checked on the test
-- realm's world, 2026-11-21), so it is the same pen's display on the old entry:
--   20004148  12373 Gray Ram          -> 267475   Amberstill Ranch ram pen (Brown Ram 267473 9 yd)
--   20095109  14548 Swift Gray Ram    -> 276737   Amberstill Ranch ram pen (Swift Brown Ram 276779 11 yd)
--   20095103  14542 Great White Kodo  -> 276879   Bloodhoof kodo pen (Grey Riding Kodo 267226 14 yd)
--   20095110  14549 Great Brown Kodo  -> 276876   Bloodhoof kodo pen
--   20095111  14550 Great Gray Kodo   -> 276877   Bloodhoof kodo pen
--   20095122  14560 Swift White Steed -> 276787   Eastvale stables (Swift Brown Steed 276785 12 yd, the same 27678x set)
--   20095121  14560 Swift White Steed -> 276892   Southshore stables (Swift Palomino 276893 3 yd, the same 27689x set)
-- Not here: 20095120, the Swift White Steed at Theramore, has no Forever display beside it to say which of 276787 and
-- 276892 it is; 2543 Archmage Ansirem Runeweaver (live's 256621 may be a different appearance of him). Other old twins
-- the tracker lists are creatures live did use (killed there, with loot records), not stand-ins.
-- A spawn moves only while it still holds the old entry; guid, spot and the rest stay. Running it again changes nothing.

UPDATE `creature` SET `id` = 267475, `modelid` = 0 WHERE `guid` = 20004148 AND `id` = 12373;
UPDATE `creature` SET `id` = 276737, `modelid` = 0 WHERE `guid` = 20095109 AND `id` = 14548;
UPDATE `creature` SET `id` = 276879, `modelid` = 0 WHERE `guid` = 20095103 AND `id` = 14542;
UPDATE `creature` SET `id` = 276876, `modelid` = 0 WHERE `guid` = 20095110 AND `id` = 14549;
UPDATE `creature` SET `id` = 276877, `modelid` = 0 WHERE `guid` = 20095111 AND `id` = 14550;
UPDATE `creature` SET `id` = 276787, `modelid` = 0 WHERE `guid` = 20095122 AND `id` = 14560;
UPDATE `creature` SET `id` = 276892, `modelid` = 0 WHERE `guid` = 20095121 AND `id` = 14560;
