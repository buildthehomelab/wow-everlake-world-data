# Cook Torka local dry run

Two live EG Link trainer windows for Cook Torka (70790 and 70840) show the same ten Cooking lessons, skill requirements, and base costs as Duhng's 70862 window and the active Cooking trainer list. The pinned 70862 SpellEffect records map the list's two teaching spells to the apprentice and journeyman IDs in those windows.

Cook Torka already has menu 5854 and its trainer option. The world has neither the NPC's link from that option to the Cooking list nor the flags to open it. The migration inserts the link and sets the gossip and trainer flags while preserving the quest-giver flag. It applies only to the pinned template, menu, and trainer list shape.

On the locally rebuilt MySQL world, the link and flags applied, all ten lessons matched their observed prices and skill requirements, and all three existing quest turn-ins remained. The second apply changed nothing. All 11 statements passed the SQL rewrite. In-game interaction is pending.
