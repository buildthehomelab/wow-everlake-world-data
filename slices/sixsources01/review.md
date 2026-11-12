# Two missing recipe learning drops

Restore Bleakheart Hellcaller (3771) → Plans: Iron Fists (251456) → spell 1252353, and Scarlet Scout (4281) → Schematic: SAF-T Bronze Bomb (264207) → spell 1266910.

Exact NPC/item pairs were checked against current Wowhead Forever item pages linked in manifest.json. Icy Veins independently lists Iron Fists on NPC 3771. NeedRoll supplied the leads but derives its recipe sources from Wowhead and CMaNGOS: it is not an independent vote. Questing.wiki confirms recipe learning identity, without identifying either drop NPC.

Rates are estimates, not measured server truth. Iron Fists differs: Wowhead 0.04%, NeedRoll 0.02%, Icy 1.23%. The patch uses the inspected Wowhead estimate, not an average. Bomb uses Wowhead 0.01%. See manifest for source URLs and disagreements. In-game acquisition remains untested.

The read-only world snapshot had neither item in active creature/vendor routes, reference loot, or fixed/choice quest rewards. Client 70862 Item/ItemSparse and trigger-6 ItemEffect links confirm both learning spells. Correct owner, map spawn and unshared loot ownership were checked. The SQL guards existing direct/reference rows and import provenance.

All 24 open PR file patches (#7–31, excluding absent numbers) were checked immediately before publishing; no item/spell key overlap was found. This change uses unique files and a separate branch. No shared world rows or shared evidence documents were changed.

Only derived factual leads are included; no copyrighted addon source/archive is redistributed. candidates.json retains all 57 dispositions; held records are not asserted to be confirmed defects.
