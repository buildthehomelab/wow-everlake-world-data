-- Questing.wiki lists Mishta for Pattern: Broodwatcher's Treaders.
-- ItemSparse 70862: 7 gold 50 silver, Cenarion Circle Honored, Leatherworking 295.
INSERT INTO npc_vendor (entry,slot,item,maxcount,incrtime,ExtendedCost,type,VerifiedBuild)
SELECT t.entry,0,275597,0,0,0,1,0
FROM creature_template t
WHERE t.entry=15179 AND t.name='Mishta'
  AND EXISTS (SELECT 1 FROM creature c WHERE c.id=t.entry AND c.map=1 AND (COALESCE(c.npcflag,t.npcflag)&128)<>0)
  AND NOT EXISTS (SELECT 1 FROM npc_vendor WHERE entry=t.entry AND item=275597 AND type=1);
