# Isolated validation

Validation used private schema codex_sixsources_01a1c7e8 with a read-only snapshot of the shared world. Two rows inserted and both spell routes resolved. All 10 generated SQL statements passed the local core SQL rewrite/parser. Reapplying preserved the whole copied loot table checksum and left exactly two provenance rows. Negative checks confirmed a missing spawn blocks insertion and an existing row with chance 99 is preserved. See validation.json for the SQL SHA-256 and copied-table counts. No shared world writes were performed. No in-game smoke test was performed.
