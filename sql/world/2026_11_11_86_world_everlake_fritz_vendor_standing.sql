-- Fritz Fizzle vendor listing: https://www.wow-professions.com/forever/npc/fritz-fizzle
-- Client 70862: 163213 is ACA Friendly and 163214 is ACA Honored.
UPDATE npc_vendor SET PlayerConditionID = 163213
WHERE entry = 256733 AND type = 1 AND PlayerConditionID = 0 AND ExtendedCost = 11861
  AND item IN (264209,264211,280321,280322,280323,280325,280326,280327,280328,285286);

UPDATE npc_vendor SET PlayerConditionID = 163214
WHERE entry = 256733 AND type = 1 AND PlayerConditionID = 0
  AND (
    (ExtendedCost = 11862 AND item IN (264216,264217,264220,285287,285288))
    OR (ExtendedCost = 11863 AND item IN (264232,264235))
  );
