-- Mobs that are stealthed on live but stand visible on the realm. First found on 2434 Shadowy Assassin (Syndicate,
-- 37-38, Southshore): Marshal Redpath 2263 and the Southshore guards saw them and killed them over and over.
-- 2026_11_27_80_world_everlake_shadowy_assassin_stealth.sql: written by hand, not tried in game (2026-11-27).
--
-- How live does it (sources, the tracker's tables):
--   Wowhead WoW Forever npc 2434 abilities: 1785 Stealth, 744 Poison, 1604 Dazed.
--   Wowhead map + EG Link live recording + NorgannonDB: they stand in and around Southshore (zone 267, ~50,57), which is
--   where the realm's six spawns are (91524001-91524006, AnoCore restore). VMaNGOS, AzerothCore and TrinityCore place
--   none, so these six are the only ones.
-- The realm: creature_template_addon 2434 auras '3616' (Poison Proc), no stealth, no stealth in its SmartAI.
--
-- The same check over the whole realm (Wowhead WoW Forever npc abilities with a stealth spell, against the realm's
-- template auras, spawn auras and SmartAI casts):
--   a) 25 spawns whose own creature_addon row has empty auras. The core takes a spawn's addon row INSTEAD of the
--      template's (Creature::GetCreatureAddon), so their template stealth never goes on, and their SmartAI casts none:
--      Razormane Stalker 3457 (4), Deviate Stalker 3634 (2), Fallenroot Shadowstalker 4798 (13), Razorfen Stalker 6035
--      (1), Jadefire Shadowstalker 7110 (2), Putridus Shadowstalker 11792 (3), Hungry Bandit 252802 (1: 43000289; its
--      SmartAI re-casts Sneak only in combat). Their rows keep their paths; the auras get the template's.
--   b) Creatures with no stealth anywhere (no template addon row, no spawn addon rows, no AI): Wowhead lists Sneak 22766 for
--      Zulian Stalker 15067, Legashi Blackguard 236876, Nightsaber Guardian 249493, Dragonmaw Infiltrator 271346, and
--      Stealth 1784 for Wormwing Ambusher 249222. They get a template addon row with that aura.
--   c) Rares and quest creatures, looked at one by one: Tunnelweb Matriarch 250034 (rare elite ambush spider, Sneak
--      22766; its SmartAI only casts Web), Zarrat Wormwing 260826 (the named Wormwing Ambusher, Stealth 1784), and the
--      kittens Solstice 255685 and Whisperfur 255771 of Kits and Cats 93615 ("Find Shalla'kal's kittens", Sneak 22766;
--      Wowhead lists none for the third kitten, Brie 255773, so the hiding is per kitten) get the same template row.
--   d) A second pass over every idle stealth Wowhead lists (Stealth, Prowl, Sneak, Faded, Hide, Shadowmeld, Greater
--      Invisibility and Forever's own stealth spells, not Vanish or timed ones): Thicket Lurker 260800 (6, dungeon 2998;
--      Stealth 1286462, its SmartAI casts it only in combat) and Burrow Beetle 256714 (Stealth 1270035) get a template row.
--      Tamable cats that list only the hunter-pet Prowl ranks (Wowhead files those under the hunter class: what they
--      teach) are left out, and so are the quest NPCs Anastasia Miller 266847 and Deathstalker Masoj 270438.
--   Left out: Colonel Kurzen 813, whose VMaNGOS fight script already goes into stealth mid-fight (Smoke Bomb, Garrote
--   from stealth), and Perith Stormhoof 272203, giver of the escort The Longwalkers 98430: stealthed at rest he would
--   be hidden from the players who must find him; his Sneak is most likely used on the way out.
--
-- Rows for 2434: Stealth 1785 added to the template addon auras beside Poison Proc, so it is on at spawn and again after
-- evading. Only changed while the auras are still '3616'. Every change is recorded in everlake_import_rows.
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
SET @EVERLAKE_FILE := '2026_11_27_80_world_everlake_shadowy_assassin_stealth.sql';

START TRANSACTION;

