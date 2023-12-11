DROP DATABASE IF EXISTS gestion_ventas;
CREATE DATABASE gestion_ventas CHARACTER SET utf8mb4;
USE gestion_ventas;

CREATE TABLE comercial (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  ciudad VARCHAR(100),
  comision FLOAT
);

CREATE TABLE pedido (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cantidad DOUBLE NOT NULL,
  fecha DATE NOT NULL,
  id_cliente INT NOT NULL,
  id_comercial INT NOT NULL
);

CREATE TABLE cliente (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  apellido1 VARCHAR(100) NOT NULL,
  apellido2 VARCHAR(100),
  ciudad VARCHAR(100),
  categoria INT
);

-- Insertamos datos de ejemplo en la tabla 'comercial'.
INSERT INTO comercial (nombre, apellido1, apellido2, ciudad, comision) VALUES
('Daniel', 'Sáez', 'Vega', 'Madrid', 5.5),
('María', 'Santana', 'Moreno', 'Barcelona', 6.0);

-- Insertamos datos de ejemplo en la tabla 'cliente'.
INSERT INTO cliente (nombre, apellido1, apellido2, ciudad, categoria) VALUES
('Empresa A', 'Contacto', 'Uno', 'Madrid', 1),
('Empresa B', 'Contacto', 'Dos', 'Barcelona', 2);

-- Insertamos datos de ejemplo en la tabla 'pedido'.
INSERT INTO pedido (cantidad, fecha, id_cliente, id_comercial) VALUES
(500.0, '2017-05-23', 1, 1),
(750.0, '2017-08-19', 2, 2);

