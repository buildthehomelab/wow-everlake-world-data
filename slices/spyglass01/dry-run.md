# Local validation

The final test ran in dedicated schema `codex_spyglass_01a1c7e8`, copied using a consistent read snapshot of the current-core local rebuild. Only candidate keys were reset inside that private schema. The source `world` schema was read-only during this test.

- All 19 expected rows inserted and all 19 provenance keys recorded.
- All ten statements passed Everlake's SQL retargeting/rewrite parser.
- Every item chance, loot flag and stack bound matched the manifest.
- Expected-map creature spawns were verified; Sneed's shredder death-cast route was checked separately.
- Reapplying left the entire copied creature-loot table unchanged by checksum.
- Negative tests confirmed that missing spawns, shared loot owners and existing reference loot prevent insertion, and that a pre-existing direct row with a different chance is preserved.

Machine-readable results are in `validation.json`. Client teaching-item checks used pinned build 1.60.1.70862. In-game drops, item use and hosted coverage scoring remain untested.
