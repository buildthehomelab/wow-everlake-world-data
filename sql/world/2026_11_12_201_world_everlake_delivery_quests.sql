-- Icy Veins Forever and QuestieDB Forever quest 95144.
-- The pinned client defines 276065 as a quest item with no StartQuestID.
-- ItemDrop removes the provided crate at turn-in without adding a visible objective.

START TRANSACTION;
SET @add_delivery := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95144)
 AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=95144)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=95144)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=95144)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=95144)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95144)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=95144)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=95144)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (7733,255897) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,ItemDrop1,ItemDropQuantity1,
  RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,
  LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95144,2,440,33554432,18446744073709551615,276065,276065,1,1,1,72,7500,
 'Overseas Delivery','Deliver Fizzgrimble''s Mysterious Crate to Friz Frazzlespark at Powderfuse Port in the Riverglades.','Hey, bub. Got a package that needs to go to an old friend of mine. Whatever you do--\r\n\r\nDO NOT OPEN THE PACKAGE!\r\n\r\nTake this--carefully--to Friz Frazzlespark across the seas over to our sister port in the Riverglades. And before you ask, no I would not suggest swimming. Didn''t work out so well for the last guy. Oh, and don''t tilt it, shake it, or make any sudden movements.\r\n\r\nI recommend heading east to Steamwheedle Port. The ship from there usually provides safe passage.\r\n\r\nBest of luck to ya!',70532 WHERE @add_delivery;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',95144,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_delivery;
INSERT INTO quest_template_addon (ID,ProvidedItemCount) SELECT 95144,1 WHERE @add_delivery;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_addon',95144,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_delivery;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95144,38,36,0 WHERE @add_delivery;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',95144,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_delivery;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95144,2,38 WHERE @add_delivery;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',95144,2,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_delivery;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild)
SELECT 95144,'A package from my old pal, Fizzgrimble? Just what I''ve been waitin'' for!$B$BYou didn''t shake this, tilt it or make any sudden movements while carrying it, did you?$B$BWould you mind turning around while I take a look inside? I wouldn''t want you spoiling the surprise.',70532 WHERE @add_delivery;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',95144,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_delivery;
INSERT INTO creature_queststarter (id,quest) SELECT 7733,95144 WHERE @add_delivery;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',7733,95144,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_delivery;
INSERT INTO creature_questender (id,quest) SELECT 255897,95144 WHERE @add_delivery;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',255897,95144,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_delivery;
COMMIT;

-- Icy Veins Forever and QuestieDB Forever quest 95066.
-- The pinned client defines the provided report with no StartQuestID.
-- ItemDrop removes the report at turn-in without adding a visible objective.

START TRANSACTION;
SET @add_rogmar := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95066)
 AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=95066)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=95066)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=95066)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=95066)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95066)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=95066)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=95066)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (259352,257558) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,ItemDrop1,ItemDropQuantity1,
  RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,RewardItem1,RewardAmount1,
  LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95066,2,16591,36700160,6130900294268439629,274981,274981,1,3,1,2826,10000,275052,1,
 'The Rog''mar Situation','Deliver the report to Demar Brant in Farholde Keep.','The message we''ve delivered is clear.\r\n\r\nReturn to Brant within the keep and show him the report. I''m certain he''ll be pleased with our progress.',70532 WHERE @add_rogmar;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',95066,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_rogmar;
INSERT INTO quest_template_addon (ID,ProvidedItemCount) SELECT 95066,1 WHERE @add_rogmar;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_addon',95066,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_rogmar;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95066,39,36,0 WHERE @add_rogmar;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',95066,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_rogmar;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95066,2,39 WHERE @add_rogmar;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',95066,2,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_rogmar;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild)
SELECT 95066,'It seems Cornelius has proven quite effective at his post, with your help, of course.$B$BUnfortunately, celebration distracts from our remaining work, exposing us to unnecessary vulnerabilities, but... perhaps a moment to reflect on our progress is in order.',70532 WHERE @add_rogmar;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',95066,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_rogmar;
INSERT INTO creature_queststarter (id,quest) SELECT 259352,95066 WHERE @add_rogmar;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',259352,95066,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_rogmar;
INSERT INTO creature_questender (id,quest) SELECT 257558,95066 WHERE @add_rogmar;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',257558,95066,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_rogmar;
COMMIT;

