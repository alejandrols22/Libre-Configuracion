use tienda;

-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre FROM producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;

-- 3. Lista todas las columnas de la tabla producto.
SELECT * FROM producto;

-- 4. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
SELECT nombre, precio, precio * 1.13 AS precio_usd FROM producto;

-- 5. Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). 
--    Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
SELECT nombre AS "nombre de producto", precio AS euros, precio * 1.13 AS dólares FROM producto;

-- 6. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
SELECT UPPER(nombre) AS nombre, precio FROM producto;

-- 7. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
SELECT LOWER(nombre) AS nombre, precio FROM producto;

-- 8. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS iniciales FROM fabricante;

-- 9. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre, ROUND(precio) AS precio_redondeado FROM producto;

-- 10. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
SELECT nombre, TRUNCATE(precio, 0) AS precio_truncado FROM producto;

-- 11. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT DISTINCT codigo_fabricante FROM producto;

-- 12. Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.
--    Nota: DISTINCT ya elimina los duplicados por sí mismo.
SELECT DISTINCT codigo_fabricante FROM producto;

-- 13. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante ORDER BY nombre;

-- 14. Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;

-- 16. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante LIMIT 5;

-- 17. Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.
SELECT * FROM fabricante LIMIT 3, 2;

-- 18. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 19. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20. Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 21. Lista el nombre de los productos que tienen un precio menor o igual a 120€.
SELECT nombre FROM producto WHERE precio <= 120;

-- 22. Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
SELECT nombre FROM producto WHERE precio >= 400;

-- 23. Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
SELECT nombre FROM producto WHERE precio < 400;

-- 24. Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
SELECT nombre FROM producto WHERE precio >= 80 AND precio <= 300;

-- 25. Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
SELECT nombre FROM producto WHERE precio BETWEEN 60 AND 200;

-- 26. Lista todos los productos que tengan un precio mayor que 200€ y que el código de fabricante sea igual a 6.
SELECT nombre FROM producto WHERE precio > 200 AND codigo_fabricante = 6;

-- 27. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
SELECT nombre FROM producto WHERE codigo_fabricante = 1 OR codigo_fabricante = 3 OR codigo_fabricante = 5;

-- 28. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT nombre FROM producto WHERE codigo_fabricante IN (1, 3, 5);

-- 29. Lista el nombre y el precio de los productos en céntimos (Habrá que multiplicar por 100 el valor del precio). 
--    Cree un alias para la columna que contiene el precio que se llame céntimos.
SELECT nombre, precio * 100 AS céntimos FROM producto;

-- 30. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
SELECT nombre FROM fabricante WHERE nombre LIKE 'S%';

-- 31. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
SELECT nombre FROM fabricante WHERE nombre LIKE '%e';

-- 32. Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
SELECT nombre FROM fabricante WHERE nombre LIKE '%w%';

-- 33. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
SELECT nombre FROM fabricante WHERE LENGTH(nombre) = 4;

-- 34. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT nombre FROM producto WHERE nombre LIKE '%Portátil%';

-- 35. Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
SELECT nombre FROM producto WHERE nombre LIKE '%Monitor%' AND precio < 215;

-- 36. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. 
--    Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
SELECT nombre, precio
FROM producto
WHERE precio >= 180
ORDER BY precio DESC, nombre ASC;


-- Consulta multitapla (composición interna)

-- 1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
--    Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY f.nombre;

-- 3. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT p.codigo AS codigo_producto, p.nombre AS nombre_producto, f.codigo AS codigo_fabricante, f.nombre AS nombre_fabricante
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 4. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio ASC
LIMIT 1;

-- 5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
ORDER BY p.precio DESC
LIMIT 1;

-- 6. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT p.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';

-- 7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT p.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Crucial' AND p.precio > 200;

-- 8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
SELECT p.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';

-- 9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.
SELECT p.nombre
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');

-- 10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
SELECT p.nombre, p.precio
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%e';

-- 11. Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
SELECT p.nombre, p.precio
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre LIKE '%w%';

-- 12. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€.
--    Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
SELECT p.nombre AS nombre_producto, p.precio, f.nombre AS nombre_fabricante
FROM producto p
INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

-- 13. Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
SELECT DISTINCT f.codigo, f.nombre
FROM fabricante f
INNER JOIN producto p ON f.codigo = p.codigo_fabricante
ORDER BY f.nombre;

-- Consulta multitapla (composición externa)

-- Listado de todos los fabricantes junto con sus productos, incluyendo fabricantes sin productos:

SELECT f.nombre AS nombre_fabricante, p.nombre AS nombre_producto
FROM fabricantes f
LEFT JOIN productos p ON f.id = p.fabricante_id
ORDER BY f.nombre, p.nombre;

-- Listado de fabricantes que no tienen ningún producto asociado:

SELECT f.nombre
FROM fabricantes f
LEFT JOIN productos p ON f.id = p.fabricante_id
WHERE p.fabricante_id IS NULL
ORDER BY f.nombre;

-- ¿Pueden existir productos que no estén relacionados con un fabricante? 
-- La respuesta depende del esquema de la base de datos y las restricciones definidas en ella. Si el campo fabricante_id en la tabla productos permite 
-- valores nulos (es decir, no tiene una restricción NOT NULL), entonces es posible tener productos que no estén relacionados con ningún fabricante. 
-- Esto podría ser útil en escenarios donde se ingresan productos antes de asignarles un fabricante o si algunos productos no necesitan estar asociados a un fabricante específico.

-- Por otro lado, si el campo fabricante_id en productos es una clave foránea obligatoria (con una restricción NOT NULL), entonces no podrían existir productos sin un fabricante 
-- asociado. En este caso, cada producto debe tener un fabricante_id válido que corresponda a un id en la tabla fabricantes.
