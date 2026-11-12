# Wailing Caverns recipe sources

The pinned 70862 client tables contain the item, sparse item and explicit On Learn effects for all fifteen teaching items. The core's Spell::EffectLearnSpell reads that item effect when a generic learning spell has no trigger spell.

Each source and item pair is present in the pinned QuestieTrace item data and has an estimated rate on the Icy Veins NPC page. These estimates are observed rates. A recursive check found no copies of these items in the corresponding boss reference chains before applying the import.

The MySQL rebuild accepted all fifteen rows. The post-apply check found the intended spawned boss for every item. A second application changed nothing, and ten statements passed the SQL rewrite. In-game loot and item use remain to be tested.
