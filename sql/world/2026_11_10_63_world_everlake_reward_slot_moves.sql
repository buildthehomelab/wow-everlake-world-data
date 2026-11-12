-- Requires the ItemSparse hotfix records already shipped by core 343fe6fb.

-- Efficient Games 70862 quest capture (CC BY 4.0), pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID3`=10919, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=962 AND BINARY q.LogTitle=BINARY 'Serpentbloom' AND q.RewardSpell=0
  AND q.`RewardItem1`=10919
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=270008
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=270009
  AND q.`RewardChoiceItemQuantity2`=1
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=5339 AND o.Amount=10);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID3`=270025, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=1199 AND BINARY q.LogTitle=BINARY 'Twilight Falls' AND q.RewardSpell=0
  AND q.`RewardItem1`=270025
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=6998
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=7000
  AND q.`RewardChoiceItemQuantity2`=1
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=5879 AND o.Amount=10);
