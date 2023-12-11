use tienda;

-- Consultas SQL para la base de datos BDTienda con estructura actualizada

-- 1. Lista el nombre de todos los productos
SELECT nombre FROM producto;

-- 2. Lista los nombres y los precios de todos los productos
SELECT nombre, precio FROM producto;

-- 3. Lista todas las columnas de la tabla producto
SELECT * FROM producto;

-- 4. Lista el nombre de los productos y el precio en euros y USD
SELECT nombre, precio, precio * 1.1 AS precio_usd FROM producto;  -- Asumiendo un tipo de cambio ficticio de 1.1

-- 5. Lista con alias para nombre, euros y dólares
SELECT nombre AS 'nombre de producto', precio AS euros, precio * 1.1 AS dólares FROM producto;  -- Asumiendo un tipo de cambio ficticio de 1.1

-- 6. Lista nombres en mayúsculas y precios
SELECT UPPER(nombre) AS nombre, precio FROM producto;

-- 7. Lista nombres en minúsculas y precios
SELECT LOWER(nombre) AS nombre, precio FROM producto;

-- 8. Lista código de fabricantes con productos
SELECT DISTINCT codigo_fabricante FROM producto;

-- 9. Lista nombres y precios redondeados
SELECT nombre, ROUND(precio) AS precio_redondeado FROM producto;

-- 10. Lista nombres y precios truncados
SELECT nombre, TRUNCATE(precio, 0) AS precio_truncado FROM producto;

-- 11. Lista nombres de fabricantes ordenados ascendente
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- 12. Lista nombres de fabricantes ordenados descendente
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 13. Lista nombres de productos ordenados por nombre ascendente y precio descendente
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;

-- 14. Primeras 5 filas de la tabla fabricante
SELECT * FROM fabricante LIMIT 5;

-- 15. 2 filas a partir de la cuarta fila de la tabla fabricante
SELECT * FROM fabricante LIMIT 3, 2;

-- 16. Producto más barato
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 17. Producto más caro
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 18. Productos del fabricante con código 2
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 19. Productos con precio ≤ 120€
SELECT nombre FROM producto WHERE precio <= 120;

-- 20. Productos con precio ≥ 400€
SELECT nombre FROM producto WHERE precio >= 400;

-- 21. Productos con precio < 400€
SELECT nombre FROM producto WHERE precio < 400;

-- 22. Productos con precio entre 80€ y 300€ sin BETWEEN
SELECT nombre FROM producto WHERE precio >= 80 AND precio <= 300;

-- 23. Productos con precio entre 60€ y 200€ con BETWEEN
SELECT nombre FROM producto WHERE precio BETWEEN 60 AND 200;

-- 24. Productos con precio > 200€ y fabricante 6
SELECT nombre FROM producto WHERE precio > 200 AND codigo_fabricante = 6;

-- 25. Productos con fabricante 1, 3 o 5 sin IN
SELECT nombre FROM producto WHERE codigo_fabricante = 1 OR codigo_fabricante = 3 OR codigo_fabricante = 5;

-- 26. Productos con fabricante 1, 3 o 5 con IN
SELECT nombre FROM producto WHERE codigo_fabricante IN (1, 3, 5);

-- 27. Precio de productos en céntimos
SELECT nombre, precio * 100 AS céntimos FROM producto;

-- 28. Fabricantes que empiezan con S
SELECT nombre FROM fabricante WHERE nombre LIKE 'S%';

-- 29. Fabricantes que terminan en e
SELECT nombre FROM fabricante WHERE nombre LIKE '%e';

-- 30. Fabricantes con 'w' en el nombre
SELECT nombre FROM fabricante WHERE nombre LIKE '%w%';

-- 31. Fabricantes con nombre de 4 caracteres
SELECT nombre FROM fabricante WHERE LENGTH(nombre) = 4;

-- 32. Productos con 'Portátil' en el nombre
SELECT nombre FROM producto WHERE nombre LIKE '%Portátil%';

-- 33. Productos con 'Monitor' en el nombre y precio < 215€
SELECT nombre FROM producto WHERE nombre LIKE '%Monitor%' AND precio < 215;

-- 34. Productos con precio ≥ 180€ ordenados por precio descendente y nombre ascendente
SELECT nombre, precio FROM producto WHERE precio >= 180 ORDER BY precio DESC, nombre ASC;
