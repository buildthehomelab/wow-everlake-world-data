-- ForeverDB.net Loot.lua (build 1.60.1.70862) lists these patterns on Mishta.
-- ItemSparse 70862 and 70888 confirm the 75000 copper base price and Cenarion Circle requirements.
INSERT INTO npc_vendor (entry, slot, item, maxcount, incrtime, ExtendedCost, type, VerifiedBuild)
SELECT t.entry, 0, patterns.item, 0, 0, 0, 1, 0
FROM creature_template t
CROSS JOIN (
    SELECT 275586 AS item
    UNION ALL SELECT 275587
    UNION ALL SELECT 275588
    UNION ALL SELECT 275589
    UNION ALL SELECT 275590
    UNION ALL SELECT 275591
    UNION ALL SELECT 275592
    UNION ALL SELECT 275593
    UNION ALL SELECT 275594
    UNION ALL SELECT 275595
    UNION ALL SELECT 275596
) patterns
WHERE t.entry = 15179 AND t.name = 'Mishta'
  AND EXISTS (
      SELECT 1 FROM creature c
      WHERE c.id = t.entry AND c.map = 1 AND (COALESCE(c.npcflag, t.npcflag) & 128) <> 0
  )
  AND NOT EXISTS (
      SELECT 1 FROM npc_vendor v WHERE v.entry = t.entry AND v.item = patterns.item AND v.type = 1
  );
