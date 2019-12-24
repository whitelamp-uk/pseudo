

SET NAMES utf8;
SET time_zone = '+00:00';


DELIMITER $$
DROP FUNCTION IF EXISTS `pseudoUUID`$$
CREATE FUNCTION `pseudoUUID`(
) RETURNS binary(16)
    DETERMINISTIC
BEGIN
  RETURN UNHEX(
    REPLACE(
      UUID(), '-', ''
    )
  );
END$$


DELIMITER $$
DROP FUNCTION IF EXISTS `pseudoUUIDStandard`$$
CREATE FUNCTION `pseudoUUIDStandard`(
  uuidBinary binary(16)
) RETURNS char(36) CHARSET utf8
    DETERMINISTIC
BEGIN
  SET @Hexed = HEX(uuidBinary);
  RETURN CONCAT_WS(
    '-'
   ,LOWER(SUBSTR(@Hexed,1,8))
   ,LOWER(SUBSTR(@Hexed,9,4))
   ,LOWER(SUBSTR(@Hexed,13,4))
   ,LOWER(SUBSTR(@Hexed,17,4))
   ,LOWER(SUBSTR(@Hexed,21,12))
  );
END$$


DELIMITER $$
DROP FUNCTION IF EXISTS `pseudoUUIDString`$$
CREATE FUNCTION `pseudoUUIDString`(
  uuidBinary binary(16)
) RETURNS char(32) CHARSET utf8
    DETERMINISTIC
BEGIN
  RETURN HEX(uuidBinary);
END$$


DELIMITER ;


