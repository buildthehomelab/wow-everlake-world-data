-- The existing secluded-house area trigger grants this unspawned creature credit.
-- https://db.icy-veins.com/api/catalog/wowf/npc/255013
START TRANSACTION;
SET @turncoat_credit := EXISTS (
    SELECT 1 FROM quest_objectives WHERE QuestID=92643 AND Type=0 AND ObjectID=255013 AND Amount=1
) AND EXISTS (
    SELECT 1 FROM areatrigger WHERE MapId=2991 AND ScriptName='classic_at_secluded_house'
) AND EXISTS (
    SELECT 1 FROM creature_model_info WHERE DisplayID=52318
) AND NOT EXISTS (
    SELECT 1 FROM creature_template WHERE entry=255013
) AND NOT EXISTS (
    SELECT 1 FROM creature_template_model WHERE CreatureID=255013
);
INSERT INTO creature_template (entry,name,faction,type,unit_class)
SELECT 255013,'DNT KILL CREDIT',35,7,2 WHERE @turncoat_credit;
INSERT INTO creature_template_model (CreatureID,Idx,CreatureDisplayID,DisplayScale,Probability)
SELECT 255013,0,52318,1,1 WHERE @turncoat_credit;
COMMIT;
