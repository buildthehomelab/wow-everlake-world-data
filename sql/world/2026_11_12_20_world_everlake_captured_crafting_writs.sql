-- EG Link 3067c691 build 70862; QuestieDB c0ce0c97ee turn-ins.
START TRANSACTION;
SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94004)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94004 OR ID IN (468047,468048))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94004)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94004)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257281)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264011 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94004,2,16941,3149824,33281,268435456,18446744073709551615,264011,
       'Craftsman''s Writ: Elixir of Ogre''s Strength',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468047,94004,1,0,2,264011,1,70862 WHERE @add_writ
UNION ALL SELECT 468048,94004,1,1,3,3391,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257281,94004 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94004,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94212)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94212 OR ID IN (468131,468132))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94212)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94212)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257296)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264012 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94212,2,16941,3149824,33281,268435456,18446744073709551615,264012,
       'Craftsman''s Writ: Elixir of Wisdom',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468131,94212,1,0,0,264012,1,70862 WHERE @add_writ
UNION ALL SELECT 468132,94212,1,1,1,3383,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257296,94212 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94212,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94213)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94213 OR ID IN (468133,468134))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94213)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94213)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257315)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264013 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94213,2,16941,3149824,33281,268435456,18446744073709551615,264013,
       'Craftsman''s Writ: Lesser Mana Potion',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468133,94213,1,0,0,264013,1,70862 WHERE @add_writ
UNION ALL SELECT 468134,94213,1,1,1,3385,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257315,94213 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94213,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94215)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94215 OR ID IN (468141,468142))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94215)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94215)
    AND EXISTS (SELECT 1 FROM creature WHERE id=261928)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264015 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94215,2,16941,3149824,33281,268435456,18446744073709551615,264015,
       'Craftsman''s Writ: Free Action Potion',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468141,94215,1,0,0,264015,1,70862 WHERE @add_writ
UNION ALL SELECT 468142,94215,1,1,1,5634,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 261928,94215 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94215,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94216)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94216 OR ID IN (468143,468144))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94216)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94216)
    AND EXISTS (SELECT 1 FROM creature WHERE id=4201)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264016 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94216,2,16941,3149824,33281,268435456,18446744073709551615,264016,
       'Craftsman''s Writ: Elixir of Lesser Agility',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468143,94216,1,0,0,264016,1,70862 WHERE @add_writ
UNION ALL SELECT 468144,94216,1,1,1,3390,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 4201,94216 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94216,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94218)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94218 OR ID IN (468147,468148))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94218)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94218)
    AND EXISTS (SELECT 1 FROM creature WHERE id=4720)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264018 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94218,2,16941,3149824,33281,268435456,18446744073709551615,264018,
       'Craftsman''s Writ: Elixir of Defense',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468147,94218,1,0,0,264018,1,70862 WHERE @add_writ
UNION ALL SELECT 468148,94218,1,1,1,8951,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 4720,94218 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94218,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94219)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94219 OR ID IN (468149,468150))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94219)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94219)
    AND EXISTS (SELECT 1 FROM creature WHERE id=8305)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264019 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94219,2,16941,3149824,33281,268435456,18446744073709551615,264019,
       'Craftsman''s Writ: Draught of Water Breathing',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468149,94219,1,0,0,264019,1,70862 WHERE @add_writ
UNION ALL SELECT 468150,94219,1,1,1,5996,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 8305,94219 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94219,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94221)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94221 OR ID IN (468153,468154))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94221)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94221)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257296)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264021 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94221,2,16941,3149824,33281,268435456,18446744073709551615,264021,
       'Craftsman''s Writ: Golden Rod',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468153,94221,1,0,0,264021,1,70862 WHERE @add_writ
UNION ALL SELECT 468154,94221,1,1,1,11128,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257296,94221 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94221,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94222)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94222 OR ID IN (468155,468156))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94222)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94222)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257316)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264022 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94222,2,16941,3149824,33281,268435456,18446744073709551615,264022,
       'Craftsman''s Writ: Iridescent Hammer',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468155,94222,1,0,0,264022,1,70862 WHERE @add_writ
UNION ALL SELECT 468156,94222,1,1,1,5541,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257316,94222 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94222,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94227)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94227 OR ID IN (468165,468166))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94227)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94227)
    AND EXISTS (SELECT 1 FROM creature WHERE id=6626)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264027 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94227,2,16941,3149824,33281,268435456,18446744073709551615,264027,
       'Craftsman''s Writ: Big Bronze Knife',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468165,94227,1,0,0,264027,1,70862 WHERE @add_writ
UNION ALL SELECT 468166,94227,1,1,1,3848,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 6626,94227 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94227,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94229)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94229 OR ID IN (468169,468170))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94229)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94229)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257282)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264029 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94229,2,16941,3149824,33281,268435456,18446744073709551615,264029,
       'Craftsman''s Writ: Ornate Spyglass',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468169,94229,1,0,0,264029,1,70862 WHERE @add_writ
