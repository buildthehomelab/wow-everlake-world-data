-- Questie Forever Horde corrections c0ce0c97ee list Oran Snakewrithe as starter and turn-in.
INSERT INTO `creature_queststarter` (id,quest)
SELECT e.id,e.quest FROM `creature_questender` e
JOIN `quest_template` q ON q.ID=e.quest
WHERE e.id=7825 AND (q.ID,q.LogTitle) IN (
 (84395,'Undead Potatoes'),(84396,'Magma or Lava?'),(84397,'Northern Kalimdor - A Comprehensive Guide'),
 (84398,'A Study of the Light'),(84399,'Ka-Boom!'),(84400,'The Knight and the Lady'),
 (84401,'Scourge: Undead Menace or Misunderstood?'),(84402,'Necromancy 101'))
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=e.id AND c.map=0 AND BINARY t.name=BINARY 'Oran Snakewrithe'
 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.id=5497 AND s.quest=q.ID)
AND EXISTS (SELECT 1 FROM `quest_objectives` o
 JOIN `gameobject_loot_template` l ON l.Item=o.ObjectID AND l.ItemType=0
 JOIN `gameobject_template` t ON t.Type=3 AND t.Data1=l.Entry
 JOIN `gameobject` g ON g.id=t.entry WHERE o.QuestID=q.ID AND o.Type=1)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.id=e.id AND s.quest=e.quest);
