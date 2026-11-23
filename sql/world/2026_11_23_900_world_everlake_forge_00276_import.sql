-- Everlake Forge #276: Import, 1 resource(s), 117 row(s)
-- 2026_11_23_900_world_everlake_forge_00276_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 71037) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
-- Sources: EG Link 423d6c96 (NOTICE.md, Forge exports).
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
UPDATE `creature_loot_template` SET `Chance` = 2.56 WHERE `Entry` = 92 AND `ItemType` = 0 AND `Item` = 3864 AND ABS(`Chance` - 0.4405) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 25.64 WHERE `Entry` = 92 AND `ItemType` = 0 AND `Item` = 4552 AND ABS(`Chance` - 16.4502) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 17.95 WHERE `Entry` = 92 AND `ItemType` = 0 AND `Item` = 7912 AND ABS(`Chance` - 26.9259) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 9.09 WHERE `Entry` = 940 AND `ItemType` = 0 AND `Item` = 2633 AND ABS(`Chance` - 34.4399) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 9.09 WHERE `Entry` = 940 AND `ItemType` = 0 AND `Item` = 2750 AND ABS(`Chance` - 0.6969) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 18.18 WHERE `Entry` = 940 AND `ItemType` = 0 AND `Item` = 3357 AND ABS(`Chance` - 7.8769) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 18.18 WHERE `Entry` = 940 AND `ItemType` = 0 AND `Item` = 3818 AND ABS(`Chance` - 7.689) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 72.73 WHERE `Entry` = 940 AND `ItemType` = 0 AND `Item` = 4306 AND ABS(`Chance` - 29.1712) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 8.33 WHERE `Entry` = 1973 AND `ItemType` = 0 AND `Item` = 2592 AND ABS(`Chance` - 19.0854) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 14.29 WHERE `Entry` = 1974 AND `ItemType` = 0 AND `Item` = 2592 AND ABS(`Chance` - 19.8226) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 41.67 WHERE `Entry` = 2164 AND `ItemType` = 0 AND `Item` = 3170 AND ABS(`Chance` - 33.9386) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 8.33 WHERE `Entry` = 2164 AND `ItemType` = 0 AND `Item` = 11406 AND ABS(`Chance` - 6.5818) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 44.44 WHERE `Entry` = 2354 AND `ItemType` = 0 AND `Item` = 11406 AND ABS(`Chance` - 32.4424) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 22.22 WHERE `Entry` = 2354 AND `ItemType` = 0 AND `Item` = 11407 AND ABS(`Chance` - 9.6819) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 23.53 WHERE `Entry` = 2656 AND `ItemType` = 0 AND `Item` = 3671 AND ABS(`Chance` - 9.7807) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 23.53 WHERE `Entry` = 2656 AND `ItemType` = 0 AND `Item` = 3676 AND ABS(`Chance` - 15.4452) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 5.88 WHERE `Entry` = 2656 AND `ItemType` = 0 AND `Item` = 20767 AND ABS(`Chance` - 9.1358) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 9.55 WHERE `Entry` = 2735 AND `ItemType` = 0 AND `Item` = 4552 AND ABS(`Chance` - 11.8302) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 4.77 WHERE `Entry` = 2735 AND `ItemType` = 0 AND `Item` = 7067 AND ABS(`Chance` - 9.9529) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 9.55 WHERE `Entry` = 2735 AND `ItemType` = 0 AND `Item` = 7912 AND ABS(`Chance` - 24.9152) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 19.35 WHERE `Entry` = 2736 AND `ItemType` = 0 AND `Item` = 4554 AND ABS(`Chance` - 16.4669) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 6.45 WHERE `Entry` = 2736 AND `ItemType` = 0 AND `Item` = 7067 AND ABS(`Chance` - 5.3045) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 50 WHERE `Entry` = 3284 AND `ItemType` = 0 AND `Item` = 2589 AND ABS(`Chance` - 38.3266) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 6.43 WHERE `Entry` = 3385 AND `ItemType` = 0 AND `Item` = 414 AND ABS(`Chance` - 4.8117) < 0.005 /* refresh */;
UPDATE `creature_loot_template` SET `Chance` = 42.86 WHERE `Entry` = 256798 AND `ItemType` = 0 AND `Item` = 4306 AND ABS(`Chance` - 34.48) < 0.005 /* refresh */;
UPDATE `gameobject_loot_template` SET `Chance` = 46.67 WHERE `Entry` = 640104 AND `ItemType` = 0 AND `Item` = 269739 AND ABS(`Chance` - 33.333) < 0.005 /* refresh */;
UPDATE `quest_classic_level` SET `MinLevel` = 100 WHERE `ID` = 79365 AND `MinLevel` <=> 30 /* refresh */;
UPDATE `quest_template` SET `LogDescription` = 'Log' WHERE `ID` = 78307 AND `LogDescription` <=> 'Return to C\'s dead drop near Pyrewood Village to collect your payment.' /* refresh */;
UPDATE `quest_template` SET `LogDescription` = 'Log' WHERE `ID` = 78699 AND `LogDescription` <=> 'Return to C\'s dead drop near Pyrewood Village to collect your payment.' /* refresh */;
UPDATE `quest_template` SET `QuestDescription` = 'Description' WHERE `ID` = 78307 AND `QuestDescription` <=> 'Your payment for the Horn of Xelthos is waiting in C\'s dead drop near Pyrewood Village.' /* refresh */;
UPDATE `quest_template` SET `QuestDescription` = 'Description' WHERE `ID` = 78699 AND `QuestDescription` <=> 'Your payment for the Eye of Bhossca is waiting in C\'s dead drop near Pyrewood Village.' /* refresh */;
UPDATE `quest_template` SET `RewardAmount1` = 0 WHERE `ID` = 4132 AND `RewardAmount1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID1` = 0 WHERE `ID` = 6163 AND `RewardChoiceItemID1` <=> 18022 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID1` = 0 WHERE `ID` = 8232 AND `RewardChoiceItemID1` <=> 20083 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID1` = 0 WHERE `ID` = 8236 AND `RewardChoiceItemID1` <=> 19984 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID1` = 0 WHERE `ID` = 8253 AND `RewardChoiceItemID1` <=> 20035 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID1` = 0 WHERE `ID` = 8257 AND `RewardChoiceItemID1` <=> 19990 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID1` = 0 WHERE `ID` = 8413 AND `RewardChoiceItemID1` <=> 20369 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID1` = 0 WHERE `ID` = 8418 AND `RewardChoiceItemID1` <=> 20504 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID1` = 0 WHERE `ID` = 8422 AND `RewardChoiceItemID1` <=> 20536 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID1` = 0 WHERE `ID` = 8425 AND `RewardChoiceItemID1` <=> 20521 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID1` = 0 WHERE `ID` = 9053 AND `RewardChoiceItemID1` <=> 22274 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID2` = 0 WHERE `ID` = 6163 AND `RewardChoiceItemID2` <=> 17001 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID2` = 0 WHERE `ID` = 8232 AND `RewardChoiceItemID2` <=> 19991 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID2` = 0 WHERE `ID` = 8236 AND `RewardChoiceItemID2` <=> 20255 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID2` = 0 WHERE `ID` = 8253 AND `RewardChoiceItemID2` <=> 20037 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID2` = 0 WHERE `ID` = 8257 AND `RewardChoiceItemID2` <=> 20082 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID2` = 0 WHERE `ID` = 8413 AND `RewardChoiceItemID2` <=> 20503 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID2` = 0 WHERE `ID` = 8418 AND `RewardChoiceItemID2` <=> 20512 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID2` = 0 WHERE `ID` = 8422 AND `RewardChoiceItemID2` <=> 20534 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID2` = 0 WHERE `ID` = 8425 AND `RewardChoiceItemID2` <=> 20130 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID2` = 0 WHERE `ID` = 9053 AND `RewardChoiceItemID2` <=> 22272 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID3` = 0 WHERE `ID` = 8232 AND `RewardChoiceItemID3` <=> 19992 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID3` = 0 WHERE `ID` = 8236 AND `RewardChoiceItemID3` <=> 19982 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID3` = 0 WHERE `ID` = 8253 AND `RewardChoiceItemID3` <=> 20036 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID3` = 0 WHERE `ID` = 8257 AND `RewardChoiceItemID3` <=> 20006 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID3` = 0 WHERE `ID` = 8413 AND `RewardChoiceItemID3` <=> 20556 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID3` = 0 WHERE `ID` = 8418 AND `RewardChoiceItemID3` <=> 20505 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID3` = 0 WHERE `ID` = 8422 AND `RewardChoiceItemID3` <=> 20530 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID3` = 0 WHERE `ID` = 8425 AND `RewardChoiceItemID3` <=> 20517 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemID3` = 0 WHERE `ID` = 9053 AND `RewardChoiceItemID3` <=> 22458 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity1` = 0 WHERE `ID` = 6163 AND `RewardChoiceItemQuantity1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity1` = 0 WHERE `ID` = 8232 AND `RewardChoiceItemQuantity1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity1` = 0 WHERE `ID` = 8236 AND `RewardChoiceItemQuantity1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity1` = 0 WHERE `ID` = 8253 AND `RewardChoiceItemQuantity1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity1` = 0 WHERE `ID` = 8257 AND `RewardChoiceItemQuantity1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity1` = 0 WHERE `ID` = 8413 AND `RewardChoiceItemQuantity1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity1` = 0 WHERE `ID` = 8418 AND `RewardChoiceItemQuantity1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity1` = 0 WHERE `ID` = 8422 AND `RewardChoiceItemQuantity1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity1` = 0 WHERE `ID` = 8425 AND `RewardChoiceItemQuantity1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity1` = 0 WHERE `ID` = 9053 AND `RewardChoiceItemQuantity1` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity2` = 0 WHERE `ID` = 6163 AND `RewardChoiceItemQuantity2` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity2` = 0 WHERE `ID` = 8232 AND `RewardChoiceItemQuantity2` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity2` = 0 WHERE `ID` = 8236 AND `RewardChoiceItemQuantity2` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity2` = 0 WHERE `ID` = 8253 AND `RewardChoiceItemQuantity2` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity2` = 0 WHERE `ID` = 8257 AND `RewardChoiceItemQuantity2` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity2` = 0 WHERE `ID` = 8413 AND `RewardChoiceItemQuantity2` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity2` = 0 WHERE `ID` = 8418 AND `RewardChoiceItemQuantity2` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity2` = 0 WHERE `ID` = 8422 AND `RewardChoiceItemQuantity2` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity2` = 0 WHERE `ID` = 8425 AND `RewardChoiceItemQuantity2` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity2` = 0 WHERE `ID` = 9053 AND `RewardChoiceItemQuantity2` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity3` = 0 WHERE `ID` = 8232 AND `RewardChoiceItemQuantity3` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity3` = 0 WHERE `ID` = 8236 AND `RewardChoiceItemQuantity3` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity3` = 0 WHERE `ID` = 8253 AND `RewardChoiceItemQuantity3` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity3` = 0 WHERE `ID` = 8257 AND `RewardChoiceItemQuantity3` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity3` = 0 WHERE `ID` = 8413 AND `RewardChoiceItemQuantity3` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity3` = 0 WHERE `ID` = 8418 AND `RewardChoiceItemQuantity3` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity3` = 0 WHERE `ID` = 8422 AND `RewardChoiceItemQuantity3` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity3` = 0 WHERE `ID` = 8425 AND `RewardChoiceItemQuantity3` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardChoiceItemQuantity3` = 0 WHERE `ID` = 9053 AND `RewardChoiceItemQuantity3` <=> 1 /* refresh */;
UPDATE `quest_template` SET `RewardItem1` = 0 WHERE `ID` = 4132 AND `RewardItem1` <=> 12059 /* refresh */;
UPDATE `quest_template` SET `RewardSpell` = 364167 WHERE `ID` = 8869 AND `RewardSpell` <=> 17044 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8869 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8908 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8916 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8918 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8919 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8927 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8935 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8936 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8937 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8938 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8952 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8954 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8955 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8956 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8958 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8959 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8966 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8999 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 9016 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 9018 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 9019 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 9020 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 9021 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 9022 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 78699 AND ABS(`RewardXPMultiplier` - 3) < 0.005 /* refresh */;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