-- Icy Veins Forever and QuestieDB Forever quest 95315.
-- The pinned client defines the provided report with no StartQuestID.
-- ItemDrop removes the report at turn-in without adding a visible objective.

START TRANSACTION;
SET @add_report := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95315)
 AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=95315)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=95315)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=95315)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=95315)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95315)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=95315)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=95315)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (2700,257558) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,ItemDrop1,ItemDropQuantity1,
  RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,
  LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95315,2,45,36700160,6130900294268439629,275994,275994,1,1,1,2826,1000,
 'The Riverglades Report','Deliver Captain Nials'' Correspondence to Demar Brant at Farholde Keep along the southeastern coast in the Riverglades.','Word from one of our scouts suggests a large force of enemies amassing to the far, far south, well beyond the Wetlands.\r\n\r\nEven more curious is there appears to be an alliance settlement out there. Farholde? The name sounds familiar.\r\n\r\nLet''s not wait on this. Best to begin the conversation before it''s too late. We''re dealing with enough here as it is.\r\n\r\nTake this correspondence and deliver it to whoever claims to be the leader of this detachment.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',95315,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_addon (ID,ProvidedItemCount) SELECT 95315,1 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_addon',95315,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95315,38,36,0 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',95315,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95315,2,38 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',95315,2,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild)
SELECT 95315,'This came from all the way up north? I can''t believe someone finally made contact. We''ve been at it for so long and all but given up hope.$B$BI''ll be sure one of my messengers delivers a swift response.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',95315,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_queststarter (id,quest) SELECT 2700,95315 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',2700,95315,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_questender (id,quest) SELECT 257558,95315 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',257558,95315,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
COMMIT;

-- Icy Veins Forever and QuestieDB Forever quest 95786.
-- The pinned client defines the provided report with no StartQuestID.
-- ItemDrop removes the report at turn-in without adding a visible objective.

START TRANSACTION;
SET @add_report := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95786)
 AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=95786)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=95786)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=95786)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_money WHERE ID=95786)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=95786)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95786)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=95786)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=95786)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (739,2277) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,ItemDrop1,ItemDropQuantity1,
  RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionID2,RewardFactionOverride1,RewardFactionOverride2,
  LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95786,2,33,33554688,6130900294268439629,270340,270340,1,5,1,72,67,10000,10000,
 'An Acquaintance in Southshore','Find Loremaster Dibbs in Southshore and bring him the Savage Coast Report Bundle.','$n, I have a friend in the Hillsbrad Foothills that is studying troll legends and evil magic. I think he may have insight about how this foul magic captured Colenel Kurzen''s mind.\r\n\r\nI also have a scout''s report that the local trolls seem to be agitated, mentioning the word..."I''lalai".\r\n\r\nI must know if this is related to Kurzen''s corruption! Here, take the fetishes and legends along with this scouting report to Loremaster Dibbs. With any luck he will be able to unravel some of their secrets.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',95786,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_addon (ID,ProvidedItemCount) SELECT 95786,1 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_addon',95786,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95786,40,30,0 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',95786,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95786,2,40 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',95786,2,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild)
SELECT 95786,'Brother Nimetz sent you all the way from Stranglethorn? You have made quite the trek then. It must be a matter of some importance.$B$BCome, tell me what has brought you all the way to Southshore.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',95786,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_queststarter (id,quest) SELECT 739,95786 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',739,95786,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_questender (id,quest) SELECT 2277,95786 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',2277,95786,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_classic_money (ID,RewardMoney) SELECT 95786,5000 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_money',95786,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
COMMIT;

