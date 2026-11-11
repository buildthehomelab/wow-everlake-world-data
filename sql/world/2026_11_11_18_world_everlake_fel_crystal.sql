-- Icy Veins Forever item 248819 lists Mister Graphed, 50 gold, stack 1.
-- Pinned ItemExtendedCost 11531 charges 500000 copper without other requirements.
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,type,PlayerConditionID,IgnoreFiltering,VerifiedBuild)
SELECT 263384,1,248819,0,0,11531,1,0,0,0
WHERE EXISTS (
    SELECT 1 FROM creature_template t JOIN creature c ON c.id=t.entry
    WHERE t.entry=263384 AND t.name='Mister Graphed' AND c.map=0 AND (COALESCE(c.npcflag,t.npcflag)&128)=128
)
AND EXISTS (SELECT 1 FROM npc_vendor WHERE entry=263384 AND item=271871 AND type=1)
AND NOT EXISTS (
    SELECT 1 FROM npc_vendor WHERE entry=263384 AND (slot=1 OR item<0 OR (item=248819 AND type=1))
);
