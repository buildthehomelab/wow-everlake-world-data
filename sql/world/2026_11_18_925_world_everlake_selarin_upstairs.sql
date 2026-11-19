-- Auberdine: Sentinel Selarin (3694) stood inside the floor of her house, under the upper storey.
-- 2026_11_18_925_world_everlake_selarin_upstairs.sql: written by hand.
--
-- Her spawn (guid 900000169, 6438.2, 374.07 on map 1 = Darkshore 39.2, 43.4) was added by the Forge's database mode,
-- which takes the height of the nearest existing spawn: 14.12, the ground floor. Players found her under the floor
-- of the two-storey house there (her name shows when the floor is pointed at).
-- Everlake's own vmaps (tools/height.py of wow-forever-tracker) read at her point: terrain 11.48, ground floor 13.94,
-- upper floor 21.98 (underside) / 23.33 (top), roof 34.85 / 37.85. The upper floor is level for 8 yards around her.
-- She is moved to the upper floor (23.33). Not checked in game.
-- Only that row is changed, and only while it still has the old height, so running it again changes nothing.
-- Never edit this file once it is deployed: a later fix is a new file.

UPDATE `creature` SET `position_z` = 23.33
 WHERE `guid` = 900000169 AND `id` = 3694 AND `map` = 1 AND ABS(`position_z` - 14.12) < 0.01;
