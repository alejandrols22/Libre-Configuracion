use tienda;

-- Número total de productos
SELECT COUNT(*) AS numero_total_productos FROM producto;

-- Número total de fabricantes
SELECT COUNT(*) AS numero_total_fabricantes FROM fabricante;

-- Número de valores distintos de código de fabricante en productos
SELECT COUNT(DISTINCT codigo_fabricante) AS numero_distintos_codigos_fabricante FROM producto;

-- Media del precio de todos los productos
SELECT AVG(precio) AS media_precio_productos FROM producto;

-- Precio más barato de todos los productos
SELECT MIN(precio) AS precio_mas_barato FROM producto;

-- Precio más caro de todos los productos
SELECT MAX(precio) AS precio_mas_caro FROM producto;

-- Nombre y precio del producto más barato
SELECT nombre, precio FROM producto WHERE precio = (SELECT MIN(precio) FROM producto) LIMIT 1;

-- Nombre y precio del producto más caro
SELECT nombre, precio FROM producto WHERE precio = (SELECT MAX(precio) FROM producto) LIMIT 1;

-- Suma de los precios de todos los productos
SELECT SUM(precio) AS suma_precios_productos FROM producto;

-- Número de productos del fabricante Asus
SELECT COUNT(*) AS numero_productos_asus FROM producto WHERE codigo_fabricante = 1;

-- Media del precio de productos del fabricante Asus
SELECT AVG(precio) AS media_precio_asus FROM producto WHERE codigo_fabricante = 1;

-- Precio más barato de productos del fabricante Asus
SELECT MIN(precio) AS precio_mas_barato_asus FROM producto WHERE codigo_fabricante = 1;

-- Precio más caro de productos del fabricante Asus
SELECT MAX(precio) AS precio_mas_caro_asus FROM producto WHERE codigo_fabricante = 1;

-- Suma de los precios de productos del fabricante Asus
SELECT SUM(precio) AS suma_precios_asus FROM producto WHERE codigo_fabricante = 1;

-- Precios máximo, mínimo, medio y número total de productos del fabricante Crucial
SELECT MAX(precio) AS precio_maximo, MIN(precio) AS precio_minimo, AVG(precio) AS precio_medio, COUNT(*) AS numero_total_productos
FROM producto
WHERE codigo_fabricante = 2;

-- Número total de productos por fabricante (incluyendo los que no tienen productos)
SELECT f.nombre AS nombre_fabricante, IFNULL(COUNT(p.codigo_fabricante), 0) AS numero_productos
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo;

-- Precios máximo, mínimo y medio de productos por fabricante
SELECT f.nombre AS nombre_fabricante, MAX(p.precio) AS precio_maximo, MIN(p.precio) AS precio_minimo, AVG(p.precio) AS precio_medio
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo;

-- Precios máximo, mínimo, medio y número total de productos de fabricantes con precio medio superior a 200€
SELECT f.codigo AS codigo_fabricante, MAX(p.precio) AS precio_maximo, MIN(p.precio) AS precio_minimo, AVG(p.precio) AS precio_medio, COUNT(*) AS numero_total_productos
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo
HAVING precio_medio > 200;

-- Nombre, precios máximo, mínimo, medio y número total de productos de fabricantes con precio medio superior a 200€
SELECT f.nombre AS nombre_fabricante, MAX(p.precio) AS precio_maximo, MIN(p.precio) AS precio_minimo, AVG(p.precio) AS precio_medio, COUNT(*) AS numero_total_productos
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo
HAVING precio_medio > 200;

-- Número de productos con precio mayor o igual a 180€
SELECT COUNT(*) AS numero_productos_precio_mayor_igual_180 FROM producto WHERE precio >= 180;

-- Número de productos con precio mayor o igual a 180€ por fabricante
SELECT f.nombre AS nombre_fabricante, COUNT(*) AS numero_productos_precio_mayor_igual_180
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.precio >= 180
GROUP BY f.codigo;

-- Precio medio de productos por fabricante (solo código)
SELECT f.codigo AS codigo_fabricante, AVG(p.precio) AS precio_medio
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo;

-- Precio medio de productos por fabricante (con nombre)
SELECT f.nombre AS nombre_fabricante, AVG(p.precio) AS precio_medio
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo;

-- Nombres de fabricantes con precio medio mayor o igual a 150€
SELECT f.nombre AS nombre_fabricante
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo
HAVING AVG(p.precio) >= 150;

-- Nombres de fabricantes con 2 o más productos
SELECT f.nombre AS nombre_fabricante
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo
HAVING COUNT(p.codigo) >= 2;

-- Nombres de fabricantes y número de productos con precio superior o igual a 220€ (sin incluir los sin productos)
SELECT f.nombre AS nombre_fabricante, COUNT(p.codigo) AS numero_productos
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.precio >= 220
GROUP BY f.codigo
HAVING COUNT(p.codigo) > 0;

-- Nombres de fabricantes y número de productos con precio superior o igual a 220€ (incluyendo los sin productos)
SELECT f.nombre AS nombre_fabricante, IFNULL(COUNT(p.codigo), 0) AS numero_productos
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.precio >= 220
GROUP BY f.codigo;

-- Nombres de fabricantes con suma del precio de todos sus productos superior a 1000€
SELECT f.nombre AS nombre_fabricante
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo
HAVING SUM(p.precio) > 1000;
