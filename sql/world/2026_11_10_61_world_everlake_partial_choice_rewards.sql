-- Efficient Games 70862 quest capture (CC BY 4.0), pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=276695, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=9 AND BINARY q.LogTitle=BINARY 'The Killing Fields' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=3578
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=1561
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=114 AND o.Amount=20);

UPDATE `quest_template` q SET q.`RewardChoiceItemID4`=270006, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=14 AND BINARY q.LogTitle=BINARY 'The People''s Militia' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=1566
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=1480
  AND q.`RewardChoiceItemQuantity2`=1
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=12296
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=3
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=121 AND o.Amount=5)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=122 AND o.Amount=15)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=449 AND o.Amount=5);

UPDATE `quest_template` q SET q.`RewardChoiceItemID4`=276686, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=46 AND BINARY q.LogTitle=BINARY 'Bounty on Murlocs' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=4840
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=1158
  AND q.`RewardChoiceItemQuantity2`=1
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=1008
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=780 AND o.Amount=8);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270053, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=98 AND BINARY q.LogTitle=BINARY 'The Legend of Stalvan' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=2044
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=2043
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3629 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270007, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=168 AND BINARY q.LogTitle=BINARY 'Collecting Memories' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=2037
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=2036
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=1894 AND o.Amount=4);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270084, q.`RewardChoiceItemQuantity3`=1, q.`RewardChoiceItemID4`=270085, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=208 AND BINARY q.LogTitle=BINARY 'Big Game Hunter' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=17686
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=17687
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3880 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270019, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=256 AND BINARY q.LogTitle=BINARY 'WANTED: Chok''sul' AND q.RewardSpell=0
  AND q.`RewardItem1`=1449
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=6189
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=6191
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=2561 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID4`=270039, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=296 AND BINARY q.LogTitle=BINARY 'Ormer''s Revenge' AND q.RewardSpell=0
  AND q.`RewardItem1`=3682
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=3493
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=3566
  AND q.`RewardChoiceItemQuantity2`=1
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=5246
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3638 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270050, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=304 AND BINARY q.LogTitle=BINARY 'A Grim Task' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=2916
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=2917
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3639 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270020, q.`RewardChoiceItemQuantity3`=1, q.`RewardChoiceItemID4`=276722, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=442 AND BINARY q.LogTitle=BINARY 'Assault on Fenris Isle' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=3461
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=3462
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3623 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=276723, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=451 AND BINARY q.LogTitle=BINARY 'A Recipe For Death' AND q.RewardSpell=0
  AND q.`RewardItem1`=2458
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=2459
  AND q.`RewardAmount2`=1
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=3451
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=3582
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3256 AND o.Amount=6)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3257 AND o.Amount=6)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3258 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID4`=276724, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=501 AND BINARY q.LogTitle=BINARY 'Elixir of Pain' AND q.RewardSpell=0
  AND q.`RewardItem1`=3735
  AND q.`RewardAmount1`=1
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=2230
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=3741
  AND q.`RewardChoiceItemQuantity2`=1
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=6482
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3496 AND o.Amount=10);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270072, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=504 AND BINARY q.LogTitle=BINARY 'Crushridge Warmongers' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=5249
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=3763
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=2287 AND o.Amount=15);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=276727, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=515 AND BINARY q.LogTitle=BINARY 'Elixir of Agony' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=3749
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=3747
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=4
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3388 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3508 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3509 AND o.Amount=5)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3510 AND o.Amount=5);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270046, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=547 AND BINARY q.LogTitle=BINARY 'Humbert''s Sword' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=3750
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=3751
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=3693 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270082, q.`RewardChoiceItemQuantity3`=1, q.`RewardChoiceItemID4`=270083, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=646 AND BINARY q.LogTitle=BINARY 'Trol''kalar' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=4508
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=4507
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=4468 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270102, q.`RewardChoiceItemQuantity3`=1, q.`RewardChoiceItemID4`=270103, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=648 AND BINARY q.LogTitle=BINARY 'Rescue OOX-17/TN!' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=9643
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=9644
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=0;

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270073, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=673 AND BINARY q.LogTitle=BINARY 'Foul Magics' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=4543
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=4545
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=4510 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270069, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=679 AND BINARY q.LogTitle=BINARY 'Call to Arms' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=9520
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=9521
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=2570 AND o.Amount=15)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=2571 AND o.Amount=10);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270079, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=680 AND BINARY q.LogTitle=BINARY 'The Real Threat' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=4976
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=4977
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=4551 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270066, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=697 AND BINARY q.LogTitle=BINARY 'Malin''s Request' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=4975
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=15104
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=4533 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270011, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=898 AND BINARY q.LogTitle=BINARY 'Free From the Hold' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=5311
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=5312
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=0;

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270022, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=943 AND BINARY q.LogTitle=BINARY 'The Absent Minded Prospector' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=5627
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=5626
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=5233 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=5234 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270004, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=982 AND BINARY q.LogTitle=BINARY 'Deep Ocean, Vast Sea' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=15401
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=15402
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=12191 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=12192 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270035, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=1059 AND BINARY q.LogTitle=BINARY 'Reclaiming the Charred Vale' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=6675
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=6676
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=0;

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270094, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=1172 AND BINARY q.LogTitle=BINARY 'The Brood of Onyxia' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=10700
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=10701
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=2 AND o.ObjectID=20359 AND o.Amount=5);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270104, q.`RewardChoiceItemQuantity3`=1, q.`RewardChoiceItemID4`=270105, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=3062 AND BINARY q.LogTitle=BINARY 'Dark Heart' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=9665
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=9666
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=9528 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID4`=270114, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=3463 AND BINARY q.LogTitle=BINARY 'Set Them Ablaze!' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=10742
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=10743
  AND q.`RewardChoiceItemQuantity2`=1
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=10744
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=4
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=2 AND o.ObjectID=149025 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=2 AND o.ObjectID=149030 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=2 AND o.ObjectID=149031 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=2 AND o.ObjectID=149032 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270038, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=3514 AND BINARY q.LogTitle=BINARY 'Horde Presence' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=10653
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=10654
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=8518 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID4`=270118, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=4242 AND BINARY q.LogTitle=BINARY 'Abandoned Hope' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=12018
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=12021
  AND q.`RewardChoiceItemQuantity2`=1
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=12041
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=0;

