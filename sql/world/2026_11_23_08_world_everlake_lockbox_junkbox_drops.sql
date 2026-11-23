-- Lockboxes and junkboxes of 167 Forever creatures: 141 lockbox drops and 100 junkboxes for rogues' Pick Pocket.
-- 2026_11_23_08_world_everlake_lockbox_junkbox_drops.sql: written from public data by a script, checked by hand.
--
-- The creatures Forever added (Riverglades above all, levels 36 to 44) drop almost no lockboxes on the realm, and
-- none of them has pockets to pick. Live players' addons recorded both: of the spawned ones, 54 of 58 with a Strong
-- Iron Lockbox and all 29 with a Steel Lockbox give none here, and all 95 with a junkbox have no pickpocket table.
-- The realm's owner chose on 2026-11-23 to take Icy Veins' records without a second witness for these.
--   * lockboxes: one loot row each, at Icy Veins' recorded chance per kill (Wowhead's Forever page where Icy Veins
--     has none). Icy Veins' samples are small, so a chance never goes above the highest the realm gives that box on
--     any older creature (4 rows lowered). Records with a chance of 0 are left out (3).
--   * junkboxes: a junkbox comes only from Pick Pocket, so a record of one is a record of picked pockets. Icy Veins
--     counts it over kills, which says nothing of the chance per attempt. INFERRED: each gets the realm's average
--     chance for that junkbox on older creatures (Battered 20, Worn 14.5, Sturdy 9.5, Heavy 8.8). The creature's
--     pickpocket table is new and holds the junkbox only: Icy Veins does not tell picked pockets from kill loot for
--     anything else. Its PickPocketLootID is set to its own entry.
--   * a creature with no loot id gets its own entry as loot id (Coyote Prowler).
--
-- Sources: Icy Veins' WoW Forever database (what players' addons recorded on live); Wowhead's Forever database
-- through the ForeverTracker's page cache (drop and pickpocketing tabs) as second witness where it has the creature.
-- Adds a row only where the creature has none for that item, and sets a loot id only where it is still 0. Each added
-- row is recorded in everlake_import_rows. Never edit this file once it is deployed: a later fix is a new file.
-- Running it again changes nothing.

SET @EVERLAKE_FILE := '2026_11_23_08_world_everlake_lockbox_junkbox_drops.sql';

START TRANSACTION;

DROP TEMPORARY TABLE IF EXISTS `everlake_box_stage`;
CREATE TEMPORARY TABLE `everlake_box_stage` (
  `pick` tinyint NOT NULL COMMENT '0 kill loot, 1 Pick Pocket',
  `entry` int unsigned NOT NULL,
  `item` int unsigned NOT NULL,
  `chance` float NOT NULL,
  `src` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`pick`, `entry`, `item`)
) ENGINE=InnoDB;

