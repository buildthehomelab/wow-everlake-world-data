# Everlake world import: dry run of slice1, slice2

Made 2026-11-08T17:17:29Z by tools/forever-data/import_dryrun.py against the fork world forever-tdb-2026-10-14+updates@2ae1313e9f, with every file of every slice. Result: **every check passes**.

## Files

- `2026_11_08_00_world_everlake_import_slice1.sql` (import, SHA1 53F438C1D0E5)
- `2026_11_08_01_world_everlake_import_slice1_corrections.sql` (corrections, SHA1 DC60501BC150)
- `2026_11_08_02_world_everlake_import_slice2.sql` (import, SHA1 F7E96DB4AA5D)
- `2026_11_08_03_world_everlake_import_slice2_corrections.sql` (corrections, SHA1 E0567EF48503)

## What the files do

| Slice | | Rows |
|---|---|---|
| slice1 | add `creature_questender` | 40 |
| slice1 | add `creature_queststarter` | 46 |
| slice1 | add `gameobject_questender` | 1 |
| slice1 | add `gameobject_queststarter` | 1 |
| slice1 | add `quest_objectives` | 4 |
| slice1 | add `quest_offer_reward` | 77 |
| slice1 | add `quest_request_items` | 41 |
| slice1 | corrections: other givers or enders | 128 quests: 144 rows added, 4 fork rows removed |
| slice1 | corrections: `quest_template` rows changed | 1 |
| slice1 | review list (not in the files) | 108 |
| slice1 | held back | 238 |
| slice2 | add `creature_loot_template` | 1502 |
| slice2 | corrections: `creature_template_difficulty` rows changed | 177 |
| slice2 | ... of them with their chance from classic | 1451 |
| slice2 | ... of them with their chance from eg-link | 51 |
| slice2 | review list (not in the files) | 533 |
| slice2 | held back | 1480 |

slice1 objective rows: written with Flags,Flags2 = [32, 0].

slice2: drops only Classic data shows (forever-db's drop rows, which are pfQuest/VMaNGOS and CMaNGOS) are added with their Classic chance; each such row's note in `everlake_import_rows` and the file's comment says `classic forever-db N% (pfQuest/CMaNGOS)`, so a later Forever recording can replace it. EG Link's chance needs 50 recorded kills; rows with an EG Link chance say `eg-link drops/kills`.

## Runs

- Stepped (the fork world as deployed, then all our files): 95 s.
- From scratch (the world release, then every fork file and ours in name order): 212 s.

## Checks

- pass: stepped run: the updater skips every fork file (the deployed state is the fork world)
- pass: stepped run: the updater applies each of our files once, in name order
- pass: from scratch: each of our files applied once, after every fork file
- pass: both runs have the same tables
- pass: both runs end with the same world
- pass: fork rows outside the corrections are unchanged (rows added = rows recorded; removed and changed = the corrections')
- pass: the only new table is everlake_import_rows
- pass: every recorded key's row is in the world, once
- pass: no key collides with a fork row
- pass: every recorded row names one of our files
- pass: every new row points at things that exist
- pass: running our files again changes nothing
- pass: the updater skips every file on the next start
- pass: ... and the world stays the same
- pass: the gap report: each gap of the slices' categories is closed, or on the review or held-back list
- pass: the gap report: no category gains an item
- pass: after the fork takes over quest 79097's creature_questender rows (2 were ours), a re-run adds nothing next to its
- pass: after the fork re-sniffs quest_template {'ID': 5634}, a re-run of the corrections leaves it
- pass: after the fork puts back creature_queststarter 4217 for quest 6121, a re-run of the corrections leaves it
- pass: after the fork drops item 735 from loot table 46 (ours), a re-run doesn't add it back
- pass: after the fork links creature 68's own loot table, a re-run of slice 2 leaves it

Tables changed against the fork world (keys): `creature_loot_template` +1502 -0 ~0, `creature_questender` +85 -1 ~0, `creature_queststarter` +124 -3 ~0, `creature_template_difficulty` +0 -0 ~177, `gameobject_questender` +9 -0 ~0, `gameobject_queststarter` +14 -0 ~0, `quest_objectives` +4 -0 ~0, `quest_offer_reward` +77 -0 ~0, `quest_request_items` +41 -0 ~0, `quest_template` +0 -0 ~1

## Gap report, before and after

Loot gaps count drops (npc and item); the rest count quests.

| Gap | Before | After | Closed | Left: review | Left: held back | Left: kept |
|---|---|---|---|---|---|---|
| quests_ender_differs | 58 | 51 | 8 | 49 | 2 | 0 |
| quests_giver_differs | 86 | 60 | 27 | 57 | 3 | 0 |
| quests_no_completion_text | 78 | 1 | 77 | 1 | 0 | 0 |
| quests_no_ender | 72 | 32 | 40 | 0 | 32 | 0 |
| quests_no_giver | 77 | 31 | 46 | 0 | 31 | 0 |
| quests_no_objectives | 173 | 169 | 4 | 0 | 169 | 0 |
| quests_no_progress_text | 42 | 1 | 41 | 1 | 0 | 0 |
| quests_no_text | 1 | 0 | 1 | 0 | 0 | 0 |
| loot_items_missing | 2865 | 1979 | 925 | 529 | 1450 | 0 |
| npcs_no_loot | 650 | 34 | 616 | 4 | 30 | 0 |

Other categories: unchanged.

## slice1: held back, by reason

Full list: slices/slice1/held-back.md.

- 151 x objectives: Forever's objective ids aren't recorded
- 69 x the NPC or object has no template in the world (slice 5)
- 17 x objectives: area trigger or reputation objectives (need more than a row)
- 1 x objectives: a target NPC or object isn't in the world (slice 5)

## slice1: review list

Full list: slices/slice1/review.md.

- quests_ender_differs: 49
- quests_giver_differs: 57
- quests_no_completion_text: 1
- quests_no_progress_text: 1

## slice2: held back, by reason

Full list: slices/slice2/held-back.md.

- 622 x the loot table is shared with other creatures that don't show the drop
- 316 x a quest item no quest in the world asks for
- 270 x only Classic data shows it (forever-db: pfQuest/CMaNGOS), with no chance
- 181 x no usable chance: EG Link has under 50 kills, no Classic chance
- 87 x the item isn't in Forever's client item list (forever-db)
- 3 x stack sizes over one; no source records the range
- 1 x EG Link recorded the NPC's kills without it

## slice2: review list

Full list: slices/slice2/review.md.

- loot_items_missing: 529
- npcs_no_loot: 4
