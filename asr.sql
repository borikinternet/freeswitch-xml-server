-- MySQL dump 10.13  Distrib 5.5.55, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ASR
-- ------------------------------------------------------
-- Server version	5.5.55-0+deb8u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attribute-types`
--

DROP TABLE IF EXISTS `attribute-types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attribute-types` (
  `attr-type` varchar(45) CHARACTER SET utf8 NOT NULL,
  `table` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`attr-type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attributes` (
  `aid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Первичный ключ',
  `attr-type` varchar(45) CHARACTER SET utf8 NOT NULL COMMENT 'Тип атрибута',
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Имя атрибута',
  `value` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Значение атрибута',
  `id` int(10) unsigned NOT NULL COMMENT 'Идентификатор головной сущности',
  `oid` int(10) unsigned NOT NULL COMMENT 'Внешний ключ организации, к которой относится атрибут',
  PRIMARY KEY (`aid`),
  KEY `oid_attributes_fk_idx` (`oid`),
  KEY `type_attributes_fk_idx` (`attr-type`),
  CONSTRAINT `oid_attributes_fk` FOREIGN KEY (`oid`) REFERENCES `organisations` (`oid`) ON DELETE CASCADE,
  CONSTRAINT `type_attributes_fk` FOREIGN KEY (`attr-type`) REFERENCES `attribute-types` (`attr-type`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица для разных необязательных атрибутов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extension-types`
--

DROP TABLE IF EXISTS `extension-types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extension-types` (
  `extension-type` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`extension-type`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица типов направлений';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `extensions`
--

DROP TABLE IF EXISTS `extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extensions` (
  `eid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Первичный ключ',
  `oid` int(10) unsigned NOT NULL COMMENT 'Внешний ключ - организация',
  `id` int(10) unsigned DEFAULT NULL COMMENT 'Внешний ключ - идентификатор сущности, ссылается на разные таблицы в зависимости от типа направления',
  `extension-type` int(10) unsigned DEFAULT NULL COMMENT 'Тип направления',
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Имя направления',
  PRIMARY KEY (`eid`),
  KEY `oid_extensions_fk_idx` (`oid`),
  KEY `type_extensions_fk_idx` (`extension-type`),
  CONSTRAINT `oid_extensions_fk` FOREIGN KEY (`oid`) REFERENCES `organisations` (`oid`) ON DELETE CASCADE,
  CONSTRAINT `type_extensions_fk` FOREIGN KEY (`extension-type`) REFERENCES `extension-types` (`extension-type`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица абстрактных направлений';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gateways`
--

DROP TABLE IF EXISTS `gateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gateways` (
  `gwid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Первичный ключ',
  `oid` int(10) unsigned NOT NULL COMMENT 'Внешний ключ организации',
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Видимое имя шлюза',
  `host` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'DNS-имя шлюза',
  `user` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Имя пользователя для регистрации',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Пароль для регистрации',
  `active` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`gwid`),
  KEY `oid_gateways_fk_idx` (`oid`),
  CONSTRAINT `oid_gateways_fk` FOREIGN KEY (`oid`) REFERENCES `organisations` (`oid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица шлюзов';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ASR`.`gateways_AFTER_INSERT` AFTER INSERT ON `gateways` FOR EACH ROW
BEGIN
	if (@triggers_enabled is null) then
		select `extension-type` into @etype from `extension-types` where `table` like 'gateways';
        insert into `extensions` (`oid`,`id`,`extension-type`,`name`) values
				(new.oid,new.gwid,@etype,concat(new.`name`,' gateway extension'));
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ASR`.`gateways_AFTER_DELETE` AFTER DELETE ON `gateways` FOR EACH ROW
BEGIN
	if (@triggers_enabled is null) then
		select `extension-type` into @etype from `extension-types` where `table` like 'gateways';
        delete from `extensions` where `id`=old.`gwid` and `extension-type`=@etype;
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `group-members`
--

DROP TABLE IF EXISTS `group-members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group-members` (
  `gid` int(10) unsigned NOT NULL COMMENT 'Внешний ключ группы',
  `uid` int(10) unsigned NOT NULL COMMENT 'Внешний ключ пользователя',
  PRIMARY KEY (`gid`,`uid`),
  KEY `uid_group_members_fk_idx` (`uid`),
  CONSTRAINT `gid_group_members_fk` FOREIGN KEY (`gid`) REFERENCES `groups` (`gid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `uid_group_members_fk` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица пользователей, членов групп';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `gid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Первичный ключ группы',
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL COMMENT 'Имя группы',
  `oid` int(10) unsigned NOT NULL COMMENT 'Внешний ключ организации',
  PRIMARY KEY (`gid`),
  KEY `oid_groups_fk_idx` (`oid`),
  CONSTRAINT `oid_groups_fk` FOREIGN KEY (`oid`) REFERENCES `organisations` (`oid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица груп';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ASR`.`groups_AFTER_INSERT` AFTER INSERT ON `groups` FOR EACH ROW
BEGIN
	if (@triggers_enabled is null) then
		select `extension-type` into @etype from `extension-types` where `table` like 'groups';
        insert into `extensions` (`oid`,`id`,`extension-type`,`name`) values
				(new.oid,new.gid,@etype,concat(new.`name`,' group extension'));
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ASR`.`groups_AFTER_DELETE` AFTER DELETE ON `groups` FOR EACH ROW
BEGIN
	if (@triggers_enabled is null) then
		select `extension-type` into @etype from `extension-types` where `table` like 'groups';
        delete from `extensions` where `id`=old.`gid` and `extension-type`=@etype;
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `organisations`
--

DROP TABLE IF EXISTS `organisations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organisations` (
  `oid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Первичный ключ',
  `domain` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'Домен организации',
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Имя организации',
  `tz` varchar(45) CHARACTER SET utf8 NOT NULL DEFAULT 'Europe/Moscow' COMMENT 'Часовой пояс',
  `billing-id` varchar(10) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Ссылка на биллинг',
  `active` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`oid`),
  UNIQUE KEY `oid_UNIQUE` (`oid`),
  UNIQUE KEY `domain_UNIQUE` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица организаций';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `outgoing-destinations`
--

DROP TABLE IF EXISTS `outgoing-destinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outgoing-destinations` (
  `odid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `oid` int(10) unsigned NOT NULL,
  `eid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`odid`),
  KEY `oid_outgoing_fk_idx` (`oid`),
  KEY `eid_outgoing_fk_idx` (`eid`),
  CONSTRAINT `eid_outgoing_fk` FOREIGN KEY (`eid`) REFERENCES `extensions` (`eid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `oid_outgoing_fk` FOREIGN KEY (`oid`) REFERENCES `organisations` (`oid`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Первичный ключ пользователя',
  `number` varchar(45) CHARACTER SET utf8 NOT NULL COMMENT 'Номер пользователя в АТС',
  `name` varchar(60) CHARACTER SET utf8 NOT NULL COMMENT 'Имя пользователя',
  `oid` int(10) unsigned NOT NULL COMMENT 'Внешний ключ организации',
  `email` varchar(255) CHARACTER SET utf8 NOT NULL COMMENT 'Электронная почта',
  `password` varchar(128) CHARACTER SET utf8 NOT NULL COMMENT 'Хэш пароля',
  `active` int(10) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`uid`),
  KEY `oid_users_fk_idx` (`oid`),
  CONSTRAINT `oid_users_fk` FOREIGN KEY (`oid`) REFERENCES `organisations` (`oid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Таблица пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ASR`.`users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW
BEGIN
	if (@triggers_enabled is null) then
		select `extension-type` into @etype from `extension-types` where `table` like 'users';
        insert into `extensions` (`oid`,`id`,`extension-type`,`name`) values
				(new.oid,new.uid,@etype,concat(new.`number`,' user extension'));
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ASR`.`users_AFTER_DELETE` AFTER DELETE ON `users` FOR EACH ROW
BEGIN
	if (@triggers_enabled is null) then
		select `extension-type` into @etype from `extension-types` where `table` like 'users';
        delete from `extensions` where `id`=old.`uid` and `extension-type`=@etype;
    end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `word-sets`
--

DROP TABLE IF EXISTS `word-sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `word-sets` (
  `wsid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8 NOT NULL,
  `oid` int(10) unsigned NOT NULL,
  `odid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`wsid`),
  KEY `oid_wsets_fk_idx` (`oid`),
  KEY `odid_wsets_fk_idx` (`odid`),
  CONSTRAINT `odid_wsets_fk` FOREIGN KEY (`odid`) REFERENCES `outgoing-destinations` (`odid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `oid_wsets_fk` FOREIGN KEY (`oid`) REFERENCES `organisations` (`oid`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `words`
--

DROP TABLE IF EXISTS `words`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `words` (
  `word` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `wsid` int(10) unsigned NOT NULL DEFAULT '0',
  `weight` int(10) unsigned NOT NULL DEFAULT '1',
  `oid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`word`,`wsid`),
  KEY `wsid_words_fk_idx` (`wsid`),
  KEY `oid_words_fk_idx` (`oid`),
  CONSTRAINT `oid_words_fk` FOREIGN KEY (`oid`) REFERENCES `organisations` (`oid`) ON UPDATE CASCADE,
  CONSTRAINT `wsid_words_fk` FOREIGN KEY (`wsid`) REFERENCES `word-sets` (`wsid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-07-26 11:24:22
