# Corroborated crafting drops

| Creature | Teaching item | Craft spell | Output | Drop chance |
| --- | ---: | ---: | ---: | ---: |
| Dalaran Shield Guard (2271) | 3866 | 3493 | 3850 | 0.027% |
| Deviate Guardian (3637) | 3611 | 3334 | 3484 | 0.017% |
| Baron Silverlaine (3887) | 7364 | 9149 | 7359 | 0.134% |
| Deviate Shambler (5761) | 4297 | 3771 | 4254 | 0.008% |
| Lorgus Jett (12902) | 253978 | 1257414 | 253977 | 0.227% |
| Lorgus Jett (12902) | 253982 | 1257416 | 253981 | 0.340% |

The Icy Veins Forever NPC capture records all six pairs. The reported fractions were converted to percentages. The two Lorgus Jett patterns were also staged from the ForeverDungeonJournal 2.0.2 comparison. [Shield Guard](https://db.icy-veins.com/api/catalog/wowf/npc/2271) · [Deviate Guardian](https://db.icy-veins.com/api/catalog/wowf/npc/3637) · [Silverlaine](https://db.icy-veins.com/api/catalog/wowf/npc/3887) · [Deviate Shambler](https://db.icy-veins.com/api/catalog/wowf/npc/5761) · [Lorgus Jett](https://db.icy-veins.com/api/catalog/wowf/npc/12902)

Build 70862 ItemXItemEffect and ItemEffect link all six items to trigger-type 6 effects. SpellEffect links each craft to the output shown above. The teaching items, outputs and all 17 distinct reagents are defined in the 70862 and 70888 ItemSparse snapshots. Thirteen reagents have a direct vendor or creature-loot source on a spawned NPC in the test copy. Iron Bar, Steel Bar, Coarse Grinding Stone, and Cerulean Dye were checked by their respective trainer spells (3307, 3337, 3326, 1249630).

The exact NPC/item pairs were absent from the data lake at 1fa4fb8. A scan of 146 fetched PR heads found no matching migration. In a disposable MySQL 8.0.46 release-world copy with the lake's recipe overlays applied, the migration inserted six loot rows and six import-ledger rows. Replay retained the same six keys and rates. All six teaching items had alternate configured loot on spawned creatures before the migration. Gameplay and a fresh Tracker run remain unverified.
