create database fonlan;
use fonlan;

CREATE TABLE IF NOT EXISTS cliente(
id int auto_increment primary key,
nombre varchar (50),
telefono varchar(50)
);

CREATE TABLE IF NOT EXISTS venta(
id int auto_increment primary key,
FOREIGN KEY (productoID) REFERENCES producto(id),
FOREIGN KEY (clienteID) REFERENCES cliente(id),
id_cliente int,
fecha date
);

CREATE TABLE IF NOT EXISTS producto(
id int auto_increment primary key,
FOREIGN KEY (fabricanteID) REFERENCES fabricante(id),
precio double,
nombre varchar(50)
);



CREATE TABLE IF NOT EXISTS fabricante(
id int auto_increment primary key,
nombre VARCHAR(50),
direccion VARCHAR(50),
tipo VARCHAR(50)
);



drop fonlan;




