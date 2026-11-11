-- AHledger live inventory confirms Torbernite. September beta vendor screenshot quotes 50 gold.
-- ItemExtendedCost 11531 matches that quote in both pinned client builds.
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,type,PlayerConditionID,IgnoreFiltering,VerifiedBuild)
SELECT 263384,14,248820,0,0,11531,1,0,0,0
WHERE EXISTS (
    SELECT 1 FROM creature_template t JOIN creature c ON c.id=t.entry
    WHERE t.entry=263384 AND t.name='Mister Graphed' AND c.map=0 AND (COALESCE(c.npcflag,t.npcflag)&128)=128
)
AND EXISTS (SELECT 1 FROM npc_vendor WHERE entry=263384 AND item=271871 AND type=1)
AND NOT EXISTS (
    SELECT 1 FROM npc_vendor WHERE entry=263384 AND (slot=14 OR item<0 OR (item=248820 AND type=1))
);
