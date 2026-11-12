-- Icy Veins Forever item listings for Mister Graphed. Costs match pinned ItemExtendedCost.
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,type,PlayerConditionID,IgnoreFiltering,VerifiedBuild)
SELECT 263384,o.slot,o.item,0,0,o.cost,1,0,0,0
FROM (
    SELECT 12 AS slot, 249428 AS item, 11530 AS cost
    UNION ALL SELECT 13, 249391, 11529
) o
WHERE EXISTS (
    SELECT 1 FROM creature_template t JOIN creature c ON c.id=t.entry
    WHERE t.entry=263384 AND t.name='Mister Graphed' AND c.map=0 AND (COALESCE(c.npcflag,t.npcflag)&128)=128
)
AND EXISTS (SELECT 1 FROM npc_vendor WHERE entry=263384 AND item=271871 AND type=1)
AND NOT EXISTS (
    SELECT 1 FROM npc_vendor WHERE entry=263384 AND (slot=o.slot OR item<0 OR (item=o.item AND type=1))
);
