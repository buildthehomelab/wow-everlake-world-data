-- Dungeon spawns far from every spot live players saw their creature: moved onto EG Link's live spots.
-- 2026_11_28_30_world_everlake_dungeon_spawns_off_eglink.sql: written by hand, not tried in game (2026-11-28).
--
-- Every creature of the Forever-only dungeons was placed by hand with INFERRED spots (no sniffs exist; Wowhead's Forever
-- database has no pins inside instances). EG Link's live recordings (the tracker's answers table, source eglink, kind
-- creatures, combatLog.positions) give world positions (map, x, y) where players met each creature, exact to under a
-- yard where a sniffed spawn exists to check them. Checked on the PTR's world, 2026-11-27:
--
--   The Drowned City (2970): 266 of 267 spawns within 15 yards of a live spot. Nothing to move.
--   Blackmaw Hold (2974): 111 spawns, 82 more than 40 yards from every live spot of their creature.
--   Alcaz Prison (2994): 34 spawns, 9 more than 40 yards off.
--   Krol'dok Stronghold (3039): 80 spawns, 50 more than 40 yards off (Overlord Mugg 760 yards, the war wolves ~425).
--   The Shaper's Terrace (3001): EG Link has no record of the map. Not checked.
--
-- Each of those spawns moves onto a live spot of its own creature (spots closer than 2 yards are one), never one a
-- well-placed spawn of the creature already stands on (5 yards), closest pairs first. 128 move. Left as they are:
--   12 spawns past the live count (more spawns than live spots): Legashi Plaguebringer 268864 x7 (2 live spots),
--     Legashi Summoner 247248 x3, Blackmaw Shaman 258508 x1, Blackmaw Druid 258516 x1. Removing them changes the
--     dungeon's pulls: for the realm owner.
--   Varrox Bleakhoof 247234 (974000103): his live spot is over a floor at -62.5 on a navmesh piece of its own, while he
--     and the safe location "in front of Varrox Bleakhoof" (world_safe_locs 1104142) stand at -101. For the realm owner.
-- Heights: EG Link gives none. Each spot takes the walkable floor of the server's navmesh (mmaps) that joins the
-- dungeon's entrance (world_safe_locs; Alcaz Prison's entrance stands on a cut-off piece, so its main piece), then the
-- exact surface under it from the maps and vmaps (tools/height.py of the tracker, the navmesh z as hint). On spawns
-- already placed well the navmesh floor is within about a yard of their z. Where two joined floors lie under a spot
-- (4 spawns) the one nearer the closest single-floor spot is taken: marked "floor INFERRED".
-- All 128 are plain spawns: MovementType 0, no path, formation, pool or game event. The instance scripts place nothing
-- by these positions (their adds are summoned around the boss). Orientation is kept.
-- Rows change only while they stand where the import put them. Every change is recorded in everlake_import_rows.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';
SET @EVERLAKE_FILE := '2026_11_28_30_world_everlake_dungeon_spawns_off_eglink.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_moves`;
CREATE TEMPORARY TABLE `everlake_moves` (`guid` BIGINT UNSIGNED NOT NULL PRIMARY KEY, `id` INT UNSIGNED NOT NULL,
  `old_x` FLOAT NOT NULL, `old_y` FLOAT NOT NULL, `x` FLOAT NOT NULL, `y` FLOAT NOT NULL, `z` FLOAT NOT NULL, `note` VARCHAR(160) NOT NULL);
