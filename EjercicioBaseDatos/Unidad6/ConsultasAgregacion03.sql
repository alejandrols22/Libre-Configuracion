use gestion_ventas;

-- Cantidad total de todos los pedidos en la tabla pedido
SELECT SUM(cantidad) AS cantidad_total_pedidos FROM pedido;

-- Cantidad media de todos los pedidos en la tabla pedido
SELECT AVG(cantidad) AS cantidad_media_pedidos FROM pedido;

-- Número total de comerciales distintos en la tabla pedido
SELECT COUNT(DISTINCT id_comercial) AS total_comerciales_distintos FROM pedido;

-- Número total de clientes en la tabla cliente
SELECT COUNT(*) AS total_clientes FROM cliente;

-- Mayor cantidad en la tabla pedido
SELECT MAX(cantidad) AS mayor_cantidad_pedido FROM pedido;

-- Menor cantidad en la tabla pedido
SELECT MIN(cantidad) AS menor_cantidad_pedido FROM pedido;

-- Valor máximo de categoría para cada ciudad en la tabla cliente
SELECT ciudad, MAX(categoria) AS max_categoria_ciudad FROM cliente GROUP BY ciudad;

-- Máximo valor de los pedidos realizados durante el mismo día para cada cliente
SELECT p.id_cliente, c.nombre, c.apellido1, p.fecha, MAX(p.cantidad) AS max_valor_pedido
FROM pedido p
INNER JOIN cliente c ON p.id_cliente = c.id
GROUP BY p.id_cliente, p.fecha;

-- Máximo valor de los pedidos realizados durante el mismo día para cada cliente (solo los que superan 2000 €)
SELECT p.id_cliente, c.nombre, c.apellido1, p.fecha, MAX(p.cantidad) AS max_valor_pedido
FROM pedido p
INNER JOIN cliente c ON p.id_cliente = c.id
WHERE p.cantidad > 2000
GROUP BY p.id_cliente, p.fecha;

-- Máximo valor de los pedidos realizados por cada comercial en la fecha '2016-08-17'
SELECT p.id_comercial, c.nombre, c.apellido1, c.apellido2, SUM(p.cantidad) AS total
FROM pedido p
INNER JOIN comercial c ON p.id_comercial = c.id
WHERE p.fecha = '2016-08-17'
GROUP BY p.id_comercial;

-- Número total de pedidos realizados por cada cliente (incluyendo los que no han realizado pedidos)
SELECT c.id AS id_cliente, c.nombre, c.apellido1, c.apellido2, IFNULL(COUNT(p.id), 0) AS total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
GROUP BY c.id;

-- Número total de pedidos realizados por cada cliente durante el año 2017
SELECT c.id AS id_cliente, c.nombre, c.apellido1, c.apellido2, IFNULL(COUNT(p.id), 0) AS total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
WHERE YEAR(p.fecha) = 2017
GROUP BY c.id;

-- Máxima cantidad de pedido realizada por cada cliente
SELECT c.id AS id_cliente, c.nombre, c.apellido1, c.apellido2, IFNULL(MAX(p.cantidad), 0) AS maxima_cantidad_pedido
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
GROUP BY c.id;

-- Pedido de máximo valor realizado cada año
SELECT YEAR(p.fecha) AS año, MAX(p.cantidad) AS maximo_valor_pedido
FROM pedido p
GROUP BY YEAR(p.fecha);
