# Wailing Caverns recipe sources

The 70862 ItemEffect and ItemXItemEffect tables link each recipe item to its spell through the generic Learning spell and the explicit On Learn effect. All seven item and item sparse records exist in the pinned client tables.

Icy Veins lists each drop on the named boss's page. Everloot separately observed the same source and item pairs. Chance values are estimates from the Icy Veins NPC pages, since the underlying server chances are unknown and Everloot's windows here are sparse.

All five bosses are spawned in Wailing Caverns and use their own loot entries. A recursive check found none of the seven items in their corresponding reference chains before the import. MySQL applied all seven rows, and the acquisition check then found one spawned boss path per recipe. The second apply changed nothing. All ten statements passed the SQL rewrite. In-game loot and learning checks are pending.
