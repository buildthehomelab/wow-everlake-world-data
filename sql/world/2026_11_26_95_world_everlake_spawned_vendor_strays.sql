-- Vendors standing in the world listed 266 items that this game does not have.
-- 2026_11_26_95_world_everlake_spawned_vendor_strays.sql: written from the test realm's world (2026-11-26, tracker
-- Query page) after the Darkmoon Faire (2026_11_26_92) and holiday (2026_11_26_93) vendors were cleaned the same way.
--
-- Checked: every npc_vendor item (2271 vendors, 10108 items) against the client's ItemSparse, the live hotfixes and
-- hotfixes.item_sparse. The rows below list an item in none of them, on the 22 vendors that have a spawn; the client
-- cannot show such an item, so no player sees these rows. They come from the base world database.
--   16 Dalaran NPCs our sniff file stands at old Dalaran (map 0): their Wrath stock (Blazik Fireclaw 104 of 184,
--      Hexil Garrot 24 of 24, ...). Hexil, Caliel, Amisi, Ainderu, Nixi and Aili have nothing left to sell.
--   6 Kalimdor vendors: Aendel Windspear and Vargus (Cenarion Circle patterns and plans live no longer has as items;
--      the tracker finds what they make obtainable another way), Lenedil Moonwing, Aili Greenwillow, Evie Whirlbrew
--      (13480, an old copy of Recipe: Major Mana Potion; 13501 stays), Apothecary Durelle.
-- Left alone: 956 vendors with no spawn anywhere (16078 such rows) and items in hotfixes.item_sparse only.
--
-- Running it again changes nothing.

-- 11188 Evie Whirlbrew: 1
DELETE FROM `npc_vendor` WHERE `entry` = 11188 AND `type` = 1 AND `item` IN
  (13480);
-- 15176 Vargus: 5
DELETE FROM `npc_vendor` WHERE `entry` = 15176 AND `type` = 1 AND `item` IN
  (22209, 22214, 22766, 22767, 22768);
-- 15293 Aendel Windspear: 10
DELETE FROM `npc_vendor` WHERE `entry` = 15293 AND `type` = 1 AND `item` IN
  (20382, 20506, 20507, 20508, 20509, 20510, 20511, 22769, 22770, 22771);
-- 28686 Caliel Brightwillow: 9
DELETE FROM `npc_vendor` WHERE `entry` = 28686 AND `type` = 1 AND `item` IN
  (33443, 33444, 33445, 33449, 33454, 35950, 35952, 35953, 35954);
-- 28687 Amisi Azuregaze: 9
DELETE FROM `npc_vendor` WHERE `entry` = 28687 AND `type` = 1 AND `item` IN
  (33443, 33444, 33445, 33449, 33454, 35950, 35952, 35953, 35954);
-- 28776 Elizabeth Ross: 11
DELETE FROM `npc_vendor` WHERE `entry` = 28776 AND `type` = 1 AND `item` IN
  (31775, 31776, 31777, 31778, 31779, 31780, 31781, 31804, 32445, 32828, 35221);
-- 28989 Aemara: 2
DELETE FROM `npc_vendor` WHERE `entry` = 28989 AND `type` = 1 AND `item` IN
  (44637, 44643);
-- 28990 Anthony Durain: 2
DELETE FROM `npc_vendor` WHERE `entry` = 28990 AND `type` = 1 AND `item` IN
  (40700, 40701);
-- 29049 Arille Azuregaze: 6
DELETE FROM `npc_vendor` WHERE `entry` = 29049 AND `type` = 1 AND `item` IN
  (33444, 33445, 35954, 40035, 40036, 40042);
-- 29491 Karandonna: 15
DELETE FROM `npc_vendor` WHERE `entry` = 29491 AND `type` = 1 AND `item` IN
  (42360, 42361, 42363, 42365, 42368, 42369, 42370, 42371, 42372, 42373, 42374, 42375, 42376, 42377, 42378);
