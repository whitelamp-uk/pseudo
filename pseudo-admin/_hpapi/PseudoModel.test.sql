
SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';


INSERT IGNORE INTO `hpapi`.`hpapi_user` (`active`,`verified`,`uuid`,`email`,`password_hash`) VALUES
(1,1,`hpapi`.hpapiUUID(),'datadude@myorg','$2y$10$hLSdApW6.30YLK3ze49uSu7OV0gmS3ZT65pufxDPGiMxsmW3bykeq');


IF ROW_COUNT() = 1 THEN

  SET @userId = LAST_INSERT_ID();

  INSERT INTO `pseudo_column` (`provider_uuid`, `db_name`, `table_name`, `column_name`) VALUES
  (UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),	'pseudo_demo',	'person_pseudoed',	'title'),
  (UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),	'pseudo_demo',	'person_pseudoed',	'yob');

  INSERT INTO `pseudo_provider` (`uuid`, `name`) VALUES
  (UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),	'My Organisation');

  INSERT INTO `pseudo_read` (`user_uuid`, `provider_uuid`, `db_name`, `table_name`, `column_name`) VALUES
  (UNHEX('A0096E271A2211EA94D800165E0004E8'),	UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),	'pseudo_demo',	'person_pseudoed',	'title'),
  (UNHEX('A0096E271A2211EA94D800165E0004E8'),	UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),	'pseudo_demo',	'person_pseudoed',	'yob');

  INSERT INTO `pseudo_user` (`user_id`, `uuid`, `remote_addr_pattern`, `token`, `token_expires`) VALUES
  (@userId,	UNHEX('A0096E271A2211EA94D800165E0004E8'),	'.+',	NULL,	NULL);

  INSERT INTO `pseudo_value` (`uuid`, `provider_uuid`, `db_name`, `table_name`, `column_name`, `decoded_value`) VALUES
  (UNHEX('7815B5AE267111EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'title',  'Mr'),
  (UNHEX('8FE4C38A267111EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'title',  'Mr'),
  (UNHEX('A294F51B267111EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'title',  'Mr'),
  (UNHEX('CE547C56267111EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'title',  'Ms'),
  (UNHEX('E16D2B1D267111EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'title',  'Mrs'),
  (UNHEX('197C72B8267211EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'title',  'Miss'),
  (UNHEX('554136D0267F11EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'yob',  '1959'),
  (UNHEX('5541ED0D267F11EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'yob',  '1965'),
  (UNHEX('5542EF7F267F11EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'yob',  '1971'),
  (UNHEX('55439F4A267F11EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'yob',  '1977'),
  (UNHEX('55443A20267F11EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'yob',  '1983'),
  (UNHEX('5544DF0B267F11EA94D800165E0004E8'),  UNHEX('8FE3CB9F266E11EA94D800165E0004E8'),  'pseudo_demo',  'person_pseudoed',  'yob',  '1989');

END IF;

