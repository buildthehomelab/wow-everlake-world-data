-- 96301 Power Wash (Marn Euhorn 264795, Mount Hyjal): "Enter the Well of Eternity and observe its effects on the
-- Venom-dripping Heart". Its objectives are server area trigger 42773 "Well of Eternity entered with the chimaera
-- heart" (type 19, area trigger enter) and the Vacant Heart 274163. The realm has no area trigger 42773, so neither
-- objective can be done.
-- 2026_11_26_80_world_everlake_power_wash_well_trigger.sql: written by hand, not tried in game (2026-11-26).
--
-- How live does it (sources):
--   Client DB2: Cleanse Heart (1293359) creates the Vacant Heart 274163 (SpellEffect 0, on the caster) and destroys
--     the Venom-dripping Heart 274162 (SpellEffect 1, effect 169), the quest's start item. Area trigger 42773 is not
--     in the client's AreaTrigger.db2: it is a server area trigger. The Eternity Cloth 274165 also uses Cleanse Heart
--     ("Dunk the venomous heart in the Well of Eternity"); nothing on the realm sells or makes that cloth.
--   EG Link objectives (build 71091, CC BY 4.0): objective 1 (event) was gained at map 1 5406.9 -3479.4 and the
--     Vacant Heart (objective 2) at 5405.4 -3480.0, the same moment: entering the well swaps the heart.
--   QuestieDB (foreverQuestTraces): triggerEnd "Well of Eternity entered with the chimaera heart" at Mount Hyjal
--     73.55 39.17, the same spot.
--   ForeverTracker tools/height.py at that point: water surface 1558.9, pool floor 1534.3.
--
-- Rows (the way 2026_11_19_987 placed 39304 and 33147): area trigger template 42773 (Blizzard's id, IsCustom 0, so the
-- objective names it), create properties 920020300 and a static spawn 920020300: a cylinder of radius 15 from z 1530 to
-- 1570 at EG Link's point, covering the water there (shape and size INFERRED: Blizzard's are not public).
-- Its action casts Cleanse Heart on the player who enters (a static trigger's caster is the player), which swaps the
-- heart; the core counts the area trigger objective first. Conditions (source 28): only players on 96301, not yet
-- complete, holding the heart 274162 enter it (INFERRED from the objective's text).
-- Rows are only added where missing. Each added row is recorded in everlake_import_rows.
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
SET @EVERLAKE_FILE := '2026_11_26_80_world_everlake_power_wash_well_trigger.sql';

START TRANSACTION;

-- area trigger 42773 (Blizzard's server id)
INSERT INTO `areatrigger_template` (`Id`, `IsCustom`, `Flags`, `ActionSetId`, `ActionSetFlags`, `VerifiedBuild`)
SELECT 42773, 0, 0, 0, 0, 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger_template` t WHERE t.`Id` = 42773 AND t.`IsCustom` = 0);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'areatrigger_template', 42773, 0, 0, 0, @EVERLAKE_FILE, 'quest 96301 objective area trigger'
FROM `areatrigger_template` t WHERE t.`Id` = 42773 AND t.`IsCustom` = 0;

-- entering it casts Cleanse Heart (1293359) on the player: Venom-dripping Heart 274162 -> Vacant Heart 274163
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`, `IsCustom`, `ActionType`, `ActionParam`, `TargetType`)
SELECT 42773, 0, 0, 1293359, 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger_template_actions` a WHERE a.`AreaTriggerId` = 42773 AND a.`IsCustom` = 0);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'areatrigger_template_actions', 42773, 0, 0, 0, @EVERLAKE_FILE, 'client SpellEffect 1293359; EG Link objectives 71091 (heart swapped on entry)'
FROM `areatrigger_template_actions` a WHERE a.`AreaTriggerId` = 42773 AND a.`IsCustom` = 0 AND a.`ActionParam` = 1293359;

-- only players on Power Wash (incomplete) who hold the Venom-dripping Heart enter it
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ConditionStringValue1`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
SELECT 28, 42773, 0, 0, 0, s.`ct`, 0, s.`v1`, s.`v2`, 0, '', 0, 0, 0, '', s.`c` FROM (
  SELECT 47 AS `ct`, 96301 AS `v1`, 8 AS `v2`, 'Well of Eternity trigger 42773 - Power Wash (96301) incomplete' AS `c`
  UNION ALL SELECT 2, 274162, 1, 'Well of Eternity trigger 42773 - holding the Venom-dripping Heart 274162'
) s
WHERE NOT EXISTS (SELECT 1 FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 28 AND c.`SourceGroup` = 42773 AND c.`SourceEntry` = 0);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'conditions', 28, 42773, 0, c.`ConditionTypeOrReference`, @EVERLAKE_FILE, 'INFERRED from the objective text (entered with the heart)'
FROM `conditions` c WHERE c.`SourceTypeOrReferenceId` = 28 AND c.`SourceGroup` = 42773 AND c.`SourceEntry` = 0 AND c.`ConditionTypeOrReference` IN (2, 47);

-- shape: cylinder, radius 15, 40 high (INFERRED)
INSERT INTO `areatrigger_create_properties` (`Id`, `IsCustom`, `AreaTriggerId`, `IsAreatriggerCustom`, `Shape`, `ShapeData0`, `ShapeData1`, `ShapeData2`, `ShapeData3`, `ShapeData4`, `ShapeData5`)
SELECT 920020300, 1, 42773, 0, 4, 15, 15, 40, 40, 0, 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger_create_properties` p WHERE p.`Id` = 920020300 AND p.`IsCustom` = 1);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'areatrigger_create_properties', 920020300, 1, 0, 0, @EVERLAKE_FILE, 'cylinder r15 h40 (INFERRED)'
FROM `areatrigger_create_properties` p WHERE p.`Id` = 920020300 AND p.`IsCustom` = 1 AND p.`AreaTriggerId` = 42773;

-- the spawn, in the Well of Eternity (map 1)
INSERT INTO `areatrigger` (`SpawnId`, `AreaTriggerCreatePropertiesId`, `IsCustom`, `MapId`, `SpawnDifficulties`, `PosX`, `PosY`, `PosZ`, `Orientation`, `PhaseUseFlags`, `PhaseId`, `PhaseGroup`, `ScriptName`, `Comment`, `VerifiedBuild`)
SELECT 920020300, 920020300, 1, 1, '0', 5406.9, -3479.4, 1530, 0, 1, 0, 0, '', 'Quest 96301 Power Wash - Well of Eternity entered with the chimaera heart (area trigger 42773)', 0 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `areatrigger` a WHERE a.`SpawnId` = 920020300);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'areatrigger', 920020300, 0, 0, 0, @EVERLAKE_FILE, 'EG Link objectives 71091 point + QuestieDB triggerEnd; z from height.py'
FROM `areatrigger` a WHERE a.`SpawnId` = 920020300 AND a.`AreaTriggerCreatePropertiesId` = 920020300;

COMMIT;
