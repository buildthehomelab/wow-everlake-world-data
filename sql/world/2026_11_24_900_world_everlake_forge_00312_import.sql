-- Everlake Forge #312: Import, 1 resource(s), 108 row(s)
-- 2026_11_24_900_world_everlake_forge_00312_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 71091) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: Wowhead 2026-11-24 (NOTICE.md, Forge exports).
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing: a row is added only
-- where none exists, spawns only where the same creature or object is not already within 5 yards, and each added row is recorded in everlake_import_rows.

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
-- values a source measured again: each statement names the value it replaces, so it changes nothing where the
-- row moved on, and nothing more when it runs again
UPDATE `creature_loot_template` SET `Chance` = 32.41 WHERE `Entry` = 247198 AND `ItemType` = 0 AND `Item` = 280059 AND ABS(`Chance` - 36.29) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 31.03 WHERE `Entry` = 247198 AND `ItemType` = 0 AND `Item` = 280061 AND ABS(`Chance` - 27.41) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.73 WHERE `Entry` = 247206 AND `ItemType` = 0 AND `Item` = 249698 AND ABS(`Chance` - 11.11) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 30.88 WHERE `Entry` = 247206 AND `ItemType` = 0 AND `Item` = 280056 AND ABS(`Chance` - 34.93) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 22.89 WHERE `Entry` = 247209 AND `ItemType` = 0 AND `Item` = 280070 AND ABS(`Chance` - 26.67) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 31.15 WHERE `Entry` = 247231 AND `ItemType` = 0 AND `Item` = 280072 AND ABS(`Chance` - 27.8) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 4.05 WHERE `Entry` = 247234 AND `ItemType` = 0 AND `Item` = 249692 AND ABS(`Chance` - 2.87) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.43 WHERE `Entry` = 247234 AND `ItemType` = 0 AND `Item` = 249698 AND ABS(`Chance` - 11.11) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.32 WHERE `Entry` = 247234 AND `ItemType` = 0 AND `Item` = 272027 AND ABS(`Chance` - 0.57) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 31.13 WHERE `Entry` = 247234 AND `ItemType` = 0 AND `Item` = 280074 AND ABS(`Chance` - 34.77) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 2.49 WHERE `Entry` = 247235 AND `ItemType` = 0 AND `Item` = 249698 AND ABS(`Chance` - 1.47) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.23 WHERE `Entry` = 247235 AND `ItemType` = 0 AND `Item` = 287032 AND ABS(`Chance` - 0.55) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 1.63 WHERE `Entry` = 247235 AND `ItemType` = 0 AND `Item` = 287034 AND ABS(`Chance` - 0.59) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.16 WHERE `Entry` = 247235 AND `ItemType` = 0 AND `Item` = 287035 AND ABS(`Chance` - 0.39) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 3.11 WHERE `Entry` = 247235 AND `ItemType` = 0 AND `Item` = 287036 AND ABS(`Chance` - 2.64) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.18 WHERE `Entry` = 247237 AND `ItemType` = 0 AND `Item` = 287029 AND ABS(`Chance` - 0.46) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.18 WHERE `Entry` = 247237 AND `ItemType` = 0 AND `Item` = 287035 AND ABS(`Chance` - 0.46) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 1.56 WHERE `Entry` = 247248 AND `ItemType` = 0 AND `Item` = 249698 AND ABS(`Chance` - 1.97) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 4.67 WHERE `Entry` = 247248 AND `ItemType` = 0 AND `Item` = 251453 AND ABS(`Chance` - 5.26) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 2.25 WHERE `Entry` = 247248 AND `ItemType` = 0 AND `Item` = 287034 AND ABS(`Chance` - 3.29) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 40.91 WHERE `Entry` = 247412 AND `ItemType` = 0 AND `Item` = 280081 AND ABS(`Chance` - 60) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 59.09 WHERE `Entry` = 247412 AND `ItemType` = 0 AND `Item` = 280082 AND ABS(`Chance` - 40) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.08 WHERE `Entry` = 250023 AND `ItemType` = 0 AND `Item` = 287028 AND ABS(`Chance` - 0.2) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.08 WHERE `Entry` = 250023 AND `ItemType` = 0 AND `Item` = 287029 AND ABS(`Chance` - 0.34) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.12 WHERE `Entry` = 250023 AND `ItemType` = 0 AND `Item` = 287030 AND ABS(`Chance` - 0.51) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.12 WHERE `Entry` = 250023 AND `ItemType` = 0 AND `Item` = 287032 AND ABS(`Chance` - 0.51) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.6 WHERE `Entry` = 250027 AND `ItemType` = 0 AND `Item` = 264231 AND ABS(`Chance` - 0.54) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.1 WHERE `Entry` = 250027 AND `ItemType` = 0 AND `Item` = 287029 AND ABS(`Chance` - 0.46) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.1 WHERE `Entry` = 250027 AND `ItemType` = 0 AND `Item` = 287030 AND ABS(`Chance` - 0.51) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.1 WHERE `Entry` = 250027 AND `ItemType` = 0 AND `Item` = 287035 AND ABS(`Chance` - 0.28) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.85 WHERE `Entry` = 253214 AND `ItemType` = 0 AND `Item` = 250183 AND ABS(`Chance` - 1.11) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.37 WHERE `Entry` = 253215 AND `ItemType` = 0 AND `Item` = 250183 AND ABS(`Chance` - 2.65) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.84 WHERE `Entry` = 255247 AND `ItemType` = 0 AND `Item` = 249698 AND ABS(`Chance` - 0.71) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 3.37 WHERE `Entry` = 255247 AND `ItemType` = 0 AND `Item` = 287036 AND ABS(`Chance` - 2.83) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.09 WHERE `Entry` = 255262 AND `ItemType` = 0 AND `Item` = 287018 AND ABS(`Chance` - 0.55) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.83 WHERE `Entry` = 255262 AND `ItemType` = 0 AND `Item` = 287020 AND ABS(`Chance` - 0.98) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.09 WHERE `Entry` = 255262 AND `ItemType` = 0 AND `Item` = 287022 AND ABS(`Chance` - 0.27) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.09 WHERE `Entry` = 255262 AND `ItemType` = 0 AND `Item` = 287024 AND ABS(`Chance` - 0.14) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.15 WHERE `Entry` = 255271 AND `ItemType` = 0 AND `Item` = 287018 AND ABS(`Chance` - 0.55) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.59 WHERE `Entry` = 255271 AND `ItemType` = 0 AND `Item` = 287020 AND ABS(`Chance` - 0.77) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.69 WHERE `Entry` = 255271 AND `ItemType` = 0 AND `Item` = 287021 AND ABS(`Chance` - 0.84) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.2 WHERE `Entry` = 255271 AND `ItemType` = 0 AND `Item` = 287022 AND ABS(`Chance` - 0.27) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.1 WHERE `Entry` = 255271 AND `ItemType` = 0 AND `Item` = 287024 AND ABS(`Chance` - 0.37) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.08 WHERE `Entry` = 255276 AND `ItemType` = 0 AND `Item` = 287018 AND ABS(`Chance` - 0.55) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.12 WHERE `Entry` = 255276 AND `ItemType` = 0 AND `Item` = 287022 AND ABS(`Chance` - 0.17) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.07 WHERE `Entry` = 255309 AND `ItemType` = 0 AND `Item` = 287017 AND ABS(`Chance` - 0.15) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.44 WHERE `Entry` = 255309 AND `ItemType` = 0 AND `Item` = 287019 AND ABS(`Chance` - 0.23) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.62 WHERE `Entry` = 255309 AND `ItemType` = 0 AND `Item` = 287021 AND ABS(`Chance` - 0.8) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.15 WHERE `Entry` = 255309 AND `ItemType` = 0 AND `Item` = 287023 AND ABS(`Chance` - 0.21) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 2.02 WHERE `Entry` = 255347 AND `ItemType` = 0 AND `Item` = 249698 AND ABS(`Chance` - 1.09) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.15 WHERE `Entry` = 255347 AND `ItemType` = 0 AND `Item` = 287030 AND ABS(`Chance` - 0.51) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.1 WHERE `Entry` = 255347 AND `ItemType` = 0 AND `Item` = 287031 AND ABS(`Chance` - 0.34) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.2 WHERE `Entry` = 255347 AND `ItemType` = 0 AND `Item` = 287032 AND ABS(`Chance` - 0.55) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.2 WHERE `Entry` = 255347 AND `ItemType` = 0 AND `Item` = 287033 AND ABS(`Chance` - 0.36) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.2 WHERE `Entry` = 255347 AND `ItemType` = 0 AND `Item` = 287035 AND ABS(`Chance` - 0.55) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 4.89 WHERE `Entry` = 255347 AND `ItemType` = 0 AND `Item` = 287036 AND ABS(`Chance` - 5.65) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.19 WHERE `Entry` = 255364 AND `ItemType` = 0 AND `Item` = 287018 AND ABS(`Chance` - 0.28) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.47 WHERE `Entry` = 255364 AND `ItemType` = 0 AND `Item` = 287019 AND ABS(`Chance` - 0.28) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.57 WHERE `Entry` = 255364 AND `ItemType` = 0 AND `Item` = 287020 AND ABS(`Chance` - 0.69) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.28 WHERE `Entry` = 255364 AND `ItemType` = 0 AND `Item` = 287022 AND ABS(`Chance` - 0.41) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.58 WHERE `Entry` = 255373 AND `ItemType` = 0 AND `Item` = 287019 AND ABS(`Chance` - 0.65) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.67 WHERE `Entry` = 255373 AND `ItemType` = 0 AND `Item` = 287020 AND ABS(`Chance` - 0.8) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 1.06 WHERE `Entry` = 255373 AND `ItemType` = 0 AND `Item` = 287021 AND ABS(`Chance` - 1.31) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.24 WHERE `Entry` = 255373 AND `ItemType` = 0 AND `Item` = 287022 AND ABS(`Chance` - 0.15) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.14 WHERE `Entry` = 255373 AND `ItemType` = 0 AND `Item` = 287023 AND ABS(`Chance` - 0.31) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.1 WHERE `Entry` = 255373 AND `ItemType` = 0 AND `Item` = 287024 AND ABS(`Chance` - 0.37) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.07 WHERE `Entry` = 255377 AND `ItemType` = 0 AND `Item` = 287017 AND ABS(`Chance` - 0.15) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.09 WHERE `Entry` = 255377 AND `ItemType` = 0 AND `Item` = 287018 AND ABS(`Chance` - 0.55) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.61 WHERE `Entry` = 255377 AND `ItemType` = 0 AND `Item` = 287019 AND ABS(`Chance` - 0.52) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.58 WHERE `Entry` = 255377 AND `ItemType` = 0 AND `Item` = 287020 AND ABS(`Chance` - 0.73) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.05 WHERE `Entry` = 255377 AND `ItemType` = 0 AND `Item` = 287024 AND ABS(`Chance` - 0.37) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.38 WHERE `Entry` = 255394 AND `ItemType` = 0 AND `Item` = 287032 AND ABS(`Chance` - 0.55) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 31.94 WHERE `Entry` = 255702 AND `ItemType` = 0 AND `Item` = 276745 AND ABS(`Chance` - 28.71) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.73 WHERE `Entry` = 255995 AND `ItemType` = 0 AND `Item` = 287019 AND ABS(`Chance` - 0.83) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.57 WHERE `Entry` = 255995 AND `ItemType` = 0 AND `Item` = 287020 AND ABS(`Chance` - 0.75) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.87 WHERE `Entry` = 255995 AND `ItemType` = 0 AND `Item` = 287021 AND ABS(`Chance` - 0.99) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.05 WHERE `Entry` = 255995 AND `ItemType` = 0 AND `Item` = 287024 AND ABS(`Chance` - 0.37) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.07 WHERE `Entry` = 255995 AND `ItemType` = 0 AND `Item` = 287026 AND ABS(`Chance` - 0.15) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 2.94 WHERE `Entry` = 256236 AND `ItemType` = 0 AND `Item` = 274028 AND ABS(`Chance` - 2.43) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 6.34 WHERE `Entry` = 258516 AND `ItemType` = 0 AND `Item` = 252893 AND ABS(`Chance` - 11.27) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 2.23 WHERE `Entry` = 258668 AND `ItemType` = 0 AND `Item` = 249698 AND ABS(`Chance` - 1.96) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 2.79 WHERE `Entry` = 258668 AND `ItemType` = 0 AND `Item` = 287034 AND ABS(`Chance` - 3.92) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 3.62 WHERE `Entry` = 258668 AND `ItemType` = 0 AND `Item` = 287036 AND ABS(`Chance` - 1.96) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 21.43 WHERE `Entry` = 261770 AND `ItemType` = 0 AND `Item` = 252938 AND ABS(`Chance` - 33.33) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 16.13 WHERE `Entry` = 261774 AND `ItemType` = 0 AND `Item` = 252938 AND ABS(`Chance` - 33.33) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.3 WHERE `Entry` = 261786 AND `ItemType` = 0 AND `Item` = 287040 AND ABS(`Chance` - 0.24) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.39 WHERE `Entry` = 261809 AND `ItemType` = 0 AND `Item` = 272028 AND ABS(`Chance` - 1.02) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 33.12 WHERE `Entry` = 261811 AND `ItemType` = 0 AND `Item` = 280012 AND ABS(`Chance` - 29.25) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 30.59 WHERE `Entry` = 261812 AND `ItemType` = 0 AND `Item` = 280018 AND ABS(`Chance` - 27.45) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 31.62 WHERE `Entry` = 261812 AND `ItemType` = 0 AND `Item` = 280020 AND ABS(`Chance` - 35.54) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 1.74 WHERE `Entry` = 261898 AND `ItemType` = 0 AND `Item` = 250183 AND ABS(`Chance` - 2.65) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 34.45 WHERE `Entry` = 262127 AND `ItemType` = 0 AND `Item` = 280022 AND ABS(`Chance` - 41.44) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 1.78 WHERE `Entry` = 268864 AND `ItemType` = 0 AND `Item` = 249698 AND ABS(`Chance` - 4.545) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 2.96 WHERE `Entry` = 268864 AND `ItemType` = 0 AND `Item` = 287034 AND ABS(`Chance` - 3.92) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 1.18 WHERE `Entry` = 268864 AND `ItemType` = 0 AND `Item` = 287036 AND ABS(`Chance` - 5.65) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 48.15 WHERE `Entry` = 269104 AND `ItemType` = 0 AND `Item` = 280079 AND ABS(`Chance` - 35.44) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 49.16 WHERE `Entry` = 269104 AND `ItemType` = 0 AND `Item` = 280080 AND ABS(`Chance` - 63.29) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 56.45 WHERE `Entry` = 269111 AND `ItemType` = 0 AND `Item` = 280077 AND ABS(`Chance` - 66.67) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 40.32 WHERE `Entry` = 269111 AND `ItemType` = 0 AND `Item` = 280078 AND ABS(`Chance` - 33.33) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 13.24 WHERE `Entry` = 271780 AND `ItemType` = 0 AND `Item` = 274028 AND ABS(`Chance` - 11.68) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.8 WHERE `Entry` = 271780 AND `ItemType` = 0 AND `Item` = 287019 AND ABS(`Chance` - 0.4) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.67 WHERE `Entry` = 271780 AND `ItemType` = 0 AND `Item` = 287020 AND ABS(`Chance` - 0.59) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.27 WHERE `Entry` = 271780 AND `ItemType` = 0 AND `Item` = 287021 AND ABS(`Chance` - 2.37) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 14.13 WHERE `Entry` = 271784 AND `ItemType` = 0 AND `Item` = 274028 AND ABS(`Chance` - 15.74) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.3 WHERE `Entry` = 271784 AND `ItemType` = 0 AND `Item` = 287018 AND ABS(`Chance` - 0.46) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 0.61 WHERE `Entry` = 271784 AND `ItemType` = 0 AND `Item` = 287019 AND ABS(`Chance` - 0.93) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 1.06 WHERE `Entry` = 271784 AND `ItemType` = 0 AND `Item` = 287020 AND ABS(`Chance` - 1.42) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 1.06 WHERE `Entry` = 271784 AND `ItemType` = 0 AND `Item` = 287021 AND ABS(`Chance` - 1.62) < 0.005 /* refresh */;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
