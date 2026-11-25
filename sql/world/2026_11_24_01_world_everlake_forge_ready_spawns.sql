-- The ForeverTracker's Spawns tab, "Ready" on 2026-11-24: creatures and objects the realm has templates for but never
-- spawned, with the positions the tracker's locator read (QuestieDB records and hand fixes, Wowhead map pins), heights
-- from the server's maps. Taken from the Forge's preview (spawn_sql), not applied through it: database mode needs the
-- PTR worldserver stopped.
--   Sebastian Jurgens 228956: gives Rift Away (84213).
--   Credit 270573 / 270574: objectives of Valuable Vantages (98095); they stand still like the quest's third, 270575.
--   Baron Bloodbane 10819 (rare): drops Royal Seal of Alexis (16999). Two spots in one pool, one up at a time, 5 h
--   respawn like the realm's other Eastern Plaguelands rares (18000-115200 s).
--   Book 441247: holds item 220345. Old Crate 442688: holds Old Key (221497), which starts The Old Key (95599).
-- Own guid block 920017000-920017006, pool 920000201. Written by hand from the preview, not tried in game. Never edit
-- this file once it is deployed: a later fix is a new file. Running it again changes nothing.

DELETE FROM `pool_members` WHERE `type` = 0 AND `spawnId` IN (920017000, 920017001);
DELETE FROM `pool_template` WHERE `entry` = 920000201;
DELETE FROM `creature` WHERE `guid` BETWEEN 920017000 AND 920017004;
DELETE FROM `gameobject` WHERE `guid` BETWEEN 920017005 AND 920017006;

INSERT INTO `creature` (`guid`,`id`,`map`,`spawnDifficulties`,`position_x`,`position_y`,`position_z`,`orientation`,`spawntimesecs`,`wander_distance`,`MovementType`,`VerifiedBuild`) VALUES
(920017000,10819,0,'0',3115.47,-3650.13,142.69,1.693,18000,5,1,0),
(920017001,10819,0,'0',3095.4,-3736.17,133.52,0,18000,5,1,0),
(920017002,228956,1,'0',-10268.92,-4033.76,0.67,1.594,120,0,0,0),
(920017003,270573,0,'0',-275.01,-296.91,170.41,0.888,120,0,0,0),
(920017004,270574,0,'0',-248.11,-1221.97,118.73,1.604,120,0,0,0);

INSERT INTO `gameobject` (`guid`,`id`,`map`,`spawnDifficulties`,`position_x`,`position_y`,`position_z`,`orientation`,`rotation0`,`rotation1`,`rotation2`,`rotation3`,`spawntimesecs`,`animprogress`,`state`,`VerifiedBuild`) VALUES
(920017005,441247,0,'0',-10414.01,-3834.73,28.42,5.991,0,0,0.145574,-0.989347,300,255,1,0),
(920017006,442688,1,'0',-4589.74,120.05,82.08,3.721,0,0,0.958329,-0.285668,300,255,1,0);

INSERT INTO `pool_template` (`entry`, `max_limit`, `description`) VALUES
(920000201, 1, 'Baron Bloodbane (10819), Eastern Plaguelands: one of two spots');
INSERT INTO `pool_members` (`type`, `spawnId`, `poolSpawnId`, `chance`, `description`) VALUES
(0, 920017000, 920000201, 0, 'Baron Bloodbane, spot 1'),
(0, 920017001, 920000201, 0, 'Baron Bloodbane, spot 2');
