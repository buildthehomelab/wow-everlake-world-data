-- 94235 Craftsman's Writ: Gnomish Universal Remote, progress text: "Careful where you walk, Gizmo!" reads as a player's name
-- recorded with the text. $N there, as in 2026_11_27_46.
-- Running it again changes nothing.
UPDATE `quest_request_items` SET `CompletionText` = REPLACE(`CompletionText`, 'Careful where you walk, Gizmo!', 'Careful where you walk, $N!')
WHERE `ID` = 94235 AND `CompletionText` LIKE 'Careful where you walk, Gizmo!%';
