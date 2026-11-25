-- Silvia's Sword (79363): an Alliance quest the test realm offers only to Horde races.
-- 2026_11_25_13_world_everlake_silvias_sword_alliance.sql: written by hand from the tracker's kept facts (2026-11-25).
--
-- The quest starts from an item (281145) dropped in Duskwood and ends at Sirra Von'Indi (268) in Darkshire. Its race
-- mask on the test realm is 162 (Orc, Tauren, Troll), so the Alliance players who loot the sword cannot take the quest.
-- Icy Veins' WoW Forever database (https://db.icy-veins.com/wow-forever/, players' addons on live WoW Forever) records
-- the quest's race mask as 6130900294268439629, the Alliance mask the world's other Alliance quests carry.
--
-- Changes the row only while it still holds 162. Running it again changes nothing. Not checked in game.

START TRANSACTION;

UPDATE `quest_template` SET `AllowableRaces` = 6130900294268439629 WHERE `ID` = 79363 AND `AllowableRaces` = 162;

COMMIT;
