use gestion_ventas;

-- Listado de clientes que han realizado algún pedido, sin repetidos y ordenado alfabéticamente
SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2, c.nombre;

-- Listado de todos los pedidos de cada cliente, ordenado alfabéticamente por cliente
SELECT c.id, c.nombre, c.apellido1, c.apellido2, p.*
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2, c.nombre;

-- Listado de todos los pedidos con datos de comerciales, ordenado alfabéticamente por comercial
SELECT co.id, co.nombre, co.apellido1, co.apellido2, p.*
FROM comercial co
JOIN pedido p ON co.id = p.id_comercial
ORDER BY co.apellido1, co.apellido2, co.nombre;

-- Listado de clientes con pedidos y comerciales asociados
SELECT c.*, p.*, co.*
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
JOIN comercial co ON p.id_comercial = co.id
ORDER BY c.apellido1, c.apellido2, c.nombre;

-- Clientes que realizaron un pedido entre 300 € y 1000 € en 2017
SELECT c.id, c.nombre, c.apellido1, c.apellido2
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
WHERE p.cantidad BETWEEN 300 AND 1000 AND YEAR(p.fecha) = 2017;

-- Nombre y apellidos de comerciales que participaron en pedidos de María Santana Moreno
SELECT co.nombre, co.apellido1, co.apellido2
FROM comercial co
JOIN pedido p ON co.id = p.id_comercial
JOIN cliente c ON p.id_cliente = c.id
WHERE c.nombre = 'María' AND c.apellido1 = 'Santana' AND c.apellido2 = 'Moreno';

-- Nombre de clientes que realizaron pedidos con Daniel Sáez Vega
SELECT c.nombre
FROM cliente c
JOIN pedido p ON c.id = p.id_cliente
JOIN comercial co ON p.id_comercial = co.id
WHERE co.nombre = 'Daniel' AND co.apellido1 = 'Sáez' AND co.apellido2 = 'Vega';

-- Listado de clientes con pedidos realizados, incluyendo los que no han pedido nada
SELECT c.nombre, c.apellido1, c.apellido2, p.*
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
ORDER BY c.apellido1, c.apellido2, c.nombre;

-- Listado de comerciales con pedidos realizados, incluyendo los que no han pedido nada
SELECT co.nombre, co.apellido1, co.apellido2, p.*
FROM comercial co
LEFT JOIN pedido p ON co.id = p.id_comercial
ORDER BY co.apellido1, co.apellido2, co.nombre;

-- Listado solamente de clientes que no han realizado ningún pedido
SELECT c.nombre, c.apellido1, c.apellido2
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
WHERE p.id IS NULL;

-- Listado solamente de comerciales que no han realizado ningún pedido
SELECT co.nombre, co.apellido1, co.apellido2
FROM comercial co
LEFT JOIN pedido p ON co.id = p.id_comercial
WHERE p.id IS NULL;

-- Listado de clientes y comerciales que no han participado en ningún pedido
SELECT c.nombre AS Cliente_Nombre, co.nombre AS Comercial_Nombre
FROM cliente c
LEFT JOIN pedido pc ON c.id = pc.id_cliente
RIGHT JOIN comercial co ON pc.id_comercial = co.id
WHERE pc.id IS NULL
UNION
SELECT c.nombre, sco.nombre
FROM comercial co
LEFT JOIN pedido pc ON co.id = pc.id_comercial
RIGHT JOIN cliente c ON pc.id_cliente = c.id
WHERE pc.id IS NULL
ORDER BY Cliente_Nombre, Comercial_Nombre;
-- Justificación del Uso de NATURAL JOIN
-- La cláusula NATURAL JOIN combina filas de dos tablas automáticamente utilizando las columnas que tienen el mismo nombre
-- y tipo en ambas tablas. Para las consultas anteriores, el uso de NATURAL JOIN no sería adecuado sin revisar cuidadosamente los esquemas 