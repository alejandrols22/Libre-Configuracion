use jardineria;

-- 1. Listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codigoOficina, ciudad FROM oficina;

-- 2. Listado con la ciudad y el teléfono de las oficinas de España.
SELECT ciudad, telefono FROM oficina WHERE pais = 'España';

-- 3. Listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email FROM empleado WHERE codigoJefe = 7;

-- 4. Nombre del puesto, nombre, apellidos y email del jefe de la empresa.
-- Asumiendo que el jefe de la empresa tiene un código de jefe específico o es NULL
SELECT puesto, nombre, apellido1, apellido2, email FROM empleado WHERE codigoJefe IS NULL;

-- 5. Listado con el nombre, apellidos y puesto de empleados que no son representantes de ventas.
SELECT nombre, apellido1, apellido2, puesto FROM empleado WHERE puesto != 'Representante de ventas';

-- 6. Listado con el nombre de todos los clientes españoles.
SELECT nombre FROM cliente WHERE pais = 'España';

-- 7. Listado con los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT estado FROM pedido;

-- 8. Código de cliente de clientes que realizaron algún pago en 2008.
-- a. Utilizando YEAR
SELECT DISTINCT codigoCliente FROM pago WHERE YEAR(fecha) = 2008;
-- b. Utilizando DATE_FORMAT
SELECT DISTINCT codigoCliente FROM pago WHERE DATE_FORMAT(fecha, '%Y') = '2008';
-- c. Sin utilizar funciones de fecha
SELECT DISTINCT codigoCliente FROM pago WHERE fecha BETWEEN '2008-01-01' AND '2008-12-31';

-- 9. Código de pedido, código de cliente, fecha esperada y fecha de entrega de pedidos no entregados a tiempo.
SELECT codigoPedido, codigoCliente, fechaEsperada, fechaEntrega FROM pedido WHERE fechaEntrega > fechaEsperada;

-- 10. Código de pedido, código de cliente, fecha esperada y fecha de entrega de pedidos entregados al menos dos días antes.
-- a. Utilizando ADDDATE
SELECT codigoPedido, codigoCliente, fechaEsperada, fechaEntrega FROM pedido WHERE fechaEntrega <= ADDDATE(fechaEsperada, INTERVAL -2 DAY);
-- b. Utilizando DATEDIFF
SELECT codigoPedido, codigoCliente, fechaEsperada, fechaEntrega FROM pedido WHERE DATEDIFF(fechaEsperada, fechaEntrega) >= 2;

-- 11. Listado de todos los pedidos rechazados en 2009.
SELECT * FROM pedido WHERE estado = 'Rechazado' AND YEAR(fecha) = 2009;

-- 12. Listado de todos los pedidos entregados en enero de cualquier año.
SELECT * FROM pedido WHERE MONTH(fechaEntrega) = 1;

-- 13. Listado con todos los pagos realizados en 2008 mediante Paypal, ordenados de mayor a menor.
SELECT * FROM pago WHERE YEAR(fecha) = 2008 AND formaPago = 'Paypal' ORDER BY cantidad DESC;

-- 14. Listado con todas las formas de pago en la tabla pago, sin repetir.
SELECT DISTINCT formaPago FROM pago;

-- 15. Productos de la gama Ornamentales con más de 100 unidades en stock, ordenados por precio de venta.
SELECT * FROM producto WHERE gama = 'Ornamentales' AND stock > 100 ORDER BY precioVenta DESC;

-- 16. Clientes de Madrid cuyo representante de ventas tenga el código 11 o 30.
SELECT nombre FROM cliente WHERE ciudad = 'Madrid' AND codigoEmpleadoRepVentas IN (11, 30);


-- Consultas multitabla (Composición interna)

-- 1. Nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT c.nombre AS nombreCliente, e.nombre AS nombreEmpleado, e.apellido1, e.apellido2
FROM cliente c
INNER JOIN empleado e ON c.codigoEmpleadoRepVentas = e.codigo;

-- 2. Nombre de los clientes que han realizado pagos y nombre de sus representantes de ventas.
SELECT DISTINCT c.nombre AS nombreCliente, e.nombre AS nombreEmpleado, e.apellido1, e.apellido2
FROM cliente c
INNER JOIN empleado e ON c.codigoEmpleadoRepVentas = e.codigo
INNER JOIN pago p ON c.codigo = p.codigoCliente;

