-- State Secrets (96377, Alliance, Renzik the Shiv 6946): hand-in quest with no giver's text (tracker quest gaps, 2026-11-26).
-- 2026_11_26_97_world_everlake_state_secrets_alliance_handin.sql: written by hand, not tried in game.
--
-- Live has no quest text for any of the three State Secrets quests: Icy Veins WoW Forever quests 96376, 96377 and 96379
-- have description and objective NULL, the Wowhead Forever and ForeverChanges pages show none, and players' addons
-- recorded only the progress and turn-in words (which the realm already has). Each is the hand-in of the Document Box
-- (274041, the reward of More Valuable Than Gold 96337) to one faction's spymaster, and Icy Veins records Renzik only as
-- the ender of 96377.
-- The realm built the Horde (96376) and neutral (96379) copies as hand-in quests (QuestType 0, 2026_11_14_950), but the
-- Alliance copy 96377 came in later (2026_11_20_25) as a normal quest (QuestType 2), which asks for giver's text that
-- live does not have. INFERRED from its two siblings: 96377 is a hand-in quest too. Only changed while it is still the
-- row 2026_11_20_25 wrote (QuestType 2, no description, no objectives text).
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing.

UPDATE `quest_template` SET `QuestType` = 0
WHERE `ID` = 96377 AND `QuestType` = 2
  AND COALESCE(`QuestDescription`, '') = '' AND COALESCE(`LogDescription`, '') = '';
