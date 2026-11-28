-- Takes back six giver rows 2026_11_27_70_world_everlake_autocomplete_quest_givers.sql added that the realm did not need.
-- 2026_11_28_00_world_everlake_drop_redundant_event_givers.sql
-- Apprentice Angler 8194 (Jang 15078), the Stranglethorn rare fish 8221, 8224, 8225 (Fishbot 5000 15079) and
-- Could I get a Fishing Flier? 8228 (Grinkle 15116), 8229 (Barrus 15119) were already offered while their game event
-- runs: game_event_creature_quest gives them to these creatures during events 40 (the fishing tournament) and 14.
-- The plain rows were harmless (the creatures stand only during those events) but say nothing the realm needed.
-- The nine Darkmoon Faire ticket prizes stay: no game event offers them.
-- Only rows that file added and recorded are removed, and only while the event's own row is still there.
-- Running it again changes nothing.
START TRANSACTION;
DELETE s FROM `creature_queststarter` s
JOIN `everlake_import_rows` r ON r.`tbl` = 'creature_queststarter' AND r.`k1` = s.`id` AND r.`k2` = s.`quest`
  AND r.`file` = '2026_11_27_70_world_everlake_autocomplete_quest_givers.sql'
JOIN `game_event_creature_quest` g ON g.`id` = s.`id` AND g.`quest` = s.`quest`
WHERE (s.`id`, s.`quest`) IN ((15078, 8194), (15079, 8221), (15079, 8224), (15079, 8225), (15116, 8228), (15119, 8229));
DELETE r FROM `everlake_import_rows` r
WHERE r.`tbl` = 'creature_queststarter' AND r.`file` = '2026_11_27_70_world_everlake_autocomplete_quest_givers.sql'
  AND (r.`k1`, r.`k2`) IN ((15078, 8194), (15079, 8221), (15079, 8224), (15079, 8225), (15116, 8228), (15119, 8229))
  AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.`id` = r.`k1` AND s.`quest` = r.`k2`);
COMMIT;
