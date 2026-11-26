-- Two Windsong Crawlers stood far from water on Zephras (map 2991): one among the Quickgale vendors in town, one in a
-- field. 2026_11_26_91_world_everlake_windsong_crawler_strays.sql: written from the test realm's world (2026-11-26,
-- tracker Query page), after a player found crawlers in town and in fields.
--
-- Crab Season (93317) says they live "along the shorelines around the lake and in rivers", and its quest map (sniffed
-- with our crawlers, build 70124) draws eight shoreline areas. Our 61 sniffed crawlers all stand inside those areas or
-- within 6 yards of one. These two came from the fork's Azeroth file (sql/custom/world/2026_10_27_70, guids 43000000+)
-- and stand about 350 yards from any area and from any of ours:
--   43000327  (2242, 915)  in town by the Quickgale vendors, 349 yd from the nearest sniffed crawler
--   43000329  (2409, 980)  in a field, 360 yd from the nearest sniffed crawler
-- The other four Azeroth crawlers stand on the shorelines and stay. Neither row has an addon, pool, formation, event or
-- per-spawn script.
--
-- Running it again changes nothing: a row goes only while it still holds the crawler entry.

DELETE FROM `creature` WHERE `guid` IN (43000327, 43000329) AND `id` = 254588;
