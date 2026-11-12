DROP TEMPORARY TABLE IF EXISTS everlake_preview_stage;
CREATE TEMPORARY TABLE everlake_preview_stage LIKE quest_reward_display_spell;
START TRANSACTION;
-- Pinned Forever 70790 SpellEffect confirms wrappers 19337 and 2946 teach these spells.
INSERT INTO everlake_preview_stage (QuestID,Idx,SpellID,PlayerConditionID,Type,VerifiedBuild)
SELECT q.ID,0,CASE q.RewardSpell WHEN 19337 THEN 1277331 ELSE 1277324 END,0,3,70790
FROM quest_template q
WHERE ((q.ID IN (5641,5645,5647) AND q.RewardSpell=19337)
    OR (q.ID IN (5644,5646,5679) AND q.RewardSpell=2946))
  AND NOT EXISTS (SELECT 1 FROM quest_reward_display_spell d WHERE d.QuestID=q.ID);

-- Forever 70790 SpellEffect confirms the teaching wrappers and their learned spells.
-- Keep the existing index-zero display, then fill the two captured learning slots.
INSERT INTO everlake_preview_stage (QuestID,Idx,SpellID,PlayerConditionID,Type,VerifiedBuild)
SELECT q.ID,s.idx,
       CASE WHEN q.RewardSpell=1579 THEN s.taming_spell ELSE s.training_spell END,
       0,3,70790
FROM quest_template q
CROSS JOIN (SELECT 1 AS idx,883 AS taming_spell,6991 AS training_spell
            UNION ALL SELECT 2,2641,982) s
WHERE ((q.ID IN (6082,6088,6102) AND q.RewardSpell=1579)
    OR (q.ID IN (6081,6089,6103) AND q.RewardSpell=5300))
  AND EXISTS (SELECT 1 FROM quest_reward_display_spell d WHERE d.QuestID=q.ID AND d.Idx=0
              AND d.SpellID=CASE q.RewardSpell WHEN 1579 THEN 23356 ELSE 23357 END)
  AND NOT EXISTS (SELECT 1 FROM quest_reward_display_spell d WHERE d.QuestID=q.ID AND d.Idx=s.idx);

INSERT INTO quest_reward_display_spell SELECT * FROM everlake_preview_stage;
INSERT INTO everlake_import_rows (tbl,k1,k2,file,note)
SELECT 'quest_reward_display_spell',QuestID,Idx,
       '2026_11_12_208_world_everlake_class_reward_previews.sql',
       'Pinned Forever client SpellEffect 70790'
FROM everlake_preview_stage;
COMMIT;
DROP TEMPORARY TABLE everlake_preview_stage;
