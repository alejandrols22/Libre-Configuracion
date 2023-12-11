use jardineria;

-- Cuántos empleados hay en la compañía
SELECT COUNT(*) AS total_empleados FROM empleado;

-- Cuántos clientes tiene cada país
SELECT pais, COUNT(*) AS total_clientes_por_pais
FROM cliente
GROUP BY pais;

-- Pago medio en 2009
SELECT AVG(total) AS pago_medio_2009
FROM pago
WHERE YEAR(fecha_pago) = 2009;

-- Cuántos pedidos hay en cada estado, ordenados de forma descendente
SELECT estado, COUNT(*) AS total_pedidos
FROM pedido
GROUP BY estado
ORDER BY total_pedidos DESC;

-- Precio de venta del producto más caro y más barato
SELECT MAX(precio_venta) AS precio_producto_mas_caro, MIN(precio_venta) AS precio_producto_mas_barato
FROM producto;

-- Número de clientes
SELECT COUNT(*) AS total_clientes FROM cliente;

-- Cuántos clientes tiene la ciudad de Madrid
SELECT COUNT(*) AS clientes_en_Madrid
FROM cliente
WHERE ciudad = 'Madrid';

-- Cuántos clientes tiene cada una de las ciudades que empiezan por M
SELECT SUBSTRING(ciudad, 1, 1) AS letra_inicial_ciudad, COUNT(*) AS total_clientes
FROM cliente
WHERE ciudad LIKE 'M%'
GROUP BY letra_inicial_ciudad;

-- Nombre de los representantes de ventas y el número de clientes que atiende cada uno
SELECT CONCAT(e.nombre, ' ', e.apellido1) AS representante_ventas, COUNT(c.codigo_cliente) AS clientes_atendidos
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
GROUP BY e.codigo_empleado;

-- Número de clientes sin representante de ventas
SELECT COUNT(*) AS clientes_sin_representante
FROM cliente
WHERE codigo_empleado_rep_ventas IS NULL;

-- Fecha del primer y último pago realizado por cada cliente
SELECT c.nombre_cliente, c.apellido_contacto, MIN(p.fecha_pago) AS primer_pago, MAX(p.fecha_pago) AS ultimo_pago
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
GROUP BY c.codigo_cliente;

-- Número de productos diferentes en cada pedido y suma de la cantidad total de productos en cada pedido
SELECT dp.codigo_pedido, COUNT(dp.codigo_producto) AS productos_diferentes, SUM(dp.cantidad) AS cantidad_total_productos
FROM detalle_pedido dp
GROUP BY dp.codigo_pedido;

-- Listado de los 20 productos más vendidos y el número total de unidades vendidas
SELECT p.nombre, SUM(dp.cantidad) AS unidades_vendidas
FROM detalle_pedido dp
INNER JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY p.codigo_producto, p.nombre
ORDER BY unidades_vendidas DESC
LIMIT 20;

-- Facturación de la empresa (base imponible, IVA y total)
SELECT
    SUM(dp.cantidad * p.precio_venta) AS base_imponible,
    SUM(dp.cantidad * p.precio_venta) * 0.21 AS IVA,
    SUM(dp.cantidad * p.precio_venta) + (SUM(dp.cantidad * p.precio_venta) * 0.21) AS total_facturado
FROM detalle_pedido dp
INNER JOIN producto p ON dp.codigo_producto = p.codigo_producto;

-- Facturación por código de producto (base imponible, IVA y total) 
SELECT
    dp.codigo_producto,
    SUM(dp.cantidad * p.precio_venta) AS base_imponible,
    SUM(dp.cantidad * p.precio_venta) * 0.21 AS IVA,
    SUM(dp.cantidad * p.precio_venta) + (SUM(dp.cantidad * p.precio_venta) * 0.21) AS total_facturado
FROM detalle_pedido dp
GROUP BY dp.codigo_producto;

-- Facturación por código de producto (filtrada por códigos que empiezan por OR)
SELECT
    dp.codigo_producto,
    SUM(dp.cantidad * p.precio_venta) AS base_imponible,
    SUM(dp.cantidad * p.precio_venta) * 0.21 AS IVA,
    SUM(dp.cantidad * p.precio_venta) + (SUM(dp.cantidad * p.precio_venta) * 0.21) AS total_facturado
FROM detalle_pedido dp
WHERE dp.codigo_producto LIKE 'OR%'
GROUP BY dp.codigo_producto;

-- Ventas totales de productos que han facturado más de 3000 euros
SELECT
    p.nombre AS nombre_producto,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.cantidad * p.precio_venta) AS total_facturado_sin_IVA,
    SUM(dp.cantidad * p.precio_venta) * 1.21 AS total_facturado_con_IVA
FROM detalle_pedido dp
INNER JOIN producto p ON dp.codigo_producto = p.codigo_producto
GROUP BY p.codigo_producto, p.nombre
HAVING total_facturado_sin_IVA > 3000;
