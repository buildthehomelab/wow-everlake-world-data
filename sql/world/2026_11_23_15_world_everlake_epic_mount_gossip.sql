-- The Epic Ride mount NPCs at Steelgrill's Depot (276734-276736, quest 99212) and Eastvale (276785-276787, quest 99213)
-- have no gossip flag, so players cannot talk to them for the quests' "inspect" objectives. Their sibling mount NPCs
-- (276737, 276788, 276800, 276891 and the rest) all carry npcflag 1. Running it again changes nothing.
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1
WHERE `entry` IN (276734, 276735, 276736, 276785, 276786, 276787) AND (`npcflag` & 1) = 0;
