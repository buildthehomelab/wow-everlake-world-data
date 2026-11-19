-- WoW Forever: Alcaz Prison (map 2994, zone 16620, levels 48-55): the instance, the way in and out, and the graveyard.
-- 2026_11_19_960_world_everlake_alcaz_prison_instance.sql. Creatures and fights follow in later files. Safe to run again.
--
-- Real data: the map and its zone (the client's Map and AreaTable, the server's map files); the portal's building: the
-- public guide of Warcraft Tavern puts the portal in the basement of the large building on Alcaz Island, Dustwallow
-- Marsh 75, 15, which is the building model spawn 67542500 of map 1 (Everlake's own vmaps); inside, the prison is one
-- building model (spawn 65701213 of map 2994) whose floors were read from the same vmaps; heights from Everlake's maps
-- and vmaps (ForeverTracker tools/height.py).
-- INFERRED: the portal's spot on the building's lowest floor, the landing (the top floor of the prison, at the foot of
-- the stairs from the building above), the exit 10 yards from it, the spot outside the exit, and the graveyard
-- (Theramore Isle, the nearest). Replace them when someone records a run.
--
-- Ids: world_safe_locs 1104144-1104145; custom area trigger templates, properties and spawns 2994-2995.

DELETE FROM `instance_template` WHERE `map` = 2994;
INSERT INTO `instance_template` (`map`,`parent`,`script`) VALUES
(2994,1,'');

DELETE FROM `world_safe_locs` WHERE `ID` IN (1104144,1104145);
INSERT INTO `world_safe_locs` (`ID`,`MapID`,`LocX`,`LocY`,`LocZ`,`Facing`,`Comment`) VALUES
(1104144,2994,-8798.0,2811.0,46.10,1.571,'Alcaz Prison (dungeon) - entrance inside, the top floor (INFERRED spot)'),
(1104145,1,-2531.0,-4926.0,21.10,1.571,'Alcaz Prison (dungeon) - exit outside, the basement of the building on Alcaz Island (INFERRED spot)');

DELETE FROM `areatrigger_template` WHERE `IsCustom` = 1 AND `Id` IN (2994,2995);
INSERT INTO `areatrigger_template` (`Id`,`IsCustom`,`Flags`,`ActionSetId`,`ActionSetFlags`,`VerifiedBuild`) VALUES
(2994,1,0,0,0,0),
(2995,1,0,0,0,0);
DELETE FROM `areatrigger_template_actions` WHERE `IsCustom` = 1 AND `AreaTriggerId` IN (2994,2995);
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`,`IsCustom`,`ActionType`,`ActionParam`,`TargetType`) VALUES
(2994,1,2,1104144,5),
(2995,1,2,1104145,5);
DELETE FROM `areatrigger_create_properties` WHERE `IsCustom` = 1 AND `Id` IN (2994,2995);
INSERT INTO `areatrigger_create_properties` (`Id`,`IsCustom`,`AreaTriggerId`,`IsAreatriggerCustom`,`Shape`,`ShapeData0`,`ShapeData1`) VALUES
(2994,1,2994,1,0,2.5,2.5),
(2995,1,2995,1,0,2.5,2.5);
DELETE FROM `areatrigger` WHERE `SpawnId` IN (2994,2995);
INSERT INTO `areatrigger` (`SpawnId`,`AreaTriggerCreatePropertiesId`,`IsCustom`,`MapId`,`SpawnDifficulties`,`PosX`,`PosY`,`PosZ`,`Orientation`,`PhaseUseFlags`,`PhaseId`,`PhaseGroup`,`ScriptName`,`Comment`,`VerifiedBuild`) VALUES
(2994,2994,1,1,'0',-2525.0,-4930.0,23.80,0,1,0,0,'','Alcaz Prison - dungeon entrance (the basement of the building on Alcaz Island)',0),
(2995,2995,1,2994,'1',-8807.0,2808.0,46.10,0,1,0,0,'','Alcaz Prison (dungeon) - exit (the top floor)',0);

DELETE FROM `graveyard_zone` WHERE `GhostZone` = 16620;
INSERT INTO `graveyard_zone` (`ID`,`GhostZone`,`Comment`) VALUES
(189,16620,'Alcaz Prison (dungeon) - Dustwallow Marsh, Theramore Isle');
