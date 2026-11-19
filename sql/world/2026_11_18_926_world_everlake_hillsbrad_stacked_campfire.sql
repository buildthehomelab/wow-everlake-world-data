-- Hillsbrad Foothills: one campfire at 33.0 34.6 instead of five stacked on top of each other.
-- 2026_11_18_926_world_everlake_hillsbrad_stacked_campfire.sql: written by hand.
--
-- Reported in game: the campfire at 33.0 34.6 (world -337, 9 on map 0) looked doubled. The fork's baseline (and the
-- Forever TDB it comes from) spawns five Cozy Fire objects there (22602 to 22606, all the same fire model, display 199)
-- within about a yard of each other, each with its own Campfire trap (2061) on the same point: three at z 55.57 and
-- two at z 60.49. Everlake's maps and vmaps (tools/height.py of wow-forever-tracker) have only terrain under that
-- point, at z 56.09, and no model: the fire stands outdoors, so the upper two float about 4.4 yards in the air and the
-- lower three draw over each other.
--
-- Kept: Cozy Fire 30018228 (22606) and its trap 30018285, on the ground. Deleted: the other four fires and their four
-- traps. No other world table names these guids (gameobject_addon, pools, game events: none in the baseline).
-- A row is deleted only while it is still as the baseline has it (guid, entry and position). Running it again changes
-- nothing. Not checked in game.
-- The same pattern (2 to 5 Cozy Fires on one point) is in the baseline at about 87 other places; this file fixes only
-- the reported one.
-- Never edit this file once it is deployed: a later fix is a new file.

DELETE FROM `gameobject`
 WHERE `map` = 0
   AND ((`guid` = 30018286 AND `id` = 22605 AND ABS(`position_x` - -336.83)  < 0.01 AND ABS(`position_y` - 9.8719)  < 0.01 AND ABS(`position_z` - 55.5745) < 0.01)
     OR (`guid` = 30018287 AND `id` = 2061  AND ABS(`position_x` - -336.83)  < 0.01 AND ABS(`position_y` - 9.8719)  < 0.01 AND ABS(`position_z` - 55.5745) < 0.01)
     OR (`guid` = 30018288 AND `id` = 22604 AND ABS(`position_x` - -337.225) < 0.01 AND ABS(`position_y` - 8.70207) < 0.01 AND ABS(`position_z` - 55.5745) < 0.01)
     OR (`guid` = 30018289 AND `id` = 2061  AND ABS(`position_x` - -337.225) < 0.01 AND ABS(`position_y` - 8.70207) < 0.01 AND ABS(`position_z` - 55.5745) < 0.01)
     OR (`guid` = 30018173 AND `id` = 22603 AND ABS(`position_x` - -337.056) < 0.01 AND ABS(`position_y` - 8.56755) < 0.01 AND ABS(`position_z` - 60.4914) < 0.01)
     OR (`guid` = 30018174 AND `id` = 2061  AND ABS(`position_x` - -337.056) < 0.01 AND ABS(`position_y` - 8.56755) < 0.01 AND ABS(`position_z` - 60.4914) < 0.01)
     OR (`guid` = 30018290 AND `id` = 22602 AND ABS(`position_x` - -337.328) < 0.01 AND ABS(`position_y` - 9.47483) < 0.01 AND ABS(`position_z` - 60.4914) < 0.01)
     OR (`guid` = 30018297 AND `id` = 2061  AND ABS(`position_x` - -337.328) < 0.01 AND ABS(`position_y` - 9.47483) < 0.01 AND ABS(`position_z` - 60.4914) < 0.01));
