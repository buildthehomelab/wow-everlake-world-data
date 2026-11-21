-- Two more vendor display mounts on their live entries (after 2026_11_21_02).
-- 2026_11_21_03_world_everlake_more_mount_displays.sql: written by hand from the ForeverTracker's Extras > Old twin list.
--
-- As in _02: live sent records of Forever's display mounts (EG Link) and never of these Classic entries, and each spawn
-- stands in a vendor's pen beside the Forever displays of that pen's set (test realm's world, 2026-11-21):
--   20024764  12354 Brown Riding Kodo -> 267227   Bloodhoof kodo pen, 2 yd from Grey Riding Kodo 267226 and White
--                                                 Riding Kodo 267216 (the 26721x-26722x set). 267227 has a template.
--   20095123  14561 Swift Brown Steed -> 276891   Southshore stables, 6 yd from Swift Palomino 276893, 9 yd from Swift
--                                                 White Steed 276892 (the 27689x set).
-- 276891 has no template on the realm. EG Link's record of it (eg-link-output-wowf 1bf749ba, build 70959) is the record
-- of its Eastvale twin 276785 but for CreatureDifficultyID 360811: model 14583 at scale 1, beast, flags 134217728,
-- normal rank. Its template is the realm's 276892 (the same pen's Swift White Steed) with that name, model and
-- difficulty, so faction, speeds and the rest match its pen.
-- Not here: the two Theramore steeds (20095120, 20095124): no Forever display stands beside them to say which set.
-- Rows are added only where none exist and recorded in everlake_import_rows. Running it again changes nothing.

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

-- 276891 Swift Brown Steed: the template of 276892 with EG Link's name, model and difficulty
DROP TEMPORARY TABLE IF EXISTS `everlake_t`;
CREATE TEMPORARY TABLE `everlake_t` SELECT * FROM `creature_template` WHERE `entry` = 276892
  AND NOT EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 276891);
UPDATE `everlake_t` SET `entry` = 276891, `name` = 'Swift Brown Steed', `VerifiedBuild` = 0;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template', 276891, 0, 0, 0, '2026_11_21_03_world_everlake_more_mount_displays.sql', 'EG Link 1bf749ba record; rest as 276892' FROM `everlake_t`;
INSERT IGNORE INTO `creature_template` SELECT * FROM `everlake_t`;
DROP TEMPORARY TABLE `everlake_t`;

CREATE TEMPORARY TABLE `everlake_t` SELECT * FROM `creature_template_difficulty` WHERE `Entry` = 276892
  AND NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` WHERE `Entry` = 276891);
UPDATE `everlake_t` SET `Entry` = 276891, `CreatureDifficultyID` = 360811, `VerifiedBuild` = 0;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_difficulty', 276891, `DifficultyID`, 0, 0, '2026_11_21_03_world_everlake_more_mount_displays.sql', 'EG Link 1bf749ba record; rest as 276892' FROM `everlake_t`;
INSERT IGNORE INTO `creature_template_difficulty` SELECT * FROM `everlake_t`;
DROP TEMPORARY TABLE `everlake_t`;

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_model', 276891, 0, 0, 0, '2026_11_21_03_world_everlake_more_mount_displays.sql', 'EG Link 1bf749ba record' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `creature_template_model` WHERE `CreatureID` = 276891);
INSERT IGNORE INTO `creature_template_model` (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`, `VerifiedBuild`)
VALUES (276891, 0, 14583, 1, 1, 0);

-- the same pen's level and addon rows, where 276892 has them
CREATE TEMPORARY TABLE `everlake_t` SELECT * FROM `creature_classic_level` WHERE `entry` = 276892
  AND NOT EXISTS (SELECT 1 FROM `creature_classic_level` WHERE `entry` = 276891);
UPDATE `everlake_t` SET `entry` = 276891;
INSERT IGNORE INTO `creature_classic_level` SELECT * FROM `everlake_t`;
DROP TEMPORARY TABLE `everlake_t`;
CREATE TEMPORARY TABLE `everlake_t` SELECT * FROM `creature_template_addon` WHERE `entry` = 276892
  AND NOT EXISTS (SELECT 1 FROM `creature_template_addon` WHERE `entry` = 276891);
UPDATE `everlake_t` SET `entry` = 276891;
INSERT IGNORE INTO `creature_template_addon` SELECT * FROM `everlake_t`;
DROP TEMPORARY TABLE `everlake_t`;

-- the spawns (guid and spot kept), only while they still hold the old entry and the live one has a template
UPDATE `creature` SET `id` = 267227, `modelid` = 0 WHERE `guid` = 20024764 AND `id` = 12354
  AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 267227);
UPDATE `creature` SET `id` = 276891, `modelid` = 0 WHERE `guid` = 20095123 AND `id` = 14561
  AND EXISTS (SELECT 1 FROM `creature_template` WHERE `entry` = 276891);

COMMIT;
