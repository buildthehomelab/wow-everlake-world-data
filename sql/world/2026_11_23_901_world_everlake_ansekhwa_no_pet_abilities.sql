-- Ansekhwa, the Thunder Bluff Weapon Master (creature 11869, trainer 1011869), teaches weapons, not pet abilities.
-- Forge operation #274 (Icy Veins 2026-11-23 gaps) gave his trainer on the test realm 15 hunter pet abilities for free: Cower, Growl, Great Stamina, Charge, Claw, Bite, five resistances,
-- Demoralizing Screech, Natural Armor, Swipe and Savage Rend. The realm's Hunter Trainers teach them; Icy Veins lists
-- pet abilities at trainers that do not teach them (NOTICE.md, operations 19 and 21). Its export (file 900, forge_00274) leaves them out;
-- this file takes them off the test realm, with any ledger rows. His weapon skills (One- and Two-Handed Maces, Staves, Guns) stay. Running it again changes nothing.

DELETE FROM `trainer_spell`
WHERE `TrainerId` = 1011869
  AND `SpellId` IN (1742, 2649, 4187, 7371, 16827, 17253, 23992, 24423, 24446, 24488, 24492, 24493, 24545, 1264494, 1265065);

DELETE FROM `everlake_import_rows`
WHERE `tbl` = 'trainer_spell' AND `k1` = 1011869
  AND `k2` IN (1742, 2649, 4187, 7371, 16827, 17253, 23992, 24423, 24446, 24488, 24492, 24493, 24545, 1264494, 1265065)
  AND `file` = '2026_11_23_900_world_everlake_forge_00274_import.sql';
