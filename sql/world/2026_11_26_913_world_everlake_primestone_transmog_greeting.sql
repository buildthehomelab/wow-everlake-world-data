-- Elder Primestone (15570, Lunar Festival, Silithus) kept a transmogrifier's greeting beside her own.
-- 2026_11_26_913_world_everlake_primestone_transmog_greeting.sql: follow-up to
-- 2026_11_26_912_world_everlake_lunar_elder_foreign_options.sql, which removed her menu's transmog and shop options but
-- missed this text (its row carries build 56461, outside the Legion builds that file looked for).
--
-- Menu 21043 held two unconditioned texts: 7933, the elders' "Now is the time when the year is new and the moon shines
-- bright...", and 31799, "I have all the tools necessary to adjust the appearance of your weapons and armor. Shall we
-- begin?". The second goes; 7933 stays. The npc_text row stays for whatever else uses it.
--
-- Running it again changes nothing.

DELETE FROM `gossip_menu` WHERE `MenuID` = 21043 AND `TextID` = 31799;
