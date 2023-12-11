USE gestion_ventas;

-- Consultas sobre una tabla

-- 1. Listado con identificador, nombre y apellidos de clientes que han realizado algún pedido, ordenados alfabéticamente.
SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2, c.nombre;

-- 2. Listado de todos los pedidos realizados por cada cliente.
SELECT c.*, p.*
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.nombre, c.apellido1, c.apellido2;

-- 3. Listado de todos los pedidos en los que ha participado un comercial.
SELECT co.*, p.*
FROM comercial co
JOIN pedido p ON co.id = p.id_comercial
ORDER BY co.apellido1, co.apellido2, co.nombre;

-- 4. Listado de clientes, pedidos y comerciales asociados a cada pedido.
SELECT c.nombre AS nombre_cliente, c.apellido1, c.apellido2, p.*, co.nombre AS nombre_comercial
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
JOIN comercial co ON p.id_comercial = co.id;

-- 5. Listado de clientes con pedidos entre 300 € y 1000 € en 2017.
SELECT c.nombre, c.apellido1, c.apellido2
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
WHERE p.cantidad BETWEEN 300 AND 1000 AND YEAR(p.fecha) = 2017;

-- 6. Nombre y apellidos de comerciales que han participado en pedidos de María Santana Moreno.
SELECT co.nombre, co.apellido1, co.apellido2
FROM comercial co
JOIN pedido p ON co.id = p.id_comercial
JOIN cliente c ON p.id_cliente = c.id
WHERE c.nombre = 'María' AND c.apellido1 = 'Santana' AND c.apellido2 = 'Moreno';

-- 7. Nombre de clientes con pedidos del comercial Daniel Sáez Vega.
SELECT c.nombre
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
JOIN comercial co ON p.id_comercial = co.id
WHERE co.nombre = 'Daniel' AND co.apellido1 = 'Sáez' AND co.apellido2 = 'Vega';

-- Consultas multitabla (Composición externa)

-- 1. Listado de clientes con pedidos, incluyendo clientes sin pedidos.
SELECT c.*, p.*
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2, c.nombre;

-- 2. Listado de comerciales con pedidos, incluyendo comerciales sin pedidos.
SELECT co.*, p.*
FROM comercial co
LEFT JOIN pedido p ON co.id = p.id_comercial
ORDER BY co.apellido1, co.apellido2, co.nombre;

-- 3. Listado de clientes que no han realizado ningún pedido.
SELECT c.*
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
WHERE p.id_cliente IS NULL;

-- 4. Listado de comerciales que no han realizado ningún pedido.
SELECT co.*
FROM comercial co
LEFT JOIN pedido p ON co.id = p.id_comercial
WHERE p.id_comercial IS NULL;

-- 5. Listado de clientes y comerciales que no han realizado ningún pedido.
SELECT c.nombre AS nombre_cliente, c.apellido1 AS apellido1_cliente, c.apellido2 AS apellido2_cliente, 
       co.nombre AS nombre_comercial, co.apellido1 AS apellido1_comercial, co.apellido2 AS apellido2_comercial
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
LEFT JOIN comercial co ON p.id_comercial = co.id
WHERE p.id IS NULL
ORDER BY c.apellido1, c.apellido2, c.nombre, co.apellido1, co.apellido2, co.nombre;

-- 6. Sobre el uso de NATURAL JOIN
-- NATURAL JOIN podría utilizarse en las consultas que implican relaciones directas entre las tablas basadas en columnas con el mismo nombre. 

