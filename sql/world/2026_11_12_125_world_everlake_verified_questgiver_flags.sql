START TRANSACTION;
-- QuestieDB Forever field 3 corroborates each Craftsman's Writ turn-in below.
UPDATE creature_template AS t
SET t.npcflag = t.npcflag | 2
WHERE (t.npcflag & 2) = 0
  AND EXISTS (
    SELECT 1 FROM creature AS c
    WHERE c.id = t.entry AND c.npcflag IS NULL
  )
  AND EXISTS (
    SELECT 1 FROM creature_questender AS e
    JOIN quest_template AS q ON q.ID = e.quest
    WHERE e.id = t.entry AND q.LogTitle LIKE 'Craftsman''s Writ:%'
      AND (e.id, e.quest) IN (
        (2663,94244),
        (3134,94214), (3134,94232), (3134,94241), (3134,94250),
        (3536,94242), (4720,94218), (6626,94227),
        (8305,94219), (8305,94228), (8305,94237), (8305,94246), (8305,94255),
        (257322,94240)
      )
  );
-- QuestieDB Forever lists Na'zok as both endpoints of Paletusk Harvesting.
UPDATE creature_template AS t
SET t.npcflag = t.npcflag | 2
WHERE t.entry = 256728 AND t.name = 'Na''zok'
  AND (t.npcflag & 2) = 0
  AND EXISTS (SELECT 1 FROM creature AS c WHERE c.id = t.entry AND c.map = 0 AND c.npcflag IS NULL)
  AND EXISTS (SELECT 1 FROM quest_template WHERE ID = 95162 AND LogTitle = 'Paletusk Harvesting')
  AND EXISTS (SELECT 1 FROM creature_queststarter WHERE id = t.entry AND quest = 95162)
  AND EXISTS (SELECT 1 FROM creature_questender WHERE id = t.entry AND quest = 95162);
-- QuestieDB Forever quest 769, field 3, lists Veren and Boramu as turn-ins.
UPDATE creature_template AS t
SET t.npcflag = t.npcflag | 2
WHERE t.entry = 258466 AND t.name = 'Boramu' AND (t.npcflag & 2) = 0
  AND EXISTS (SELECT 1 FROM creature AS c WHERE c.id = t.entry AND c.map = 1 AND c.npcflag IS NULL)
  AND EXISTS (
    SELECT 1 FROM creature_questender AS e
    JOIN quest_template AS q ON q.ID = e.quest
    WHERE e.id = t.entry AND e.quest = 769 AND q.LogTitle = 'Kodo Hide Bag'
  );
COMMIT;