INSERT INTO `everlake_box_stage` (`pick`, `entry`, `item`, `chance`, `src`) VALUES
(0, 255071, 4632, 0.643, 'icyveins'),  -- Sewer Fiend: Ornate Bronze Lockbox
(0, 246600, 4633, 1.189, 'icyveins'),  -- Mana Echo: Heavy Bronze Lockbox
(0, 246683, 4633, 5.95, 'icyveins'),  -- Mana Phantom: Heavy Bronze Lockbox
(0, 246888, 4633, 1.012, 'icyveins'),  -- Arcane Elemental: Heavy Bronze Lockbox
(0, 246990, 4633, 1.579, 'icyveins'),  -- Phantasm: Heavy Bronze Lockbox
(0, 246992, 4633, 0.796, 'icyveins'),  -- Arcane Echo: Heavy Bronze Lockbox
(0, 246993, 4633, 0.329, 'icyveins'),  -- Mana Stalker: Heavy Bronze Lockbox
(0, 255065, 4633, 3.064, 'icyveins+wowhead'),  -- Risen Terror: Heavy Bronze Lockbox
(0, 255068, 4633, 1.348, 'icyveins'),  -- Mindless Horror: Heavy Bronze Lockbox
(0, 255070, 4633, 1.427, 'icyveins'),  -- Skeletal Warder: Heavy Bronze Lockbox
(0, 255071, 4633, 1.929, 'icyveins+wowhead'),  -- Sewer Fiend: Heavy Bronze Lockbox
(0, 260800, 4633, 0.8, 'icyveins'),  -- Thicket Lurker: Heavy Bronze Lockbox
(0, 260801, 4633, 0.925, 'icyveins'),  -- Thicket Hunter: Heavy Bronze Lockbox
(0, 260802, 4633, 1.484, 'icyveins'),  -- Thicket Matriarch: Heavy Bronze Lockbox
(0, 260808, 4633, 0.498, 'icyveins'),  -- Highland Horror: Heavy Bronze Lockbox
(0, 264081, 4633, 0.248, 'icyveins'),  -- Gloomrise Spinner: Heavy Bronze Lockbox
(0, 264083, 4633, 0.291, 'icyveins'),  -- Gloomrise Soldier: Heavy Bronze Lockbox
(0, 270094, 4633, 0.535, 'icyveins'),  -- Stormheart: Heavy Bronze Lockbox
(0, 271336, 4633, 0.407, 'icyveins'),  -- Carnage: Heavy Bronze Lockbox
(0, 271346, 4633, 0.608, 'icyveins'),  -- Dragonmaw Infiltrator: Heavy Bronze Lockbox
(0, 271348, 4633, 0.59, 'icyveins'),  -- Dragonmaw Soulbinder: Heavy Bronze Lockbox
(0, 271351, 4633, 0.721, 'icyveins'),  -- Dragonmaw Reclaimer: Heavy Bronze Lockbox
(0, 271732, 4633, 1.543, 'icyveins'),  -- Thicket Stalker: Heavy Bronze Lockbox
(0, 250187, 4634, 1.116, 'icyveins+wowhead'),  -- Bladetooth Frenzy: Iron Lockbox
(0, 255066, 4634, 0.025, 'icyveins'),  -- Fallen Mage: Iron Lockbox
(0, 255774, 4634, 0.042, 'icyveins'),  -- Redridge Scout: Iron Lockbox
(0, 256383, 4634, 0.074, 'icyveins'),  -- Meadowsbrook Farmhand: Iron Lockbox
(0, 268462, 4634, 3.922, 'icyveins'),  -- Mana-Rich Frenzy: Iron Lockbox
(0, 270892, 4634, 0.627, 'icyveins'),  -- Goaz Warder: Iron Lockbox
(0, 271338, 4634, 0.789, 'icyveins'),  -- Ados: Iron Lockbox
(0, 271373, 4634, 1.739, 'icyveins'),  -- Subdued Dragonspawn: Iron Lockbox
(0, 271458, 4634, 0.778, 'icyveins'),  -- Neru: Iron Lockbox
(0, 271460, 4634, 0.931, 'icyveins'),  -- Modr: Iron Lockbox
(0, 271462, 4634, 0.209, 'icyveins'),  -- Golm: Iron Lockbox
(0, 272389, 4634, 0.478, 'icyveins'),  -- Marsh Owl: Iron Lockbox
(0, 250187, 4636, 0.976, 'icyveins'),  -- Bladetooth Frenzy: Strong Iron Lockbox
(0, 254560, 4636, 0.226, 'icyveins'),  -- Twilight Shadowmancer: Strong Iron Lockbox
(0, 255560, 4636, 0.21, 'icyveins'),  -- Magram Guardian: Strong Iron Lockbox
(0, 255769, 4636, 0.082, 'icyveins'),  -- Redridge Brute: Strong Iron Lockbox
(0, 255770, 4636, 0.048, 'icyveins'),  -- Redridge Mystic: Strong Iron Lockbox
(0, 255772, 4636, 0.227, 'icyveins'),  -- Redridge Trapper: Strong Iron Lockbox
(0, 255774, 4636, 0.084, 'icyveins'),  -- Redridge Scout: Strong Iron Lockbox
(0, 255851, 4636, 0.037, 'icyveins'),  -- Mature Paletusk: Strong Iron Lockbox
(0, 255898, 4636, 0.091, 'icyveins'),  -- Murloc Oracle: Strong Iron Lockbox
(0, 255901, 4636, 0.154, 'icyveins'),  -- Sand Crawler: Strong Iron Lockbox
(0, 256383, 4636, 0.034, 'icyveins'),  -- Meadowsbrook Farmhand: Strong Iron Lockbox
(0, 256434, 4636, 0.158, 'icyveins'),  -- Turner's Mill Lumberjack: Strong Iron Lockbox
(0, 256749, 4636, 0.154, 'icyveins'),  -- Rog'mar Trainee: Strong Iron Lockbox
(0, 256798, 4636, 0.082, 'icyveins'),  -- Twilight Neophyte: Strong Iron Lockbox
(0, 256801, 4636, 0.096, 'icyveins'),  -- Murloc Warrior: Strong Iron Lockbox
(0, 256807, 4636, 0.188, 'icyveins'),  -- Shore Crawler: Strong Iron Lockbox
(0, 256952, 4636, 0.101, 'icyveins'),  -- Twilight Raider: Strong Iron Lockbox
(0, 257888, 4636, 1.439, 'icyveins'),  -- Krol'dok Shaman: Strong Iron Lockbox
(0, 257900, 4636, 1.347, 'icyveins'),  -- Redridge Prisoner: Strong Iron Lockbox
(0, 257926, 4636, 0.213, 'icyveins'),  -- Farholde Scout: Strong Iron Lockbox
(0, 258038, 4636, 0.484, 'icyveins'),  -- Shadowhide Bully: Strong Iron Lockbox
(0, 258040, 4636, 0.897, 'icyveins'),  -- Shadowhide Curseweaver: Strong Iron Lockbox
(0, 258042, 4636, 0.438, 'icyveins'),  -- Twilight Grunt: Strong Iron Lockbox
(0, 258331, 4636, 0.21, 'icyveins'),  -- Young Paletusk: Strong Iron Lockbox
(0, 258573, 4636, 0.12, 'icyveins'),  -- Mudfin Oracle: Strong Iron Lockbox
(0, 258574, 4636, 0.066, 'icyveins'),  -- Mudfin Warrior: Strong Iron Lockbox
(0, 258588, 4636, 0.279, 'icyveins'),  -- Jumbo Crawfish: Strong Iron Lockbox
(0, 258687, 4636, 0.527, 'icyveins'),  -- Krol'dok Brute: Strong Iron Lockbox
(0, 258792, 4636, 1.536, 'icyveins'),  -- Risen Sentry: Strong Iron Lockbox
(0, 258804, 4636, 1.627, 'icyveins'),  -- Brinescale Sorceress: Strong Iron Lockbox
(0, 259046, 4636, 0.29, 'icyveins'),  -- Freshwater Crocolisk: Strong Iron Lockbox
(0, 259052, 4636, 0.052, 'icyveins'),  -- Rog'mar Poacher: Strong Iron Lockbox
(0, 259054, 4636, 0.152, 'icyveins'),  -- Wildplains Patriarch: Strong Iron Lockbox
(0, 259055, 4636, 0.199, 'icyveins'),  -- Wildplains Huntress: Strong Iron Lockbox
(0, 259263, 4636, 0.559, 'icyveins'),  -- Coyote Prowler: Strong Iron Lockbox
(0, 259267, 4636, 0.26, 'icyveins'),  -- Plains Coyote: Strong Iron Lockbox
(0, 259269, 4636, 0.218, 'icyveins'),  -- High Plains Buzzard: Strong Iron Lockbox
(0, 259979, 4636, 0.833, 'icyveins'),  -- Saltseer Murderer: Strong Iron Lockbox
(0, 259981, 4636, 0.734, 'icyveins'),  -- Saltseer Cultist: Strong Iron Lockbox
(0, 259987, 4636, 0.702, 'icyveins'),  -- Saltseer Manhunter: Strong Iron Lockbox
(0, 260353, 4636, 0.834, 'icyveins'),  -- Saltseer Coroner: Strong Iron Lockbox
(0, 260429, 4636, 0.348, 'icyveins'),  -- Venture Co. Agent: Strong Iron Lockbox
(0, 260969, 4636, 0.209, 'icyveins'),  -- Twilight Instigator: Strong Iron Lockbox
(0, 261711, 4636, 0.087, 'icyveins'),  -- Empowered Brute: Strong Iron Lockbox
(0, 262037, 4636, 0.146, 'icyveins'),  -- Roosting Duskbat: Strong Iron Lockbox
(0, 262169, 4636, 0.079, 'icyveins'),  -- Twilight Ritualist: Strong Iron Lockbox
(0, 262397, 4636, 0.146, 'icyveins'),  -- Brinescale Skirmisher: Strong Iron Lockbox
(0, 262473, 4636, 0.211, 'icyveins'),  -- Cinderscale Whelp: Strong Iron Lockbox
(0, 263196, 4636, 1.43, 'icyveins'),  -- Profane Necromancer: Strong Iron Lockbox
(0, 263307, 4636, 0.1, 'icyveins'),  -- Glade Viper: Strong Iron Lockbox
(0, 263343, 4636, 0.195, 'icyveins'),  -- Low Plains Buzzard: Strong Iron Lockbox
(0, 263348, 4636, 0.11, 'icyveins'),  -- Roving Tallstrider: Strong Iron Lockbox
(0, 263899, 4636, 2.026, 'icyveins'),  -- Undying Offering: Strong Iron Lockbox
(0, 268321, 4636, 2.023, 'icyveins'),  -- Bound Elemental: Strong Iron Lockbox
(0, 268462, 4636, 1.961, 'icyveins'),  -- Mana-Rich Frenzy: Strong Iron Lockbox
(0, 270667, 4636, 0.282, 'icyveins'),  -- Farholde Priest: Strong Iron Lockbox
(0, 272228, 4636, 0.199, 'icyveins'),  -- Harvest Sentry: Strong Iron Lockbox
(0, 252711, 4637, 1.075, 'icyveins'),  -- Decrepit Pylon Protector: Steel Lockbox
(0, 253272, 4637, 0.668, 'icyveins'),  -- Magram Necromancer: Steel Lockbox
(0, 255850, 4637, 0.261, 'icyveins+wowhead'),  -- Bolder'ok Brute: Steel Lockbox
(0, 256795, 4637, 0.167, 'icyveins'),  -- Twilight Fanatic: Steel Lockbox
(0, 256797, 4637, 0.147, 'icyveins'),  -- Twilight Corrupter: Steel Lockbox
(0, 256799, 4637, 0.211, 'icyveins'),  -- Twilight Champion: Steel Lockbox
(0, 256801, 4637, 0.064, 'icyveins'),  -- Murloc Warrior: Steel Lockbox
(0, 256899, 4637, 0.328, 'icyveins'),  -- Chogg'Zac: Steel Lockbox
(0, 257885, 4637, 1.353, 'icyveins'),  -- Krol'dok Centurion: Steel Lockbox
(0, 257888, 4637, 0.48, 'icyveins'),  -- Krol'dok Shaman: Steel Lockbox
(0, 257901, 4637, 0.07, 'icyveins'),  -- Eastsea Buccaneer: Steel Lockbox
(0, 257910, 4637, 0.058, 'icyveins'),  -- Eastsea Musketeer: Steel Lockbox
(0, 257915, 4637, 0.172, 'icyveins'),  -- Eastsea Raider: Steel Lockbox
(0, 257916, 4637, 0.087, 'icyveins'),  -- Eastsea Bombardier: Steel Lockbox
(0, 258038, 4637, 0.726, 'icyveins'),  -- Shadowhide Bully: Steel Lockbox
(0, 258042, 4637, 0.701, 'icyveins'),  -- Twilight Grunt: Steel Lockbox
(0, 258100, 4637, 1.046, 'icyveins'),  -- Twilight Warlock: Steel Lockbox
(0, 258102, 4637, 0.733, 'icyveins'),  -- Twilight Outrider: Steel Lockbox
(0, 258104, 4637, 1.448, 'icyveins'),  -- Twilight Lieutenant: Steel Lockbox
(0, 258687, 4637, 0.583, 'icyveins'),  -- Krol'dok Brute: Steel Lockbox
(0, 260968, 4637, 0.194, 'icyveins'),  -- Twilight Mauler: Steel Lockbox
(0, 260995, 4637, 0.336, 'icyveins'),  -- Ogre Miner: Steel Lockbox
(0, 260996, 4637, 0.115, 'icyveins'),  -- Twilight Subjugator: Steel Lockbox
(0, 261497, 4637, 0.073, 'icyveins'),  -- Twilight Firecaller: Steel Lockbox
(0, 262065, 4637, 2.459, 'icyveins'),  -- Riding Wolf: Steel Lockbox
(0, 262169, 4637, 0.058, 'icyveins'),  -- Twilight Ritualist: Steel Lockbox
(0, 262477, 4637, 0.191, 'icyveins'),  -- Cinderscale Warrior: Steel Lockbox
(0, 263141, 4637, 2.778, 'icyveins'),  -- Scaldaron: Steel Lockbox
(0, 263681, 4637, 0.885, 'icyveins'),  -- Bear: Steel Lockbox
(0, 268423, 4637, 4.66, 'icyveins'),  -- Zalfan Moonshadow: Steel Lockbox
(0, 255262, 4638, 1.325, 'icyveins'),  -- Alcaz Chaplain: Reinforced Steel Lockbox
(0, 255267, 4638, 3.39, 'icyveins'),  -- Slavering Hound: Reinforced Steel Lockbox
(0, 255271, 4638, 2.069, 'icyveins'),  -- Defias Truthfinder: Reinforced Steel Lockbox
(0, 255276, 4638, 0.549, 'icyveins'),  -- Defias Mercenary: Reinforced Steel Lockbox
(0, 255309, 4638, 1.685, 'icyveins'),  -- Defias Bounty Hunter: Reinforced Steel Lockbox
(0, 255364, 4638, 1.282, 'icyveins'),  -- Renegade Conjurer: Reinforced Steel Lockbox
(0, 255373, 4638, 1.587, 'icyveins'),  -- Strashaz Enchantress: Reinforced Steel Lockbox
(0, 255377, 4638, 1.379, 'icyveins'),  -- Alcaz Jailer: Reinforced Steel Lockbox
(0, 255995, 4638, 1.695, 'icyveins'),  -- Strashaz Soldier: Reinforced Steel Lockbox
(0, 271784, 4638, 3.39, 'icyveins'),  -- Alcaz Jailer: Reinforced Steel Lockbox
(0, 247237, 5758, 3.279, 'icyveins'),  -- Blackmaw Berserker: Mithril Lockbox
(0, 255247, 5758, 1.961, 'icyveins'),  -- Swarming Imp: Mithril Lockbox
(0, 249551, 5759, 1.408, 'icyveins'),  -- Blackthorne Cultist: Thorium Lockbox
(0, 250023, 5759, 1.299, 'icyveins'),  -- Blackmaw Thrall: Thorium Lockbox
(0, 250027, 5759, 5.085, 'icyveins'),  -- Blackmaw Headhunter: Thorium Lockbox
(0, 255247, 5759, 0.98, 'icyveins'),  -- Swarming Imp: Thorium Lockbox
(0, 255347, 5759, 3.448, 'icyveins'),  -- Legashi Slayer: Thorium Lockbox
(0, 255394, 5759, 5.556, 'icyveins'),  -- Blackmaw Champion: Thorium Lockbox
(0, 277474, 5759, 4.274, 'icyveins'),  -- Blackmaw Devotee: Thorium Lockbox
(1, 203139, 16882, 20, 'icyveins'),  -- Son of Arugal: Battered Junkbox
(1, 214456, 16882, 20, 'icyveins'),  -- Dro'zem the Blasphemous: Battered Junkbox
(1, 214519, 16882, 20, 'icyveins'),  -- Incinerator Gar'im: Battered Junkbox
(1, 255066, 16882, 20, 'icyveins+wowhead'),  -- Fallen Mage: Battered Junkbox
(1, 255068, 16882, 20, 'icyveins+wowhead'),  -- Mindless Horror: Battered Junkbox
(1, 255069, 16882, 20, 'icyveins+wowhead'),  -- Fallen Warrior: Battered Junkbox
(1, 255070, 16882, 20, 'icyveins+wowhead'),  -- Skeletal Warder: Battered Junkbox
(1, 255071, 16882, 20, 'icyveins'),  -- Sewer Fiend: Battered Junkbox
(1, 255072, 16882, 20, 'icyveins+wowhead'),  -- Dark Caster: Battered Junkbox
(1, 266216, 16882, 20, 'icyveins+wowhead'),  -- Lord Tomas: Battered Junkbox
(1, 267307, 16882, 20, 'icyveins+wowhead'),  -- Chol'aruk: Battered Junkbox
(1, 268622, 16882, 20, 'icyveins+wowhead'),  -- Encroaching Soldier: Battered Junkbox
(1, 268623, 16882, 20, 'icyveins+wowhead'),  -- Outraged Pillager: Battered Junkbox
(1, 269134, 16882, 20, 'icyveins+wowhead'),  -- Kirin Tor Necromancer: Battered Junkbox
(1, 271346, 16882, 20, 'icyveins+wowhead'),  -- Dragonmaw Infiltrator: Battered Junkbox
(1, 271348, 16882, 20, 'icyveins+wowhead'),  -- Dragonmaw Soulbinder: Battered Junkbox
(1, 271351, 16882, 20, 'icyveins+wowhead'),  -- Dragonmaw Reclaimer: Battered Junkbox
(1, 272284, 16882, 20, 'icyveins'),  -- Lost Defender: Battered Junkbox
(1, 275044, 16882, 20, 'icyveins'),  -- Dragonmaw Warder: Battered Junkbox
(1, 275045, 16882, 20, 'icyveins'),  -- Dragonmaw Saboteur: Battered Junkbox
(1, 275046, 16882, 20, 'icyveins'),  -- Dragonmaw Thaumaturgist: Battered Junkbox
(1, 246003, 16883, 14.5, 'icyveins'),  -- Fel Ancient: Worn Junkbox
(1, 246016, 16883, 14.5, 'icyveins'),  -- Arcanic Enigma: Worn Junkbox
(1, 253272, 16883, 14.5, 'icyveins'),  -- Magram Necromancer: Worn Junkbox
(1, 254284, 16883, 14.5, 'wowhead'),  -- Outcast Marauder: Worn Junkbox
(1, 254560, 16883, 14.5, 'icyveins+wowhead'),  -- Twilight Shadowmancer: Worn Junkbox
(1, 255561, 16883, 14.5, 'icyveins'),  -- Gelkis Guardian: Worn Junkbox
(1, 255769, 16883, 14.5, 'icyveins+wowhead'),  -- Redridge Brute: Worn Junkbox
(1, 255770, 16883, 14.5, 'icyveins+wowhead'),  -- Redridge Mystic: Worn Junkbox
(1, 255772, 16883, 14.5, 'icyveins+wowhead'),  -- Redridge Trapper: Worn Junkbox
(1, 255774, 16883, 14.5, 'icyveins+wowhead'),  -- Redridge Scout: Worn Junkbox
(1, 255851, 16883, 14.5, 'icyveins+wowhead'),  -- Mature Paletusk: Worn Junkbox
(1, 255898, 16883, 14.5, 'icyveins+wowhead'),  -- Murloc Oracle: Worn Junkbox
(1, 256383, 16883, 14.5, 'icyveins'),  -- Meadowsbrook Farmhand: Worn Junkbox
(1, 256434, 16883, 14.5, 'icyveins+wowhead'),  -- Turner's Mill Lumberjack: Worn Junkbox
(1, 256749, 16883, 14.5, 'icyveins+wowhead'),  -- Rog'mar Trainee: Worn Junkbox
(1, 256798, 16883, 14.5, 'icyveins+wowhead'),  -- Twilight Neophyte: Worn Junkbox
(1, 257001, 16883, 14.5, 'icyveins+wowhead'),  -- Old Rot-Chum: Worn Junkbox
(1, 257926, 16883, 14.5, 'icyveins+wowhead'),  -- Farholde Scout: Worn Junkbox
(1, 258331, 16883, 14.5, 'icyveins+wowhead'),  -- Young Paletusk: Worn Junkbox
(1, 258573, 16883, 14.5, 'icyveins+wowhead'),  -- Mudfin Oracle: Worn Junkbox
(1, 258574, 16883, 14.5, 'icyveins+wowhead'),  -- Mudfin Warrior: Worn Junkbox
(1, 258792, 16883, 14.5, 'icyveins'),  -- Risen Sentry: Worn Junkbox
(1, 258797, 16883, 14.5, 'icyveins'),  -- Champion of the Deep: Worn Junkbox
(1, 258799, 16883, 14.5, 'icyveins'),  -- Brinescale Explorer: Worn Junkbox
(1, 258804, 16883, 14.5, 'icyveins'),  -- Brinescale Sorceress: Worn Junkbox
(1, 258849, 16883, 14.5, 'icyveins'),  -- Saltscale Muckdweller: Worn Junkbox
(1, 259052, 16883, 14.5, 'icyveins+wowhead'),  -- Rog'mar Poacher: Worn Junkbox
(1, 259979, 16883, 14.5, 'icyveins'),  -- Saltseer Murderer: Worn Junkbox
(1, 259981, 16883, 14.5, 'icyveins'),  -- Saltseer Cultist: Worn Junkbox
(1, 259987, 16883, 14.5, 'icyveins'),  -- Saltseer Manhunter: Worn Junkbox
(1, 260353, 16883, 14.5, 'icyveins'),  -- Saltseer Coroner: Worn Junkbox
(1, 260969, 16883, 14.5, 'icyveins'),  -- Twilight Instigator: Worn Junkbox
(1, 261710, 16883, 14.5, 'icyveins+wowhead'),  -- Twilight Brute: Worn Junkbox
(1, 261711, 16883, 14.5, 'icyveins+wowhead'),  -- Empowered Brute: Worn Junkbox
(1, 262169, 16883, 14.5, 'icyveins+wowhead'),  -- Twilight Ritualist: Worn Junkbox
(1, 263071, 16883, 14.5, 'wowhead'),  -- Blademaster Kaijo: Worn Junkbox
(1, 263196, 16883, 14.5, 'icyveins'),  -- Profane Necromancer: Worn Junkbox
(1, 267065, 16883, 14.5, 'icyveins+wowhead'),  -- Syndicate Smuggler: Worn Junkbox
(1, 270667, 16883, 14.5, 'icyveins'),  -- Farholde Priest: Worn Junkbox
(1, 222286, 16884, 9.5, 'icyveins'),  -- Namida Grimtotem: Sturdy Junkbox
(1, 253524, 16884, 9.5, 'wowhead'),  -- Bristleback Nomad: Sturdy Junkbox
(1, 255271, 16884, 9.5, 'icyveins'),  -- Defias Truthfinder: Sturdy Junkbox
(1, 255276, 16884, 9.5, 'icyveins'),  -- Defias Mercenary: Sturdy Junkbox
(1, 255309, 16884, 9.5, 'icyveins'),  -- Defias Bounty Hunter: Sturdy Junkbox
(1, 255373, 16884, 9.5, 'icyveins'),  -- Strashaz Enchantress: Sturdy Junkbox
(1, 255849, 16884, 9.5, 'wowhead'),  -- Bolder'ok Magus: Sturdy Junkbox
(1, 255850, 16884, 9.5, 'wowhead'),  -- Bolder'ok Brute: Sturdy Junkbox
(1, 255906, 16884, 9.5, 'wowhead'),  -- Snargl: Sturdy Junkbox
(1, 255995, 16884, 9.5, 'icyveins'),  -- Strashaz Soldier: Sturdy Junkbox
(1, 256433, 16884, 9.5, 'icyveins+wowhead'),  -- Woodworker: Sturdy Junkbox
(1, 256795, 16884, 9.5, 'icyveins+wowhead'),  -- Twilight Fanatic: Sturdy Junkbox
(1, 256797, 16884, 9.5, 'icyveins+wowhead'),  -- Twilight Corrupter: Sturdy Junkbox
(1, 256799, 16884, 9.5, 'icyveins+wowhead'),  -- Twilight Champion: Sturdy Junkbox
(1, 256801, 16884, 9.5, 'icyveins+wowhead'),  -- Murloc Warrior: Sturdy Junkbox
(1, 256899, 16884, 9.5, 'icyveins'),  -- Chogg'Zac: Sturdy Junkbox
(1, 256952, 16884, 9.5, 'icyveins+wowhead'),  -- Twilight Raider: Sturdy Junkbox
(1, 257885, 16884, 9.5, 'icyveins'),  -- Krol'dok Centurion: Sturdy Junkbox
(1, 257901, 16884, 9.5, 'icyveins+wowhead'),  -- Eastsea Buccaneer: Sturdy Junkbox
(1, 257910, 16884, 9.5, 'icyveins+wowhead'),  -- Eastsea Musketeer: Sturdy Junkbox
(1, 257915, 16884, 9.5, 'icyveins+wowhead'),  -- Eastsea Raider: Sturdy Junkbox
(1, 257916, 16884, 9.5, 'icyveins+wowhead'),  -- Eastsea Bombardier: Sturdy Junkbox
(1, 258042, 16884, 9.5, 'icyveins'),  -- Twilight Grunt: Sturdy Junkbox
(1, 258100, 16884, 9.5, 'icyveins'),  -- Twilight Warlock: Sturdy Junkbox
(1, 258102, 16884, 9.5, 'icyveins'),  -- Twilight Outrider: Sturdy Junkbox
(1, 258687, 16884, 9.5, 'icyveins'),  -- Krol'dok Brute: Sturdy Junkbox
(1, 260023, 16884, 9.5, 'wowhead'),  -- Farholde Ambusher: Sturdy Junkbox
(1, 260211, 16884, 9.5, 'icyveins'),  -- Scoutmaster Vargas: Sturdy Junkbox
(1, 260931, 16884, 9.5, 'wowhead'),  -- Clubtoe: Sturdy Junkbox
(1, 260968, 16884, 9.5, 'icyveins+wowhead'),  -- Twilight Mauler: Sturdy Junkbox
(1, 260995, 16884, 9.5, 'icyveins+wowhead'),  -- Ogre Miner: Sturdy Junkbox
(1, 260996, 16884, 9.5, 'wowhead'),  -- Twilight Subjugator: Sturdy Junkbox
(1, 261497, 16884, 9.5, 'icyveins+wowhead'),  -- Twilight Firecaller: Sturdy Junkbox
(1, 262067, 16884, 9.5, 'icyveins'),  -- Twilight Peon: Sturdy Junkbox
(1, 262397, 16884, 9.5, 'wowhead'),  -- Brinescale Skirmisher: Sturdy Junkbox
(1, 271784, 16884, 9.5, 'icyveins'),  -- Alcaz Jailer: Sturdy Junkbox
(1, 249229, 16885, 8.8, 'wowhead'),  -- Felguard Sentinel: Heavy Junkbox
(1, 252096, 16885, 8.8, 'wowhead'),  -- Deadwood Fel-Tender: Heavy Junkbox
(1, 252116, 16885, 8.8, 'wowhead'),  -- Deadwood Totemic: Heavy Junkbox
(1, 260422, 16885, 8.8, 'wowhead');  -- Ashen Acolyte: Heavy Junkbox

