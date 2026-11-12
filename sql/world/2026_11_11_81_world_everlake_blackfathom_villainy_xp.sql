-- EG Link 70862 and earlier captures agree on XP difficulty 7 and multiplier 2.375.
UPDATE quest_template
SET RewardXPMultiplier=2.375
WHERE ID IN (1200,6561) AND LogTitle='Blackfathom Villainy'
  AND RewardXPDifficulty=7 AND RewardXPMultiplier=1
  AND RewardChoiceItemID1=7001 AND RewardChoiceItemID2=7002
  AND RewardChoiceItemID3=270031 AND RewardChoiceItemID4=270032;
