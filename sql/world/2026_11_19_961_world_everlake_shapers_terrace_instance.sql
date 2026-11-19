-- WoW Forever: The Shaper's Terrace (map 3001, zone 16667, levels 58-60): the instance, the way in and out, and the
-- graveyard. 2026_11_19_961_world_everlake_shapers_terrace_instance.sql. Creatures and fights follow in later files.
-- Safe to run again.
--
-- Real data: the map and its areas (the client's Map and AreaTable, the server's map files); the entrance: the public
-- guide of Warcraft Tavern puts it on the hill over Marshal's Refuge, Un'Goro Crater 48.1, 6.1 (the client's
-- UiMapAssignment turns that into map 1 x -6117.1, y -1246.4), where the same cave model stands on both map 1 (spawn
-- 69461145) and map 3001 (spawn 67635162) with a floor at z -143.25 (Everlake's own vmaps): the dungeon is a copy of
-- this part of the crater, so the way in keeps its place.
-- INFERRED: the landing (the same spot inside: the guide's ledge over the pond), the exit 10 yards from it, the spot
-- outside the exit, and the graveyard (Un'Goro Crater, The Marshlands).
--
-- Ids: world_safe_locs 1104146-1104147; custom area trigger templates, properties and spawns 3001-3002.

-- added only where missing, so the fight script a later file names on it is kept
INSERT INTO `instance_template` (`map`,`parent`,`script`)
SELECT 3001,1,'' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `instance_template` WHERE `map` = 3001);

DELETE FROM `world_safe_locs` WHERE `ID` IN (1104146,1104147);
INSERT INTO `world_safe_locs` (`ID`,`MapID`,`LocX`,`LocY`,`LocZ`,`Facing`,`Comment`) VALUES
(1104146,3001,-6117.1,-1246.4,-143.25,3.142,'The Shaper''s Terrace (dungeon) - entrance inside, the ledge over the pond (INFERRED spot)'),
(1104147,1,-6107.1,-1246.4,-143.25,0.0,'The Shaper''s Terrace (dungeon) - exit outside, the hill over Marshal''s Refuge (INFERRED spot)');

DELETE FROM `areatrigger_template` WHERE `IsCustom` = 1 AND `Id` IN (3001,3002);
INSERT INTO `areatrigger_template` (`Id`,`IsCustom`,`Flags`,`ActionSetId`,`ActionSetFlags`,`VerifiedBuild`) VALUES
(3001,1,0,0,0,0),
(3002,1,0,0,0,0);
DELETE FROM `areatrigger_template_actions` WHERE `IsCustom` = 1 AND `AreaTriggerId` IN (3001,3002);
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`,`IsCustom`,`ActionType`,`ActionParam`,`TargetType`) VALUES
(3001,1,2,1104146,5),
(3002,1,2,1104147,5);
DELETE FROM `areatrigger_create_properties` WHERE `IsCustom` = 1 AND `Id` IN (3001,3002);
INSERT INTO `areatrigger_create_properties` (`Id`,`IsCustom`,`AreaTriggerId`,`IsAreatriggerCustom`,`Shape`,`ShapeData0`,`ShapeData1`) VALUES
(3001,1,3001,1,0,2.5,2.5),
(3002,1,3002,1,0,2.5,2.5);
DELETE FROM `areatrigger` WHERE `SpawnId` IN (3001,3002);
INSERT INTO `areatrigger` (`SpawnId`,`AreaTriggerCreatePropertiesId`,`IsCustom`,`MapId`,`SpawnDifficulties`,`PosX`,`PosY`,`PosZ`,`Orientation`,`PhaseUseFlags`,`PhaseId`,`PhaseGroup`,`ScriptName`,`Comment`,`VerifiedBuild`) VALUES
(3001,3001,1,1,'0',-6117.1,-1246.4,-143.25,0,1,0,0,'','The Shaper''s Terrace - dungeon entrance (Un''Goro Crater, over Marshal''s Refuge)',0),
(3002,3002,1,3001,'1',-6127.1,-1246.4,-143.25,0,1,0,0,'','The Shaper''s Terrace (dungeon) - exit',0);

DELETE FROM `graveyard_zone` WHERE `GhostZone` = 16667;
INSERT INTO `graveyard_zone` (`ID`,`GhostZone`,`Comment`) VALUES
(450,16667,'The Shaper''s Terrace (dungeon) - Un''Goro Crater, The Marshlands');
