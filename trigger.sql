-- trigger --
CREATE TABLE replica_ventas AS
SELECT * FROM ventas WHERE 1=0;

-- ahora crearemos el trigger --
DELIMITER $$
CREATE TRIGGER TRIGGER2
BEFORE INSERT ON ventas
FOR EACH ROW
BEGIN
	INSERT INTO replica_ventas (id_ventas, id_clientes, id_productos, fecha_de_venta)
    VALUES (NEW.id_ventas, NEW.id_clientes, NEW.id_productos, NEW.fecha_de_venta);
END$$
DELIMITER ;

INSERT INTO ventas(id_ventas, id_clientes, id_productos, fecha_de_venta)
VALUES (7,1,2,'2023-01-01');
SELECT * FROM replica_ventas;

drop table if exists replicaClientes;
create table replicaClientes as select * from clientes where 1 = 0;
delimiter $$
drop trigger if exists trigger2;
create trigger trigger2
before insert on clientes
for each row
begin
 insert into replicaClientes (Id_CLIENTES, FECHA_DE_ALTA, CIF_NIF, NOMBRE)
    values (new.Id_CLIENTES, new.FECHA_DE_ALTA, new.CIF_NIF, new.NOMBRE)
end $$
delimiter ;

insert into clientes (Id_CLIENTES, FECHA_DE_ALTA, CIF_NIF, NOMBRE)
values (3, '2023-01-01', '02334267K', 'Agapito');
select * from replicaClientes;

DELIMITER $$
CREATE TRIGGER TRIGGER_UPDATE_VENTAS2
AFTER UPDATE ON ventas
FOR EACH ROW
BEGIN
	-- Actualizar en replica_ventas después de una actualización
    UPDATE replica_ventas
    SET id_clientes=NEW.id_clientes,
		id_productos=NEW.id_productos,
        fecha_de_venta=NEW.fecha_de_venta
	WHERE id_ventas=NEW.id_ventas;
END $$
DELIMITER ;

UPDATE ventas SET id_clientes=2 WHERE id_ventas=10;
SELECT * FROM replica_ventas;

CREATE TABLE replica_productos AS
SELECT * FROM productos WHERE 1=0;

-- ahora crearemos el trigger --
DELIMITER $$
CREATE TRIGGER TRIGGER3
BEFORE INSERT ON productos
FOR EACH ROW
BEGIN
	INSERT INTO replica_productos (id_producto, id_proveedor, nombre, fabricante)
    VALUES (NEW.id_producto, NEW.id_proveedor, NEW.nombre, NEW.fabricante);
END$$
DELIMITER ;

INSERT INTO productos(id_producto, id_proveedor, nombre, fabricante)
VALUES (21,1,'ordenador x','fabricante x');
SELECT * FROM replica_productos;


--
-- Disparadores clientes
--
DELIMITER $$
CREATE TRIGGER TRIGGER1 BEFORE INSERT ON clientes FOR EACH ROW BEGIN
    INSERT INTO clientes_copia  VALUES (NEW.id_clientes,NEW.nombre);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla clientes_copia
--

CREATE TABLE clientes_copia (
  id int(11) NOT NULL,
  nombre varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla clientes_copia
--

INSERT INTO clientes_copia (id, nombre) VALUES
(121, 'Gandalf');
--
-- Indices de la tabla clientes_copia
--
ALTER TABLE clientes_copia
  ADD PRIMARY KEY (id);
  
  DELIMITER $$
CREATE TRIGGER TRIGGER_UPDATE_CLIENTES2
AFTER UPDATE ON clientes
FOR EACH ROW
BEGIN
-- Actualizar en replica_ventas después de una actualización
UPDATE clientes_copia
SET nombre=NEW.nombre
WHERE id=NEW.id_clientes;
END $$
DELIMITER ;

UPDATE clientes SET nombre='Alberto' WHERE id_clientes=121;
SELECT * FROM clientes_copia;


DELIMITER $$
CREATE TRIGGER TRIGGER_UPDATE_PRODUCTOS2
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
	-- Actualizar en replica_ventas después de una actualización
    UPDATE replica_productos
    SET id_proveedor=NEW.id_proveedor,
		nombre=NEW.nombre,
        fabricante=NEW.fabricante
	WHERE id_producto=NEW.id_producto;
END $$
DELIMITER ;

UPDATE productos SET nombre='ordenador y' WHERE id_producto=21;
SELECT * FROM replica_productos;
