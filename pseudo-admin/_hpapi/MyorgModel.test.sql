
SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';


INSERT IGNORE INTO `hpapi`.`hpapi_user` (`active`,`verified`,`uuid`,`email`,`password_hash`) VALUES
(1,1,`hpapi`.hpapiUUID(),'datadude@myorg','$2y$10$hLSdApW6.30YLK3ze49uSu7OV0gmS3ZT65pufxDPGiMxsmW3bykeq');


