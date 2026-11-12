# Slice 6 local world replay

MySQL 8.0.46 loaded the original October 14 TrinityCore world dump. Everlake’s update planner selected 572 files for replay and skipped 59 already recorded files. The rebuild completed with 275 world tables and all seven SQL files from slices 1–5, plus Everlake’s dynamic respawn update. The source pins and candidate SQL hashes are in the manifest.

| Check | Result |
| --- | --- |
| Fresh world | Neither quest existed. Both givers and both target creatures had world spawns. |
| First application | Both templates, their two classic levels, two objectives, two starters and two enders appeared. The import registry records all ten new rows. Both givers gained the quest-giver flag. |
| Reapplication | The quest, objective, relation and registry rows matched the first result. |
| Upstream overlap | A scratch schema with a pre-existing template for 93786 retained that template and acquired no related rows or quest-giver flag. |
| Missing dependency | In that scratch schema, 95603 stayed absent while its target had no spawn. |

These tests cover SQL and world-table dependencies. Player interaction, terrain reachability and reward presentation still need an in-game check.
