# Everlake world import, slice1: dry run

Made 2026-11-08T16:37:20Z by tools/forever-data/import_dryrun.py against the fork world forever-tdb-2026-10-14+updates@2ae1313e9f. Result: **every check passes**.

## Files

- `2026_11_08_00_world_everlake_import_slice1.sql` (import, SHA1 53F438C1D0E5)
- `2026_11_08_01_world_everlake_import_slice1_corrections.sql` (corrections, SHA1 DC60501BC150)

## What the files do

| | Rows |
|---|---|
| add `creature_questender` | 40 |
| add `creature_queststarter` | 46 |
| add `gameobject_questender` | 1 |
| add `gameobject_queststarter` | 1 |
| add `quest_objectives` | 4 |
| add `quest_offer_reward` | 77 |
| add `quest_request_items` | 41 |
| corrections: other givers or enders | 128 quests: 144 rows added, 4 fork rows removed |
| corrections: empty text filled in | 1 |
| close calls (review list, not in the files) | 108 |
| held back | 238 |

Objective rows: written with Flags,Flags2 = [32, 0].

## Runs

- Stepped (the fork world as deployed, then our files): 78 s.
- From scratch (the world release, then every fork file and ours in name order): 164 s.

## Checks

- pass: stepped run: the updater skips every fork file (the deployed state is the fork world)
- pass: stepped run: the updater applies each of our files once
- pass: from scratch: each of our files applied once, after every fork file
- pass: both runs have the same tables
- pass: both runs end with the same world
- pass: fork rows outside the corrections are unchanged (rows added = rows recorded; removed and changed = the corrections')
- pass: the only new table is everlake_import_rows
- pass: every recorded key's row is in the world
- pass: no key collides with a fork row
- pass: every recorded row names one of our files
- pass: every new row points at things that exist
- pass: running our files again changes nothing
- pass: the updater skips every file on the next start
- pass: ... and the world stays the same
- pass: the gap report: each slice-1 gap is closed, or on the review or held-back list
- pass: the gap report: no category gains an item
- pass: after the fork takes over quest 79097's creature_questender rows (2 were ours), a re-run adds nothing next to its
- pass: after the fork re-sniffs quest_template {'ID': 5634}, a re-run of the corrections leaves it
- pass: after the fork puts back creature_queststarter 4217 for quest 6121, a re-run of the corrections leaves it

Tables changed against the fork world (rows): `creature_questender` +85 -1 ~0, `creature_queststarter` +124 -3 ~0, `gameobject_questender` +9 -0 ~0, `gameobject_queststarter` +14 -0 ~0, `quest_objectives` +4 -0 ~0, `quest_offer_reward` +77 -0 ~0, `quest_request_items` +41 -0 ~0, `quest_template` +0 -0 ~1

## Gap report, before and after

| Gap | Before | After | Closed | Left: review | Left: held back | Left: kept |
|---|---|---|---|---|---|---|
| quests_no_giver | 77 | 31 | 46 | 0 | 31 | 0 |
| quests_giver_differs | 86 | 60 | 27 | 57 | 3 | 0 |
| quests_no_ender | 72 | 32 | 40 | 0 | 32 | 0 |
| quests_ender_differs | 58 | 51 | 8 | 49 | 2 | 0 |
| quests_no_text | 1 | 0 | 1 | 0 | 0 | 0 |
| quests_no_objectives | 173 | 169 | 4 | 0 | 169 | 0 |
| quests_no_progress_text | 42 | 1 | 41 | 1 | 0 | 0 |
| quests_no_completion_text | 78 | 1 | 77 | 1 | 0 | 0 |

Other categories: unchanged.

## Held back, by reason

Full list: held-back.md.

- 151 x objectives: Forever's objective ids aren't recorded
- 69 x the NPC or object has no template in the world (slice 5)
- 17 x objectives: area trigger or reputation objectives (need more than a row)
- 1 x objectives: a target NPC or object isn't in the world (slice 5)

## Close calls

Full list: review.md.

- quests_ender_differs: 49
- quests_giver_differs: 57
- quests_no_completion_text: 1
- quests_no_progress_text: 1
