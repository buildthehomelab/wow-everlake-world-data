# Slice 8 local dry run

MySQL 8.0.46 was rebuilt from the October 14 Forever world release, the repository-default core pin `029c5dd9caee8521eb27dbee2bd1fe515b31331e`, and reviewed world-data pin `24a3b39ef0bb507088e7f72ab8313ad490602572`.

The rebuilt world had one Arcane Secrets chest (410299) with an empty, unshared loot entry (119849), two spawned librarians with quest-giver flags, and an existing Research Access condition that accepts completion of 79096 as one qualifying path. QuestieDB supplies the chest and librarian relationships, and its item trace corroborates the book. The published Library Books walkthrough describes obtaining it by clicking the chest. The chest grants the book before quest acceptance; the item already has a maximum count of one.

MySQL inserted the ten expected keys. Applying the same SQL twice left those rows and the pre-existing Research Access condition unchanged. The 63 statements also passed Everlake's SQL rewrite. No in-game interaction was tested.
