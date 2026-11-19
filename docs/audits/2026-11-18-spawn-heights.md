# Spawn height audit, 2026-11-18

Started by a player report: Sentinel Selarin (3694) in Auberdine stood in the ground under the floor of her house. Only her
name showed, on the floor.

## What was checked

29,824 creature and object spawns. Each one's height was compared with every surface on its vertical line (terrain, water
and each model), read from Everlake's own maps and vmaps with `tools/height.py` of wow-forever-tracker.

| Source | Spawns |
| --- | ---: |
| Core fork `sql/custom/world`, every file except the two baseline dumps | 24,253 |
| This repository's `sql/world` | 2,775 |
| Forge operations still on the PTR world (read back through the tracker's data repo export) | 2,796 |

The Forge rows and this repository's Forge export files are mostly the same spawns, and were counted once below.

## Groups

- **buried**: a model surface (a floor, a deck, a platform) lies 0.6 to 2.5 yards above the spawn.
- **under**: there is no surface at or below the spawn at all.
- **floating**: more than 2 yards above the surface below it, with no water there.

## Fixed: 36 creatures

`sql/world/2026_11_18_925_world_everlake_spawn_heights_under_floors.sql` moves 36 creatures up onto the surface above them.
Each one meets all three of these:

- It comes from the core fork's `2026_11_05_99_world_forever_restore_forever_quest_data.sql`, the AnoCore port.
- Its height equals the bare terrain to the hundredth, which is what a height read that ignores buildings gives.
- At least 2.5 yards stay free above the new surface.

Live sniffs almost never match the terrain that exactly: of the sniffed creatures, only one fell into this pattern.

## Left for a look in game

`2026-11-18-spawn-heights.csv` lists every other flagged creature, 534 rows. Objects are left out: lanterns under eaves,
hanging banners and decorations on shelves are meant to sit under something, and there were too many of them to sort by
hand. The columns are group, source file, guid, entry, map, x, y, z, the surface the tool found and a note.

| Group | From sniffs | From other files |
| --- | ---: | ---: |
| buried | 8 | 38 |
| under | 10 | 76 |
| floating | 174 | 228 |

Worth looking at first:

- **buried, other files (38).** This includes five AnoCore spawns that are terrain-level but would have less than 2.5 yards
  free above the new surface: 255890 (guid 25589013), 260419 and 260857 (both at -6969.8, -4869.35), 260558, plus
  6491 (guid 47220000, a Riverglades spirit healer). The rest stand on one model with another just above. That can be a
  shelf or an overhang, or a spawn half a floor too low.
- **under, other files (76).** Most of these are in the new Forever zones (map 0 around -8,800, -5,500, and map 2997).
  There, the server's maps may be older than the client's, so the tool's answer is weak. Others are in caves or under water.
- **floating.** Most of these are flying or swimming creatures, or creatures on scaffolding that has no collision. Leave them
  unless a player reports one.
