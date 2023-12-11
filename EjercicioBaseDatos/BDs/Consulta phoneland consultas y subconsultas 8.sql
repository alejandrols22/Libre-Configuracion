-- consulta 13
SELECT nombre,precio FROM productos
WHERE precio=(SELECT max(precio) FROM productos);
-- consulta 14
SELECT COUNT(*) AS numProductApple
FROM productos WHERE productos.id_proveedor=(
SELECT proveedores.id_proveedor FROM
proveedores WHERE proveedores.nombre_proveedor="APPLE");
-- consulta 15
SELECT 
MAX(precio) AS precioMaxXiaomi,
MIN(PRECIO) AS precioMinXioami,
ROUND(AVG(PRECIO),2) AS precioMedXioami,
COUNT(*) AS numProductosXioami
FROM productos
WHERE productos.id_proveedor=
(SELECT id_proveedor FROM proveedores
WHERE proveedores.nombre_proveedor="XIAOMI");

-- muestra el nombre de los clientes que han realizado
-- compras con un precio promedio por encima
-- del promedio de todos los productos

SELECT nombre AS NOMBRE_CLIENTES
FROM clientes
WHERE id_clientes 
IN (SELECT id_clientes 
FROM ventas JOIN productos
ON productos.id_PRODUCTO=ventas.id_productos
 GROUP BY ventas.id_productos
 HAVING AVG(productos.PRECIO)>(
 SELECT AVG(precio) FROM productos))
 ;
 
 
 SELECT ventas.Id_CLIENTES, precio FROM ventas 
 INNER JOIN productos 
 ON productos.id_PRODUCTO=ventas.id_PRODUCTOS
 ;
 SELECT AVG(precio) FROM productos;
 
 -- consulta y subconsulta clientes compras por encima del precio medio
 
 SELECT c.nombre AS nombre_cliente
FROM clientes c
WHERE c.id_clientes IN (
  SELECT v.id_clientes
  FROM ventas v
  JOIN productos p ON v.id_PRODUCTOS= p.id_PRODUCTO
  GROUP BY v.id_PRODUCTOS
  HAVING AVG(p.precio) > (
    SELECT AVG(precio) FROM productos
  )
);

 
 
 -- la consulta anterior da error, solo cinco nombre esta es correcta
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


-- precio medio productos

SELECT AVG(precio) FROM productos;

-- variación en la que sale el precio medio de compras

SELECT c.nombre AS nombre_cliente, round(AVG(p.precio),2) AS precio_medio_compra
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
GROUP BY c.nombre;


-- comprobacion

SELECT max(clientes.NOMBRE), round(avg(precio)) FROM productos
JOIN ventas
on
ventas.id_PRODUCTOS=productos.id_PRODUCTO
JOIN clientes
ON
clientes.Id_CLIENTES=ventas.Id_CLIENTES
GROUP BY ventas.Id_CLIENTES


 
 
 
 
 
 














