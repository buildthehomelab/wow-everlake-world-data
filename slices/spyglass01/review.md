# Spyglass recipe-source cross-check

Nineteen supported alternate recipe drops across Blackfathom Deeps, the Deadmines, Ragefire Chasm, Shadowfang Keep and the Stockade. This slice examines the remaining 29 Spyglass candidates after addon01's five rows (already included in PR #26).

The manifest links the Icy Veins NPC pages for every rate. Exact boss/item relationships come from [Spyglass](https://github.com/Karl-HeinzSchneider/WoW-Spyglass/tree/8b39cef2456b88227c4c09b3ae7b406e2c92d152/.contribute/data/dungeons); the addon uses encounter IDs, which were resolved to real NPC IDs. The original NPC JSON contains explicit IDs for most bosses; named-only Stockade entries were corroborated against exact Icy Veins NPC pages and expected-map spawns. These sources may share inputs. Rates are public estimates, not authoritative server probabilities.

Build 70862 Item and ItemSparse contain every teaching item. ItemEffect/ItemXItemEffect confirm use spell 402265 and each On Learn crafting spell. Every loot owner is unshared and matches the creature's default difficulty. Nested reference-loot coverage was checked before adding rows. Sneed is reached through his shredder's existing death cast, rather than a static Sneed spawn.

All nineteen recipes already have another locally verified acquisition path. Therefore this slice improves source fidelity and redundancy but adds **zero distinct spell unlocks**. It must not be reported as nineteen new obtainable spells or as a refreshed hosted Tracker score. The other active session's new-unlock work is in PRs #25–27; this branch does not duplicate those files or modify those PRs.

Ten Spyglass candidates and the disposition of all 21 scoped Recipe Registry vendor entries are in `held-back.json`. The three highest-priority Spyglass unlocks remain Expert Campfire, Sentinel's Boots and Justicar's Boots. See the source-expansion catalog under `sources/research-2026-11-10-spyglass/` for six additional lookup or comparison sources, with provenance and reuse limits kept explicit.

## Concurrency note

Initial local testing used the shared rebuild and collided with the other session's `addon02` filename. The published slice uses its own `spyglass01` identifier and `_30_` filename. Final verification copied the necessary world tables into a dedicated schema and made no further changes to the shared `world` schema. Existing shared import tracking for the preliminary file was left alone because that filename also belongs to the other session's six-row draft. Reconcile preliminary tracking by exact keys when rebuilding; do not delete provenance by that shared filename. No live or PTR database was changed here.
