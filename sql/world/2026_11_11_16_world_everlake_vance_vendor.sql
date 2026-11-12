-- Efficient Games Forever 70862 observed Vance's six vendor offers.
-- Two-hour restock follows matching local enchanting supplies.
START TRANSACTION;
UPDATE creature_template SET npcflag=npcflag|128
WHERE entry=5695 AND name='Vance Undergloom' AND npcflag=83
AND EXISTS (SELECT 1 FROM creature WHERE id=5695 AND map=0 AND npcflag IS NULL);
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,type,PlayerConditionID,IgnoreFiltering,VerifiedBuild)
SELECT 5695,o.slot,o.item,o.stock,o.restock,0,1,0,0,0
FROM (
    SELECT 220 slot,10938 item,1 stock,7200 restock
    UNION ALL SELECT 221,10940,3,7200
    UNION ALL SELECT 222,247786,0,0
    UNION ALL SELECT 223,4470,0,0
    UNION ALL SELECT 224,6217,0,0
    UNION ALL SELECT 225,6342,0,0
) o
WHERE EXISTS (
    SELECT 1 FROM creature_template t JOIN creature c ON c.id=t.entry
    WHERE t.entry=5695 AND t.name='Vance Undergloom' AND c.map=0 AND COALESCE(c.npcflag,t.npcflag)&128
)
AND NOT EXISTS (
    SELECT 1 FROM npc_vendor v WHERE v.entry=5695 AND (v.slot=o.slot OR v.item<0 OR (v.item=o.item AND v.type=1))
);
COMMIT;
