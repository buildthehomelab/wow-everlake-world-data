-- Quest capture from EG Link 3067c691, build 70862, quest 94256.
START TRANSACTION;
SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94256)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94256 OR ID IN (468223,468224))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94256)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94256)
    AND EXISTS (SELECT 1 FROM creature WHERE id=2921)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264056 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94256,2,16941,3149824,33281,268435456,18446744073709551615,264056,
       'Craftsman''s Writ: Frost Protection Potion',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,12500,2587,12500,70862
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468223,94256,1,0,0,264056,1,70862 WHERE @add_writ
UNION ALL SELECT 468224,94256,1,1,1,6050,1,70862 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 2921,94256 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94256,4818,0 WHERE @add_writ;
COMMIT;
