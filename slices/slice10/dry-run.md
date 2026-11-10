# Slice 10 local dry run

The pinned world has older per-NPC trainer lists with profession entry ranks, but the active trainer links for the sampled NPCs use shared lists that omit those rows. EG Link's November 8–9 live trainer windows (Forever build 70862) show the missing ranks and their copper prices and skill requirements.

The SQL inserts only the five missing lessons. It leaves active links and existing lessons in place, including newer Forever recipes. Local MySQL verification confirmed the five keys, base prices, skill gates and required levels. The four existing trainer lists have 29 NPC links across them. A second application changed nothing; all ten statements passed the SQL rewrite. No in-game training interaction was tested.
