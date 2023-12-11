use jardineria;

-- Consultas SQL para la base de datos Jardinería con la estructura proporcionada

-- 1. Código de oficina y ciudad donde hay oficinas
SELECT codigo_oficina, ciudad FROM oficina;

-- 2. Ciudad y teléfono de las oficinas de España
SELECT ciudad, telefono FROM oficina WHERE pais = 'España';

-- 3. Nombre, apellidos y email de los empleados cuyo jefe tiene código 7
SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe = 7;

-- 4. Nombre del puesto, nombre, apellidos y email del jefe de la empresa
-- (Suponiendo que el jefe de la empresa es el empleado con el menor código_empleado)
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigo_jefe IS NULL;

-- 5. Nombre, apellidos y puesto de empleados que no son representantes de ventas
SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE puesto != 'Representante de Ventas';

-- 6. Nombre de todos los clientes españoles
SELECT nombre_cliente FROM cliente WHERE pais = 'España';

-- 7. Distintos estados de los pedidos
SELECT DISTINCT estado FROM pedido;

-- 8. Código de cliente que realizaron pagos en 2008
-- Utilizando YEAR
SELECT DISTINCT codigo_cliente FROM pago WHERE YEAR(fecha_pago) = 2008;
-- Utilizando DATE_FORMAT
SELECT DISTINCT codigo_cliente FROM pago WHERE DATE_FORMAT(fecha_pago, '%Y') = '2008';
-- Sin utilizar funciones de fecha
SELECT DISTINCT codigo_cliente FROM pago WHERE fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';

-- 9. Pedidos no entregados a tiempo
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega > fecha_esperada;

-- 10. Pedidos entregados al menos dos días antes de lo esperado
-- Utilizando ADDDATE
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE fecha_entrega <= ADDDATE(fecha_esperada, INTERVAL -2 DAY);
-- Utilizando DATEDIFF
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega FROM pedido WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;

-- 11. Pedidos rechazados en 2009
SELECT * FROM pedido WHERE estado = 'Rechazado' AND YEAR(fecha_pedido) = 2009;

-- 12. Pedidos entregados en enero de cualquier año
SELECT * FROM pedido WHERE MONTH(fecha_entrega) = 1;

-- 13. Pagos realizados en 2008 mediante Paypal
SELECT * FROM pago WHERE forma_pago = 'Paypal' AND YEAR(fecha_pago) = 2008 ORDER BY total DESC;

-- 14. Todas las formas de pago sin repetir
SELECT DISTINCT forma_pago FROM pago;

-- 15. Productos de la gama Ornamentales con más de 100 unidades en stock
SELECT * FROM producto WHERE gama = 'Ornamentales' AND cantidad_en_stock > 100 ORDER BY precio_venta DESC;

-- 16. Clientes de Madrid con representante de ventas 11 o 30
SELECT 
    *
FROM
    cliente
WHERE
    ciudad = 'Madrid'
        AND codigo_empleado_rep_ventas IN (11 , 30);
