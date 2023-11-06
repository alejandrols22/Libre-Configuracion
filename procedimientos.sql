use empresa;

DELIMITER $$

DROP PROCEDURE IF EXISTS CalcularEdad $$

CREATE PROCEDURE CalcularEdad (
    IN fechaNacimiento INT,
    OUT edad INT
)
BEGIN
    DECLARE actual INT DEFAULT YEAR(CURDATE()); -- Obtiene el año actual
    SET edad = actual - fechaNacimiento; -- Calcula la edad
END $$

DELIMITER ;

CALL CalcularEdad(1990, @edadCalculada); -- 1990 es un ejemplo de año de nacimiento
SELECT @edadCalculada; -- Esto mostrará el resultado

DELIMITER $$

DROP PROCEDURE IF EXISTS `Calculadora` $$
CREATE PROCEDURE `Calculadora`(
    IN num1 DOUBLE,
    IN num2 DOUBLE,
    IN op CHAR(1),
    OUT result DOUBLE
)
BEGIN
    CASE op
        WHEN '+' THEN SET result = num1 + num2;
        WHEN '-' THEN SET result = num1 - num2;
        WHEN '*' THEN SET result = num1 * num2;
        WHEN '/' THEN SET result = num1 / num2;
        ELSE SET result = 0;
    END CASE;
END$$

DELIMITER ;