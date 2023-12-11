use tienda;

-- Devuelve todos los productos del fabricante Lenovo
SELECT * FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo
SELECT * FROM producto
WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- Lista el nombre del producto más caro del fabricante Lenovo
SELECT nombre FROM producto
WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- Lista el nombre del producto más barato del fabricante Hewlett-Packard
SELECT nombre FROM producto
WHERE precio = (SELECT MIN(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard'));

-- Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo
SELECT * FROM producto
WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos
SELECT * FROM producto
WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus')
AND precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'));
