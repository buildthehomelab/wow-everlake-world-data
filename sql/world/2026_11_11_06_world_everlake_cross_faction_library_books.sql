-- Efficient Games 70862 (CC BY 4.0) reports all races; Questie Forever c0ce0c97ee lists both faction librarians.

INSERT INTO `creature_queststarter` (id,quest)
SELECT 211022,q.ID FROM `quest_template` q
WHERE q.ID=79091 AND q.AllowableRaces=4294967373
AND EXISTS (SELECT 1 FROM `creature_queststarter` r WHERE r.quest=q.ID AND r.id=211033)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=211022 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` r WHERE r.quest=q.ID AND r.id=211022);

INSERT INTO `creature_questender` (id,quest)
SELECT 211022,q.ID FROM `quest_template` q
WHERE q.ID=79091 AND q.AllowableRaces=4294967373
AND EXISTS (SELECT 1 FROM `creature_questender` r WHERE r.quest=q.ID AND r.id=211033)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=211022 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_questender` r WHERE r.quest=q.ID AND r.id=211022);

UPDATE `quest_template` q
SET AllowableRaces=18446744073709551615,
    LogDescription=REPLACE(REPLACE(LogDescription,'Garion Wendell in Stormwind','your faction librarian'),'Owen Thadd in Undercity','your faction librarian')
WHERE q.ID=79091 AND q.AllowableRaces=4294967373
AND (SELECT COUNT(*) FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id IN (211022,211033))=2
AND (SELECT COUNT(*) FROM `creature_questender` e WHERE e.quest=q.ID AND e.id IN (211022,211033))=2;

INSERT INTO `creature_queststarter` (id,quest)
SELECT 211033,q.ID FROM `quest_template` q
WHERE q.ID=79095 AND q.AllowableRaces=8589934770
AND EXISTS (SELECT 1 FROM `creature_queststarter` r WHERE r.quest=q.ID AND r.id=211022)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=211033 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` r WHERE r.quest=q.ID AND r.id=211033);

INSERT INTO `creature_questender` (id,quest)
SELECT 211033,q.ID FROM `quest_template` q
WHERE q.ID=79095 AND q.AllowableRaces=8589934770
AND EXISTS (SELECT 1 FROM `creature_questender` r WHERE r.quest=q.ID AND r.id=211022)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=211033 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_questender` r WHERE r.quest=q.ID AND r.id=211033);

UPDATE `quest_template` q
SET AllowableRaces=18446744073709551615,
    LogDescription=REPLACE(REPLACE(LogDescription,'Garion Wendell in Stormwind','your faction librarian'),'Owen Thadd in Undercity','your faction librarian')
WHERE q.ID=79095 AND q.AllowableRaces=8589934770
AND (SELECT COUNT(*) FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id IN (211022,211033))=2
AND (SELECT COUNT(*) FROM `creature_questender` e WHERE e.quest=q.ID AND e.id IN (211022,211033))=2;

INSERT INTO `creature_queststarter` (id,quest)
SELECT 211033,q.ID FROM `quest_template` q
WHERE q.ID=79096 AND q.AllowableRaces=8589934770
AND EXISTS (SELECT 1 FROM `creature_queststarter` r WHERE r.quest=q.ID AND r.id=211022)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=211033 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` r WHERE r.quest=q.ID AND r.id=211033);

INSERT INTO `creature_questender` (id,quest)
SELECT 211033,q.ID FROM `quest_template` q
WHERE q.ID=79096 AND q.AllowableRaces=8589934770
AND EXISTS (SELECT 1 FROM `creature_questender` r WHERE r.quest=q.ID AND r.id=211022)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=211033 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_questender` r WHERE r.quest=q.ID AND r.id=211033);

UPDATE `quest_template` q
SET AllowableRaces=18446744073709551615,
    LogDescription=REPLACE(REPLACE(LogDescription,'Garion Wendell in Stormwind','your faction librarian'),'Owen Thadd in Undercity','your faction librarian')
WHERE q.ID=79096 AND q.AllowableRaces=8589934770
AND (SELECT COUNT(*) FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id IN (211022,211033))=2
AND (SELECT COUNT(*) FROM `creature_questender` e WHERE e.quest=q.ID AND e.id IN (211022,211033))=2;
