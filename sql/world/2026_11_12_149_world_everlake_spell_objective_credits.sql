-- Build 70790 SpellEffect rows grant these credits without creature spawns.
-- 1302112 -> 268764, 1310681 -> 272513, 1303509 -> 269255.
START TRANSACTION;
CREATE TEMPORARY TABLE quest_spell_credits (
    entry INT PRIMARY KEY, quest INT, name VARCHAR(64), display_id INT, focus_id INT
);
INSERT INTO quest_spell_credits VALUES
    (268764,97257,'Invisible Bunny',15435,2308),
    (272513,97292,'[DNT] Kill Credit: Hissing Serum',52318,2334),
    (269255,97485,'[DNT] Kill Credit: Spread Incense',52318,2313);
DELETE c FROM quest_spell_credits c
WHERE NOT EXISTS (
    SELECT 1 FROM quest_objectives o WHERE o.QuestID=c.quest AND o.Type=0 AND o.ObjectID=c.entry
) OR NOT EXISTS (
    SELECT 1 FROM gameobject_template t JOIN gameobject g ON g.id=t.entry WHERE t.type=8 AND t.data0=c.focus_id
) OR NOT EXISTS (
    SELECT 1 FROM creature_model_info m WHERE m.DisplayID=c.display_id
) OR EXISTS (
    SELECT 1 FROM creature_template t WHERE t.entry=c.entry
) OR EXISTS (
    SELECT 1 FROM creature_template_model m WHERE m.CreatureID=c.entry
);
INSERT INTO creature_template (entry,name,faction,type,unit_class)
SELECT entry,name,35,10,1 FROM quest_spell_credits;
INSERT INTO creature_template_model (CreatureID,Idx,CreatureDisplayID,DisplayScale,Probability)
SELECT entry,0,display_id,1,1 FROM quest_spell_credits;
DROP TEMPORARY TABLE quest_spell_credits;
COMMIT;
