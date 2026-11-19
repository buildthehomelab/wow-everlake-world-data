-- Quest items: templates and loot for 12 world objects that hold an item quests ask for.
-- 2026_11_19_939_world_everlake_quest_item_object_templates.sql: written by hand from EG Link's object_details (CC BY 4.0, eg-link-output-wowf c389a874).
--
-- 1. Seven objects the realm has no template for. Their template (type, model, size, the 35 data fields, lock and
--    loot id included) is EG Link's newest record of the client's object query, with the item it marks as the
--    object's quest item, and a loot row for that item (100 %, only while the quest needs it):
--      580100 Conqueror's Helm (build 70959): item 254392, quest 92743 A Conqueror's Crown
--      620424 Freshly Picked Berries (build 70938): item 265808, quest 94734 A Boar's Delight
--      629451 Powder Keg (build 70938): item 268346, quest 95123 A Blast Ye Scurvy Dogs!
--      660624 The Coldbringer's Eye (build 70959): item 276916, quest 96773/97196 The Coldbringer's Eye
--      667674 Explorers' League Supplies (build 70959): item 278403, quest 97617 Safety Checks
--      668515 Diplomatic Satchel (build 70959): item 279171, quest 86615 Treaty Obligations
--      669115 Lost Gryphon Egg (build 70959): item 279229, quest 86620 Fledgling Rescue
-- 2. Five objects the realm has a template for, whose loot id holds no rows, so they give nothing: the four Tablets of
--    I'lalai and The Lost Magic of the Runemasters. A loot row for their quest item, only while the realm's loot id
--    is the one EG Link records and that loot is still empty:
--      642943 The First Tablet of I'lalai: loot 140217, item 270308, quest 95775/95787 The Drowned City, Take Two With Water
--      642944 The Second Tablet of I'lalai: loot 140218, item 270309, quest 95775/95787
--      642945 The Third Tablet of I'lalai: loot 140219, item 270310, quest 95775/95787
--      642946 The Fourth Tablet of I'lalai: loot 140220, item 270311, quest 95775/95787
--      650929 The Lost Magic of the Runemasters: loot 140820, item 273169, quest 96800 Past Due
--
-- No spawns here: the tracker's locator places objects only once the realm has their template, so their spawns
-- come from it in a later file (as file 937's did). 25 more quest objects are known to no source with a template
-- (EG Link, DatabaseForever) and stay out. Not checked in game.
--
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added (docs/forever-import.md)';

START TRANSACTION;

-- Conqueror's Helm (580100, type 3): 92743 A Conqueror's Crown
SET @EVERLAKE_O580100 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 580100)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 580100);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 580100, 3, 114289, 'Conqueror''s Helm', '', '', '', 1.0, 43, 136084, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 70959 FROM DUAL WHERE @EVERLAKE_O580100 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 580100, 0, 254392, 70959 FROM DUAL WHERE @EVERLAKE_O580100 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 580100 AND `Idx` = 0);
SET @EVERLAKE_L580100 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 580100 AND `type` = 3 AND `Data1` = 136084)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 136084);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 136084, 0, 254392, 100, 1, 1, 0, 1, 1, 'Conqueror''s Helm' FROM DUAL WHERE @EVERLAKE_L580100 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 580100, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_O580100 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 580100, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_O580100 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 136084, 0, 254392, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_L580100 = 1;

-- Freshly Picked Berries (620424, type 3): 94734 A Boar's Delight
SET @EVERLAKE_O620424 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 620424)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 620424);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 620424, 3, 125757, 'Freshly Picked Berries', '', '', '', 0.5, 57, 138721, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 70938 FROM DUAL WHERE @EVERLAKE_O620424 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 620424, 0, 265808, 70938 FROM DUAL WHERE @EVERLAKE_O620424 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 620424 AND `Idx` = 0);
SET @EVERLAKE_L620424 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 620424 AND `type` = 3 AND `Data1` = 138721)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 138721);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 138721, 0, 265808, 100, 1, 1, 0, 1, 1, 'Freshly Picked Berries' FROM DUAL WHERE @EVERLAKE_L620424 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 620424, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70938 object_details' FROM DUAL WHERE @EVERLAKE_O620424 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 620424, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70938 object_details' FROM DUAL WHERE @EVERLAKE_O620424 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 138721, 0, 265808, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70938 object_details' FROM DUAL WHERE @EVERLAKE_L620424 = 1;

