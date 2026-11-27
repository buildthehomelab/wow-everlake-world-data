-- Darkspear Islands: Borook Gallfist (263647, Thunder Bluff) could not queue anyone.
-- 2026_11_26_94_world_everlake_darkspear_borook_gossip.sql: written by hand (2026-11-26), found on the PTR after
-- 2026_11_26_80_world_everlake_darkspear_islands. That file gave the eight Darkspear Islands battlemasters menu 2997001
-- only when they had no menu. Borook already had menu 43603 (his own greeting, npc_text 20043603) with no options, so he
-- kept it and showed the greeting with no way to join. This keeps his greeting and adds the usual battlemaster option
-- (OptionNpc 9 = battlemaster, broadcast text 10355) to menu 43603, as 2997001 has. Only menu 43603 is touched, only
-- while it has no options, and only Borook uses it.

SET @EVERLAKE_FILE := '2026_11_26_94_world_everlake_darkspear_borook_gossip.sql';

INSERT INTO `gossip_menu_option` (`MenuID`, `GossipOptionID`, `OptionID`, `OptionNpc`, `OptionText`, `OptionBroadcastTextID`, `Language`, `Flags`,
    `ActionMenuID`, `ActionPoiID`, `GossipNpcOptionID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `SpellID`, `OverrideIconID`, `VerifiedBuild`)
SELECT 43603, 299700102, 0, 9, 'I would like to go to the battleground.', 10355, 0, 0, 0, 0, NULL, 0, 0, '', 0, NULL, NULL, 0
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `gossip_menu_option` WHERE `MenuID` = 43603 OR `GossipOptionID` = 299700102);
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'gossip_menu_option', 43603, 0, 299700102, 0, @EVERLAKE_FILE, 'Borook Gallfist (263647) Darkspear Islands battlemaster option (OptionNpc 9, broadcast text 10355)'
FROM `gossip_menu_option` WHERE `MenuID` = 43603 AND `GossipOptionID` = 299700102;
