-- EG Link build 70862 quest 92814. AHledger identifies Molkar as the observed starter.
INSERT INTO quest_template
    (ID, QuestType, QuestSortID, RewardXPDifficulty, RewardXPMultiplier, Flags,
     RewardChoiceItemID1, RewardChoiceItemQuantity1, RewardChoiceItemID2, RewardChoiceItemQuantity2,
     RewardFactionID1, RewardFactionOverride1, RewardFactionID2, RewardFactionOverride2,
     AllowableRaces, LogTitle, LogDescription, QuestDescription, VerifiedBuild)
SELECT 92814, 2, 405, 4, 1, 3145736, 254682, 1, 253974, 1, 92, 100000, 93, -500000,
       18446744073709551615, 'I Need a Tailor',
       'Maintain your reputation with the Gelkis, and bring a White Bandit Mask to Molkar in the Gelkis Village in Desolace.',
       'My mate, Halea, is tasked with ensuring our armaments are empowered with appropriate magical energy.

The whole concept of enchanting is far beyond my understanding, but as the centaur whose job is to keep our village well supplied and equipped, I know that Halea is often behind on her duties--to no fault of her own.

I would like to gift her some simple clothes to practice her craft on. I see some adventurers wandering through sandstorms with simple facemasks. Could you get me a few of those?', 70862
WHERE NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=92814) AND EXISTS (
    SELECT 1 FROM creature_template t JOIN creature c ON c.id=t.entry
    WHERE t.entry=253140 AND t.name='Molkar' AND c.map=1 AND (COALESCE(c.npcflag,t.npcflag) & 2)=2
);

INSERT INTO quest_classic_level (ID, QuestLevel, MinLevel, MaxLevel)
SELECT ID,35,30,0 FROM quest_template WHERE ID=92814 AND LogTitle='I Need a Tailor' AND VerifiedBuild=70862
AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=92814);

INSERT INTO quest_template_classic_level (ID, LevelType, QuestLevel)
SELECT ID,2,35 FROM quest_template WHERE ID=92814 AND LogTitle='I Need a Tailor' AND VerifiedBuild=70862
AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=92814);

INSERT INTO quest_classic_money (ID, RewardMoney)
SELECT ID,1800 FROM quest_template WHERE ID=92814 AND LogTitle='I Need a Tailor' AND VerifiedBuild=70862
AND NOT EXISTS (SELECT 1 FROM quest_classic_money WHERE ID=92814);

INSERT INTO quest_objectives (ID,QuestID,Type,`Order`,StorageIndex,ObjectID,Amount)
SELECT o.id,q.ID,o.kind,o.position,o.storage,o.object,o.amount
FROM quest_template q
CROSS JOIN (SELECT 465576 AS id,1 AS kind,0 AS position,0 AS storage,10008 AS object,1 AS amount
            UNION ALL SELECT 465577,6,1,-1,92,3000) o
WHERE q.ID=92814 AND q.LogTitle='I Need a Tailor' AND q.VerifiedBuild=70862
AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE ID=o.id);

INSERT INTO creature_queststarter (id,quest,VerifiedBuild)
SELECT 253140,ID,70862 FROM quest_template WHERE ID=92814 AND LogTitle='I Need a Tailor' AND VerifiedBuild=70862
AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE id=253140 AND quest=92814);

INSERT INTO creature_questender (id,quest,VerifiedBuild)
SELECT 253140,ID,70862 FROM quest_template WHERE ID=92814 AND LogTitle='I Need a Tailor' AND VerifiedBuild=70862
AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE id=253140 AND quest=92814);
