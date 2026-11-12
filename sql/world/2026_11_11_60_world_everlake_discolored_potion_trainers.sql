-- Quest unlocks: Wowhead Forever alchemy leveling guide.
-- Lesson prices and ranks: My Forever Recipe Book 0.18.1-beta, file 9488332.
-- Local IDs and generic greeting for the reconstructed menus.
START TRANSACTION;
INSERT IGNORE INTO trainer (Id, Type, Greeting)
VALUES (9001937, 2, 'I can teach you to make discolored healing potions.');

INSERT IGNORE INTO trainer_spell (TrainerId, SpellId, MoneyCost, ReqSkillLine, ReqSkillRank)
VALUES (9001937, 4508, 10, 171, 50),
       (9001937, 1244645, 100, 171, 85),
       (9001937, 1244646, 500, 171, 135),
       (9001937, 1244647, 1500, 171, 175),
       (9001937, 1244648, 5000, 171, 230),
       (9001937, 1231583, 10000, 171, 250);

INSERT IGNORE INTO gossip_menu (MenuID, TextID)
VALUES (9001937, 68), (9249713, 68);
INSERT IGNORE INTO gossip_menu_option (MenuID, GossipOptionID, OptionID, OptionNpc, OptionText, OptionBroadcastTextID)
VALUES (9001937, 9001937, 0, 3, 'Train me.', 3266),
       (9249713, 9249713, 0, 3, 'Train me.', 3266);

INSERT IGNORE INTO conditions
    (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ConditionTypeOrReference, ConditionTarget, ConditionValue1, Comment)
VALUES (15, 9001937, 0, 8, 0, 91920, 'Renferrel training requires Wild Eyes rewarded'),
       (15, 9249713, 0, 8, 0, 92110, 'Odd Child training requires My First Real Potion rewarded');

INSERT IGNORE INTO creature_trainer (CreatureID, TrainerID, MenuID, OptionID)
VALUES (1937, 9001937, 9001937, 0), (249713, 9001937, 9249713, 0);
INSERT IGNORE INTO creature_template_gossip (CreatureID, MenuID)
VALUES (1937, 9001937), (249713, 9249713);
UPDATE creature_template SET npcflag = npcflag | 17 WHERE entry IN (1937, 249713);
COMMIT;
