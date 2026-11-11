-- Efficient Games 70862 vendor capture (9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae, CC BY 4.0).
-- Capture shows stock of five. Restock time follows matching local offers on vendor 3497.
CREATE TEMPORARY TABLE everlake_innkeeper_fish (npc INT, slot INT, item INT, PRIMARY KEY (npc,item));
INSERT INTO everlake_innkeeper_fish VALUES
    (6727, 220, 4603),
    (6727, 221, 6303),
    (6727, 222, 6308),
    (6727, 223, 6362),
    (6727, 224, 8959),
    (6791, 220, 4603),
    (6791, 221, 6289),
    (6791, 222, 6308),
    (6791, 223, 6362),
    (6791, 224, 8959),
    (8931, 220, 4603),
    (8931, 221, 6289),
    (8931, 222, 6303),
    (8931, 223, 6308),
    (8931, 224, 6362),
    (8931, 225, 8959),
    (12962, 220, 4603),
    (12962, 221, 6289),
    (12962, 222, 6303),
    (12962, 223, 6308),
    (12962, 224, 6362),
    (12962, 225, 8959);
INSERT INTO npc_vendor
    (entry, slot, item, maxcount, incrtime, ExtendedCost, type, PlayerConditionID, IgnoreFiltering, VerifiedBuild)
SELECT f.npc, f.slot, f.item, 5, 3600, 0, 1, 0, 0, 0
FROM everlake_innkeeper_fish f
WHERE EXISTS (
    SELECT 1 FROM creature_template t JOIN creature c ON c.id=t.entry
    WHERE t.entry=f.npc AND (COALESCE(c.npcflag,t.npcflag)&128)=128
)
AND NOT EXISTS (
    SELECT 1 FROM npc_vendor v WHERE v.entry=f.npc
        AND (v.slot=f.slot OR v.item<0 OR (v.item=f.item AND v.type=1))
);
DROP TEMPORARY TABLE everlake_innkeeper_fish;
