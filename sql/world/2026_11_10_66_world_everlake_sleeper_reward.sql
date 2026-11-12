-- Efficient Games 70862 quest capture, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
-- Existing escort completion is handled by classic_npc_kerlonian in core 343fe6fb.
UPDATE `quest_template` q
SET q.RewardChoiceItemID4=270014, q.RewardChoiceItemQuantity4=1
WHERE q.ID=5321 AND BINARY q.LogTitle=BINARY 'The Sleeper Has Awakened' AND q.Flags=2 AND q.StartItem=0
AND q.RewardChoiceItemID1=15205 AND q.RewardChoiceItemQuantity1=1
AND q.RewardChoiceItemID2=15206 AND q.RewardChoiceItemQuantity2=1
AND q.RewardChoiceItemID3=15207 AND q.RewardChoiceItemQuantity3=1
AND q.RewardChoiceItemID4=0 AND q.RewardChoiceItemQuantity4=0 AND q.RewardChoiceItemDisplayID4=0
AND q.RewardChoiceItemID5=0 AND q.RewardChoiceItemID6=0
AND NOT EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s JOIN `creature` c ON c.id=s.id
 JOIN `creature_template` t ON t.entry=s.id
 WHERE s.quest=q.ID AND s.id=11218 AND c.map=1 AND t.ScriptName='classic_npc_kerlonian')
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature` c ON c.id=e.id
 WHERE e.quest=q.ID AND e.id=11219 AND c.map=1)
AND EXISTS (SELECT 1 FROM `gameobject` g JOIN `gameobject_template` t ON t.entry=g.id
 JOIN `gameobject_loot_template` l ON l.Entry=t.Data1
 WHERE g.id=176634 AND g.map=1 AND t.type=3 AND l.ItemType=0 AND l.Item=13536 AND l.Chance=100);
