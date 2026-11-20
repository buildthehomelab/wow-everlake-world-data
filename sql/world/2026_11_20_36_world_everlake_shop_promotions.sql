-- WoW Forever's promotion items in the in-game Store: a 'Promotions' tab (shop_group 4) with 29 products (100-138).
-- 2026_11_20_36_world_everlake_shop_promotions.sql: written by a script, checked by hand.
--
-- What is sold: the items the tracker files under its "Promotions" phase (paid or promotional on live: Collector's Edition,
-- Skyborne packs, subscriptions, Twitch and China launch rewards, trading-card loot), all known to the realm's item data.
-- Prices in shop points, a project decision (2026-11-20): pets and toys 10, outfits 20, the Eternal Explorer pack 15,
-- tabards, trading-card items and Collector's Edition vouchers 5. Card icons are the items' own (client Item.db2).
-- Each product mails its items (shop_product_action 1 = Item). The vouchers start the classic Welcome! quests in the
-- six starting areas, which give the classic Mini Diablo, Panda Cub or Zergling.
-- Left out: the classic Panda Collar 180089 (another copy of the pet), the iCoke vouchers 19642, 22822, 23227 (the
-- Summer Gift Package they lead to is sold).
-- A row is added only where its id is free; each is recorded in everlake_import_rows. The Store loads at server start.
-- Never edit this file once it is deployed: a later fix is a new file. Running it again changes nothing. Not tried in game.
CREATE TABLE IF NOT EXISTS `everlake_import_rows` (
  `tbl` varchar(64) NOT NULL COMMENT 'world table of the row',
  `k1` bigint NOT NULL COMMENT 'the row''s key, in the table''s primary key order',
  `k2` bigint NOT NULL DEFAULT '0',
  `k3` bigint NOT NULL DEFAULT '0',
  `k4` bigint NOT NULL DEFAULT '0',
  `file` varchar(200) NOT NULL COMMENT 'the update file that added the row',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT 'the sources that gave it',
  PRIMARY KEY (`tbl`, `k1`, `k2`, `k3`, `k4`),
  KEY `file` (`file`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Rows the Everlake world import added';
SET @EVERLAKE_FILE := '2026_11_20_36_world_everlake_shop_promotions.sql';
START TRANSACTION;
SET @EVERLAKE_T := NOT EXISTS (SELECT 1 FROM `shop_group` WHERE `ID` = 4);
INSERT INTO `shop_group` (`ID`, `Name`, `IconFileDataID`, `Ordering`) SELECT 4, 'Promotions', 7831521, 4 FROM DUAL WHERE @EVERLAKE_T = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_group', 4, 0, 0, 0, @EVERLAKE_FILE, 'project decision: Promotions tab' FROM DUAL WHERE @EVERLAKE_T = 1;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 100) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 100);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 100, 4, 'Azurky', 'A companion pet (Azurky), sent by mail.', 656556, 10, 0, 1, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 100 AS `p`, 0 AS `i`, 285354 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 100, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 100;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 101) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 101);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 101, 4, 'Gill''el', 'A companion pet (Gill''el), sent by mail.', 5834819, 10, 0, 2, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 101 AS `p`, 0 AS `i`, 229368 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 101, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 101;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 102) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 102);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 102, 4, 'Pachimari', 'A companion pet (Pachimari), sent by mail.', 7741132, 10, 0, 3, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 102 AS `p`, 0 AS `i`, 280614 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 102, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 102;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 103) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 103);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 103, 4, 'Poley', 'A companion pet: Polar Bear Collar, sent by mail.', 132498, 10, 0, 4, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 103 AS `p`, 0 AS `i`, 22781 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 103, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 103;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 104) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 104);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 104, 4, 'Terky', 'A companion pet: White Murloc Egg, sent by mail.', 132834, 10, 0, 5, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 104 AS `p`, 0 AS `i`, 22780 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 104, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 104;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 105) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 105);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 105, 4, 'Mini Diablo', 'A companion pet: Diablo Stone, sent by mail.', 7831523, 10, 0, 6, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 105 AS `p`, 0 AS `i`, 281168 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 105, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 105;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 106) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 106);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 106, 4, 'Panda Cub', 'A companion pet: Panda Collar, sent by mail.', 7831521, 10, 0, 7, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 106 AS `p`, 0 AS `i`, 281166 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 106, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 106;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 107) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 107);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 107, 4, 'Zergling', 'A companion pet: Zergling Leash, sent by mail.', 7831522, 10, 0, 8, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 107 AS `p`, 0 AS `i`, 281167 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 107, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 107;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 110) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 110);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 110, 4, 'Collector''s Edition Voucher: Northshire', 'Turn it in at Northshire and choose Mini Diablo, Panda Cub or Zergling.', 134140, 5, 0, 9, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 110 AS `p`, 0 AS `i`, 14646 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 110, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 110;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 111) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 111);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 111, 4, 'Collector''s Edition Voucher: Coldridge Valley', 'Turn it in at Coldridge Valley and choose Mini Diablo, Panda Cub or Zergling.', 134140, 5, 0, 10, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 111 AS `p`, 0 AS `i`, 14647 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 111, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 111;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 112) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 112);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 112, 4, 'Collector''s Edition Voucher: Shadowglen', 'Turn it in at Shadowglen and choose Mini Diablo, Panda Cub or Zergling.', 134140, 5, 0, 11, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 112 AS `p`, 0 AS `i`, 14648 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 112, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 112;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 113) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 113);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 113, 4, 'Collector''s Edition Voucher: Valley of Trials', 'Turn it in at the Valley of Trials and choose Mini Diablo, Panda Cub or Zergling.', 134140, 5, 0, 12, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 113 AS `p`, 0 AS `i`, 14649 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 113, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 113;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 114) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 114);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 114, 4, 'Collector''s Edition Voucher: Camp Narache', 'Turn it in at Camp Narache and choose Mini Diablo, Panda Cub or Zergling.', 134140, 5, 0, 13, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 114 AS `p`, 0 AS `i`, 14650 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 114, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 114;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 115) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 115);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 115, 4, 'Collector''s Edition Voucher: Deathknell', 'Turn it in at Deathknell and choose Mini Diablo, Panda Cub or Zergling.', 134140, 5, 0, 14, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 115 AS `p`, 0 AS `i`, 14651 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 115, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 115;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 120) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 120);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 120, 4, 'Adventurer''s Tent', 'A toy: Adventurer''s Tent, sent by mail.', 4624631, 10, 0, 15, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 120 AS `p`, 0 AS `i`, 288185 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 120, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 120;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 121) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 121);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 121, 4, 'Pouch of Violet Dust', 'A toy: Pouch of Violet Dust, sent by mail.', 5931149, 10, 0, 16, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 121 AS `p`, 0 AS `i`, 289439 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 121, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 121;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 122) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 122);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 122, 4, 'Shen''dorei Windwell', 'A toy: Shen''dorei Windwell, sent by mail.', 1029585, 10, 0, 17, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 122 AS `p`, 0 AS `i`, 280740 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 122, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 10' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 122;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 125) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 125);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 125, 4, 'Shen''dorei Skyseer''s Garb', 'The Shen''dorei Skyseer''s outfit: nine pieces and the ensemble, sent by mail.', 7751149, 20, 0, 18, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 125 AS `p`, 0 AS `i`, 271755 AS `item` UNION ALL SELECT 125 AS `p`, 1 AS `i`, 271746 AS `item` UNION ALL SELECT 125 AS `p`, 2 AS `i`, 271747 AS `item` UNION ALL SELECT 125 AS `p`, 3 AS `i`, 271748 AS `item` UNION ALL SELECT 125 AS `p`, 4 AS `i`, 271749 AS `item` UNION ALL SELECT 125 AS `p`, 5 AS `i`, 271750 AS `item` UNION ALL SELECT 125 AS `p`, 6 AS `i`, 271751 AS `item` UNION ALL SELECT 125 AS `p`, 7 AS `i`, 271752 AS `item` UNION ALL SELECT 125 AS `p`, 8 AS `i`, 271753 AS `item` UNION ALL SELECT 125 AS `p`, 9 AS `i`, 271754 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 125, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 20' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 125;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 126) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 126);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 126, 4, 'Veteran Adventurer''s Outdoor Wear', 'The Veteran Adventurer''s outfit: nine pieces, the ensemble and the Veteran Adventurer''s Rucksack, sent by mail.', 7711862, 20, 0, 19, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 126 AS `p`, 0 AS `i`, 279182 AS `item` UNION ALL SELECT 126 AS `p`, 1 AS `i`, 279173 AS `item` UNION ALL SELECT 126 AS `p`, 2 AS `i`, 279174 AS `item` UNION ALL SELECT 126 AS `p`, 3 AS `i`, 279175 AS `item` UNION ALL SELECT 126 AS `p`, 4 AS `i`, 279176 AS `item` UNION ALL SELECT 126 AS `p`, 5 AS `i`, 279177 AS `item` UNION ALL SELECT 126 AS `p`, 6 AS `i`, 279178 AS `item` UNION ALL SELECT 126 AS `p`, 7 AS `i`, 279179 AS `item` UNION ALL SELECT 126 AS `p`, 8 AS `i`, 279180 AS `item` UNION ALL SELECT 126 AS `p`, 9 AS `i`, 279181 AS `item` UNION ALL SELECT 126 AS `p`, 10 AS `i`, 280623 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 126, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 20' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 126;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 127) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 127);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 127, 4, 'Stillwater Fisher Attire', 'Ensemble: Stillwater Fisher Attire, sent by mail.', 6893245, 20, 0, 20, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 127 AS `p`, 0 AS `i`, 244231 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 127, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 20' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 127;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 128) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 128);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 128, 4, 'Eternal Explorer Pack', 'The Eternal Explorer''s Backpack and the Tabard of Eternal Exploration, sent by mail.', 8119728, 15, 0, 21, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 128 AS `p`, 0 AS `i`, 285352 AS `item` UNION ALL SELECT 128 AS `p`, 1 AS `i`, 285353 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 128, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 15' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 128;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 130) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 130);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 130, 4, 'Lordaeron Forever Tabard', 'A tabard, sent by mail.', 7713111, 5, 0, 22, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 130 AS `p`, 0 AS `i`, 280404 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 130, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 130;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 131) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 131);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 131, 4, 'Shen''dorei Tabard', 'A tabard, sent by mail.', 8101155, 5, 0, 23, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 131 AS `p`, 0 AS `i`, 280729 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 131, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 131;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 132) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 132);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 132, 4, 'Tabard of Flame', 'A tabard, sent by mail.', 134473, 5, 0, 24, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 132 AS `p`, 0 AS `i`, 23705 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 132, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 132;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 133) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 133);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 133, 4, 'Tabard of Frost', 'A tabard, sent by mail.', 135026, 5, 0, 25, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 133 AS `p`, 0 AS `i`, 23709 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 133, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 133;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 134) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 134);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 134, 4, 'Upperdeck Tabard #3', 'A tabard, sent by mail.', 135026, 5, 0, 26, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 134 AS `p`, 0 AS `i`, 23710 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 134, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 134;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 136) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 136);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 136, 4, 'Carved Ogre Idol', 'Carved Ogre Idol, sent by mail.', 134230, 5, 0, 27, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 136 AS `p`, 0 AS `i`, 23716 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 136, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 136;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 137) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 137);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 137, 4, 'Perpetual Purple Firework', 'Perpetual Purple Firework, sent by mail.', 134284, 5, 0, 28, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 137 AS `p`, 0 AS `i`, 23714 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 137, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 137;