-- only creatures the realm has, with loot ids that are theirs alone or still unset, and no row for the item yet
DELETE s FROM `everlake_box_stage` s
WHERE s.`pick` = 0 AND (
  NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`LootID` IN (0, s.`entry`))
  OR EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`LootID` NOT IN (0, s.`entry`))
  OR EXISTS (SELECT 1 FROM `creature_loot_template` l WHERE l.`Entry` = s.`entry` AND l.`ItemType` = 0 AND l.`Item` = s.`item`));
DELETE s FROM `everlake_box_stage` s
WHERE s.`pick` = 1 AND (
  NOT EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`PickPocketLootID` IN (0, s.`entry`))
  OR EXISTS (SELECT 1 FROM `creature_template_difficulty` d WHERE d.`Entry` = s.`entry` AND d.`PickPocketLootID` NOT IN (0, s.`entry`))
  OR EXISTS (SELECT 1 FROM `pickpocketing_loot_template` l WHERE l.`Entry` = s.`entry` AND l.`ItemType` = 0 AND l.`Item` = s.`item`));

UPDATE `creature_template_difficulty` d JOIN (SELECT DISTINCT `entry` FROM `everlake_box_stage` WHERE `pick` = 0) s ON s.`entry` = d.`Entry`
SET d.`LootID` = d.`Entry` WHERE d.`LootID` = 0;
UPDATE `creature_template_difficulty` d JOIN (SELECT DISTINCT `entry` FROM `everlake_box_stage` WHERE `pick` = 1) s ON s.`entry` = d.`Entry`
SET d.`PickPocketLootID` = d.`Entry` WHERE d.`PickPocketLootID` = 0;

INSERT INTO `creature_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`entry`, 0, s.`item`, s.`chance`, 0, 1, 0, 1, 1, CONCAT('Forever lockbox: ', s.`src`) FROM `everlake_box_stage` s WHERE s.`pick` = 0;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'creature_loot_template', s.`entry`, 0, s.`item`, 0, @EVERLAKE_FILE, CONCAT(s.`src`, ': chance per kill, capped at the realm''s highest') FROM `everlake_box_stage` s WHERE s.`pick` = 0;

INSERT INTO `pickpocketing_loot_template` (`Entry`, `ItemType`, `Item`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
SELECT s.`entry`, 0, s.`item`, s.`chance`, 0, 1, 0, 1, 1, CONCAT('Forever junkbox: ', s.`src`) FROM `everlake_box_stage` s WHERE s.`pick` = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`)
SELECT 'pickpocketing_loot_template', s.`entry`, 0, s.`item`, 0, @EVERLAKE_FILE, CONCAT(s.`src`, ' saw the junkbox; chance INFERRED = realm average') FROM `everlake_box_stage` s WHERE s.`pick` = 1;

DROP TEMPORARY TABLE IF EXISTS `everlake_box_stage`;

COMMIT;
