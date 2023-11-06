use nuevodb;

-- 1. Calcula el numero total de productos que hay en la tabla productos.
SELECT COUNT(*) AS TotalProductos FROM productos;
-- 2. Calcula el numero total de fabricantes que hay en la tabla fabricante.
SELECT COUNT(DISTINCT id_proveedor) AS TotalFabricantes FROM productos;

-- 3
SELECT COUNT(DISTINCT id_proveedor) AS ValoresDistintosproveedor FROM productos;
-- 4
SELECT AVG(precio) AS MediaPrecio From productos;


-- 7 Lista el nombre y el precio del producto mas barato
SELECT NOMBRE, PRECIO FROM productos 
WHERE precio=(SELECT MIN(precio) FROM productos);
-- Lista el nombre y el precio del producto mas barato
SELECT NOMBRE, PRECIO FROM productos 
WHERE precio=(SELECT MAX(precio) FROM productos);

-- Calcular el numero de productos que tiene apple pero con consulta y subconsulta
SELECT COUNT(*) AS numProductApple
FROM productos WHERE productos.id_proveedor=(
SELECT proveedores.id_proveedor FROM
proveedores WHERE proveedores.nombre_proveedor="APPLE");

-- Xiaomi
SELECT MIN(precio) AS precioMinXiaomi
FROM productos
WHERE productos.id_proveedor =
(SELECT id_proveedor FROM proveedores
WHERE proveedores.nombre_proveedor="MICROSOFT");

-- Calcular la suma de todos los productos de Apple

SELECT id_proveedor 
FROM proveedores 
WHERE nombre_proveedor = 'Apple';

SELECT SUM(CAST(precio AS DECIMAL(10,2))) AS TotalAppleProductsPrice
FROM productos
WHERE id_proveedor = (
    SELECT id_proveedor 
    FROM proveedores 
    WHERE nombre_proveedor = 'Apple'
);

-- Seleccionar precio medio minimo y medio de apple

SELECT 
MAX(precio) AS precioMaxApple,
MIN(precio) AS precioMinApple,
ROUND (AVG(precio),2) AS precioMedApple,
COUNT(*) AS numProdcutosApple
FROM productos
WHERE productos.id_proveedor=
(SELECT id_proveedor FROM proveedores
WHERE proveedores.nombre_proveedor="APPLE");

-- muestra el nombre de los clienets que ha comprado con un precio pormedio por encima de el precio promedio de todos los productos
/*
SELECT nombre FROM NOMBRE_CLIENTES
FROM clientes
WHERE id_clientes
IN (SELECT id_clientes
FROM ventas INNER JOIN productos
ON productos.id_PRODUCTO=ventas.id_producto
	GROUP BY ventas.id_productos
    HAVING avg(productos.PRECIO)>(
    SELECT AVG(precio) FROM productos))
    ;
    
    
    SELECT vebtas.id_CLIENTES, percio FROm ventas
    INNER JOIN productos
    ON productos.id_PRODUCTO.v
*/

SELECT clientes.NOMBRE, AVG(CAST(productos.precio AS DECIMAL(10,2))) AS AvgClientPurchasePrice
FROM clientes
JOIN ventas ON clientes.Id_CLIENTES = ventas.Id_CLIENTES
JOIN productos ON ventas.id_PRODUCTOS = productos.id_PRODUCTO
GROUP BY clientes.Id_CLIENTES, clientes.NOMBRE
HAVING AvgClientPurchasePrice > (
    SELECT AVG(CAST(precio AS DECIMAL(10,2))) 
    FROM productos
);

