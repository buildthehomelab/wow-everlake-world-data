-- Questie Forever and Wowhead identify Molkar's Economic Warfare as Horde.
-- Reuse the race mask from the Horde Buying Friendship: Gelkis quest.
UPDATE quest_template q
JOIN quest_template reference ON reference.ID=94873 AND reference.AllowableRaces=8589934770
JOIN creature_queststarter s ON s.quest=q.ID AND s.id=253140
JOIN creature_questender e ON e.quest=q.ID AND e.id=253140
SET q.AllowableRaces=reference.AllowableRaces
WHERE q.ID=92812 AND q.LogTitle='Economic Warfare' AND q.AllowableRaces=0
  AND q.RewardFactionID1=92 AND q.RewardFactionOverride1=75000;
