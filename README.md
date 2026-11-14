# wow-everlake-world-data

Update files for Everlake's world database, made from public data about live WoW Forever. Everlake is a WoW Forever
realm running a TrinityCore fork; this repository holds only data. The generator and the import plan are in
[wow-project-everlake](https://github.com/buildthehomelab/wow-project-everlake): `tools/forever-data` and
`docs/forever-import.md`.

## Layout

- `sql/world/`: TrinityCore update files, named `YYYY_MM_DD_NN_world_everlake_import_<slice>.sql`. Everlake's build
  copies them into the fork's `sql/custom/world/`, where the worldserver's own updater applies them with the fork's files.
- `slices/<slice>/`: for each slice, `manifest.json` (every decision and the source pins), `review.md` (close calls
  kept out of the files), `held-back.md` (rows that need something we don't have, and why) and `dry-run.md` (the two
  dry runs and their checks).

- `sql/world/YYYY_MM_DD_NNN_world_everlake_build.sql` (NNN from 950) and `build/<the file's name>.json`: the world
  build's files, written by the [ForeverTracker](https://github.com/buildthehomelab/wow-forever-tracker)
  (`python tools/tracker.py world export`, described in its `docs/WORLD-BUILD.md`). The tracker replays the fork's
  world, weighs what the sources say against it and writes what the world lacks. The manifest lists every row with
  the rule that passed it and its witnesses, the pins of the sources, and what was held back and why.

- `sql/world/YYYY_MM_DD_900_world_everlake_forge_<operation>_<kind>.sql`: the ForeverTracker Forge's exports, rows
  added on the test realm first and exported as they stood there (the date is the day they were applied). NOTICE.md
  says what each operation's rows come from; each row's ledger note names it too.

## Rules the files follow

- A file is never changed once it is deployed: the updater would run it, and every later custom file, again. A later
  fix is a new file.
- Running a file again changes nothing. An import file adds a row only where none exists and records each row it adds,
  with its own file name, in `everlake_import_rows`. A corrections file changes a fork row only while that row is still
  as the correction was written against.
- Every row names the sources that gave it.

## Licence

GPL-3.0 (see LICENSE), because several sources are GPL-3.0. NOTICE.md credits every source; EG Link's data is CC BY 4.0
and is credited there. Game content such as names and text belongs to Blizzard Entertainment.
