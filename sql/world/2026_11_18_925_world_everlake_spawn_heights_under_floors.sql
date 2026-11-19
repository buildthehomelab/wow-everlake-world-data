-- 36 creatures of the restored Forever quest data stood under a floor: in the ground under a building, deck or platform.
-- 2026_11_18_925_world_everlake_spawn_heights_under_floors.sql: written from an audit (tools/height.py of wow-forever-tracker on Everlake's own maps and vmaps).
--
-- The core fork's 2026_11_05_99_world_forever_restore_forever_quest_data.sql (AnoCore port) gives these spawns the height of
-- the bare terrain to the hundredth, as a height read without buildings does, while a model surface (a house floor, a dock,
-- a platform) lies 0.6 to 2.5 yards over them. Player report 2026-11-18: Sentinel Selarin (3694) in Auberdine stood under
-- the ground floor of her house (terrain 11.48, floor 13.94); only her name showed, on the floor.
-- Each one is moved up onto that surface (the top of it when the model gives both faces), and only where at least 2.5 yards
-- stay free above it. Five more with less headroom, and spawns from other files, are left for a look in game
-- (docs/audits/2026-11-18-spawn-heights.md). Not checked in game.
-- A row changes only while it still has the old height, so running this again changes nothing.
-- Never edit this file once it is deployed: a later fix is a new file.

START TRANSACTION;

-- entry 185333, map 0 (-164.533, 787.2): 63.711 -> 64.76
UPDATE `creature` SET `position_z` = 64.76 WHERE `guid` = 18533300 AND `id` = 185333 AND `map` = 0 AND ABS(`position_z` - 63.711) < 0.01;
-- entry 248265, map 0 (-9606.08, -1116.3): 42.406 -> 43.86
UPDATE `creature` SET `position_z` = 43.86 WHERE `guid` = 24826500 AND `id` = 248265 AND `map` = 0 AND ABS(`position_z` - 42.406) < 0.01;
-- entry 248779, map 0 (-192.533, 921.6): 65.543 -> 66.71
UPDATE `creature` SET `position_z` = 66.71 WHERE `guid` = 24877900 AND `id` = 248779 AND `map` = 0 AND ABS(`position_z` - 65.543) < 0.01;
-- entry 253092, map 0 (-10636.7, 1182.67): 33.06 -> 34.77
UPDATE `creature` SET `position_z` = 34.77 WHERE `guid` = 25309200 AND `id` = 253092 AND `map` = 0 AND ABS(`position_z` - 33.06) < 0.01;
-- entry 255890, map 0 (-8180.33, -5597.07): 3.599 -> 4.4
UPDATE `creature` SET `position_z` = 4.4 WHERE `guid` = 25589001 AND `id` = 255890 AND `map` = 0 AND ABS(`position_z` - 3.599) < 0.01;
-- entry 255894, map 0 (-8212.67, -5713.47): 4.828 -> 7.12
UPDATE `creature` SET `position_z` = 7.12 WHERE `guid` = 25589400 AND `id` = 255894 AND `map` = 0 AND ABS(`position_z` - 4.828) < 0.01;
-- entry 255895, map 0 (-8186.8, -5606.77): 3.787 -> 5.01
UPDATE `creature` SET `position_z` = 5.01 WHERE `guid` = 25589500 AND `id` = 255895 AND `map` = 0 AND ABS(`position_z` - 3.787) < 0.01;
-- entry 256675, map 0 (-7921.67, -4704.67): 22.638 -> 24.47
UPDATE `creature` SET `position_z` = 24.47 WHERE `guid` = 25667500 AND `id` = 256675 AND `map` = 0 AND ABS(`position_z` - 22.638) < 0.01;
-- entry 256840, map 0 (-9053.33, -4879.27): 23.45 -> 25.17
UPDATE `creature` SET `position_z` = 25.17 WHERE `guid` = 25684001 AND `id` = 256840 AND `map` = 0 AND ABS(`position_z` - 23.45) < 0.01;
-- entry 257595, map 0 (-9189.13, -5024.77): 38.51 -> 39.72
UPDATE `creature` SET `position_z` = 39.72 WHERE `guid` = 25759500 AND `id` = 257595 AND `map` = 0 AND ABS(`position_z` - 38.51) < 0.01;
-- entry 257754, map 0 (-11016.7, -2048.33): 39.132 -> 40.71
UPDATE `creature` SET `position_z` = 40.71 WHERE `guid` = 25775400 AND `id` = 257754 AND `map` = 0 AND ABS(`position_z` - 39.132) < 0.01;
-- entry 258686, map 0 (-8063.93, -3385.47): 165.663 -> 166.65
UPDATE `creature` SET `position_z` = 166.65 WHERE `guid` = 25868605 AND `id` = 258686 AND `map` = 0 AND ABS(`position_z` - 165.663) < 0.01;
-- entry 259049, map 0 (-9137.4, -3996.57): 36.138 -> 36.99
UPDATE `creature` SET `position_z` = 36.99 WHERE `guid` = 25904900 AND `id` = 259049 AND `map` = 0 AND ABS(`position_z` - 36.138) < 0.01;
-- entry 259861, map 0 (-9118.0, -5005.37): 38.507 -> 40.04
UPDATE `creature` SET `position_z` = 40.04 WHERE `guid` = 25986100 AND `id` = 259861 AND `map` = 0 AND ABS(`position_z` - 38.507) < 0.01;
-- entry 259962, map 0 (-8210.61, -5712.06): 5.106 -> 5.99
UPDATE `creature` SET `position_z` = 5.99 WHERE `guid` = 25996200 AND `id` = 259962 AND `map` = 0 AND ABS(`position_z` - 5.106) < 0.01;
-- entry 260565, map 0 (-8107.14, -5653.86): 2.515 -> 3.36
UPDATE `creature` SET `position_z` = 3.36 WHERE `guid` = 26056500 AND `id` = 260565 AND `map` = 0 AND ABS(`position_z` - 2.515) < 0.01;
-- entry 262037, map 0 (-9215.0, -4840.47): 60.994 -> 62.7
UPDATE `creature` SET `position_z` = 62.7 WHERE `guid` = 26203702 AND `id` = 262037 AND `map` = 0 AND ABS(`position_z` - 60.994) < 0.01;
-- entry 263120, map 0 (-8214.73, -5714.88): 4.828 -> 6.08
UPDATE `creature` SET `position_z` = 6.08 WHERE `guid` = 26312000 AND `id` = 263120 AND `map` = 0 AND ABS(`position_z` - 4.828) < 0.01;
-- entry 263190, map 0 (-7921.67, -4704.67): 22.638 -> 24.47
UPDATE `creature` SET `position_z` = 24.47 WHERE `guid` = 26319000 AND `id` = 263190 AND `map` = 0 AND ABS(`position_z` - 22.638) < 0.01;
-- entry 263326, map 0 (-8141.53, -5684.37): 1.869 -> 2.73
UPDATE `creature` SET `position_z` = 2.73 WHERE `guid` = 26332600 AND `id` = 263326 AND `map` = 0 AND ABS(`position_z` - 1.869) < 0.01;
-- entry 263384, map 0 (-8139.47, -5682.96): 1.876 -> 2.73
UPDATE `creature` SET `position_z` = 2.73 WHERE `guid` = 26338400 AND `id` = 263384 AND `map` = 0 AND ABS(`position_z` - 1.876) < 0.01;
-- entry 263613, map 0 (-9014.53, -5063.57): 39.812 -> 41.0
UPDATE `creature` SET `position_z` = 41.0 WHERE `guid` = 26361300 AND `id` = 263613 AND `map` = 0 AND ABS(`position_z` - 39.812) < 0.01;
-- entry 266216, map 0 (-598.4, -1480.53): 52.441 -> 54.02
UPDATE `creature` SET `position_z` = 54.02 WHERE `guid` = 26621602 AND `id` = 266216 AND `map` = 0 AND ABS(`position_z` - 52.441) < 0.01;
-- entry 269683, map 0 (-9156.8, -5044.17): 38.513 -> 39.36
UPDATE `creature` SET `position_z` = 39.36 WHERE `guid` = 26968303 AND `id` = 269683 AND `map` = 0 AND ABS(`position_z` - 38.513) < 0.01;
-- entry 269688, map 0 (-9156.8, -5044.17): 38.513 -> 39.36
UPDATE `creature` SET `position_z` = 39.36 WHERE `guid` = 26968800 AND `id` = 269688 AND `map` = 0 AND ABS(`position_z` - 38.513) < 0.01;
-- entry 269699, map 0 (-9169.73, -5034.47): 38.513 -> 39.49
UPDATE `creature` SET `position_z` = 39.49 WHERE `guid` = 26969900 AND `id` = 269699 AND `map` = 0 AND ABS(`position_z` - 38.513) < 0.01;
-- entry 270571, map 0 (-9240.87, -4908.37): 60.329 -> 61.29
UPDATE `creature` SET `position_z` = 61.29 WHERE `guid` = 27057100 AND `id` = 270571 AND `map` = 0 AND ABS(`position_z` - 60.329) < 0.01;
-- entry 270572, map 0 (-9189.13, -5034.47): 38.513 -> 39.65
UPDATE `creature` SET `position_z` = 39.65 WHERE `guid` = 27057200 AND `id` = 270572 AND `map` = 0 AND ABS(`position_z` - 38.513) < 0.01;
-- entry 271005, map 0 (-9187.07, -5023.36): 38.336 -> 39.69
UPDATE `creature` SET `position_z` = 39.69 WHERE `guid` = 27100500 AND `id` = 271005 AND `map` = 0 AND ABS(`position_z` - 38.336) < 0.01;
-- entry 271006, map 0 (-9191.19, -5026.18): 38.513 -> 39.75
UPDATE `creature` SET `position_z` = 39.75 WHERE `guid` = 27100600 AND `id` = 271006 AND `map` = 0 AND ABS(`position_z` - 38.513) < 0.01;
-- entry 272315, map 0 (-8199.73, -5742.57): 1.793 -> 4.7
UPDATE `creature` SET `position_z` = 4.7 WHERE `guid` = 27231502 AND `id` = 272315 AND `map` = 0 AND ABS(`position_z` - 1.793) < 0.01;
-- entry 272420, map 0 (-7035.73, -4850.17): 90.916 -> 93.33
UPDATE `creature` SET `position_z` = 93.33 WHERE `guid` = 27242000 AND `id` = 272420 AND `map` = 0 AND ABS(`position_z` - 90.916) < 0.01;
-- entry 272914, map 0 (-4358.43, -2564.81): 211.35 -> 212.38
UPDATE `creature` SET `position_z` = 212.38 WHERE `guid` = 27291400 AND `id` = 272914 AND `map` = 0 AND ABS(`position_z` - 211.35) < 0.01;
-- entry 3694, map 1 (6438.2, 374.067): 11.481 -> 13.94
UPDATE `creature` SET `position_z` = 13.94 WHERE `guid` = 369400 AND `id` = 3694 AND `map` = 1 AND ABS(`position_z` - 11.481) < 0.01;
-- entry 254284, map 1 (-2829.33, 1053.3): 130.299 -> 132.41
UPDATE `creature` SET `position_z` = 132.41 WHERE `guid` = 25428401 AND `id` = 254284 AND `map` = 1 AND ABS(`position_z` - 130.299) < 0.01;
-- entry 275744, map 1 (9869.66, 1558.97): 1328.55 -> 1330.36
UPDATE `creature` SET `position_z` = 1330.36 WHERE `guid` = 27574402 AND `id` = 275744 AND `map` = 1 AND ABS(`position_z` - 1328.55) < 0.01;

COMMIT;
