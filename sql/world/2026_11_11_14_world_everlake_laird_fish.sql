-- Efficient Games Forever 70790: Laird offers. One-hour restock follows vendor 3497.
CREATE TEMPORARY TABLE everlake_laird_fish (npc INT, slot INT, item INT, stock INT, PRIMARY KEY (npc,item));
INSERT INTO everlake_laird_fish VALUES
    (4200, 220, 4603, 5),
    (4200, 221, 6308, 4),
    (4200, 222, 6362, 5),
    (4200, 223, 8959, 5);
INSERT INTO npc_vendor
    (entry, slot, item, maxcount, incrtime, ExtendedCost, type, PlayerConditionID, IgnoreFiltering, VerifiedBuild)
SELECT f.npc, f.slot, f.item, f.stock, 3600, 0, 1, 0, 0, 0
FROM everlake_laird_fish f
WHERE EXISTS (
    SELECT 1 FROM creature_template t JOIN creature c ON c.id=t.entry
    WHERE t.entry=f.npc AND (COALESCE(c.npcflag,t.npcflag)&128)=128
)
AND NOT EXISTS (
    SELECT 1 FROM npc_vendor v WHERE v.entry=f.npc
        AND (v.slot=f.slot OR v.item<0 OR (v.item=f.item AND v.type=1))
);
DROP TEMPORARY TABLE everlake_laird_fish;