UNION ALL SELECT 468170,94229,1,1,1,5507,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257282,94229 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94229,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94230)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94230 OR ID IN (468171,468172))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94230)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94230)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257304)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264030 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94230,2,16941,3149824,33281,268435456,18446744073709551615,264030,
       'Craftsman''s Writ: Explosive Sheep',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468171,94230,1,0,0,264030,1,70862 WHERE @add_writ
UNION ALL SELECT 468172,94230,1,1,1,4384,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257304,94230 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94230,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94231)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94231 OR ID IN (468173,468174))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94231)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94231)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257317)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264031 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94231,2,16941,3149824,33281,268435456,18446744073709551615,264031,
       'Craftsman''s Writ: Moonsight Rifle',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468173,94231,1,0,0,264031,1,70862 WHERE @add_writ
UNION ALL SELECT 468174,94231,1,1,1,4383,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257317,94231 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94231,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94233)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94233 OR ID IN (468177,468178))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94233)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94233)
    AND EXISTS (SELECT 1 FROM creature WHERE id=261932)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264033 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94233,2,16941,3149824,33281,268435456,18446744073709551615,264033,
       'Craftsman''s Writ: Practice Lock',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468177,94233,1,0,0,264033,1,70862 WHERE @add_writ
UNION ALL SELECT 468178,94233,1,1,1,6712,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 261932,94233 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94233,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94235)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94235 OR ID IN (468181,468182))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94235)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94235)
    AND EXISTS (SELECT 1 FROM creature WHERE id=7853)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264035 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94235,2,16941,3149824,33281,268435456,18446744073709551615,264035,
       'Craftsman''s Writ: Gnomish Universal Remote',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468181,94235,1,0,0,264035,1,70862 WHERE @add_writ
UNION ALL SELECT 468182,94235,1,1,1,7506,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 7853,94235 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94235,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94241)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94241 OR ID IN (468193,468194))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94241)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94241)
    AND EXISTS (SELECT 1 FROM creature WHERE id=3134)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264041 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94241,2,16941,3149824,33281,268435456,18446744073709551615,264041,
       'Craftsman''s Writ: Dark Leather Tunic',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468193,94241,1,0,0,264041,1,70862 WHERE @add_writ
UNION ALL SELECT 468194,94241,1,1,1,2317,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 3134,94241 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94241,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94243)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94243 OR ID IN (468197,468198))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94243)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94243)
    AND EXISTS (SELECT 1 FROM creature WHERE id=4201)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264043 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94243,2,16941,3149824,33281,268435456,18446744073709551615,264043,
       'Craftsman''s Writ: Heavy Quiver',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468197,94243,1,0,0,264043,1,70862 WHERE @add_writ
UNION ALL SELECT 468198,94243,1,1,1,7371,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 4201,94243 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94243,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94247)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94247 OR ID IN (468205,468206))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94247)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94247)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257282)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264047 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94247,2,16941,3149824,33281,268435456,18446744073709551615,264047,
       'Craftsman''s Writ: Lesser Wizard''s Robe',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468205,94247,1,0,0,264047,1,70862 WHERE @add_writ
UNION ALL SELECT 468206,94247,1,1,1,5766,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257282,94247 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94247,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94248)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94248 OR ID IN (468207,468208))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94248)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94248)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257304)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264048 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94248,2,16941,3149824,33281,268435456,18446744073709551615,264048,
       'Craftsman''s Writ: Blue Overalls',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468207,94248,1,0,0,264048,1,70862 WHERE @add_writ
UNION ALL SELECT 468208,94248,1,1,1,6263,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257304,94248 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94248,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94249)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94249 OR ID IN (468209,468210))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94249)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94249)
    AND EXISTS (SELECT 1 FROM creature WHERE id=257316)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264049 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94249,2,16941,3149824,33281,268435456,18446744073709551615,264049,
       'Craftsman''s Writ: Azure Silk Hood',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468209,94249,1,0,0,264049,1,70862 WHERE @add_writ
UNION ALL SELECT 468210,94249,1,1,1,7048,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 257316,94249 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94249,4817,0 WHERE @add_writ;

SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94255)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94255 OR ID IN (468221,468222))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94255)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94255)
    AND EXISTS (SELECT 1 FROM creature WHERE id=8305)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264055 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94255,2,16941,3149824,33281,268435456,18446744073709551615,264055,
       'Craftsman''s Writ: Spider Silk Slippers',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468221,94255,1,0,0,264055,1,70862 WHERE @add_writ
UNION ALL SELECT 468222,94255,1,1,1,4321,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 8305,94255 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94255,4817,0 WHERE @add_writ;
COMMIT;