-- 3. Nombre de los clientes que no han realizado pagos y nombre de sus representantes de ventas.
SELECT c.nombre AS nombreCliente, e.nombre AS nombreEmpleado, e.apellido1, e.apellido2
FROM cliente c
LEFT JOIN pago p ON c.codigo = p.codigoCliente
INNER JOIN empleado e ON c.codigoEmpleadoRepVentas = e.codigo
WHERE p.codigoCliente IS NULL;

-- 4. Nombre de los clientes que han hecho pagos y nombre de sus representantes junto con la ciudad de la oficina.
SELECT c.nombre AS nombreCliente, e.nombre AS nombreEmpleado, e.apellido1, e.apellido2, o.ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigoEmpleadoRepVentas = e.codigo
INNER JOIN oficina o ON e.codigoOficina = o.codigo
INNER JOIN pago p ON c.codigo = p.codigoCliente;

-- 5. Nombre de los clientes que no han hecho pagos y nombre de sus representantes junto con la ciudad de la oficina.
SELECT c.nombre AS nombreCliente, e.nombre AS nombreEmpleado, e.apellido1, e.apellido2, o.ciudad
FROM cliente c
LEFT JOIN pago p ON c.codigo = p.codigoCliente
INNER JOIN empleado e ON c.codigoEmpleadoRepVentas = e.codigo
INNER JOIN oficina o ON e.codigoOficina = o.codigo
WHERE p.codigoCliente IS NULL;

-- 6. Dirección de las oficinas que tienen clientes en Fuenlabrada.
SELECT o.direccion
FROM oficina o
INNER JOIN empleado e ON o.codigo = e.codigoOficina
INNER JOIN cliente c ON e.codigo = c.codigoEmpleadoRepVentas
WHERE c.ciudad = 'Fuenlabrada';

-- 7. Nombre de los clientes y nombre de sus representantes junto con la ciudad de la oficina.
SELECT c.nombre AS nombreCliente, e.nombre AS nombreEmpleado, e.apellido1, e.apellido2, o.ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigoEmpleadoRepVentas = e.codigo
INNER JOIN oficina o ON e.codigoOficina = o.codigo;

-- 8. Nombre de los empleados junto con el nombre de sus jefes.
SELECT e.nombre AS nombreEmpleado, j.nombre AS nombreJefe
FROM empleado e
LEFT JOIN empleado j ON e.codigoJefe = j.codigo;

-- 9. Nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
SELECT c.nombre
FROM cliente c
INNER JOIN pedido p ON c.codigo = p.codigoCliente
WHERE p.fechaEntrega > p.fechaEsperada;

-- 10. Diferentes gamas de producto compradas por cada cliente.
SELECT c.nombre AS nombreCliente, p.gama
FROM cliente c
INNER JOIN pedido pe ON c.codigo = pe.codigoCliente
INNER JOIN detallePedido dp ON pe.codigo = dp.codigoPedido
INNER JOIN producto p ON dp.codigoProducto = p.codigo;

-- Consultas multitabla (Composición externa)

-- 1. Clientes que no han realizado ningún pago.
SELECT c.*
FROM cliente c
LEFT JOIN pago p ON c.codigo = p.codigoCliente
WHERE p.codigoCliente IS NULL;

-- 2. Clientes que no han realizado ningún pedido.
SELECT c.*
FROM cliente c
LEFT JOIN pedido p ON c.codigo = p.codigoCliente
WHERE p.codigoCliente IS NULL;

-- 3. Clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
SELECT c.*
FROM cliente c
LEFT JOIN pago pa ON c.codigo = pa.codigoCliente
LEFT JOIN pedido pe ON c.codigo = pe.codigoCliente
WHERE pa.codigoCliente IS NULL AND pe.codigoCliente IS NULL;

-- 4. Empleados que no tienen una oficina asociada.
SELECT e.*
FROM empleado e
LEFT JOIN oficina o ON e.codigoOficina = o.codigo
WHERE o.codigo IS NULL;

-- 5. Empleados que no tienen un cliente asociado.
SELECT e.*
FROM empleado e
LEFT JOIN cliente c ON e.codigo = c.codigoEmpleadoRepVentas
WHERE c.codigoEmpleadoRepVentas IS NULL;

-- 6. Empleados que no tienen un jefe asociado y los que no tienen un cliente asociado.
SELECT e.*
FROM empleado e
LEFT JOIN empleado j ON e.codigoJefe = j.codigo
LEFT JOIN cliente c ON e.codigo = c.codigoEmpleadoRepVentas
WHERE j.codigo IS NULL AND c.codigoEmpleadoRepVentas IS NULL;