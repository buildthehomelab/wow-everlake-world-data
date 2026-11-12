-- Icy Veins Forever and QuestieDB list Sirra Von'Indi as a turn-in.
-- Pinned ItemSparse identifies Silvia's Sword (281145) as the quest starter.
START TRANSACTION;
SET @fix_silvia := EXISTS (SELECT 1 FROM quest_template WHERE ID=79363 AND LogTitle='Silvia''s Sword')
 AND EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=79363 AND Type=1 AND ObjectID=281145)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id
             WHERE c.id=268 AND t.name='Sirra Von''Indi' AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)
 AND EXISTS (SELECT 1 FROM creature_template WHERE entry=6176 AND name='Bath''rah the Windwatcher');
INSERT INTO creature_questender (id,quest)
SELECT 268,79363 WHERE @fix_silvia
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE id=268 AND quest=79363);
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_questender',268,79363,'2026_11_12_206_world_everlake_quest_turnin_corrections.sql','Icy Veins Forever and QuestieDB Forever' WHERE ROW_COUNT()=1;
DELETE FROM creature_questender WHERE id=6176 AND quest=79363 AND @fix_silvia;
DELETE FROM creature_queststarter WHERE id=6176 AND quest=79363 AND @fix_silvia;
-- QuestieDB Forever lists both turn-ins. Icy Veins records Modera and item objective 251961.
INSERT INTO creature_questender (id,quest)
SELECT 269127,97287
WHERE EXISTS (SELECT 1 FROM quest_template WHERE ID=97287 AND LogTitle='Shrewd Negotiations')
 AND EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=97287 AND Type=1 AND ObjectID=251961 AND Amount=1)
 AND EXISTS (SELECT 1 FROM creature c JOIN creature_template t ON t.entry=c.id
             WHERE c.id=269127 AND t.name='Image of Archmage Modera' AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE id=269127 AND quest=97287);
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note) SELECT 'creature_questender',269127,97287,'2026_11_12_206_world_everlake_quest_turnin_corrections.sql','Icy Veins Forever and QuestieDB Forever' WHERE ROW_COUNT()=1;
COMMIT;
