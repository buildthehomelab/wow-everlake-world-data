-- Icy Veins Forever item listings for Mister Graphed. Costs match pinned ItemExtendedCost.
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,type,PlayerConditionID,IgnoreFiltering,VerifiedBuild)
SELECT 263384,o.slot,o.item,0,0,o.cost,1,0,0,0
FROM (
    SELECT 2 AS slot, 249274 AS item, 11531 AS cost
    UNION ALL SELECT 3 AS slot, 249429 AS item, 11531 AS cost
    UNION ALL SELECT 4 AS slot, 249427 AS item, 11529 AS cost
    UNION ALL SELECT 5 AS slot, 12363 AS item, 11531 AS cost
    UNION ALL SELECT 6 AS slot, 249399 AS item, 11529 AS cost
    UNION ALL SELECT 7 AS slot, 248822 AS item, 11531 AS cost
    UNION ALL SELECT 8 AS slot, 13468 AS item, 11531 AS cost
    UNION ALL SELECT 9 AS slot, 249426 AS item, 11531 AS cost
    UNION ALL SELECT 10 AS slot, 249424 AS item, 11530 AS cost
    UNION ALL SELECT 11 AS slot, 249425 AS item, 11530 AS cost
) o
WHERE EXISTS (
    SELECT 1 FROM creature_template t JOIN creature c ON c.id=t.entry
    WHERE t.entry=263384 AND t.name='Mister Graphed' AND c.map=0 AND (COALESCE(c.npcflag,t.npcflag)&128)=128
)
AND EXISTS (SELECT 1 FROM npc_vendor WHERE entry=263384 AND item=271871 AND type=1)
AND NOT EXISTS (
    SELECT 1 FROM npc_vendor WHERE entry=263384 AND (slot=o.slot OR item<0 OR (item=o.item AND type=1))
);
