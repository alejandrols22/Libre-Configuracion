use ejemplo4000;


-- Insertar datos en la tabla 'clientes'
INSERT INTO clientes (nombre, apellidos, direccion, ciudad, provincia, cp, tipo_de_cliente, ingresos, fecha)
VALUES
    ('Alberto', 'Ruiz', 'Avenida Gandalf', 'Gondor', 'Tierra media', '29003', 'empresa', 9000.50, '2023-01-15'),
    ('Laura', 'Perez', 'Calle Frodo', 'Bolso cerrado', 'La comarca', '28003', 'particular', 6000.75, '2023-02-20'),
    ('Sauron', 'Gonzalez', 'Avenida maligna', 'Mordor city', 'Mordor', '38003', 'particular',8000.75, '2023-02-20');
-- Insertar datos en la tabla 'productos'
INSERT INTO productos (idfabricante, nombre_producto, precio)
VALUES
    (1, 'Movil iPhone', 999.99),
    (2, 'Movil Honor', 499.99),
    (3, 'Movil Samsung', 799.99);




-- Insertar datos en la tabla 'ventas'
INSERT INTO ventas (idclientes, idproductos, fecha_Ventas)
VALUES
    (1, 1, '2023-01-10'),
    (2, 2, '2023-02-15'),
    (3, 3, '2023-03-20'),
    (1, 2, '2023-04-05'),
    (2, 1, '2023-05-10'),
    (3, 3, '2023-06-15');
