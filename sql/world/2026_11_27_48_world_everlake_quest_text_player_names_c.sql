-- Three more quest progress texts with a player's name recorded in place of $N (older quests; see 2026_11_27_46 and _47).
--   8550 The Horde Needs More Peacebloom!: "Hello again, Abyssmal." (the other "Hello again" texts have $N there).
--   11171 Hex Lord? Hah!: "...the opportunity I've given you, Diedthreexs."
--   5621 Garments of the Moon: "Our spells of Fortify are very powerful, Delor."
-- Running it again changes nothing.
UPDATE `quest_request_items` SET `CompletionText` = REPLACE(`CompletionText`, 'Hello again, Abyssmal.', 'Hello again, $N.')
WHERE `ID` = 8550 AND `CompletionText` LIKE 'Hello again, Abyssmal.%';
UPDATE `quest_request_items` SET `CompletionText` = REPLACE(`CompletionText`, 'I''ve given you, Diedthreexs.', 'I''ve given you, $N.')
WHERE `ID` = 11171 AND `CompletionText` LIKE '%I''ve given you, Diedthreexs.%';
UPDATE `quest_request_items` SET `CompletionText` = REPLACE(`CompletionText`, 'Our spells of Fortify are very powerful, Delor.', 'Our spells of Fortify are very powerful, $N.')
WHERE `ID` = 5621 AND `CompletionText` LIKE 'Our spells of Fortify are very powerful, Delor.%';
