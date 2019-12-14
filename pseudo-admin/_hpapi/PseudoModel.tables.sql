-- Adminer 4.7.5 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;

CREATE TABLE IF NOT EXISTS `pseudo_access` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_uuid` binary(16) NULL,
  `owner_uuid` binary(16) NULL,
  `db_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `table_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `column_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `may_write` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_uuid_owner_uuid_db_name_table_name_column_name` (`user_uuid`,`owner_uuid`,`db_name`,`table_name`,`column_name`),
  KEY `owner_uuid` (`owner_uuid`,`db_name`,`table_name`,`column_name`),
  CONSTRAINT `pseudo_access_ibfk_1` FOREIGN KEY (`user_uuid`) REFERENCES `pseudo_user` (`uuid`),
  CONSTRAINT `pseudo_access_ibfk_2` FOREIGN KEY (`owner_uuid`, `db_name`, `table_name`, `column_name`) REFERENCES `pseudo_column` (`owner_uuid`, `db_name`, `table_name`, `column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `pseudo_column` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner_uuid` binary(16) NULL,
  `db_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `table_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `column_name` varchar(64) CHARACTER SET ascii NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `owner_uuid_db_name_table_name_column_name` (`owner_uuid`,`db_name`,`table_name`,`column_name`),
  CONSTRAINT `pseudo_column_ibfk_1` FOREIGN KEY (`owner_uuid`) REFERENCES `pseudo_owner` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `pseudo_owner` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) NULL,
  `user_uuid` binary(16) NULL,
  `name` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `user_uuid` (`user_uuid`),
  CONSTRAINT `pseudo_owner_ibfk_1` FOREIGN KEY (`user_uuid`) REFERENCES `pseudo_user` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `pseudo_user` (
  `user_id` int(11) unsigned NOT NULL,
  `uuid` binary(16) NULL,
  `remote_addr_pattern` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '.+',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `pseudo_value` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) NULL,
  `owner_uuid` binary(16) NULL,
  `db_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `table_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `column_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `decoded_value` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `owner_db_table_column` (`owner_uuid`,`db_name`,`table_name`,`column_name`),
  CONSTRAINT `pseudo_value_ibfk_1` FOREIGN KEY (`owner_uuid`, `db_name`, `table_name`, `column_name`) REFERENCES `pseudo_column` (`owner_uuid`, `db_name`, `table_name`, `column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2019-12-09 01:05:32
