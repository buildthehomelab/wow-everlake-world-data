-- Everlake Forge #42: Import, 1 resource(s), 164 row(s)
-- Applied on the test realm as the tracker's Forge operation #62; numbered 42 here, the next free number of this repository.
-- 2026_11_16_900_world_everlake_forge_00042_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70938) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Classic database 2026-11-16: Midsummer Fire Festival (NOTICE.md, Forge exports).
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing: a row is added only
-- where none exists, spawns only where the same creature or object is not already within 5 yards (10 for a holiday's object, against one there all year or brought in by the same event, 30 for a holiday's creature, against one there all year or brought in by the same event), and each added row is recorded in everlake_import_rows.

CREATE TABLE IF NOT EXISTS `everlake_import_rows` (
  `tbl` varchar(64) NOT NULL COMMENT 'world table of the row',
  `k1` bigint NOT NULL COMMENT 'the row''s key, in the table''s primary key order',
  `k2` bigint NOT NULL DEFAULT '0',
  `k3` bigint NOT NULL DEFAULT '0',
  `k4` bigint NOT NULL DEFAULT '0',
  `file` varchar(200) NOT NULL COMMENT 'the update file that added the row',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT 'the sources that gave it',
  PRIMARY KEY (`tbl`, `k1`, `k2`, `k3`, `k4`),
  KEY `file` (`file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added (docs/forever-import.md)';

START TRANSACTION;
-- gameobject: 76 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `gameobject` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(910620000, 181021, 1, 0, 0, '0', 0, 0, 0, -1, -1277.65, 49.8685, 144.238, 0.558505, 0, 0, 0.275637, 0.961262, 180, 255, 1, '', NULL, 70938),
(910620001, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 1381.49, -4369.8, 52.8347, -3.00197, 0, 0, 0.997564, -0.069756, 180, 255, 1, '', NULL, 70938),
(910620002, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 1661.55, -4344.48, 75.2458, -2.58309, 0, 0, 0.961262, -0.275637, 180, 255, 1, '', NULL, 70938),
(910620003, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 1687.43, -4340.11, 74.9505, -0.488692, 0, 0, 0.241922, -0.970296, 180, 255, 1, '', NULL, 70938),
(910620004, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 1659.82, -4329.04, 75.2346, 2.68781, 0, 0, 0.97437, 0.224951, 180, 255, 1, '', NULL, 70938),
(910620005, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 1484.87, -4416.72, 53.1904, 0.10472, 0, 0, 0.052336, 0.99863, 180, 255, 1, '', NULL, 70938),
(910620006, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 1706.77, -3929.71, 71.8858, -1.01229, 0, 0, 0.48481, -0.87462, 180, 255, 1, '', NULL, 70938),
(910620007, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 9892.4, 2238.72, 1343.61, -0.087267, 0, 0, 0.04362, -0.999048, 180, 255, 1, '', NULL, 70938),
(910620008, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 9985.94, 1978.34, 1352.14, -1.6057, 0, 0, 0.71934, -0.694658, 180, 255, 1, '', NULL, 70938),
(910620009, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 9986.28, 2022.9, 1351.84, 1.6057, 0, 0, 0.71934, 0.694658, 180, 255, 1, '', NULL, 70938),
(910620010, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 10013.6, 2242.08, 1343.91, -3.03687, 0, 0, 0.99863, -0.052336, 180, 255, 1, '', NULL, 70938),
(910620011, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 10014, 2226.74, 1343.69, -3.12414, 0, 0, 0.999962, -0.008727, 180, 255, 1, '', NULL, 70938),
(910620012, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 10014.4, 2211.14, 1343.83, 3.10669, 0, 0, 0.999848, 0.017452, 180, 255, 1, '', NULL, 70938),
(910620013, 181021, 0, 0, 0, '0', 0, 0, 0, -1, -4994.78, -847.123, 524.522, -2.46091, 0, 0, 0.942641, -0.333807, 180, 255, 1, '', NULL, 70938),
(910620014, 181021, 0, 0, 0, '0', 0, 0, 0, -1, -5003.33, -874.714, 524.838, 0.680678, 0, 0, 0.333807, 0.942641, 180, 255, 1, '', NULL, 70938),
(910620015, 181021, 0, 0, 0, '0', 0, 0, 0, -1, -4974.65, -871.542, 524.529, -2.44346, 0, 0, 0.939693, -0.34202, 180, 255, 1, '', NULL, 70938),
(910620016, 181021, 0, 0, 0, '0', 0, 0, 0, -1, -4984.71, -859.337, 524.799, -2.46091, 0, 0, 0.942641, -0.333807, 180, 255, 1, '', NULL, 70938),
(910620017, 181021, 0, 0, 0, '0', 0, 0, 0, -1, -4993.28, -886.917, 524.6, 0.680678, 0, 0, 0.333807, 0.942641, 180, 255, 1, '', NULL, 70938),
(910620018, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 1672.88, -4320.48, 74.9852, 1.64061, 0, 0, 0.731354, 0.681998, 180, 255, 1, '', NULL, 70938),
(910620019, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 1685.85, -4327.43, 74.8583, 0.698132, 0, 0, 0.34202, 0.939693, 180, 255, 1, '', NULL, 70938),
(910620020, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 9893.36, 2207.54, 1343.76, 0.034907, 0, 0, 0.017452, 0.999848, 180, 255, 1, '', NULL, 70938),
(910620021, 181021, 1, 0, 0, '0', 0, 0, 0, -1, 9892.59, 2223.51, 1343.63, 0.017453, 0, 0, 0.008727, 0.999962, 180, 255, 1, '', NULL, 70938),
(910620022, 181021, 0, 0, 0, '0', 0, 0, 0, -1, -4641.6, -1178.9, 515.026, -2.05949, 0, 0, 0.857167, -0.515038, 180, 255, 1, '', NULL, 70938),
(910620023, 181021, 0, 0, 0, '0', 0, 0, 0, -1, -5013.39, -862.519, 524.679, 0.698132, 0, 0, 0.34202, 0.939693, 180, 255, 1, '', NULL, 70938),
(910620024, 181021, 0, 0, 0, '0', 0, 0, 0, -1, -4634.71, -1025.57, 514.933, 1.8675, 0, 0, 0.803857, 0.594823, 180, 255, 1, '', NULL, 70938),
(910620025, 180698, 0, 0, 0, '0', 0, 0, 0, -1, -14413.2, 419.881, 22.2328, 1.09956, 0, 0, 0.522498, 0.85264, 180, 255, 1, '', NULL, 70938),
(910620026, 180905, 0, 0, 0, '0', 0, 0, 0, -1, -14413.7, 423.299, 9.9094, 6.21337, 0, 0, -0.034899, 0.999391, 180, 255, 1, '', NULL, 70938),
(910620027, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14366.1, 378.064, 23.33, 1.85005, 0, 0, 0.798635, 0.601815, 180, 255, 1, '', NULL, 70938),
(910620028, 180905, 0, 0, 0, '0', 0, 0, 0, -1, -14349.2, 437.972, 8.54443, 2.3911, 0, 0, 0.930417, 0.366502, 180, 255, 1, '', NULL, 70938),
(910620029, 180905, 0, 0, 0, '0', 0, 0, 0, -1, -14408.5, 423.064, 9.64023, 0.925024, 0, 0, 0.446198, 0.894935, 180, 255, 1, '', NULL, 70938),
(910620030, 180749, 0, 0, 0, '0', 0, 0, 0, -1, -14306.8, 508.344, 8.63792, 2.53072, 0, 0, 0.953716, 0.300708, -4, 255, 1, '', NULL, 70938),
(910620031, 180749, 0, 0, 0, '0', 0, 0, 0, -1, -14371, 420.312, 16.5129, 4.39823, 0, 0, -0.809016, 0.587786, -4, 255, 1, '', NULL, 70938),
(910620032, 180749, 0, 0, 0, '0', 0, 0, 0, -1, -14420.4, 519.201, 5.00312, 6.26573, 0, 0, -0.008726, 0.999962, -4, 255, 1, '', NULL, 70938),
(910620033, 180749, 0, 0, 0, '0', 0, 0, 0, -1, -14465.2, 457.38, 15.1645, 4.71239, 0, 0, -0.707107, 0.707107, -4, 255, 1, '', NULL, 70938),
(910620034, 180905, 0, 0, 0, '0', 0, 0, 0, -1, -14400, 415.09, 23.6735, 4.66003, 0, 0, -0.725374, 0.688355, 180, 255, 1, '', NULL, 70938),
(910620035, 180905, 0, 0, 0, '0', 0, 0, 0, -1, -14323.7, 447.686, 24.0552, 2.14675, 0, 0, 0.878817, 0.47716, 180, 255, 1, '', NULL, 70938),
(910620036, 180905, 0, 0, 0, '0', 0, 0, 0, -1, -14412.3, 420.295, 23.3374, 4.01426, 0, 0, -0.906307, 0.422619, 180, 255, 1, '', NULL, 70938),
(910620037, 180905, 0, 0, 0, '0', 0, 0, 0, -1, -14442.5, 453.238, 16.4982, 0.680677, 0, 0, 0.333806, 0.942642, 180, 255, 1, '', NULL, 70938),
(910620038, 180698, 0, 0, 0, '0', 0, 0, 0, -1, -14443.3, 453.252, 15.3917, 2.16421, 0, 0, 0.882947, 0.469473, 180, 255, 1, '', NULL, 70938),
(910620039, 180698, 0, 0, 0, '0', 0, 0, 0, -1, -14447.7, 484.136, 15.0479, 5.53269, 0, 0, -0.366501, 0.930418, 180, 255, 1, '', NULL, 70938),
(910620040, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14389.6, 421.986, 7.40637, 5.51524, 0, 0, -0.374606, 0.927184, 180, 255, 1, '', NULL, 70938),
(910620041, 180698, 0, 0, 0, '0', 0, 0, 0, -1, -14459.6, 427.453, 25.1701, 5.23599, 0, 0, -0.5, 0.866025, 180, 255, 1, '', NULL, 70938),
(910620042, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14395.2, 403.79, 22.7013, 5.88176, 0, 0, -0.199368, 0.979925, 180, 255, 1, '', NULL, 70938),
(910620043, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14405.9, 421.402, 8.40552, 1.309, 0, 0, 0.608761, 0.793354, 180, 255, 1, '', NULL, 70938),
(910620044, 180905, 0, 0, 0, '0', 0, 0, 0, -1, -14446.7, 484.295, 16.1732, 2.75761, 0, 0, 0.981627, 0.190812, 180, 255, 1, '', NULL, 70938),
(910620045, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14410.9, 418.75, 22.3049, 1.15192, 0, 0, 0.544639, 0.838671, 180, 255, 1, '', NULL, 70938),
(910620046, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14415.9, 420.981, 22.1447, 1.0821, 0, 0, 0.515038, 0.857168, 180, 255, 1, '', NULL, 70938),
(910620047, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14416.1, 425.141, 8.92412, 1.0821, 0, 0, 0.515038, 0.857168, 180, 255, 1, '', NULL, 70938),
(910620048, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14441.4, 450.783, 15.3908, 0.59341, 0, 0, 0.292371, 0.956305, 180, 255, 1, '', NULL, 70938),
(910620049, 180905, 0, 0, 0, '0', 0, 0, 0, -1, -14458.8, 427.472, 26.2924, 4.99164, 0, 0, -0.601814, 0.798636, 180, 255, 1, '', NULL, 70938),
(910620050, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14445.1, 455.929, 15.3959, 0.523598, 0, 0, 0.258819, 0.965926, 180, 255, 1, '', NULL, 70938),
(910620051, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14453.7, 416.083, 25.0479, 1.71042, 0, 0, 0.754709, 0.656059, 180, 255, 1, '', NULL, 70938),
(910620052, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14323.7, 448.269, 23.9998, 5.81195, 0, 0, -0.233445, 0.97237, 180, 255, 1, '', NULL, 70938),
(910620053, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14325.6, 445.086, 23.9201, 1.3439, 0, 0, 0.622514, 0.782609, 180, 255, 1, '', NULL, 70938),
(910620054, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14345.5, 439.709, 8.50672, 2.49582, 0, 0, 0.948323, 0.317306, 180, 255, 1, '', NULL, 70938),
(910620055, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14347.7, 437.647, 8.44997, 0.366518, 0, 0, 0.182235, 0.983255, 180, 255, 1, '', NULL, 70938),
(910620056, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14399.5, 414.966, 23.6128, 0.157079, 0, 0, 0.078459, 0.996917, 180, 255, 1, '', NULL, 70938),
(910620057, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14408.6, 422.722, 9.57084, 2.3911, 0, 0, 0.930417, 0.366502, 180, 255, 1, '', NULL, 70938),
(910620058, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14411.8, 423.773, 9.83538, 4.79966, 0, 0, -0.67559, 0.737278, 180, 255, 1, '', NULL, 70938),
(910620059, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14412.6, 419.929, 23.2535, 5.44543, 0, 0, -0.406736, 0.913546, 180, 255, 1, '', NULL, 70938),
(910620060, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14443, 453.212, 16.4388, 0.366518, 0, 0, 0.182235, 0.983255, 180, 255, 1, '', NULL, 70938),
(910620061, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14447.3, 484.714, 16.1075, 0.95993, 0, 0, 0.461748, 0.887011, 180, 255, 1, '', NULL, 70938),
(910620062, 180754, 0, 0, 0, '0', 0, 0, 0, -1, -14458.9, 426.968, 26.223, 4.62512, 0, 0, -0.737277, 0.675591, 180, 255, 1, '', NULL, 70938),
(910620063, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14458.2, 425.221, 25.1342, 0.523598, 0, 0, 0.258819, 0.965926, 180, 255, 1, '', NULL, 70938),
(910620064, 180698, 0, 0, 0, '0', 0, 0, 0, -1, -14324.3, 448.045, 22.9496, 6.02139, 0, 0, -0.130526, 0.991445, 180, 255, 1, '', NULL, 70938),
(910620065, 180698, 0, 0, 0, '0', 0, 0, 0, -1, -14346.2, 439.547, 7.43393, 5.37562, 0, 0, -0.438371, 0.898794, 180, 255, 1, '', NULL, 70938),
(910620066, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14305.5, 527.585, 8.64799, 5.51524, 0, 0, -0.374606, 0.927184, 180, 255, 1, '', NULL, 70938),
(910620067, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14323.8, 451.201, 23.1549, 6.03884, 0, 0, -0.121869, 0.992546, 180, 255, 1, '', NULL, 70938),
(910620068, 180698, 0, 0, 0, '0', 0, 0, 0, -1, -14400.4, 414.542, 22.5606, 1.11701, 0, 0, 0.529919, 0.848048, 180, 255, 1, '', NULL, 70938),
(910620069, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14323.9, 470.009, 8.34166, 3.21142, 0, 0, -0.999391, 0.034906, 180, 255, 1, '', NULL, 70938),
(910620070, 180698, 0, 0, 0, '0', 0, 0, 0, -1, -14409, 422.393, 8.53757, 2.87979, 0, 0, 0.991445, 0.130528, 180, 255, 1, '', NULL, 70938),
(910620071, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14325.5, 445.049, 22.7047, 5.96903, 0, 0, -0.156434, 0.987688, 180, 255, 1, '', NULL, 70938),
(910620072, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14343.6, 441.722, 7.45835, 2.28638, 0, 0, 0.909961, 0.414694, 180, 255, 1, '', NULL, 70938),
(910620073, 180698, 0, 0, 0, '0', 0, 0, 0, -1, -14412.7, 423.767, 8.78997, 1.23918, 0, 0, 0.580703, 0.814116, 180, 255, 1, '', NULL, 70938),
(910620074, 180905, 0, 0, 0, '0', 0, 0, 0, -1, -14345.2, 439.924, 8.57175, 0.418879, 0, 0, 0.207911, 0.978148, 180, 255, 1, '', NULL, 70938),
(910620075, 180699, 0, 0, 0, '0', 0, 0, 0, -1, -14350.6, 436.631, 7.39575, 2.23402, 0, 0, 0.898793, 0.438373, 180, 255, 1, '', NULL, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject` x ON x.`id` = s.`id` AND x.`map` = s.`map` AND (x.`position_x` - s.`position_x`) * (x.`position_x` - s.`position_x`) + (x.`position_y` - s.`position_y`) * (x.`position_y` - s.`position_y`) <= 100 AND (EXISTS (SELECT 1 FROM `game_event_gameobject` e WHERE e.`guid` = x.`guid` AND e.`eventEntry` IN (1)) OR (NOT EXISTS (SELECT 1 FROM `game_event_gameobject` e WHERE e.`guid` = x.`guid` AND e.`eventEntry` > 0) AND NOT EXISTS (SELECT 1 FROM `game_event_gameobject` e WHERE e.`guid` = x.`guid` AND e.`eventEntry` IN (-1))));
DELETE s FROM `everlake_forge_stage` s JOIN `gameobject` x ON x.`guid` = s.`guid`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `gameobject_template` p WHERE p.`entry` = `everlake_forge_stage`.`id`);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild`) SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'gameobject', s.`guid`, 0, 0, 0, '2026_11_16_900_world_everlake_forge_00042_import.sql', 'Forge #42: Classic database 2026-11-16: Midsummer Fire Festival' FROM `everlake_forge_stage` s;

-- creature: 6 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `creature` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`) VALUES
(910620000, 15723, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -14321.7, 437.662, 22.6407, 2.7362, 120, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910620001, 15723, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -14338.9, 446.054, 7.6281, 3.8301, 120, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910620002, 15723, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -14341.4, 444.062, 7.5659, 0.6885, 120, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910620003, 15723, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -14370.7, 379.381, 23.2468, 4.3004, 120, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910620004, 15723, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -14443, 459.812, 15.4692, 5.1394, 120, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938),
(910620005, 15723, 0, 0, 0, '0', 0, 0, 0, -1, 0, 0, -14393, 418.553, 7.7149, 3.2973, 120, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, '', NULL, 70938);
DELETE s FROM `everlake_forge_stage` s JOIN `creature` x ON x.`id` = s.`id` AND x.`map` = s.`map` AND (x.`position_x` - s.`position_x`) * (x.`position_x` - s.`position_x`) + (x.`position_y` - s.`position_y`) * (x.`position_y` - s.`position_y`) <= 900 AND (EXISTS (SELECT 1 FROM `game_event_creature` e WHERE e.`guid` = x.`guid` AND e.`eventEntry` IN (1)) OR (NOT EXISTS (SELECT 1 FROM `game_event_creature` e WHERE e.`guid` = x.`guid` AND e.`eventEntry` > 0) AND NOT EXISTS (SELECT 1 FROM `game_event_creature` e WHERE e.`guid` = x.`guid` AND e.`eventEntry` IN (-1))));
DELETE s FROM `everlake_forge_stage` s JOIN `creature` x ON x.`guid` = s.`guid`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature_template` p WHERE p.`entry` = `everlake_forge_stage`.`id`);
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild`) SELECT `guid`, `id`, `map`, `zoneId`, `areaId`, `spawnDifficulties`, `phaseUseFlags`, `PhaseId`, `PhaseGroup`, `terrainSwapMap`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curHealthPct`, `MovementType`, `npcflag`, `unit_flags`, `unit_flags2`, `unit_flags3`, `ScriptName`, `StringId`, `VerifiedBuild` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'creature', s.`guid`, 0, 0, 0, '2026_11_16_900_world_everlake_forge_00042_import.sql', 'Forge #42: Classic database 2026-11-16: Midsummer Fire Festival' FROM `everlake_forge_stage` s;

-- game_event_gameobject: 76 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `eventEntry`, `guid` FROM `game_event_gameobject` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`eventEntry`, `guid`) VALUES
(1, 910620000),
(1, 910620001),
(1, 910620002),
(1, 910620003),
(1, 910620004),
(1, 910620005),
(1, 910620006),
(1, 910620007),
(1, 910620008),
(1, 910620009),
(1, 910620010),
(1, 910620011),
(1, 910620012),
(1, 910620013),
(1, 910620014),
(1, 910620015),
(1, 910620016),
(1, 910620017),
(1, 910620018),
(1, 910620019),
(1, 910620020),
(1, 910620021),
(1, 910620022),
(1, 910620023),
(1, 910620024),
(1, 910620025),
(1, 910620026),
(1, 910620027),
(1, 910620028),
(1, 910620029),
(1, 910620030),
(1, 910620031),
(1, 910620032),
(1, 910620033),
(1, 910620034),
(1, 910620035),
(1, 910620036),
(1, 910620037),
(1, 910620038),
(1, 910620039),
(1, 910620040),
(1, 910620041),
(1, 910620042),
(1, 910620043),
(1, 910620044),
(1, 910620045),
(1, 910620046),
(1, 910620047),
(1, 910620048),
(1, 910620049),
(1, 910620050),
(1, 910620051),
(1, 910620052),
(1, 910620053),
(1, 910620054),
(1, 910620055),
(1, 910620056),
(1, 910620057),
(1, 910620058),
(1, 910620059),
(1, 910620060),
(1, 910620061),
(1, 910620062),
(1, 910620063),
(1, 910620064),
(1, 910620065),
(1, 910620066),
(1, 910620067),
(1, 910620068),
(1, 910620069),
(1, 910620070),
(1, 910620071),
(1, 910620072),
(1, 910620073),
(1, 910620074),
(1, 910620075);
DELETE s FROM `everlake_forge_stage` s JOIN `game_event_gameobject` x ON x.`guid` <=> s.`guid` AND x.`eventEntry` <=> s.`eventEntry`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `gameobject` p WHERE p.`guid` = `everlake_forge_stage`.`guid`);
INSERT INTO `game_event_gameobject` (`eventEntry`, `guid`) SELECT `eventEntry`, `guid` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'game_event_gameobject', s.`guid`, s.`eventEntry`, 0, 0, '2026_11_16_900_world_everlake_forge_00042_import.sql', 'Forge #42: Classic database 2026-11-16: Midsummer Fire Festival' FROM `everlake_forge_stage` s;

-- game_event_creature: 6 row(s)
DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
CREATE TEMPORARY TABLE `everlake_forge_stage` SELECT `eventEntry`, `guid` FROM `game_event_creature` LIMIT 0;
INSERT INTO `everlake_forge_stage` (`eventEntry`, `guid`) VALUES
(1, 910620000),
(1, 910620001),
(1, 910620002),
(1, 910620003),
(1, 910620004),
(1, 910620005);
DELETE s FROM `everlake_forge_stage` s JOIN `game_event_creature` x ON x.`guid` <=> s.`guid` AND x.`eventEntry` <=> s.`eventEntry`;
DELETE FROM `everlake_forge_stage` WHERE NOT EXISTS (SELECT 1 FROM `creature` p WHERE p.`guid` = `everlake_forge_stage`.`guid`);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) SELECT `eventEntry`, `guid` FROM `everlake_forge_stage`;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'game_event_creature', s.`guid`, s.`eventEntry`, 0, 0, '2026_11_16_900_world_everlake_forge_00042_import.sql', 'Forge #42: Classic database 2026-11-16: Midsummer Fire Festival' FROM `everlake_forge_stage` s;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
