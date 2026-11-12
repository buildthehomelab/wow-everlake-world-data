-- Requires the ItemSparse hotfix records already shipped by core 343fe6fb.

-- Efficient Games 70862 quest capture (CC BY 4.0), pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

UPDATE `quest_template` q SET q.`RewardItem2`=0, q.`RewardAmount2`=0, q.`RewardChoiceItemID1`=9531, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270098, q.`RewardChoiceItemQuantity2`=1
WHERE q.ID=2846 AND BINARY q.LogTitle=BINARY 'Tiara of the Deep' AND q.RewardSpell=0
  AND q.`RewardItem1`=9527
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=9531
  AND q.`RewardAmount2`=1
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=0
  AND q.`RewardChoiceItemQuantity1`=0
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=0
  AND q.`RewardChoiceItemQuantity2`=0
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=0
  AND q.`RewardChoiceItemQuantity3`=0
  AND q.`RewardChoiceItemDisplayID3`=0
  AND q.`RewardChoiceItemID4`=0
  AND q.`RewardChoiceItemQuantity4`=0
  AND q.`RewardChoiceItemDisplayID4`=0
  AND q.`RewardChoiceItemID5`=0
  AND q.`RewardChoiceItemQuantity5`=0
  AND q.`RewardChoiceItemDisplayID5`=0
  AND q.`RewardChoiceItemID6`=0
  AND q.`RewardChoiceItemQuantity6`=0
  AND q.`RewardChoiceItemDisplayID6`=0
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=9234 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem2`=0, q.`RewardAmount2`=0, q.`RewardChoiceItemID1`=10824, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270081, q.`RewardChoiceItemQuantity2`=1
WHERE q.ID=3341 AND BINARY q.LogTitle=BINARY 'Bring the End' AND q.RewardSpell=0
  AND q.`RewardItem1`=10823
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=10824
  AND q.`RewardAmount2`=1
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=0
  AND q.`RewardChoiceItemQuantity1`=0
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=0
  AND q.`RewardChoiceItemQuantity2`=0
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=0
  AND q.`RewardChoiceItemQuantity3`=0
  AND q.`RewardChoiceItemDisplayID3`=0
  AND q.`RewardChoiceItemID4`=0
  AND q.`RewardChoiceItemQuantity4`=0
  AND q.`RewardChoiceItemDisplayID4`=0
  AND q.`RewardChoiceItemID5`=0
  AND q.`RewardChoiceItemQuantity5`=0
  AND q.`RewardChoiceItemDisplayID5`=0
  AND q.`RewardChoiceItemID6`=0
  AND q.`RewardChoiceItemQuantity6`=0
  AND q.`RewardChoiceItemDisplayID6`=0
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=1
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=10420 AND o.Amount=1);
