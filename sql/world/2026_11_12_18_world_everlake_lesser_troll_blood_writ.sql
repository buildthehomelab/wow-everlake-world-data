-- Quest capture from EG Link 3067c691, build 70888, quest 94217.
START TRANSACTION;
SET @add_writ := (
    NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=94217)
    AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=94217 OR ID IN (468145,468146))
    AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=94217)
    AND NOT EXISTS (SELECT 1 FROM quest_treasure_pickers WHERE QuestID=94217)
    AND EXISTS (SELECT 1 FROM creature WHERE id=14508)
    AND EXISTS (SELECT 1 FROM spell_loot_template WHERE Entry IN (1247526,1269671)
                AND ItemType=0 AND Item=264017 AND GroupId=1)
);
INSERT INTO quest_template
    (ID,QuestType,QuestSortID,Flags,FlagsEx,FlagsEx2,AllowableRaces,StartItem,LogTitle,LogDescription,
     RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,VerifiedBuild)
SELECT 94217,2,16941,3149824,33281,268435456,18446744073709551615,264017,
       'Craftsman''s Writ: Lesser Troll''s Blood Elixir',
       'Acquire the items requested by the customer and deliver them to the location marked on your map. This writ must be in your possession to complete the transaction.',
       2586,7500,2587,7500,70888
WHERE @add_writ;
INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount,VerifiedBuild)
SELECT 468145,94217,1,0,0,264017,1,70888 WHERE @add_writ
UNION ALL SELECT 468146,94217,1,1,1,3388,1,70888 WHERE @add_writ;
INSERT INTO creature_questender (id,quest) SELECT 14508,94217 WHERE @add_writ;
INSERT INTO quest_treasure_pickers (QuestID,TreasurePickerID,OrderIndex) SELECT 94217,4817,0 WHERE @add_writ;
COMMIT;