INSERT INTO `everlake_moves` VALUES
(974000000, 247195, 3694.70, 3428.00, 3684.88, 3506.82, 294.38, 'Withermaw: 79 yd onto an EG Link live spot of its own creature'),
(974000001, 247198, 3386.70, 3370.70, 3540.98, 3355.20, 258.29, 'Bonesnout the Unbroken: 155 yd onto an EG Link live spot of its own creature'),
(974000002, 247206, 3320.00, 3578.70, 3266.90, 3596.75, 350.05, 'Impaan the Imprisoner: 56 yd onto an EG Link live spot of its own creature'),
(974000003, 247235, 3337.30, 3394.70, 3367.73, 3468.63, 318.92, 'Legashi Subjugator: 80 yd onto an EG Link live spot of its own creature'),
(974000004, 247235, 3328.00, 3394.70, 3313.03, 3482.43, 339.26, 'Legashi Subjugator: 89 yd onto an EG Link live spot of its own creature'),
(974000007, 247237, 3445.30, 3578.70, 3425.06, 3515.15, 299.84, 'Blackmaw Berserker: 67 yd onto an EG Link live spot of its own creature'),
(974000008, 247237, 3445.30, 3586.70, 3428.70, 3510.15, 298.76, 'Blackmaw Berserker: 78 yd onto an EG Link live spot of its own creature'),
(974000009, 247237, 3470.70, 3637.30, 3429.45, 3666.88, 302.81, 'Blackmaw Berserker: 50 yd onto an EG Link live spot of its own creature'),
(974000010, 247237, 3478.70, 3637.30, 3426.83, 3696.32, 300.57, 'Blackmaw Berserker: 79 yd onto an EG Link live spot of its own creature'),
(974000012, 247248, 3320.00, 3320.00, 3280.20, 3510.20, 341.59, 'Legashi Summoner: 194 yd onto an EG Link live spot of its own creature'),
(974000013, 247248, 3445.30, 3386.70, 3473.18, 3595.85, 297.48, 'Legashi Summoner: 211 yd onto an EG Link live spot of its own creature'),
(974000014, 247248, 3437.30, 3386.70, 3398.90, 3478.69, 305.60, 'Legashi Summoner: 100 yd onto an EG Link live spot of its own creature'),
(974000018, 250023, 3445.30, 3620.00, 3475.25, 3571.98, 294.64, 'Blackmaw Thrall: 57 yd onto an EG Link live spot of its own creature'),
(974000019, 250023, 3445.30, 3628.00, 3424.92, 3667.80, 302.93, 'Blackmaw Thrall: 45 yd onto an EG Link live spot of its own creature'),
(974000022, 250027, 3428.00, 3670.70, 3470.00, 3516.40, 294.50, 'Blackmaw Headhunter: 160 yd onto an EG Link live spot of its own creature'),
(974000023, 250027, 3420.00, 3670.70, 3422.43, 3509.70, 299.17, 'Blackmaw Headhunter: 161 yd onto an EG Link live spot of its own creature'),
(974000025, 255347, 3328.00, 3370.70, 3314.51, 3325.34, 261.77, 'Legashi Slayer: 47 yd onto an EG Link live spot of its own creature'),
(974000026, 255347, 3337.30, 3428.00, 3314.47, 3484.28, 338.70, 'Legashi Slayer: 61 yd onto an EG Link live spot of its own creature'),
(974000027, 255347, 3337.30, 3420.00, 3282.06, 3422.36, 250.68, 'Legashi Slayer: 55 yd onto an EG Link live spot of its own creature'),
(974000028, 255394, 3445.30, 3545.30, 3444.64, 3654.03, 302.02, 'Blackmaw Champion: 109 yd onto an EG Link live spot of its own creature'),
(974000029, 255394, 3437.30, 3545.30, 3461.95, 3333.58, 308.62, 'Blackmaw Champion: 213 yd onto an EG Link live spot of its own creature'),
(974000030, 255394, 3512.00, 3561.30, 3702.39, 2978.98, 173.28, 'Blackmaw Champion: 613 yd onto an EG Link live spot of its own creature'),
(974000031, 255394, 3504.00, 3561.30, 3507.74, 3106.48, 165.44, 'Blackmaw Champion: 455 yd onto an EG Link live spot of its own creature; floor INFERRED (two walkable floors)'),
(974000032, 258152, 3512.00, 3586.70, 3548.78, 2874.58, 169.48, 'Blackmaw Spearfisher: 713 yd onto an EG Link live spot of its own creature'),
(974000033, 258152, 3553.30, 3570.70, 3655.23, 3068.82, 188.85, 'Blackmaw Spearfisher: 512 yd onto an EG Link live spot of its own creature'),
(974000034, 258152, 3578.70, 3570.70, 3656.12, 3075.87, 188.86, 'Blackmaw Spearfisher: 501 yd onto an EG Link live spot of its own creature'),
(974000035, 258264, 3720.00, 3394.70, 3700.69, 3478.98, 298.71, 'Depraved Owlbeast: 86 yd onto an EG Link live spot of its own creature'),
(974000036, 258264, 3720.00, 3386.70, 3674.88, 3471.47, 289.71, 'Depraved Owlbeast: 96 yd onto an EG Link live spot of its own creature'),
(974000037, 258264, 3670.70, 3353.30, 3628.63, 3343.10, 276.17, 'Depraved Owlbeast: 43 yd onto an EG Link live spot of its own creature'),
(974000038, 258264, 3678.70, 3353.30, 3643.03, 3420.85, 290.19, 'Depraved Owlbeast: 76 yd onto an EG Link live spot of its own creature'),
(974000047, 258508, 3470.70, 3528.00, 3554.96, 2870.83, 169.78, 'Blackmaw Shaman: 663 yd onto an EG Link live spot of its own creature'),
(974000048, 258508, 3470.70, 3537.30, 3495.09, 2833.59, 193.38, 'Blackmaw Shaman: 704 yd onto an EG Link live spot of its own creature'),
(974000050, 258508, 3420.00, 3704.00, 3500.97, 2833.74, 193.03, 'Blackmaw Shaman: 874 yd onto an EG Link live spot of its own creature'),
(974000051, 258516, 3561.30, 3545.30, 3559.67, 2850.65, 168.85, 'Blackmaw Druid: 695 yd onto an EG Link live spot of its own creature'),
(974000053, 258516, 3528.00, 3520.00, 3690.89, 2940.00, 173.55, 'Blackmaw Druid: 602 yd onto an EG Link live spot of its own creature'),
(974000054, 258516, 3537.30, 3520.00, 3697.08, 3006.13, 177.26, 'Blackmaw Druid: 538 yd onto an EG Link live spot of its own creature'),
(974000055, 258668, 3370.70, 3378.70, 3308.01, 3326.56, 261.80, 'Legashi Ritualist: 82 yd onto an EG Link live spot of its own creature'),
(974000056, 258668, 3370.70, 3361.30, 3386.30, 3322.69, 249.95, 'Legashi Ritualist: 42 yd onto an EG Link live spot of its own creature'),
(974000058, 258668, 3404.00, 3370.70, 3501.68, 3366.69, 254.61, 'Legashi Ritualist: 98 yd onto an EG Link live spot of its own creature'),
(974000067, 268864, 3378.70, 3537.30, 3575.24, 3436.19, 295.28, 'Legashi Plaguebringer: 221 yd onto an EG Link live spot of its own creature'),
(974000068, 268864, 3378.70, 3545.30, 3662.83, 3434.29, 292.19, 'Legashi Plaguebringer: 305 yd onto an EG Link live spot of its own creature'),
(974000100, 247207, 3665.00, 2905.00, 3463.57, 2956.51, 135.72, 'Blackmaw Behemoth: 208 yd onto an EG Link live spot of its own creature'),
(974000101, 247209, 3495.00, 3165.00, 3681.30, 2868.78, 172.07, 'Elder Shaman Bloodmane: 350 yd onto an EG Link live spot of its own creature'),
(974000104, 247235, 3400.00, 2885.00, 3517.74, 3101.99, 165.83, 'Legashi Subjugator: 247 yd onto an EG Link live spot of its own creature; floor INFERRED (two walkable floors)'),
(974000105, 247235, 3395.00, 2880.00, 3629.50, 3080.86, 299.32, 'Legashi Subjugator: 309 yd onto an EG Link live spot of its own creature; floor INFERRED (two walkable floors)'),
(974000106, 247235, 3440.00, 2850.00, 3468.62, 2918.05, 135.71, 'Legashi Subjugator: 74 yd onto an EG Link live spot of its own creature'),
(974000107, 247235, 3500.00, 3040.00, 3545.50, 3007.66, 146.58, 'Legashi Subjugator: 56 yd onto an EG Link live spot of its own creature'),
(974000108, 247237, 3300.00, 2895.00, 3581.45, 3077.05, 181.81, 'Blackmaw Berserker: 335 yd onto an EG Link live spot of its own creature'),
(974000109, 247237, 3295.00, 2900.00, 3595.59, 3055.13, 294.56, 'Blackmaw Berserker: 338 yd onto an EG Link live spot of its own creature'),
(974000110, 247237, 3310.00, 2935.00, 3459.81, 2921.18, 135.72, 'Blackmaw Berserker: 150 yd onto an EG Link live spot of its own creature'),
(974000111, 247237, 3305.00, 2930.00, 3527.80, 2978.59, 145.73, 'Blackmaw Berserker: 228 yd onto an EG Link live spot of its own creature'),
(974000113, 247248, 3410.00, 2840.00, 3575.82, 2884.97, 169.93, 'Legashi Summoner: 172 yd onto an EG Link live spot of its own creature'),
(974000114, 247248, 3465.00, 3060.00, 3519.95, 2990.38, 145.30, 'Legashi Summoner: 89 yd onto an EG Link live spot of its own creature'),
(974000116, 247996, 3660.00, 2905.00, 3463.68, 2959.27, 135.72, 'Clawbert: 204 yd onto an EG Link live spot of its own creature'),
(974000120, 255347, 3520.00, 2825.00, 3525.60, 2973.28, 145.98, 'Legashi Slayer: 148 yd onto an EG Link live spot of its own creature'),
(974000121, 255347, 3340.00, 2880.00, 3531.42, 2974.11, 145.92, 'Legashi Slayer: 213 yd onto an EG Link live spot of its own creature'),
(974000122, 255347, 3335.00, 2885.00, 3541.47, 3009.98, 146.41, 'Legashi Slayer: 241 yd onto an EG Link live spot of its own creature'),
(974000125, 255394, 3345.00, 2985.00, 3465.15, 3027.70, 234.73, 'Blackmaw Champion: 128 yd onto an EG Link live spot of its own creature'),
(974000126, 255394, 3340.00, 2990.00, 3526.09, 2992.16, 145.30, 'Blackmaw Champion: 186 yd onto an EG Link live spot of its own creature'),
(974000127, 258508, 3620.00, 3065.00, 3679.42, 3052.44, 188.76, 'Blackmaw Shaman: 61 yd onto an EG Link live spot of its own creature'),
(974000128, 258508, 3625.00, 3070.00, 3672.31, 3044.15, 188.56, 'Blackmaw Shaman: 54 yd onto an EG Link live spot of its own creature'),
(974000129, 258508, 3560.00, 3120.00, 3501.52, 3013.38, 145.26, 'Blackmaw Shaman: 122 yd onto an EG Link live spot of its own creature'),
(974000130, 258508, 3565.00, 3125.00, 3693.23, 2937.40, 173.85, 'Blackmaw Shaman: 227 yd onto an EG Link live spot of its own creature'),
(974000135, 277474, 3505.00, 3160.00, 3686.69, 2913.44, 172.08, 'Blackmaw Devotee: 306 yd onto an EG Link live spot of its own creature'),
(974000136, 277474, 3510.00, 3165.00, 3663.63, 2894.96, 172.07, 'Blackmaw Devotee: 311 yd onto an EG Link live spot of its own creature'),
(974000137, 277474, 3480.00, 3155.00, 3649.05, 2885.73, 172.07, 'Blackmaw Devotee: 318 yd onto an EG Link live spot of its own creature'),
(974000138, 277474, 3515.00, 3160.00, 3657.72, 2902.24, 172.07, 'Blackmaw Devotee: 295 yd onto an EG Link live spot of its own creature'),
(974000139, 277474, 3515.00, 3170.00, 3681.75, 2905.50, 172.07, 'Blackmaw Devotee: 313 yd onto an EG Link live spot of its own creature'),
(974000140, 277474, 3520.00, 3165.00, 3681.16, 2912.46, 172.08, 'Blackmaw Devotee: 300 yd onto an EG Link live spot of its own creature'),
(974001002, 255267, -8798.00, 2877.00, -8847.16, 2874.83, 13.53, 'Slavering Hound: 49 yd onto an EG Link live spot of its own creature'),
(974001004, 255267, -8792.00, 2892.00, -8851.64, 2878.73, 13.53, 'Slavering Hound: 61 yd onto an EG Link live spot of its own creature'),
(974001005, 255271, -8828.00, 2892.00, -8805.74, 2944.72, 7.03, 'Defias Truthfinder: 57 yd onto an EG Link live spot of its own creature'),
(974001006, 255271, -8867.00, 2886.00, -8855.13, 2966.09, 7.03, 'Defias Truthfinder: 81 yd onto an EG Link live spot of its own creature'),
(974001015, 255369, -8846.00, 2973.00, -8804.53, 2934.13, 7.03, 'Arcane Servitor: 57 yd onto an EG Link live spot of its own creature'),
(974001018, 255377, -8759.00, 2931.00, -8746.66, 2888.16, 14.44, 'Alcaz Jailer: 45 yd onto an EG Link live spot of its own creature'),
(974001019, 255377, -8759.00, 2937.00, -8763.07, 2868.88, 14.18, 'Alcaz Jailer: 68 yd onto an EG Link live spot of its own creature'),
(974001026, 256236, -8753.00, 2934.00, -8764.00, 2854.17, 13.19, 'The Questioner: 81 yd onto an EG Link live spot of its own creature'),
(974001032, 271784, -8795.00, 2922.00, -8840.92, 2889.90, 14.44, 'Alcaz Jailer: 56 yd onto an EG Link live spot of its own creature'),
(48110000, 258966, -7455.63, -3769.81, -7521.08, -3851.43, 123.68, 'Slavecrusher Grox: 105 yd onto an EG Link live spot of its own creature'),
(48110001, 258972, -7370.91, -3985.64, -7494.58, -4077.03, 151.32, 'Twilight Commander Zarmok: 154 yd onto an EG Link live spot of its own creature'),
(48110002, 259281, -7544.86, -4177.56, -7272.43, -4504.91, 176.90, 'War Handler Ashka: 426 yd onto an EG Link live spot of its own creature'),
(48110003, 258964, -7367.19, -4323.94, -7310.25, -4033.80, 264.42, 'Nar''gurk: 296 yd onto an EG Link live spot of its own creature'),
(48110004, 264773, -7257.15, -4154.90, -7166.47, -4441.55, 181.53, 'Bossman Toof: 301 yd onto an EG Link live spot of its own creature; floor INFERRED (two walkable floors)'),
(48110005, 258968, -7328.87, -4008.90, -6831.80, -4583.32, 241.26, 'Overlord Mugg: 760 yd onto an EG Link live spot of its own creature'),
(48110006, 259283, -7540.73, -4177.53, -7253.88, -4485.86, 177.18, 'Snarlfang: 421 yd onto an EG Link live spot of its own creature'),
(48110007, 259285, -7548.91, -4178.22, -7253.72, -4485.38, 177.22, 'Terrorhowl: 426 yd onto an EG Link live spot of its own creature'),
(48110008, 257888, -7252.43, -4154.07, -7105.39, -4247.26, 209.25, 'Krol''dok Shaman: 174 yd onto an EG Link live spot of its own creature'),
(48110009, 257888, -7263.09, -4154.10, -7101.74, -4257.20, 207.29, 'Krol''dok Shaman: 191 yd onto an EG Link live spot of its own creature'),
(48110010, 258038, -7612.20, -3722.98, -7312.77, -4058.91, 261.60, 'Shadowhide Bully: 450 yd onto an EG Link live spot of its own creature'),
(48110011, 257900, -7616.23, -3719.78, -7533.78, -3793.62, 130.63, 'Redridge Prisoner: 111 yd onto an EG Link live spot of its own creature'),
(48110012, 258687, -7616.63, -3724.85, -7549.69, -3795.46, 127.10, 'Krol''dok Brute: 97 yd onto an EG Link live spot of its own creature'),
(48110013, 258687, -7570.72, -3720.33, -7554.73, -3772.08, 132.67, 'Krol''dok Brute: 54 yd onto an EG Link live spot of its own creature'),
(48110014, 258042, -7576.31, -3721.75, -7528.23, -3723.16, 147.64, 'Twilight Grunt: 48 yd onto an EG Link live spot of its own creature'),
(48110015, 262065, -7532.20, -3736.42, -7279.56, -4476.61, 174.33, 'Riding Wolf: 782 yd onto an EG Link live spot of its own creature'),
(48110016, 262067, -7537.96, -3735.43, -7535.50, -4225.37, 151.62, 'Twilight Peon: 490 yd onto an EG Link live spot of its own creature'),
(48110019, 258104, -7502.99, -3756.80, -7462.85, -3778.20, 146.30, 'Twilight Lieutenant: 45 yd onto an EG Link live spot of its own creature'),
(48110023, 257900, -7394.64, -3804.09, -7465.22, -3876.88, 135.25, 'Redridge Prisoner: 101 yd onto an EG Link live spot of its own creature'),
(48110025, 258040, -7378.90, -3846.08, -7318.12, -4029.71, 264.33, 'Shadowhide Curseweaver: 193 yd onto an EG Link live spot of its own creature'),
(48110026, 258038, -7385.28, -3842.20, -7287.11, -4031.01, 262.85, 'Shadowhide Bully: 213 yd onto an EG Link live spot of its own creature'),
(48110030, 262067, -7367.57, -3922.01, -7560.93, -4209.62, 151.19, 'Twilight Peon: 347 yd onto an EG Link live spot of its own creature'),
(48110031, 257900, -7375.32, -3923.45, -7449.93, -3903.43, 120.47, 'Redridge Prisoner: 77 yd onto an EG Link live spot of its own creature'),
(48110035, 258100, -7452.94, -4042.21, -7331.56, -4020.31, 264.27, 'Twilight Warlock: 123 yd onto an EG Link live spot of its own creature'),
(48110037, 258687, -7458.93, -4043.76, -7418.50, -4016.21, 161.74, 'Krol''dok Brute: 49 yd onto an EG Link live spot of its own creature'),
(48110038, 262065, -7481.37, -4073.89, -7280.95, -4467.45, 174.19, 'Riding Wolf: 442 yd onto an EG Link live spot of its own creature'),
(48110039, 258687, -7486.40, -4074.46, -7408.82, -4025.66, 164.45, 'Krol''dok Brute: 92 yd onto an EG Link live spot of its own creature'),
(48110040, 257900, -7516.84, -4088.58, -7455.84, -3926.10, 124.63, 'Redridge Prisoner: 174 yd onto an EG Link live spot of its own creature'),
(48110041, 258038, -7521.04, -4087.52, -7318.98, -4063.08, 261.60, 'Shadowhide Bully: 204 yd onto an EG Link live spot of its own creature'),
(48110042, 258687, -7522.55, -4093.13, -7409.61, -4022.70, 163.47, 'Krol''dok Brute: 133 yd onto an EG Link live spot of its own creature'),
(48110043, 258687, -7529.09, -4130.80, -7530.80, -4222.85, 152.27, 'Krol''dok Brute: 92 yd onto an EG Link live spot of its own creature'),
(48110044, 258104, -7535.36, -4129.39, -7514.90, -4094.27, 151.66, 'Twilight Lieutenant: 41 yd onto an EG Link live spot of its own creature'),
(48110045, 258038, -7506.67, -4221.92, -7308.79, -4140.62, 255.05, 'Shadowhide Bully: 214 yd onto an EG Link live spot of its own creature'),
(48110049, 258102, -7488.92, -4252.07, -7337.43, -4416.60, 168.81, 'Twilight Outrider: 224 yd onto an EG Link live spot of its own creature'),
(48110050, 257885, -7484.98, -4256.05, -7323.58, -4246.92, 244.86, 'Krol''dok Centurion: 162 yd onto an EG Link live spot of its own creature'),
(48110054, 257900, -7434.56, -4314.49, -7312.65, -4065.94, 262.58, 'Redridge Prisoner: 277 yd onto an EG Link live spot of its own creature'),
(48110057, 262065, -7396.21, -4320.57, -7293.07, -4473.94, 173.82, 'Riding Wolf: 185 yd onto an EG Link live spot of its own creature'),
(48110058, 258687, -7398.56, -4322.95, -7438.28, -4297.79, 156.75, 'Krol''dok Brute: 47 yd onto an EG Link live spot of its own creature'),
(48110059, 257885, -7396.82, -4326.33, -7326.80, -4250.01, 244.87, 'Krol''dok Centurion: 104 yd onto an EG Link live spot of its own creature'),
(48110061, 258042, -7322.73, -4317.44, -7337.42, -4409.03, 168.10, 'Twilight Grunt: 93 yd onto an EG Link live spot of its own creature'),
(48110062, 257900, -7276.01, -4299.16, -7322.75, -4068.98, 261.60, 'Redridge Prisoner: 235 yd onto an EG Link live spot of its own creature'),
(48110063, 258038, -7281.97, -4299.63, -7324.17, -4221.04, 248.43, 'Shadowhide Bully: 89 yd onto an EG Link live spot of its own creature'),
(48110066, 258104, -7263.62, -4268.41, -7324.35, -4227.89, 247.46, 'Twilight Lieutenant: 73 yd onto an EG Link live spot of its own creature'),
(48110067, 257885, -7259.67, -4271.51, -7315.82, -4244.44, 244.77, 'Krol''dok Centurion: 62 yd onto an EG Link live spot of its own creature'),
(48110068, 258042, -7253.69, -4224.12, -7181.10, -4296.66, 187.35, 'Twilight Grunt: 103 yd onto an EG Link live spot of its own creature'),
(48110070, 258687, -7260.04, -4227.09, -7301.13, -4266.61, 244.51, 'Krol''dok Brute: 57 yd onto an EG Link live spot of its own creature'),
(48110072, 258687, -7247.10, -4101.85, -7310.02, -4265.60, 244.52, 'Krol''dok Brute: 175 yd onto an EG Link live spot of its own creature'),
(48110075, 258687, -7257.06, -4062.18, -7365.19, -3963.51, 167.01, 'Krol''dok Brute: 146 yd onto an EG Link live spot of its own creature'),
(48110076, 257885, -7254.96, -4065.08, -7319.35, -4246.06, 244.64, 'Krol''dok Centurion: 192 yd onto an EG Link live spot of its own creature'),
(48110077, 258687, -7282.43, -4043.34, -7352.70, -3960.86, 168.40, 'Krol''dok Brute: 108 yd onto an EG Link live spot of its own creature');
DELETE m FROM `everlake_moves` m
WHERE NOT EXISTS (SELECT 1 FROM `creature` c WHERE c.`guid` = m.`guid` AND c.`id` = m.`id`
  AND ABS(c.`position_x` - m.`old_x`) < 1 AND ABS(c.`position_y` - m.`old_y`) < 1);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature', m.`guid`, 0, 0, 0, @EVERLAKE_FILE, m.`note` FROM `everlake_moves` m;
UPDATE `creature` c JOIN `everlake_moves` m ON m.`guid` = c.`guid`
SET c.`position_x` = m.`x`, c.`position_y` = m.`y`, c.`position_z` = m.`z`;
DROP TEMPORARY TABLE `everlake_moves`;

COMMIT;
