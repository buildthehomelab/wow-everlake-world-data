-- Both faction variants come from the Crest of Lordaeron chest.
-- https://db.icy-veins.com/api/catalog/wowf/item/268579
START TRANSACTION;

SET @crest := 614679;
SET @crest_ready := EXISTS (
    SELECT 1 FROM gameobject_template WHERE entry = @crest AND type = 3 AND data1 = @crest
) AND EXISTS (
    SELECT 1 FROM gameobject WHERE id = @crest AND map = 2999
) AND EXISTS (
    SELECT 1 FROM gameobject_loot_template WHERE Entry = @crest AND ItemType = 0 AND Item = 275521
);

INSERT INTO gameobject_loot_template
    (Entry, ItemType, Item, Chance, QuestRequired, LootMode, GroupId, MinCount, MaxCount, Comment)
SELECT @crest, 0, 268579, 100, 0, 1, 0, 1, 1, 'Crest of Lordaeron - Alliance quest starter'
WHERE @crest_ready
  AND NOT EXISTS (
      SELECT 1 FROM gameobject_loot_template WHERE Entry = @crest AND ItemType = 0 AND Item = 268579
  );

INSERT INTO conditions
    (SourceTypeOrReferenceId, SourceGroup, SourceEntry, ElseGroup,
     ConditionTypeOrReference, ConditionTarget, ConditionValue1, Comment)
SELECT 4, @crest, faction.item, 0, 6, 0, faction.team, 'Crest of Lordaeron - looter faction'
FROM (
    SELECT 268579 AS item, 469 AS team
    UNION ALL SELECT 275521, 67
) faction
WHERE @crest_ready
  AND NOT EXISTS (
      SELECT 1 FROM conditions
      WHERE SourceTypeOrReferenceId = 4 AND SourceGroup = @crest AND SourceEntry = faction.item
        AND ElseGroup = 0 AND ConditionTypeOrReference = 6 AND ConditionTarget = 0
        AND ConditionValue1 = faction.team AND NegativeCondition = 0
  );

COMMIT;
