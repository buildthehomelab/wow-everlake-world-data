# Slice 7 local world replay

The local MySQL 8.0.46 world used the October 14 release, core 029c5dd9 and world-data 24a3b39e. The fresh baseline replay applied 572 SQL updates, including all seven files from slices 1–5 and the dynamic respawn update. Slice 6 passed its local checks before this import was applied.

| Inserted table | Rows | Evidence and guard |
| --- | ---: | --- |
| Vendor stock | 17 | Live EG Link money-only, unlimited listings. Vendors are spawned and flagged. Direct and inherited duplicate checks protect existing stock. |
| Creature loot | 5 | EG Link observed each item at least twice in 58 or 63 sampled windows. The tables are linked to spawned creatures and checked for shared users and referenced loot. |
| Quest objectives | 8 | EG Link 70862 objective IDs corroborated by Polestar. The four quests have world templates and each item has an existing loot path from a spawned creature or chest. Multi-objective sets enter together. |
| Quest request text | 12 | Live EG Link text for existing quests without a request row. |
| Quest completion text | 10 | Live EG Link text for existing quests without a reward row. |

All 45 SQL statements passed Everlake’s SQL rewrite. MySQL inserted the 52 expected keys and recorded each in the import registry. The second application left the row counts and registry unchanged. Player-facing behavior still needs an in-game check.
