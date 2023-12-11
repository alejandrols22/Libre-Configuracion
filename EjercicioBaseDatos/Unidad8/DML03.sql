use jardineria;

-- Inserta una nueva oficina en Almería
INSERT INTO oficina (nombre, ciudad) VALUES ('Oficina Almería', 'Almería');

-- Inserta un empleado para la oficina de Almería que sea representante de ventas
INSERT INTO empleado (nombre, cargo, id_oficina) VALUES ('Nuevo Empleado', 'Representante de Ventas', (SELECT id FROM oficina WHERE ciudad = 'Almería'));

-- Inserta un cliente que tenga como representante de ventas el empleado que hemos creado en el paso anterior.
INSERT INTO cliente (nombre, representante_venta) VALUES ('Nuevo Cliente', (SELECT id FROM empleado WHERE nombre = 'Nuevo Empleado'));

-- Inserte un pedido para el cliente que acabamos de crear, que contenga al menos dos productos.
INSERT INTO pedido (cantidad, fecha, id_cliente)
VALUES 
    (2, '2023-12-11', (SELECT id FROM cliente WHERE nombre = 'Nuevo Cliente')),
    (3, '2023-12-11', (SELECT id FROM cliente WHERE nombre = 'Nuevo Cliente'));

-- Actualiza el código del cliente que hemos creado en el paso anterior y averigua si hubo cambios en las tablas relacionadas.
UPDATE cliente SET codigo = 100 WHERE nombre = 'Nuevo Cliente';

-- Borra el cliente y averigua si hubo cambios en las tablas relacionadas.
DELETE FROM cliente WHERE nombre = 'Nuevo Cliente';

-- Elimina los clientes que no hayan realizado ningún pedido.
DELETE FROM cliente WHERE id NOT IN (SELECT DISTINCT id_cliente FROM pedido);

-- Incrementa en un 20% el precio de los productos que no tengan pedidos.
UPDATE producto SET precio = precio * 1.20 WHERE codigo_producto NOT IN (SELECT DISTINCT codigo_producto FROM detalle_pedido);

-- Borra los pagos del cliente con menor límite de crédito.
DELETE FROM pago WHERE id_cliente = (SELECT id FROM cliente ORDER BY limite_credito ASC LIMIT 1);

-- Establece a 0 el límite de crédito del cliente que menos unidades pedidas tenga del producto OR-179.
UPDATE cliente SET limite_credito = 0 WHERE id = (SELECT id_cliente FROM detalle_pedido WHERE codigo_producto = 'OR-179' ORDER BY cantidad ASC LIMIT 1);

-- Modifica la tabla detalle_pedido para incorporar un campo numérico llamado total_linea y actualiza todos sus registros para calcular su valor con la fórmula:
-- total_linea = precio_unidad * cantidad * (1 + (iva / 100));
ALTER TABLE detalle_pedido ADD COLUMN total_linea DOUBLE;
UPDATE detalle_pedido SET total_linea = precio_unidad * cantidad * (1 + (iva / 100));

-- Borra el cliente que menor límite de crédito tenga. ¿Es posible borrarlo solo con una consulta? ¿Por qué?


-- Inserta una oficina con sede en Granada y tres empleados que sean representantes de ventas.
INSERT INTO oficina (nombre, ciudad) VALUES ('Oficina Granada', 'Granada');
INSERT INTO empleado (nombre, cargo, id_oficina) VALUES ('Empleado 1', 'Representante de Ventas', (SELECT id FROM oficina WHERE ciudad = 'Granada'));
INSERT INTO empleado (nombre, cargo, id_oficina) VALUES ('Empleado 2', 'Representante de Ventas', (SELECT id FROM oficina WHERE ciudad = 'Granada'));
INSERT INTO empleado (nombre, cargo, id_oficina) VALUES ('Empleado 3', 'Representante de Ventas', (SELECT id FROM oficina WHERE ciudad = 'Granada'));

-- Inserta tres clientes que tengan como representantes de ventas los empleados que hemos creado en el paso anterior.
INSERT INTO cliente (nombre, representante_venta) VALUES ('Cliente 1', (SELECT id FROM empleado WHERE nombre = 'Empleado 1'));
INSERT INTO cliente (nombre, representante_venta) VALUES ('Cliente 2', (SELECT id FROM empleado WHERE nombre = 'Empleado 2'));
INSERT INTO cliente (nombre, representante_venta) VALUES ('Cliente 3', (SELECT id FROM empleado WHERE nombre = 'Empleado 3'));

-- Borra uno de los clientes y comprueba si hubo cambios en las tablas relacionadas. Si no hubo cambios, modifica las tablas necesarias estableciendo la clave foránea con la cláusula ON DELETE CASCADE.
DELETE FROM cliente WHERE nombre = 'Cliente 1';
