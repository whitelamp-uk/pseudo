
SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `pseudo_column`;
CREATE TABLE `pseudo_column` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_uuid` binary(16) DEFAULT NULL,
  `db_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `table_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `column_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `owner_uuid_db_name_table_name_column_name` (`provider_uuid`,`db_name`,`table_name`,`column_name`),
  CONSTRAINT `pseudo_column_ibfk_1` FOREIGN KEY (`provider_uuid`) REFERENCES `pseudo_provider` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `pseudo_provider`;
CREATE TABLE `pseudo_provider` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `name` varchar(128) NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `pseudo_read`;
CREATE TABLE `pseudo_read` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_uuid` binary(16) DEFAULT NULL,
  `provider_uuid` binary(16) DEFAULT NULL,
  `db_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `table_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `column_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_uuid_owner_uuid_db_name_table_name_column_name` (`user_uuid`,`provider_uuid`,`db_name`,`table_name`,`column_name`),
  KEY `owner_uuid` (`provider_uuid`,`db_name`,`table_name`,`column_name`),
  CONSTRAINT `pseudo_read_ibfk_1` FOREIGN KEY (`user_uuid`) REFERENCES `pseudo_user` (`uuid`),
  CONSTRAINT `pseudo_read_ibfk_2` FOREIGN KEY (`provider_uuid`, `db_name`, `table_name`, `column_name`) REFERENCES `pseudo_column` (`provider_uuid`, `db_name`, `table_name`, `column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `pseudo_user`;
CREATE TABLE `pseudo_user` (
  `user_id` int(11) unsigned NOT NULL,
  `uuid` binary(16) DEFAULT NULL,
  `remote_addr_pattern` varchar(255) CHARACTER SET ascii NOT NULL DEFAULT '.+',
  `token` varchar(255) CHARACTER SET ascii DEFAULT NULL,
  `token_expires` datetime DEFAULT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `pseudo_value`;
CREATE TABLE `pseudo_value` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` binary(16) DEFAULT NULL,
  `provider_uuid` binary(16) DEFAULT NULL,
  `db_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `table_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `column_name` varchar(64) CHARACTER SET ascii NOT NULL,
  `decoded_value` varchar(255) NOT NULL,
  `created` timestamp DEFAULT CURRENT_TIMESTAMP,
  `updated` timestamp NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`),
  KEY `owner_db_table_column` (`provider_uuid`,`db_name`,`table_name`,`column_name`),
  CONSTRAINT `pseudo_value_ibfk_1` FOREIGN KEY (`provider_uuid`, `db_name`, `table_name`, `column_name`) REFERENCES `pseudo_column` (`provider_uuid`, `db_name`, `table_name`, `column_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


