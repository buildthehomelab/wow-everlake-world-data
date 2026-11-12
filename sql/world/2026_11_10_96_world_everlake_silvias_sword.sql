-- Efficient Games 70862, CC BY 4.0, pin 9fcae73cc74fea4f1c4f2f09df9ca811b0f893ae.
UPDATE `quest_template` q
SET q.LogDescription=REPLACE(q.LogDescription,'7 Defias Enchanters','2 Defias Enchanters')
WHERE q.ID=79363 AND BINARY q.LogTitle=BINARY 'Silvia''s Sword'
AND BINARY q.LogDescription=BINARY 'Defeat 7 Defias Night Blades and 7 Defias Enchanters in Addle''s Stead then return to Sirra Von''Indi in Darkshire for more information.'
AND EXISTS (SELECT 1 FROM `quest_objectives` o WHERE o.QuestID=q.ID AND o.Type=0 AND o.ObjectID=910 AND o.Amount=2);
