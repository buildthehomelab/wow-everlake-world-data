# Quest dialogue local dry run

The live 70790 captures have two variants for each of these lines. In both cases, replacing the generic race token with "skyborne" produces the other captured variant exactly. The import keeps the token so that the dialogue uses the current player's race.

On the pinned MySQL world, the two existing quests lacked the respective dialogue rows. Both rows applied, a second run changed nothing, and all 17 statements passed the SQL rewrite.
