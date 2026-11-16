-- Everlake Forge #38: Import, 1 resource(s), 121 row(s)
-- Applied on the test realm as the tracker's Forge operation #39; numbered 38 here, the next free number of this repository.
-- 2026_11_16_900_world_everlake_forge_00038_import.sql: exported by the Forever Tracker Forge (https://github.com/buildthehomelab/wow-forever-tracker) from a realm where it was applied and tested first.
-- Made from the official WoW Forever client data (build 70938) and the Forge rules (docs/FORGE.md); rows as they were on that realm when exported.
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
UPDATE `quest_template` SET `LogDescription` = 'Speak to Braldir Ashmantle for another Fire Sapta.' WHERE `ID` = 94473 AND `LogDescription` <=> 'Speak to Braldir Ashmantle for another Fire Sapta' /* refresh */;
UPDATE `quest_template` SET `LogTitle` = 'Onu is Meditating' WHERE `ID` = 960 AND `LogTitle` <=> 'Onu is meditating' /* refresh */;
UPDATE `quest_template` SET `LogTitle` = 'Onu is Meditating' WHERE `ID` = 961 AND `LogTitle` <=> 'Onu is meditating' /* refresh */;
UPDATE `quest_template` SET `QuestDescription` = '<Penned in faded ink, the note is requesting $2oa Shadow Protection Potion, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>' WHERE `ID` = 94214 AND `QuestDescription` IS NULL /* refresh */;
UPDATE `quest_template` SET `QuestDescription` = '\n\n<Penned in faded ink, the note is requesting $2oa Lesser Troll\'s Blood Elixir, along with information about delivery location and payment. At the bottom appears text denoting this writ is transferable.>' WHERE `ID` = 94217 AND `QuestDescription` IS NULL /* refresh */;
UPDATE `quest_template` SET `QuestDescription` = 'A Forsaken paladin... here in Ashenvale? Amusing. \r\n\r\nSo you seek a Kor Gem? Unsurprising as these are sometimes employed to empower magical weapons and implements by the paladins of the Alliance. Why should a fallen paladin like you be any different?\r\n\r\nIf you truly desire one of the gems, then you must head north to the ruins known as Blackfathom Deeps. The naga who still use the gems are down below. Do not go alone, $c.' WHERE `ID` = 95042 AND `QuestDescription` <=> 'A Forsaken paladin... here in Ashenvale? Amusing. $B$BSo you seek a Kor Gem? Unsurprising as these are sometimes employed to empower magical weapons and implements by the paladins of the alliance. Why should a fallen paladin like you be any different?$B$BIf you truly desire one of the gems, then you must head north to the ruins known as Blackfathom Deeps. The naga who still use the gems are down below. Do not go alone, $C.' /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8383 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8384 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8385 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8386 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8387 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8389 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8390 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8391 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8392 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8397 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8398 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8404 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8405 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8406 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8407 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8408 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8431 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8432 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8433 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8434 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8435 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8440 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8441 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8442 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyID1` = 1792 WHERE `ID` = 8443 AND `RewardCurrencyID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 75 WHERE `ID` = 8383 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 20 WHERE `ID` = 8384 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 500 WHERE `ID` = 8385 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 10 WHERE `ID` = 8386 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 75 WHERE `ID` = 8387 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 10 WHERE `ID` = 8389 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 20 WHERE `ID` = 8390 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 30 WHERE `ID` = 8391 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 40 WHERE `ID` = 8392 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 50 WHERE `ID` = 8397 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 100 WHERE `ID` = 8398 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 20 WHERE `ID` = 8404 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 30 WHERE `ID` = 8405 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 40 WHERE `ID` = 8406 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 50 WHERE `ID` = 8407 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 100 WHERE `ID` = 8408 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 20 WHERE `ID` = 8431 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 30 WHERE `ID` = 8432 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 40 WHERE `ID` = 8433 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 50 WHERE `ID` = 8434 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 100 WHERE `ID` = 8435 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 30 WHERE `ID` = 8440 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 40 WHERE `ID` = 8441 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 50 WHERE `ID` = 8442 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardCurrencyQty1` = 100 WHERE `ID` = 8443 AND `RewardCurrencyQty1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionID1` = 2586 WHERE `ID` = 91904 AND `RewardFactionID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionID1` = 2586 WHERE `ID` = 91905 AND `RewardFactionID1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionID2` = 2587 WHERE `ID` = 91904 AND `RewardFactionID2` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionID2` = 2587 WHERE `ID` = 91905 AND `RewardFactionID2` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionID4` = 2799 WHERE `ID` = 8385 AND `RewardFactionID4` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8384 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8386 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8389 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8390 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8391 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8392 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8397 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8398 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8404 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8405 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8406 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8407 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8408 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8431 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8432 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8433 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8434 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8435 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8440 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8441 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8442 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionOverride1` = 0 WHERE `ID` = 8443 AND `RewardFactionOverride1` <=> 5000 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8384 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8386 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8389 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8390 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8391 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8392 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8397 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8398 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8404 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8405 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8406 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8407 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8408 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8431 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8432 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8433 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8434 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8435 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8440 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8441 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8442 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue1` = 5 WHERE `ID` = 8443 AND `RewardFactionValue1` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardFactionValue4` = 5 WHERE `ID` = 8385 AND `RewardFactionValue4` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardSpell` = 364165 WHERE `ID` = 5306 AND `RewardSpell` <=> 17043 /* refresh */;
UPDATE `quest_template` SET `RewardSpell` = 24962 WHERE `ID` = 98896 AND `RewardSpell` <=> 0 /* refresh */;
UPDATE `quest_template` SET `RewardXPDifficulty` = 5 WHERE `ID` = 8405 AND `RewardXPDifficulty` <=> 3 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 1442 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 5103 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 5306 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 1.95 WHERE `ID` = 5522 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2.375 WHERE `ID` = 7462 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 7631 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 7650 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8906 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8909 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8911 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8913 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;
UPDATE `quest_template` SET `RewardXPMultiplier` = 2 WHERE `ID` = 8950 AND ABS(`RewardXPMultiplier` - 1) < 0.005 /* refresh */;

DROP TEMPORARY TABLE IF EXISTS `everlake_forge_stage`;
COMMIT;
