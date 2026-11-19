-- Elwynn Forest: Kobold Tracks (563442) for "Shhh! We're Hunting Kobolds" (91772) gave credit again from the same track.
-- 2026_11_18_924_world_everlake_kobold_tracks.sql: written by hand.
--
-- The quest wants 6 "Followed Kobold Tracks" from the 13 tracks laid along the trail east of Goldshire. The track is a
-- goober (type 10) whose sniffed template has autoClose 3000 ms, consumable 0 and Allow Multi-Interact 0. So after a
-- click it closes itself 3 seconds later and can be clicked again, and the core credits every click
-- (Player::KillCreditGO keeps no list of which object already gave credit). Players reported standing at one track and
-- clicking it six times instead of following the trail.
--
-- This sets consumable (Data5) and Allow Multi-Interact (Data20). The core's goober use then calls DespawnForPlayer:
-- the clicked track disappears for that player only, for the spawn's respawn time (120 s), and stays up for everyone
-- else. Each player has to find six different tracks, and no one takes a track from anyone else. Not checked in game.
-- Only changed while the row is still the sniffed goober with both flags off.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

START TRANSACTION;

UPDATE `gameobject_template`
SET `Data5` = 1, `Data20` = 1
WHERE `entry` = 563442 AND `type` = 10 AND `Data5` = 0 AND `Data20` = 0;

COMMIT;
