-- Paletusks can no longer be pickpocketed.
-- 2026_11_26_16_world_everlake_paletusks_no_pickpocket.sql: written by hand (2026-11-26).
--
-- Blizzard's server-side note of 17 November 2026 (step 70959+1): "Various Paletusks can no longer be pickpocketed".
-- Of the realm's Paletusks (beasts), Mature Paletusk 255851 and Young Paletusk 258331 still have a pickpocket loot id
-- (their own entry); Juvenile Paletusk 266862 already has none. Each changes only while it still holds its own id.
-- The pickpocketing_loot_template rows stay (nothing else uses them).
--
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing. Not checked in
-- game.

UPDATE `creature_template_difficulty` SET `PickPocketLootID` = 0
WHERE `Entry` IN (255851, 258331) AND `PickPocketLootID` = `Entry`;
