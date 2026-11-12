-- Requires the ItemSparse hotfix records already shipped by core 343fe6fb.

-- Efficient Games 70862 quest capture (CC BY 4.0), pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=287059, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=11 AND BINARY q.LogTitle=BINARY 'Riverpaw Gnoll Bounty' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=2249
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=2238
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=782 AND o.Amount=8);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=287067, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=474 AND BINARY q.LogTitle=BINARY 'Defeat Nek''rosh' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=3209
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=6194
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3625 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=287071, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=600 AND BINARY q.LogTitle=BINARY 'Venture Company Mining' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=5253
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=4128
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3917 AND o.Amount=10);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270115, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=1446 AND BINARY q.LogTitle=BINARY 'Jammal''an the Prophet' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=11123
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=11124
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=6212 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270099, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=2768 AND BINARY q.LogTitle=BINARY 'Divino-matic Rod' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=9533
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=9534
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=8548 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=287073, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=2987 AND BINARY q.LogTitle=BINARY 'Gordunni Cobalt' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=9658
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=9660
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=2
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=9463 AND o.Amount=12)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=9466 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID4`=270117, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=3528 AND BINARY q.LogTitle=BINARY 'The God Hakkar' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=10749
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=10750
  AND q.`RewardChoiceItemQuantity2`=1
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=10751
  AND q.`RewardChoiceItemQuantity3`=1
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=10662 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270123, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=4126 AND BINARY q.LogTitle=BINARY 'Hurley Blackbreath' AND q.RewardSpell=0
  AND q.`RewardItem1`=12003
  AND q.`RewardAmount1`=10
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=11964
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=12000
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=11312 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270123, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=4134 AND BINARY q.LogTitle=BINARY 'Lost Thunderbrew Recipe' AND q.RewardSpell=0
  AND q.`RewardItem1`=3928
  AND q.`RewardAmount1`=5
  AND q.`RewardItem2`=6149
  AND q.`RewardAmount2`=5
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=11964
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=12000
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=11312 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270120, q.`RewardChoiceItemQuantity3`=1, q.`RewardChoiceItemID4`=270121, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=4201 AND BINARY q.LogTitle=BINARY 'The Love Potion' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=11962
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=11866
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=3
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=8846 AND o.Amount=4)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=11405 AND o.Amount=10)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=11413 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270127, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=7441 AND BINARY q.LogTitle=BINARY 'Pusillin and the Elder Azj''Tordin' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=18411
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=18410
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=18261 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID2`=274959, q.`RewardChoiceItemQuantity2`=1
WHERE q.ID=95064 AND BINARY q.LogTitle=BINARY 'Preventative Measures' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=274961
  AND q.`RewardChoiceItemQuantity1`=1
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=256749 AND o.Amount=12);