-- Powder Keg (629451, type 3): 95123 A Blast Ye Scurvy Dogs!
SET @EVERLAKE_O629451 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 629451)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 629451);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 629451, 3, 33, 'Powder Keg', '', '', '', 1.5, 43, 139539, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4099, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 70938 FROM DUAL WHERE @EVERLAKE_O629451 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 629451, 0, 268346, 70938 FROM DUAL WHERE @EVERLAKE_O629451 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 629451 AND `Idx` = 0);
SET @EVERLAKE_L629451 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 629451 AND `type` = 3 AND `Data1` = 139539)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 139539);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 139539, 0, 268346, 100, 1, 1, 0, 1, 1, 'Powder Keg' FROM DUAL WHERE @EVERLAKE_L629451 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 629451, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70938 object_details' FROM DUAL WHERE @EVERLAKE_O629451 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 629451, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70938 object_details' FROM DUAL WHERE @EVERLAKE_O629451 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 139539, 0, 268346, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70938 object_details' FROM DUAL WHERE @EVERLAKE_L629451 = 1;

-- The Coldbringer's Eye (660624, type 3): 96773/97196 The Coldbringer's Eye
SET @EVERLAKE_O660624 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 660624)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 660624);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 660624, 3, 127182, 'The Coldbringer''s Eye', '', '', '', 1.0, 0, 142133, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 162085, 0, 0, 4096, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 70959 FROM DUAL WHERE @EVERLAKE_O660624 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 660624, 0, 276916, 70959 FROM DUAL WHERE @EVERLAKE_O660624 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 660624 AND `Idx` = 0);
SET @EVERLAKE_L660624 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 660624 AND `type` = 3 AND `Data1` = 142133)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 142133);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 142133, 0, 276916, 100, 1, 1, 0, 1, 1, 'The Coldbringer''s Eye' FROM DUAL WHERE @EVERLAKE_L660624 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 660624, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_O660624 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 660624, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_O660624 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 142133, 0, 276916, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_L660624 = 1;

-- Explorers' League Supplies (667674, type 3): 97617 Safety Checks
SET @EVERLAKE_O667674 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 667674)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 667674);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 667674, 3, 128430, 'Explorers'' League Supplies', '', '', '', 0.4, 43, 142449, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 70959 FROM DUAL WHERE @EVERLAKE_O667674 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 667674, 0, 278403, 70959 FROM DUAL WHERE @EVERLAKE_O667674 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 667674 AND `Idx` = 0);
SET @EVERLAKE_L667674 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 667674 AND `type` = 3 AND `Data1` = 142449)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 142449);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 142449, 0, 278403, 100, 1, 1, 0, 1, 1, 'Explorers'' League Supplies' FROM DUAL WHERE @EVERLAKE_L667674 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 667674, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_O667674 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 667674, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_O667674 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 142449, 0, 278403, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_L667674 = 1;

-- Diplomatic Satchel (668515, type 3): 86615 Treaty Obligations
SET @EVERLAKE_O668515 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 668515)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 668515);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 668515, 3, 128615, 'Diplomatic Satchel', '', '', '', 1.0, 43, 142577, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 70959 FROM DUAL WHERE @EVERLAKE_O668515 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 668515, 0, 279171, 70959 FROM DUAL WHERE @EVERLAKE_O668515 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 668515 AND `Idx` = 0);
SET @EVERLAKE_L668515 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 668515 AND `type` = 3 AND `Data1` = 142577)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 142577);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 142577, 0, 279171, 100, 1, 1, 0, 1, 1, 'Diplomatic Satchel' FROM DUAL WHERE @EVERLAKE_L668515 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 668515, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_O668515 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 668515, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_O668515 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 142577, 0, 279171, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_L668515 = 1;