UPDATE `quest_template` q SET q.`RewardChoiceItemID4`=270037, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=5088 AND BINARY q.LogTitle=BINARY 'Arikara' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=15464
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=15465
  AND q.`RewardChoiceItemQuantity2`=1
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=15466
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=2
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=12785 AND o.Amount=1)
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=12925 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID4`=270065, q.`RewardChoiceItemQuantity4`=1
WHERE q.ID=5943 AND BINARY q.LogTitle=BINARY 'Gizelton Caravan' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=15691
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=15692
  AND q.`RewardChoiceItemQuantity2`=1
  AND q.`RewardChoiceItemDisplayID2`=0
  AND q.`RewardChoiceItemID3`=15695
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=0;

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270028, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=6283 AND BINARY q.LogTitle=BINARY 'Bloodfury Bloodline' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=16990
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=16987
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=16190 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270113, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=7701 AND BINARY q.LogTitle=BINARY 'WANTED: Overseer Maltorius' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=19128
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=19127
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
  AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1 AND o.ObjectID=18946 AND o.Amount=1);

UPDATE `quest_template` q SET q.`RewardChoiceItemID3`=270111, q.`RewardChoiceItemQuantity3`=1
WHERE q.ID=7847 AND BINARY q.LogTitle=BINARY 'Return to Primal Torntusk' AND q.RewardSpell=0
  AND q.`RewardItem1`=0
  AND q.`RewardAmount1`=0
  AND q.`RewardItem2`=0
  AND q.`RewardAmount2`=0
  AND q.`RewardItem3`=0
  AND q.`RewardAmount3`=0
  AND q.`RewardItem4`=0
  AND q.`RewardAmount4`=0
  AND q.`RewardChoiceItemID1`=19114
  AND q.`RewardChoiceItemQuantity1`=1
  AND q.`RewardChoiceItemDisplayID1`=0
  AND q.`RewardChoiceItemID2`=19115
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
  AND (SELECT COUNT(*) FROM `quest_objectives` o WHERE o.QuestID=q.ID)=0;
