create database ejemplo4000;
use ejemplo4000;

CREATE TABLE clientes (
    idclientes INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    ciudad VARCHAR(50),
    provincia VARCHAR(50),
    cp VARCHAR(10),
    tipo_de_cliente VARCHAR(20),
    ingresos double,
    fecha date
);


CREATE TABLE ventas (
    idclientes INT,
    idventas INT AUTO_INCREMENT PRIMARY KEY,
    idproductos INT,
    fecha_Ventas DATE,
    INDEX idx_idclientes (idclientes),
    INDEX idx_idproductos (idproductos)
);


CREATE TABLE productos (
    idproducto INT AUTO_INCREMENT PRIMARY KEY,
    idfabricante int,
    nombre_producto varchar(20),
    precio double,
    INDEX idx_idfabricante (idfabricante)
    );

CREATE TABLE fabricante (
	idfabricantes INT AUTO_INCREMENT PRIMARY KEY,
    idclientes INT,
    nombrefabricante VARCHAR (50),
    tipo_producto ENUM('Electronica','Ropa','Mueble'),
    caracteristicas SET('Segunda Mano','Calidad','Primera mano','Edicion Limitada')
    );


ALTER TABLE ventas
ADD CONSTRAINT fk_idclientes
FOREIGN KEY (idclientes)
REFERENCES clientes(idclientes);













