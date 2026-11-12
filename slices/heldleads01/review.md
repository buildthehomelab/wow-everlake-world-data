# Steel Spear and vendor blocker follow-up

One missing unlock is ready: Saltstone Crystalhide (4151, map 1) → Plans: Steel Spear (251457) → trigger-6 learning spell 1252354. Both current Wowhead and Icy Veins name the exact pair. Their rate estimates differ (0.03% vs 1.74%); use inspected Wowhead 0.03%, not an average or a claim about exact server truth. NeedRoll's old rounded 0.00% is not a usable positive rate. Client 70862 Item/ItemSparse and ItemEffect links confirm the recipe identity.

Sources: [Wowhead item](https://www.wowhead.com/forever/item=251457/plans-steel-spear), [Icy NPC](https://db.icy-veins.com/wow-forever/npcs/4151), [NeedRoll release](https://www.curseforge.com/wow/addons/needroll/files/9539356). NeedRoll explicitly reuses Wowhead; no source independence is assumed. All pages inspected 2026-11-10 America/Toronto.

The two Doan shoe leads remain held. [Warden pattern](https://www.wowhead.com/forever/item=252845/pattern-wardens-leather-shoes) has no drop attribution in fetched content; [ForeverDB](https://foreverdb.net/item/252845) says source unknown. [Icy Doan](https://db.icy-veins.com/wow-forever/npcs/6487) does not list either item. [Hearthproof](https://hearthproof.com/dungeons/scarlet-monastery-library/) labels Mender's Shoes BETA and rate unknown, with aggregate sources; this does not establish a current direct observation. The Mender exact Wowhead page timed out, and direct HTML requests returned 403. These failures are not evidence of unavailability.

## Vendor work

All 21 previous dispositions are retained in vendor-blockers.json, with explicit targeted follow-up. Dala's three recipe requirements are confirmed by current Wowhead tooltips: [Jam](https://www.wowhead.com/forever/item=274415/recipe-sweetpaw-jam) Friendly, [Bag](https://www.wowhead.com/forever/item=254134/pattern-mooncloth-reagent-bag) and [Lotus Claw](https://www.wowhead.com/forever/item=274424/formula-enchant-gloves-lotus-claw) Honored with Barkskin Burrow. Dala's template and spawn are absent locally. [Mastercraft's public changelog](https://www.curseforge.com/wow/addons/mastercraft/files/9181254/dependencies) names her stock but supplies neither complete spawn placement nor verified terms. A secondary guide claims 10 Deadwood Tribal Beads each; a separate page treats base gold as a price. Neither is a sufficient current observed purchase record. No vendor rows are generated.

Fresh exact-ID [Phoenix Bindings](https://www.wowhead.com/forever/item=211247/pattern-phoenix-bindings) and [old Lesser Arcane Elixir](https://www.wowhead.com/forever/item=217399/recipe-lesser-arcane-elixir) pages still mark them unavailable despite vendor listings. New Forever Lesser Arcane Elixir 250378 is a different ID and belongs to the other session's price corrections. Ziri's nine leads still lack a resolved local NPC template/spawn; Dismantle's Gnomeregan region is insufficient placement proof.

The pinned Efficient Games 70862 observation snapshot (9fcae73cc7) has no target item/NPC matches in loot/vendors/creatures/npcs for the three held leads or Dala. This is incomplete sampling, not proof of absence. Source files were read only and are not redistributed here.

## Validation and coordination

A private schema copied shared world tables read-only. Steel Spear had no active direct creature/vendor route, reference-loot entry or fixed/choice quest reward. One row inserted; the 10 SQL statements passed the core rewrite/parser. Replay preserved the copied loot checksum and one import provenance row. Missing spawn blocks insertion; an existing chance-99 row remains unchanged. See validation.json. In-game testing is pending.

Other session was inspected before work and again before publishing: it owns the 28 Nina Surefire cost/reputation corrections in PR #33 and the Dalria/Kulwia inquiry. Neither was edited. This patch uses unique files and its own branch; no shared world rows or common evidence files were changed.

Pre-publish scan: all 26 open PR file patches checked for item 251457/spell 1252354. Only PR #32's explicitly held research candidate mentions these IDs; no SQL or manifest mutation overlaps.
