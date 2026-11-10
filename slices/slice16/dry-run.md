# Wailing Caverns recipe sources

The pinned 70862 client tables contain the item, sparse item and On Learn effects for all eleven teaching items. The pinned core reads these effects through Spell::EffectLearnSpell.

Each boss and item pair appears in the pinned QuestieTrace item data and has a rate estimate on the corresponding Icy Veins NPC page. The estimates measure observed drops. A recursive check found none of the items in the corresponding boss reference chains before the import.

The local MySQL rebuild accepted all eleven rows and found the intended spawned boss for each path. Reapplication changed nothing, and all ten statements passed the SQL rewrite. In-game loot and item use remain to be tested.
