USE nuevodb;

DELIMITER $$

DROP PROCEDURE IF EXISTS CalculaCategoriaEdad;
CREATE PROCEDURE CalculaCategoriaEdad(IN fecha_nacimiento INT, OUT edad INT, OUT categoria VARCHAR(20))
BEGIN
    DECLARE actual INT DEFAULT 2023; 
    SET edad = actual - fecha_nacimiento;
    
    IF edad >= 65 THEN
        SET categoria = 'Jubilado';
    ELSEIF edad >= 18 THEN
        SET categoria = 'Adulto';
    ELSEIF edad > 10 THEN
        SET categoria = 'Adolescente';
	ELSEIF edad < 0 THEN
		set categoria = 'Imposible';
    ELSE
        SET categoria = 'Niño';
    END IF;
    
    SELECT edad, categoria; -- Devuelve los resultados 
    
END $$
DELIMITER ;

CALL CalculaCategoriaEdad(2024, @edad, @categoria);


-- si es entre 1000 y 2000 es un 20%, si es entre 2000 y 5000 sea un 30%, si es entre 5000 y 10000 sea un 40% y si es mas de 10000 un 50%





DELIMITER $$
DROP PROCEDURE IF EXISTS CalculaDescuentoIvaTotal3$$
CREATE PROCEDURE CalculaDescuentoIvaTotal3
(
 IN precio_base DECIMAL(10,2), 
 OUT descuento DECIMAL(10,2), 
 OUT iva DECIMAL(10,2), 
 OUT total DECIMAL(10,2))
BEGIN 
    -- Determinar el porcentaje de descuento basado en el precio base
    IF precio_base < 1000 THEN
        SET descuento = precio_base * 0.10;
    ELSEIF precio_base >= 1000 AND precio_base < 2000 THEN
        SET descuento = precio_base * 0.20;
    ELSEIF precio_base >= 2000 AND precio_base < 5000 THEN
        SET descuento = precio_base * 0.30;
    ELSEIF precio_base >= 5000 AND precio_base < 10000 THEN
        SET descuento = precio_base * 0.40;
    ELSE
        SET descuento = precio_base * 0.50;
    END IF;
    
    -- Definir la tasa de IVA (21%)
    SET iva = precio_base * 0.21;
    
    -- Calcular el total después de aplicar el descuento y añadir el IVA
    SET total = precio_base - descuento + iva;
END$$

DELIMITER ;

CALL CalculaDescuentoIvaTotal3(9000,@descuento,@iva,@total);
SELECT @descuento, @iva, @total;
