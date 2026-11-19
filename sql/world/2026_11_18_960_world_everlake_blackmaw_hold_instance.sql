-- WoW Forever: Blackmaw Hold (map 2974, zone 16554, levels 55-60): the instance, the way in and out, and the graveyard.
-- 2026_11_18_960_world_everlake_blackmaw_hold_instance.sql. Nothing inside yet: creatures, loot and the fights follow in
-- later files. Safe to run again.
--
-- What is real data and what is a guess:
--  * real: the map and its areas (the client's Map and AreaTable, the server's map files: Blackmaw Grove 17311 is where
--    the dungeon starts, as the public guides say); the portal spot in Azshara, which three dungeon guides give within
--    14 yards of one another (Warcraft Tavern: Winterspring 66.6, 84.4; mmonster: Azshara 34.9, 23.8; ssegold: Azshara
--    35.0, 23.4), at the inner end of the furbolg tunnel whose Blackmaw camps Wowhead's Forever pages pin (Azshara
--    34-39, 23-34); heights from Everlake's own maps and vmaps (ForeverTracker tools/height.py).
--  * INFERRED: the portal's floor (the cave model has two floors there, 167.6 and 189.3: the lower one is taken), the
--    landing spot in Blackmaw Grove (open ground on the grove floor by the lake), the exit portal 12 yards from it, the
--    spot outside the exit puts players on (the cave floor 20 yards from the portal, facing the tunnel mouth), and the
--    graveyard (Bitter Reaches, the nearest Azshara graveyard to the tunnel). Replace them when someone records a run.
--
-- Ids: world_safe_locs 1104140-1104141 (after the fork's 1104100-1104123); custom area trigger templates, properties
-- and spawns 2974-2975 (the fork's are 300-323 and 5-33).

-- the instance (no instance script yet: the fights come with the core fork's classic_instance_blackmaw_hold)
DELETE FROM `instance_template` WHERE `map` = 2974;
INSERT INTO `instance_template` (`map`,`parent`,`script`) VALUES
(2974,1,'');

DELETE FROM `world_safe_locs` WHERE `ID` IN (1104140,1104141);
INSERT INTO `world_safe_locs` (`ID`,`MapID`,`LocX`,`LocY`,`LocZ`,`Facing`,`Comment`) VALUES
(1104140,2974,3470.0,3690.0,300.25,1.571,'Blackmaw Hold (dungeon) - entrance inside, Blackmaw Grove (INFERRED spot)'),
(1104141,1,4525.0,-5058.0,164.55,3.666,'Blackmaw Hold (dungeon) - exit outside, the furbolg tunnel in Azshara (INFERRED spot)');

-- server area triggers, spheres of 2.5 yards: the portal in the tunnel, and the way out in Blackmaw Grove
DELETE FROM `areatrigger_template` WHERE `IsCustom` = 1 AND `Id` IN (2974,2975);
INSERT INTO `areatrigger_template` (`Id`,`IsCustom`,`Flags`,`ActionSetId`,`ActionSetFlags`,`VerifiedBuild`) VALUES
(2974,1,0,0,0,0),
(2975,1,0,0,0,0);
DELETE FROM `areatrigger_template_actions` WHERE `IsCustom` = 1 AND `AreaTriggerId` IN (2974,2975);
INSERT INTO `areatrigger_template_actions` (`AreaTriggerId`,`IsCustom`,`ActionType`,`ActionParam`,`TargetType`) VALUES
(2974,1,2,1104140,5),
(2975,1,2,1104141,5);
DELETE FROM `areatrigger_create_properties` WHERE `IsCustom` = 1 AND `Id` IN (2974,2975);
INSERT INTO `areatrigger_create_properties` (`Id`,`IsCustom`,`AreaTriggerId`,`IsAreatriggerCustom`,`Shape`,`ShapeData0`,`ShapeData1`) VALUES
(2974,1,2974,1,0,2.5,2.5),
(2975,1,2975,1,0,2.5,2.5);
DELETE FROM `areatrigger` WHERE `SpawnId` IN (2974,2975);
INSERT INTO `areatrigger` (`SpawnId`,`AreaTriggerCreatePropertiesId`,`IsCustom`,`MapId`,`SpawnDifficulties`,`PosX`,`PosY`,`PosZ`,`Orientation`,`PhaseUseFlags`,`PhaseId`,`PhaseGroup`,`ScriptName`,`Comment`,`VerifiedBuild`) VALUES
(2974,2974,1,1,'0',4541.9,-5048.0,167.57,0,1,0,0,'','Blackmaw Hold - dungeon entrance (the furbolg tunnel, Azshara)',0),
(2975,2975,1,2974,'1',3470.0,3678.0,301.27,0,1,0,0,'','Blackmaw Hold (dungeon) - exit (Blackmaw Grove)',0);

-- ghosts release to Azshara's Bitter Reaches graveyard (INFERRED: the nearest one to the tunnel)
DELETE FROM `graveyard_zone` WHERE `GhostZone` = 16554;
INSERT INTO `graveyard_zone` (`ID`,`GhostZone`,`Comment`) VALUES
(630,16554,'Blackmaw Hold (dungeon) - Azshara, Bitter Reaches');
