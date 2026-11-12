-- Efficient Games build 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98298
SET q.RewardNextQuest=98298
WHERE q.ID=99 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Arugal''s Folly'
AND BINARY next_q.LogTitle=BINARY 'Arugal''s Folly' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (1938) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98189
SET q.RewardNextQuest=98189
WHERE q.ID=286 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Return the Statuette'
AND BINARY next_q.LogTitle=BINARY 'Return the Statuette' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (1242) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98216
SET q.RewardNextQuest=98216
WHERE q.ID=299 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Uncovering the Past'
AND BINARY next_q.LogTitle=BINARY 'Understanding Our Present' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (1077) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=99156
SET q.RewardNextQuest=99156
WHERE q.ID=356 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Rear Guard Patrol'
AND BINARY next_q.LogTitle=BINARY 'Rear Guard Patrol' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (1495) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=91920
SET q.RewardNextQuest=91920
WHERE q.ID=430 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Return to Quinn'
AND BINARY next_q.LogTitle=BINARY 'Wild Eyes' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (1951) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=484
SET q.RewardNextQuest=484
WHERE q.ID=469 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Daily Delivery'
AND BINARY next_q.LogTitle=BINARY 'Young Crocolisk Skins' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (2094) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98435
SET q.RewardNextQuest=98435
WHERE q.ID=760 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Wildmane Cleansing'
AND BINARY next_q.LogTitle=BINARY 'Thunderhorn''s Report' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (2948) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98403
SET q.RewardNextQuest=98403
WHERE q.ID=932 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Twisted Hatred'
AND BINARY next_q.LogTitle=BINARY 'Twisted Hatred' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (3567) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=935
SET q.RewardNextQuest=935
WHERE q.ID=934 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Crown of the Earth'
AND BINARY next_q.LogTitle=BINARY 'Crown of the Earth' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (3515) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98392
SET q.RewardNextQuest=98392
WHERE q.ID=937 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'The Enchanted Glade'
AND BINARY next_q.LogTitle=BINARY 'Darkness in the Glade' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (3519) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1473
SET q.RewardNextQuest=1473
WHERE q.ID=1478 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Halgar''s Summons'
AND BINARY next_q.LogTitle=BINARY 'Creature of the Void' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (5675) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1498
SET q.RewardNextQuest=1498
WHERE q.ID=1505 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Veteran Uzzek'
AND BINARY next_q.LogTitle=BINARY 'Path of Defense' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (5810) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1501
SET q.RewardNextQuest=1501
WHERE q.ID=1506 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Gan''rul''s Summons'
AND BINARY next_q.LogTitle=BINARY 'Creature of the Void' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (5875) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1639
SET q.RewardNextQuest=1639
WHERE q.ID=1638 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'A Warrior''s Training'
AND BINARY next_q.LogTitle=BINARY 'Bartleby the Drunk' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (6089) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1678
SET q.RewardNextQuest=1678
WHERE q.ID=1679 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Muren Stormpike'
AND BINARY next_q.LogTitle=BINARY 'Vejrek' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (6114) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1683
SET q.RewardNextQuest=1683
WHERE q.ID=1684 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Elanaria'
AND BINARY next_q.LogTitle=BINARY 'Vorlus Vilehoof' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (4088) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1819
SET q.RewardNextQuest=1819
WHERE q.ID=1818 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Speak with Dillinger'
AND BINARY next_q.LogTitle=BINARY 'Ulag the Cleaver' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (1496) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1963
SET q.RewardNextQuest=1963
WHERE q.ID=1859 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Therzok'
AND BINARY next_q.LogTitle=BINARY 'The Shattered Hand' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (6446) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1861
SET q.RewardNextQuest=1861
WHERE q.ID=1860 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Speak with Jennea'
AND BINARY next_q.LogTitle=BINARY 'Mirror Lake' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (5497) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1880
SET q.RewardNextQuest=1880
WHERE q.ID=1879 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Speak with Bink'
AND BINARY next_q.LogTitle=BINARY 'Mage-tastic Gizmonitor' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (5144) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1882
SET q.RewardNextQuest=1882
WHERE q.ID=1881 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Speak with Anastasia'
AND BINARY next_q.LogTitle=BINARY 'The Balnir Farmstead' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (4568) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1884
SET q.RewardNextQuest=1884
WHERE q.ID=1883 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Speak with Un''thuwa'
AND BINARY next_q.LogTitle=BINARY 'Ju-Ju Heaps' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (5880) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=1886
SET q.RewardNextQuest=1886
WHERE q.ID=1885 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Mennet Carkad'
AND BINARY next_q.LogTitle=BINARY 'The Deathstalkers' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (6467) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=2238
SET q.RewardNextQuest=2238
WHERE q.ID=2218 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Road to Salvation'
AND BINARY next_q.LogTitle=BINARY 'Simple Subterfugin''' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (5165) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=2759
SET q.RewardNextQuest=2759
WHERE q.ID=2758 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'The Origins of Smithing'
AND BINARY next_q.LogTitle=BINARY 'In Search of Galvan' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (7798) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=95774
SET q.RewardNextQuest=95774
WHERE q.ID=4921 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Lost in Battle'
AND BINARY next_q.LogTitle=BINARY 'Her Name Is Olgra' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (3432) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=65597
SET q.RewardNextQuest=65597
WHERE q.ID=65593 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Hearts of the Lovers'
AND BINARY next_q.LogTitle=BINARY 'The Binding' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (5675) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=65610
SET q.RewardNextQuest=65610
WHERE q.ID=65601 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Love Hurts'
AND BINARY next_q.LogTitle=BINARY 'Wish You Were Here' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (3363) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=65603
SET q.RewardNextQuest=65603
WHERE q.ID=65602 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'What Is Love?'
AND BINARY next_q.LogTitle=BINARY 'The Binding' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (6122) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=65604
SET q.RewardNextQuest=65604
WHERE q.ID=65610 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Wish You Were Here'
AND BINARY next_q.LogTitle=BINARY 'The Binding' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (5875) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=79364
SET q.RewardNextQuest=79364
WHERE q.ID=79360 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Elemental Aid'
AND BINARY next_q.LogTitle=BINARY 'Eyes on the Sky' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (6176) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=79361
SET q.RewardNextQuest=79361
WHERE q.ID=79364 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Eyes on the Sky'
AND BINARY next_q.LogTitle=BINARY 'Storm, Earth, and Fire' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (5905,6176) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=91859
SET q.RewardNextQuest=91859
WHERE q.ID=91858 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Diplomatic Incident'
AND BINARY next_q.LogTitle=BINARY 'A Curious Pair' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (248840) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=91860
SET q.RewardNextQuest=91860
WHERE q.ID=91859 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'A Curious Pair'
AND BINARY next_q.LogTitle=BINARY 'A Grim Fate' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (259611) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=91862
SET q.RewardNextQuest=91862
WHERE q.ID=91861 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Into Fenris Keep'
AND BINARY next_q.LogTitle=BINARY 'Lumina Windsinger' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (248755) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=96204
SET q.RewardNextQuest=96204
WHERE q.ID=91862 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Lumina Windsinger'
AND BINARY next_q.LogTitle=BINARY 'The Windshaper''s Wrath' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (248755) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=92458
SET q.RewardNextQuest=92458
WHERE q.ID=92432 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'An Alarming Request'
AND BINARY next_q.LogTitle=BINARY 'Heart of Disruption' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (269127) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=93035
SET q.RewardNextQuest=93035
WHERE q.ID=93034 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Valley of Bones'
AND BINARY next_q.LogTitle=BINARY 'Ravaging Ravagers' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (253177) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=93797
SET q.RewardNextQuest=93797
WHERE q.ID=93791 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Speak with Belann'
AND BINARY next_q.LogTitle=BINARY 'Boughs in the Wind' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (256507) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=94978
SET q.RewardNextQuest=94978
WHERE q.ID=94007 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Taming the Beast'
AND BINARY next_q.LogTitle=BINARY 'Taming the Beast' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (252389) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=96264
SET q.RewardNextQuest=96264
WHERE q.ID=94789 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Call of Air'
AND BINARY next_q.LogTitle=BINARY 'Elemental Aid' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (259023) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=5929
SET q.RewardNextQuest=5929
WHERE q.ID=94914 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Moonglade'
AND BINARY next_q.LogTitle=BINARY 'Great Bear Spirit' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (11802) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=95125
SET q.RewardNextQuest=95125
WHERE q.ID=95111 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'An Underrated Talent'
AND BINARY next_q.LogTitle=BINARY 'Ott''s Masterwork' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (3539) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=95126
SET q.RewardNextQuest=95126
WHERE q.ID=95125 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Ott''s Masterwork'
AND BINARY next_q.LogTitle=BINARY 'The Moonsilver Blade' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (3539) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=97287
SET q.RewardNextQuest=97287
WHERE q.ID=96984 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Heart of Disruption'
AND BINARY next_q.LogTitle=BINARY 'Shrewd Negotiations' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (2410) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98065
SET q.RewardNextQuest=98065
WHERE q.ID=98046 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Crown of the Earth'
AND BINARY next_q.LogTitle=BINARY 'Crown of the Earth' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (4092) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98240
SET q.RewardNextQuest=98240
WHERE q.ID=98072 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Crocs of the Sky'
AND BINARY next_q.LogTitle=BINARY 'Crimson Crate Delivery' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (2094) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98209
SET q.RewardNextQuest=98209
WHERE q.ID=98208 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Bloom of the Heavens'
AND BINARY next_q.LogTitle=BINARY 'Bloom of the Heavens' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (270844) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98310
SET q.RewardNextQuest=98310
WHERE q.ID=98216 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Understanding Our Present'
AND BINARY next_q.LogTitle=BINARY 'Gleaning Our Future' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (1077) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98245
SET q.RewardNextQuest=98245
WHERE q.ID=98240 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Crimson Crate Delivery'
AND BINARY next_q.LogTitle=BINARY 'Razormaw Needling' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (270637) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98313
SET q.RewardNextQuest=98313
WHERE q.ID=98310 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Gleaning Our Future'
AND BINARY next_q.LogTitle=BINARY 'For Further Study' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (1077) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=2519
SET q.RewardNextQuest=2519
WHERE q.ID=98391 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'The Sisterhood of Elune'
AND BINARY next_q.LogTitle=BINARY 'The Temple of the Moon' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (7316) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98398
SET q.RewardNextQuest=98398
WHERE q.ID=98392 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Darkness in the Glade'
AND BINARY next_q.LogTitle=BINARY 'The Oracle Tree' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (3519) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98394
SET q.RewardNextQuest=98394
WHERE q.ID=98393 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'The Great Cat Spirit'
AND BINARY next_q.LogTitle=BINARY 'The Great Cat Spirit' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (11802) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98396
SET q.RewardNextQuest=98396
WHERE q.ID=98394 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'The Great Cat Spirit'
AND BINARY next_q.LogTitle=BINARY 'The Great Cat Spirit' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (11957) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98731
SET q.RewardNextQuest=98731
WHERE q.ID=98396 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'The Great Cat Spirit'
AND BINARY next_q.LogTitle=BINARY 'Blessings of the Great Cat Spirit' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (11957) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);

UPDATE `quest_template` q JOIN `quest_template` next_q ON next_q.ID=98397
SET q.RewardNextQuest=98397
WHERE q.ID=98731 AND q.RewardNextQuest=0 AND BINARY q.LogTitle=BINARY 'Blessings of the Great Cat Spirit'
AND BINARY next_q.LogTitle=BINARY 'To Darnassus' AND (next_q.Flags & 524288)=0
AND EXISTS (SELECT 1 FROM `creature_questender` e JOIN `creature_queststarter` s ON s.id=e.id
 JOIN `creature` c ON c.id=e.id JOIN `creature_template` t ON t.entry=e.id
 WHERE e.quest=q.ID AND s.quest=next_q.ID AND e.id IN (11802) AND (COALESCE(c.npcflag,t.npcflag)&2)=2);
