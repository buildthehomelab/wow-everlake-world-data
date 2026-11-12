-- Questie Forever Horde corrections c0ce0c97ee list Owen Thadd as starter and turn-in.
INSERT INTO `creature_queststarter` (id,quest)
SELECT e.id,e.quest FROM `creature_questender` e
JOIN `quest_template` q ON q.ID=e.quest
WHERE e.id=211022 AND (q.ID,q.LogTitle) IN (
 (78124,'Nar''thalas Almanac'),
 (78127,'The Dalaran Digest'),
 (78142,'Bewitchments and Glamours'),
 (78145,'Arcanic Systems Manual'),
 (78147,'Crimes Against Anatomy'),
 (78149,'Fury of the Land'),
 (79092,'Archmage Theocritus'' Research Journal'),
 (79093,'Rumi of Gnomeregan: The Collected Works'),
 (79097,'Baxtan: On Destructive Magics'),
 (79947,'Geomancy: The Stone-Cold Truth'),
 (79948,'Defensive Magics 101'),
 (79949,'A Web of Lies: Debunking Myths and Legends'),
 (79950,'Demons and You'),
 (79951,'Mummies: A Guide to the Unsavory Undead'),
 (79952,'RwlRwlRwlRwl!'),
 (81949,'Legends of the Tidesages'),
 (81954,'Venomous Journeys'),
 (81955,'A Mind of Metal'),
 (81956,'Conjurer''s Codex'))
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=e.id AND c.map=0 AND BINARY t.name=BINARY 'Owen Thadd'
 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.id=211033 AND s.quest=q.ID)
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=1)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.id=e.id AND s.quest=e.quest);
