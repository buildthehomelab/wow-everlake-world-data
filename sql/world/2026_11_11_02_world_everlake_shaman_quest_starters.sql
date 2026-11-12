-- Questie Forever trace c0ce0c97ee records these alternate Shaman quest starters.

INSERT INTO `creature_queststarter` (id,quest)
SELECT 251366,q.ID FROM `quest_template` q
JOIN `quest_template_addon` a ON a.ID=q.ID
WHERE q.ID=92467 AND BINARY q.LogTitle=BINARY 'Call of Earth' AND a.AllowableClasses=64
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=251374)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=251166)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=251366 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=251366);

INSERT INTO `creature_queststarter` (id,quest)
SELECT 257446,q.ID FROM `quest_template` q
JOIN `quest_template_addon` a ON a.ID=q.ID
WHERE q.ID=94449 AND BINARY q.LogTitle=BINARY 'Call of Fire' AND a.AllowableClasses=64
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=258098)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=257597)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=257446 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=257446);

INSERT INTO `creature_queststarter` (id,quest)
SELECT 258098,q.ID FROM `quest_template` q
JOIN `quest_template_addon` a ON a.ID=q.ID
WHERE q.ID=96243 AND BINARY q.LogTitle=BINARY 'Call of Earth' AND a.AllowableClasses=64
AND EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=258113)
AND EXISTS (SELECT 1 FROM `creature_questender` e WHERE e.quest=q.ID AND e.id=257446)
AND EXISTS (SELECT 1 FROM `creature` c JOIN `creature_template` t ON t.entry=c.id
 WHERE c.id=258098 AND (COALESCE(c.npcflag,t.npcflag)&2)=2)
AND NOT EXISTS (SELECT 1 FROM `creature_queststarter` s WHERE s.quest=q.ID AND s.id=258098);
