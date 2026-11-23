-- Skill-up ranges of 45 chests, herbs and ore nodes, as live Forever has them.
-- 2026_11_23_03_world_everlake_skillup_ranges.sql: written from public data by a script, checked by hand.
--
-- A chest-type object carries the skill at which opening it stops always giving a point (trivialSkillLow, Data23) and
-- the skill at which it gives none (trivialSkillHigh, Data24). The realm has both on 62 such templates and neither on
-- these 45, so the core falls back to its own rule there (required skill +25 and +100). Live Forever's templates, as
-- EG Link recorded the client's own query data, hold the values below on every build it has: for the locked chests
-- and footlockers that is required skill +30 and +105, five points later than the fallback.
--
-- Among them: Battered and Waterlogged Footlocker (150), Dented Footlocker (175), Mossy Footlocker (175 and 225), two
-- Buccaneer's Strongboxes, Large Iron Bound and Large Mithril Bound Chests, and 28 herb and ore nodes.
--
-- Source: EG Link (Efficient Games, CC BY 4.0), object details of builds 1.60.1.70450 to 1.60.1.71037, through the
-- ForeverTracker's source cache.
-- Changes a template only while it is a chest with the lock the record names and both values still 0. Running it
-- again changes nothing. Never edit this file once it is deployed: a later fix is a new file.