-- 29512 Ainderu Summerleaf: 5
DELETE FROM `npc_vendor` WHERE `entry` = 29512 AND `type` = 1 AND `item` IN
  (21895, 21916, 21917, 21918, 21919);
-- 29537 Darahir: 9
DELETE FROM `npc_vendor` WHERE `entry` = 29537 AND `type` = 1 AND `item` IN
  (22147, 22148, 22832, 33448, 37201, 39973, 44605, 44614, 44615);
-- 29538 Hexil Garrot: 24
DELETE FROM `npc_vendor` WHERE `entry` = 29538 AND `type` = 1 AND `item` IN
  (40694, 40695, 40702, 40704, 40716, 40738, 40739, 40748, 40749, 44641, 44644, 44652, 45829, 45830, 45838,
   45839, 45846, 45847, 50972, 50973, 50981, 50982, 50994, 50995);
-- 29547 Applebough: 6
DELETE FROM `npc_vendor` WHERE `entry` = 29547 AND `type` = 1 AND `item` IN
  (27856, 29450, 35948, 35949, 43086, 43088);
-- 30885 Blazik Fireclaw: 104
DELETE FROM `npc_vendor` WHERE `entry` = 30885 AND `type` = 1 AND `item` IN
  (25829, 34986, 35008, 35016, 35020, 35021, 35027, 35028, 35029, 35030, 35031, 35039, 35040, 35041, 35059,
   35060, 35061, 35062, 35063, 35073, 35074, 35088, 35089, 35090, 35091, 35092, 35094, 35105, 35106, 35129,
   35130, 35131, 35132, 35133, 35134, 35135, 35140, 35145, 35146, 35148, 35155, 35160, 35161, 35163, 35170,
   35175, 35176, 35178, 37927, 37928, 37929, 41591, 41592, 44429, 44431, 51330, 51331, 51332, 51333, 51334,
   51335, 51336, 51346, 51347, 51348, 51349, 51353, 51354, 51355, 51356, 51357, 51358, 51359, 51360, 51361,
   51362, 51363, 51364, 51377, 51396, 51407, 51408, 51409, 51417, 51423, 51437, 51452, 51455, 51468, 51469,
   51470, 51471, 51472, 51473, 51474, 51475, 51476, 51477, 51478, 51479, 51501, 51513, 51533, 69861);
-- 32287 Archmage Alvareaux: 18
DELETE FROM `npc_vendor` WHERE `entry` = 32287 AND `type` = 1 AND `item` IN
  (41718, 42188, 43157, 44141, 44159, 44166, 44167, 44170, 44171, 44173, 44174, 44176, 44179, 44180, 44181,
   44182, 44183, 50368);
-- 32334 Nixi Fireclaw: 4
DELETE FROM `npc_vendor` WHERE `entry` = 32334 AND `type` = 1 AND `item` IN
  (33444, 33445, 35954, 43236);
-- 32337 Christi Stockton: 8
DELETE FROM `npc_vendor` WHERE `entry` = 32337 AND `type` = 1 AND `item` IN
  (44621, 44622, 44623, 44625, 44626, 44632, 44678, 44679);
-- 32403 Sandra Bartan: 12
DELETE FROM `npc_vendor` WHERE `entry` = 32403 AND `type` = 1 AND `item` IN
  (33443, 33444, 33445, 33449, 33454, 35950, 35952, 35953, 35954, 40035, 40036, 40042);
-- 43408 Aili Greenwillow: 1
DELETE FROM `npc_vendor` WHERE `entry` = 43408 AND `type` = 1 AND `item` IN
  (37460);
-- 43411 Lenedil Moonwing: 4
DELETE FROM `npc_vendor` WHERE `entry` = 43411 AND `type` = 1 AND `item` IN
  (58256, 58260, 58274, 58279);
-- 248196 Apothecary Durelle: 1
DELETE FROM `npc_vendor` WHERE `entry` = 248196 AND `type` = 1 AND `item` IN
  (250996);
