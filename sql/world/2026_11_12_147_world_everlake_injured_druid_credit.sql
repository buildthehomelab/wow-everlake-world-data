-- Restore the unspawned objective credit used by classic_spell_heal_injured_druid.
-- https://db.icy-veins.com/api/catalog/wowf/npc/257964
START TRANSACTION;
SET @add_injured_druid_credit := EXISTS (
    SELECT 1 FROM quest_objectives WHERE QuestID=94489 AND Type=0 AND ObjectID=257964 AND Amount=7
) AND EXISTS (
    SELECT 1 FROM spell_script_names WHERE spell_id=1276047 AND ScriptName='classic_spell_heal_injured_druid'
) AND EXISTS (
    SELECT 1 FROM creature_model_info WHERE DisplayID=138043
) AND NOT EXISTS (
    SELECT 1 FROM creature_template WHERE entry=257964
) AND NOT EXISTS (
    SELECT 1 FROM creature_template_model WHERE CreatureID=257964
);
INSERT INTO creature_template (entry,name,faction,type,unit_class)
SELECT 257964,'Injured Druid',35,7,2 WHERE @add_injured_druid_credit;
INSERT INTO creature_template_model (CreatureID,Idx,CreatureDisplayID,DisplayScale,Probability)
SELECT 257964,0,138043,1,1 WHERE @add_injured_druid_credit;
COMMIT;
