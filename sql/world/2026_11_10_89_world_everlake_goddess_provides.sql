-- Efficient Games build 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- The 70862 criteria trees track two self-targeted Night Elf racial spells.
INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Description)
SELECT racial.ID,q.ID,14,racial.Slot,racial.Slot,racial.TreeID,1,racial.Description
FROM `quest_template` q
CROSS JOIN (
    SELECT 476662 AS ID,0 AS Slot,231191 AS TreeID,'Elune''s Light cast' AS Description
    UNION ALL
    SELECT 476663,1,231193,'Shadowmeld cast'
) racial
WHERE q.ID=97979 AND BINARY q.LogTitle=BINARY 'The Goddess Provides' AND q.AllowableRaces=8
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id WHERE s.quest=q.ID AND s.id=3595 AND c.map=1)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=3595)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID OR o.ID IN (476662,476663) OR (o.Type=14 AND o.ObjectID IN (231191,231193)));