UPDATE `gameobject_template` SET `Data23` = 220, `Data24` = 295 WHERE `entry` = 2044 AND `type` = 3 AND `Data0` = 51 AND `Data23` = 0 AND `Data24` = 0;  -- Wintersbite
UPDATE `gameobject_template` SET `Data23` = 100, `Data24` = 175 WHERE `entry` = 2653 AND `type` = 3 AND `Data0` = 40 AND `Data23` = 0 AND `Data24` = 0;  -- Lesser Bloodstone Deposit
UPDATE `gameobject_template` SET `Data23` = 175, `Data24` = 250 WHERE `entry` = 19903 AND `type` = 3 AND `Data0` = 25 AND `Data23` = 0 AND `Data24` = 0;  -- Indurium Mineral Vein
UPDATE `gameobject_template` SET `Data23` = 100, `Data24` = 175 WHERE `entry` = 73940 AND `type` = 3 AND `Data0` = 40 AND `Data23` = 0 AND `Data24` = 0;  -- Ooze Covered Silver Vein
UPDATE `gameobject_template` SET `Data23` = 180, `Data24` = 255 WHERE `entry` = 73941 AND `type` = 3 AND `Data0` = 42 AND `Data23` = 0 AND `Data24` = 0;  -- Ooze Covered Gold Vein
UPDATE `gameobject_template` SET `Data23` = 55, `Data24` = 130 WHERE `entry` = 74447 AND `type` = 3 AND `Data0` = 23 AND `Data23` = 0 AND `Data24` = 0;  -- Large Iron Bound Chest
UPDATE `gameobject_template` SET `Data23` = 30, `Data24` = 105 WHERE `entry` = 75295 AND `type` = 3 AND `Data0` = 5 AND `Data23` = 0 AND `Data24` = 0;  -- Large Iron Bound Chest
UPDATE `gameobject_template` SET `Data23` = 100, `Data24` = 175 WHERE `entry` = 75296 AND `type` = 3 AND `Data0` = 24 AND `Data23` = 0 AND `Data24` = 0;  -- Large Iron Bound Chest
UPDATE `gameobject_template` SET `Data23` = 155, `Data24` = 230 WHERE `entry` = 75297 AND `type` = 3 AND `Data0` = 60 AND `Data23` = 0 AND `Data24` = 0;  -- Large Iron Bound Chest
UPDATE `gameobject_template` SET `Data23` = 30, `Data24` = 105 WHERE `entry` = 103815 AND `type` = 3 AND `Data0` = 5 AND `Data23` = 0 AND `Data24` = 0;  -- Ambermill Strongbox
UPDATE `gameobject_template` SET `Data23` = 30, `Data24` = 105 WHERE `entry` = 105176 AND `type` = 3 AND `Data0` = 5 AND `Data23` = 0 AND `Data24` = 0;  -- Venture Co. Strongbox
UPDATE `gameobject_template` SET `Data23` = 100, `Data24` = 175 WHERE `entry` = 105569 AND `type` = 3 AND `Data0` = 40 AND `Data23` = 0 AND `Data24` = 0;  -- Silver Vein
UPDATE `gameobject_template` SET `Data23` = 100, `Data24` = 175 WHERE `entry` = 105570 AND `type` = 3 AND `Data0` = 24 AND `Data23` = 0 AND `Data24` = 0;  -- Alliance Strongbox
UPDATE `gameobject_template` SET `Data23` = 255, `Data24` = 330 WHERE `entry` = 123309 AND `type` = 3 AND `Data0` = 380 AND `Data23` = 0 AND `Data24` = 0;  -- Ooze Covered Truesilver Deposit
UPDATE `gameobject_template` SET `Data23` = 30, `Data24` = 105 WHERE `entry` = 123332 AND `type` = 3 AND `Data0` = 5 AND `Data23` = 0 AND `Data24` = 0;  -- Buccaneer's Strongbox
UPDATE `gameobject_template` SET `Data23` = 30, `Data24` = 105 WHERE `entry` = 123333 AND `type` = 3 AND `Data0` = 5 AND `Data23` = 0 AND `Data24` = 0;  -- Buccaneer's Strongbox
UPDATE `gameobject_template` SET `Data23` = 270, `Data24` = 345 WHERE `entry` = 123848 AND `type` = 3 AND `Data0` = 400 AND `Data23` = 0 AND `Data24` = 0;  -- Ooze Covered Thorium Vein
UPDATE `gameobject_template` SET `Data23` = 100, `Data24` = 175 WHERE `entry` = 129127 AND `type` = 3 AND `Data0` = 24 AND `Data23` = 0 AND `Data24` = 0;  -- Gallywix's Lockbox
UPDATE `gameobject_template` SET `Data23` = 205, `Data24` = 280 WHERE `entry` = 131978 AND `type` = 3 AND `Data0` = 61 AND `Data23` = 0 AND `Data24` = 0;  -- Large Mithril Bound Chest
UPDATE `gameobject_template` SET `Data23` = 245, `Data24` = 320 WHERE `entry` = 142141 AND `type` = 3 AND `Data0` = 440 AND `Data23` = 0 AND `Data24` = 0;  -- Arthas' Tears
UPDATE `gameobject_template` SET `Data23` = 260, `Data24` = 335 WHERE `entry` = 142143 AND `type` = 3 AND `Data0` = 442 AND `Data23` = 0 AND `Data24` = 0;  -- Blindweed
UPDATE `gameobject_template` SET `Data23` = 270, `Data24` = 345 WHERE `entry` = 142144 AND `type` = 3 AND `Data0` = 443 AND `Data23` = 0 AND `Data24` = 0;  -- Ghost Mushroom
UPDATE `gameobject_template` SET `Data23` = 200, `Data24` = 275 WHERE `entry` = 150079 AND `type` = 3 AND `Data0` = 379 AND `Data23` = 0 AND `Data24` = 0;  -- Mithril Deposit
UPDATE `gameobject_template` SET `Data23` = 180, `Data24` = 255 WHERE `entry` = 150080 AND `type` = 3 AND `Data0` = 42 AND `Data23` = 0 AND `Data24` = 0;  -- Gold Vein
UPDATE `gameobject_template` SET `Data23` = 255, `Data24` = 330 WHERE `entry` = 150081 AND `type` = 3 AND `Data0` = 380 AND `Data23` = 0 AND `Data24` = 0;  -- Truesilver Deposit
UPDATE `gameobject_template` SET `Data23` = 270, `Data24` = 345 WHERE `entry` = 150082 AND `type` = 3 AND `Data0` = 400 AND `Data23` = 0 AND `Data24` = 0;  -- Small Thorium Vein
UPDATE `gameobject_template` SET `Data23` = 255, `Data24` = 330 WHERE `entry` = 153465 AND `type` = 3 AND `Data0` = 62 AND `Data23` = 0 AND `Data24` = 0;  -- Large Mithril Bound Chest
UPDATE `gameobject_template` SET `Data23` = 310, `Data24` = 385 WHERE `entry` = 176587 AND `type` = 3 AND `Data0` = 1122 AND `Data23` = 0 AND `Data24` = 0;  -- Plaguebloom
UPDATE `gameobject_template` SET `Data23` = 325, `Data24` = 400 WHERE `entry` = 176588 AND `type` = 3 AND `Data0` = 1123 AND `Data23` = 0 AND `Data24` = 0;  -- Icecap
UPDATE `gameobject_template` SET `Data23` = 325, `Data24` = 400 WHERE `entry` = 176589 AND `type` = 3 AND `Data0` = 1124 AND `Data23` = 0 AND `Data24` = 0;  -- Black Lotus
UPDATE `gameobject_template` SET `Data23` = 255, `Data24` = 330 WHERE `entry` = 176636 AND `type` = 3 AND `Data0` = 441 AND `Data23` = 0 AND `Data24` = 0;  -- Sungrass
UPDATE `gameobject_template` SET `Data23` = 275, `Data24` = 350 WHERE `entry` = 176637 AND `type` = 3 AND `Data0` = 444 AND `Data23` = 0 AND `Data24` = 0;  -- Gromsblood
UPDATE `gameobject_template` SET `Data23` = 285, `Data24` = 360 WHERE `entry` = 176638 AND `type` = 3 AND `Data0` = 1119 AND `Data23` = 0 AND `Data24` = 0;  -- Golden Sansam
UPDATE `gameobject_template` SET `Data23` = 290, `Data24` = 365 WHERE `entry` = 176639 AND `type` = 3 AND `Data0` = 1120 AND `Data23` = 0 AND `Data24` = 0;  -- Dreamfoil
UPDATE `gameobject_template` SET `Data23` = 305, `Data24` = 380 WHERE `entry` = 176640 AND `type` = 3 AND `Data0` = 1121 AND `Data23` = 0 AND `Data24` = 0;  -- Mountain Silversage
UPDATE `gameobject_template` SET `Data23` = 310, `Data24` = 385 WHERE `entry` = 176641 AND `type` = 3 AND `Data0` = 1122 AND `Data23` = 0 AND `Data24` = 0;  -- Plaguebloom
UPDATE `gameobject_template` SET `Data23` = 245, `Data24` = 320 WHERE `entry` = 176642 AND `type` = 3 AND `Data0` = 440 AND `Data23` = 0 AND `Data24` = 0;  -- Arthas' Tears
UPDATE `gameobject_template` SET `Data23` = 270, `Data24` = 345 WHERE `entry` = 176643 AND `type` = 3 AND `Data0` = 400 AND `Data23` = 0 AND `Data24` = 0;  -- Small Thorium Vein
UPDATE `gameobject_template` SET `Data23` = 200, `Data24` = 275 WHERE `entry` = 176645 AND `type` = 3 AND `Data0` = 379 AND `Data23` = 0 AND `Data24` = 0;  -- Mithril Deposit
UPDATE `gameobject_template` SET `Data23` = 180, `Data24` = 255 WHERE `entry` = 179490 AND `type` = 3 AND `Data0` = 1560 AND `Data23` = 0 AND `Data24` = 0;  -- Battered Footlocker
UPDATE `gameobject_template` SET `Data23` = 180, `Data24` = 255 WHERE `entry` = 179491 AND `type` = 3 AND `Data0` = 1560 AND `Data23` = 0 AND `Data24` = 0;  -- Waterlogged Footlocker
UPDATE `gameobject_template` SET `Data23` = 205, `Data24` = 280 WHERE `entry` = 179492 AND `type` = 3 AND `Data0` = 61 AND `Data23` = 0 AND `Data24` = 0;  -- Dented Footlocker
UPDATE `gameobject_template` SET `Data23` = 205, `Data24` = 280 WHERE `entry` = 179493 AND `type` = 3 AND `Data0` = 61 AND `Data23` = 0 AND `Data24` = 0;  -- Mossy Footlocker
UPDATE `gameobject_template` SET `Data23` = 255, `Data24` = 330 WHERE `entry` = 179497 AND `type` = 3 AND `Data0` = 62 AND `Data23` = 0 AND `Data24` = 0;  -- Mossy Footlocker
UPDATE `gameobject_template` SET `Data23` = 255, `Data24` = 330 WHERE `entry` = 181108 AND `type` = 3 AND `Data0` = 380 AND `Data23` = 0 AND `Data24` = 0;  -- Truesilver Deposit
