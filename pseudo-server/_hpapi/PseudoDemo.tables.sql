

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';


CREATE TABLE `person` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(16) DEFAULT NULL,
  `yob` smallint(4) unsigned DEFAULT NULL,
  `postcode` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `person_pseudoed` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` binary(16) DEFAULT NULL,
  `yob` binary(16) DEFAULT NULL,
  `postcode` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


