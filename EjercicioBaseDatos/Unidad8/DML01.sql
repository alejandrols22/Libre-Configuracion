use tienda;

-- Inserta un nuevo fabricante indicando su código y su nombre
INSERT INTO fabricante (codigo, nombre)
VALUES (11, 'Nuevo Fabricante 1');

-- Inserta un nuevo fabricante indicando solamente su nombre
INSERT INTO fabricante (nombre)
VALUES ('Nuevo Fabricante 2');

-- Inserta un nuevo producto asociado a uno de los nuevos fabricantes
INSERT INTO producto (codigo, nombre, precio, codigo_fabricante)
VALUES (101, 'Nuevo Producto 1', 299.99, 11);

-- Inserta un nuevo producto asociado a uno de los nuevos fabricantes
INSERT INTO producto (nombre, precio, codigo_fabricante)
VALUES ('Nuevo Producto 2', 199.99, 12);

-- Crea una nueva tabla fabricante_productos y copia los registros de la tabla tienda en ella
CREATE TABLE fabricante_productos AS
SELECT f.nombre AS nombre_fabricante, p.nombre AS nombre_producto, p.precio
FROM fabricante AS f
JOIN producto AS p ON f.codigo = p.codigo_fabricante;

-- Elimina el fabricante Asus si no tiene productos asociados
DELETE FROM fabricante WHERE nombre = 'Asus' AND codigo NOT IN (SELECT DISTINCT codigo_fabricante FROM producto);

-- Elimina el fabricante Xiaomi si no tiene productos asociados
DELETE FROM fabricante WHERE nombre = 'Xiaomi' AND codigo NOT IN (SELECT DISTINCT codigo_fabricante FROM producto);

-- Actualiza el código del fabricante Lenovo y asígnale el valor 20 si no existe ya otro fabricante con ese código
UPDATE fabricante SET codigo = 20 WHERE nombre = 'Lenovo' AND codigo <> 20;

-- Actualiza el código del fabricante Huawei y asígnale el valor 30 si no existe ya otro fabricante con ese código
UPDATE fabricante SET codigo = 30 WHERE nombre = 'Huawei' AND codigo <> 30;

-- Actualiza el precio de todos los productos sumándole 5 € al precio actual
UPDATE producto SET precio = precio + 5;

-- Elimina todas las impresoras que tienen un precio menor de 200 €
DELETE FROM producto WHERE nombre LIKE '%Impresora%' AND precio < 200;
