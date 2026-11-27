-- Alard Schmied (28694, Blacksmithing Trainer at old Dalaran) taught 99 spells that this game does not have.
-- 2026_11_26_910_world_everlake_alard_trainer_strays.sql: written from the test realm's world (2026-11-26, tracker
-- Query page) after the vendor cleanups (2026_11_26_92, _93, _95).
--
-- Checked: every trainer_spell row (704 trainers, 4638 spells) against the client's SpellName and hotfixes.spell_name.
-- 2473 spells are in neither; of the trainers a spawned creature uses (creature_trainer), only trainer 813 has any:
-- 99 of its 154 rows, Wrath and later blacksmithing recipes from the base world database. No remaining trainer spell
-- needs one of the missing spells as ReqAbility. Trainers no spawned creature uses (4321 such rows) are left alone.
--
-- Running it again changes nothing.

DELETE FROM `trainer_spell` WHERE `TrainerId` = 813 AND `SpellId` IN
  (52567, 52568, 52569, 52570, 52571, 52572, 54550, 54551, 54552, 54553, 54554, 54555, 54556, 54557, 54917,
   54918, 54941, 54944, 54945, 54946, 54947, 54948, 54949, 55013, 55014, 55015, 55017, 55055, 55056, 55057,
   55058, 55174, 55177, 55179, 55181, 55182, 55185, 55200, 55201, 55203, 55204, 55206, 55298, 55300, 55301,
   55302, 55303, 55304, 55305, 55306, 55307, 55308, 55309, 55310, 55311, 55312, 55369, 55370, 55371, 55372,
   55373, 55374, 55375, 55376, 55377, 55656, 55834, 55835, 55839, 56234, 56280, 56357, 56400, 56549, 56550,
   56551, 56552, 56553, 56554, 56555, 56556, 59405, 59406, 59436, 59438, 59440, 59441, 59442, 61008, 61009,
   61010, 63182, 264435, 264439, 330149, 330150, 330151, 330152, 330153);
