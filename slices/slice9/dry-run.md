# Slice 9 local dry run

MySQL 8.0.46 was rebuilt from the October 14 Forever world release, core pin `029c5dd9caee8521eb27dbee2bd1fe515b31331e`, and reviewed world-data pin `24a3b39ef0bb507088e7f72ab8313ad490602572`.

Scrolls (409692) already spawns in the cave outside Wailing Caverns and has an empty, unshared loot entry (119761). QuestieTrace links the book to Scrolls and records both librarians accepting it. Wowhead's library guide describes collecting the book and turning it in to either librarian. Its quest page lists the Comprehension Charm reward, matching the item used by neighboring library quests in the rebuilt world. The pinned Research Access condition already accepts this quest as one qualifying path.

The chest remains a lootable object. Both spawned librarians handle the turn-in. All nine expected keys landed on MySQL; the second application changed nothing, and all 56 statements passed Everlake's SQL rewrite. No in-game interaction was tested.