-- Lost Gryphon Egg (669115, type 3): 86620 Fledgling Rescue
SET @EVERLAKE_O669115 := (SELECT COUNT(*) = 0 FROM `gameobject_template` WHERE `entry` = 669115)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gameobject_template' AND `k1` = 669115);
INSERT INTO `gameobject_template` (`entry`, `type`, `displayId`, `name`, `IconName`, `castBarCaption`, `unk1`, `size`, `Data0`, `Data1`, `Data2`, `Data3`, `Data4`, `Data5`, `Data6`, `Data7`, `Data8`, `Data9`, `Data10`, `Data11`, `Data12`, `Data13`, `Data14`, `Data15`, `Data16`, `Data17`, `Data18`, `Data19`, `Data20`, `Data21`, `Data22`, `Data23`, `Data24`, `Data25`, `Data26`, `Data27`, `Data28`, `Data29`, `Data30`, `Data31`, `Data32`, `Data33`, `Data34`, `ContentTuningId`, `RequiredLevel`, `AIName`, `ScriptName`, `StringId`, `VerifiedBuild`)
SELECT 669115, 3, 124000, 'Lost Gryphon Egg', '', '', '', 0.75, 43, 142637, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4097, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', NULL, 70959 FROM DUAL WHERE @EVERLAKE_O669115 = 1;
INSERT INTO `gameobject_questitem` (`GameObjectEntry`, `Idx`, `ItemId`, `VerifiedBuild`)
SELECT 669115, 0, 279229, 70959 FROM DUAL WHERE @EVERLAKE_O669115 = 1 AND NOT EXISTS (SELECT 1 FROM `gameobject_questitem` WHERE `GameObjectEntry` = 669115 AND `Idx` = 0);
SET @EVERLAKE_L669115 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 669115 AND `type` = 3 AND `Data1` = 142637)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 142637);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 142637, 0, 279229, 100, 1, 1, 0, 1, 1, 'Lost Gryphon Egg' FROM DUAL WHERE @EVERLAKE_L669115 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_template', 669115, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_O669115 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_questitem', 669115, 0, 0, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_O669115 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 142637, 0, 279229, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_L669115 = 1;

-- The First Tablet of I'lalai (642943): loot 140217 -> item 270308
SET @EVERLAKE_L642943 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 642943 AND `type` = 3 AND `Data1` = 140217)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 140217);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 140217, 0, 270308, 100, 1, 1, 0, 1, 1, 'The First Tablet of I''lalai' FROM DUAL WHERE @EVERLAKE_L642943 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 140217, 0, 270308, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_L642943 = 1;

-- The Second Tablet of I'lalai (642944): loot 140218 -> item 270309
SET @EVERLAKE_L642944 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 642944 AND `type` = 3 AND `Data1` = 140218)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 140218);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 140218, 0, 270309, 100, 1, 1, 0, 1, 1, 'The Second Tablet of I''lalai' FROM DUAL WHERE @EVERLAKE_L642944 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 140218, 0, 270309, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_L642944 = 1;

-- The Third Tablet of I'lalai (642945): loot 140219 -> item 270310
SET @EVERLAKE_L642945 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 642945 AND `type` = 3 AND `Data1` = 140219)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 140219);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 140219, 0, 270310, 100, 1, 1, 0, 1, 1, 'The Third Tablet of I''lalai' FROM DUAL WHERE @EVERLAKE_L642945 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 140219, 0, 270310, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_L642945 = 1;

-- The Fourth Tablet of I'lalai (642946): loot 140220 -> item 270311
SET @EVERLAKE_L642946 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 642946 AND `type` = 3 AND `Data1` = 140220)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 140220);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 140220, 0, 270311, 100, 1, 1, 0, 1, 1, 'The Fourth Tablet of I''lalai' FROM DUAL WHERE @EVERLAKE_L642946 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 140220, 0, 270311, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_L642946 = 1;

-- The Lost Magic of the Runemasters (650929): loot 140820 -> item 273169
SET @EVERLAKE_L650929 := (SELECT COUNT(*) = 1 FROM `gameobject_template` WHERE `entry` = 650929 AND `type` = 3 AND `Data1` = 140820)
  AND (SELECT COUNT(*) = 0 FROM `gameobject_loot_template` WHERE `Entry` = 140820);
INSERT INTO `gameobject_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT 140820, 0, 273169, 100, 1, 1, 0, 1, 1, 'The Lost Magic of the Runemasters' FROM DUAL WHERE @EVERLAKE_L650929 = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gameobject_loot_template', 140820, 0, 273169, 0, '2026_11_19_939_world_everlake_quest_item_object_templates.sql', 'eglink@70959 object_details' FROM DUAL WHERE @EVERLAKE_L650929 = 1;

COMMIT;
