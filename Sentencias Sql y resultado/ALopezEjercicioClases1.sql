use ahora7;

SELECT
	LOWER(nombre)
FROM clientes;

SELECT nombre 
	FROM clientes 
WHERE nombre LIKE 'a%';

SELECT
	SUBSTR(nombre, 2, LENGTH(nombre)) AS Nombre_cliente
FROM CLIENTES;

SELECT distinct ventas.idproductos
FROM ventas;

SELECT *
	FROM clientes
WHERE nombre not LIKE '________';
SELECT * FROM clientes ;

SELECT * FROM clientes 
WHERE nombre IS NOT NULL;

SELECT COUNT(DISTINCT productos.idfabricante) AS unico
FROM productos;

SELECT c.IdClientes, v.fecha_Ventas
FROM clientes c
INNER JOIN ventas v
ON c.Idclientes = v.Idclientes;

SELECT 
    c.nombre AS nombre_cliente, 
    p.nombre_producto AS nombre_producto, 
    p.precio * 1.21 AS precio_con_IVA, 
    v.fecha_Ventas AS fecha_venta
FROM ventas AS v
INNER JOIN clientes AS c ON v.idclientes = c.idclientes
INNER JOIN productos AS p ON v.idproductos = p.idproducto;

SELECT c.nombre AS nombre_cliente, p.nombre_producto AS nombre_producto, v.fecha_Ventas AS fecha_venta
FROM ventas AS v
INNER JOIN clientes AS c ON v.idclientes = c.idclientes
INNER JOIN productos AS p ON v.idproductos = p.idproducto;

SELECT 
    p.nombre_producto AS nombre_producto, 
    p.precio  AS precio_normal,
    p.precio * 1.21 AS precio_con_IVA
FROM productos AS p
INNER JOIN ventas AS v ON p.idproducto = v.idproductos
GROUP BY p.idproducto, p.nombre_producto, p.precio;

SELECT c.IdClientes, v.fecha_Ventas, p.Precio, 
round(p.precio*@iva, 0) as iva,
round(precio +@iva,0) AS total
FROM clientes c
INNER JOIN ventas v
ON c.IdClientes= v.IdClientes
INNER JOIN productos p
ON p.IdProductos = v.IdProductos;

SET @iva:=0.21;
SELECT 
    c.IdClientes, 
    v.fecha_Ventas, 
    p.Precio, 
    ROUND(p.precio + (p.precio * @iva), 0) AS precio_iva,
    ROUND(p.precio + (p.precio * @iva)) AS total,
    SUBSTR(p.nombre_producto, LENGTH(p.nombre_producto)-10) AS ultimos_10_caracteres
FROM clientes c
	INNER JOIN ventas v ON c.IdClientes = v.IdClientes
	INNER JOIN productos p ON p.idproducto = v.idproductos;

SELECT ventas.IdClientes, clientes.Nombre
FROM clientes INNER JOIN ventas
ON clientes.IdClientes = ventas.IdClientes
GROUP BY ventas.IdClientes
HAVING COUNT(*) >= 3;


