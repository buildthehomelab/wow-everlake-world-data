-- Four Forever beasts hunters tame on live that the test realm gives no pet family and no tameable flag.
-- 2026_11_25_19_world_everlake_tameable_beasts.sql: written by hand from the tracker's kept facts (2026-11-25).
--
--   entry   creature               family            sources
--   270693  Daggerfang             6  Crocolisk      EG Link (family 6, tameable flag), Icy Veins, Wowhead "Tameable"
--   221328  Dreamwater Vicejaw     21 Turtle         Icy Veins (family 21, tameable), Wowhead "Tameable"
--   264079  Gloomrise Hatchling    3  Spider         EG Link, Icy Veins, Wowhead
--   264082  Broodmother Valraxx    3  Spider         EG Link and Wowhead tameable (Icy Veins: family 3, not tameable)
--
-- EG Link's recordings of the server's creature records, Icy Veins' WoW Forever database
-- (https://db.icy-veins.com/wow-forever/) and Wowhead's WoW Forever pages. The realm holds family 0 and TypeFlags 0 for
-- each, so Tame Beast refuses them. family is set, and the tameable type flag (0x1) on the normal difficulty row, only
-- while the rows still hold those values. Shadowgale Shrieker (256108) is left: only EG Link calls it tameable.
--
-- Running it again changes nothing. Not checked in game.

START TRANSACTION;

UPDATE `creature_template` SET `family` = 6 WHERE `entry` = 270693 AND `family` = 0 AND `type` = 1;
UPDATE `creature_template` SET `family` = 21 WHERE `entry` = 221328 AND `family` = 0 AND `type` = 1;
UPDATE `creature_template` SET `family` = 3 WHERE `entry` IN (264079, 264082) AND `family` = 0 AND `type` = 1;

UPDATE `creature_template_difficulty` SET `TypeFlags` = `TypeFlags` | 1
WHERE `Entry` IN (270693, 221328, 264079, 264082) AND `DifficultyID` = 0 AND `TypeFlags` = 0
  AND EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = `creature_template_difficulty`.`Entry` AND t.`family` > 0);

COMMIT;
