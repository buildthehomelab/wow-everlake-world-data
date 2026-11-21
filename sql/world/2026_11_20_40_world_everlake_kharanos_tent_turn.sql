-- The Kharanos Camp Tent (guid 52899606, object 528996) turned 180 degrees to face the other way.
-- 2026_11_20_40_world_everlake_kharanos_tent_turn.sql: written by hand.
--
-- User report 2026-11-20 after the height fix in 2026_11_20_39: the tent faces the wrong way. The core fork's
-- restore file 2026_11_05_99 spawns it at orientation 3.142, rotation (0, 0, 1, -0.000204). Turned by pi that is
-- orientation 0.000407, rotation (0, 0, 0.000204, 1). Only this tent changes.
-- The row moves only while it still has the old facing. Running it again changes nothing. A later fix is a new file.

UPDATE `gameobject`
SET `orientation` = 0.000407, `rotation0` = 0, `rotation1` = 0, `rotation2` = 0.000204, `rotation3` = 1
WHERE `guid` = 52899606 AND `id` = 528996 AND `map` = 0 AND `orientation` BETWEEN 3.10 AND 3.20;