SET @EVERLAKE_P := NOT EXISTS (SELECT 1 FROM `shop_product` WHERE `ID` = 138) AND NOT EXISTS (SELECT 1 FROM `shop_product_action` WHERE `ProductID` = 138);
INSERT INTO `shop_product` (`ID`, `GroupID`, `Name`, `Description`, `IconFileDataID`, `Price`, `NormalPrice`, `Ordering`, `Enabled`)
SELECT 138, 4, 'Summer Gift Package', 'Summer Gift Package, sent by mail.', 134140, 5, 0, 29, 1 FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT INTO `shop_product_action` (`ProductID`, `Index`, `Action`, `Param1`, `Param2`) SELECT s.`p`, s.`i`, 1, s.`item`, 1 FROM (SELECT 138 AS `p`, 0 AS `i`, 23224 AS `item`) s WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product', 138, 0, 0, 0, @EVERLAKE_FILE, 'project decision: promotion item, price 5' FROM DUAL WHERE @EVERLAKE_P = 1;
INSERT IGNORE INTO `everlake_import_rows` (`tbl`, `k1`, `k2`, `k3`, `k4`, `file`, `note`) SELECT 'shop_product_action', a.`ProductID`, a.`Index`, 0, 0, @EVERLAKE_FILE, CONCAT('mails item ', a.`Param1`) FROM `shop_product_action` a WHERE @EVERLAKE_P = 1 AND a.`ProductID` = 138;

COMMIT;
