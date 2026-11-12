-- All The Things 5.4.9, 1e38eaa8ab4482387b0479459772b496e30d8ca2, Camelot Zones.lua.
-- ItemSparse 70862 and 70888: Timbermaw Hold (576) Revered (6), Blacksmithing 300.
INSERT INTO `npc_vendor`
    (`entry`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`, `type`, `PlayerConditionID`, `IgnoreFiltering`, `VerifiedBuild`)
SELECT 11557, offer.slot, offer.item, 0, 0, 0, 1, 0, 0, 0
FROM (SELECT 102 AS slot, 251469 AS item UNION ALL SELECT 101, 251470) offer
WHERE EXISTS (
    SELECT 1 FROM `creature_template` t JOIN `creature` c ON c.id=t.entry
    WHERE t.entry=11557 AND t.name='Meilosh' AND c.map=1
        AND (COALESCE(c.npcflag, t.npcflag) & 128)=128
)
AND EXISTS (SELECT 1 FROM `npc_vendor` v WHERE v.entry=11557 AND v.item=19204 AND v.type=1)
AND NOT EXISTS (
    SELECT 1 FROM `npc_vendor` v
    WHERE v.entry=11557 AND (v.slot=offer.slot OR (v.item=offer.item AND v.type=1))
);
