-- Efficient Games 70862 quest capture (CC BY 4.0), pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=4127, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270070, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270071, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=202 AND BINARY q.LogTitle=BINARY 'Colonel Kurzen' AND q.RewardSpell=0
  AND q.`RewardItem1`=4127
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=3
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=939 AND o.Amount=6)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=978 AND o.Amount=4)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3615 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=4125, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270096, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270097, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=206 AND BINARY q.LogTitle=BINARY 'Mai''Zoth' AND q.RewardSpell=0
  AND q.`RewardItem1`=4125
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3616 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=5274, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270033, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270034, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=249 AND BINARY q.LogTitle=BINARY 'Morganth' AND q.RewardSpell=0
  AND q.`RewardItem1`=5274
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3617 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=6223, q.`RewardItem2`=0, q.`RewardAmount2`=0, q.`RewardChoiceItemID1`=3560, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270044, q.`RewardChoiceItemQuantity2`=1
WHERE q.ID=253 AND BINARY q.LogTitle=BINARY 'Bride of the Embalmer' AND q.RewardSpell=0
  AND q.`RewardItem1`=3560
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=6223
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=2382 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=4138, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270092, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270093, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=608 AND BINARY q.LogTitle=BINARY 'The Bloodsail Buccaneers' AND q.RewardSpell=0
  AND q.`RewardItem1`=4138
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=3
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=2546 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=2548 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=2550 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=4120, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270076, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270077, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=611 AND BINARY q.LogTitle=BINARY 'The Curse of the Tides' AND q.RewardSpell=0
  AND q.`RewardItem1`=4120
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=2
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=4027 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=4034 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=4129, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270090, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270091, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=613 AND BINARY q.LogTitle=BINARY 'Cracking Maury''s Foot' AND q.RewardSpell=0
  AND q.`RewardItem1`=4129
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3930 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=4118, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270226, q.`RewardChoiceItemQuantity2`=1
WHERE q.ID=630 AND BINARY q.LogTitle=BINARY 'Message in a Bottle' AND q.RewardSpell=0
  AND q.`RewardItem1`=4118
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=4103 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=4741, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270056, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270057, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=682 AND BINARY q.LogTitle=BINARY 'Stromgarde Badges' AND q.RewardSpell=0
  AND q.`RewardItem1`=4741
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=4506 AND o.Amount=15);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=4987, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270088, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270089, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=762 AND BINARY q.LogTitle=BINARY 'An Ambassador of Evil' AND q.RewardSpell=0
  AND q.`RewardItem1`=4987
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=4621 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=5813, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270048, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270049, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=1012 AND BINARY q.LogTitle=BINARY 'Insane Druids' AND q.RewardSpell=0
  AND q.`RewardItem1`=5813
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=3
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=3940 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=3941 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=3942 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=10702, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270086, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270087, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=1166 AND BINARY q.LogTitle=BINARY 'Overlord Mok''Morokk''s Concern' AND q.RewardSpell=0
  AND q.`RewardItem1`=10702
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=3
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=5834 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=5835 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=5836 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=5016, q.`RewardItem2`=0, q.`RewardAmount2`=0, q.`RewardChoiceItemID1`=9622, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270052, q.`RewardChoiceItemQuantity2`=1
WHERE q.ID=1203 AND BINARY q.LogTitle=BINARY 'Jarl Needs a Blade' AND q.RewardSpell=0
  AND q.`RewardItem1`=9622
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=5016
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3853 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID1`=247840, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=247841, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=247846, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=4402 AND BINARY q.LogTitle=BINARY 'Galgar''s Cactus Apple Surprise' AND q.RewardSpell=0
  AND q.`RewardItem1`=11584
  AND q.`RewardAmount1`=10
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=11583 AND o.Amount=10);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=19118, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270106, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270107, q.`RewardChoiceItemQuantity3`=1, q.`RewardChoiceItemID4`=270108, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=7850 AND BINARY q.LogTitle=BINARY 'Dark Vessels' AND q.RewardSpell=0
  AND q.`RewardItem1`=19118
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=19071 AND o.Amount=10);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=11469, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270100, q.`RewardChoiceItemQuantity2`=1
WHERE q.ID=8551 AND BINARY q.LogTitle=BINARY 'The Captain''s Chest' AND q.RewardSpell=0
  AND q.`RewardItem1`=11469
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3932 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardItem1`=0, q.`RewardAmount1`=0, q.`RewardChoiceItemID1`=4130, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=270109, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=270110, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=8554 AND BINARY q.LogTitle=BINARY 'Facing Negolash' AND q.RewardSpell=0
  AND q.`RewardItem1`=4130
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3935 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID1`=247846, q.`RewardChoiceItemQuantity1`=1, q.`RewardChoiceItemID2`=247841, q.`RewardChoiceItemQuantity2`=1, q.`RewardChoiceItemID3`=247840, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=91743 AND BINARY q.LogTitle=BINARY 'Rascally Rodents' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=247839 AND o.Amount=8);
