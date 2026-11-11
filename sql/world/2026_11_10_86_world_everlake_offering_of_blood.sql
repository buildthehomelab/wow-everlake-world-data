-- Efficient Games 70862 quest capture, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- The 70862 CriteriaTree and Criteria tables link both objectives to item 210713's on-use spell 426754.
INSERT INTO `quest_objectives` (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,Description)
SELECT ritual.ID,q.ID,14,ritual.Slot,ritual.Slot,ritual.TreeID,1,ritual.Description
FROM `quest_template` q
CROSS JOIN (
    SELECT 471636 AS ID,1 AS Slot,224929 AS TreeID,'Willingly offer blood' AS Description
    UNION ALL
    SELECT 471637,2,224931,'Release Tortured Soul'
) ritual
WHERE q.ID=95885 AND BINARY q.LogTitle=BINARY 'The Offering of Blood' AND q.StartItem=210713
AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.`Order`=0 AND o.StorageIndex=0 AND o.ObjectID=212753 AND o.Amount=1)
AND EXISTS (SELECT 1 FROM `creature_template` c WHERE c.entry=212753)
AND EXISTS (SELECT 1 FROM `gameobject_queststarter` s WHERE s.id=645153 AND s.quest=q.ID)
AND EXISTS (SELECT 1 FROM `gameobject_questender` e WHERE e.id=645153 AND e.quest=q.ID)
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.ID IN (471636,471637) OR (o.Type=14 AND o.ObjectID IN (224929,224931)));
