-- Efficient Games Forever 70862 vendor capture, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae (CC BY 4.0).
-- Neutral price of 1000 copper for each draught matches ItemSparse.
INSERT INTO `npc_vendor`
    (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`)
SELECT 15126, offer.slot, offer.item, 0, 0, 0, 1, 0, 0, 0
FROM (SELECT 220 AS slot, 17348 AS item UNION ALL SELECT 221, 17351) offer
WHERE EXISTS (
    SELECT 1 FROM `creature_template` t JOIN `creature` c ON c.id=t.entry
    WHERE t.entry=15126 AND t.name='Rutherford Twing' AND c.map=0
        AND (COALESCE(c.npcflag, t.npcflag) & 128)=128
)
AND EXISTS (SELECT 1 FROM `npc_vendor` v WHERE v.entry=15126 AND v.item=17349 AND v.type=1)
AND NOT EXISTS (
    SELECT 1 FROM `npc_vendor` v
    WHERE v.entry=15126 AND (v.slot=offer.slot OR (v.item=offer.item AND v.type=1))
);