-- Icy Veins Forever and QuestieDB Forever quest 95798.
-- The pinned client defines the provided report with no StartQuestID.
-- ItemDrop removes the report at turn-in without adding a visible objective.

START TRANSACTION;
SET @add_report := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95798)
 AND NOT EXISTS (SELECT 1 FROM quest_template_addon WHERE ID=95798)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=95798)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=95798)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_money WHERE ID=95798)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=95798)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95798)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=95798)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=95798)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (2277,252019) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;

INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,StartItem,ItemDrop1,ItemDropQuantity1,
  RewardXPDifficulty,RewardXPMultiplier,RewardFactionID1,RewardFactionOverride1,RewardChoiceItemID1,RewardChoiceItemQuantity1,RewardChoiceItemID2,RewardChoiceItemQuantity2,
  LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95798,2,279,33554688,6130900294268439629,270339,270339,1,4,1,72,7500,279879,1,279878,1,
 'The Web of Magic','Bring the I''lalai Fetish to Abra Cadabra in Dalaran.','$n, I want you to take this I''lalai Fetish to my friend Abra in Dalaran. I would love to have her examine it if she has the time to do so.\r\n\r\nShe is also particularly interested in troll practices and magic, so I believe this discovery will be exciting for her to unravel.\r\n\r\nDo be careful, though. The Kirin Tor can be a bit particular about who they let into their grand city. If you haven''t already become a noteworthy visitor, you may need to find a way into their good graces.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',95798,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_addon (ID,ProvidedItemCount) SELECT 95798,1 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_addon',95798,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95798,40,30,0 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',95798,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95798,2,40 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',95798,2,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild)
SELECT 95798,'My word! The amount of different and conflicting magics pulling on this fetish is remarkable. It is certainly a good thing you have brought it to me.$B$BIn the wrong hands this could be very dangerous if not handled with extreme caution.$B$BThank you for bringing it all the way here, <Class>. I will send Loremaster Dibbs my findings promptly.',70532 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',95798,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_queststarter (id,quest) SELECT 2277,95798 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',2277,95798,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO creature_questender (id,quest) SELECT 252019,95798 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',252019,95798,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
INSERT INTO quest_classic_money (ID,RewardMoney) SELECT 95798,3500 WHERE @add_report;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_money',95798,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_report;
COMMIT;

-- Icy Veins Forever quest records and QuestieDB Forever NPC endpoints.
START TRANSACTION;

SET @add_ilalai := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=95799)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=95799)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=95799)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=95799)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_money WHERE ID=95799)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=95799)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=95799)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=95799)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (2277,2916) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,
  RewardItem1,RewardAmount1,RewardChoiceItemID1,RewardChoiceItemQuantity1,RewardChoiceItemID2,RewardChoiceItemQuantity2,RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 95799,2,1537,33554696,6130900294268439629,4,1,
 272124,1,279880,1,279881,1,72,7500,47,5000,'Findings for the Explorer''s League','Bring Loremaster Dibbs'' I''lalai Translations to Historian Karnik in Ironforge.','I must write my colleague in Ironforge at the Explorer''s League immediately. This is a discovery of historical proportions.\r\n\r\nWould you mind delivering the letter to Ironforge for me? I will write a copy of my translations of the tablets for you.',70532 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',95799,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 95799,40,30,0 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',95799,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 95799,2,40 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',95799,2,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO quest_classic_money (ID,RewardMoney) SELECT 95799,3500 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_money',95799,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild)
SELECT 95799,'Ah, Loremaster Dibbs never fails to bring me things of great interest. While my area of study isn''t focused on trolls, I certainly can appreciate his passion.$B$BThis is splendid news. I will get a team together to strike out for this lost city of I''lalai at once!',70532 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',95799,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO creature_queststarter (id,quest) SELECT 2277,95799 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',2277,95799,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO creature_questender (id,quest) SELECT 2916,95799 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',2916,95799,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;

