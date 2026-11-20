-- Water-only creatures that do not swim: they sink to the floor and bob up and down in the water.
-- 2026_11_19_995_world_everlake_aquatic_can_swim.sql: written by hand.
--
-- Player report 2026-11-19: the Lake Threshers in Redridge's Lake Everstill clip up and down in the water. In the Forever
-- TDB (2026-10-14) their creature_template_difficulty.StaticFlags1 is 0x00040000 (AQUATIC, "water only") without
-- 0x10000000 (CAN_SWIM). The core gives a creature UNIT_FLAG_CAN_SWIM only from CAN_SWIM (ObjectMgr::ChooseCreatureFlags),
-- and Unit::CanSwim() reads that flag, so these creatures stay bound to water but never swim: gravity pulls them down and
-- the client shows them walking on the lake bed and popping up. The Darkshore Threshers (2185, 2187) carry both flags
-- (0x10040000) and swim. No later file on the realm changes these rows (core sql/custom/world, this repository).
--
-- The same gap holds for every water-only creature the TDB spawns in the old world, so all of them get CAN_SWIM:
--   6033  Lake Frenzy (Eastern Kingdoms)        12124  Great Shark (Kalimdor, Eastern Kingdoms)
--   6145  School of Fish (Kalimdor, Maraudon)   12125  Mammoth Shark (Kalimdor)
--   8236  Muck Frenzy (Kalimdor)                14356  Sawfin Frenzy (Eastern Kingdoms)
--  10942  Nessy (Deeprun Tram)                  14357  Lake Thresher (Redridge)
--  11374  Hooktooth Frenzy (Zul'Gurub)          14490  Rippa (Stranglethorn)
--  12123  Reef Shark (Kalimdor, Eastern Kingdoms) 15505  Canal Frenzy (Ruins of Ahn'Qiraj)
--  15526  Meridith the Mermaiden (Kalimdor)
-- Other AQUATIC-only entries in the TDB have no spawns, or also carry FLOATING (0x20000000), and are left alone.
-- Sources: the Forever TDB TDB_full_forever_2026_10_14 (creature_template_difficulty, creature); the core's
-- Creature/Unit/ObjectMgr swim code at the PTR pin.
-- Only rows that are still AQUATIC without CAN_SWIM change. Never edit this file once it is deployed: a later fix is a new
-- file. Running it again changes nothing.

UPDATE `creature_template_difficulty` SET `StaticFlags1` = `StaticFlags1` | 0x10000000
WHERE `DifficultyID` = 0 AND (`StaticFlags1` & 0x00040000) <> 0 AND (`StaticFlags1` & 0x10000000) = 0
  AND `Entry` IN (6033, 6145, 8236, 10942, 11374, 12123, 12124, 12125, 14356, 14357, 14490, 15505, 15526);
