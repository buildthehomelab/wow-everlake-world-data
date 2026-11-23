-- Genn Fairweather (Zephras Isle) stables pets.
-- 2026_11_22_09_world_everlake_genn_fairweather_stable.sql: written by hand.
--
-- Genn Fairweather (265756, "Stablemaster and Riding Trainer") is the only stable master on Zephras Isle (map 2991).
-- The fork's row for him has no stable master flag and his menu (43344) only sells Galestriders and trains riding, so
-- a hunter had nowhere on the isle to stable a pet (checked on the test realm's world, 2026-11-22). His title is the
-- witness; the packet capture his rows were made from did not hold the hunter's option. INFERRED: the option's wording
-- is the one the fork's other stable masters use (broadcast text 30181), not a recorded line of his.
--
-- This gives his template the stable master flag (4307 -> 4198611, bit 4194304) and adds the option to his menu. The
-- core shows it to hunters only. The flag changes only while it is still 4307; the option is added only while the menu
-- has no stable option and its slot 2 is free, and is recorded in everlake_import_rows. Never edit this file once it
-- is deployed: a later fix is a new file. Running it again changes nothing.

SET @EVERLAKE_FILE := '2026_11_22_09_world_everlake_genn_fairweather_stable.sql';

START TRANSACTION;

UPDATE `creature_template` SET `npcflag` = 4198611
WHERE `entry` = 265756 AND `name` = 'Genn Fairweather' AND `npcflag` = 4307;

SET @EVERLAKE_OPTION := (SELECT COUNT(*) = 0 FROM `gossip_menu_option` WHERE `MenuID` = 43344 AND (`OptionNpc` = 12 OR `OptionID` = 2))
  AND (SELECT COUNT(*) = 0 FROM `gossip_menu_option` WHERE `GossipOptionID` = 920043344)
  AND (SELECT COUNT(*) = 1 FROM `creature_template_gossip` WHERE `CreatureID` = 265756 AND `MenuID` = 43344)
  AND (SELECT COUNT(*) = 0 FROM `everlake_import_rows` WHERE `tbl` = 'gossip_menu_option' AND `k1` = 43344 AND `k2` = 2);
INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`,
  `Language`, `Flags`, `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`,
  `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`)
SELECT 43344, 920043344, 2, 12, 'I''d like to stable my pet here.', 30181, 0, 0, 0, 0, NULL, 0, 0, NULL, 0, NULL, NULL, 0
FROM DUAL WHERE @EVERLAKE_OPTION = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gossip_menu_option', 43344, 2, 0, 0, @EVERLAKE_FILE, 'INFERRED: Genn Fairweather stable option, from his title'
FROM DUAL WHERE @EVERLAKE_OPTION = 1;

COMMIT;