SET @add_ilalai := NOT EXISTS (SELECT 1 FROM quest_template WHERE ID=96078)
 AND NOT EXISTS (SELECT 1 FROM quest_objectives WHERE QuestID=96078)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_level WHERE ID=96078)
 AND NOT EXISTS (SELECT 1 FROM quest_template_classic_level WHERE ID=96078)
 AND NOT EXISTS (SELECT 1 FROM quest_classic_money WHERE ID=96078)
 AND NOT EXISTS (SELECT 1 FROM quest_offer_reward WHERE ID=96078)
 AND NOT EXISTS (SELECT 1 FROM creature_queststarter WHERE quest=96078)
 AND NOT EXISTS (SELECT 1 FROM creature_questender WHERE quest=96078)
 AND (SELECT COUNT(DISTINCT c.id) FROM creature c JOIN creature_template t ON t.entry=c.id
      WHERE c.id IN (2519,3188) AND (COALESCE(c.npcflag,t.npcflag)&2)<>0)=2;
INSERT INTO quest_template
 (ID,QuestType,QuestSortID,Flags,AllowableRaces,RewardXPDifficulty,RewardXPMultiplier,
  RewardItem1,RewardAmount1,RewardItem2,RewardAmount2,RewardChoiceItemID1,RewardChoiceItemQuantity1,RewardChoiceItemID2,RewardChoiceItemQuantity2,RewardChoiceItemID3,RewardChoiceItemQuantity3,RewardFactionID1,RewardFactionOverride1,RewardFactionID2,RewardFactionOverride2,LogTitle,LogDescription,QuestDescription,VerifiedBuild)
SELECT 96078,2,33,33554696,12261800583900083122,4,1,
 270312,1,270313,1,279885,1,279886,1,279887,1,530,15000,76,5000,'A Tale Spun Around the Fire','Take the tablet etchings to Master Gadrin in Sen''jin Village in Durotar.','$n, we Darkspear keep much of our traditions alive by oral storytelling. We pass legends such as these to the next generation, teaching lessons and weaving cautionary tales to our younglings.\r\n\r\nThese etchings must be taken to our spiritual leader, Master Gadrin in Sen''jin Village. He is one of the wisest Darkspear and he will wish to hear the truth of this tale.\r\n\r\nI have prepared an extra copy of this tale for you as well. If you ever lose your copy, I would be happy to create another, for a small fee.',70532 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template',96078,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO quest_classic_level (ID,QuestLevel,MinLevel,MaxLevel) SELECT 96078,40,30,0 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_level',96078,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO quest_template_classic_level (ID,LevelType,QuestLevel) SELECT 96078,2,40 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_template_classic_level',96078,2,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO quest_classic_money (ID,RewardMoney) SELECT 96078,3500 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_classic_money',96078,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO quest_offer_reward (ID,RewardText,VerifiedBuild)
SELECT 96078,'<Master Gadrin listens closely as you explain your journey and how you came to possess the I''lalai tablet etchings.>$B$BIt was good of Kin''Weelay to send you here. I am grateful he has taken such a strong interest in preserving and discovering parts of our ancestral heritage we have lost over the centuries. We Darkspear didn''t break from the Gurubashi that long ago, in the grand scheme of things, you know.$B$BAnyway, Kin''weelay asked me to give this to you, as thanks for all your efforts this day.',70532 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_offer_reward',96078,0,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO creature_queststarter (id,quest) SELECT 2519,96078 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_queststarter',2519,96078,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
INSERT INTO creature_questender (id,quest) SELECT 3188,96078 WHERE @add_ilalai;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'creature_questender',3188,96078,'2026_11_12_201_world_everlake_delivery_quests.sql','Icy Veins Forever and QuestieDB Forever' WHERE @add_ilalai;
COMMIT;
