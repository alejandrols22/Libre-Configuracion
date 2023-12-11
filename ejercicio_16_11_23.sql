delimiter $$
DROP FUNCTION if EXISTS funcion1 $$
CREATE FUNCTION funcion1(euros decimal(12,2))
RETURNS DECIMAL (10,2)
BEGIN
 RETURN euros*68;
 END $$
delimiter ;



SELECT funcion1(precio) FROM articulos;


USE phoneland;

DELIMITER $$
DROP FUNCTION IF EXISTS descuento $$
CREATE FUNCTION descuento (euros DECIMAL(12,2))
	RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	RETURN euros-(euros*0.10);
END $$
DELIMITER ;

DELIMITER $$
DROP FUNCTION IF EXISTS calcular_iva $$
CREATE FUNCTION calcular_iva (euros DECIMAL(12,2))
	RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	RETURN (descuento(euros)*0.21);
END $$
DELIMITER ;

SELECT precio, descuento(precio) AS Descuento, calcular_iva(precio) AS IVA FROM productos;

CASE p_tipo_producto
        WHEN 'alimentos' THEN
            SET p_iva = p_importe * 0.04;
        WHEN 'tecnología' THEN
            SET p_iva = p_importe * 0.21;
        WHEN 'formación' THEN
            SET p_iva = 0;
        ELSE
            SET p_iva = 0;
    END CASE;
