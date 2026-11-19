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

## CI

`.github/workflows/sql.yml` runs `ci/check_sql.py` on every pull request and push that touches `sql/`, and daily. It
builds the PTR's world from scratch the way the image does: the Forever TDB dump, then the core's world update files at
the PTR's core commit and every file here, in file-name order, each through the mysql client over a utf8mb4 connection
on MySQL 8.0 (as the worldserver's updater applies them). A file that fails there would stop the PTR's worldserver, so
it fails the check. Each file a change adds or edits then runs a second time, and any table it writes to must come out
the same (its CHECKSUM). The core commit and the TDB come from wow-project-everlake's `docker-compose.ptr.yml` and
`Dockerfile` on main, so the check follows the PTR's pins by itself. Locally (needs Docker, git, curl and 7z):

    python3 ci/check_sql.py --changed sql/world/<new file>.sql

## Licence

GPL-3.0 (see LICENSE), because several sources are GPL-3.0. NOTICE.md credits every source; EG Link's data is CC BY 4.0
and is credited there. Game content such as names and text belongs to Blizzard Entertainment.
