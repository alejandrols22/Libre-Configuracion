USE nuevodb;

SELECT c.nombre AS nombre_cliente, round(AVG(precio),2)
FROM clientes c
JOIN ventas v ON c.id_clientes = v.id_clientes
JOIN productos p ON v.id_PRODUCTOS = p.id_PRODUCTO

WHERE c.id_clientes IN (
	SELECT v.id_clientes
    FROM ventas v
    JOIN productos p ON v.id_PRODUCTOS = p.id_PRODUCTO
    GROUP BY v.id_clientes
    HAVING AVG(p.precio) > (
		SELECT AVG(precio)
        FROM productos
	)
)
GROUP BY c.nombre ORDER BY AVG(precio) desc;

-- Selecciona los clientes que ha realizado ventas
SELECT nombre
FROM clientes c
WHERE EXISTS (
	SELECT 1
    FROM ventas v
    WHERE v.id_clientes = c.id_clientes
);

-- Seleciona los clientes que NO han realizado ventas
SELECT nombre
FROM clientes c
WHERE NOT EXISTS (
	SELECT 1
    FROM ventas v
    WHERE v.id_clientes = c.id_clientes
);

-- Seleccionar los produtos cuyo id de producto en ventas mayor que 10.

SELECT nombre
FROM productos
WHERE id_producto IN(
	SELECT id_producto
    FROM ventas
    WHERE id_producto>10);
    
SELECT * FROM productos;

-- Selecciona los clientes que han realizado ventas

SELECT nombre
FROM clientes
WHERE id_clientes not IN ( SELECT id_clientes FROM ventas)



-- PROCEDIMIENTOS 

DELIMITER $$
DROP PROCEDURE IF EXISTS CalculaPrecioIva2 $$
CREATE PROCEDURE CalculaPrecioIva2 -- DECIMAL(10,2) = un decimal con 10 digitos y 2 decimales
(IN precio DECIMAL(10,2), OUT total DECIMAL(10,2))
BEGIN 
	DECLARE iva DECIMAL(10,2);
    SET iva := 0.21;
    SET total := precio + (precio * iva);
END $$
DELIMITER ;

CALL CalculaPrecioIva2(100.0,@resultado);
SELECT @resultado;
    
-- Hacer un procedimiento que calcule la edad de una persona sabiendo su fecha de nacimiento
DELIMITER $$
DROP PROCEDURE IF EXISTS CalculaEdad $$
CREATE PROCEDURE CalculaEdad 
(IN fechaNacimiento DECIMAL(4,0), OUT edad DECIMAL(4,0))
BEGIN 
	DECLARE actual DECIMAL(4,0) DEFAULT 2023;
	SET edad := actual - fechaNacimiento;
END $$
DELIMITER ;

CALL CalculaEdad(1977,@actual);
SELECT  CONCAT ("Su edad es :", @actual) AS edad;

-- Procedimiento calcular factura : en resultado salga el precio, el iva y el total (Con un concat El precio es x, El iva es x, El total es x)

DELIMITER $$
DROP PROCEDURE IF EXISTS CalculaFactura $$
CREATE PROCEDURE CalculaFactura 
(IN precio DECIMAL(10,2), IN importeIVA DECIMAL(5,2), OUT resultado VARCHAR(255))
BEGIN 
    DECLARE iva DECIMAL(10,2);
    DECLARE precioConIva DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);

    -- Calculamos el IVA basado en el importe dado
    SET iva := importeIVA * precio;

    -- Calculamos el precio con IVA
    SET precioConIva := precio + iva;

    -- Formateamos el resultado
    SET resultado := CONCAT('El precio es: ', precio, ', El IVA es: ', iva, ', El total es: ', precioConIva);
END $$
DELIMITER ;


CALL CalculaFactura(100.0, 0.21, @resFactura);
SELECT @resFactura;

-- Calcular factura descuento: Lo mismo con un impuesto del 10%, mostrando cuanto seria el descuento, el descuento se aplica antes deq ue el iva se llamara.

DELIMITER $$
DROP PROCEDURE IF EXISTS CalcularFacturaDescuento $$
CREATE PROCEDURE CalcularFacturaDescuento 
(IN precioOriginal DECIMAL(10,2), OUT resultado VARCHAR(255))
BEGIN 
    DECLARE descuento DECIMAL(10,2);
    DECLARE precioConDescuento DECIMAL(10,2);
    DECLARE iva DECIMAL(10,2);
    DECLARE total DECIMAL(10,2);
    DECLARE tasaIVA DECIMAL(5,2);
    DECLARE tasaDescuento DECIMAL(5,2);

    -- Establecer las tasas de IVA y descuento
    SET tasaIVA := 0.21; -- 21% de IVA
    SET tasaDescuento := 0.10; -- 10% de descuento

    -- Calcular el descuento
    SET descuento := precioOriginal * tasaDescuento;

    -- Aplicar el descuento al precio original
    SET precioConDescuento := precioOriginal - descuento;

    -- Calcular el IVA sobre el precio con descuento
    SET iva := precioConDescuento * tasaIVA;

    -- Calcular el total sumando el IVA al precio con descuento
    SET total := precioConDescuento + iva;

    -- Formatear el resultado para mostrar los cálculos
    SET resultado := CONCAT('El precio original es: ', precioOriginal,
                            ', El descuento es: ', descuento,
                            ', El precio con descuento es: ', precioConDescuento,
                            ', El IVA es: ', iva,
                            ', El total a pagar es: ', total);
END $$
DELIMITER ;

CALL CalcularFacturaDescuento(100.0, @resFacturaDescuento);
SELECT @resFacturaDescuento;

-- Procedimiento que llame al primer procedimiento y que este todo en un solo select usar call y select

--- PROCEDIMIENTO QUE CALCULA EL DESCUENTO Y EL IVA-----------------------------

DELIMITER $$
DROP PROCEDURE IF EXISTS CalculaDescuentoIvaTotal3$$

CREATE PROCEDURE CalculaDescuentoIvaTotal3(IN precio_base DECIMAL(10,2),
 OUT descuento DECIMAL(10,2), OUT iva DECIMAL(10,2), 
 OUT total DECIMAL(10,2))
BEGIN 
    -- Definir el descuento (10%)
    SET descuento = precio_base * 0.10;
    
    -- Definir la tasa de IVA (21%)
    SET iva = precio_base * 0.21;
    
    -- Calcular el total
    SET total = precio_base - descuento + iva;
END $$
DELIMITER ;


---- PROCEDIMIENTO QUE LLAMA AL PRIMERO Y MUESTRA LOS RESULTADOS
DELIMITER $$
DROP PROCEDURE IF EXISTS CalculaPrecioDescuentoIvaTotal2$$
CREATE PROCEDURE CalculaPrecioDescuentoIvaTotal2(IN precio_base 
DECIMAL(10,2), OUT descuento DECIMAL(10,2), 
OUT precio_descuento DECIMAL(10,2), OUT iva DECIMAL(10,2), 
OUT total DECIMAL(10,2))
BEGIN
    CALL CalculaDescuentoIvaTotal3(precio_base, descuento, iva, total);
    SELECT @precio_base, @descuento, @precio_descuento, @iva, @total; -- Muestra todos los resultados
END $$
DELIMITER ;

-- LLAMADA AL SEGUNDO PROCEDIMIENTO

SET @precio_base = 1000; -- Establece el precio base
CALL CalculaPrecioDescuentoIvaTotal2(@precio_base, @descuento,
@precio_descuento, @iva, @total); -- Llama al procedimiento y obtén todos los resultados