UPDATE `creature_template_addon` a
SET a.`auras` = '3616 1785'
WHERE a.`entry` = 2434 AND a.`auras` = '3616';

INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_addon', 2434, 0, 0, 0, @EVERLAKE_FILE, 'auras 3616 -> 3616 1785 (Stealth); Wowhead Forever npc 2434 ability 1785'
FROM `creature_template_addon` a WHERE a.`entry` = 2434 AND a.`auras` = '3616 1785';


-- a) spawn rows with empty auras take their template's stealth
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_addon', ca.`guid`, 0, 0, 0, @EVERLAKE_FILE, CONCAT('auras empty -> template ', t.`auras`, ' (stealth; Wowhead Forever npc ', c.`id`, ')')
FROM `creature_addon` ca JOIN `creature` c ON c.`guid` = ca.`guid` JOIN `creature_template_addon` t ON t.`entry` = c.`id`
WHERE c.`id` IN (3457, 3634, 4798, 6035, 7110, 11792, 252802) AND IFNULL(ca.`auras`, '') = ''
  AND t.`auras` REGEXP '(^| )(22766|6408|5916)( |$)';
UPDATE `creature_addon` ca JOIN `creature` c ON c.`guid` = ca.`guid` JOIN `creature_template_addon` t ON t.`entry` = c.`id`
SET ca.`auras` = t.`auras`
WHERE c.`id` IN (3457, 3634, 4798, 6035, 7110, 11792, 252802) AND IFNULL(ca.`auras`, '') = ''
  AND t.`auras` REGEXP '(^| )(22766|6408|5916)( |$)';

-- b) + c) creatures with no stealth at all get a template addon row with Wowhead's stealth spell
CREATE TEMPORARY TABLE `everlake_build_stage` (`entry` INT UNSIGNED NOT NULL PRIMARY KEY, `auras` VARCHAR(32) NOT NULL, `note` VARCHAR(255) NOT NULL);
INSERT INTO `everlake_build_stage` (`entry`, `auras`, `note`) VALUES
(15067, '22766', 'Wowhead Forever npc 15067 ability 22766 Sneak (Zulian Stalker)'),
(236876, '22766', 'Wowhead Forever npc 236876 ability 22766 Sneak (Legashi Blackguard)'),
(249222, '1784', 'Wowhead Forever npc 249222 ability 1784 Stealth (Wormwing Ambusher)'),
(249493, '22766', 'Wowhead Forever npc 249493 ability 22766 Sneak (Nightsaber Guardian)'),
(271346, '22766', 'Wowhead Forever npc 271346 ability 22766 Sneak (Dragonmaw Infiltrator)'),
(250034, '22766', 'Wowhead Forever npc 250034 ability 22766 Sneak (Tunnelweb Matriarch, rare elite)'),
(260826, '1784', 'Wowhead Forever npc 260826 ability 1784 Stealth (Zarrat Wormwing)'),
(255685, '22766', 'Wowhead Forever npc 255685 ability 22766 Sneak (Solstice, Kits and Cats 93615)'),
(255771, '22766', 'Wowhead Forever npc 255771 ability 22766 Sneak (Whisperfur, Kits and Cats 93615)'),
(260800, '1286462', 'Wowhead Forever npc 260800 ability 1286462 Stealth (Thicket Lurker; its SmartAI casts it only in combat)'),
(256714, '1270035', 'Wowhead Forever npc 256714 ability 1270035 Stealth (Burrow Beetle)');
DELETE s FROM `everlake_build_stage` s
WHERE NOT EXISTS (SELECT 1 FROM `creature_template` t WHERE t.`entry` = s.`entry`)
   OR EXISTS (SELECT 1 FROM `creature_template_addon` a WHERE a.`entry` = s.`entry`);
INSERT INTO `creature_template_addon` (`entry`, `auras`) SELECT s.`entry`, s.`auras` FROM `everlake_build_stage` s;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_template_addon', s.`entry`, 0, 0, 0, @EVERLAKE_FILE, s.`note` FROM `everlake_build_stage` s;
DROP TEMPORARY TABLE `everlake_build_stage`;

COMMIT;
